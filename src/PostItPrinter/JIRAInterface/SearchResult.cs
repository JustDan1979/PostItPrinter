using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;

namespace JIRAInterface
{
    [DataContract]
    public class Progress
    {
        [DataMember(Name = "progress")]
        public int? progress { get; set; }
        [DataMember(Name = "total")]
        public int? total { get; set; }
        [DataMember(Name = "percent")]
        public int? percent { get; set; }
    }

    [DataContract]
    public class Issuetype
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "id")]
        public string id { get; set; }
        [DataMember(Name = "description")]
        public string description { get; set; }
        [DataMember(Name = "iconUrl")]
        public string iconUrl { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
        [DataMember(Name = "subtask")]
        public bool? subtask { get; set; }
    }

    [DataContract]
    public class AvatarUrls
    {
        [DataMember(Name = "16x16")]
        public string __invalid_name__16x16 { get; set; }
        [DataMember(Name = "24x24")]
        public string __invalid_name__24x24 { get; set; }
        [DataMember(Name = "32x32")]
        public string __invalid_name__32x32 { get; set; }
        [DataMember(Name = "48x48")]
        public string __invalid_name__48x48 { get; set; }
    }

    [DataContract]
    public class Reporter
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
        [DataMember(Name = "emailAddress")]
        public string emailAddress { get; set; }
        [DataMember(Name = "avatarUrls")]
        public AvatarUrls avatarUrls { get; set; }
        [DataMember(Name = "displayName")]
        public string displayName { get; set; }
        [DataMember(Name = "active")]
        public bool? active { get; set; }
    }

    [DataContract]
    public class Priority
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "iconUrl")]
        public string iconUrl { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
        [DataMember(Name = "id")]
        public string id { get; set; }
    }

    [DataContract]
    public class StatusCategory
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "id")]
        public int? id { get; set; }
        [DataMember(Name = "key")]
        public string key { get; set; }
        [DataMember(Name = "colorName")]
        public string colorName { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
    }

    [DataContract]
    public class Status
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "description")]
        public string description { get; set; }
        [DataMember(Name = "iconUrl")]
        public string iconUrl { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
        [DataMember(Name = "id")]
        public string id { get; set; }
        [DataMember(Name = "statusCategory")]
        public StatusCategory statusCategory { get; set; }
    }

    [DataContract]
    public class AvatarUrls2
    {
        [DataMember(Name = "16x16")]
        public string __invalid_name__16x16 { get; set; }
        [DataMember(Name = "24x24")]
        public string __invalid_name__24x24 { get; set; }
        [DataMember(Name = "32x32")]
        public string __invalid_name__32x32 { get; set; }
        [DataMember(Name = "48x48")]
        public string __invalid_name__48x48 { get; set; }
    }

    [DataContract]
    public class Project
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "id")]
        public string id { get; set; }
        [DataMember(Name = "key")]
        public string key { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
        [DataMember(Name = "avatarUrls")]
        public AvatarUrls2 avatarUrls { get; set; }
    }

    [DataContract]
    public class Customfield12110
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "value")]
        public string value { get; set; }
        [DataMember(Name = "id")]
        public string id { get; set; }
    }

    [DataContract]
    public class Aggregateprogress
    {
        [DataMember(Name = "progress")]
        public int? progress { get; set; }
        [DataMember(Name = "total")]
        public int? total { get; set; }
        [DataMember(Name = "percent")]
        public int? percent { get; set; }
    }

    [DataContract]
    public class Votes
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "votes")]
        public int? votes { get; set; }
        [DataMember(Name = "hasVoted")]
        public bool? hasVoted { get; set; }
    }

    [DataContract]
    public class AvatarUrls3
    {
        [DataMember(Name = "16x16")]
        public string __invalid_name__16x16 { get; set; }
        [DataMember(Name = "24x24")]
        public string __invalid_name__24x24 { get; set; }
        [DataMember(Name = "32x32")]
        public string __invalid_name__32x32 { get; set; }
        [DataMember(Name = "48x48")]
        public string __invalid_name__48x48 { get; set; }
    }

    [DataContract]
    public class Creator
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
        [DataMember(Name = "emailAddress")]
        public string emailAddress { get; set; }
        [DataMember(Name = "avatarUrls")]
        public AvatarUrls3 avatarUrls { get; set; }
        [DataMember(Name = "displayName")]
        public string displayName { get; set; }
        [DataMember(Name = "active")]
        public bool active { get; set; }
    }

    [DataContract]
    public class Watches
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "watchCount")]
        public int? watchCount { get; set; }
        [DataMember(Name = "isWatching")]
        public bool isWatching { get; set; }
    }

    [DataContract]
    public class AvatarUrls4
    {
        [DataMember(Name = "16x16")]
        public string __invalid_name__16x16 { get; set; }
        [DataMember(Name = "24x24")]
        public string __invalid_name__24x24 { get; set; }
        [DataMember(Name = "32x32")]
        public string __invalid_name__32x32 { get; set; }
        [DataMember(Name = "48x48")]
        public string __invalid_name__48x48 { get; set; }
    }

    [DataContract]
    public class Assignee
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "name")]
        public string name { get; set; }
        [DataMember(Name = "emailaddress")]
        public string emailAddress { get; set; }
        [DataMember(Name = "avatarUrls")]
        public AvatarUrls4 avatarUrls { get; set; }
        [DataMember(Name = "displayName")]
        public string displayName { get; set; }
        [DataMember(Name = "active")]
        public bool active { get; set; }
    }

    [DataContract]
    public class Customfield12410
    {
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "value")]
        public string value { get; set; }
        [DataMember(Name = "id")]
        public string id { get; set; }
    }
    [DataContract]
    public class Fields
    {
        [DataMember(Name = "progress")]
        public Progress progress { get; set; }
        [DataMember(Name = "summary")]
        public string summary { get; set; }
        [DataMember(Name = "issuetype")]
        public Issuetype issuetype { get; set; }
        [DataMember(Name = "customfield_10610")]
        public object customfield_10610 { get; set; }
        [DataMember(Name = "customfield_12210")]
        public object customfield_12210 { get; set; }
        [DataMember(Name = "customfield_12310")]
        public object customfield_12310 { get; set; }
        [DataMember(Name = "timespent")]
        public int? timespent { get; set; }
        [DataMember(Name = "customfield_11710")]
        public object customfield_11710 { get; set; }
        [DataMember(Name = "reporter")]
        public Reporter reporter { get; set; }
        [DataMember(Name = "updated")]
        public string updated { get; set; }
        [DataMember(Name = "created")]
        public string created { get; set; }
        [DataMember(Name = "priority")]
        public Priority priority { get; set; }
        [DataMember(Name = "description")]
        public object description { get; set; }
        [DataMember(Name = "customfield_10710")]
        public object customfield_10710 { get; set; }
        [DataMember(Name = "customfield_10812")]
        public object customfield_10812 { get; set; }
        [DataMember(Name = "customfield_10002")]
        public object customfield_10002 { get; set; }
        [DataMember(Name = "customfield_10813")]
        public object customfield_10813 { get; set; }
        [DataMember(Name = "customfield_10814")]
        public object customfield_10814 { get; set; }
        [DataMember(Name = "issuelinks")]
        public List<object> issuelinks { get; set; }
        [DataMember(Name = "customfield_10815")]
        public object customfield_10815 { get; set; }
        [DataMember(Name = "customfield_10711")]
        public object customfield_10711 { get; set; }
        [DataMember(Name = "customfield_12710")]
        public string customfield_12710 { get; set; }
        [DataMember(Name = "customfield_10810")]
        public object customfield_10810 { get; set; }
        [DataMember(Name = "customfield_10000")]
        public object customfield_10000 { get; set; }
        [DataMember(Name = "customfield_10811")]
        public object customfield_10811 { get; set; }
        [DataMember(Name = "customfield_11210")]
        public object customfield_11210 { get; set; }
        [DataMember(Name = "subtasks")]
        public List<object> subtasks { get; set; }
        [DataMember(Name = "customfield_11610")]
        public object customfield_11610 { get; set; }
        [DataMember(Name = "status")]
        public Status status { get; set; }
        [DataMember(Name = "customfield_11211")]
        public string customfield_11211 { get; set; }
        [DataMember(Name = "labels")]
        public List<object> labels { get; set; }
        [DataMember(Name = "workratio")]
        public long? workratio { get; set; }
        [DataMember(Name = "project")]
        public Project project { get; set; }
        [DataMember(Name = "customfield_12110")]
        public Customfield12110 customfield_12110 { get; set; }
        [DataMember(Name = "environment")]
        public object environment { get; set; }
        [DataMember(Name = "customfield_11910")]
        public object customfield_11910 { get; set; }
        [DataMember(Name = "customfield_10014")]
        public object customfield_10014 { get; set; }
        [DataMember(Name = "aggregateprogress")]
        public Aggregateprogress aggregateprogress { get; set; }
        [DataMember(Name = "lastViewed")]
        public string lastViewed { get; set; }
        [DataMember(Name = "customfield_10015")]
        public object customfield_10015 { get; set; }
        [DataMember(Name = "components")]
        public List<object> components { get; set; }
        [DataMember(Name = "customfield_10013")]
        public object customfield_10013 { get; set; }
        [DataMember(Name = "customfield_11411")]
        public object customfield_11411 { get; set; }
        [DataMember(Name = "customfield_10010")]
        public object customfield_10010 { get; set; }
        [DataMember(Name = "timeoriginalestimate")]
        public object timeoriginalestimate { get; set; }
        [DataMember(Name = "customfield_12011")]
        public object customfield_12011 { get; set; }
        [DataMember(Name = "customfield_10011")]
        public object customfield_10011 { get; set; }
        [DataMember(Name = "customfield_11410")]
        public string customfield_11410 { get; set; }
        [DataMember(Name = "votes")]
        public Votes votes { get; set; }
        [DataMember(Name = "fixVersions")]
        public List<object> fixVersions { get; set; }
        [DataMember(Name = "resolution")]
        public object resolution { get; set; }
        [DataMember(Name = "resolutiondate")]
        public object resolutiondate { get; set; }
        [DataMember(Name = "customfield_10210")]
        public string customfield_10210 { get; set; }
        [DataMember(Name = "creator")]
        public Creator creator { get; set; }
        [DataMember(Name = "aggregatetimeoriginalestimate")]
        public object aggregatetimeoriginalestimate { get; set; }
        [DataMember(Name = "duedate")]
        public object duedate { get; set; }
        [DataMember(Name = "customfield_10311")]
        public object customfield_10311 { get; set; }
        [DataMember(Name = "customfield_11310")]
        public object customfield_11310 { get; set; }
        [DataMember(Name = "watches")]
        public Watches watches { get; set; }
        [DataMember(Name = "assignee")]
        public Assignee assignee { get; set; }
        [DataMember(Name = "customfield_12810")]
        public object customfield_12810 { get; set; }
        [DataMember(Name = "customfield_12510")]
        public object customfield_12510 { get; set; }
        [DataMember(Name = "customfield_12610")]
        public object customfield_12610 { get; set; }
        [DataMember(Name = "aggregatetimeestimate")]
        public int? aggregatetimeestimate { get; set; }
        [DataMember(Name = "versions")]
        public List<object> versions { get; set; }
        [DataMember(Name = "customfield_10510")]
        public string customfield_10510 { get; set; }
        [DataMember(Name = "customfield_12411")]
        public object customfield_12411 { get; set; }
        [DataMember(Name = "timeestimate")]
        public int? timeestimate { get; set; }
        [DataMember(Name = "customfield_12410")]
        public Customfield12410 customfield_12410 { get; set; }
        [DataMember(Name = "aggregatetimespent")]
        public int? aggregatetimespent { get; set; }
    }

    [DataContract]
    public class Issue
    {
        [DataMember(Name = "expand")]
        public string expand { get; set; }
        [DataMember(Name = "id")]
        public string id { get; set; }
        [DataMember(Name = "self")]
        public string self { get; set; }
        [DataMember(Name = "key")]
        public string key { get; set; }
        [DataMember(Name = "fields")]
        public Fields fields { get; set; }
        public override string ToString()
        {
            if (fields != null && fields.summary != null)
                return key + " " + fields.summary;
            else
                return key;
        }
    }
    [DataContract]
    public class SearchResult
    {
        [DataMember(Name = "expand")]

        public string expand { get; set; }
        [DataMember(Name = "startAt")]
        public int startAt { get; set; }
        [DataMember(Name = "maxResults")]
        public int maxResults { get; set; }
        [DataMember(Name = "total")]
        public int total { get; set; }
        [DataMember(Name = "issues")]
        public List<Issue> issues { get; set; }
    }
}
