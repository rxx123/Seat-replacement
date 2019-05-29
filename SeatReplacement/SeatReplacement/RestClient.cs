using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace SeatReplacement
{
    public class RestClient
    {
        public static string HttpPost(string url, string body)
        {
            try
            {
                //ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
                Encoding encoding = Encoding.GetEncoding("GB2312");
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(new Uri(url));
                request.Method = "post";
                request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8";
                request.ContentType = "application/x-www-form-urlencoded";
                request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36";
                string paraUrlCoded = System.Web.HttpUtility.UrlEncode("str");
                paraUrlCoded += "=" + System.Web.HttpUtility.UrlEncode(body);
                byte[] buffer = encoding.GetBytes(paraUrlCoded);
                request.ContentLength = buffer.Length;
                request.GetRequestStream().Write(buffer, 0, buffer.Length);
                request.GetRequestStream().Close();//关闭请求流
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                using (StreamReader reader = new StreamReader(response.GetResponseStream(), encoding))
                {
                    return reader.ReadToEnd();
                }
            }
            catch (WebException ex)
            {
                var res = (HttpWebResponse)ex.Response;
                StringBuilder sb = new StringBuilder();
                StreamReader sr = new StreamReader(res.GetResponseStream(), Encoding.UTF8);
                sb.Append(sr.ReadToEnd());
                //string ssb = sb.ToString();
                throw new Exception(sb.ToString());
            }
        }

        /// <summary>  
        /// GET Method  
        /// </summary>  
        /// <returns></returns>  
        public static string HttpGet(string url)
        {
            HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create(url);
            myRequest.Method = "GET";

            HttpWebResponse myResponse = null;
            try
            {
                myResponse = (HttpWebResponse)myRequest.GetResponse();
                StreamReader reader = new StreamReader(myResponse.GetResponseStream(), Encoding.UTF8);
                string content = reader.ReadToEnd();
                return content;
            }
            //异常请求  
            catch (WebException e)
            {
                myResponse = (HttpWebResponse)e.Response;
                using (Stream errData = myResponse.GetResponseStream())
                {
                    using (StreamReader reader = new StreamReader(errData))
                    {
                        string text = reader.ReadToEnd();

                        return text;
                    }
                }
            }
        }
    }
    
}
