Attribute VB_Name = "Module1"
Option Explicit
Declare Function StartDevice Lib "dll_camera.dll" () As Long   '启动设备
Declare Sub ReleaseDevice Lib "dll_camera.dll" ()        '释放设备
Declare Sub setQRable Lib "dll_camera.dll" (ByVal bqr As Long)   '启动QR识别引擎
Declare Sub setDMable Lib "dll_camera.dll" (ByVal bdm As Long)    '启动DM识别引擎
Declare Sub setBarcode Lib "dll_camera.dll" (ByVal bbarcode As Long)  '启动一维码识别引擎
Declare Sub SetBeepTime Lib "dll_camera.dll" (ByVal BeepTime As Long)    '设置 蜂鸣时间 单位：ms
Declare Sub SetBeep Lib "dll_camera.dll" (ByVal bar As Long)
Declare Function GetDecodeString Lib "dll_camera.dll" (ByRef bytByte As Byte, ByRef nlen As Long) As Long   '获取解码信息的指针
Declare Function GetDevice Lib "dll_camera.dll" () As Long     '查找设备  1 表示成功 -1表示失败
Declare Sub ReleaseLostDevice Lib "dll_camera.dll" ()      '人为拔出设备时，需要释放的摄像头资源

Public Function ByteToStr(B() As Byte) As String                                'Byte数组转字符串
    Dim I, Tmp As String
    For Each I In B                                                             '枚举整个数组赋值给I
        If I > 127 Then                                                         '如果为汉字编码.(大于127为汉字,占两个字节)
            If Tmp <> "" Then                                                   '如果临时变量不为空(为空为第一字节)
                ByteToStr = ByteToStr & Chr(Tmp * 256 + I)                      '合并两个字节,转换为汉字.累加数据
                Tmp = ""                                                        '清空临时变量
            Else
                Tmp = I                                                         '储存临时变量
            End If
        Else
            ByteToStr = ByteToStr & Chr(I)                                      '转换为汉字,累加数据
        End If
    Next
End Function
