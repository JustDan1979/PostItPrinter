using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Drawing;

namespace JIRAInterface
{
    public class Client
    {
        string UserName { get; set; }
        string Password { get; set; }
        public Client(string _UserName, string _Password)
        {
            UserName = _UserName;
            Password = _Password;
        }

        public SearchResult JQLSearch(string JQLText)
        {
            int startAt = 0;
            string Request = "https://eshipping.jira.com/rest/api/2/search?jql=" + JQLText.Replace(" ", "%20") + "&startAt=" + startAt.ToString();
            SearchResult results = RetrieveResults(Request);
            if (results.total > results.maxResults)
            {
                while (startAt + results.maxResults <= results.total)
                {
                    startAt += 50;
                    Request = "https://eshipping.jira.com/rest/api/2/search?jql=" + JQLText.Replace(" ", "%20") + "&startAt=" + startAt.ToString();
                    results.issues.AddRange(RetrieveResults(Request).issues);
                }
            }
            return results;
        }

        public List<User> GetUsers()
        {
            string Request = "https://eshipping.jira.com/rest/api/2/user/assignable/search?issueKey=SUPPORT-2";
            try
            {
                var request = WebRequest.Create(Request) as HttpWebRequest;
                request.Headers.Add("Authorization", "Basic " + GetEncodedCredentials());
                request.ContentType = "application/json";
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    if (response.StatusCode != HttpStatusCode.OK)
                        throw new Exception(String.Format(
                        "Server error (HTTP {0}: {1}).",
                        response.StatusCode,
                        response.StatusDescription));
                    DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(List<User>));
                    var stream = response.GetResponseStream();
                    object objResponse = jsonSerializer.ReadObject(stream);
                    List<User> jsonResponse
                    = objResponse as List<User>;
                    foreach(User user in jsonResponse)
                    {
                        user.image = GetImageFromUrl(user.avatarUrls.__invalid_name__32x32);
                    }
                    return jsonResponse;
                }
            }
            catch (Exception e)
            {
                throw e;
            }


        }
        public List<Sprint> GetSprints()
        {
            string Request = "https://eshipping.jira.com/rest/greenhopper/1.0/sprintquery/11?includeHistoricSprints=false&includeFutureSprints=true";
            try
            {
                var request = WebRequest.Create(Request) as HttpWebRequest;
                request.Headers.Add("Authorization", "Basic " + GetEncodedCredentials());
                request.ContentType = "application/json";
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    if (response.StatusCode != HttpStatusCode.OK)
                        throw new Exception(String.Format(
                        "Server error (HTTP {0}: {1}).",
                        response.StatusCode,
                        response.StatusDescription));
                    DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(RapidView));
                    var stream = response.GetResponseStream();
                    object objResponse = jsonSerializer.ReadObject(stream);
                    RapidView jsonResponse
                    = objResponse as RapidView;
                    return jsonResponse.sprints;
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public List<Worklog> GetWorklogs(DateTime From, DateTime To)
        {
            List<Worklog> results = new List<Worklog>();
            string request = String.Format("https://eshipping.jira.com/rest/timesheet-gadget/1.0/raw-timesheet.json?startDate={0}&endDate={1}", From.ToString("yyyy-MM-dd"), To.ToString("yyyy-MM-dd"));
            TimeSheet sheet = GetTimeSheet(request);
            results = sheet.worklog;
            return results;
        }
        private TimeSheet GetTimeSheet(string Request)
        {
            try
            {
                var request = WebRequest.Create(Request) as HttpWebRequest;
                request.Headers.Add("Authorization", "Basic " + GetEncodedCredentials());
                request.ContentType = "application/json";
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    if (response.StatusCode != HttpStatusCode.OK)
                        throw new Exception(String.Format(
                        "Server error (HTTP {0}: {1}).",
                        response.StatusCode,
                        response.StatusDescription));
                    DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(TimeSheet));
                    var stream = response.GetResponseStream();
                    object objResponse = jsonSerializer.ReadObject(stream);
                    TimeSheet jsonResponse = objResponse as TimeSheet;
                    return jsonResponse;
                }
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        private SearchResult RetrieveResults(string Request)
        {
            try
            {
                var request = WebRequest.Create(Request) as HttpWebRequest;
                request.Headers.Add("Authorization", "Basic " + GetEncodedCredentials());
                request.ContentType = "application/json";
                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    if (response.StatusCode != HttpStatusCode.OK)
                        throw new Exception(String.Format(
                        "Server error (HTTP {0}: {1}).",
                        response.StatusCode,
                        response.StatusDescription));
                    DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(SearchResult));
                    var stream = response.GetResponseStream();
                    object objResponse = jsonSerializer.ReadObject(stream);
                    SearchResult jsonResponse
                    = objResponse as SearchResult;
                    return jsonResponse;
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Issue GetIssueByKey(string Key)
        {
            SearchResult result = RetrieveResults(String.Format("https://eshipping.jira.com/rest/api/2/search?jql=key={0}", Key));
            if (result == null)
                return null;
            if (result.issues.Count >= 1)
                return result.issues[0];
            else
                return null;
        }
        public Image GetImageFromUrl(string url)
        {
            var request = WebRequest.Create(url) as HttpWebRequest;
            request.Headers.Add("Authorization", "Basic " + GetEncodedCredentials());


            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                using (Stream stream = response.GetResponseStream())
                {
                    return Image.FromStream(stream);
                }
            }
        }
        public bool AddTime(string Key, double Minutes, DateTime Day, Guid guid)
        {
            bool Success = true;
            string DateStr = WebUtility.UrlEncode(Day.ToString("dd/MMM/yy h:mm:ss tt"));
            // string Cookie = "ondemand.signup.enabled=false; atlassian.xsrf.token=AG87-S37R-QM8W-6VWE|46b17993b45fceb47f82a567852cb7ea96de4fb3|lin; __atl_path=172.24.36.101.1403528171758769; JSESSIONID=54C144E1683475141D1B7272762FC805; studio.crowd.tokenkey=JHfKCtjdZKWK4t8mQT0oqA00; AJS.conglomerate.cookie=\"|Tempo.SHOW_TRACKER=true\"; __utma=112334352.1633908034.1403528166.1403752400.1403787979.16; __utmb=112334352.1.10.1403787979; __utmc=112334352; __utmz=112334352.1403528166.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utma=1.270546799.1403528166.1403752400.1403787979.16; __utmb=1.2.10.1403787979; __utmc=1; __utmz=1.1403528166.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)";
            string Cookie = "ondemand.signup.enabled=false; atlassian.xsrf.token=AG87-S37R-QM8W-6VWE|46b17993b45fceb47f82a567852cb7ea96de4fb3|lin; __atl_path=172.24.36.101.1403528171758769; AJS.conglomerate.cookie=\"|Tempo.SHOW_TRACKER=true\"; JSESSIONID=47EA14BDC6C85BEF9097F8BF6336851F; studio.crowd.tokenkey=JHfKCtjdZKWK4t8mQT0oqA00; __utma=112334352.1633908034.1403528166.1403878476.1403900970.21; __utmb=112334352.1.10.1403900970; __utmc=112334352; __utmz=112334352.1403528166.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utma=1.270546799.1403528166.1403878476.1403900970.21; __utmb=1.2.10.1403900970; __utmc=1; __utmz=1.1403528166.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)";
            string Comment = guid.ToString();

            string PostData = String.Format("user={0}&id=&type=&selected-panel=0&startTimeEnabled=false&tracker=false&planning=false&issue={1}&date={2}&enddate={3}&time={4}&remainingEstimate=0h&comment={5}", UserName, Key, DateStr, DateStr, Minutes.ToString());
            var request = HttpWebRequest.Create("https://eshipping.jira.com/rest/tempo-rest/1.0/worklogs/" + Key);
            request.Method = "POST";
            request.Headers.Add("Cookie", Cookie);
            request.Headers.Add("Origin", "https://eshipping.jira.com");
            request.Headers.Add("X-Requested-With", "XMLHttpRequest");
            request.ContentType = "application/x-www-form-urlencoded; charset=UTF-8";
            byte[] byteArray = Encoding.UTF8.GetBytes(PostData);

            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            //request.Headers.Add("Referer", "https://eshipping.jira.com/secure/TempoUserBoard!timesheet.jspa");
            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                using (TextReader reader = new StreamReader(response.GetResponseStream()) as TextReader)
                {
                    string resp = reader.ReadToEnd();
                    if (resp.Contains("<submit-result valid=\"false\">"))
                        Success = false;
                }
            }
            return Success;
        }

        private string GetEncodedCredentials()
        {
            string mergedCredentials = string.Format("{0}:{1}", UserName, Password);
            byte[] byteCredentials = UTF8Encoding.UTF8.GetBytes(mergedCredentials);
            return Convert.ToBase64String(byteCredentials);
        }
    }
}
