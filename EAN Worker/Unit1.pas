unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, BarCode, Vcl.ComCtrls, Vcl.ExtDlgs,
  Vcl.Samples.Spin, Vcl.Printers, Jpeg, WinApi.ShellApi;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label3: TLabel;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EditCode: TEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    Image2: TImage;
    Panel3: TPanel;
    Button2: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    Button3: TButton;
    Edit1: TEdit;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Button4: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape1: TShape;
    ColorDialog1: TColorDialog;
    SaveDialog1: TSaveDialog;
    Image1: TImage;
    ComboBox2: TComboBox;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    SpinEdit3: TSpinEdit;
    Label8: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label9: TLabel;
    ScrollBox1: TScrollBox;
    BarCode1: TBarCode;
    GroupBox1: TGroupBox;
    SpinEdit4: TSpinEdit;
    Label10: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure EditCodeChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string);
var
  Bmp: TBitmap;
  Jpg: TJPEGImage;
begin
  Bmp := TBitmap.Create;
  Jpg := TJPEGImage.Create;
  try
    Bmp.LoadFromFile(BmpFileName);
    Jpg.Assign(Bmp);
    Jpg.SaveToFile(JpgFileName);
  finally
    Jpg.Free;
    Bmp.Free;
  end;
end;

function InvertBitmap(MyBitmap: TBitmap): TBitmap;
var
  x, y: Integer;
  ByteArray: PByteArray;
begin
  MyBitmap.PixelFormat := pf24Bit;
  for y := 0 to MyBitmap.Height - 1 do
  begin
    ByteArray := MyBitmap.ScanLine[y];
    for x := 0 to MyBitmap.Width * 3 - 1 do
    begin
      ByteArray[x] := 255 - ByteArray[x];
    end;
  end;
  Result := MyBitmap;
end;


procedure DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
var
  Header, Bits: Pointer;
  HeaderSize: DWORD;
  BitsSize: DWORD;
begin
  GetDIBSizes(ABitmap.Handle, HeaderSize, BitsSize);
  Header := AllocMem(HeaderSize);
  Bits := AllocMem(BitsSize);
  try
    GetDIB(ABitmap.Handle, ABitmap.Palette, Header^, Bits^);
    StretchDIBits(Canvas.Handle, DestRect.Left, DestRect.Top,
      DestRect.Right, DestRect.Bottom,
      0, 0, ABitmap.Width, ABitmap.Height, Bits, TBitmapInfo(Header^),
      DIB_RGB_COLORS, SRCCOPY);
  finally
    FreeMem(Header, HeaderSize);
    FreeMem(Bits, BitsSize);
  end;
end;

procedure PrintImage(Image: TImage; ZoomPercent: Integer);
  // if ZoomPercent=100, Image will be printed across the whole page
var
  relHeight, relWidth: integer;
begin
  Screen.Cursor := crHourglass;

  try
    Printer.BeginDoc;
    with Image.Picture.Bitmap do
    begin
      if ((Width / Height) > (Printer.PageWidth / Printer.PageHeight)) then
      begin
        // Stretch Bitmap to width of PrinterPage
        relWidth := Printer.PageWidth;
        relHeight := MulDiv(Height, Printer.PageWidth, Width);
      end
      else
      begin
        // Stretch Bitmap to height of PrinterPage
        relWidth  := MulDiv(Width, Printer.PageHeight, Height);
        relHeight := Printer.PageHeight;
      end;
      relWidth := Round(relWidth * ZoomPercent / 100);
      relHeight := Round(relHeight * ZoomPercent / 100);
      DrawImage(Printer.Canvas, Rect(0, 0, relWidth, relHeight), Image.Picture.Bitmap);
    end;
  finally
    Screen.cursor := crDefault;
  end;
  Printer.EndDoc;
  Screen.cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Bitmap: TBitmap;
  Source: TRect;
  Dest: TRect;
