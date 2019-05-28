unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, jpeg, DB, ADODB;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    miSetManage: TMenuItem;
    miCreatePort: TMenuItem;
    miClosePort: TMenuItem;
    N8: TMenuItem;
    miExit: TMenuItem;
    miOperator: TMenuItem;
    miReadSEIDInfo: TMenuItem;
    Timer1: TTimer;
    Panel1: TPanel;
    procedure Timer1Timer(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miCreatePortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miReadSEIDInfoClick(Sender: TObject);
    procedure miClosePortClick(Sender: TObject);
  private
    { Private declarations }
    Procedure Init;
    function DataBaseCfg: integer;

  public
    { Public declarations }
    Procedure MenuSet(SetValue: Integer);
  end;

var
  frmMain: TfrmMain;

implementation

uses ConfigPort, CardDll, Global, ReadSID;

{$R *.dfm}

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  statusBar1.Panels[0].Text:= '登录日期:'+datetostr(date)+'  '+'时间:'+timetostr(now);
end;

procedure TfrmMain.miExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.miCreatePortClick(Sender: TObject);
begin
  if Not Assigned(frmConfigPort) then
  begin
    frmConfigPort := TfrmConfigPort.Create(Application);
  end;
  frmConfigPort.Show;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  DllHandle: THandle;
  iResultValue: integer;
begin
  DllHandle := loadlibrary(SDTAPIDll);
  if DllHandle = 0 then
  begin
    Error(SDTAPIDll + '动态库不存在或损坏，请检查后重试!');
    Abort;
  end;
  DllHandle:=loadlibrary(WltRSDll);
  if DllHandle = 0 then
  begin
    Error(WltRSDll + '动态库不存在或损坏，请检查后重试!');
    Abort;
  end;
  FreeLibrary(DllHandle);
  Init;
  {DataBasePath := GetDirPath + 'Data\' + ZTDB;
  if not FileExists(DataBasePath) then
  begin
    Error('没有找到' + DataBasePath + '数据库文件');
    exit;
  end;
  iResultValue := DataBaseCfg;
  if iResultValue <> 0 then
  begin
    exit;
  end; }
end;

procedure TfrmMain.miReadSEIDInfoClick(Sender: TObject);
begin
  if Not Assigned(frmReadSID) then
  begin
    frmReadSID := TfrmReadSID.Create(Application);
  end;
  frmReadSID.Show;
end;

procedure TfrmMain.miClosePortClick(Sender: TObject);
var
  iResultValue: integer;
begin
  //iResultValue := SDT_ClosePort(CurReaderComPort);
  //SDT_ClosePort(CurReaderComPort);
  if iResultValue <> $90 then
  begin
    Error('关闭读卡器端口失败!' + ErrorType(iResultValue));
    Exit;
  end
  else
  begin
    frmMain.MenuSet(0);
    Success('关闭读卡器端口成功!');
    
    //Close;
  end;
end;

function TfrmMain.DataBaseCfg: integer;
begin
  
  Result := 0;
end;

procedure TfrmMain.Init;
begin
  MenuSet(1);
end;

procedure TfrmMain.MenuSet(SetValue: Integer);
begin
  Case SetValue of
    0:
    begin
      miCreatePort.Enabled := True;
      //miClosePort.Enabled := False;
      miOperator.Enabled := False;
    end;
    1:
    begin
      //miCreatePort.Enabled := False;
      //miClosePort.Enabled := True;
      miOperator.Enabled := True;
    end;
    //N
  end;
end;

end.
