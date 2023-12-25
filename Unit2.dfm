object Form2: TForm2
  Left = 194
  Top = 33
  BorderStyle = bsNone
  Caption = 'ACS-RVND pada CVRPTW'
  ClientHeight = 703
  ClientWidth = 1279
  Color = clBtnHighlight
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'MS Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 23
  object Label1: TLabel
    Left = 467
    Top = 16
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
    Left = 89
    Top = 48
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
    Left = 140
    Top = 80
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 684
    Width = 1279
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = #169' 2022 Yunita Maulinda'
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 128
    Width = 585
    Height = 553
    Caption = 'Titik dan Jarak Customer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object GroupBox4: TGroupBox
      Left = 8
      Top = 296
      Width = 569
      Height = 249
      Caption = 'Jarak Antar Customer'
      TabOrder = 0
      object sgMatriks: TStringGrid
        Left = 8
        Top = 24
        Width = 553
        Height = 217
        ColCount = 2
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnDrawCell = sgMatriksDrawCell
        OnKeyPress = sgMatriksKeyPress
        OnSelectCell = sgMatriksSelectCell
        OnSetEditText = sgMatriksSetEditText
      end
    end
    object PageControl1: TPageControl
      Left = 8
      Top = 24
      Width = 569
      Height = 273
      ActivePage = TabSheet2
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Titik Customer'
        object imgTitik: TImage
          Left = 0
          Top = 0
          Width = 561
          Height = 233
          OnMouseUp = imgTitikMouseUp
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Hasil Rute'
        ImageIndex = 1
        object imgHasil: TImage
          Left = 0
          Top = 0
          Width = 561
          Height = 233
        end
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 600
    Top = 128
    Width = 673
    Height = 553
    Caption = 'Data dan Hasil'
    TabOrder = 2
    object PageControl2: TPageControl
      Left = 8
      Top = 24
      Width = 657
      Height = 521
      ActivePage = TabSheet3
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object TabSheet3: TTabSheet
        Caption = 'Data Customer'
        object Label4: TLabel
          Left = 344
          Top = 16
          Width = 161
          Height = 21
          Caption = 'Kapasitas Kendaraan'
        end
        object Label5: TLabel
          Left = 344
          Top = 56
          Width = 239
          Height = 21
          Caption = 'Kecepatan Kendaraan (km/jam)'
        end
        object Label6: TLabel
          Left = 344
          Top = 96
          Width = 151
          Height = 21
          Caption = 'Time Window (jam)'
        end
        object Label7: TLabel
          Left = 344
          Top = 136
          Width = 143
          Height = 21
          Caption = 'Global Pheromone'
        end
        object Label8: TLabel
          Left = 344
          Top = 176
          Width = 171
          Height = 21
          Caption = 'Pheromone Feasibility'
        end
        object Label9: TLabel
          Left = 344
          Top = 216
          Width = 135
          Height = 21
          Caption = 'Local Pheromone'
        end
        object Label10: TLabel
          Left = 344
          Top = 256
          Width = 138
          Height = 21
          Caption = 'Banyak Semut (m)'
        end
        object Label11: TLabel
          Left = 344
          Top = 336
          Width = 132
          Height = 21
          Caption = 'Iterasi Maksimum'
        end
        object Label12: TLabel
          Left = 344
          Top = 296
          Width = 188
          Height = 21
          Caption = 'Iterasi Maksimum RVND'
        end
        object sgCust: TStringGrid
          Left = 0
          Top = 0
          Width = 337
          Height = 481
          ColCount = 3
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          TabOrder = 0
          OnKeyPress = sgCustKeyPress
          OnSetEditText = sgCustSetEditText
        end
        object edKapasitas: TEdit
          Left = 592
          Top = 8
          Width = 49
          Height = 29
          TabOrder = 1
        end
        object edKecepatan: TEdit
          Left = 592
          Top = 48
          Width = 49
          Height = 29
          TabOrder = 2
        end
        object edTW: TEdit
          Left = 592
          Top = 88
          Width = 49
          Height = 29
          TabOrder = 3
        end
        object edA: TEdit
          Left = 592
          Top = 128
          Width = 49
          Height = 29
          TabOrder = 4
        end
        object edB: TEdit
          Left = 592
          Top = 168
          Width = 49
          Height = 29
          TabOrder = 5
        end
        object edP: TEdit
          Left = 592
          Top = 208
          Width = 49
          Height = 29
          TabOrder = 6
        end
        object edM: TEdit
          Left = 592
          Top = 248
          Width = 49
          Height = 29
          TabOrder = 7
        end
        object edIter: TEdit
          Left = 592
          Top = 328
          Width = 49
          Height = 29
          TabOrder = 8
        end
        object Button1: TButton
          Left = 344
          Top = 424
          Width = 297
          Height = 41
          Caption = 'Proses RVND'
          TabOrder = 9
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 344
          Top = 368
          Width = 297
          Height = 41
          Caption = 'Proses ACS'
          TabOrder = 10
          OnClick = Button2Click
        end
        object edRVND: TEdit
          Left = 592
          Top = 288
          Width = 49
          Height = 29
          TabOrder = 11
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Perhitungan Rute'
        ImageIndex = 1
        object mmOutput: TMemo
          Left = 0
          Top = 0
          Width = 649
          Height = 481
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object Home1: TMenuItem
      Caption = 'Home'
      object Cover1: TMenuItem
        Caption = 'Halaman Utama'
        OnClick = Cover1Click
      end
      object Keluar1: TMenuItem
        Caption = 'Keluar'
        ShortCut = 16465
        OnClick = Keluar1Click
      end
    end
    object File1: TMenuItem
      Caption = 'File'
      object Buka1: TMenuItem
        Caption = 'Buka'
        OnClick = Buka1Click
      end
      object Dataset1: TMenuItem
        Caption = 'Dataset'
        OnClick = Dataset1Click
      end
      object Simpan1: TMenuItem
        Caption = 'Simpan'
        OnClick = Simpan1Click
      end
      object Hapus1: TMenuItem
        Caption = 'Hapus'
        OnClick = Hapus1Click
      end
    end
    object Proses1: TMenuItem
      Caption = 'Proses'
      object N2Opt1: TMenuItem
        Caption = '2-Opt'
        OnClick = N2Opt1Click
      end
      object Cross1: TMenuItem
        Caption = 'Cross'
        OnClick = Cross1Click
      end
      object Exchange1: TMenuItem
        Caption = 'Exchange'
        OnClick = Exchange1Click
      end
      object OrOpt1: TMenuItem
        Caption = 'Or-Opt'
        OnClick = OrOpt1Click
      end
      object Reverse1: TMenuItem
        Caption = 'Reverse'
        OnClick = Reverse1Click
      end
      object Shift101: TMenuItem
        Caption = 'Shift(1,0)'
        OnClick = Shift101Click
      end
      object Shift201: TMenuItem
        Caption = 'Shift(2,0)'
        OnClick = Shift201Click
      end
      object Swap111: TMenuItem
        Caption = 'Swap(1,1)'
        OnClick = Swap111Click
      end
      object Swap211: TMenuItem
        Caption = 'Swap(2,1)'
        OnClick = Swap211Click
      end
      object Swap221: TMenuItem
        Caption = 'Swap(2,2)'
        OnClick = Swap221Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Left = 88
    Top = 8
  end
  object XMLDocument1: TXMLDocument
    Left = 128
    Top = 8
    DOMVendorDesc = 'MSXML'
  end
end
