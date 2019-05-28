Attribute VB_Name = "Module1"
Public Declare Function SDT_ResetSAM Lib "sdtapi.dll" (ByVal IPort As Integer, ByVal iState As Integer) As Integer
Public Declare Function SDT_GetSAMStatus Lib "sdtapi.dll" (ByVal IPort As Integer, ByVal iState As Integer) As Integer
Public Declare Function SDT_GetSAMID Lib "sdtapi.dll" (ByVal IPort As Integer, ByRef OutData As Any, ByVal iState As Integer) As Integer
Public Declare Function SDT_GetSAMIDToStr Lib "sdtapi.dll" (ByVal IPort As Integer, ByVal OutData As String, ByVal iState As Integer) As Integer
Public Declare Function SDT_SetMaxRFByte Lib "sdtapi.dll" (ByVal IPort As Integer, ByVal ByteI As Byte, ByVal iState As Integer) As Integer
Public Declare Function SDT_StartFindIDCard Lib "sdtapi.dll" (ByVal IPort As Integer, ByRef OutData As Any, ByVal iState As Integer) As Integer
Public Declare Function SDT_SelectIDCard Lib "sdtapi.dll" (ByVal IPort As Integer, ByRef OutData As Any, ByVal iState As Integer) As Integer
Public Declare Function SDT_ReadBaseMsg Lib "sdtapi.dll" (ByVal IPort As Integer, ByRef CHMsg As Any, ByRef CHMsgLen As Long, ByRef PHMSg As Any, ByRef PHMsgLen As Long, ByVal iState As Integer) As Integer
Public Declare Function SDT_ReadMngInfo Lib "sdtapi.dll" (ByVal IPort As Integer, ByRef pucSNDN As Any, ByVal iState As Integer) As Integer
Public Declare Function SDT_ReadNewAppMsg Lib "sdtapi.dll" (ByVal IPort As Integer, ByRef FPMsg As Any, ByRef FPMsgLen As Integer, ByVal iState As Integer) As Integer
Public Declare Function SDT_OpenPort Lib "sdtapi.dll" (ByVal IPort As Integer) As Integer
Public Declare Function SDT_ClosePort Lib "sdtapi.dll" (ByVal IPort As Integer) As Integer
Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Function SDT_GetCOMBaud Lib "sdtapi.dll" (ByVal IPort As Integer, ByRef Baud As Long) As Integer
Public Declare Function SDT_SetCOMBaud Lib "sdtapi.dll" (ByVal IPort As Integer, ByVal BaudCur As Long, ByVal BaudSet As Long) As Integer

Public Declare Function GetBmp Lib "WltRS.dll" (ByVal file_name As String, ByVal Port As Integer) As Integer
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Declare Function DeleteFile Lib "kernel32" Alias "DeleteFileA" (ByVal lpFileName As String) As Long

Public Declare Function CopyFile Lib "kernel32" Alias "CopyFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal bFailIfExists As Long) As Long
Public Declare Function DeleteMetaFile Lib "gdi32" (ByVal hMF As Long) As Long

Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Declare Function CopyFilee Lib "kernel32" Alias "CopyFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal bFailIfExists As Long) As Long
Public Const SW_SHOWNORMAL = 1
Public Const SW_SHOWMAXIMIZED = 3
Public Const SW_SHOWDEFAULT = 10
Public Const SW_SHOW = 5

Public Declare Function GetFileAttributes Lib "kernel32" Alias "GetFileAttributesA" (ByVal lpFileName As String) As Long
Public Declare Function SetFileAttributes Lib "kernel32" Alias "SetFileAttributesA" (ByVal lpFileName As String, ByVal dwFileAttributes As Long) As Long
Public Const FILE_ATTRIBUTE_ARCHIVE = &H20
Public Const FILE_ATTRIBUTE_COMPRESSED = &H800
Public Const FILE_ATTRIBUTE_DIRECTORY = &H10
Public Const FILE_ATTRIBUTE_HIDDEN = &H2
Public Const FILE_ATTRIBUTE_NORMAL = &H80
Public Const FILE_ATTRIBUTE_READONLY = &H1
Public Const FILE_ATTRIBUTE_SYSTEM = &H4
Public Const FILE_ATTRIBUTE_TEMPORARY = &H100



