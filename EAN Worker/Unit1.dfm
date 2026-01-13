object Form1: TForm1
  Left = 245
  Top = 125
  Caption = 'EAN Worker'
  ClientHeight = 555
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 620
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 616
    object Label3: TLabel
      Left = 23
      Top = 5
      Width = 215
      Height = 39
      Caption = 'EAN-GTIN Worker'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Impact'
      Font.Style = []
      ParentFont = False
    end
    object Image1: TImage
      Left = 469
      Top = 17
      Width = 20
      Height = 20
      AutoSize = True
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 46
    Width = 620
    Height = 490
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    TabStop = False
    ExplicitWidth = 616
    ExplicitHeight = 489
    object TabSheet1: TTabSheet
      Caption = 'Generator'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 462
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitHeight = 461
        object Label1: TLabel
          Left = 11
          Top = 14
          Width = 85
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Type of the EAN :'
        end
        object Label2: TLabel
          Left = 11
          Top = 59
          Width = 31
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Code :'
        end
        object Label4: TLabel
          Left = 11
          Top = 149
          Width = 53
          Height = 13
          Caption = 'Bar Width :'
        end
        object Label5: TLabel
          Left = 8
          Top = 177
          Width = 56
          Height = 13
          Caption = 'Bar Height :'
        end
        object Label6: TLabel
          Left = 15
          Top = 245
          Width = 91
          Height = 13
          Caption = 'Background Color :'
        end
        object Shape1: TShape
          Left = 112
          Top = 243
          Width = 22
          Height = 17
          Cursor = crHandPoint
          OnMouseDown = Shape1MouseDown
        end
        object Label7: TLabel
          Left = 21
          Top = 123
          Width = 43
          Height = 13
          Caption = 'Pixel Bit :'
        end
        object Label8: TLabel
          Left = 14
          Top = 206
          Width = 50
          Height = 13
          Caption = 'Font Size :'
        end
        object EditCode: TEdit
          Left = 11
          Top = 78
          Width = 123
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabStop = False
          TabOrder = 0
          Text = '*BARCODE39*'
          OnChange = EditCodeChange
        end
        object ComboBox1: TComboBox
          Left = 11
          Top = 32
          Width = 123
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 1
          TabStop = False
          Text = 'EAN13'
          OnChange = ComboBox1Change
          Items.Strings = (
            'EAN8'
            'EAN13'
            'Code39')
        end
        object Button1: TButton
          Left = 80
          Top = 431
          Width = 50
          Height = 25
          Caption = 'Save'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object SpinEdit1: TSpinEdit
          Left = 70
          Top = 147
          Width = 64
          Height = 22
          TabStop = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 4
          OnChange = SpinEdit1Change
        end
        object SpinEdit2: TSpinEdit
          Left = 70
          Top = 175
          Width = 64
          Height = 22
          TabStop = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 145
          OnChange = SpinEdit2Change
        end
        object Button4: TButton
          Left = 11
          Top = 431
          Width = 50
          Height = 25
          Caption = 'Print'
          TabOrder = 5
          TabStop = False
          OnClick = Button4Click
        end
        object ComboBox2: TComboBox
          Left = 70
          Top = 120
          Width = 64
          Height = 21
          Style = csDropDownList
          ItemIndex = 2
          TabOrder = 6
          TabStop = False
          Text = '32'
          OnChange = ComboBox2Change
          Items.Strings = (
            '8'
            '24'
            '32')
        end
        object CheckBox1: TCheckBox
          Left = 50
          Top = 278
          Width = 80
          Height = 17
          TabStop = False
          Caption = 'Transparent'
          TabOrder = 7
        end
        object SpinEdit3: TSpinEdit
          Left = 70
          Top = 203
          Width = 64
          Height = 22
          TabStop = False
          MaxValue = 72
          MinValue = 1
          TabOrder = 8
          Value = 8
          OnChange = SpinEdit3Change
        end
        object CheckBox2: TCheckBox
          Left = 50
          Top = 301
          Width = 51
          Height = 17
          TabStop = False
          Caption = 'Invert'
          TabOrder = 9
        end
        object CheckBox3: TCheckBox
          Left = 50
          Top = 324
          Width = 46
          Height = 17
          TabStop = False
          Caption = 'Bold'
          Checked = True
          State = cbChecked
          TabOrder = 10
          OnClick = CheckBox3Click
        end
        object GroupBox1: TGroupBox
          Left = 11
          Top = 354
          Width = 123
          Height = 65
          Caption = ' Print Zoom '
          TabOrder = 11
          object Label10: TLabel
            Left = 25
            Top = 32
            Width = 25
            Height = 13
            Caption = 'in % :'
          end
          object SpinEdit4: TSpinEdit
            Left = 59
            Top = 29
            Width = 45
            Height = 22
            TabStop = False
            MaxValue = 100
            MinValue = 1
            TabOrder = 0
            Value = 100
          end
        end
      end
      object ScrollBox1: TScrollBox
        Left = 145
        Top = 0
        Width = 467
        Height = 462
        HorzScrollBar.Smooth = True
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 1
        ExplicitWidth = 463
        ExplicitHeight = 461
        object BarCode1: TBarCode
          Left = 3
          Top = 15
          Width = 391
          Height = 145
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          BarCodeType = EAN13
          Code = '3290123456786'
          BarWidth = 4
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Reader'
      ImageIndex = 1
      object Image2: TImage
        Left = 3
        Top = 3
        Width = 230
        Height = 145
        AutoSize = True
      end
      object Panel3: TPanel
        Left = 0
        Top = 407
        Width = 612
        Height = 55
        Align = alBottom
        TabOrder = 0
        object Label9: TLabel
          Left = 176
          Top = 21
          Width = 56
          Height = 13
          Caption = 'EAN-Code :'
        end
        object Button2: TButton
          Left = 7
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Bitmap'
          TabOrder = 0
          TabStop = False
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 88
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Read'
          TabOrder = 1
          TabStop = False
          OnClick = Button3Click
        end
        object Edit1: TEdit
          Left = 238
          Top = 18
          Width = 171
          Height = 21
          TabStop = False
          ReadOnly = True
          TabOrder = 2
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 536
    Width = 620
    Height = 19
    Panels = <
      item
        Text = 'Bar Code :'
        Width = 65
      end
      item
        Text = 'EAN13'
        Width = 250
      end
      item
        Text = 'Bit :'
        Width = 30
      end
      item
        Text = '32'
        Width = 50
      end>
    ExplicitTop = 535
    ExplicitWidth = 616
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 500
    Top = 105
  end
  object ColorDialog1: TColorDialog
    Left = 364
    Top = 129
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp|Jpeg;Jpg (*.jpg)|*.jpg'
    Left = 284
    Top = 129
  end
end
