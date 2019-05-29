using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing.Printing;
using System.IO;
using System.Net;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Threading;

namespace SeatReplacement
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        #region 变量
        Stream streamToPrint;
        string address = "";//打印txt存放地址
        string addressSave = "";//保存txt存放地址
        string streamType = "txt";
        IniFile infile = new IniFile(AppDomain.CurrentDomain.BaseDirectory + @"\Config.INI");
        private DispatcherTimer ShowTimer;
        System.Timers.Timer tIdentity;
        System.Timers.Timer tTicket;
        #endregion
        public MainWindow()
        {
            InitializeComponent();
            //address = infile.ReadValue("CONFIG", "ADDRESS");
            //addressSave = infile.ReadValue("CONFIG", "ADDRESSSave");
            //string a = "020569780311932141656018027901188600178574445818676009179083681404611325017558988810910223024416059959220427736603679376380069730519525691492099";
            //var qrUrl = ConfigurationManager.AppSettings["QRURL"];
            //string res = RestClient.HttpPost(qrUrl, a);
            //TicketInfo ticketInfo = JsonConvert.DeserializeObject<TicketInfo>(res);
            //TicketGet ticketGet = new TicketGet();
            //ticketGet.trainDate = ticketInfo.ticket.trainDate;
            //ticketGet.trainCodeAt = ticketInfo.ticket.trainCodeAt;
            //ticketGet.coachNo = ticketInfo.ticket.coachNo;
            //ticketGet.seatNo = ticketInfo.ticket.seatNo;
            //ticketGet.seatType = ticketInfo.ticket.seatType;
            //DataTable aa = SQLhelp.GetInfo(ticketGet);
            //List<DJ60_change_seat_log> listdj = TableToList.ToDataList<DJ60_change_seat_log>(aa);
            //dayinxieru(listdj);
            //streamToPrint = new FileStream(@address, FileMode.OpenOrCreate, FileAccess.ReadWrite,
            //    FileShare.None);
            //// 创建一个PrintDialog的实例。 
            //PrintDialog PrintDialog1 = new PrintDialog();
            //// 把PrintDialog的Document属性设为上面配置好的PrintDocument的实例 
            //streamToPrint.Close();
            //PrintDocument p = new PrintDocument();
            ////隐藏 对话框
            //PrintController printController = new StandardPrintController();
            //p.PrintController = printController;
            ////创建打印画布
            //p.PrintPage += new PrintPageEventHandler(docToPrint_PrintPage);
            //p.Print();
        }
        #region API声明
        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_StartFindIDCard(int iPort, byte[] pucManaInfo, int iIfOpen);

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_SelectIDCard(int iPort, byte[] pucManaMsg, int iIfOpen);

        [DllImport("sdtapi.dll")]
        private static extern int InitComm(int Port);//初始化

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_ReadBaseMsg(int iPort, byte[] pucCHMsg, ref UInt32 puiCHMsgLen, byte[] pucPHMsg, ref UInt32 puiPHMsgLen, int iIfOpen);

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_OpenPort(int iPort);

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_ClosePort(int iPort);

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_GetCOMBaud(int iPort, ref UInt32 puiBaudRate);

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_SetCOMBaud(int iPort, UInt32 uiCurrBaud, UInt32 uiSetBaud);

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_ResetSAM(int iPort, int iIfOpen);

        [DllImport("sdtapi.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int SDT_GetSAMStatus(int iPort, int iIfOpen);

        //#define TX_TYPE_NONE 0
        //#define TX_TYPE_USB 1 这个是 USB 口
        //#define TX_TYPE_LPT 2 这个是并口
        //#define TX_TYPE_COM 3 这个是串口
        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern bool  TxOpenPrinter(int Type, int Idx);
        //#define TX_STAT_NOERROR 0x0008 无故障
        //#define TX_STAT_SELECT 0x0010 处于联机状态
        //#define TX_STAT_PAPEREND 0x0020 缺纸
        //#define TX_STAT_BUSY 0x0080 繁忙
        //#define TX_STAT_DRAW_HIGH 0x0100 钱箱接口的电平（整机使用的， 模块无用）
        //#define TX_STAT_COVER 0x0200 打印机机芯的盖子打开
        //#define TX_STAT_ERROR 0x0400 打印机错误
        //#define TX_STAT_RCV_ERR 0x0800 可恢复错误（需要人工干预）
        //#define TX_STAT_CUT_ERR 0x1000 切刀错误
        //#define TX_STAT_URCV_ERR 0x2000 不可恢复错误
        //#define TX_STAT_ARCV_ERR 0x4000 可自动恢复的错误
        //#define TX_STAT_PAPER_NE 0x8000 快要没有纸了
        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int  TxGetStatus();//获取打印机状态

        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern void TxClosePrinter();//关闭所连接的打印机

        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern bool  TxWritePrinter(byte[] buf, int len);//输出指定的缓冲buf : 为缓冲区指针len : 为缓冲区长度

        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern int TxReadPrinter(byte[] buf, int len);//从打印机读取数据buf : 为接收缓冲len : 为欲读取的字节数

        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern void TxInit();//发送初始化指令， 初始化打印机

        //串口设置参数的定义如下
        public UInt32 TX_SER_BAUD_MASK = 0xFF000000; //波特率
        public UInt32 TX_SER_BAUD9600 = 0x00000000;// 9600 的波特率
        public UInt32 TX_SER_BAUD19200 = 0x01000000;// 19200 的波特率
        public UInt32 TX_SER_BAUD38400 = 0x02000000; // 38400 的波特率
        public UInt32 TX_SER_BAUD57600 = 0x03000000; // 57600 的波特率
        public UInt32 TX_SER_BAUD115200 = 0x04000000; // 115200 的波特率
        public UInt32 TX_SER_DATA_MASK = 0x00FF0000; // 数据位
        public UInt32 TX_SER_DATA_8BITS = 0x00000000; // 8 位数据位
        public UInt32 TX_SER_DATA_7BITS = 0x00010000; // 7 为数据位
        public UInt32 TX_SER_PARITY_MASK = 0x0000FF00; // 校验
        public UInt32 TX_SER_PARITY_NONE = 0x00000000; // 无校验
        public UInt32 TX_SER_PARITY_EVEN = 0x00000100; // 偶校验
        public UInt32 TX_SER_PARITY_ODD = 0x00000200; // 奇校验
        public UInt32 TX_SER_STOP_MASK = 0x000000F0; // 停止位
        public UInt32 TX_SER_STOP_1BITS = 0x00000000; // 1 位停止位
        public UInt32 TX_SER_STOP_15BITS = 0x00000010; // 1.5 位停止位
        public UInt32 TX_SER_STOP_2BITS = 0x00000020; // 2 位停止位
        public UInt32 TX_SER_FLOW_MASK = 0x0000000F; // 流控制
        public UInt32 TX_SER_FLOW_NONE = 0x00000000; // 无流控
        public UInt32 TX_SER_FLOW_HARD = 0x00000001; // 硬件流控（DTR/DSR 方式）
        public UInt32 TX_SER_FLOW_SOFT = 0x00000002; // 软件流控（XON/XOFF 方式）
        //attr 参数是波特率， 数据位， 校验位， 停止位， 流控位的组合
        //TxSetupSerial(TX_SER_BAUD38400|TX_SER_DATA_8BITS|TX_SER_PARITY_NONE|TX_S
        //ER_STOP_1BITS|TX_SER_FLOW_HARD);
        //上面的例子就是设置串口位 38400 的波特率， 8 位数据位， 无校验， 1 位停止位， 硬件流控。
        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern void TxSetupSerial(UInt32 attr);//设置串口参数

        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern void TxOutputStringLn(string str);//输出字符串（以\0 结束）， 并自动添加回车、 换行

        [DllImport("TxPrnMod.dll", CallingConvention = CallingConvention.StdCall)]
        static extern void  TxNewline();//输出回车、 换行， 就是向打印机发送 0x0D,0x0A 的数据， 打印机接收到后， 会将缓冲区中的数据打印并走纸 1 行
        #endregion
        /// <summary>
        /// 窗体加载
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            mainPage mainPage = new mainPage();
            frameMain.Navigate(mainPage);
            mainPage.imgIdentity.MouseDown+=new MouseButtonEventHandler(ImgIdentity_MouseDown);
            mainPage.imgTicket.MouseDown+=new MouseButtonEventHandler(ImgTicket_MouseDown);
            ShowTime();    //在这里窗体加载的时候不执行文本框赋值，窗体上不会及时的把时间显示出来，而是等待了片刻才显示了出来
            ShowTimer = new DispatcherTimer();
            ShowTimer.Tick += new EventHandler(ShowCurTimer);//起个Timer一直获取当前时间
            ShowTimer.Interval = new TimeSpan(0, 0, 0, 1, 0);
            ShowTimer.Start();
        }
        /// <summary>
        /// 显示当前时间
        /// </summary>
        private void ShowTime()
        {
            //获得年月日
            this.currentTimeLabel.Content = DateTime.Now.ToString("yyyy-MM-dd")+"   "+ System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetDayName(DateTime.Now.DayOfWeek)+"   " +DateTime.Now.ToString("HH:mm:ss");
        }
        public void ShowCurTimer(object sender, EventArgs e)
        {
            ShowTime();
        }
        /// <summary>
        /// 身份证点击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ImgIdentity_MouseDown(object sender, MouseButtonEventArgs e)
        {
            identityCardPage identityCardPage = new identityCardPage();
            frameMain.Navigate(identityCardPage);
            this.topTitle.Content = "席位置换";
            this.back.Visibility = Visibility.Visible;
            identityCardPage.btnBackIdentity.MouseDown += new MouseButtonEventHandler(BtnBackIdentity_MouseDown);
            tIdentity = new System.Timers.Timer(3000);
            //实例化Timer类，设置间隔时间为10000毫秒；
            tIdentity.Elapsed += new System.Timers.ElapsedEventHandler(theoutIdentity);
            //到达时间的时候执行事件； 
            tIdentity.AutoReset = true;
            //设置是执行一次（false）还是一直执行(true)；   
            tIdentity.Start();
            //需要调用 timer.Start()或者timer.Enabled = true来启动它， timer.Start()的内部原理还是设置timer.Enabled = true; 
        }
        public void theoutIdentity(object source, System.Timers.ElapsedEventArgs e)
        {
            tIdentity.Stop();
            tIdentity.Close();
            try
            {
                int iRet = 0;
                int iPort = Convert.ToInt32(ConfigurationManager.AppSettings["IdentityPort"]);
                //变量声明
                byte[] CardPUCIIN = new byte[255];
                byte[] pucManaMsg = new byte[255];
                byte[] pucCHMsg = new byte[255];
                byte[] pucPHMsg = new byte[3024];
                

                UInt32 puiCHMsgLen = 0;
                UInt32 puiPHMsgLen = 0;
                UInt32 puiBaudRate = 0;
                int st = 0;
                //查看串口当前波特率
                int baudRate = SDT_GetCOMBaud(iPort, ref puiBaudRate);
                if (baudRate!= 0x90)
                {
                    tIdentity.Start();
                    return;
                }
                //设置SAM_V 的串口的波特率
                int baudRatee = SDT_SetCOMBaud(iPort, puiBaudRate, puiBaudRate);
                if (baudRatee != 0x90)
                {
                    tIdentity.Start();
                    return;
                }
                //打开串口/USB
                iRet = SDT_OpenPort(iPort);
                if (iRet != 0x90)
                {
                    //关闭串口/USB
                    SDT_ClosePort(iPort);
                    tIdentity.Start();
                    return;
                }
                //对 SAM_V 复位
                int sam =SDT_ResetSAM(iPort,0);
                if (sam != 0x90)
                {
                    //关闭串口/USB
                    SDT_ClosePort(iPort);
                    tIdentity.Start();
                    return;
                }
                //对 SAM_V 进行状态检测
                int samstate = SDT_GetSAMStatus(iPort,0);
                if (samstate != 0x90)
                {
                    //关闭串口/USB
                    SDT_ClosePort(iPort);
                    tIdentity.Start();
                    return;
                }
                //开始找卡
                st = SDT_StartFindIDCard(iPort, CardPUCIIN, 0);
                if (st != 0x9f) {
                    tIdentity.Start();
                    return;
                }
                //选卡
                st = SDT_SelectIDCard(iPort, pucManaMsg, 0);
                if (st != 0x90)
                {
                    tIdentity.Start();
                    return;
                }
                //读取证/卡固定信息
                st = SDT_ReadBaseMsg(iPort, pucCHMsg, ref puiCHMsgLen, pucPHMsg, ref puiPHMsgLen, 0);
                if (st != 0x90)
                {
                    tIdentity.Start();
                    return;
                }
                //显示结果
                var result=ASCIIEncoding.Unicode.GetString(pucCHMsg);
                this.Dispatcher.Invoke(new Action(() =>
                {

                    DoPrint(result);

                    //dayinxieru(result);
                    //streamToPrint = new FileStream(@address, FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.None);
                    //// 创建一个PrintDialog的实例。 
                    //PrintDialog PrintDialog1 = new PrintDialog();
                    //// 把PrintDialog的Document属性设为上面配置好的PrintDocument的实例 
                    //streamToPrint.Close();
                    //PrintDocument p = new PrintDocument();
                    ////隐藏 对话框
                    //PrintController printController = new StandardPrintController();
                    //p.PrintController = printController;
                    ////创建打印画布
                    //p.PrintPage += new PrintPageEventHandler(docToPrint_PrintPage);
                    //p.Print();

                    frameMain.NavigationService.GoBack();
                    this.back.Visibility = Visibility.Hidden;
                    this.topTitle.Content = "席位置换自助终端";
                }));
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }
        /// <summary>
        /// 网络打印机
        /// </summary>
        /// <param name="result"></param>
        public void dayinxieru(List<DJ60_change_seat_log> result)
        {
            string newTime = result[0].new_train_date;
            string checi = result[0].new_train_code;
            string chexiang = result[0].coach_no;
            string xiwei = result[0].seat_no;
            string xchexiang = result[0].new_coach_no;
            string xxiwei = result[0].new_seat_no;
            //保存打印信息
            StreamWriter sww = new StreamWriter(addressSave, true);
            string strRiqi = DateTime.Now.ToString("yyyy-MM-dd");
            string strShijian = DateTime.Now.ToString("HH:mm:ss");
            DateTime dt = DateTime.ParseExact(newTime, "yyyyMMdd", System.Globalization.CultureInfo.CurrentCulture);
            string time = string.Format("{0:M}", Convert.ToDateTime(dt));
            sww.WriteLine(" 欢迎乘坐西安北动车         ");
            sww.WriteLine("                                                   ");
            sww.WriteLine("您打印的车次" + time + " " + checi.Trim() + "次");
            sww.WriteLine("* * * * * * * * * * * * * * * * * * * * * * * *             ");
            sww.WriteLine("         原车厢            原席位");
            sww.WriteLine("              " + chexiang + "                  " + xiwei);
            sww.WriteLine(" ----------------------------------------------");
            sww.WriteLine("         新车厢            新席位");
            sww.WriteLine("              " + xchexiang + "                 " + xxiwei);
            sww.WriteLine("* * * * * * * * * * * * * * * * * * * * * * * *           ");
            sww.WriteLine(" 打印时间：" + strRiqi + " " + strShijian);
            sww.WriteLine(result);
            sww.WriteLine("                                                   ");
            sww.Close();
            // 小票打印
            StreamWriter sw = new StreamWriter(address, false);
            sw.WriteLine(" 欢迎乘坐西安北动车         ");
            sw.WriteLine("                                                   ");
            sw.WriteLine("您打印的车次" + time + " " + checi.Trim() + "次");
            sw.WriteLine("* * * * * * * * * * * * * * * * * * * * * * * *             ");
            sw.WriteLine("         原车厢            原席位");
            sw.WriteLine("              " + chexiang + "                  " + xiwei);
            sw.WriteLine(" ----------------------------------------------");
            sw.WriteLine("         新车厢            新席位");
            sw.WriteLine("               " + xchexiang + "                 " + xxiwei);
            sw.WriteLine("* * * * * * * * * * * * * * * * * * * * * * * *           ");
            sw.WriteLine(" 打印时间：" + strRiqi + " " + strShijian);
            sw.WriteLine("                                                   ");
            sw.Close();
        }
        private void docToPrint_PrintPage(object sender, PrintPageEventArgs e)
        {
            switch (this.streamType)
            {
                case "txt":
                    string text = null;
                    // 信息头 
                    string strTou = string.Empty;
                    System.Drawing.Font printFont = new System.Drawing.Font
                    ("Arial", 11, System.Drawing.FontStyle.Regular);
                    System.Drawing.Font printFont1 = new System.Drawing.Font
                    ("Arial", 16, System.Drawing.FontStyle.Regular);
                    System.IO.StreamReader streamReader = new StreamReader(@address);
                    text = streamReader.ReadToEnd();
                    // 获取信息头 
                    strTou = text.Substring(0, 30);
                    //信息其他部分 
                    text = text.Substring(70, (text.Length - 70));
                    // 设置信息打印格式 
                    e.Graphics.DrawString(strTou, printFont1, System.Drawing.Brushes.Black, 10, 0);
                    e.Graphics.DrawString(text, printFont, System.Drawing.Brushes.Black, 10, 5);
                    streamReader.Close();
                    break;
                case "image":
                    System.Drawing.Image image = System.Drawing.Image.FromStream(this.streamToPrint);
                    int x = e.MarginBounds.X;
                    int y = e.MarginBounds.Y;
                    int width = image.Width;
                    int height = image.Height;
                    if ((width / e.MarginBounds.Width) > (height / e.MarginBounds.Height))
                    {
                        width = e.MarginBounds.Width;
                        height = image.Height * e.MarginBounds.Width / image.Width;
                    }
                    else
                    {
                        height = e.MarginBounds.Height;
                        width = image.Width * e.MarginBounds.Height / image.Height;
                    }
                    System.Drawing.Rectangle destRect = new System.Drawing.Rectangle(x, y, width, height);
                    e.Graphics.DrawImage(image, destRect, 0, 0, image.Width, image.Height, System.Drawing.GraphicsUnit.Pixel);
                    break;
                default:
                    break;
            }
        }
        /// <summary>
        /// 车票点击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ImgTicket_MouseDown(object sender, MouseButtonEventArgs e)
        {
            ticketPage ticketPage = new ticketPage();
            frameMain.Navigate(ticketPage);
            this.topTitle.Content = "席位置换";
            this.back.Visibility = Visibility.Visible;
            ticketPage.btnBackTicket.MouseDown += new MouseButtonEventHandler(BtnBackTicket_MouseDown);

            tTicket = new System.Timers.Timer(3000);
            tTicket.Elapsed += new System.Timers.ElapsedEventHandler(theoutTicket);
            tTicket.AutoReset = true;   
            tTicket.Start();
        }
        public void theoutTicket(object source, System.Timers.ElapsedEventArgs e)
        {
            tTicket.Stop();
            tTicket.Close();
            try
            {
                int flag = Dll_Camera.StartDevice();//启动设备（1设备启动成功）
                if (flag != 1)
                {
                    tTicket.Start();
                    return;
                }
                Dll_Camera.SetBeep(true);//蜂鸣开启
                int flagg = Dll_Camera.GetDevice();//查找设备（1设备查找成功）
                if (flagg != 1)
                {
                    Dll_Camera.ReleaseLostDevice();
                    tTicket.Start();
                    return;
                }
                //设置qr
                Dll_Camera.setQRable(true);//QR引擎开启
                Dll_Camera.SetBeepTime(100);//蜂鸣时间
                Dll_Camera.SetDecodeTime(200);
                int Length = 1024;
                StringBuilder tempStr = new StringBuilder(Length);
                Dll_Camera.setQRable(false);//为防止重复信息误读 关闭解码
                Dll_Camera.GetDecodeString(tempStr, out Length);
                var result = "";
                if (Length > 0)
                {
                    result = tempStr.ToString();
                    var qrUrl = ConfigurationManager.AppSettings["QRURL"];
                    string res = RestClient.HttpPost(qrUrl, result);
                    TicketInfo ticketInfo = JsonConvert.DeserializeObject<TicketInfo>(res);
                    if (ticketInfo.status==1)
                    {
                        TicketGet ticketGet = new TicketGet();
                        ticketGet.trainDate = ticketInfo.ticket.trainDate;
                        ticketGet.trainCodeAt = ticketInfo.ticket.trainCodeAt;
                        ticketGet.coachNo = ticketInfo.ticket.coachNo;
                        ticketGet.seatNo = ticketInfo.ticket.seatNo;
                        ticketGet.seatType = ticketInfo.ticket.seatType;
                        DataTable aa = SQLhelp.GetInfo(ticketGet);
                        List<DJ60_change_seat_log> listdj= TableToList.ToDataList<DJ60_change_seat_log>(aa);
                        dayinxieru(listdj);
                        streamToPrint = new FileStream(@address, FileMode.OpenOrCreate, FileAccess.ReadWrite,
                            FileShare.None);
                        // 创建一个PrintDialog的实例。 
                        PrintDialog PrintDialog1 = new PrintDialog();
                        // 把PrintDialog的Document属性设为上面配置好的PrintDocument的实例 
                        streamToPrint.Close();
                        PrintDocument p = new PrintDocument();
                        //隐藏 对话框
                        PrintController printController = new StandardPrintController();
                        p.PrintController = printController;
                        //创建打印画布
                        p.PrintPage += new PrintPageEventHandler(docToPrint_PrintPage);
                        p.Print();


                        //DoPrint(ticketInfo.ticket);
                    }
                    else
                    {//根据二维码信息获取旅客信息失败
                        return;
                    }
                    
                    this.Dispatcher.Invoke(new Action(() =>
                    {
                        //dayinxieru(result);
                        //streamToPrint = new FileStream(@address, FileMode.OpenOrCreate, FileAccess.ReadWrite,
                        //    FileShare.None);
                        //// 创建一个PrintDialog的实例。 
                        //PrintDialog PrintDialog1 = new PrintDialog();
                        //// 把PrintDialog的Document属性设为上面配置好的PrintDocument的实例 
                        //streamToPrint.Close();
                        //PrintDocument p = new PrintDocument();
                        ////隐藏 对话框
                        //PrintController printController = new StandardPrintController();
                        //p.PrintController = printController;
                        ////创建打印画布
                        //p.PrintPage += new PrintPageEventHandler(docToPrint_PrintPage);
                        //p.Print();

                        frameMain.NavigationService.GoBack();
                        this.back.Visibility = Visibility.Hidden;
                        this.topTitle.Content = "席位置换自助终端";
                    }));
                }
                else
                {
                    tTicket.Start();
                    return;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }
        /// <summary>
        /// 身份证返回
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnBackIdentity_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (tIdentity != null)
            {
                tIdentity.Stop();
                tIdentity.Close();
            }
            frameMain.NavigationService.GoBack();
            this.back.Visibility = Visibility.Hidden;
            this.topTitle.Content = "席位置换自助终端";
        }
        /// <summary>
        /// 车票返回
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnBackTicket_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (tTicket != null)
            {
                tTicket.Stop();
                tTicket.Close();
            }
            frameMain.NavigationService.GoBack();
            this.back.Visibility = Visibility.Hidden;
            this.topTitle.Content = "席位置换自助终端";
        }
        /// <summary>
        /// 首页返回
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Back_MouseDown(object sender, MouseButtonEventArgs e)
        {
            mainPage mainPage = new mainPage();
            frameMain.Navigate(mainPage);
            mainPage.imgIdentity.MouseDown += new MouseButtonEventHandler(ImgIdentity_MouseDown);
            mainPage.imgTicket.MouseDown += new MouseButtonEventHandler(ImgTicket_MouseDown);
            this.topTitle.Content = "席位置换自助终端";
            this.back.Visibility = Visibility.Hidden;
            if (tIdentity != null)
            {
                tIdentity.Stop();
                tIdentity.Close();
            }
            if (tTicket != null)
            {
                tTicket.Stop();
                tTicket.Close();
            }
        }
        /// <summary>
        /// 打印机程序
        /// </summary>
        /// <param name="result"></param>
        public void DoPrint(string result)
        {
            string newTime = "5月28日";
            string checi = "T5461";
            string chexiang = "03";
            string xiwei = "17B";
            string xchexiang = "06";
            string xxiwei = "19C";
            int TX_TYPE = Convert.ToInt32(ConfigurationManager.AppSettings["TX_TYPE"]);
            int TX_Port = Convert.ToInt32(ConfigurationManager.AppSettings["TX_Port"]);
            if (TxOpenPrinter(TX_TYPE, TX_Port))
            {
                TxSetupSerial(TX_SER_BAUD38400 | TX_SER_DATA_8BITS | TX_SER_PARITY_NONE | TX_SER_STOP_1BITS | TX_SER_FLOW_HARD);
                int a = TxGetStatus();
                if (a!= 0x0008)
                {
                    MessageBox.Show(a.ToString());
                }
                TxInit();
                TxOutputStringLn("   欢迎乘坐西安北动车    ");
                TxNewline();
                TxOutputStringLn("您打印的车次" + newTime + " " + checi + "次");
                TxOutputStringLn("* * * * * * * * * * * * *");
                TxOutputStringLn("   原车厢        原席位  ");
                TxOutputStringLn("   "+ chexiang+"       "+ xiwei);
                TxOutputStringLn(" ----------------------- ");
                TxOutputStringLn("   新车厢        新席位  ");
                TxOutputStringLn("   " + xchexiang + "       " + xxiwei);
                TxOutputStringLn("* * * * * * * * * * * * *");
                TxOutputStringLn("打印时间："+ DateTime.Now.ToLocalTime().ToString());
                TxClosePrinter();
            }
        }
    }
}
