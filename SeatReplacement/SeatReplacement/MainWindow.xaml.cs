using System;
using System.Configuration;
using System.Drawing.Printing;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;
using System.Windows.Threading;

namespace SeatReplacement
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        Stream streamToPrint;
        string address = "";//打印txt存放地址
        string addressSave = "";//保存txt存放地址
        string streamType = "txt";
        IniFile infile = new IniFile(AppDomain.CurrentDomain.BaseDirectory + @"\Config.INI");
        private DispatcherTimer ShowTimer;
        System.Timers.Timer tIdentity;
        System.Timers.Timer tTicket;
        public MainWindow()
        {
            InitializeComponent();
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
            address = infile.ReadValue("CONFIG", "ADDRESS");
            addressSave = infile.ReadValue("CONFIG", "ADDRESSSave");
        }
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
                int iPort = Convert.ToInt32(ConfigurationManager.AppSettings["iPort"]);
                //变量声明
                byte[] CardPUCIIN = new byte[255];
                byte[] pucManaMsg = new byte[255];
                byte[] pucCHMsg = new byte[255];
                byte[] pucPHMsg = new byte[3024];
                UInt32 puiCHMsgLen = 0;
                UInt32 puiPHMsgLen = 0;
                int st = 0;
                iRet = SDT_OpenPort(iPort);
                if (iRet != 0x90)
                {
                    SDT_ClosePort(iPort);
                    tIdentity.Start();
                    return;
                }

                //读卡操作
                st = SDT_StartFindIDCard(iPort, CardPUCIIN, 1);
                if (st != 0x9f) {
                    tIdentity.Start();
                    return;
                }
                st = SDT_SelectIDCard(iPort, pucManaMsg, 1);
                if (st != 0x90)
                {
                    tIdentity.Start();
                    return;
                }
                st = SDT_ReadBaseMsg(iPort, pucCHMsg, ref puiCHMsgLen, pucPHMsg, ref puiPHMsgLen, 1);
                if (st != 0x90)
                {
                    tIdentity.Start();
                    return;
                }
                //显示结果
                var result=ASCIIEncoding.Unicode.GetString(pucCHMsg);
                this.Dispatcher.Invoke(new Action(() =>
                {
                    dayinxieru(result);
                    streamToPrint = new FileStream(@address, FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.None);
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
        public void dayinxieru(string result)
        {
            string newTime = "20190521";
            string checi = "checi";
            string chexiang = "chexiang";
            string xiwei = "xiwei";
            string xchexiang = "xchexiang";
            string xxiwei = "xxiwei";
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
            sw.WriteLine("              " + xchexiang + "                 " + xxiwei);
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
                    this.Dispatcher.Invoke(new Action(() =>
                    {
                        dayinxieru(result);
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

                        frameMain.NavigationService.GoBack();
                        this.back.Visibility = Visibility.Hidden;
                        this.topTitle.Content = "席位置换自助终端";
                    }));
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
    }
}