Public PortFlag As Long
Public BaudRate As Long
Public StopFlag As Boolean
Public PortOpenFlag As Boolean
Public FileNo As Integer
Public filepath As String

Public SqlPolarityPrn As New ADODB.Connection
Public PolPrnConStr As String
Public SFZ_Number As String
Public SFZ_Name As String
Public SFZ_Sex As String
Public SFZ_MinZ As String
Public SFZ_Address As String
Public SFZ_YXQXS As Date
Public SFZ_YXQXE As Date
Public SFZ_CSRQ As Date
Public SFZ_AppAddress As String
Public SFZ_FZJG As String
Public SamStrId As String
Public Const VerStr = "V5.5"

Public SamStr As String


Public p_Name As String
Public p_Sex As String
Public p_MinZ As String
Public p_CSDate As Date
Public p_Address As String
Public p_Number As String
Public sfzscdate As String
Public P_qfjg As String
Public p_yqrq As String
Public delte_flag As Integer







Public Function DisZPErr(ByVal Ret As Integer) As String
Select Case Ret
    Case 0
        DisZPErr = "调用sdtapi.dll错误"
    Case -1
        DisZPErr = "相片解码错误"
    Case -2
        DisZPErr = "wlt文件后缀错误"
    Case -3
        DisZPErr = "wlt文件打开错误"
    Case -4
         DisZPErr = "wlt文件格式错误"
    Case -5
        DisZPErr = "软件未授权"
    Case -6
        DisZPErr = "设备连接错误"
End Select
End Function

Public Function FilterStr(str_Src As String) As String
    Dim str_Ret As String
    Dim AscCode As Integer
    
    For i = 1 To Len(str_Src)
        AscCode = Asc(Mid$(str_Src, i, 1))
        If (AscCode <> 9 And AscCode <> 13 And AscCode <> 10 And AscCode <> 32 And AscCode <> 0 And AscCode <> -24159) Then
            str_Ret = str_Ret & Chr$(AscCode)
        End If
    Next i
        
    FilterStr = str_Ret
End Function



Public Function ReturnNational(TmpData() As Byte) As String
If TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 49 And TmpData(4) = 0 Then '01
    ReturnNational = "汉族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 50 And TmpData(4) = 0 Then '02
    ReturnNational = "蒙族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 51 And TmpData(4) = 0 Then '03
    ReturnNational = "回族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 52 And TmpData(4) = 0 Then '04
    ReturnNational = "藏族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 53 And TmpData(4) = 0 Then '05
    ReturnNational = "维吾尔族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 54 And TmpData(4) = 0 Then '06
    ReturnNational = "苗族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 55 And TmpData(4) = 0 Then '07
    ReturnNational = "彝族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 56 And TmpData(4) = 0 Then '08
    ReturnNational = "壮族"
ElseIf TmpData(1) = 48 And TmpData(2) = 0 And TmpData(3) = 57 And TmpData(4) = 0 Then '09
    ReturnNational = "布依族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 48 And TmpData(4) = 0 Then '10
    ReturnNational = "朝鲜族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 49 And TmpData(4) = 0 Then '11
    ReturnNational = "满族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 50 And TmpData(4) = 0 Then '12
    ReturnNational = "侗族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 51 And TmpData(4) = 0 Then '13
    ReturnNational = "瑶族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 52 And TmpData(4) = 0 Then '14
    ReturnNational = "白族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 53 And TmpData(4) = 0 Then '15
    ReturnNational = "土家族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 54 And TmpData(4) = 0 Then '16
    ReturnNational = "哈尼族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 55 And TmpData(4) = 0 Then '17
    ReturnNational = "哈萨克族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 56 And TmpData(4) = 0 Then '18
    ReturnNational = "傣族"
