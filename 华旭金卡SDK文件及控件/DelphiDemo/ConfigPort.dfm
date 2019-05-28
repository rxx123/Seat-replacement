object frmConfigPort: TfrmConfigPort
  Left = 304
  Top = 189
  Width = 403
  Height = 229
  Caption = #37197#32622#31471#21475
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = #21326#25991#26032#39759
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  object Label2: TLabel
    Left = 85
    Top = 39
    Width = 100
    Height = 19
    Caption = #35835#21345#22120#31471#21475
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 85
    Top = 95
    Width = 60
    Height = 19
    Caption = #27874#29305#29575
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 285
    Top = 223
    Width = 80
    Height = 19
    Caption = #27169#22359#36895#29575
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 285
    Top = 279
    Width = 80
    Height = 19
    Caption = #36718#24490#26102#38388
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object btnSure: TBitBtn
    Left = 157
    Top = 147
    Width = 73
    Height = 26
    Caption = #30830#23450
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnSureClick
    Kind = bkOK
  end
  object cmbReaderPortNu: TComboBox
    Tag = 999
    Left = 190
    Top = 35
    Width = 145
    Height = 27
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 1
    OnChange = cmbReaderPortNuChange
    OnClick = cmbReaderPortNuClick
    OnKeyPress = cmbPortNoKeyPress
    Items.Strings = (
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5'
      'COM6'
      'USB1'
      'USB2'
      'USB3')
  end
  object cmbSetBaud: TComboBox
    Tag = 999
    Left = 190
    Top = 90
    Width = 145
    Height = 27
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 2
    OnKeyPress = cmbPortNoKeyPress
    Items.Strings = (
      '115200'
      '57600'
      '38400'
      '19200'
      '9600')
  end
  object edtRate: TEdit
    Left = 390
    Top = 217
    Width = 144
    Height = 27
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Visible = False
    OnKeyPress = edtRateKeyPress
  end
  object edtTime: TEdit
    Left = 390
    Top = 272
    Width = 144
    Height = 27
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
    OnKeyPress = edtRateKeyPress
  end
end
