using JIRAInterface;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PostItPrinter
{
    public partial class Form1 : Form
    {
        SerialPort sp = new SerialPort("COM6", 9600);
        JIRAInterface.Client JIRAClient = new JIRAInterface.Client("dleach", "redacted");
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            var sprints = JIRAClient.GetSprints();
            foreach (var sprint in sprints)
                comboBox1.Items.Add(sprint);
            pictureBox1.Image = new Bitmap(96 * 3, 96 * 3);

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            flowLayoutPanel1.Height = 96 * 3 + 10;
            flowLayoutPanel1.Width = this.Width;
            flowLayoutPanel1.Controls.Clear();

            var sprint = comboBox1.SelectedItem as Sprint;
            var results = JIRAClient.JQLSearch("sprint+=+" + sprint.id + "+AND+issuetype+!=+Epic").issues;
            foreach (var issue in results)
            {
                Bitmap b = GetIssueBMP(issue);
                // pictureBox1.Image = b;
                PrintBMP(b);
                PictureBox a = new PictureBox();

                a.Height = 96 * 3;
                a.Width = 96 * 3;
                a.Image = b;



                Panel p = new Panel();
                p.Height = a.Height;
                p.Width = b.Width;

                CheckBox chk = new CheckBox();
                chk.Width = 10;
                chk.Height = 10;
                chk.Checked = true;

                p.Controls.Add(chk);
                p.Controls.Add(a);
                chk.BringToFront();

                p.Tag = chk;
                a.Tag = chk;

                p.Click += p_Click;
                a.Click += p_Click;


                flowLayoutPanel1.Controls.Add(p);
                return;
            }
        }

        void p_Click(object sender, EventArgs e)
        {
            Control c = sender as Control;
            CheckBox chk = c.Tag as CheckBox;
            chk.Checked = !chk.Checked;
        }


        private Bitmap GetIssueBMP(Issue issue)
        {
            Bitmap bmp = new Bitmap(96 * 3, 96 * 3);
            Graphics g = Graphics.FromImage(bmp);
            g.FillRectangle(Brushes.LightYellow, new Rectangle(0, 0, 96 * 3, 96 * 3));
            //            g.DrawRectangle(Pens.Black, new Rectangle(3, 3, 96 * 3 - 6, 96 * 3 - 6));
            g.DrawString(issue.key, new Font(FontFamily.GenericSerif, 14f, FontStyle.Bold), Brushes.Black, new RectangleF(5, 5, 96 * 3 - 10, 18));
            g.DrawLine(Pens.Black, new Point(5, 25), new Point(96 * 3 - 10, 25));
            g.DrawString(issue.fields.summary, new Font(FontFamily.GenericSerif, 14f, FontStyle.Regular), Brushes.Black, new RectangleF(5, 27, 96 * 3 - 10, 96 * 3 - 20 - 5));
            g.Flush();
            return bmp;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            foreach (Panel p in flowLayoutPanel1.Controls)
            {
                foreach (Control ctl in p.Controls)
                {
                    if (ctl is PictureBox)
                    {
                        PictureBox pb = ctl as PictureBox;
                        Bitmap bmp = (Bitmap)pb.Image;
                        PrintBMP(bmp);
                    }
                    return; //don't iterate through rest
                }
            }
        }
        public static byte[] ImageToByte(Image img)
        {
            ImageConverter converter = new ImageConverter();
            return (byte[])converter.ConvertTo(img, typeof(byte[]));
        }
        private void PrintBMP(Bitmap bmp)
        {
            Color yellow = Color.FromArgb(255, 255, 224);
            for (int rowOffset = 0; rowOffset < bmp.Height; rowOffset += 8)
            {
                byte[] row = new byte[96 * 3];
                BitArray bitArray = new BitArray(row);
                for (int x = 0; x < 96 * 3; x++)
                {

                    for (int i = rowOffset; i < rowOffset + 7; i++)
                    {
                        Color a = bmp.GetPixel(x, i);

                        if (a != yellow)
                            bitArray.Set((i - rowOffset) + x * 8, true);
                        else
                            bitArray.Set((i - rowOffset) + x * 8, false);
                    }
                }
                bitArray.CopyTo(row, 0);
                PrintRow(row);
            }
           
        }
        Queue<byte[]> PendingLines = new Queue<byte[]>();
        int lines = 0;
        private void PrintRow(byte[] row)
        {
            PendingLines.Enqueue(row);
            if (!sp.IsOpen)
            {
                //sp.DtrEnable = true;
                sp.Open();
                sp.DataReceived += sp_DataReceived;
            }
            Bitmap bmp = new Bitmap(pictureBox1.Image);

            Graphics g = Graphics.FromImage(bmp);
            for (int x = 0; x < 96 * 3; x++)
            {
                byte line = row[x];
                for (int y = 0; y < 8; y++)
                {
                    var bit = (line & (1 << y - 1)) != 0;
                    if (bit)
                    {
                        g.DrawLine(Pens.Green, new Point(x, y + lines), new Point(x, y + 0 + lines));
                    }
                    else
                    {
                        g.DrawLine(Pens.Black, new Point(x, y + lines), new Point(x, y + 0 + lines));
                    }
                }
            }
            pictureBox1.Image = bmp;

            lines += 8;
        }

        void sp_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            SerialPort sp = (SerialPort)sender;
            string msg = sp.ReadLine();
            if (msg.Contains("Init") || msg.Contains("ready"))
            {
                if (PendingLines.Any())
                {
                    byte[] row = PendingLines.Dequeue();
                    sp.Write(row, 0, 150);

                }
            }
        }

    }
}
