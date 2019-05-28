unit Global;

interface

uses
  Windows, Forms, ComCtrls, SysUtils, Controls, StrUtils, StdCtrls, DateUtils, CardDll, DBClient,
  Messages, ADODB, ComObj, ActiveX, Buttons;

Const

    FEnable: Boolean = true;
    FDisEnable: boolean = false;
    FNull = '';
    FZero = '0';
    IFOpen = 1;





    //端口号
    USBPort1 = 1001;
    USBPort2 = 1002;
    USBPort3 = 1003;
    Com1Port = 1;
    Com2Port = 2;
    Com3Port = 3;
    Com4Port = 4;
    Com5Port = 5;
    Com6Port = 6;

    //串口速率
    Rate9600 = 9600;


    //错误码
    res_Suc_Operate = $90;//操作成功
    res_Err_CardNoContent = $91;//证卡中此项无内容
    res_Suc_FindCard = $9F;//寻找证/卡成功
    res_Err_PortNo = $1;//端口号不合法
    res_Err_PCRecOverTime = $02;//PC接收超时
    res_Err_DataTrans = $03;// 数据传输错误
    res_Err_SAMVNotUse = $05;//该SAM_V串口不可用，只在SDT_GetComBaud时才有可能返回
    res_Err_RecTerminalDataCheckSum = $10;//接收业务终端数据的校验和错
    res_Err_RecTerminalDataLength = $11;//接收业务终端数据的长度错
    res_Err_RecTerminalDataCommand = $21;//接收业务终端的命令错误，包括命令中的各种数值或逻辑搭配错误
    res_Err_ExceedAuthorityOperate = $23;//越权操作
    res_Err_Unknown = $24;//无法识别的错误
    res_Err_FindCard = $80;//寻找证/卡失败
    res_Err_SelectCard = $81;//选取证/卡失败
    res_Err_CardAuthSAMV = $31;//证/卡认证SAM_V失败
    res_Err_SAMVAuthCard = $32;//SAM_V认证证/卡失败
    res_Err_InfoVaildate = $33;//信息验证错误
    res_Err_UnknownCardType = $40;//无法识别的卡类型
    res_Err_ReadCardOperate = $41;//读证/卡操作失败
    res_Err_GetRandom = $47;//取随机数失败
    res_Err_SAMVCheck = $60;//SAM_V自检失败，不能接收命令
    res_Err_SAMVNOtAuth = $66;//SAM_V没经过授权，无法使用 

    //解析照片错误码
    res_pic_UseSTDAPIDLL =0;	    //调用sdtapi.dll错误
    res_pic_PhotoDecodeErr = -1;	//相片解码错误
    res_pic_WLTSuffixErr = -2;	  //wlt文件后缀错误
    res_pic_WLTOpenErr = -3;      //wlt文件打开错误
    res_pic_WLTFormat = -4;       //wlt文件格式错误
    res_pic_SoftNotAuth = -5;	    //软件未授权
    res_pic_DeviceConErr = -6;    //设备连接错误

    //Variant
Var
  ExePath: String;       //程序路径
  PortHandle: integer;   //串口句柄
  ReaderPortHandle: integer;
  LoginCount: integer;//登录次数
  G_Time: integer;//轮循时间
  
  //IFCreateCom: integer;  //是否创建串口
  IFCloseCom: Boolean;  //是否关闭串口
  CurComPort: integer;   //串口号
  CurReaderComPort: integer;// 读写器串口
  CurComRate: integer;   //串口速率
  CurReaderType: integer;//读卡机类型

  CfgFile: TextFile;//配置文件
  S: Array[1..1] of String;  
  //DllHandle:Thandle;

