using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JIRAInterface
{
    public class Entry
    {
        public string comment { get; set; }
        public int timeSpent { get; set; }
        public string author { get; set; }
        public string authorFullName { get; set; }
        public object created { get; set; }
        public object startDate { get; set; }
        public string updateAuthor { get; set; }
        public string updateAuthorFullName { get; set; }
        public object updated { get; set; }
    }

    public class Worklog
    {
        public string key { get; set; }
        public string summary { get; set; }
        public List<Entry> entries { get; set; }
    }
    public class TimeSheet
    {
        public List<Worklog> worklog { get; set; }
        public long startDate { get; set; }
        public long endDate { get; set; }
    }
}
