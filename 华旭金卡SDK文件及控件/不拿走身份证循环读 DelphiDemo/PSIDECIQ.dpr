program PSIDECIQ;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  ConfigPort in 'ConfigPort.pas' {frmConfigPort},
  CardDll in 'CardDll.pas',
  Global in 'Global.pas',
  ReadSID in 'ReadSID.pas' {frmReadSID},
  InputThread in 'InputThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
