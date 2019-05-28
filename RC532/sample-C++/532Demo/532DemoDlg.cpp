
// 532DemoDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "532Demo.h"
#include "532DemoDlg.h"
#include "afxdialogex.h"
#include "Device2.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#define WM_NOTIFYICON   WM_USER+5

#if defined(_WIN64)
#pragma comment(lib, "64RC532.lib")
#else
#pragma comment(lib, "dll_camera.lib")
#endif


//此处为引用DLL库，根据操作系统情况判断

// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
protected:
	DECLARE_MESSAGE_MAP()
//	afx_msg LRESULT GetDecodeStr(WPARAM wParam, LPARAM lParam);
};

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)	
END_MESSAGE_MAP()


// CMy532DemoDlg 对话框



CMy532DemoDlg::CMy532DemoDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CMy532DemoDlg::IDD, pParent)
{
	bDM= FALSE;
	//bQR= FALSE;
	bQR=TRUE;
    bBarcode= FALSE;
	isRun=false;
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMy532DemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT1, m_edit1);
	DDX_Control(pDX, IDC_EDIT2, m_edit2);
}
//通过类向导添加WM_DecodeSucess的接收函数为GetDecodeStr否则接收不到MSG
BEGIN_MESSAGE_MAP(CMy532DemoDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, &CMy532DemoDlg::OnButtonGetStr)	
	ON_MESSAGE(WM_DecodeSucess, &CMy532DemoDlg::GetDecodeStr)
	ON_MESSAGE(WM_ReleaseCamera, &CMy532DemoDlg::MessageReleaseCamera)
	ON_BN_CLICKED(IDC_BUTTON2, &CMy532DemoDlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDOK, &CMy532DemoDlg::OnBnClickedOk)
	ON_WM_CLOSE()
END_MESSAGE_MAP()


// CMy532DemoDlg 消息处理程序

BOOL CMy532DemoDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码 
	//==========================================RC532二次开发代码添加处=======================
	//初始化识读qr
	GetAppHandle(this->m_hWnd);
	
	isRun=StartDevice();//启动摄像头
    if(isRun!=1)
	{
		OnCancel();
		return false;
	}
	//SetLed（） 和SetBeep（）的控制都需在StartDevice（）成功之后才起作用。
	SetBeep(TRUE);//设置蜂鸣器打开状态
	//设置码制
	setQRable(TRUE);//使能qr引擎
	//setDMable(true);//使能DM引擎
	setBarcode(TRUE);//使能一维引擎

    SetBeepTime(100);//识读成功后 ，设置蜂鸣时间（ms）

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

void CMy532DemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CMy532DemoDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CMy532DemoDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}






//RC532为用户提供俩种获取解码信息的方式：（1）以消息的方式，mesgID为123，用户可在需要时拦截消息，
//消息参数WPARAM——消息内容, LPARAM——消息长度。
afx_msg LRESULT CMy532DemoDlg::GetDecodeStr(WPARAM wParam, LPARAM lParam)
{
	setQRable(false);
	setBarcode(false);
	
	BYTE* pbyDecodedMessage =(BYTE*)wParam;
	CString temp;
	temp=pbyDecodedMessage;
    m_edit2.SetWindowText(temp);
	//此处控制解码间隔更改Sleep时间
	Sleep(1000);
	setQRable(true);
	setBarcode(true);   
	return 0;
}

afx_msg LRESULT CMy532DemoDlg::MessageReleaseCamera(WPARAM wParam, LPARAM lParam)
{
	 ReleaseDevice();
	 PostMessage(WM_CLOSE);  
	
	return 0;
}
//（2）直接调用接口函数GetDecodeString(char *aa)，每调用一次GetDecodeString
//取得解码信息后，函数会自动清空解码信息的内存，等待存放下次解码信息。
//本例通过按钮控制接收函数
void CMy532DemoDlg::OnButtonGetStr()
{
	char strRsult[2000];
	int lenth;
	//调用DLL函数接收解码信息
	setQRable(false);
	setBarcode(false);
	int ret=GetDecodeString(strRsult,lenth);
    CString temp=strRsult;
	m_edit1.SetWindowText(temp);
	Sleep(1000);
	setQRable(true);
	setBarcode(true);
}
//请空接收信息
void CMy532DemoDlg::OnBnClickedButton2()

{
	m_edit1.SetWindowText("");
	m_edit2.SetWindowText("");
}

//退出时要调用DLL的ReleaseDevice()函数，否则不能完全关闭硬件
void CMy532DemoDlg::OnBnClickedOk()
{
	 ReleaseDevice();
	 PostMessage(WM_CLOSE);  
	 CDialogEx::OnOK();
}

//退出时要调用DLL的ReleaseDevice()函数，否则不能完全关闭硬件
void CMy532DemoDlg::OnClose()
{
	ReleaseDevice();
	CDialogEx::OnClose();
}
