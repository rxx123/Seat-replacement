unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    btn1: TButton;
    btn2: TButton;
    tmr1: TTimer;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  function GetDevice():Boolean; cdecl; external 'dll_camera.dll';
  function StartDevice():Boolean; cdecl;external 'dll_camera.dll';
  procedure setQRable(bqr:Boolean);cdecl;external 'dll_camera.dll';
  procedure setBarcode(bbarcode:Boolean);cdecl;external 'dll_camera.dll';
  function GetDecodeString(a:pansichar; var len: integer):integer;cdecl; external 'dll_camera.dll';
  procedure ReleaseDevice(); cdecl;external 'dll_camera.dll';
  procedure SetBeepTime(ibeepTime:integer);cdecl;external 'dll_camera.dll';
  procedure SetBeep(bBeep:Boolean);cdecl;external 'dll_camera.dll';

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  if GetDevice()=true then
    begin
      if StartDevice()=true then
        begin
          setBarcode(true);
          setQRable(true);
          SetBeep(true);
          SetBeepTime(200);
          tmr1.Enabled:=true;
        end
      else showmessage('启动设备失败');
    end
  else showmessage('没有发现设备');
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  if GetDevice()=true then
    begin
      ReleaseDevice();
      //tmr1.Enabled :=false;
    end
  else showmessage('没有发现设备');
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
  pAnsiDecode:pAnsiChar;
  ansistrDecode:ansistring;
  nLen: integer;
begin
  setBarcode(false);
  setQRable(false);
  pAnsiDecode := AllocMem(1024);
  setlength(ansistrDecode, 1024);
  GetDecodeString(pAnsiDecode, nLen);
  ansistrDecode := strPas(pAnsiDecode);
  if ansistrDecode<>'' then
    begin
    //  tmr1.Enabled := false;
      edt1.text := ansistrDecode;
     end;
  Sleep(1000);
  setBarcode(true);
  setQRable(true);
end;

end.


