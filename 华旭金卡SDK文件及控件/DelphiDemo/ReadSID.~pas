unit ReadSID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ComCtrls, Buttons, DB, ADODB, SyncObjs,
  Grids, DBGrids;

type
  //事件类型
  TEvent = (
    NoEvent,                  //没有事件
    ReadyReadRec,             //准备好读记录
    NotFindCard,              //没有找到卡
    ReadingCardInfo,          //正在读卡
    ReadCardErr,              //读卡错
    ErrRec,                  //错误的记录
    ReadRecSuc,              //成功读数据
    QryMatchRec,             //查询到匹配记录
    StopRead,                //停止读卡
    EndEvent                   //结束程序
    );
  TfrmReadSID = class(TForm)
    qryDB: TADOQuery;
    qryDBRec: TIntegerField;
    qryDBDSDesigner1: TWideStringField;
    qryDBDSDesigner2: TWideStringField;
    qryDBDSDesigner3: TWideStringField;
    qryDBCSex: TStringField;
    qryDBDSDesigner4: TWideStringField;
    qryDBDSDesigner5: TWideStringField;
    qryDBDSDesigner7: TWideStringField;
    DataSource1: TDataSource;
    sdOutPut: TSaveDialog;
    Label21: TLabel;
    Label1: TLabel;
    Animate1: TAnimate;
    btnRead: TBitBtn;
    btnClose: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    imgPhoto: TImage;
    edtSex: TEdit;
    edtName: TEdit;
    edtBirthDate: TEdit;
    edtAddress: TEdit;
    edtFolk: TEdit;
    edtIDNo: TEdit;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtPort: TEdit;
    edtEffect: TEdit;
    Edit8: TEdit;
    StatusBar1: TStatusBar;
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtSexKeyPress(Sender: TObject; var Key: Char);
    procedure btnReadClick(Sender: TObject);
    procedure btnOutputClick(Sender: TObject);
  private
    { Private declarations }
    cModleSN: Array [0..255]of Char;//安全模块序列号
    aName:array [0..29] of Char;
    aSex:array [0..1] of Char;
    aNation:array [0..3] of Char;
    aBir:array [0..15] of Char;
    aAddr:array [0..69] of Char;
    aPID:array [0..35] of Char;
    aPort:array [0..29] of Char;
    aEffectS,aEffectE:array [0..15] of Char;
    aNewAddr:array [0..256] of Char;

    AppName: String;
    CardPUCIIN: array[0..255] of Byte;
    CardPUCSN: array[0..255] of Byte;
    CardCHMsgLen: integer;
    CardPHMsgLen: integer;
    CardNewAddLen: integer;
    pucCHMsg: array[0..256] of byte;
    pucPHMsg: array[0..1024] of byte;
    pucNewAddInfo: array[0..256] of byte;
    FOutPutFile: string;
    Procedure SetEvent(Event: TEvent);
    Procedure Init;

  public
    { Public declarations }
    function ReadCard: integer;
    procedure SetErrMsg(ErrMsg: TEvent);
  end;

var
  frmReadSID: TfrmReadSID;
  GEvent: TEvent;
  CanRead: Boolean;
  MatchRecCount: integer;//匹配记录

implementation

uses CardDll, Global, Main, InputThread;

{$R *.dfm}

procedure TfrmReadSID.btnCloseClick(Sender: TObject);
begin
  SetEvent(EndEvent);
  Sleep(100);
  Close;
end;

procedure TfrmReadSID.FormDestroy(Sender: TObject);
begin
  frmReadSID := nil;
end;

procedure TfrmReadSID.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmReadSID.FormCreate(Sender: TObject);
begin
  Init;
  AppName:= GetDirPath;
end;

procedure TfrmReadSID.edtSexKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

function TfrmReadSID.ReadCard: integer;
var
  iFileHandle: Integer;

  i,j,num:integer;
  a,b:string;
  //Ch:Char;
  tmpPID:string;
  hnddll:Thandle;
  PathString:string;
  StrL:integer;
  iResultValue: integer;
  sTrimName: String;