ElseIf TmpData(1) = 49 And TmpData(2) = 0 And TmpData(3) = 57 And TmpData(4) = 0 Then '19
    ReturnNational = "黎族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 48 And TmpData(4) = 0 Then '20
    ReturnNational = "傈僳族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 49 And TmpData(4) = 0 Then '21
    ReturnNational = "佤族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 50 And TmpData(4) = 0 Then '22
    ReturnNational = "畲族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 51 And TmpData(4) = 0 Then '23
    ReturnNational = "高山族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 52 And TmpData(4) = 0 Then '24
    ReturnNational = "拉祜族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 53 And TmpData(4) = 0 Then '25
    ReturnNational = "水族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 54 And TmpData(4) = 0 Then '26
    ReturnNational = "东乡族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 55 And TmpData(4) = 0 Then '27
    ReturnNational = "纳西族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 56 And TmpData(4) = 0 Then '28
    ReturnNational = "景颇族"
ElseIf TmpData(1) = 50 And TmpData(2) = 0 And TmpData(3) = 57 And TmpData(4) = 0 Then '29
    ReturnNational = "柯尔克孜族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 48 And TmpData(4) = 0 Then '30
    ReturnNational = "土族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 49 And TmpData(4) = 0 Then '31
    ReturnNational = "达斡尔族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 50 And TmpData(4) = 0 Then '32
    ReturnNational = "仫佬族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 51 And TmpData(4) = 0 Then '33
    ReturnNational = "羌族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 52 And TmpData(4) = 0 Then '34
    ReturnNational = "布朗族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 53 And TmpData(4) = 0 Then '35
    ReturnNational = "撒拉族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 54 And TmpData(4) = 0 Then '36
    ReturnNational = "毛南族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 55 And TmpData(4) = 0 Then '37
    ReturnNational = "仡佬族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 56 And TmpData(4) = 0 Then '38
    ReturnNational = "锡伯族"
ElseIf TmpData(1) = 51 And TmpData(2) = 0 And TmpData(3) = 57 And TmpData(4) = 0 Then '39
    ReturnNational = "阿昌族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 48 And TmpData(4) = 0 Then '40
    ReturnNational = "普米族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 49 And TmpData(4) = 0 Then '41
    ReturnNational = "塔吉克族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 50 And TmpData(4) = 0 Then '42
    ReturnNational = "怒族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 51 And TmpData(4) = 0 Then '43
    ReturnNational = "乌孜别克族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 52 And TmpData(4) = 0 Then '44
    ReturnNational = "俄罗斯族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 53 And TmpData(4) = 0 Then '45
    ReturnNational = "鄂温克族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 54 And TmpData(4) = 0 Then '46
    ReturnNational = "德昂族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 55 And TmpData(4) = 0 Then '47
    ReturnNational = "保安族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 56 And TmpData(4) = 0 Then '48
    ReturnNational = "裕固族"
ElseIf TmpData(1) = 52 And TmpData(2) = 0 And TmpData(3) = 57 And TmpData(4) = 0 Then '49
    ReturnNational = "京族"
ElseIf TmpData(1) = 53 And TmpData(2) = 0 And TmpData(3) = 48 And TmpData(4) = 0 Then '50
    ReturnNational = "塔塔尔族"
ElseIf TmpData(1) = 53 And TmpData(2) = 0 And TmpData(3) = 49 And TmpData(4) = 0 Then '51
    ReturnNational = "独龙族"
ElseIf TmpData(1) = 53 And TmpData(2) = 0 And TmpData(3) = 50 And TmpData(4) = 0 Then '52
    ReturnNational = "鄂伦春族"
ElseIf TmpData(1) = 53 And TmpData(2) = 0 And TmpData(3) = 51 And TmpData(4) = 0 Then '53
    ReturnNational = "赫哲族"
ElseIf TmpData(1) = 53 And TmpData(2) = 0 And TmpData(3) = 52 And TmpData(4) = 0 Then '54
    ReturnNational = "门巴族"
ElseIf TmpData(1) = 53 And TmpData(2) = 0 And TmpData(3) = 53 And TmpData(4) = 0 Then '55
    ReturnNational = "珞巴族"
ElseIf TmpData(1) = 53 And TmpData(2) = 0 And TmpData(3) = 54 And TmpData(4) = 0 Then '56
    ReturnNational = "基诺族"

Else
    ReturnNational = StrConv(TmpData, vbWide)
End If

End Function
