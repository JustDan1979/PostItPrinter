namespace Drawing
{
    using System.Drawing;

    public class Segment
    {
        public PointF Origin { get; set; }
        
        public PointF Destination { get; set; }

        public Segment(Point a, Point b)
        {
            Origin = a;
            Destination = b;
        }

        public Segment(PointF a, PointF b)
        {
            Origin = a;
            Destination = b;
        }
    }
}
