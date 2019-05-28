object Form1: TForm1
  Left = 192
  Top = 130
  Caption = 'Form1'
  ClientHeight = 170
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edt1: TEdit
    Left = 72
    Top = 40
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object btn1: TButton
    Left = 72
    Top = 96
    Width = 89
    Height = 25
    Caption = #25195#30721
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 184
    Top = 96
    Width = 113
    Height = 25
    Caption = #20851#38381
    TabOrder = 2
    OnClick = btn2Click
  end
  object tmr1: TTimer
    Enabled = False
    OnTimer = tmr1Timer
    Left = 24
    Top = 40
  end
end
