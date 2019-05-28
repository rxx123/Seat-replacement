
// 532DemoDlg.cpp : ʵ���ļ�
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


//�˴�Ϊ����DLL�⣬���ݲ���ϵͳ����ж�

// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// �Ի�������
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

// ʵ��
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


// CMy532DemoDlg �Ի���



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
//ͨ���������WM_DecodeSucess�Ľ��պ���ΪGetDecodeStr������ղ���MSG
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


// CMy532DemoDlg ��Ϣ�������

BOOL CMy532DemoDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// ��������...���˵�����ӵ�ϵͳ�˵��С�

	// IDM_ABOUTBOX ������ϵͳ���Χ�ڡ�
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

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������ 
	//==========================================RC532���ο���������Ӵ�=======================
	//��ʼ��ʶ��qr
	GetAppHandle(this->m_hWnd);
	
	isRun=StartDevice();//��������ͷ
    if(isRun!=1)
	{
		OnCancel();
		return false;
	}
	//SetLed���� ��SetBeep�����Ŀ��ƶ�����StartDevice�����ɹ�֮��������á�
	SetBeep(TRUE);//���÷�������״̬
	//��������
	setQRable(TRUE);//ʹ��qr����
	//setDMable(true);//ʹ��DM����
	setBarcode(TRUE);//ʹ��һά����

    SetBeepTime(100);//ʶ���ɹ��� �����÷���ʱ�䣨ms��

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
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

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CMy532DemoDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CMy532DemoDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}






//RC532Ϊ�û��ṩ���ֻ�ȡ������Ϣ�ķ�ʽ����1������Ϣ�ķ�ʽ��mesgIDΪ123���û�������Ҫʱ������Ϣ��
//��Ϣ����WPARAM������Ϣ����, LPARAM������Ϣ���ȡ�
afx_msg LRESULT CMy532DemoDlg::GetDecodeStr(WPARAM wParam, LPARAM lParam)
{
	setQRable(false);
	setBarcode(false);
	
	BYTE* pbyDecodedMessage =(BYTE*)wParam;
	CString temp;
	temp=pbyDecodedMessage;
    m_edit2.SetWindowText(temp);
	//�˴����ƽ���������Sleepʱ��
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
//��2��ֱ�ӵ��ýӿں���GetDecodeString(char *aa)��ÿ����һ��GetDecodeString
//ȡ�ý�����Ϣ�󣬺������Զ���ս�����Ϣ���ڴ棬�ȴ�����´ν�����Ϣ��
//����ͨ����ť���ƽ��պ���
void CMy532DemoDlg::OnButtonGetStr()
{
	char strRsult[2000];
	int lenth;
	//����DLL�������ս�����Ϣ
	setQRable(false);
	setBarcode(false);
	int ret=GetDecodeString(strRsult,lenth);
    CString temp=strRsult;
	m_edit1.SetWindowText(temp);
	Sleep(1000);
	setQRable(true);
	setBarcode(true);
}
//��ս�����Ϣ
void CMy532DemoDlg::OnBnClickedButton2()

{
	m_edit1.SetWindowText("");
	m_edit2.SetWindowText("");
}

//�˳�ʱҪ����DLL��ReleaseDevice()��������������ȫ�ر�Ӳ��
void CMy532DemoDlg::OnBnClickedOk()
{
	 ReleaseDevice();
	 PostMessage(WM_CLOSE);  
	 CDialogEx::OnOK();
}

//�˳�ʱҪ����DLL��ReleaseDevice()��������������ȫ�ر�Ӳ��
void CMy532DemoDlg::OnClose()
{
	ReleaseDevice();
	CDialogEx::OnClose();
}
