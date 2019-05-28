using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Threading;

namespace dll_camera_demo
{
    public partial class TestForm : Form
    {
        //设备状态
        public Boolean deviceState = false;
        public Boolean qrEnable = true;
        public Boolean dmEnable = true;
        public Boolean hxEnable = true;//如需汉信码解码，请联系我们 www.inspiry.cn
        public Boolean barEnable = true;
        public const int USER = 0x0400;//程序起始地址

        public TestForm()
        {
            InitializeComponent();
        }
        protected override void DefWndProc(ref Message msg)
        {
            
            if (msg.Msg == USER + 123)//receive code info from the 532 dll
            {

                Dll_Camera.setQRable(false);
                Dll_Camera.setDMable(false);            
                 Dll_Camera.setBarcode(false);

                IntPtr wp = new IntPtr((int)msg.WParam);
                byte[] wpbuf = new byte[((int)msg.LParam)];
                Marshal.Copy(wp, wpbuf, 0, ((int)msg.LParam));
                string strBC = System.Text.Encoding.GetEncoding("GB2312").GetString(wpbuf, 0, ((int)msg.LParam));
                this.codeInfo.AppendText(strBC.Trim());
                Thread.Sleep(2000);
                if (this.qrEnable == true)
                {
                    Dll_Camera.setQRable(true);
                }
                if (this.dmEnable == true)
                {
                    Dll_Camera.setDMable(true);
                }
                if (this.barEnable == true)
                {
                    Dll_Camera.setBarcode(true);
                }

            }
            else
            {
                base.DefWndProc(ref msg);
            }
        }
        private void TestForm_Load(object sender, EventArgs e)
        {
            this.timerCheck.Enabled = true;
            this.timerCheck.Interval = 2000;
            //通过消息得到解码信息 获取本地权限
            Dll_Camera.GetAppHandle(this.Handle);
            this.qrDecode.Checked = true;
            this.dmDecode.Checked = true;
            this.hxDecode.Checked = false;
            this.barDecode.Checked = true;
            
        }
        private void qrDecode_CheckedChanged(object sender, EventArgs e)
        {
            if (this.qrDecode.Checked == true)
            {
                this.qrEnable = true;
            }
            else
            {
                this.qrEnable = false;
            }
            Dll_Camera.setQRable(this.qrEnable);
        }
        //定时器 定时查看设备连接状态
        private void timerCheck_Tick(object sender, EventArgs e)
        {
            if (!deviceState)
            {
                int flag = Dll_Camera.StartDevice();

                //Dll_Camera.StartDevice();启动设备
                //int result = Dll_Camera.GetDevice();
             
                if (flag == 1)
                //if(result == 1)
                {
                    //第三步：设置打开蜂鸣器，DLL默认不打开
                    Dll_Camera.SetBeep(true);
                    //设置一维                
                   Dll_Camera.setBarcode(barEnable);
                    //设置qr
                    Dll_Camera.setQRable(qrEnable);
                    //设置dm
                    Dll_Camera.setDMable(dmEnable);
                    //设置扫码成功蜂鸣
                    Dll_Camera.SetBeepTime(100);
                    Dll_Camera.SetDecodeTime(200);

                    deviceState = true;
                    this.labelText.Text = "解码信息：(设备已连接)";
                }
                else if (flag == -1)
                {
                    this.labelText.Text = "解码信息：(设备已启动)";
                }
                else if (flag == -2)
                {
                    this.labelText.Text = "解码信息：(设备已断开)";
                }
                else if (flag == -3)
                {
                    this.labelText.Text = "解码信息：(设备已初始化失败)";
                }
            }
            else
            {
                int result = Dll_Camera.GetDevice();
              // 定时获取设备信息
                if (result == 1)
                {
                    this.labelText.Text = "解码信息：(设备已连接)";
                }
                else
                {
                    deviceState = false;
                    Dll_Camera.ReleaseLostDevice();
                    this.labelText.Text = "解码信息：(设备已断开)";
                }
            }

        }
        //点击“获取解码信息”按钮，通过DLL里的GetDecodeString函数取得码值
        private void buttonRead_Click(object sender, EventArgs e)
        {
            if (deviceState)
            {
                int Length = 1024;
                StringBuilder tempStr = new StringBuilder(Length);

                Dll_Camera.setQRable(false);//为防止重复信息误读 关闭解码
                Dll_Camera.setBarcode(false);
                Dll_Camera.GetDecodeString(tempStr, out Length);
                if (Length > 0)
                    this.textBox1.AppendText(tempStr.ToString());

                Thread.Sleep(1000);
                Dll_Camera.setQRable(true);
                Dll_Camera.setBarcode(true);//传输解码信息完毕 开启解码
            }
            else
            {
                MessageBox.Show("设备已断开");
            }
        }

        private void Clear_Click(object sender, EventArgs e)
        {
            StringBuilder tempStr = new StringBuilder();
            tempStr.Length = 0;
            this.codeInfo.Text = tempStr.ToString();
            this.textBox1.Text = tempStr.ToString();
        }

        private void TestForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (deviceState == true)
            {
                Dll_Camera.ReleaseDevice();
            }
            else
            {
                Dll_Camera.ReleaseLostDevice();
            }
        }

        private void dmDecode_CheckedChanged(object sender, EventArgs e)
        {
            if (this.dmDecode.Checked == true)
            {
                this.dmEnable = true;
            }
            else
            {
                this.dmEnable = false;
            }
            Dll_Camera.setDMable(true);
        }

        private void hxDecode_CheckedChanged(object sender, EventArgs e)
        {
            if (this.hxDecode.Checked == true)
            {

            }
            else
            {

            }
        }

        private void barDecode_CheckedChanged(object sender, EventArgs e)
        {
            if (this.barDecode.Checked == true)
            {
                this.barEnable = true;
            }
            else
            {
                this.barEnable = false;
            }
       
           Dll_Camera.setBarcode(false);
        }
       

    }
}
