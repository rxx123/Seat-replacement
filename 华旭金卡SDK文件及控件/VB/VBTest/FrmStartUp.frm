VERSION 5.00
Begin VB.Form FrmStartup 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "第二代居民身份证验证系统"
   ClientHeight    =   4245
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7470
   Icon            =   "FrmStartUp.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4245
   ScaleWidth      =   7470
   Begin VB.Frame Frame4 
      Appearance      =   0  'Flat
      Caption         =   "端口选择"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2055
      Left            =   2160
      TabIndex        =   8
      Top             =   120
      Width           =   2175
      Begin VB.ComboBox Combo2 
         Height          =   300
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   1320
         Width           =   1215
      End
      Begin VB.OptionButton Option2 
         Caption         =   "USB口"
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   1320
         Width           =   855
      End
      Begin VB.OptionButton Option1 
         Caption         =   "串口"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   600
         Value           =   -1  'True
         Width           =   735
      End
      Begin VB.ComboBox Combo1 
         Height          =   300
         ItemData        =   "FrmStartUp.frx":030A
         Left            =   840
         List            =   "FrmStartUp.frx":030C
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   600
         Width           =   1215
      End
   End
   Begin VB.Frame Frame5 
      Appearance      =   0  'Flat
      Caption         =   "波特率"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2055
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   1935
      Begin VB.OptionButton Option6 
         Caption         =   "115200"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Value           =   -1  'True
         Width           =   1095
      End
      Begin VB.OptionButton Option7 
         Caption         =   "57600"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   855
      End
      Begin VB.OptionButton Option8 
         Caption         =   "38400"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   960
         Width           =   855
      End
      Begin VB.OptionButton Option9 
         Caption         =   "19200"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   1320
         Width           =   855
      End
      Begin VB.OptionButton Option10 
         Caption         =   "9600"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   1680
         Width           =   735
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   "确认"
      Height          =   495
      Left            =   1200
      TabIndex        =   1
      Top             =   2280
      Width           =   855
   End
   Begin VB.CommandButton Command2 
      Caption         =   "退出"
      Height          =   495
      Left            =   2160
      TabIndex        =   0
      Top             =   2280
      Width           =   855
   End
End
Attribute VB_Name = "FrmStartup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
 Dim SamRet As Integer
 Dim Baud As Long
 Dim BaudSet As Long
 Dim SamStr As String

 SamStr = Space(100)
 
 
 If Option1.Value = True Then
    If Option6.Value = True Then
        BaudRate = 115200
    ElseIf Option7.Value = True Then
        BaudRate = 57600
    ElseIf Option8.Value = True Then
        BaudRate = 38400
    ElseIf Option9.Value = True Then
        BaudRate = 19200
    ElseIf Option10.Value = True Then
        BaudRate = 9600
    End If
    PortFlag = CLng(Combo1.ListIndex + 1)
    SamRet = SDT_GetCOMBaud(PortFlag, Baud)
    If SamRet = &H90 Then
    ElseIf SamRet = 5 Then
        MsgBox "请查看端口选择是否正确", vbExclamation + vbOKOnly, App.Title
        Exit Sub
    Else
        MsgBox "取串口波特率失败", vbExclamation + vbOKOnly, App.Title
        Exit Sub
    End If
        
    SamRet = SDT_SetCOMBaud(PortFlag, Baud, BaudRate)
        
    If SamRet = &H90 Then
    Else
        MsgBox "设置串口波特率失败", vbExclamation + vbOKOnly, App.Title
        Exit Sub
    End If
         
    Sleep (500)
    SamRet = SDT_GetSAMIDToStr(PortFlag, SamStr, 1)
    If SamRet = &H90 Then
        MDIForm1.StatusBar1.Panels(1).Text = "安全模块编号:" & FilterStr(SamStr)
        MDIForm1.StatusBar1.Panels(2).Text = "安全模块状态:正常"
    End If
    
 Else
    PortFlag = CLng(Combo2.ListIndex + 1 + 1000)
 End If
 
 '打开端口
 SamRet = SDT_OpenPort(PortFlag)
 If SamRet <> &H90 Then
        MsgBox "端口选择错误或设备没有连接，请重试", vbExclamation + vbOKOnly, App.Title
        Exit Sub
 Else
    PortOpenFlag = True
    SDT_ClosePort (PortFlag)
    MsgBox "打开端口成功", vbInformation + vbOKOnly, App.Title
    Unload Me
 End If
 
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Form_Load()
Combo1.AddItem "1--COM1"
Combo1.AddItem "2--COM2"
Combo1.AddItem "3--COM3"
Combo1.AddItem "4--COM4"
Combo1.AddItem "5--COM5"
Combo1.AddItem "6--COM6"
Combo1.AddItem "7--COM7"
Combo1.AddItem "8--COM8"
Combo1.AddItem "9--COM9"
Combo1.AddItem "10--COM10"
Combo1.AddItem "11--COM11"
Combo1.AddItem "12--COM12"
Combo1.AddItem "13--COM13"
Combo1.AddItem "14--COM14"
Combo1.AddItem "15--COM15"
Combo1.AddItem "16--COM16"
Combo1.ListIndex = 0


Combo2.AddItem "1--USB1"
Combo2.AddItem "2--USB2"
Combo2.AddItem "3--USB3"
Combo2.AddItem "4--USB4"
Combo2.AddItem "5--USB5"
Combo2.AddItem "6--USB6"
Combo2.AddItem "7--USB7"
Combo2.AddItem "8--USB8"
Combo2.AddItem "9--USB9"
Combo2.AddItem "10--USB10"
Combo2.AddItem "11--USB11"
Combo2.AddItem "12--USB12"
Combo2.AddItem "13--USB13"
Combo2.AddItem "14--USB14"
Combo2.AddItem "15--USB15"
Combo2.AddItem "16--USB16"
    Me.Left = MDIForm1.Width / 4
    Me.Top = MDIForm1.Height / 4
End Sub

Private Sub Option1_Click()
Frame5.Enabled = True
Option6.Enabled = True
Option7.Enabled = True
Option8.Enabled = True
Option9.Enabled = True
Option10.Enabled = True
End Sub

Private Sub Option10_Click()
    BaudRate = 9600
End Sub


Private Sub Option2_Click()
Frame5.Enabled = False
Option6.Enabled = False
Option7.Enabled = False
Option8.Enabled = False
Option9.Enabled = False
Option10.Enabled = False
End Sub

Private Sub Option6_Click()
    BaudRate = 115200
End Sub

Private Sub Option7_Click()
    BaudRate = 57600
End Sub

Private Sub Option8_Click()
    BaudRate = 38400
End Sub

Private Sub Option9_Click()
    BaudRate = 19200
End Sub