begin
  Result := -1;
  Animate1.Active := False;
  //SDT_ClosePort(CurReaderComPort);
  //Label21.Font.Color := clBlue;
  //label21.Cursor := crDefault;
  //开始找卡:
  //SetCursor(Self, crHourGlass);

  iResultValue := SDT_StartFindIDCard(CurReaderComPort, @CardPUCIIN, IFOpen);
  If iResultValue <> $9f Then  //找卡不成功，可能是没有卡或者卡片一直处于磁场中
  begin
    
    //SDT_ClosePort(CurReaderComPort);
    //SDT_OpenPort(CurReaderComPort);
    Sleep(G_Time);
    //exit;
  end;
  //else if iResultValue = $9f Then
  begin
    Animate1.Active := True;
    MatchRecCount := 0;
    ClearAll(Self);
    imgPhoto.Visible := False;
    imgPhoto.Refresh;
    imgPhoto.Visible := False;
    Label21.Caption := '';
    Label21.Font.Color := clBlue;
    //label21.Refresh;
    iResultValue := SDT_SelectIDCard(CurReaderComPort, @CardPUCSN, IFOpen);
    //读卡片中的标识
    //If iResultValue = 144 Then
    begin
      //开始读卡内人员信息
      Label21.Font.Color := clBlue;
      Label21.Caption:= '正在读卡......';
      Label21.Refresh;
      //SetEvent(ReadingCardInfo);
      //Sleep(10);
      //label21.Refresh;
      //将卡片中的人员基本信息和照片存入文件中
      iResultValue := SDT_ReadBaseMsg(CurReaderComPort, @pucchmsg, @CardCHMsgLen, @pucphmsg, @CardPHMsgLen, IFOpen);
      if iResultValue <> 144 Then
      begin
        Label21.Font.Color := clRed;
        Label21.Caption:= '读卡失败，请再次放卡重试';
        //SetEvent(ReadCardErr);
        //Sleep(10);
        //label21.Refresh;
        exit;
      end
      else   //处理读到的信息，显示在界面上
      begin
        PathString:=AppName + 'picture.wlt';
        iFileHandle :=filecreate(PathString);
        filewrite(iFileHandle,pucphmsg,CardpHMsgLen);
        fileclose(iFileHandle);

        FillChar(aName,30,0);
        FillChar(aSex,2,0);
        FillChar(aNation,4,0);
        FillChar(aBir,16,0);
        FillChar(aAddr,70,0);
        FillChar(aPID,36,0);
        FillChar(aPort,30,0);
        FillChar(aEffectS,16,0);
        FillChar(aEffectE,16,0);

        copymemory(@aname,@pucchmsg,30);
        copymemory(@aSex,@pucchmsg[30],2);
        copymemory(@aNation,@pucchmsg[32],4);
        copymemory(@aBir,@pucchmsg[36],16);
        copymemory(@aAddr,@pucchmsg[52],70);
        copymemory(@aPID,@pucchmsg[122],36);
        copymemory(@aPort,@pucchmsg[158],30);
        copymemory(@aEffectS,@pucchmsg[188],16);
        copymemory(@aEffectE,@pucchmsg[204],16);
        tmpPID:=WideCharLenToString(@aPID,18);

        edtName.Text := Trim(WideCharLenToString(@aName,15));
        if WideCharLenToString(@aSex,1) = '1' then
        begin
          edtSex.Text := '男';
        end
        else
        begin
          edtSex.Text := '女';
        end;
        edtFolk.Text := Trim(FGBTOFolk(strtoint(WideCharLenToString(@aNation,2))));
        a:=Trim(WideCharLenToString(@aBir,8));
        edtBirthDate.Text := Copy(a,1,4)+'年'+Copy(a,5,2)+'月'+Copy(a,7,2)+'日';
        edtAddress.Text := Trim((WideCharLenToString(@aAddr,35)));
        edtIDNO.Text := Trim(WideCharLenToString(@aPID,18));
        edtPort.Text := Trim(WideCharLenToString(@aPort,15));
        a := Trim(WideCharLenToString(@aEffectS,8));
        b := Trim(WideCharLenToString(@aEffectE,8));
        if  length(b)<8 then
        begin
          edtEffect.Text := Copy(a,1,4)+'年'+Copy(a,5,2)+'月'+Copy(a,7,2)+'日'+' 到 '+b
        end
        else
        begin
          edtEffect.Text := Copy(a,1,4)+'年'+Copy(a,5,2)+'月'+Copy(a,7,2)+'日'+' 到 '+
                      Copy(b,1,4)+'年'+Copy(b,5,2)+'月'+Copy(b,7,2)+'日';
        end;

        iResultValue := SDT_ReadNewAppMsg(CurReaderComPort, @pucNewAddInfo, @CardNewAddLen, IFOpen);
        if iResultValue <> 144 then
        begin
          if iResultValue <> 145 then
          begin
            Label21.Font.Color := clRed;
            Label21.Caption:= '读取卡内追加信息失败，请重新放卡......';
            //label21.Refresh;
            exit;
          end;
        end
        else
        begin
          FillChar(aNewAddr,CardNewAddLen,0);
          copymemory(@aNewAddr,@pucNewAddInfo,CardNewAddLen );
          //label20.Caption := WideCharLenToString(@aNewAddr,18);
        end;

        //将读卡后生成的图片文件还原成bmp格式的图片文件并显示出来
        if (CurReaderComPort = USBPort1) or (CurReaderComPort = USBPort2) or (CurReaderComPort = USBPort3) then
        begin
          iResultValue := GetBmp(Pchar(AppName+'Picture.wlt'), 1)
        end
        else
        begin
          iResultValue := GetBmp(Pchar(AppName+'Picture.wlt'), 2);
        end;

        if iResultValue = 1 then
        begin
          imgPhoto.Picture.LoadFromFile(AppName + '\Picture.bmp');
          imgPhoto.Visible := True;
          imgPhoto.Refresh;
        end
        else
        begin
          Label21.Caption := picErrorType(iResultValue);
          exit;
        end;
        RefreshAll(Self);
        label21.Font.Color := clBlue;
        Label21.Caption:= '读卡信息成功';//,正在检索数据库';
        //label21.Refresh;
      end;
    end
    {else
    begin
      Sleep(G_Time);
      exit;
    end; }
  end ;
  {else
  begin
    //Error();
    Label21.Font.Color := clRed;
    Label21.Caption := '读卡错误' + PicErrorType(iResultValue);
    //label21.Refresh;
    Exit;
  end; }
  {Sleep(10);
  sTrimName := trimSpace(edtName.Text);
  MatchRecCount := CheckData(qryDB, sTrimName, edtIDNO.Text);
  if MatchRecCount > 0 then
  begin
    Label21.Font.Color := clRed;
    Label21.Caption:= '检索到' + inttostr(MatchRecCount) + '条姓名或身份证号匹配记录!';
  end
  else
  begin
    Label21.Font.Color := clGreen;
    Label21.Caption:= '检索数据库完毕!';
    //label21.Refresh;
  end;}
  Animate1.Active := False;
  SetEvent(ReadyReadRec);
  Sleep(G_Time);
  Result := 0;
