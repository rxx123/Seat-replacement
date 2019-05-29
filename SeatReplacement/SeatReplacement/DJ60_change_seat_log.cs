using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeatReplacement
{
    public class TicketGet
    {
        public string trainDate { get; set; }// 始发日期
        public string trainCodeAt { get; set; }// 车次
        public string coachNo { get; set; }// 车厢号
        public string seatNo { get; set; }// 席位号
        public string seatType { get; set; }// 席位类型名
    }
    public class DJ60_change_seat_log
    {
        public string train_date { get; set; }// 始发日期
        public string train_no { get; set; }// 全车次
        public string train_code { get; set; }// 车次
        public string start_station_name { get; set; }// 始发站名
        public string end_station_name { get; set; }// 终到站名
        public string coach_no { get; set; }// 车厢号
        public string seat_no { get; set; }// 席位号
        public string coach_level_name { get; set; }// 车厢等级名
        public string seat_no_name { get; set; }//席位号名
        public string bed_level_name { get; set; }//
        public string limit_station { get; set; }// 限到站
        public string limit_station_name { get; set; }//限到站名
        public string special_id { get; set; }//
        public string start_date { get; set; }// 开车日期
        public string seat_type_code { get; set; }// 席位类型码
        public string seat_type_name { get; set; }// 席位类型名
        public string board_station { get; set; }//乘车站站序
        public string board_station_name { get; set; }// 乘车站名
        public string arrive_station { get; set; }// 到达站站序
        public string arrive_station_name { get; set; }// 到达站名
        public string use_state { get; set; }//
        public string new_train_date { get; set; }// 新车始发日期
        public string new_train_no { get; set; }// 新全车次
        public string new_train_code { get; set; }//新车次
        public string new_start_station_name { get; set; }// 新始发站名
        public string new_end_station_name { get; set; }// 新终到站名
        public string new_coach_no { get; set; }// 新车厢号
        public string new_seat_no { get; set; }// 新席位号
        public string new_coach_level_name { get; set; }// 新车厢等级名
        public string new_seat_no_name { get; set; }// 新席位号名
        public string new_bed_level_name { get; set; }//
        public string new_limit_station { get; set; }// 新限到站
        public string new_limit_station_name { get; set; }// 新限到站名
        public string new_special_id { get; set; }//
        public string new_start_date { get; set; }//新开车日期
        public string new_seat_type { get; set; }//新席位类型码
        public string new_seat_type_name { get; set; }// 新席位类型名
        public string reuse_seat_flag { get; set; }//
        public string change_start_date { get; set; }//
        public string change_train_no { get; set; }//
        public string change_purpose_code { get; set; }//
        public int change_range { get; set; }//
        public string change_seat_type { get; set; }//
        public string change_coach_no { get; set; }//
        public string change_purpose { get; set; }//
        public string reuse_purpose { get; set; }//
        public string change_flag { get; set; }//
        public string coach_flag { get; set; }//
        public string use_state_flag { get; set; }//
        public string reuse_flag { get; set; }//
        public string success_change_flag { get; set; }//
        public string new_location_code { get; set; }//
        public string demand_id { get; set; }//
        public string operater_no { get; set; }//
        public int window_no { get; set; }//
        public string inner_code { get; set; }//
        public DateTime operate_time { get; set; }//
        public DateTime reuse_time { get; set; }//
        public string reuse_info { get; set; }
        public string purpose_code { get; set; }
        public int ticket_type { get; set; }//
        public string pass_flag { get; set; }
    }
}
