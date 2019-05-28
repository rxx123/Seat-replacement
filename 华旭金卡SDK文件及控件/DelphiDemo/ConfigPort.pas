unit ConfigPort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TfrmConfigPort = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    btnSure: TBitBtn;
    cmbReaderPortNu: TComboBox;
    cmbSetBaud: TComboBox;
    Label3: TLabel;
    edtRate: TEdit;
    Label4: TLabel;
    edtTime: TEdit;
    procedure cmbPortNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbReaderTypeKeyPress(Sender: TObject; var Key: Char);
    procedure btnSureClick(Sender: TObject);
    procedure cmbReaderPortNuChange(Sender: TObject);
    procedure cmbReaderPortNuClick(Sender: TObject);
    procedure edtRateKeyPress(Sender: TObject; var Key: Char);
    //function OpenReaderPort(PortNu: integer): integer;
  private
    { Private declarations }
    Baud, BaudSet, Baudrate :longint;
      
  public
    { Public declarations }
  end;

var
  frmConfigPort: TfrmConfigPort;

implementation

uses CardDll, Main, Global;

{$R *.dfm}

procedure TfrmConfigPort.cmbPortNoKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfrmConfigPort.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmConfigPort.FormDestroy(Sender: TObject);
begin
  frmConfigPort := nil;
end;

procedure TfrmConfigPort.FormCreate(Sender: TObject);
begin  
  cmbReaderPortNu.ItemIndex := 0;
  cmbSetBaud.ItemIndex := 0;
end;

procedure TfrmConfigPort.cmbReaderTypeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    btnSure.Click;
  end
  else
  begin
    key := #0;
  end;
end;

procedure TfrmConfigPort.btnSureClick(Sender: TObject);
Var
  iResultValue: integer;
  iRate: integer;
begin
  if edtTime.Text = '' then
  begin
    G_Time := 300;
  end
  else
  begin
     G_Time := strtoint(edtTime.Text);
  end;
  if (G_Time < 200) or (G_Time > 10000) then
  begin
    Error('读卡轮循时间为200毫秒-10秒');
    exit;
  end;
  if edtRate.Text = '' then
  begin
    iRate := 250;
  end
  else
  begin
    iRate := Strtoint(edtRate.Text);
  end;
  if (iRate < 100) or (iRate > 256) then
  begin
    Error('速率在100-256之间');
    exit;
  end;
  Case cmbReaderPortNu.ItemIndex of
    0:  CurReaderComPort := Com1Port;
    1:  CurReaderComPort := Com2Port;
    2:  CurReaderComPort := Com3Port;
    3:  CurReaderComPort := Com4Port;
    4:  CurReaderComPort := Com5Port;
    5:  CurReaderComPort := Com6Port;
    6:  CurReaderComPort := USBPort1;
    7:  CurReaderComPort := USBPort2;
    8:  CurReaderComPort := USBPort3;

    //4:  CurComPort := 100;
  else
    CurReaderComPort := Com1Port;
  end;
  CurComRate := StrToInt(cmbSetBaud.Text);
  if (CurReaderComPort <> USBPort1) and (CurReaderComPort <> USBPort2) and (CurReaderComPort <> USBPort3) then
  begin
    iResultValue:= SDT_GetCOMBaud(CurReaderComPort, @Baud);
    if iResultValue = 144 then
    begin

    end
    else if iResultValue = 5 Then
    begin
      //Error(ErrorType(iResultValue));
      Error('请检查端口选择是否正确!');
      abort;
    end
    else
    begin
      Error('取串口波特率失败' + ErrorType(iResultValue));
      abort;
    End;

    //设置新的串口波特率
    iResultValue:= SDT_SetCOMBaud(CurReaderComPort, Baud, CurComRate);
    if iResultValue =144 then
    begin

    end
    else
    begin
      Error('设置串口波特率失败!' + ErrorType(iResultValue));
      abort;
    end;
    Sleep (1000);

    {//设置射频适配器最大通信字节数
    iResultValue:= SDT_SetMaxRFByte(CurReaderComPort, iRate, IFOpen);
    if iResultValue =144 then
    begin

    end
    else
    begin
      Error('设置射频适配器最大通信字节数失败!' + ErrorType(iResultValue));
      abort;
    end; }
  end;

  iResultValue := SDT_OpenPort(CurReaderComPort);

  if iResultValue <> $90 then
  begin
    Error('打开读卡器端口失败!' + ErrorType(iResultValue));
    Exit;
  end
  else
  begin
    SDT_ClosePort(CurReaderComPort);
    Success('打开读卡器端口成功!');
    frmMain.MenuSet(1);
    Close;
  end;

end;


procedure TfrmConfigPort.cmbReaderPortNuChange(Sender: TObject);
begin
  if (cmbReaderPortNu.ItemIndex = 6) or (cmbReaderPortNu.ItemIndex = 7) or (cmbReaderPortNu.ItemIndex = 8) then
  begin
    Label1.Enabled := False;
    cmbSetBaud.Enabled := False;
  end
  else
  begin
    Label1.Enabled := True;
    cmbSetBaud.Enabled := True;
  end;
end;

procedure TfrmConfigPort.cmbReaderPortNuClick(Sender: TObject);
begin
  if (cmbReaderPortNu.ItemIndex = 6) or (cmbReaderPortNu.ItemIndex = 7) or (cmbReaderPortNu.ItemIndex = 8) then
  begin
    Label1.Enabled := False;
    cmbSetBaud.Enabled := False;
  end
  else
  begin
    Label1.Enabled := True;
    cmbSetBaud.Enabled := True;
  end;
end;

procedure TfrmConfigPort.edtRateKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key < '0') or (Key > '9') then
  begin
    Key := #0;
  end;
end;

end.
