object frmMain: TfrmMain
  Left = 192
  Top = 119
  Width = 745
  Height = 480
  Caption = #20108#20195#35777#35835#21462#27979#35797#31243#24207
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 402
    Width = 737
    Height = 24
    BiDiMode = bdRightToLeft
    Color = clSkyBlue
    Panels = <
      item
        Width = 260
      end
      item
        Text = ' www.hxgc.com.cn'
        Width = 150
      end
      item
        Text = ' '#25216#26415#25903#25345#30005#35805#65306'(010)51616033 '#20256#30495#65306'(010)51616099'
        Width = 50
      end>
    ParentBiDiMode = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 737
    Height = 402
    Align = alClient
    Color = clSkyBlue
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 632
    Top = 64
    object miSetManage: TMenuItem
      Caption = #31995#32479#31649#29702'(&M)'
      object miCreatePort: TMenuItem
        Caption = #25171#24320#31471#21475'(&O)'
        OnClick = miCreatePortClick
      end
      object miClosePort: TMenuItem
        Caption = #20851#38381#31471#21475'(&C)'
        Visible = False
        OnClick = miClosePortClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = #36864#20986'(&X)'
        OnClick = miExitClick
      end
    end
    object miOperator: TMenuItem
      Caption = #25805#20316'(&O)'
      object miReadSEIDInfo: TMenuItem
        Caption = #35835#21462#20108#20195#35777#20449#24687'(&R)'
        OnClick = miReadSEIDInfoClick
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 561
    Top = 124
  end
end
