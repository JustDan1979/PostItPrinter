using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JIRAInterface
{
    public class Sprint
    {
        public int id { get; set; }
        public string name { get; set; }
        public string state { get; set; }
        public int linkedPagesCount { get; set; }
        public override string ToString()
        {
            return name + " " + state;
        }
    }

    public class RapidView
    {
        public List<Sprint> sprints { get; set; }
        public int rapidViewId { get; set; }
    }
}