begin
  Bitmap := TBitmap.Create;
  try
    case ComboBox2.ItemIndex of
      0 : Bitmap.PixelFormat := pf8bit;
      1 : Bitmap.PixelFormat := pf24bit;
      else
        Bitmap.PixelFormat := pf32bit;
    end;

    if CheckBox1.Checked = true then
    begin
      Bitmap.Transparent := true;
      Bitmap.TransparentColor := clWhite;
    end;

    with Bitmap do
    begin
      Width := BarCode1.Width;
      Height := BarCode1.Height;
      Dest := Rect(0, 0, Width, Height);
    end;

    with BarCode1 do
      Source := Rect(0, 0, Width, Height);
      Bitmap.Canvas.CopyRect(Dest, BarCode1.Canvas, Source);

    if CheckBox2.Checked = true then
    begin
      Image1.Picture.Bitmap.Assign(Bitmap);
      Image1.Picture.Bitmap := InvertBitmap(Image1.Picture.Bitmap);
      Image1.Refresh;
      Bitmap.Assign(Image1.Picture.Bitmap);
    end;

    if SaveDialog1.Execute then
    begin
      if SaveDialog1.FilterIndex = 1 then
        begin
            Bitmap.SaveToFile(SaveDialog1.FileName + '.bmp');
        end;

      if SaveDialog1.FilterIndex = 2 then
        begin
            Bitmap.SaveToFile(ExtractFilePath(Application.ExeName) + 'Data\Backup\_.bmp');
            Bmp2Jpeg(ExtractFilePath(Application.ExeName) + 'Data\Backup\_.bmp',
                    SaveDialog1.FileName + '.jpg');
        end;
    end;
  finally
    Bitmap.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    begin
      Image2.Picture.Loadfromfile(OpenPictureDialog1.filename);
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i, start, stop,
  p, laenge, farbe : integer;
  scode, scode2,
  s, c, cs : string;
  punkt1, punkt2 : tpoint;
begin
    //left, right Point
    punkt1.x:=2;
    punkt2.x:=image2.width-2;
    punkt1.y:=image2.height div 2;
    punkt2.y:=punkt2.y;

    farbe:=image2.Canvas.Pixels[punkt1.x,punkt1.y];
    i:=punkt1.x;
    while image2.canvas.pixels[i,punkt1.y]= farbe do inc(i);
    start:=i;
    i:=punkt2.x;
    while image2.canvas.pixels[i,punkt1.y]= farbe do dec(i);
    stop:=i+1;

    laenge:=round((stop-start)/95);
    scode:='';
    for i:=0 to 94 do
      if image2.Canvas.Pixels[start+i*laenge,punkt1.y]<>farbe then scode:=scode+'1'
                                                          else scode:=scode+'0';
    scode2:=scode;
    c:='';
    cs:='';
    for i:=1 to 6 do
    begin
      s:='';
      s:=scode2[i*7-3]+scode2[i*7-2]+scode2[i*7-1]+scode2[i*7]+scode2[i*7+1]+
         scode2[i*7+2]+scode2[i*7+3];

      if s='0001101' then begin c:=c+'0'; cs:=cs+'A'; end;
      if s='0100111' then begin c:=c+'0'; cs:=cs+'B'; end;
      if s='0011001' then begin c:=c+'1'; cs:=cs+'A'; end;
      if s='0110011' then begin c:=c+'1'; cs:=cs+'B'; end;
      if s='0010011' then begin c:=c+'2'; cs:=cs+'A'; end;
      if s='0011011' then begin c:=c+'2'; cs:=cs+'B'; end;
      if s='0111101' then begin c:=c+'3'; cs:=cs+'A'; end;
      if s='0100001' then begin c:=c+'3'; cs:=cs+'B'; end;
      if s='0100011' then begin c:=c+'4'; cs:=cs+'A'; end;
      if s='0011101' then begin c:=c+'4'; cs:=cs+'B'; end;
      if s='0110001' then begin c:=c+'5'; cs:=cs+'A'; end;
      if s='0111001' then begin c:=c+'5'; cs:=cs+'B'; end;
      if s='0101111' then begin c:=c+'6'; cs:=cs+'A'; end;
      if s='0000101' then begin c:=c+'6'; cs:=cs+'B'; end;
      if s='0111011' then begin c:=c+'7'; cs:=cs+'A'; end;
      if s='0010001' then begin c:=c+'7'; cs:=cs+'B'; end;
      if s='0110111' then begin c:=c+'8'; cs:=cs+'A'; end;
      if s='0001001' then begin c:=c+'8'; cs:=cs+'B'; end;
      if s='0001011' then begin c:=c+'9'; cs:=cs+'A'; end;
      if s='0010111' then begin c:=c+'9'; cs:=cs+'B'; end;
    end;

    if cs='AAAAAA' then c:='0'+c;
    if cs='AABABB' then c:='1'+c;
    if cs='AABBAB' then c:='2'+c;
    if cs='AABBBA' then c:='3'+c;
    if cs='ABAABB' then c:='4'+c;
    if cs='ABBAAB' then c:='5'+c;
    if cs='ABBBAA' then c:='6'+c;
    if cs='ABABAB' then c:='7'+c;
    if cs='ABABBA' then c:='8'+c;
    if cs='ABBABA' then c:='9'+c;

    for i:=1 to 6 do
    begin
      s:='';
      s:=scode2[i*7+44]+scode2[i*7+45]+scode2[i*7+46]+scode2[i*7+47]+
         scode2[i*7+48]+scode2[i*7+49]+scode2[i*7+50];

      if s='1110010' then c:=c+'0';
      if s='1100110' then c:=c+'1';
      if s='1101100' then c:=c+'2';
      if s='1000010' then c:=c+'3';
      if s='1011100' then c:=c+'4';
      if s='1001110' then c:=c+'5';
      if s='1010000' then c:=c+'6';
      if s='1000100' then c:=c+'7';
      if s='1001000' then c:=c+'8';
      if s='1110100' then c:=c+'9';
    end;

    Edit1.Text := c;
    if length(c)= 13 then
       p:=strtoint(c[1])+3*strtoint(c[2])+strtoint(c[3])+3*strtoint(c[4])+strtoint(c[5])
       +3*strtoint(c[6])+strtoint(c[7])+3*strtoint(c[8])+strtoint(c[9])
       +3*strtoint(c[10])+strtoint(c[11])+3*strtoint(c[12])+strtoint(c[13])
    else
      p:=-1;

    if p mod 10 = 0 then // correct
    else
      if p=-1 then Edit1.Text:='incorrect range information'
              else Edit1.Text:='not correct';
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Bitmap: TBitmap;
  Source: TRect;
  Dest: TRect;
