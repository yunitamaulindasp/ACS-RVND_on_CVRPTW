object Form1: TForm1
  Left = 240
  Top = 0
  BorderStyle = bsNone
  Caption = 'ACS-RVND pada CVRPTW'
  ClientHeight = 722
  ClientWidth = 1279
  Color = clBtnHighlight
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'MS Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 27
  object Label1: TLabel
    Left = 465
    Top = 270
    Width = 348
    Height = 27
    Caption = 'IMPLEMENTASI ALGORITMA'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 87
    Top = 302
    Width = 1104
    Height = 27
    Caption = 
      'ANT COLONY SYSTEM - RANDOMIZED VARIABLE NEIGHBOURHOOD DESCENT (A' +
      'CS-RVND)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 138
    Top = 334
    Width = 1001
    Height = 27
    Caption = 
      'PADA CAPACITATED VEHICLE ROUTING PROBLEM WITH TIME WINDOW (CVRPT' +
      'W)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 561
    Top = 371
    Width = 157
    Height = 27
    Caption = 'September 2022'
  end
  object Button2: TButton
    Left = 467
    Top = 411
    Width = 345
    Height = 41
    Caption = 'Mulai'
    TabOrder = 0
    OnClick = Button2Click
  end
end
