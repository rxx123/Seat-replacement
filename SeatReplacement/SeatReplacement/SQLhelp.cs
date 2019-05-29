using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeatReplacement
{
    public  class SQLhelp
    {
        public static DataTable GetInfo(TicketGet ticketGet)
        {
            string connectionString = ConfigurationManager.AppSettings["SeatReplacement"];
            SqlConnection con = new SqlConnection(connectionString);
            DataSet ds = new DataSet();
            string sql = "select * from DJ60_change_seat_log where train_date='"
                         + ticketGet.trainDate + "' and train_code='"
                         + ticketGet.trainCodeAt + "' and coach_no='"
                         + ticketGet.coachNo.Replace('车', ' ') + "' and seat_no='"
                         + ticketGet.seatNo + "' and seat_type_name='"
                         + ticketGet.seatType + "'";
            try
            {
                con.Open();
                SqlDataAdapter adp = new SqlDataAdapter(sql, con);
                adp.Fill(ds);
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                con.Close();
            }
            return  ds.Tables[0];
        }
    }
}
