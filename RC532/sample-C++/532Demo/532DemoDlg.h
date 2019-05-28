
// 532DemoDlg.h : 头文件
//

#pragma once


// CMy532DemoDlg 对话框
class CMy532DemoDlg : public CDialogEx
{
// 构造
public:
	CMy532DemoDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_MY532DEMO_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	BOOL bDM;
	BOOL bQR;
	BOOL bHX;
	BOOL bBarcode;
	int isRun;
	CEdit m_edit2;
	CEdit m_edit1;
	afx_msg void OnButtonGetStr();
protected:
	afx_msg LRESULT GetDecodeStr(WPARAM wParam, LPARAM lParam);
	afx_msg LRESULT MessageReleaseCamera(WPARAM wParam, LPARAM lParam);
public:
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedOk();
	afx_msg void OnClose();
};
