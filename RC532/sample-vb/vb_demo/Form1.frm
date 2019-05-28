VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3855
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   8955
   LinkTopic       =   "Form1"
   ScaleHeight     =   3855
   ScaleWidth      =   8955
   StartUpPosition =   3  '窗口缺省
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   375
      Left            =   5760
      TabIndex        =   2
      Top             =   2400
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "退出"
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Top             =   2400
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   1095
      Left            =   840
      TabIndex        =   0
      Top             =   600
      Width           =   7575
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   720
      Top             =   2160
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private bytByte(0 To 2000) As Byte
Private Sub Command1_Click()
ReleaseLostDevice
Unload Me
End Sub

Private Sub Command2_Click()
GetDecodeString bytByte(0), nlen
Text1 = Text1 + ByteToStr(bytByte)
End Sub

Private Sub Form_Load()
'查找设备
    If GetDevice = 1 Then
        If StartDevice = 1 Then '启动设备
         setQRable 1             '启动QR引擎
         SetBeep 1
         SetBeepTime 100        '设置扫描蜂鸣声
         Else
             MsgBox "启动设备失败"
         End If
        
    Else
        MsgBox "获取设备失败"
    End If
End Sub

'间隔1秒
Private Sub Timer1_Timer()
GetDecodeString bytByte(0), nlen
Text1 = Text1 + ByteToStr(bytByte)
setQRable 1
End Sub
