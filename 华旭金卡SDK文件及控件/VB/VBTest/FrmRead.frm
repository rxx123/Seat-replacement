VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FrmRead 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "第二代居民身份证验证系统"
   ClientHeight    =   7455
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9870
   Icon            =   "FrmRead.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7455
   ScaleWidth      =   9870
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9120
      Top             =   5880
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmRead.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmRead.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmRead.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmRead.frx":1000
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton CmdExit 
      Caption         =   "退出"
      Height          =   495
      Left            =   5160
      TabIndex        =   11
      Top             =   6600
      Width           =   855
   End
   Begin VB.CommandButton CmdReadCard 
      Caption         =   "读卡"
      Height          =   495
      Left            =   3600
      TabIndex        =   10
      Top             =   6600
      Width           =   855
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   7080
      Width           =   9870
      _ExtentX        =   17410
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   7832
            MinWidth        =   7832
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4304
            MinWidth        =   4304
            Text            =   "电话：010－51616789"
            TextSave        =   "电话：010－51616789"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   5168
            MinWidth        =   5009
            Text            =   "网址：www.hxgc.com.cn"
            TextSave        =   "网址：www.hxgc.com.cn"
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Image Image3 
      Height          =   1095
      Left            =   9120
      Top             =   4920
      Width           =   615
   End
   Begin VB.Image Image2 
      Height          =   1575
      Left            =   7440
      Top             =   1440
      Width           =   1335
   End
   Begin VB.Label Label18 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label18"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   210
      Left            =   2400
      TabIndex        =   9
      Top             =   5640
      Width           =   735
   End
   Begin VB.Label Label17 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label17"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   210
      Left            =   2400
      TabIndex        =   8
      Top             =   5280
      Width           =   735
   End
   Begin VB.Label Label16 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label16"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   210
      Left            =   2400
      TabIndex        =   7
      Top             =   4920
      Width           =   735
   End
   Begin VB.Label Label12 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label12"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   210
      Left            =   3240
      TabIndex        =   6
      Top             =   3840
      Width           =   735
   End
   Begin VB.Label Label10 
      BackStyle       =   0  'Transparent
      Caption         =   "Label10"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   810
      Left            =   1920
      TabIndex        =   5
      Top             =   2760
      Width           =   5655
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label8"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   210
      Left            =   1920
      TabIndex        =   4
      Top             =   2280
      Width           =   630
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "Label6"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   3600
      TabIndex        =   3
      Top             =   1800
      Width           =   975
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "Label4"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   1920
      TabIndex        =   2
      Top             =   1800
      Width           =   975
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label2"
      BeginProperty Font 
         Name            =   "宋体"
         Size            =   10.5
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   210
      Left            =   1920
      TabIndex        =   1
      Top             =   1320
      Width           =   630
   End
   Begin VB.Image Image1 
      Height          =   6570
      Left            =   0
      Picture         =   "FrmRead.frx":1452
      Top             =   0
      Width           =   9870
   End
End
Attribute VB_Name = "FrmRead"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub CmdExit_Click()
    StopFlag = True
    Unload Me
End Sub
Private Sub ClearDisp()
    Label2.Caption = ""
    Label4.Caption = ""
    Label6.Caption = ""
    Label8.Caption = ""
    Label10.Caption = ""
    Label12.Caption = ""
    Label16.Caption = ""
    Label17.Caption = ""
    Label18.Caption = ""

    StatusBar1.Panels(1).Text = ""
    Image2.Picture = LoadPicture("")

End Sub

Private Sub cmdOpenPort_Click()

End Sub

