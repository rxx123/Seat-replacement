unit CardDll;

interface
Uses SysUtils;

  const  SDTAPIDll = 'SDTAPI.dll'; //���õĶ�д����̬���ӿ�
  const  WltRSDll = 'WltRS.dll'; //���õ�ͼ��̬���ӿ�  

 //��̬���ö�̬��
  Function SDT_OpenPort(iPort:integer):integer; stdcall; external SDTAPIDll name 'SDT_OpenPort';
  function SDT_ClosePort(iPortID:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_ClosePort';

  function SDT_StartFindIDCard(iPort:integer;pucIIN:Pbytearray;iIfOpen:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_StartFindIDCard';
  function SDT_SelectIDCard(iPort:integer;pucSN:Pbytearray;iIfOpen:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_SelectIDCard';
  function SDT_ReadBaseMsg(iPort:integer;pucCHMsg:Pbytearray;puiCHMsgLen:PInteger;pucPHMsg:Pbytearray;puiPHMsgLen:PInteger;iIfOpen:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_ReadBaseMsg';
  function SDT_ReadBaseMsgToFile(iPortID:integer;pcCHMsgFileName:PChar;puiCHMsgFileLen:pinteger;pcPHMsgFileName:PChar;puiPHMsgFileLen:pinteger;iIfOpen:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_ReadBaseMsgToFile';
  function SDT_ReadFPMsg(iPortID:integer;pucFPMsg:Pbytearray;puiFPMsgLen:PInteger;iIfOpen:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_ReadFPMsg';


  function SDT_ResetSAM(iPortID:integer;iState:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_ResetSAM';
  function SDT_GetSAMStatus(iPortID:integer;iState:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_GetSAMStatus';
  function SDT_GetSAMID(iPortID:integer;OutData:Pbytearray;iState:integer):integer;stdcall;external SDTAPIDll name 'SDT_GetSAMID';
  function SDT_GetSAMIDToStr(iPortID:integer;OutData:PChar;iState:integer):integer;stdcall;external SDTAPIDll name 'SDT_GetSAMIDToStr';
  function SDT_ReadIINSNDN(iPortID:integer;OutData:Pbytearray;iState:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_ReadIINSNDN';
  function SDT_SetMaxRFByte(iPortID:integer;ByteI:byte;iState:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_SetMaxRFByte';
  function SDT_GetCOMBaud(iPortID:integer;Baud:pLongint):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_GetCOMBaud';
  function SDT_SetCOMBaud(iPortID:integer;BaudCur:Longint;BaudSet:Longint):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_SetCOMBaud';
  function SDT_ReadNewAppMsg(iPort:integer;pucCHMsg:Pbytearray;puiCHMsgLen:PInteger;iIfOpen:integer):integer;stdcall;external 'SDTAPI.DLL' name 'SDT_ReadNewAppMsg';

  function GetBmp(file_name:Pchar;Port:integer):integer;stdcall;external WltRSDll name 'GetBmp';

  
  //function GetBmp(file_name:Pchar;Port:integer):integer;stdcall;external 'WltRS.dll' name 'GetBmp';
  {TSDT_OpenPort = Function  (iPort:integer):integer;stdcall;
  TSDT_StartFindIDCard=function (iPort:integer;pucIIN:Pbytearray;iIfOpen:integer):integer;stdcall;
  TSDT_SelectIDCard=function (iPort:integer;pucSN:Pbytearray;iIfOpen:integer):integer;stdcall;
  TSDT_ReadBaseMsg=function (iPort:integer;pucCHMsg:Pbytearray;puiCHMsgLen:PInteger;pucPHMsg:Pbytearray;puiPHMsgLen:PInteger;iIfOpen:integer):integer;stdcall;
  TSDT_ReadNewAppMsg=function (iPort:integer;pucCHMsg:Pbytearray;puiCHMsgLen:PInteger;iIfOpen:integer):integer;stdcall;

  TSDT_ResetSAM=function (iPortID:integer;iState:integer):integer;stdcall;
  TSDT_GetSAMStatus=function (iPortID:integer;iState:integer):integer;stdcall;
  TSDT_GetSAMID=function (iPortID:integer;OutData:Pbytearray;iState:integer):integer;stdcall;

  TSDT_ReadMngInfo=function (iPortID:integer;OutData:Pbytearray;iState:integer):integer;stdcall;

  TGetBmp=function (file_name:Pchar;Port:integer):integer;stdcall;
  TSDT_ClosePort=function (iPortID:integer):integer;stdcall;
  TSDT_SetMaxRFByte=function (iPortID:integer;ByteI:byte;iState:integer):integer;stdcall;
  TSDT_GetCOMBaud=function (iPortID:integer;Baud:pLongint):integer;stdcall;
  TSDT_SetCOMBaud=function (iPortID:integer;BaudCur:Longint;BaudSet:Longint):integer;stdcall;
  }


implementation
{procedure TForm1.Button4Click(Sender: TObject);
var
 F1:TextFile;
  aName:array [0..29] of Char;
  aSex:array [0..1] of Char;
  aNation:array [0..3] of Char;
  aBir:array [0..15] of Char;
  aAddr:array [0..69] of Char;
  aPID:array [0..35] of Char;
  aPort:array [0..29] of Char;
  aEffectS,aEffectE:array [0..15] of Char;
  aNewAddr:array [0..35] of Char;
//  aBuf:array [0..255] of Char;
  i,j:integer;
  a,b:string;
  Ch:Char;
  tmpPID:string;

  //tmpBuf:array [0..255] of Char;
  //tmpInt:integer;
  //label FindCard;
  label ReadCard;
var
  hnddll:Thandle;
begin
                hnddll:=loadlibrary('WltRS.dll');
                if hnddll <> 0 then
                begin
                     @GetBmp := GetProcAddress(hnddll, 'GetBmp');
                    if @GetBmp = nil then
                    begin
                      showmessage('�Ҳ�����Ҫ���õĺ��������������');
                      abort;
                    end;
                end
                else
                begin
                  showmessage('�Ҳ�����̬�⣬���������');
                  abort;
                end;

                SamRet:= GetBmp('c:\1\Picture.wlt', 1);
                hnddll:=loadlibrary('WltRS.dll');
                If SamRet = 1 Then
                    Image1.Picture.LoadFromFile(appName+'Picture.bmp')
                Else
                begin
                    Label21.Caption:= '��ԭBMP�ļ�����';
                    showmessage ('��ȷ����Ƭ�㷨����Ȩ�Ƿ���ȷ��');
                    abort;
                End;
                 Label21.Caption:= '�����ɹ�';
                Label21.Refresh;
                Sleep (50);
                  abort;


end; }
end.
