using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Drawing
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private async void button1_ClickAsync(object sender, EventArgs e)
        {
            var graphics = this.pictureBox1.CreateGraphics();
            graphics.Clear(Color.AntiqueWhite);
            await DrawCardAsync("TEAM-1💩", "As a dev team, I want like so many post its! - No, like seriously just so many post its! - So that post it notes can be hung up and do post it note things.", DateTime.Now, DateTime.Now.AddDays(10));
        }

        private async Task DrawCardAsync(string Title, string Description, DateTime started, DateTime due)
        {
            if (due.DayOfWeek == DayOfWeek.Sunday)
            {
                due = due.AddDays(1);
            }

            if (due.DayOfWeek == DayOfWeek.Saturday)
            {
                due = due.AddDays(-1);
            }

            var segments = new List<Segment>();
            segments.AddRange(DrawText(Title, 20F, new Rectangle(10, 20, 280, 30)));
            segments.AddRange(DrawText(Description, 15F, new Rectangle(10, 50, 280, 250)));

            for (int y = 200; y <= 280; y += 20)
            {
                segments.Add(new Segment(new Point(25, y), new Point(275, y)));
            }

            for (int x = 25; x <= 275; x += 50)
            {
                segments.Add(new Segment(new Point(x, 200), new Point(x, 280)));
            }

            DateTime calendarStart = started.AddDays(-1 * ((int)started.DayOfWeek + 1));
            for(int i = 0; i < 28; i++)
            {
                var day = calendarStart.AddDays(i);
                if (day.DayOfWeek != DayOfWeek.Saturday && day.DayOfWeek != DayOfWeek.Sunday)
                {
                    var x = 60 + ((int)day.DayOfWeek - 1) * 50;
                    var y = (int)(i / 7) * 20 + 201;
                    segments.AddRange(DrawText(calendarStart.AddDays(i).Day.ToString(), 8F, new Rectangle(x, y, 20, 20)));
                    if (day.Date == started.Date)
                    {
                        segments.AddRange(DrawText("S", 20F, new Rectangle(x - 20, y, 20, 20)));
                    }
                    if (day.Date == due.Date)
                    {
                        segments.AddRange(DrawText("D", 20F, new Rectangle(x - 20, y, 20, 20)));
                    }
                }
            }


            await RenderPointsAsync(segments);
        }

        private async Task RenderPointsAsync(List<Segment> segments)
        {
            int step = 0;
            var graphics = this.pictureBox1.CreateGraphics();
            graphics.ScaleTransform(2F, 2F);

            Segment previousChunk = new Segment(new Point(0, 0), new Point(0, 0));
            foreach (var segment in segments)
            {
                foreach (var chunk in GetChunks(segment))
                {
                    if (chunk.Origin.X != previousChunk.Destination.X && chunk.Destination.Y != previousChunk.Destination.Y)
                    {
                        await Task.Delay(100);
                        foreach (var movement in GetChunks(new Segment(previousChunk.Destination, chunk.Origin)))
                        {
                            graphics.DrawLine(Pens.LightGreen, movement.Origin, movement.Destination);
                            if (++step % 2 == 0)
                            {
                                await Task.Delay(1);
                            }
                        }
                        await Task.Delay(100);
                    }

                    graphics.DrawLine(Pens.Black, chunk.Origin, chunk.Destination);
                    if (++step % 2 == 0)
                    {
                        await Task.Delay(1);
                    }
                    previousChunk = chunk;
                }
            }
        }

        private IEnumerable<Segment> DrawText(string text, float emSize, Rectangle rectangle)
        {
            using (Graphics g = this.pictureBox1.CreateGraphics())
            using (Font font = new System.Drawing.Font("1CamBam_Stick_9", emSize, FontStyle.Bold))
            //using (Font font = new System.Drawing.Font("Body Font", emSize, FontStyle.Bold))
            //using (Font font = new System.Drawing.Font("times new roman", emSize, FontStyle.Bold))
            using (GraphicsPath gp = new GraphicsPath())
            using (StringFormat sf = new StringFormat())
            {
                gp.AddString(text, font.FontFamily, (int)font.Style, font.Size, rectangle, sf);

                PointF previous = PointF.Empty;
                PointF origin = PointF.Empty;
                gp.Flatten(new Matrix(), 0.05f);  // <<== *

                for (int i = 0; i < gp.PathPoints.Count(); i++)
                {
                    var pathType = gp.PathTypes[i];
                    switch (pathType)
                    {
                        case 0:
                        //case 131:
                            previous = gp.PathPoints[i];
                            origin = gp.PathPoints[i];
                            break;
                        case 1:
                            yield return new Segment(previous, gp.PathPoints[i]);
                            previous = gp.PathPoints[i];
                            break;
                        case 3:
                            if (i > 2 && gp.PathTypes[i] == 3 && gp.PathTypes[i - 1] == 3 && gp.PathTypes[i - 2] == 3)
                            {
                                foreach (var segment in Bezier(previous, gp.PathPoints[i - 2], gp.PathPoints[i - 1], gp.PathPoints[i]))
                                {
                                    yield return segment;
                                }

                            }
                            break;
                        //case 128:
                        case 163:
                            yield return new Segment(gp.PathPoints[i], origin);
                            break;
                        default:
                            yield return new Segment(previous, gp.PathPoints[i]);
                            previous = gp.PathPoints[i];
                            //origin = gp.PathPoints[i];
                            break;
                    }
                }
            }
        }

        private IEnumerable<Segment> GetChunks(Segment segment)
        {
            var dx = segment.Destination.X - segment.Origin.X;
            var dy = segment.Destination.Y - segment.Origin.Y;
            var distance = (int)(Math.Sqrt(dx * dx + dy * dy));
            var xStep = (dx / distance);
            var yStep = (dy / distance);
            
            Point previous = new Point((int)segment.Origin.X, (int)segment.Origin.Y);
            Segment lastSegment = null;

            for (int i = 0; i < distance; i++)
            {
                Point current = new Point(
                    (int)(segment.Origin.X + i * xStep),
                    (int)(segment.Origin.Y + i * yStep)
                );

                if (lastSegment != null)
                {
                    if (previous.X == current.X && previous.Y == current.Y)
                    {
                        continue;
                    }
                }

                yield return new Segment(previous, current);
                previous = current;
            }
            yield return new Segment(previous, new Point((int)segment.Destination.X, (int)segment.Destination.Y));
        }

        private IEnumerable<Segment> Bezier(PointF P1, PointF P2, PointF P3, PointF P4)
        {
            //https://javascript.info/bezier-curve
            //P = (1−t)3P1 + 3(1−t)2tP2 +3(1−t)t2P3 + t3P4

            PointF previous = P1;
            for (var t = 0F; t <= 1F; t += .1F)
            {
                PointF current = new PointF(
                    (1F - t) * 3F * P1.X + 3F * (1F - t) * 2F * P2.X + 3F * (1F - t) * t * 2F * P3.X + t * 3F * P4.X,
                    (1F - t) * 3F * P1.Y + 3F * (1F - t) * 2F * P2.Y + 3F * (1F - t) * t * 2F * P3.Y + t * 3F * P4.Y);
                yield return new Segment(previous, current);
                previous = current;
            }
            yield return new Segment(previous, P4);
        }
    }
}
