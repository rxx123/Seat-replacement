using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeatReplacement
{
    public class TicketInfo
    {
        /// <summary>
        /// 
        /// </summary>
        public int status { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public Ticket ticket { get; set; }
    }

    

    public class Ticket
    {
        /// <summary>
        /// 二代居民身份证
        /// </summary>
        public string paperType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string paperId { get; set; }
        /// <summary>
        /// 黄山北
        /// </summary>
        public string stationToCode { get; set; }
        /// <summary>
        /// 二等座
        /// </summary>
        public string seatType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string departTime { get; set; }
        /// <summary>
        /// 茹星星
        /// </summary>
        public string lvName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ticketNo { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string relayStation { get; set; }
        /// <summary>
        /// 绩溪北
        /// </summary>
        public string stationFromCode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string seatNo { get; set; }
        /// <summary>
        /// 06车
        /// </summary>
        public string coachNo { get; set; }
        /// <summary>
        /// 全
        /// </summary>
        public string ticketType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string trainCodeAt { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string trainDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int ticketPrice { get; set; }
    }

    
}