Private Sub CmdReadCard_Click()
    If PortOpenFlag = False Then
        MsgBox "请首先打开端口", vbExclamation + vbOKOnly, App.Title
        Exit Sub
    End If
    

    ClearDisp

    
  
    Dim CardPUCIIN(1 To 16) As Byte
    Dim CardPUCSN(1 To 16) As Byte
    Dim CardAppInfo(1 To 300) As Byte
    
    Dim CardCHMsgLen As Long
    Dim CardPHMsgLen As Long
    Dim TmpCHMsg(1 To 256) As Byte
    Dim TmpPHMsg(1 To 1024) As Byte
    Dim CardAppInfoLen As Integer
    Dim BmpFileH As Long
    
    Dim TmpData() As Byte
    Dim SamRet As Integer
    
    Dim TmpStr As String

    TmpStr = ""
    TmpStr = Space(255)
    

   

    
        

    
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
FindCard:

    StatusBar1.Panels(1).Picture = ImageList1.ListImages(1).Picture
    Sleep (50)
    'StatusBar1.Panels(1).Text = ""
    
    
    StatusBar1.Panels(1).Picture = ImageList1.ListImages(2).Picture
    SamRet = SDT_StartFindIDCard(PortFlag, CardPUCIIN(1), 1)

    If SamRet <> &H9F Then
        'StatusBar1.Panels(1).Text = "请重新放置身份证......"
        'StatusBar1.Panels(1).Picture = ImageList1.ListImages(3).Picture
        'Exit Sub
        SDT_ClosePort (PortFlag)
        SamRet = SDT_OpenPort(PortFlag)
       
    End If
      

    SamRet = SDT_SelectIDCard(PortFlag, CardPUCSN(1), 1)

    
    StatusBar1.Panels(1).Picture = ImageList1.ListImages(3).Picture
     
    SamRet = SDT_ReadBaseMsg(PortFlag, TmpCHMsg(1), CardCHMsgLen, TmpPHMsg(1), CardPHMsgLen, 1)
            
            
            If SamRet <> &H90 Then
                Sleep (150)
                StatusBar1.Panels(1).Text = "请重新放置身份证......"
                Exit Sub
            Else   '信息处理

                
               BmpFileH = FreeFile
                Open App.Path & "\BaseInfo.txt" For Binary Access Write As #BmpFileH
                Put #BmpFileH, , TmpCHMsg()
                Close #BmpFileH
            
                BmpFileH = FreeFile
                Open App.Path & "\Picture.wlt" For Binary Access Write As #BmpFileH
                Put #BmpFileH, , TmpPHMsg()
                Close #BmpFileH
                
                Dim TmpPos As Long
                TmpPos = 0
                ReDim TmpData(1 To 30)
                CopyMemory TmpData(1), TmpCHMsg(1), 30
                Label2.Caption = StrConv(TmpData, vbWide)    '姓名
                
                
                TmpPos = 31
                ReDim TmpData(1 To 2)
                CopyMemory TmpData(1), TmpCHMsg(TmpPos), 2

                If TmpData(1) = 49 Then
                    Label4.Caption = "男"
                ElseIf TmpData(1) = 50 Then
                    Label4.Caption = "女"
                Else
                    Label4.Caption = "其他"
                End If
               
              
                TmpPos = 33
                ReDim TmpData(1 To 4)
                CopyMemory TmpData(1), TmpCHMsg(TmpPos), 4
                Label6.Caption = ReturnNational(TmpData())
                 
                TmpPos = 37
                
                ReDim TmpData(1 To 16)
                CopyMemory TmpData(1), TmpCHMsg(TmpPos), 16
                TmpStr = StrConv(TmpData, vbWide)
                
                SFZ_CSRQ = CDate(Left(TmpStr, 4) + "-" + Mid(TmpStr, 5, 2) + "-" + Right(TmpStr, 2))
                Label8.Caption = Left(TmpStr, 4) + "年" + Mid(TmpStr, 5, 2) + "月" + Right(TmpStr, 2) + "日" '出生日期
                 
                TmpPos = 53
                ReDim TmpData(1 To 70)
                CopyMemory TmpData(1), TmpCHMsg(TmpPos), 70
                Label10.Caption = StrConv(TmpData, vbWide)   '家庭住址
                
                 
                TmpPos = 123
                ReDim TmpData(1 To 36)
                CopyMemory TmpData(1), TmpCHMsg(TmpPos), 36
                Label12.Caption = StrConv(TmpData, vbWide)   '身份证号码
                
                
                TmpPos = 159
                ReDim TmpData(1 To 30)
                CopyMemory TmpData(1), TmpCHMsg(TmpPos), 30
                Label16.Caption = StrConv(TmpData, vbWide)
                
                 
                TmpPos = 189
                ReDim TmpData(1 To 32)
                CopyMemory TmpData(1), TmpCHMsg(TmpPos), 32
                TmpStr = StrConv(TmpData, vbWide)
                TmpStr = FilterStr(TmpStr)
                SFZ_YXQXS = CDate(Left(TmpStr, 4) + "-" + Mid(TmpStr, 5, 2) + "-" + Mid(TmpStr, 7, 2))
                
                If Len(TmpStr) < 16 Then
                    Dim TmpEndD As String
                    TmpEndD = Right(TmpStr, Len(TmpStr) - 8)
                    Label17.Caption = Left(TmpStr, 4) + " 年 " + Mid(TmpStr, 5, 2) + " 月 " + Mid(TmpStr, 7, 2) + " 日 " + " 至 " + TmpEndD
                    SFZ_YXQXE = CDate("3000-12-31")
                Else
                    Label17.Caption = Left(TmpStr, 4) + " 年 " + Mid(TmpStr, 5, 2) + " 月 " + Mid(TmpStr, 7, 2) + " 日 " + " 至 " + Mid(TmpStr, 9, 4) + " 年 " + Mid(TmpStr, 13, 2) + " 月 " + Right(TmpStr, 2) + " 日 "
                    SFZ_YXQXE = CDate(Mid(TmpStr, 9, 4) + "-" + Mid(TmpStr, 13, 2) + "-" + Right(TmpStr, 2))
                    
                End If

                
                
                FileNo = 0
