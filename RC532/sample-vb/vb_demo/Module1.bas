Attribute VB_Name = "Module1"
Option Explicit
Declare Function StartDevice Lib "dll_camera.dll" () As Long   '�����豸
Declare Sub ReleaseDevice Lib "dll_camera.dll" ()        '�ͷ��豸
Declare Sub setQRable Lib "dll_camera.dll" (ByVal bqr As Long)   '����QRʶ������
Declare Sub setDMable Lib "dll_camera.dll" (ByVal bdm As Long)    '����DMʶ������
Declare Sub setBarcode Lib "dll_camera.dll" (ByVal bbarcode As Long)  '����һά��ʶ������
Declare Sub SetBeepTime Lib "dll_camera.dll" (ByVal BeepTime As Long)    '���� ����ʱ�� ��λ��ms
Declare Sub SetBeep Lib "dll_camera.dll" (ByVal bar As Long)
Declare Function GetDecodeString Lib "dll_camera.dll" (ByRef bytByte As Byte, ByRef nlen As Long) As Long   '��ȡ������Ϣ��ָ��
Declare Function GetDevice Lib "dll_camera.dll" () As Long     '�����豸  1 ��ʾ�ɹ� -1��ʾʧ��
Declare Sub ReleaseLostDevice Lib "dll_camera.dll" ()      '��Ϊ�γ��豸ʱ����Ҫ�ͷŵ�����ͷ��Դ

Public Function ByteToStr(B() As Byte) As String                                'Byte����ת�ַ���
    Dim I, Tmp As String
    For Each I In B                                                             'ö���������鸳ֵ��I
        If I > 127 Then                                                         '���Ϊ���ֱ���.(����127Ϊ����,ռ�����ֽ�)
            If Tmp <> "" Then                                                   '�����ʱ������Ϊ��(Ϊ��Ϊ��һ�ֽ�)
                ByteToStr = ByteToStr & Chr(Tmp * 256 + I)                      '�ϲ������ֽ�,ת��Ϊ����.�ۼ�����
                Tmp = ""                                                        '�����ʱ����
            Else
                Tmp = I                                                         '������ʱ����
            End If
        Else
            ByteToStr = ByteToStr & Chr(I)                                      'ת��Ϊ����,�ۼ�����
        End If
    Next
End Function
