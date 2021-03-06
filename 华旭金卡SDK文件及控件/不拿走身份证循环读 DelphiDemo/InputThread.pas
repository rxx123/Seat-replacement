{***********************************************************************
             Copyright（C），北京华旭金卡
   文件名：InputThread.pas   流文件
     作者：任杰
     版本：1.0
 生成日期：2006-04-12
 功能描述：
 调用接口：
 提供接口：
  　　  　

************************************************************************}
unit InputThread;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, SyncObjs;

type
  PReadPack = ^TReadPack;
  TReadPack = Record
     ReadByte: Array [1..1024] of Byte;
     Size: Cardinal;
  End;
Type
  //线程声明
  TComRead = Class(TThread)

    protected
      procedure Execute; override;
    end;

  TGetErrMessage = Class(TThread)

    protected
      procedure Execute; override;
    end;


Var
  Read_Buffer: Tlist;
  pBuf : PChar; 
  CS          : TCriticalSection;
implementation

uses Global, ReadSID;

{ TComRead }

procedure TComRead.Execute;
begin
  inherited;
  while not Terminated do
  begin
    Case GEvent of
      ReadyReadRec:
      begin
        Cs.Enter;  //进入临界区
        frmReadSID.ReadCard;
        Cs.Leave;  
      end;
      {ErrRec:
      begin
        Cs.Enter;  //进入临界区
        frmReadSID.ErrorRec;
        Cs.Leave;
      end;}
    else 
      Sleep(500);
    end;
    //
  end;
end;

{ TComGetErrMessage }

procedure TGetErrMessage.Execute;
begin
  inherited;
  while not Terminated do
  begin
    if  (GEvent <> ReadyReadRec) and (GEvent <> NoEvent) then
    begin
      Cs.Enter;  //进入临界区
      frmReadSID.SetErrMsg(GEvent);
      Cs.Leave;
    end;
      {ErrRec:
      begin
        Cs.Enter;  //进入临界区
        frmReadSID.ErrorRec;
        Cs.Leave;
      end;}

      Sleep(20);
        //
  end;
end;

end.