FindRightTermb:
                
                If PortFlag > 0 And PortFlag < 17 Then
                    SamRet = GetBmp(App.Path & "\Picture.wlt", 1)
                Else
                    SamRet = GetBmp(App.Path & "\Picture.wlt", 2)
                End If
                    Image2.Visible = True
                If SamRet = 1 Then
                    Image2.Picture = LoadPicture(App.Path & "\Picture.bmp")
                    Image2.Refresh
                 StatusBar1.Panels(1).Text = "读取身份证信息成功......"
                    '读追加地址信息
                    'StatusBar1.Panels(1).Text = "正在读取最新地址信息......"
                    SamRet = SDT_ReadNewAppMsg(PortFlag, CardAppInfo(1), CardAppInfoLen, 1)
                    If SamRet = 144 Then
                       Label18.Caption = FilterStr(StrConv(CardAppInfo, vbWide))
                    Else
                       Label18.Caption = ""
                       'StatusBar1.Panels(1).Text = "无最新地址......"
                       Sleep (50)
                    End If
                    SFZ_Number = FilterStr(Label12.Caption)
                    SFZ_Name = FilterStr(Label2.Caption)
                    SFZ_Sex = FilterStr(Label4.Caption)
                    SFZ_MinZ = FilterStr(Label6.Caption)
                    SFZ_Address = FilterStr(Label10.Caption)
                    SFZ_FZJG = FilterStr(Label16.Caption)
                    If Label18.Caption = "" Then
                        SFZ_AppAddress = "空"
                    Else
                        SFZ_AppAddress = Label18.Caption
                    End If
                    
                     ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''写入可显示的文本文件
                     BmpFileH = FreeFile
                     Open App.Path & "\TmpTxt.txt" For Output As #BmpFileH
                     Write #BmpFileH, SFZ_Number
                     Write #BmpFileH, SFZ_Name
                     Write #BmpFileH, SFZ_Sex
                     Write #BmpFileH, SFZ_MinZ
                     Write #BmpFileH, SFZ_Address
                     Write #BmpFileH, SFZ_FZJG
                     Write #BmpFileH, SFZ_AppAddress
                     Write #BmpFileH, CStr(SFZ_CSRQ)
                     Write #BmpFileH, CStr(SFZ_YXQXS)
                     Write #BmpFileH, CStr(SFZ_YXQXE)
                     Close #BmpFileH
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''写入可显示的文本文件
                    

                Else
                    StatusBar1.Panels(1).Text = "正在进行照片解密......"
                    'If (CopyTermFile(FileNo) = 1) Then
                        FileNo = FileNo + 1
                        GoTo FindRightTermb
                    'Else
                       ' StopFlag = True
                        Exit Sub
                    'End If
                End If
               ' StatusBar1.Panels(1).Text = "读卡成功"
                'Sleep (50)

            End If


 
End Sub

Private Sub Command1_Click() '读取追加地址信息
    
    
End Sub

Private Sub Form_Load()

    SFZ_Number = ""
    SFZ_Name = ""
    SFZ_Sex = ""
    SFZ_MinZ = ""
    SFZ_Address = ""
    SFZ_FZJG = ""
            
    SFZ_CSRQ = CDate("1900-01-01")
    SFZ_YXQXS = CDate("1900-01-01")
    SFZ_YXQXE = CDate("1900-01-01")
    Label2.Caption = ""
    Label4.Caption = ""
    Label6.Caption = ""
    Label8.Caption = ""
    Label10.Caption = ""
    Label12.Caption = ""
    Label16.Caption = ""
    Label17.Caption = ""
    Label18.Caption = ""
    StopFlag = False
    BaudRate = 115200
    StatusBar1.Panels(1).Text = "等待读卡......"
    Me.Left = MDIForm1.Left + 1000
    Me.Top = MDIForm1.Top + 1000
    
    StatusBar1.Panels(1).Picture = ImageList1.ListImages(4).Picture
    SamRet = SDT_SetMaxRFByte(PortFlag, 250, 1)
    If SamRet <> &H90 Then

        StatusBar1.Panels(1).Text = "设置射频适配器最大通信字节数失败"
        Exit Sub
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    StopFlag = True
    MDIForm1.WindowState = 2
End Sub

