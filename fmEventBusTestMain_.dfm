object fmEventBusTestMain: TfmEventBusTestMain
  Left = 0
  Top = 0
  Caption = 'fmEventBusTestMain'
  ClientHeight = 256
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 76
    Top = 16
    Width = 121
    Height = 19
    Caption = 'Event Bus Test'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btShowSubForm: TButton
    Left = 16
    Top = 48
    Width = 243
    Height = 25
    Caption = 'show sub Form'
    TabOrder = 0
    OnClick = btShowSubFormClick
  end
  object btPostDefault: TButton
    Left = 16
    Top = 104
    Width = 243
    Height = 25
    Caption = 'post Event Bus'
    TabOrder = 1
    OnClick = btPostDefaultClick
  end
  object btPostContext: TButton
    Left = 16
    Top = 136
    Width = 243
    Height = 25
    Caption = 'post Event Bus(Context)'
    TabOrder = 2
    OnClick = btPostContextClick
  end
  object btPostThread: TButton
    Left = 16
    Top = 168
    Width = 243
    Height = 25
    Caption = 'post Event Bus(Thread)'
    TabOrder = 3
    OnClick = btPostThreadClick
  end
  object btPostClear: TButton
    Left = 16
    Top = 200
    Width = 243
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = btPostClearClick
  end
end