begin
  Bitmap := TBitmap.Create;
  try
    case ComboBox2.ItemIndex of
      0 : Bitmap.PixelFormat := pf8bit;
      1 : Bitmap.PixelFormat := pf24bit;
      else
        Bitmap.PixelFormat := pf32bit;
    end;

    if CheckBox1.Checked = true then
    begin
      Bitmap.Transparent := true;
      Bitmap.TransparentColor := clWhite;
    end;

    with Bitmap do
    begin
      Width := BarCode1.Width;
      Height := BarCode1.Height;
      Dest := Rect(0, 0, Width, Height);
    end;

    with BarCode1 do
      Source := Rect(0, 0, Width, Height);
      Bitmap.Canvas.CopyRect(Dest, BarCode1.Canvas, Source);

    if CheckBox2.Checked = true then
    begin
      Image1.Picture.Bitmap.Assign(Bitmap);
      Image1.Picture.Bitmap := InvertBitmap(Image1.Picture.Bitmap);
      Image1.Refresh;
      Bitmap.Assign(Image1.Picture.Bitmap);
    end;

    Image1.Height := BarCode1.Height;
    Image1.Width := BarCode1.Width;
    Image1.Picture.Bitmap.Assign(Bitmap);
  finally
    Bitmap.Free;
  end;

  // Print image zoom in %
  PrintImage(Image1, SpinEdit4.Value);
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = true then
  begin
    BarCode1.Font.Style := [fsBold];
  end else begin
    BarCode1.Font.Style := [];
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  BarCode1.BarCodeType := TBarCodeType(ComboBox1.ItemIndex);
  EditCode.Text := BarCode1.Code;
  StatusBar1.Panels[1].Text := ComboBox1.Text;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
  0 : StatusBar1.Panels[3].Text := '8';
  1 : StatusBar1.Panels[3].Text := '24';
  2 : StatusBar1.Panels[3].Text := '32';
  end;
end;

procedure TForm1.EditCodeChange(Sender: TObject);
var
  Savepos,L:integer;
begin
  SavePos := EditCode.SelStart;
  L := length(EditCode.text);
  if (L<12) and (BarCode1.BarCodeType=EAN13) then exit;
  if (L<8) and (BarCode1.BarCodeType=EAN8) then exit;

  BarCode1.Code := EditCode.Text;
  EditCode.Text := BarCode1.Code;
  EditCode.SelStart := SavePos;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    BarCode1.Color := ColorDialog1.Color;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  BarCode1.BarWidth := SpinEdit1.Value;
  BarCode1.Repaint;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  BarCode1.Height := SpinEdit2.Value;
  BarCode1.Repaint;
end;

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
  BarCode1.Font.Size := SpinEdit3.Value;
  BarCode1.Repaint;
end;

end.