end;

procedure TfrmReadSID.SetEvent(Event: TEVent);
begin
  GEvent := Event;
end;

procedure TfrmReadSID.SetErrMsg(ErrMsg: TEvent);
begin
  Case ErrMsg of
    QryMatchRec:
    begin
      //Error('检索到' + inttostr(MatchRecCount) + '条姓名或身份证号匹配记录');
      Label21.Font.Color := clRed;
      Label21.Caption:= '检索到' + inttostr(MatchRecCount) + '条姓名或身份证号匹配记录!';


    end;
    ReadingCardInfo:
    begin
      Label21.Caption:= '正在读卡......';
    end;
    ReadCardErr:
    begin
      Label21.Caption:= '读卡失败';
    end;
  else
    //Sleep(10);
  end;
  Label21.Refresh;
  Sleep(10);
  SetEvent(ReadyReadRec);
end;

procedure TfrmReadSID.Init;
begin
  SetEvent(NoEvent);
  CS := TCriticalSection.Create;
  TComRead.Create(False); //创建读卡监视线程
  //ReadCard;
  //TGetErrMessage.Create(False); //创建错误消息监视线程
end;

procedure TfrmReadSID.btnReadClick(Sender: TObject);
Var

  sModleSN: String;
  iResultValue: integer;
  iState: integer;

begin

  Label21.Caption := '';
  Label21.Font.Color := clBlue;
  Label21.Refresh;


  if btnRead.Caption = '停止' then
  begin
    btnRead.Caption := '开始';
    SetEvent(StopRead);
  end
  else
  if btnRead.Caption = '开始' then
  begin
    {iResultValue := SDT_ResetSam(CurReaderComPort, IFOpen);
    if iResultValue = 144 Then
    begin

    end
    else
    begin
      Error('安全模块复位失败, ' + ErrorType(iResultValue));
      exit;
    end; 
    Sleep(2000);
    iResultValue := SDT_SetMaxRFByte(CurReaderComPort, 255, IFOpen);
    if iResultValue = 144 Then
    begin
      //StatusBar1.Panels[1].Text := '安全模块状态: 正常';
    end
    else
    begin
      Label21.Font.Color := clRed;
      Label21.Caption := '设置通讯字节数失败, ' + ErrorType(iResultValue);
      exit;
    end;}
    iResultValue := SDT_GetSAMStatus(CurReaderComPort, IFOpen);
    if iResultValue = 144 Then
    begin
      StatusBar1.Panels[1].Text := '安全模块状态: 正常';
    end
    else
    begin 
      StatusBar1.Panels[1].Text := '安全模块状态: 失败';
      exit;
    end;
    //getmem(cModleSN, 255);  }
    iResultValue := SDT_GetSAMIDToStr(CurReaderComPort, cModleSN, IFOpen);
    //sModleSN := String(cModleSN);
    if iResultValue = 144 Then
    begin
      sModleSN := String(cModleSN);
      //freemem(cModleSN);
      StatusBar1.Panels[0].Text := '安全模块序列号:' + sModleSN;
    end
    else
    begin
      StatusBar1.Panels[0].Text := '安全模块序列号: 无效';
    end;  {}

    btnRead.Caption := '停止';
    StatusBar1.Refresh;
    Label21.Refresh;
    //ReadCard;
    SetEvent(ReadyReadRec);
  end;
end;
procedure TfrmReadSID.btnOutputClick(Sender: TObject);
Var
  iResultValue: integer;
  sExtendFileName: string;
begin


end;


end.