Function GetDirPath: string;
{
        功能    ：得到当前程序路径
        入口参数：
                  无
        返回值  ：路径
        备注    ：
}
Function Error(Const Msg : Pchar;Const ErrorType: UINT = MB_OK+MB_ICONERROR):integer;Overload;
{
        功能    ：显示一个错误窗口
        入口参数：
                  Msg       : Pchar 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：可显示出一个自己定制的出错处理窗口
}
Function Error(Const ErrorID : integer;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;Overload;
{
        功能    ：显示一个错误窗口
        入口参数：
                  Msg       : String 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：同上
}
Function Error(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;Overload;
{
        功能    ：显示一个错误窗口
        入口参数：
                  Msg       : String 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：可显示出一个自己定制的出错处理窗口
}


Function Success(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONINFORMATION):integer;
{
        功能    ：显示一个成功窗口
        入口参数：
                  Msg       : String 错误的内容;
                  ErrorType : 错误类别;
        返回值  ：出错后可能的用户选择处理方式时，使用
        备注    ：可显示出一个自己定制的出错处理窗口
}

Procedure EnableAll(F: TForm);
//Enable ALL visual Edit or Combox in a Form
{
    功能    ： 设置全部的可见的Edit和Combobox中的可编辑性
    入口参数：
               F : 窗体变量，指示被清除的窗体
    返回值  ： 无
    备注    ： 无
}

Procedure DisEnableAll(F: TForm);
//Enable ALL visual Edit or Combox in a Form
{
    功能    ： 设置全部的可见的Edit和Combobox中的可编辑性
    入口参数：
               F : 窗体变量，指示被清除的窗体
    返回值  ： 无
    备注    ： 无
}

Procedure ClearAll(F: TForm);
//Enable ALL visual Edit or Combox in a Form
{
    功能    ： 清除全部的可见的Edit和Combobox中的内容
    入口参数：
               F : 窗体变量，指示被清除的窗体
    返回值  ： 无
    备注    ： 无
}

Procedure SetCursor(F: TForm; Cursor: TCursor);

Procedure RefreshAll(F: TForm);

Procedure NumLimit(var Key: Char);
{功能 ：               //数字输入限制
   入口参数：   Key        :           接收的键值

   返回值：     无
   备注：                 无
}

Procedure NumDecimalLimit(var Key: Char);
{功能 ：               //数字小数点输入限制
   入口参数：   Key        :           接收的键值

   返回值：     无
   备注：                 无
}

Procedure IDCardNoLimit(var Key: Char);
{功能 ：               身份证号码输入限制
   入口参数：   Key   :      接收的键值

   返回值：     无

   备注：                 无
}
Procedure SimulateTab(var Key: Char);
{功能 ：               回车键模拟TAB键，下一对象获得焦点
   入口参数：   Key   :      接收的键值

   返回值：     无

   备注：                 无
}

Procedure ReadOnlySimulateTab(var Key: Char);
{功能 ：               回车键模拟TAB键，下一对象获得焦点,否则返回Key值为#0
   入口参数：   Key   :      接收的键值

   返回值：     无

   备注：                 无
}

function custrtoDate(strDate: String): TDateTime;
{功能 ：               自定义字符串转为日期函数
   入口参数：   strDate: 转换的字符串

   返回值：     转换后的日期

   备注：                 无


}
function cuDateToStr(dtDate: TDateTime): String;
function cuTimeToStr(dtTime: TDateTime): String;

function FillStrToLeftNull(str: String; FillStr: Char; sLength: Integer): String;
{功能 ：               左补齐字符串
   入口参数：   str: 要被被齐的字符串
                FillStr: 填充的字符
                sLength: 字符串的要求长度
   返回值：     无

   备注：                 无


}
function FillStrToRightNull(str: String; FillStr: Char; sLength: Integer): String;
{功能 ：               右补齐字符串
   入口参数：   str: 要被被齐的字符串
                FillStr: 填充的字符
                sLength: 字符串的要求长度
   返回值：     无

   备注：                 无


}

function trimSpace(s: String): String;

function FillLeftStrToSender(Sender: TOBject): integer;

function GetMSecOfTimeLen(StartTime: TDateTime): Integer;

function PrintErrorType(ErrorValue: integer): String;

function ErrorType(ErrorValue: integer): String;

function PicErrorType(ErrorValue: integer): string;

function ConverCharToStr(SChar: Array of Char): String;

Function FGBTOFolk(GB: Integer): String;
Function FFolkTOGB(Folk: String): String;

implementation

Function GetDirPath: string;
begin
  Result := ExtractFilePath(application.ExeName);
    //Result := GetCurrentDir;
end;

Function Error(Const Msg : Pchar;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;
begin
    {$IFDEF APPLICATION_MAIN_RUN}
    Result:=Messagebox(Application.MainForm.Handle,MSG,'错误',ErrorType);
    {$ELSE}
    Result:=Application.MessageBox(MSG,'错误',ErrorType);
    {$ENDIF}
end;
//-----------------------------------------------------------------------
Function Error(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;Overload;
begin
    {$IFDEF APPLICATION_MAIN_RUN}
    Result:=Messagebox(Application.MainForm.Handle,Pchar(MSG),'错误',ErrorType);
    {$ELSE}
    Result:=Application.MessageBox(Pchar(MSG),'错误',ErrorType);
    {$ENDIF}
end;
//---------------------------------------------------------------------
Function Error(Const ErrorID : integer;Const ErrorType : UINT=MB_OK+MB_ICONERROR):integer;
begin
   {case of}
   {$IFDEF APPLICATION_MAIN_RUN}
   Result:=Messagebox(application.MainForm.Handle,Pchar(inttostr(ErrorID)),'错误',ErrorType);
   {$ELSE}
   Result:=Messagebox(0,Pchar(inttostr(ErrorID)),'错误',ErrorType);
   {$ENDIF}
end;

Function Success(Const MSG :String;Const ErrorType : UINT=MB_OK+MB_ICONINFORMATION):integer;
begin
    Result:=Application.MessageBox(pchar(Msg),'消息',ErrorType);
end;

function DeleteWarning: Boolean;
begin
  Result := False;
  if application.MessageBox('该记录删除后将无法恢复，确定要删除吗？','警告',Mb_iconexclamation+mb_okCancel)=IDok then
  begin
    Result := True;
  end;
end;

Procedure DisEnableAll(F: TForm);
var
  i   : integer;
  str : String;
begin
  i:=F.ComponentCount-1 ;  //i: F中的控件总数
  while(i>0) do
  begin
    str:=F.Components[i].ClassName;   //各个控件的类名

    if (Uppercase(Rightstr(str,4))='EDIT') then            //如果类名为TEDIT
    begin
      if ((TCustomedit(F.Components[i]).Visible) and ((F.Components[i].Tag=999) or (F.Components[i].Tag=998))) then
      begin
        TCustomEdit(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,8))='COMBOBOX') then
    begin
      if ((TCustomCombobox(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomcombobox(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,4))='MEMO') then
    begin
      if ((TCustomMemo(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomMemo(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,6))='BUTTON') then
    begin
      if ((TSpeedButton(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=False;
      end;
    end;

    if (Uppercase(Rightstr(str,14))='DATETIMEPICKER') then
    begin
      if ((TDateTimePicker(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=False;
      end;
    end;

    dec(i);
  end;
end;
//-------------------------------------------------------
Procedure EnableAll(F : TForm);
var
  i: integer;
  str: String;
begin
  i := F.ComponentCount - 1 ;
  while(i>0) do
  begin
    str:=F.Components[i].ClassName;
    if (Uppercase(Rightstr(str,4))='EDIT') then
    begin
      if ((TCustomedit(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomEdit(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,8))='COMBOBOX') then
    begin
      if ((TCustomCombobox(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomcombobox(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,4))='MEMO') then
    begin
      if ((TCustomMemo(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomMemo(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,6))='BUTTON') then
    begin
      if ((TSpeedButton(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=True;
      end;
    end;
    if (Uppercase(Rightstr(str,14))='DATETIMEPICKER') then
    begin
      if ((TDateTimePicker(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TSpeedButton(F.Components[i]).Enabled:=True;
      end;
    end;
    dec(i);
  end;
end;

Procedure ClearAll(F: TForm);
var
  i   : integer;
  str : String;
begin
  i:=F.ComponentCount-1 ;  //i: F中的控件总数
  while(i>0) do
  begin
    str:=F.Components[i].ClassName;   //各个控件的类名

    if (Uppercase(Rightstr(str,4))='EDIT') then            //如果类名为TEDIT
    begin
      if ((TCustomedit(F.Components[i]).Visible) and ((F.Components[i].Tag=999) or (F.Components[i].Tag=998))) then
      begin
        TCustomEdit(F.Components[i]).Clear;
        TCustomEdit(F.Components[i]).Refresh;
      end;
    end;

    if (Uppercase(Rightstr(str,8))='COMBOBOX') then
    begin
      if ((TCustomCombobox(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomcombobox(F.Components[i]).Clear;
        TCustomEdit(F.Components[i]).Refresh;
      end;
    end;

    if (Uppercase(Rightstr(str,4))='MEMO') then
    begin
      if ((TCustomMemo(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomMemo(F.Components[i]).Clear;
        TCustomEdit(F.Components[i]).Refresh;
      end;
    end;
    dec(i);
  end;
end;

Procedure SetCursor(F: TForm; Cursor: TCursor);
var
  i   : integer;
begin
  i:=F.ComponentCount-1 ;  //i: F中的控件总数
  while(i>0) do
  begin
    TControl(F.Components[i]).Cursor := Cursor;
    TControl(F.Components[i]).Refresh;
  end;
end;
Procedure RefreshAll(F: TForm);
var
  i   : integer;
  str : String;
begin
  i:=F.ComponentCount-1 ;  //i: F中的控件总数
  while(i>0) do
  begin
    str:=F.Components[i].ClassName;   //各个控件的类名

    if (Uppercase(Rightstr(str,4))='EDIT') then            //如果类名为TEDIT
    begin
      if ((TCustomedit(F.Components[i]).Visible) and ((F.Components[i].Tag=999) or (F.Components[i].Tag=998))) then
      begin
        TCustomEdit(F.Components[i]).Refresh;
      end;
    end;

    if (Uppercase(Rightstr(str,8))='COMBOBOX') then
    begin
      if ((TCustomCombobox(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomEdit(F.Components[i]).Refresh;
      end;
    end;

    if (Uppercase(Rightstr(str,4))='MEMO') then
    begin
      if ((TCustomMemo(F.Components[i]).Visible) and (F.Components[i].Tag=999)) then
      begin
        TCustomEdit(F.Components[i]).Refresh;
      end;
    end;
    dec(i);
  end;
end;

Procedure NumLimit(var Key: Char);
Var
  Sender: TObject;
begin
  if (key <#48) or (key > #57) then
  begin
    if Key = #22 then
    begin
      key := #22;
    end
    else if Key = #13 then
    begin
      key := #13;
      SimulateTab(Key);
    end
    else
    if Key = #8 then
    begin
      key := #8;
    end
    else
    key := #0;
  end;
end;

Procedure NumDecimalLimit(var Key: Char);
Var
  Sender: TObject;
begin
  if (key <#48) or (key > #57) then
  begin
    if Key = #22 then
    begin
      key := #22;
    end
    else if key = '.' then
    begin
      key:='.';
    end
    else
    if Key = #8 then
    begin
      key := #8;
    end
    else
    if Key = #13 then
    begin
      key := #13;
      SimulateTab(Key);
    end
    else
    begin
      key := #0;
    end;
  end;
end;

Procedure IDCardNoLimit(var Key: Char);
Var
  Sender: TObject;
begin
  if (key <#48) or (key > #57) then
  begin
    if Key = #22 then
    begin
      key := #22;
    end
    else if key = 'x' then
    begin
      key:='X';
    end
    else
    if Key = 'X' then
    begin
      key:='X';
    end
    else
    if Key = #8 then
    begin
      key := #8;
    end
    else
    if Key = #13 then
    begin
      key := #13;
      SimulateTab(Key);
    end
    else
    begin
      key := #0;
    end;
  end;
end;

Procedure SimulateTab(var Key: Char);
Var
  Sender: TObject;
begin
  if Key = #13 then
  begin
    PostMessage(TWinControl(Sender).Handle ,WM_KeyDown,VK_Tab,0);
  end;
end;

Procedure ReadOnlySimulateTab(var Key: Char);
Var
  Sender: TObject;
begin
  if Key = #13 then
  begin
    PostMessage(TWinControl(Sender).Handle ,WM_KeyDown,VK_Tab,0);
  end
  else
  begin
    Key := #0;
  end;
end;

function custrtoDate(strDate: String): TDateTime;
var
  sYear, sMonth, sDate: string;
begin
  if StrDate = '' then
  begin
    Result := Date();
    Exit;
  end;
  Try
    sYear := Leftstr(strDate, 4);
    sMonth := MidStr(strDate, 5, 2);
    sDate := RightStr(strDate, 2);
    Result := EncodeDate(strtoint(sYear), strtoint(sMonth), strtoint(sDate));
  Except
    Result := Date();
  end;
end;

function cuDateToStr(dtDate: TDateTime): String;
var
  iYear, iMonth: integer;
  sYear, sMonth: string;
  sDate: string;
begin
  iYear := Yearof(dtDate);
  iMonth := Monthof(dtDate);
  sYear := inttostr(iYear);
  sMonth := inttostr(iMonth);
  if length(inttostr(iMonth)) = 1 then
  begin
    sMonth := '0' + sMonth;
  end;
  sDate := RightStr(DateToStr(Dateof(dtDate)), 2);
  if LeftStr(sDate, 1) = '-' then
  begin
    sDate := RightStr(sDate, 1);
    sDate := '0' + sDate;
  end;
  Result := sYear + sMonth + sDate;
end;

function cuTimeToStr(dtTime: TDateTime): String;
var
  sHour,sMin, sSec: string;
  sTime: string;
begin
  sTime := TimeToStr(dtTime);
  sHour := LeftStr(sTime, 2);
  sMin := MidStr(sTime, 4, 2);
  sSec := RightStr(sTime, 2);
  Result := sHour + sMin + sSec;

end;

function FillStrToLeftNull(str: String; FillStr: Char; sLength: Integer): String;
var
  i: integer;
  sFillStr: String;
begin
  if sLength > Length(str) then
  begin
    for i := 1 to sLength - Length(str) do
    begin
      sFillStr := FillStr + sFillStr;
    end;
    Result := sFillStr + str;
  end
  else
  begin
    Result := str;
  end;
end;

function FillStrToRightNull(str: String; FillStr: Char; sLength: Integer): String;
var
  i: integer;
  sFillStr: String;
begin
  if sLength > Length(str) then
  begin
    for i := 1 to sLength - Length(str) do
    begin
      sFillStr := sFillStr + FillStr;
    end;
    Result := str + sFillStr;
  end
  else
  begin
    Result := str;
  end;
end;

function FillLeftStrToSender(Sender: TObject): integer;
var
  i: integer;
begin
  {if TEdit(Sender).MaxLength > Length(TCustomEdit(Sender).Text)) then
  begin
    for i := 1 to (TCustomer(Sender).MaxLength - Length(TCustomer(Sender).Text)) do
    begin
      sFillStr := FillStr + sFillStr;
    end;
    Result := sFillStr + str;
  end
  else
  begin
    Result := str;
  end;}

end;

function GetMSecOfTimeLen(StartTime: TDateTime): Integer;
//计算从开始到现在经过的毫秒时间数
var
  Hour,Minute,Second,MSec:Word;
begin
  DecodeTime(Date+Time-StartTime,Hour,Minute,Second,MSec);
  Result := MSec+(Second+(Minute+Hour*60)*60)*1000;
end;



function ErrorType(ErrorValue: integer): String;
begin
  Result := '';

  Case ErrorValue of
    res_Suc_Operate: Result := ' 操作成功!';
    res_Err_CardNoContent: Result := ' 证卡中此项无内容!';
    res_Suc_FindCard: Result := ' 寻找证/卡成功!';
    res_Err_PortNo: Result := ' 端口号不合法!';
    res_Err_PCRecOverTime: Result := ' PC接收超时!';
    res_Err_DataTrans: Result := ' 数据传输错误!';
    res_Err_SAMVNotUse: Result := ' 该SAM_V串口不可用，只在SDT_GetComBaud时才有可能返回!';
    res_Err_RecTerminalDataCheckSum: Result := ' 接收业务终端数据的校验和错!';
    res_Err_RecTerminalDataLength: Result := ' 接收业务终端数据的长度错!';
    res_Err_RecTerminalDataCommand: Result := ' 接收业务终端的命令错误，包括命令中的各种数值或逻辑搭配错误!';
    res_Err_ExceedAuthorityOperate: Result := ' 越权操作!';
    res_Err_Unknown: Result := ' 无法识别的错误!';
    res_Err_FindCard: Result := ' 寻找证/卡失败!';
    res_Err_SelectCard: Result := ' 选取证/卡失败!';
    res_Err_CardAuthSAMV: Result := ' 证/卡认证SAM_V失败!';
    res_Err_SAMVAuthCard: Result := ' SAM_V认证证/卡失败!';
    res_Err_InfoVaildate: Result := ' 信息验证错误!';
    res_Err_UnknownCardType: Result := ' 无法识别的卡类型!';
    res_Err_ReadCardOperate: Result := ' 读证/卡操作失败!';
    res_Err_GetRandom: Result := ' 取随机数失败!';
    res_Err_SAMVCheck: Result := ' SAM_V自检失败，不能接收命令!';
    res_Err_SAMVNOtAuth: Result := ' AM_V没经过授权，无法使用!';
  else
    Result := ' 未知错误，错误返回值'+ inttostr(ErrorValue);
  end;

end;

function PicErrorType(ErrorValue: integer): String;
begin
  Result := '';
  Case ErrorValue of
    res_pic_UseSTDAPIDLL: Result := ' 调用sdtapi.dll错误!';
    res_pic_PhotoDecodeErr: Result := ' 相片解码错误!';
    res_pic_WLTSuffixErr: Result := ' wlt文件后缀错误!';
    res_pic_WLTOpenErr: Result := ' wlt文件打开错误!';
    res_pic_WLTFormat: Result := ' wlt文件格式错误!';
    res_pic_SoftNotAuth: Result := ' 软件未授权!';
    res_pic_DeviceConErr: Result := ' 设备连接错误!';
  else
    Result := ' 错误类型：未知错误!返回值'+ inttostr(ErrorValue);
  end;  
end;



function PrintErrorType(ErrorValue: integer): String;
begin
  Result := '';

  {Case ErrorValue of
    res_READER_TYPE_WRONG: Result := ' 错误类型：读卡器类型无效!';
    res_NO_veifyPin: Result := ' 错误类型：未校验PIN!';
    res_DeviceClose_ERROR: Result := '错误类型： 设备关闭失败!';
    res_ERR_OPEN_DEVICE: Result := ' 错误类型： 设备打开失败!';
    ErrCNoCard: Result := ' 错误类型：无卡!';
    ErrCRecordNotF: Result := ' 错误类型：没有找到记录文件!';
    ErrCInvData: Result := ' 错误类型：数据无效!';
    CheckPINFirst: Result := ' 错误类型：第一次输入PIN值错误!';
    CheckPINSec: Result := ' 错误类型：第二次输入PIN值错误!';
    CheckPINThird: Result := ' 错误类型：第三次输入PIN值错误!';
    ErrCNoPSAMCard: Result := '错误类型：无PSAM卡';
    ErrCKeyLock: Result := '密钥被锁死';

  else
    Result := ' 错误类型：未知错误!'+ inttostr(ErrorValue);
  end;}

end;

function ConverCharToStr(SChar: Array of Char): String;
begin
  Result := String(Schar);
end;

Function FGBTOFolk(GB: Integer): String;
Var
  sFolk: String;
begin
  sFolk := '';
  Case GB of
    01: sFolk := '汉';
    02: sFolk := '蒙古';
    03: sFolk := '回';
    04: sFolk := '藏';
    05: sFolk := '维吾尔';
    06: sFolk := '苗';
    07: sFolk := '彝';
    08: sFolk := '壮';
    09: sFolk := '布依';
    10: sFolk := '朝鲜';
    11: sFolk := '满';
    12: sFolk := '侗';
    13: sFolk := '瑶';
    14: sFolk := '白';
    15: sFolk := '土家';
    16: sFolk := '哈尼';
    17: sFolk := '哈萨克';
    18: sFolk := '傣';
    19: sFolk := '黎';
    20: sFolk := '傈僳';
    21: sFolk := '佤';
    22: sFolk := '畲';
    23: sFolk := '高山';
    24: sFolk := '拉祜';
    25: sFolk := '水';
    26: sFolk := '东乡';
    27: sFolk := '纳西';
    28: sFolk := '景颇';
    29: sFolk := '柯尔克孜';
    30: sFolk := '土';
    31: sFolk := '达斡尔';
    32: sFolk := '仫佬';
    33: sFolk := '羌';
    34: sFolk := '布朗';
    35: sFolk := '撒拉';
    36: sFolk := '毛南';
    37: sFolk := '仡佬';
    38: sFolk := '锡伯';
    39: sFolk := '阿昌';
    40: sFolk := '普米';
    41: sFolk := '塔吉克';
    42: sFolk := '怒';
    43: sFolk := '乌孜别克';
    44: sFolk := '俄罗斯';
    45: sFolk := '鄂温克';
    46: sFolk := '德昴';
    47: sFolk := '保安';
    48: sFolk := '裕固';
    49: sFolk := '京';
    50: sFolk := '塔塔尔';
    51: sFolk := '独龙';
    52: sFolk := '鄂伦春';
    53: sFolk := '赫哲';
    54: sFolk := '门巴';
    55: sFolk := '珞巴';
    56: sFolk := '基诺';
  Else
    sFolk := '';
  end;
  Result := sFolk;
end;

Function FFolkTOGB(Folk: String): String;
Var
  sGB: String;
begin
  sGB := '';
  if Folk = '汉族' then  sGB := '01'
  else if Folk = '蒙古族' then  sGB := '02'
  else if Folk = '回族' then  sGB := '03'
  else if Folk = '藏族' then  sGB := '04'
  else if Folk = '维吾尔族' then  sGB := '05'
  else if Folk = '苗族' then  sGB := '06'
  else if Folk = '彝族' then  sGB := '07'
  else if Folk = '壮族' then  sGB := '08'
  else if Folk = '布依族' then  sGB := '09'
  else if Folk = '朝鲜族' then  sGB := '10'
  else if Folk = '满族' then  sGB := '11'
  else if Folk = '侗族' then  sGB := '12'
  else if Folk = '瑶族' then  sGB := '13'
  else if Folk = '白族' then  sGB := '14'
  else if Folk = '土家族' then  sGB := '15'
  else if Folk = '哈尼族' then  sGB := '16'
  else if Folk = '哈萨克族' then  sGB := '17'
  else if Folk = '傣族' then  sGB := '18'
  else if Folk = '黎族' then  sGB := '19'
  else if Folk = '傈僳族' then  sGB := '20'
  else if Folk = '佤族' then  sGB := '21'
  else if Folk = '畲族' then  sGB := '22'
  else if Folk = '高山族' then  sGB := '23'
  else if Folk = '拉祜族' then  sGB := '24'
  else if Folk = '水族' then  sGB := '25'
  else if Folk = '东乡族' then  sGB := '26'
  else if Folk = '纳西族' then  sGB := '27'
  else if Folk = '景颇族' then  sGB := '28'
  else if Folk = '柯尔克孜族' then  sGB := '29'
  else if Folk = '土族' then  sGB := '30'
  else if Folk = '达斡尔族' then  sGB := '31'
  else if Folk = '仫佬族' then  sGB := '32'
  else if Folk = '羌族' then  sGB := '33'
  else if Folk = '布朗族' then  sGB := '34'
  else if Folk = '撒拉族' then  sGB := '35'
  else if Folk = '毛南族' then  sGB := '36'
  else if Folk = '仡佬族' then  sGB := '37'
  else if Folk = '锡伯族' then  sGB := '38'
  else if Folk = '阿昌族' then  sGB := '39'
  else if Folk = '普米族' then  sGB := '40'
  else if Folk = '塔吉克族' then  sGB := '41'
  else if Folk = '怒族' then  sGB := '42'
  else if Folk = '乌孜别克族' then  sGB := '43'
  else if Folk = '俄罗斯族' then  sGB := '44'
  else if Folk = '鄂温克族' then  sGB := '45'
  else if Folk = '德昴族' then  sGB := '46'
  else if Folk = '保安族' then  sGB := '47'
  else if Folk = '裕固族' then  sGB := '48'
  else if Folk = '京族' then  sGB := '49'
  else if Folk = '塔塔尔族' then  sGB := '50'
  else if Folk = '独龙族' then  sGB := '51'
  else if Folk = '鄂伦春族' then  sGB := '52'
  else if Folk = '赫哲族' then  sGB := '53'
  else if Folk = '门巴族' then  sGB := '54'
  else if Folk = '珞巴族' then  sGB := '55'
  else if Folk = '基诺族' then  sGB := '56'
  else sGB := '';


  Result := sGB;
end;

function trimSpace(s: String): String;
Var
  i, iLength: integer;
  SS: String;
begin
  SS := '';
  iLength := Length(S);
  for i := 1 to iLength do
  begin
    if S[i] = ' ' then
    begin
      continue;
    end;
    SS := SS + S[i];
  end;
  Result := SS;
end;

end.
