// VCNoTestDlg.cpp : implementation file
//

#include "stdafx.h"
#include "VCNoTest.h"
#include "VCNoTestDlg.h"
#include "sdtapi.h"
#include "wltrs.h"
#include "iostream.h"
#include "fstream.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVCNoTestDlg dialog

CVCNoTestDlg::CVCNoTestDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CVCNoTestDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CVCNoTestDlg)
	m_Name = _T("");
	m_Sex = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CVCNoTestDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CVCNoTestDlg)
	DDX_Control(pDX, IDC_edtName, m_Na);
	DDX_Control(pDX, IDC_Picture, m_Picture);
	DDX_Text(pDX, IDC_edtName, m_Name);
	DDX_Text(pDX, IDC_edtSex, m_Sex);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CVCNoTestDlg, CDialog)
	//{{AFX_MSG_MAP(CVCNoTestDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, OnButton1)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVCNoTestDlg message handlers

BOOL CVCNoTestDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CVCNoTestDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CVCNoTestDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CVCNoTestDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

int chczeroend(char * pucAppMsg, int chlength)
{
	for (int i = 0; i < chlength; i ++)
	{
		if (pucAppMsg[i] == 0x3f)
		{
			pucAppMsg[i] = '\0';
			return (i + 1);
		}

	}
}


void CVCNoTestDlg::OnButton1() 
{
	// TODO: Add your control notification handler code here
	
	int iResultValue, ichar, i;	
	unsigned char pucCHMsg[256];
	unsigned int  puiCHMsgLen;
	unsigned char pucPHMsg[1024];
	unsigned int  puiPHMsgLen; 
	char hxcName[100];
	char hxcSex[10];
	char hxcFolk[10];
	char hxcBirth[20];
	char hxcAddress[256];
	char hxcIDNu[40];
	char hxcSignDepart[50];
	char hxcUseLife[100];
	
	wchar_t wt_Name[30];
	wchar_t wt_Sex[2];
	wchar_t wt_Folk[4];
	wchar_t wt_Birth[16];
	wchar_t wt_Address[70];
	wchar_t wt_IDNu[36];
	wchar_t wt_SignDepart[30];
	wchar_t wt_UseLife[32];		
	
	unsigned char pucManaInfo[255];
	unsigned char pucManaMsg[255];	
	
	int iPort=1;
	int st=0;
	int iIfOpen = 1;
	int iRet;

	//读卡
	iResultValue=SDT_StartFindIDCard(iPort,pucManaInfo,1);
	if(iResultValue!=0x9f) return ;
	iResultValue=SDT_SelectIDCard(iPort,pucManaMsg,1);
    if(iResultValue!=0x90) return ;

	iResultValue = SDT_ReadBaseMsg(iPort, pucCHMsg, &puiCHMsgLen, pucPHMsg, &puiPHMsgLen, iIfOpen);
	memcpy(&wt_Name[0], &pucCHMsg[0], 30);
	memcpy(&wt_Sex[0], &pucCHMsg[30], 2);
	memcpy(&wt_Folk[0], &pucCHMsg[32], 4);
	memcpy(&wt_Birth[0], &pucCHMsg[36], 16);
	memcpy(&wt_Address[0], &pucCHMsg[52], 70);
	memcpy(&wt_IDNu[0], &pucCHMsg[122], 36);
	memcpy(&wt_SignDepart[0], &pucCHMsg[158], 30);
	memcpy(&wt_UseLife[0], &pucCHMsg[188], 32); 
    	
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_Name, -1, hxcName, 30, NULL, NULL);     
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_Sex, -1, hxcSex, 2, NULL, NULL);     
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_Folk, -1, hxcFolk, 4, NULL, NULL);     
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_Birth, -1, hxcBirth, 16, NULL, NULL);     
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_Address, -1, hxcAddress, 70, NULL, NULL);     
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_IDNu, -1, hxcIDNu, 36, NULL, NULL);     
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_SignDepart, -1, hxcSignDepart, 30, NULL, NULL);     
	ichar = WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, wt_UseLife, -1, hxcUseLife, 32, NULL, NULL);     
	
	chczeroend(hxcName, 30);
	chczeroend(hxcSex, 2);
	chczeroend(hxcFolk, 4);
	chczeroend(hxcBirth, 16);
	chczeroend(hxcAddress, 70);
	chczeroend(hxcIDNu, 36);
	chczeroend(hxcSignDepart, 30);
	chczeroend(hxcUseLife, 32);

	GetDlgItem(IDC_edtName)->SetWindowText(hxcName);
	GetDlgItem(IDC_edtSex)->SetWindowText(hxcSex);

	FILE *MyFile;
	char pcPHMsgFileName[MAX_PATH];

	strcpy(pcPHMsgFileName,"picture.wlt");
	
	if ((MyFile = fopen(pcPHMsgFileName,"wb"))==NULL) return;     //建立或打开文件(写)
			   fwrite(pucPHMsg,sizeof(unsigned char),puiPHMsgLen,MyFile);
			   fclose(MyFile);
	iRet = GetBmp("picture.wlt", 1);
	if (iRet != 0)
		return;

	/*方式1
		CWnd *hwnd;
		HDC hdc,hdcs;
		RECT rect;
		hwnd=GetDlgItem(IDC_Picture);//位图要显示的位置（picture控件）
		hdc=hwnd->GetDC()->m_hDC;
        hdcs = CreateCompatibleDC(hdc);
		HBITMAP m_hBitmap;
        BITMAP bm;
        m_hBitmap=(HBITMAP)::LoadImage(NULL,"picture.bmp",IMAGE_BITMAP,0,0,LR_LOADFROMFILE|LR_CREATEDIBSECTION|LR_DEFAULTSIZE);
        GetObject(m_hBitmap, sizeof BITMAP, &bm);
		
		SelectObject(hdcs, m_hBitmap);
		
		hwnd->GetClientRect(&rect);
		::SetStretchBltMode(hdc,COLORONCOLOR);       
		::StretchBlt(hdc, rect.left, rect.top, rect.right, rect.bottom, hdcs, 0, 0, bm.bmWidth, bm.bmHeight,+SRCCOPY);
	*/	
	//方式2
	HBITMAP m_hBitmap;
	m_hBitmap=(HBITMAP)::LoadImage(NULL,"C:\\picture.bmp",IMAGE_BITMAP,0,0,LR_LOADFROMFILE|LR_CREATEDIBSECTION|LR_DEFAULTSIZE);
        
	m_Picture.SetBitmap(m_hBitmap);
	


}