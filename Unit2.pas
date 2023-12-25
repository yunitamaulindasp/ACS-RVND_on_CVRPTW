unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, Grids, ExtCtrls, xmldom, XMLIntf,
  msxmldom, XMLDoc, Math;

type  Rute = array of array of integer;
      Matriks = array of array of real;
      Graph = record
        mtBobot, mtWaktu : matriks;
        size : integer;
      end;

type  Titik = record
        posisi : TPoint;
        warna : TColor;
      end;

type  Customer = record
        Cust, Permintaan : integer;
        Waktu : Real;
      end;
type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    Home1: TMenuItem;
    Cover1: TMenuItem;
    Keluar1: TMenuItem;
    File1: TMenuItem;
    Buka1: TMenuItem;
    Simpan1: TMenuItem;
    Hapus1: TMenuItem;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    XMLDocument1: TXMLDocument;
    Dataset1: TMenuItem;
    Proses1: TMenuItem;
    Shift101: TMenuItem;
    Shift201: TMenuItem;
    Swap111: TMenuItem;
    Swap211: TMenuItem;
    Swap221: TMenuItem;
    Cross1: TMenuItem;
    N2Opt1: TMenuItem;
    OrOpt1: TMenuItem;
    Reverse1: TMenuItem;
    Exchange1: TMenuItem;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    sgMatriks: TStringGrid;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    imgTitik: TImage;
    imgHasil: TImage;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    sgCust: TStringGrid;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edKapasitas: TEdit;
    edKecepatan: TEdit;
    edTW: TEdit;
    edA: TEdit;
    edB: TEdit;
    edP: TEdit;
    edM: TEdit;
    edIter: TEdit;
    mmOutput: TMemo;
    Button1: TButton;
    Button2: TButton;
    edRVND: TEdit;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure imgTitikMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgMatriksKeyPress(Sender: TObject; var Key: Char);
    procedure sgMatriksSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure sgMatriksDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgMatriksSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgCustKeyPress(Sender: TObject; var Key: Char);
    procedure sgCustSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure Keluar1Click(Sender: TObject);
    procedure Buka1Click(Sender: TObject);
    procedure Simpan1Click(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
    procedure Dataset1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Shift101Click(Sender: TObject);
    procedure Shift201Click(Sender: TObject);
    procedure Swap111Click(Sender: TObject);
    procedure Swap211Click(Sender: TObject);
    procedure Swap221Click(Sender: TObject);
    procedure Cross1Click(Sender: TObject);
    procedure N2Opt1Click(Sender: TObject);
    procedure OrOpt1Click(Sender: TObject);
    procedure Reverse1Click(Sender: TObject);
    procedure Exchange1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Cover1Click(Sender: TObject);
  private
    G : graph;
    arTitik : array of Titik;
    arCust : array of Customer;
    pheromone : array of Matriks;
    tabulist,Solusi,copySolusi,pilihSolusi : Rute;
    tabulistpilih, tabulistterpilih : array of integer;

  public
    procedure GambarTitik (const index : Integer; const repaint: Boolean);
    procedure GambarSisi(const v1, v2: byte);
    procedure GambarBobot(const v1, v2: byte);
    procedure HapusBobot(const v1, v2: byte);
    procedure HapusSisi(const v1, v2: byte);
    procedure Buka;
    procedure Dataset;
    procedure Hapus;
    procedure Simpan;
    procedure ACS;
    Function HitungJarak(rute: array of integer):real;
    function HitungK(rute: array of integer): integer;
    function HitungW(rute: array of integer): real;
    function TotalJarak(s: rute): real;
    function TotalWaktu(s: rute): real;
    procedure Cross(const s: rute);
    procedure Swap11(const s: rute);
    procedure Swap21(const s: rute);
    procedure Swap22(const s: rute);
    procedure Shift10(const s: rute);
    procedure Shift20(const s: rute);
    procedure Opt2(const s: rute);
    procedure OrOpt(const s: rute);
    procedure Reverse(const s: rute);
    procedure Exchange(const s: rute);
    procedure Parameter;
    procedure Update;
  end;

var
  Form2: TForm2;
  m,Q,itermax,titikawal,itermaxRVND : integer;
  alfa,beta,rho,TW,kecepatan : real;

implementation

uses Unit1, Dataset;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;

  imgTitik.Canvas.Brush.Color := clWhite;
  imgTitik.Canvas.FillRect(Rect(0, 0, imgTitik.Width, imgTitik.Height));

  sgMatriks.Cells[0, 0] := 'Titik';
  sgMatriks.Cells[1, 0] := '0';
  sgMatriks.Cells[0, 1] := '0';

  sgCust.Cells[0, 0] := 'Customer';
  sgCust.Cells[1, 0] := 'Permintaan';
  sgCust.Cells[2, 0] := 'Service Time (Jam)';
  sgCust.ColWidths[0]:=80;
  sgCust.ColWidths[1]:=90;
  sgCust.ColWidths[2]:=150;
end;

procedure TForm2.imgTitikMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var P, i, b, a : Integer;
begin
  if (Button = mbLeft) then
  begin
    P := Length(arTitik);
    setLength(arTitik, P+1);
    arTitik[P].posisi := Point(X,Y);
    arTitik[P].warna := clYellow;
    G.size := P+1;
    setLength(G.mtBobot, G.size, G.size);
    setLength(G.mtWaktu, G.size, G.size);
    setLength(arcust, P);
    for i := 0 to G.size-2 do
    begin
      G.mtBobot[i, P] := 0;
      G.mtBobot[P, i] := 0;
      G.mtWaktu[i, P] := 0;
      G.mtWaktu[P, i] := 0;
    end;
    if G.size > 1 then
    begin
      sgMatriks.ColCount := sgMatriks.ColCount + 1;
      sgMatriks.RowCount := sgMatriks.RowCount + 1;
      sgMatriks.Col := 2;
      sgMatriks.Row := 1;
    end;
    b := sgMatriks.ColCount - 1;
    sgMatriks.Cells[0, b] := Format('%d', [b-1]);
    sgMatriks.Cells[b, 0] := Format('%d', [b-1]);
    GambarTitik(P, true);

    if P > 1 then
    begin
      sgCust.RowCount := sgCust.RowCount +1 ;
      sgCust.Row := 1;
    end;

    if P>0 then
      sgCust.Cells[0, P] := Format('%d', [P]);

    for a:=0 to length(arcust)-1 do
    begin
      arcust[a].Cust := a+1;
      arcust[a].Permintaan := 0;
      arcust[a].Waktu := 0;
    end;
  end ;
end;

procedure TForm2.sgMatriksKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
    Key := #00
  else
  if (Key = #13) then
    if sgMatriks.Col > sgMatriks.Row then
      if sgMatriks.Col < (sgMatriks.ColCount - 1) then
        sgMatriks.Col := sgMatriks.Col + 1
      else
        if sgMatriks.Row < (sgMatriks.RowCount - 2) then
        begin
          sgMatriks.Row := sgMatriks.Row + 1;
          sgMatriks.Col := sgMatriks.Row + 1;
        end
    else
    begin
      if sgMatriks.Col = sgMatriks.RowCount then
        if sgMatriks.Row < (sgMatriks.RowCount - 1) then
        begin
          sgMatriks.Row := sgMatriks.Row + 1;
          sgMatriks.Col := 1;
        end
        else
          sgMatriks.Col := sgMatriks.Col + 1;
      Key := #00;
    end;
end;

procedure TForm2.sgMatriksSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var bobotLama, bobotBaru : real ;
begin
  bobotLama :=  G.mtBobot[ARow-1, ACol-1];
  if (Value='') and (bobotLama <> 0) then
  begin
    HapusSisi(ARow-1, ACol-1);
    sgMatriks.Cells[ARow, ACol] := value;
    G.mtBobot[ARow-1, ACol-1] := bobotBaru;
    G.mtBobot[ACol-1, ARow-1] := bobotBaru;
  end
  else
  if Value <> '' then
  begin
    bobotBaru := StrTofloat(Value);
    if (bobotLama=0) and (bobotBaru <> 0) then
    begin
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := bobotBaru;
      G.mtBobot[ACol-1, ARow-1] := bobotBaru;
      GambarSisi(ARow-1, ACol-1);
    end
    else
    if (bobotLama <> 0) and (bobotBaru = 0) then
    begin
      HapusSisi(ARow-1, ACol-1);
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := 0;
      G.mtBobot[ACol-1, ARow-1] := 0;
    end
    else
    if (bobotLama <> 0) and (bobotBaru <> 0) and (bobotLama <> bobotBaru) then
    begin
      HapusSisi(ARow-1, ACol-1);
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := bobotBaru;
      G.mtBobot[ACol-1, ARow-1] := bobotBaru;
      GambarSisi(ARow-1, ACol-1);
    end
  end;
end;

procedure TForm2.sgMatriksDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ACol = ARow) then
    if not (gdFixed in State) then
    begin
      sgMatriks.Canvas.Brush.Color := clGray;
      sgMatriks.Canvas.FillRect(Rect);
      sgMatriks.Canvas.Brush.Color := clWhite;
    end
  else
  if not (gdSelected in State) and not (gdFixed in State) then
    if sgMatriks.Cells[ACol, ARow] = '' then
      sgMatriks.Cells[ACol, ARow] := '0';
end;

procedure TForm2.sgMatriksSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect := ACol <> ARow;
end;

procedure TForm2.GambarBobot(const v1, v2: byte);
var P1, P2: TPoint; xC, yC: integer; bobot : real;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;

  xC := Round((P1.X + P2.X)/2);
  yC := Round((P1.Y + P2.Y)/2);
  bobot := G.mtBobot[v1, v2];

  imgTitik.Canvas.Font.Color := clBlue;
  imgTitik.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
  imgTitik.Canvas.Font.Color := clBlack;
end;

procedure TForm2.GambarSisi(const v1, v2: byte);
var P1, P2: TPoint;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;
  imgTitik.Canvas.Pen.Color := clBlack;
  imgTitik.Canvas.MoveTo(P1.X, P1.Y);
  imgTitik.Canvas.LineTo(P2.X, P2.Y);

  GambarBobot(v1, v2);
  GambarTitik(v1, true);
  GambarTitik(v2, true);
end;

procedure TForm2.GambarTitik(const index: Integer; const repaint: Boolean);
var X, Y : Integer;
begin
    X := arTitik[index].posisi.X;
    Y := arTitik[index].posisi.Y;

    imgTitik.Canvas.Pen.Color := clBlack;
    imgTitik.Canvas.Ellipse(X-6, Y-6, X+6, Y+6);
    imgtitik.Canvas.Brush.Color := arTitik[index].warna;

    imgTitik.Canvas.FloodFill(X, Y, clBlack, fsBorder);
    imgTitik.Canvas.Brush.Color := clWhite;
    imgTitik.Canvas.Font.Color := clRed;
    imgTitik.Canvas.Font.Style := [fsBold];

    imgTitik.Canvas.TextOut(X-5, Y+10, Format('%d', [index]));
    imgTitik.Canvas.Font.Color := clBlack;
    imgTitik.Canvas.Font.Style := [];

    imghasil.Canvas.Pen.Color := clBlack;
    imghasil.Canvas.Ellipse(X-6, Y-6, X+6, Y+6);
    imghasil.Canvas.Brush.Color := arTitik[index].warna;

    imghasil.Canvas.FloodFill(X, Y, clBlack, fsBorder);
    imghasil.Canvas.Brush.Color := clWhite;
    imghasil.Canvas.Font.Color := clRed;
    imghasil.Canvas.Font.Style := [fsBold];

    imghasil.Canvas.TextOut(X-5, Y+10, Format('%d', [index]));
    imghasil.Canvas.Font.Color := clBlack;
    imghasil.Canvas.Font.Style := [];

    if repaint then imgTitik.Repaint();
end;

procedure TForm2.HapusBobot(const v1, v2: byte);
var P1, P2: TPoint; xC, yC: integer; bobot : real;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;

  xC := Round((P1.X + P2.X)/2);
  yC := Round((P1.Y + P2.Y)/2);
  bobot := G.mtBobot[v1, v2];

  imgTitik.Canvas.Font.Color := clwhite;
  imgTitik.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
  imgTitik.Canvas.Font.Color := clBlack;
end;

procedure TForm2.HapusSisi(const v1, v2: byte);
Var p1, p2: TPoint;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;
  imgTitik.Canvas.Pen.Color := clWhite;
  imgTitik.Canvas.MoveTo(P1.X, P1.Y);
  imgTitik.Canvas.LineTo(P2.X, P2.Y);

  HapusBobot(v1, v2);
  GambarTitik(v1, true);
  GambarTitik(v2, true);
end;

procedure TForm2.sgCustKeyPress(Sender: TObject; var Key: Char);
begin
  if (sgCust.Col = 1) and not(Key in ['0'..'9']) and not (Key = #13) and not(Key = #8) then
  begin
    Application.MessageBox('Masukkan Bilangan Integer!','Information', MB_OK or MB_ICONEXCLAMATION);
    Key := #00;
  end
  else
  if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
    Key := #00
  else
  if (Key = #13) then
  begin
    if sgCust.Col < sgCust.ColCount-1 then sgCust.Col := sgCust.Col + 1
    else if sgCust.Row < sgCust.RowCount-1 then
    begin
      sgCust.Row := sgCust.Row + 1;
      sgCust.Col := sgCust.Col - 1;
    end;
    Key := #00;
  end;
end;

procedure TForm2.sgCustSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var key: char;
begin
  if Value <> '' then
    if sgCust.Col = 1 then
      arcust[ARow-1].Permintaan:=strtoint(value)
    else
      arcust[ARow-1].Waktu:=strtofloat(value);
end;

procedure TForm2.Keluar1Click(Sender: TObject);
begin
  if Application.MessageBox('Anda Yakin Ingin Keluar?','Konfirmasi',MB_ICONINFORMATION+MB_YESNO)=IDYES
  then Form1.Close;
end;

procedure TForm2.Buka;
var myfile: textfile;
    jenis, namafile : string;
    i, j, bykTitik, bykCust: byte;
    X, Y, permintaan, banyak, kapasitas : integer;
    bobot, waktu, kecepatan, global, feasibility, local : real;
begin
  if opendialog1.Execute then
  begin
    Hapus;
    namafile := opendialog1.FileName;
    assignfile(myfile, namafile);
    reset(myfile);
    readln(myfile, jenis);
    readln(myfile, bykTitik);
    setLength(G.mtBobot, bykTitik, bykTitik);
    setLength(G.mtWaktu, bykTitik, bykTitik);
    G.size := bykTitik;
    setlength(arTitik, bykTitik);
    sgMatriks.ColCount := bykTitik+1;
    SgMatriks.RowCount := bykTitik+1;
    readln(myfile, jenis);
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
        begin
          readln(myfile, bobot);
          G.mtBobot[i, j] := bobot;
          G.mtBobot[j, i] := bobot;
          sgMatriks.Cells[j+1, i+1] := FloatToStr (bobot);
          sgMatriks.Cells[i+1, j+1] := FloatToStr (bobot);
        end;
    for i := 1 to bykTitik do
    begin
      sgMatriks.Cells[0, i] := Format('%d', [i-1]);
      sgMatriks.Cells[i, 0] := Format('%d', [i-1]);
    end;
    sgCust.ColWidths[0]:=80;
    sgCust.ColWidths[1]:=90;
    sgCust.ColWidths[2]:=150;
    readln(myfile, jenis);
    readln(myfile, bykCust);
    setlength(arCust, bykCust);
    sgCust.RowCount:=bykCust+1;
    sgCust.Cells[0, 0] := 'Customer';
    sgCust.Cells[1, 0] := 'Permintaan';
    sgCust.Cells[2, 0] := 'Service Time (Jam)';
    for i:=0 to length(arCust)-1 do
    begin
      arCust[i].Cust := i+1;
      sgCust.Cells[0, i+1] := Format('%d', [i+1]);
    end;
    readln(myfile, jenis);
    for i:=0 to length(arCust)-1 do
    begin
      readln(myfile, permintaan);
      arCust[i].Permintaan:=permintaan;
      sgCust.Cells[1,i+1]:=inttostr(permintaan);
    end;
    readln(myfile, jenis);
    for i:=0 to length(arCust)-1 do
    begin
      readln(myfile, waktu);
      arCust[i].Waktu:=waktu;
      sgCust.Cells[2,i+1]:=floattostr(waktu);
    end;
    readln(myfile, jenis);
    readln(myfile, kapasitas);
    edKapasitas.Text:=inttostr(kapasitas);
    readln(myfile, jenis);
    readln(myfile, kecepatan);
    edKecepatan.Text:=floattostr(kecepatan);
    readln(myfile, jenis);
    readln(myfile, waktu);
    edTW.Text:=floattostr(waktu);
    readln(myfile, jenis);
    readln(myfile, global);
    edA.Text:=floattostr(global);
    readln(myfile, jenis);
    readln(myfile, feasibility);
    edB.Text:=floattostr(feasibility);
    readln(myfile, jenis);
    readln(myfile, local);
    edP.Text:=floattostr(local);
    readln(myfile, jenis);
    readln(myfile, banyak);
    edM.Text:=floattostr(banyak);
    setLength(arTitik, bykTitik);
    readln(myfile, jenis);
    for i := 0 to bykTitik-1 do
    begin
      readln(myfile, X, Y);
      arTitik[i].posisi := Point(X, Y);
      arTitik[i].warna := clYellow;
    end;
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
          if G.mtBobot[i, j] <> 0 then
            GambarSisi(i, j);
    closefile(myfile);
  end;
end;

procedure TForm2.Dataset;
var Instance: IXMLInstanceType;
    i, j, byktitik, bykparameter : byte;
    tw, st, bobot : real;
    permintaan, kapasitas, x, y, Xmin, Xmax, Ymin, Ymax, width, height, Tx, Ty : integer;
    pos : array of array of integer;
begin
  if opendialog1.Execute then
  begin
    Hapus;
    Instance := Loadinstance(opendialog1.FileName);
    mmoutput.Clear;

    byktitik := instance.Network.Nodes.Count;
    G.size := bykTitik;
    setLength(G.mtBobot, G.size, G.size);
    setLength(G.mtWaktu, G.size, G.size);
    setlength(arTitik, bykTitik);
    sgMatriks.ColCount := bykTitik+1;
    SgMatriks.RowCount := bykTitik+1;
    for i := 1 to bykTitik do
    begin
      sgMatriks.Cells[0, i] := Format('%d', [i-1]);
      sgMatriks.Cells[i, 0] := Format('%d', [i-1]);
    end;
    sgCust.ColWidths[0]:=80;
    sgCust.ColWidths[1]:=90;
    sgCust.ColWidths[2]:=150;

    bykparameter:=instance.Requests.Count;
    setlength(arCust, bykParameter);
    sgCust.RowCount:=bykParameter+1;
    sgCust.Cells[0, 0] := 'Customer';
    sgCust.Cells[1, 0] := 'Permintaan';
    sgCust.Cells[2, 0] := 'Service Time (Jam)';
    for i:=0 to length(arCust)-1 do
    begin
      arCust[i].Cust := i+1;
      sgCust.Cells[0, i+1] := Format('%d', [i+1]);
    end;
    for i:=0 to instance.Requests.Count-1 do
    begin
      permintaan:=round(instance.Requests.Request[i].Quantity/10);
      arCust[i].Permintaan:=permintaan;
      sgCust.Cells[1,i+1]:=inttostr(permintaan);

      st:=instance.Requests.Request[i].Service_time/10;
      arCust[i].Waktu:=st/60;
      sgCust.Cells[2,i+1]:=floattostr(st/60);
    end;

    kapasitas:=round(instance.Fleet.Vehicle_profile.Capacity/10);
    edKapasitas.Text:=inttostr(kapasitas);
    tw:=instance.Fleet.Vehicle_profile.Max_travel_time/10;
    edTW.Text:=floattostr(tw/60);

      x:=round(instance.Network.Nodes[0].Cx/10);
      y:=round(instance.Network.Nodes[0].Cy/10);

      setLength(arTitik, bykTitik);
      setLength(pos, bykTitik, 2);

      Xmin := X;
      Xmax := X;
      Ymin := Y;
      Ymax := Y;
      pos[0,0] := X;
      pos[0,1] := Y;
      arTitik[0].warna:=clyellow;

    for i:=1 to instance.Network.Nodes.Count-1 do
    begin
      x:=round(instance.Network.Nodes[i].Cx/10);
      y:=round(instance.Network.Nodes[i].Cy/10);

      if X < Xmin then Xmin := X;
      if X > Xmax then Xmax := X;
      if Y < Ymin then Ymin := Y;
      if Y > Ymax then Ymax := Y;
      pos[i,0] := X;
      pos[i,1] := Y;
      arTitik[i].warna:=clyellow;
    end;

    width := imghasil.Width-40;
    height := imghasil.Height-50;

    for i := 0 to bykTitik-1 do
    begin
      tX := pos[i,0];
      tY := pos[i,1];
      if Xmin < 0 then
      begin
        if tX < 0 then tX := tX-Xmin
          else tX := tX + abs(Xmin);
      end else
        tX := tX - Xmin;

      if Ymin < 0 then
      begin
        if tY < 0 then tY := tY-Ymin
          else tY := tY + abs(Ymin);
      end else
        tY := tY - Ymin;

      arTitik[i].posisi.X := Round(tX/(Xmax-Xmin)*Width)+20;
      arTitik[i].posisi.Y := Round(tY/(Ymax-Ymin)*Height)+20;
    end;

    setLength(G.mtBobot, bykTitik, bykTitik);
    for i := 0 to bykTitik-1 do
    begin
      for j := 0 to bykTitik-1 do
      begin
        if j > i then
        begin
          bobot := sqrt((sqr(pos[i,0]-pos[j,0])) + (sqr(pos[i,1]-pos[j,1])));;
          bobot := round(bobot*1000)/1000;
          G.mtBobot[i, j] := bobot;
          G.mtBobot[j, i] := bobot;
          sgMatriks.Cells[j+1, i+1] := FloatToStr (bobot);
          sgMatriks.Cells[i+1, j+1] := FloatToStr (bobot);
        end;
      end;
    end;

    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
          if G.mtBobot[i, j] <> 0 then
            GambarSisi(i, j);
  end;
end;

procedure TForm2.Hapus;
var i, j, bykTitik: byte;
begin
  mmOutput.Lines.Clear;
  imgTitik.Canvas.Brush.Color := clWhite;
  imgTitik.Canvas.FillRect(Rect(0, 0, imgTitik.Width, imgTitik.Height));
  imghasil.Canvas.Brush.Color := clWhite;
  imghasil.Canvas.FillRect(Rect(0, 0, imghasil.Width, imghasil.Height));
  bykTitik := G.size;
  if bykTitik <> 0 then
  begin
    setLength(arTitik, 0);
    for i := 1 to bykTitik do
      for j := 1 to bykTitik do
        sgMatriks.Cells[i, j] := '';
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        G.mtBobot[i,j] := 0;
    G.size := 0;
    setLength(G.mtBobot, 0, 0);
    sgMatriks.ColCount := 2;
    sgMatriks.RowCount := 2;
  end;
  edKapasitas.Text:='';
  edTW.Text:='';
  edKecepatan.Text:='';
  edIter.Text:='';
  edRVND.Text:='';
  edA.Text:='';
  edB.Text:='';
  edP.Text:='';
  edM.Text:='';
  for i:=1 to 2 do
    for j:=1 to length(arCust) do
      sgCust.Cells[i,j]:='';
  sgCust.Cells[0,1]:='';
  sgCust.ColCount := 3;
  sgCust.RowCount := 2;
  setlength(arCust, 0);
  setlength(arTitik,0);
  setlength(pheromone,0);
  setlength(tabulist,0);
  setlength(solusi,0);
  setlength(copysolusi,0);
  setlength(tabulistpilih,0);
  setlength(tabulistterpilih,0);
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
end;

procedure TForm2.Simpan;
var i, j, bykTitik, bykParameter : byte;
    namafile: string;
    myfile: textfile;
    X, Y, banyak, kapasitas : Integer;
begin
  if savedialog1.Execute then
  begin
    bykTitik := G.size;
    bykParameter := length(arCust);
    namafile := savedialog1.FileName;
    assignfile(myfile, namafile);
    rewrite(myfile);
    writeln(myfile, '[Banyak titik]');
    writeln(myfile, bykTitik);
    writeln(myfile, '[Bobot sisi]');
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
          writeln(myfile, G.mtBobot[i, j]);
    writeln(myfile, '[Banyak arCust]');
    writeln(myfile, bykParameter);
    writeln(myfile, '[Parameter permintaan]');
    for i:=0 to bykParameter-1 do
    begin
      X:=arCust[i].Permintaan;
      writeln(myfile, X);
    end;
    writeln(myfile, '[Parameter service time]');
    for i:=0 to bykParameter-1 do
      writeln(myfile, arCust[i].Waktu);
    kapasitas:=strtoint(edKapasitas.Text);
    writeln(myfile, '[Kapasitas Kendaraan]');
    writeln(myfile, kapasitas);
    writeln(myfile, '[Kecepatan Kendaraan]');
    writeln(myfile, strtofloat(edKecepatan.Text));
    writeln(myfile, '[Time Window]');
    writeln(myfile, strtofloat(edTW.Text));
    writeln(myfile, '[Global Pheromone]');
    writeln(myfile, strtofloat(edA.Text));
    writeln(myfile, '[Pheromone Feasibility]');
    writeln(myfile, strtofloat(edB.Text));
    writeln(myfile, '[Local Pheromone]');
    writeln(myfile, strtofloat(edP.Text));
    writeln(myfile, '[Banyak Semut]');
    writeln(myfile, strtoint(edM.Text));
    writeln(myfile, '[Posisi titik]');
    for i := 0 to bykTitik do
    begin
      X := arTitik[i].posisi.X;
      Y := arTitik[i].posisi.Y;
      writeln(myfile, X, ' ', Y);
    end;
    closefile(myfile);
  end;
end;

procedure TForm2.Buka1Click(Sender: TObject);
begin
  Buka;
end;

procedure TForm2.Simpan1Click(Sender: TObject);
begin
  Simpan;
end;

procedure TForm2.Hapus1Click(Sender: TObject);
begin
  Hapus;
end;

procedure TForm2.Dataset1Click(Sender: TObject);
begin
  Dataset;
end;

//Implementasi

procedure TForm2.ACS;
var a,b,c,d,v,u,i,j, cust,iter,sv,pilih,kendala : integer;
    t, besar,kecil,penyebut,peluang,deltaT,waktu : real;
    himpV, himpT : set of byte;
    ruteakhir : string;
    P1,P2 : TPoint;
begin
  setlength(pheromone, 1);
  setLength(pheromone[0], g.size, g.size);
  for a:=0 to g.size-1 do
  begin
    for b:=0 to g.size-1 do
      if a<>b then
      begin
        pheromone[0][a,b]:=1/m;
        pheromone[0][b,a]:=1/m;
      end
      else
      begin
        pheromone[0][a,b]:=0;
        pheromone[0][b,a]:=0;
      end;
  end;

  iter:=0;
  kecil:=99999;
  while iter<=100 do
  begin
    setLength(tabulist, m);
    Randomize;
    for a:=0 to m-1 do
    begin
      setLength(tabulist[a], 1);
      repeat
        v:=1+random(G.size-1);
      until (arCust[v-1].Waktu <= TW);
      tabulist[a,0]:=v;
    end;

    cust:=0;
    himpT:=[];
    while cust<g.size-2 do
    begin
      if arCust[cust].Waktu<=TW then
      for a:=0 to length(tabulist)-1 do
      begin
        himpV:=[];
        himpV:=himpV+himpT;
        for b:=0 to length(tabulist[a])-1 do
          himpV:=himpV+[tabulist[a][b]];

        v:=tabulist[a][length(tabulist[a])-1];

        penyebut:=0;
        for b:=1 to g.size-1 do
          if (v<>b) and (not(b in himpV)) then
            penyebut:=penyebut+(power(pheromone[length(pheromone)-1][v,b],alfa)*power((1/g.mtbobot[v,b]),beta));

        besar:=0;
        for b:=1 to g.size-1 do
          if (v<>b) and (not(b in himpV)) then
          begin
            peluang:=(power(pheromone[length(pheromone)-1][v,b],alfa)*power((1/g.mtbobot[v,b]),beta))/penyebut;
            if (besar<=peluang) then
            begin
              besar:=peluang;
              sv:=b;
            end;
          end;

        if arCust[sv-1].Waktu<=TW then
        begin
        setLength(tabulist[a], length(tabulist[a])+1);
        tabulist[a][length(tabulist[a])-1]:=sv;
        end
        else himpT:=himpT+[sv];
      end;
      cust:=cust+1;
    end;

    setlength(pheromone, length(pheromone)+1);
    setLength(pheromone[length(pheromone)-1], g.size, g.size);
    for a:=0 to g.size-1 do
      for b:=0 to g.size-1 do
        if a<>b then
        begin
          deltaT:=0;
          for c:=0 to m-1 do
            for d:=0 to length(tabulist[c])-2 do
              if ((tabulist[c][d]=a) and (tabulist[c][d+1]=b)) or ((tabulist[c][d]=b) and (tabulist[c][d+1]=a)) then
                deltaT:=deltaT+(1/hitungjarak(tabulist[c]));

          t:=((1-rho)*(pheromone[length(pheromone)-2][a,b]))+deltaT;

          pheromone[length(pheromone)-1][a,b]:=t;
          pheromone[length(pheromone)-1][b,a]:=t;
        end;

    besar:=9999;
    for a:=0 to m-1 do
      if besar>=hitungjarak(tabulist[a]) then
      begin
        besar:=hitungjarak(tabulist[a]);
        pilih:=a;
      end;

    setLength(tabulistpilih, length(tabulist[pilih]));
    for a:=0 to length(tabulist[pilih])-1 do
      tabulistpilih[a]:=tabulist[pilih][a];

    if hitungjarak(tabulistpilih)<=kecil then
    begin
      setLength(tabulistterpilih, length(tabulistpilih));
      for a:=0 to length(tabulistpilih)-1 do
        tabulistterpilih[a]:=tabulistpilih[a];
      kecil:=hitungjarak(tabulistpilih);
      iter:=iter+1;
    end
    else
      break;
  end;

      for a:=0 to length(tabulistterpilih)-1 do
        if a<>length(tabulistterpilih)-1 then
          ruteakhir:=ruteakhir+inttostr(tabulistterpilih[a])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(tabulistterpilih[a]);

      mmOutput.Lines.Add('Dipilih tabulist :');
      mmOutput.Lines.Add('[ '+ruteakhir+' ]');
      mmOutput.Lines.Add('');

  setlength(Solusi, 1);
  setlength(Solusi[length(solusi)-1], 3);
  Solusi[0][0]:=0;
  Solusi[0][1]:=tabulistterpilih[0];
  Solusi[0][2]:=0;

  v:=1;
  while v<length(tabulistterpilih) do
  begin
    cust:=tabulistterpilih[v];

    kendala:=HitungK(Solusi[length(Solusi)-1])+arCust[cust-1].Permintaan;
    waktu:=HitungW(Solusi[length(Solusi)-1])+arCust[cust-1].Waktu;

    if (kendala<=Q) and (waktu<=TW) then
    begin
      setlength(Solusi[length(solusi)-1], length(Solusi[length(solusi)-1])+1);
      for a:=length(Solusi[length(solusi)-1])-2 downto length(Solusi[length(solusi)-1])-3 do
        Solusi[length(solusi)-1][a+1]:=Solusi[length(solusi)-1][a];
      Solusi[length(solusi)-1][length(Solusi[length(solusi)-1])-2]:=cust;
    end
    else
    begin
      setlength(Solusi, length(Solusi)+1);
      setlength(Solusi[length(solusi)-1], 3);
      Solusi[length(solusi)-1][0]:=0;
      Solusi[length(solusi)-1][1]:=cust;
      Solusi[length(solusi)-1][2]:=0;
    end;
    v:=v+1;
  end;

mmOutput.Lines.Add('Dari Tabulist yang terpilih, dibuatlah rute dengan tidak'+
' melanggar kapasitas kendaraan dan time window yang telah ditentukan.');
for a:=0 to length(solusi)-1 do
begin
  ruteakhir:='';
  for b:=0 to length(solusi[a])-1 do
    if b<length(solusi[a])-1 then
      ruteakhir:=ruteakhir+inttostr(solusi[a][b])+'-'
    else
      ruteakhir:=ruteakhir+inttostr(solusi[a][b]);
  mmOutput.Lines.Add('Rute '+inttostr(a+1)+' : [ '+ruteakhir+' ]');
  mmOutput.Lines.Add('dengan panjang rute '+formatfloat('0.##',hitungjarak(solusi[a]))+' km, kapasitas '+inttostr(HitungK(solusi[a]))+', waktu '+formatfloat('0.#',HitungW(solusi[a]))+' jam.');
end;
mmOutput.Lines.Add('Total panjang rute '+formatfloat('0.##',Totaljarak(solusi))+' km, total waktu '+formatfloat('0.#',TotalWaktu(solusi))+' jam.');
end;

procedure TForm2.Button1Click(Sender: TObject);
var waktu,totaljaraklama,totaljarakbaru,bobot,totalakhir : real;
    i,j,a,b,n,k,u,v, xC,yC, iter,plh,iterRVND : integer;
    rute: array of string;
    NL,NL1 : array of integer;
    hapusNL, hapusNL1, tplh : set of byte;
    P1,P2 : TPoint;
    wrn: string;
begin
  if  (edKapasitas.Text='') or (edTW.Text='') or (edKecepatan.Text='') or
      (edA.Text='') or (edB.Text='') or (edP.Text='') or (edM.Text='') or (edIter.Text='') then
      Application.MessageBox('Masukkan Data','Information', MB_OK or MB_ICONEXCLAMATION)
  else
  begin
    mmOutput.Clear;
    Update;
    parameter;

    for i:=0 to g.size-1 do
      for j:=0 to g.size-1 do
        if i<>j then
        begin
          waktu:=g.mtBobot[i,j]/kecepatan;
          g.mtWaktu[i,j]:=waktu;
          g.mtWaktu[j,i]:=waktu;
        end
        else g.mtWaktu[i,j]:=0;

    for i:=0 to g.size-1 do
      for j:=0 to g.size-1 do
        if i<>j then
        begin
          waktu:=g.mtBobot[i,j]/kecepatan;
          g.mtWaktu[i,j]:=waktu;
          g.mtWaktu[j,i]:=waktu;
        end
        else g.mtWaktu[i,j]:=0;

    totalakhir:=99999;
    iter:=0;
    while iter<itermax do
    begin
      mmOutput.Lines.Add('- Iterasi '+inttostr(iter+1)+' :');

      ACS;

      mmOutput.Lines.Add('');
      
      setlength(copySolusi, length(Solusi));
      for a:=0 to length(Solusi)-1 do
      begin
        setlength(copySolusi[a], length(Solusi[a]));
        for b:=0 to length(Solusi[a])-1 do
          copySolusi[a,b]:=Solusi[a,b];
      end;

      iterRVND:= 0;

      while iterRVND<itermaxRVND do
      begin
        Randomize;
        setlength(NL,6);
        hapusNL:=[];
        n:=0;
        while length(NL)>0 do
        begin
          totaljaraklama:=TotalJarak(copySolusi);

          repeat
            b:=1+random(6);
          until not(b in hapusNL);
          for a:=0 to length(NL)-1 do
            NL[a]:=b;

          if NL[n]=1 then Shift10(copySolusi)
          else
          if NL[n]=2 then Swap11(copySolusi)
          else
          if NL[n]=3 then Shift20(copySolusi)
          else
          if NL[n]=4 then Swap22(copySolusi)
          else
          if NL[n]=5 then Cross(copySolusi)
          else
          if NL[n]=6 then Swap21(copySolusi);

          totaljarakbaru:=TotalJarak(copySolusi);
          if totaljarakbaru<totaljaraklama then
          begin
            setlength(NL1, 4);

            hapusNL1:=[];
            while length(NL1)>0 do
            begin
              totaljaraklama:=TotalJarak(copySolusi);

              repeat
                b:=1+random(4);
              until not(b in hapusNL1);
              for a:=0 to length(NL1)-1 do
                NL1[a]:=b;

              if NL1[n]=1 then Opt2(copySolusi)
              else
              if NL1[n]=2 then OrOpt(copySolusi)
              else
              if NL1[n]=3 then Reverse(copySolusi)
              else
              if NL1[n]=4 then Exchange(copySolusi);

              totaljarakbaru:=TotalJarak(copySolusi);
              if totaljarakbaru>=totaljaraklama then
              begin
                setlength(NL1, length(NL1)-1);
                hapusNL1:=hapusNL1+[b];
              end;
            end;
          end
          else
          begin
            setlength(NL, length(NL)-1);
            hapusNL:=hapusNL+[b];
          end;
        end;

        if TotalJarak(copySolusi)<TotalJarak(Solusi) then
        begin
          setlength(Solusi, length(copySolusi));
          for a:=0 to length(copySolusi)-1 do
          begin
            setlength(Solusi[a], length(copySolusi[a]));
            for b:=0 to length(copySolusi[a])-1 do
              Solusi[a,b]:=copySolusi[a,b];
          end;
        end;
        iterRVND:=iterRVND+1;
      end;

        mmOutput.Lines.Add('Rute yang telah terbentuk, kemudian dilakukan perbaikan dengan RVND. Sehingga diperoleh rute :');
        setlength(rute, 0);
        setlength(rute, length(Solusi));
        i:=0;
        k:=0;
        while i<=length(Solusi)-1 do
        begin
          if length(Solusi[i])=2 then
          begin
            i:=i+1;
            k:=k;
          end
          else
          begin
            k:=k+1;
            for j:=0 to length(Solusi[i])-1 do
              if rute[i]='' then
                rute[i]:=rute[i] + inttostr(Solusi[i,j])
              else
                rute[i]:=rute[i] + '-' + inttostr(Solusi[i,j]);
            mmOutput.Lines.Add('PR ' + inttostr(k) + ' = [' + rute[i] + ']');
            mmOutput.Lines.Add('jarak ' + formatfloat('0.##',HitungJarak(Solusi[i])) + ' km, kapasitas '+
                          inttostr(HitungK(solusi[i]))+', waktu '+
                          formatfloat('0.#',HitungW(Solusi[i]))+' jam.');
            i:=i+1;
          end;
        end;

        mmOutput.Lines.Add('Total jarak tempuh '+formatfloat('0.##',TotalJarak(Solusi))+
                          ' km, total waktu tempuh yang dibutuhkan '+
                          formatfloat('0.#',TotalWaktu(Solusi))+' jam.');
        mmOutput.Lines.Add('');

      if TotalJarak(Solusi)<=totalakhir then
      begin
        setlength(pilihSolusi, length(Solusi));
        for a:=0 to length(Solusi)-1 do
        begin
          setlength(pilihSolusi[a], length(Solusi[a]));
          for b:=0 to length(Solusi[a])-1 do
            pilihSolusi[a,b]:=Solusi[a,b];
        end;
        totalakhir:=TotalJarak(Solusi);
      end;

      iter:=iter+1;
    end;

    mmOutput.Lines.Add('');
    mmOutput.Lines.Add('Dari iterasi yang telah dilakukan, diperoleh rute optimal dengan jarak tempuh '+formatfloat('0.##',TotalJarak(pilihSolusi))+' km dan total waktu tempuh yang dibutuhkan adalah '+formatfloat('0.#',TotalWaktu(pilihSolusi))+' jam.');
    mmOutput.Lines.Add('Rute yang terbentuk:');
    setlength(rute, 0);
    setlength(rute, length(pilihSolusi));
    i:=0;
    k:=0;
    while i<=length(pilihSolusi)-1 do
    begin
      if length(pilihSolusi[i])=2 then
      begin
        i:=i+1;
        k:=k;
      end
      else
      begin
        k:=k+1;
        for j:=0 to length(pilihSolusi[i])-1 do
          if rute[i]='' then
            rute[i]:=rute[i] + inttostr(pilihSolusi[i,j])
          else
            rute[i]:=rute[i] + '-' + inttostr(pilihSolusi[i,j]);
        mmOutput.Lines.Add('Rute '+inttostr(i+1)+' = ['+rute[i]+']');
        mmOutput.Lines.Add('dengan panjang rute = '+formatfloat('0.##',HitungJarak(pilihSolusi[i]))+' km dan waktu tempuh = '+formatfloat('0.#',HitungW(pilihSolusi[i]))+' jam.');
        i:=i+1;
      end;
    end;
    mmOutput.Lines.Add('');
    
    tplh:=[];
    for i:= 0 to Length(pilihSolusi)-1 do
    begin
      repeat
        plh:=random(30)*2+1;
      until not(plh in tplh);
      wrn:=inttostr(plh)+'0000';
      tplh:=tplh+[plh];
      for j:=0 to length(pilihSolusi[i])-2 do
      begin
        u:= pilihSolusi[i, j];
        v:= pilihSolusi[i, j+1];
        P1 := arTitik[u].posisi;
        P2 := arTitik[v].posisi;
        imghasil.Canvas.Pen.Width := 2;
        imghasil.Canvas.Pen.Color := strtoint(wrn);
        imghasil.Canvas.MoveTo(P1.X, P1.Y);
        imghasil.Canvas.LineTo(P2.X, P2.Y);
      end;
    end;

    PageControl1.ActivePageIndex:=1;
    PageControl2.ActivePageIndex:=1;
  end;
end;

function TForm2.HitungJarak(rute: array of integer): real;
var i : integer;
    jumlah: real;
begin
  jumlah:=0;
  for i:=0 to length(rute)-2 do
    jumlah:= jumlah + g.mtbobot[rute[i], rute[i+1]];
  result:= jumlah;
end;

function TForm2.HitungK(rute: array of integer): integer;
var a, totalK: integer;
begin
  totalK:=0;
  for a:=1 to length(rute)-2 do
    totalK:=totalK+arCust[rute[a]-1].Permintaan;
  result:=totalK;
end;

function TForm2.HitungW(rute: array of integer): real;
var a: integer; TotalW: real;
begin
  TotalW:=0;
  for a:=0 to length(rute)-2 do
    totalW:=totalW+g.mtWaktu[rute[a], rute[a+1]];
  for a:=1 to length(rute)-2 do
    totalW:=totalW+arCust[rute[a]-1].Waktu;
  result:=totalW;
end;

function TForm2.TotalJarak(s: rute): real;
var a : integer; total : real;
begin
  total := 0;
  for a:=0 to length(s)-1 do
    total := total + HitungJarak(s[a]);
  result := total;
end;

function TForm2.TotalWaktu(s: rute): real;
var a : integer; total : real;
begin
  total := 0;
  for a:=0 to length(s)-1 do
    total := total + HitungW(s[a]);
  result := total;
end;

procedure TForm2.Cross(const s: rute);
var a, b, c, i, j, k, t1, K1, K2 : integer;
    totaljarak1, totaljarak2, totalwaktu1, totalwaktu2 : real;
    artampung, arsimpan, arfix : rute;
begin
  setlength(arfix, length(s));
  for j:=0 to length(s)-1 do
  begin
    setlength(arfix[j], length(s[j]));
    for k:=0 to length(s[j])-1 do
      arfix[j,k]:=s[j,k];
  end;

  totaljarak1:=totaljarak(arfix);
  totalwaktu1:=totalwaktu(arfix);

  setlength(artampung, 2);
  for i:=0 to length(s)-2 do
  begin
    a:=2;
    while a < length(s[i])-1 do
    begin
      t1:=s[i,a];
      if i=0 then b:=1 else b:=0;

      while b < length(s) do
      begin
        if i<>b then
        begin
          c:=2;
          while c < length(s[b])-1 do
          begin
            setlength(arsimpan, length(s));
            for j:=0 to length(s)-1 do
            begin
              setlength(arsimpan[j], length(s[j]));
              for k:=0 to length(s[j])-1 do
                arsimpan[j,k]:=s[j,k];
            end;

            setlength(artampung[0], length(s[i]));
            for j:=0 to length(s[i])-1 do
              artampung[0,j]:=s[i,j];
            setlength(artampung[1], length(s[b]));
            for j:=0 to length(s[b])-1 do
              artampung[1,j]:=s[b,j];

            artampung[0,a]:=artampung[1,c];
            artampung[1,c]:=t1;

            K1:=HitungK(artampung[0]);
            K2:=HitungK(artampung[1]);

            if (K1<Q) and (K2<Q) then
            begin
              for j:=0 to length(artampung[0])-1 do
                arsimpan[i,j]:=artampung[0,j];
              for j:=0 to length(artampung[1])-1 do
                arsimpan[b,j]:=artampung[1,j];

              totaljarak2:=TotalJarak(arsimpan);
              totalwaktu2:=totalwaktu(arsimpan);
              if (totaljarak2<totaljarak1) and (totalwaktu2<totalwaktu1) then
              begin
                for j:=0 to length(arsimpan)-1 do
                begin
                  setlength(arfix[j], length(arsimpan[j]));
                  for k:=0 to length(arsimpan[j])-1 do
                    arfix[j,k]:=arsimpan[j,k];
                end;
                totaljarak1:=totaljarak2;
              end;
            end;
            c:=c+1;
          end;
        end;
        b:=b+1;
      end;
      a:=a+1;
    end;
  end;

  for i:=0 to length(s)-1 do
  begin
    setlength(copySolusi[i], length(arfix[i]));
    for j:=0 to length(arfix[i])-1 do
      copySolusi[i,j]:=arfix[i,j];
  end;
end;

procedure TForm2.Shift10(const s: rute);
var a, b, c, i, j, k, l, t1, K1, K2 : integer;
    totaljarak1, totaljarak2, W1, W2 : real;
    artampung, arsimpan, arfix : rute;
begin
  setlength(arfix, length(s));
  for j:=0 to length(s)-1 do
  begin
    setlength(arfix[j], length(s[j]));
    for k:=0 to length(s[j])-1 do
      arfix[j,k]:=s[j,k];
  end;

  totaljarak1:=totaljarak(arfix);
  W1:=TotalWaktu(arfix);

  setlength(artampung, 2);
  for i:=0 to length(s)-1 do
  begin
    a:=1;
    while a < length(s[i])-1 do
    begin
      t1:=s[i,a];
      if i=0 then b:=1 else b:=0;

      while b < length(s) do
      begin
        if i<>b then
        begin
          c:=1;
          while c < length(s[b]) do
          begin
            setlength(arsimpan, length(s));
            for j:=0 to length(s)-1 do
            begin
              setlength(arsimpan[j], length(s[j]));
              for k:=0 to length(s[j])-1 do
                arsimpan[j,k]:=s[j,k];
            end;

            setlength(artampung[0], length(s[i]));
            for j:=0 to length(s[i])-1 do
              artampung[0,j]:=s[i,j];
            setlength(artampung[1], length(s[b]));
            for j:=0 to length(s[b])-1 do
              artampung[1,j]:=s[b,j];

            for j:=a to length(artampung[0])-2 do
              artampung[0,j]:=s[i,j+1];
            setlength(artampung[0], length(artampung[0])-1);

            setlength(artampung[1], length(artampung[1])+1);
            for j:=length(artampung[1])-2 downto c do
              artampung[1,j+1]:=s[b,j];
            artampung[1,c]:=t1;

            K1:=HitungK(artampung[0]);
            K2:=HitungK(artampung[1]);

            if ((K1<Q) and (K2<Q)) then
            begin
              setlength(arsimpan[i], length(artampung[0]));
              setlength(arsimpan[b], length(artampung[1]));
              for j:=0 to length(artampung[0])-1 do
                arsimpan[i,j]:=artampung[0,j];
              for j:=0 to length(artampung[1])-1 do
                arsimpan[b,j]:=artampung[1,j];

              totaljarak2:=TotalJarak(arsimpan);
              W2:=TotalWaktu(arsimpan);
              if (totaljarak2<totaljarak1) and (W2<W1) then
              begin
                for j:=0 to length(arsimpan)-1 do
                begin
                  setlength(arfix[j], length(arsimpan[j]));
                  for k:=0 to length(arsimpan[j])-1 do
                    arfix[j,k]:=arsimpan[j,k];
                end;
                totaljarak1:=totaljarak2;
              end;
            end;
            c:=c+1;
          end;
        end;
        b:=b+1;
      end;
      a:=a+1;
    end;
  end;

  for i:=0 to length(s)-1 do
  begin
    setlength(copySolusi[i], length(arfix[i]));
    for j:=0 to length(arfix[i])-1 do
      copySolusi[i,j]:=arfix[i,j];
  end;
end;

procedure TForm2.Shift20(const s: rute);
var a, b, c, i, j, k, l, t1, t2, K1, K2 : integer;
    totaljarak1, totaljarak2, W1, W2 : real;
    artampung, arsimpan, arfix : rute;
begin
  setlength(arfix, length(s));
  for j:=0 to length(s)-1 do
  begin
    setlength(arfix[j], length(s[j]));
    for k:=0 to length(s[j])-1 do
      arfix[j,k]:=s[j,k];
  end;

  totaljarak1:=totaljarak(arfix);
  W1:=TotalWaktu(arfix);

  setlength(artampung, 2);
  for i:=0 to length(s)-1 do
  begin
    a:=1;
    while a < length(s[i])-2 do
    begin
      t1:=s[i,a];
      t2:=s[i,a+1];
      if i=0 then b:=1 else b:=0;

      while b < length(s) do
      begin
        if i<>b then
        begin
          c:=1;
          while c < length(s[b]) do
          begin
            setlength(arsimpan, length(s));
            for j:=0 to length(s)-1 do
            begin
              setlength(arsimpan[j], length(s[j]));
              for k:=0 to length(s[j])-1 do
                arsimpan[j,k]:=s[j,k];
            end;

            setlength(artampung[0], length(s[i]));
            for j:=0 to length(s[i])-1 do
              artampung[0,j]:=s[i,j];
            setlength(artampung[1], length(s[b]));
            for j:=0 to length(s[b])-1 do
              artampung[1,j]:=s[b,j];

            for j:=a to length(artampung[0])-1 do
              artampung[0,j]:=s[i,j+2];
            setlength(artampung[0], length(artampung[0])-2);

            setlength(artampung[1], length(artampung[1])+2);
            for j:=length(artampung[1])-2 downto c do
              artampung[1,j+1]:=s[b,j-1];
            artampung[1,c]:=t1;
            artampung[1,c+1]:=t2;

            K1:=HitungK(artampung[0]);
            K2:=HitungK(artampung[1]);

            if (K1<Q) and (K2<Q) then
            begin
              setlength(arsimpan[i], length(artampung[0]));
              setlength(arsimpan[b], length(artampung[1]));
              for j:=0 to length(artampung[0])-1 do
                arsimpan[i,j]:=artampung[0,j];
              for j:=0 to length(artampung[1])-1 do
                arsimpan[b,j]:=artampung[1,j];

              totaljarak2:=TotalJarak(arsimpan);
              W2:=TotalWaktu(arsimpan);
              if (totaljarak2<totaljarak1) and (W2<W1) then
              begin
                for j:=0 to length(arsimpan)-1 do
                begin
                  setlength(arfix[j], length(arsimpan[j]));
                  for k:=0 to length(arsimpan[j])-1 do
                    arfix[j,k]:=arsimpan[j,k];
                end;
                totaljarak1:=totaljarak2;
              end;
            end;
            c:=c+1;
          end;
        end;
        b:=b+1;
      end;
      a:=a+1;
    end;
  end;

  for i:=0 to length(s)-1 do
  begin
    setlength(copySolusi[i], length(arfix[i]));
    for j:=0 to length(arfix[i])-1 do
      copySolusi[i,j]:=arfix[i,j];
  end;
end;

procedure TForm2.Swap11(const s: rute);
var a, b, c, i, j, k, l, t1, K1, K2 : integer;
    totaljarak1, totaljarak2, W1, W2 : real;
    artampung, arsimpan, arfix : rute;
begin
  setlength(arfix, length(s));
  for j:=0 to length(s)-1 do
  begin
    setlength(arfix[j], length(s[j]));
    for k:=0 to length(s[j])-1 do
      arfix[j,k]:=s[j,k];
  end;

  totaljarak1:=totaljarak(arfix);
  W1:=TotalWaktu(arfix);
  
  setlength(artampung, 2);
  for i:=0 to length(s)-1 do
  begin
    a:=1;
    while a < length(s[i])-1 do
    begin
      t1:=s[i,a];
      if i=0 then b:=1 else b:=0;

      while b < length(s) do
      begin
        if i<>b then
        begin
          c:=1;
          while c < length(s[b])-1 do
          begin
            setlength(arsimpan, length(s));
            for j:=0 to length(s)-1 do
            begin
              setlength(arsimpan[j], length(s[j]));
              for k:=0 to length(s[j])-1 do
                arsimpan[j,k]:=s[j,k];
            end;

            setlength(artampung[0], length(s[i]));
            for j:=0 to length(s[i])-1 do
              artampung[0,j]:=s[i,j];
            setlength(artampung[1], length(s[b]));
            for j:=0 to length(s[b])-1 do
              artampung[1,j]:=s[b,j];

            artampung[0,a]:=artampung[1,c];
            artampung[1,c]:=t1;

            K1:=HitungK(artampung[0]);
            K2:=HitungK(artampung[1]);

            if ((K1<Q) and (K2<Q)) then
            begin
              for j:=0 to length(artampung[0])-1 do
                arsimpan[i,j]:=artampung[0,j];
              for j:=0 to length(artampung[1])-1 do
                arsimpan[b,j]:=artampung[1,j];

              totaljarak2:=TotalJarak(arsimpan);
              W2:=TotalWaktu(arsimpan);
              if (totaljarak2<totaljarak1) and (W2<W1) then
              begin
                for j:=0 to length(arsimpan)-1 do
                begin
                  setlength(arfix[j], length(arsimpan[j]));
                  for k:=0 to length(arsimpan[j])-1 do
                    arfix[j,k]:=arsimpan[j,k];
                end;
                totaljarak1:=totaljarak2;
              end;
            end;
            c:=c+1;
          end;
        end;
        b:=b+1;
      end;
      a:=a+1;
    end;
  end;

  for i:=0 to length(s)-1 do
  begin
    setlength(copySolusi[i], length(arfix[i]));
    for j:=0 to length(arfix[i])-1 do
      copySolusi[i,j]:=arfix[i,j];
  end;
end;

procedure TForm2.Swap21(const s: rute);
var a, b, c, i, j, k, l, t1, t2, K1, K2 : integer;
    totaljarak1, totaljarak2, W1, W2 : real;
    artampung, arsimpan, arfix : rute;
begin
  setlength(arfix, length(s));
  for j:=0 to length(s)-1 do
  begin
    setlength(arfix[j], length(s[j]));
    for k:=0 to length(s[j])-1 do
      arfix[j,k]:=s[j,k];
  end;

  totaljarak1:=totaljarak(arfix);
  W1:=TotalWaktu(arfix);

  setlength(artampung, 2);
  for i:=0 to length(s)-1 do
  begin
    a:=1;
    while a < length(s[i])-2 do
    begin
      t1:=s[i,a];
      t2:=s[i,a+1];
      if i=0 then b:=1 else b:=0;

      while b < length(s) do
      begin
        if i<>b then
        begin
          c:=1;
          while c < length(s[b])-1 do
          begin
            setlength(arsimpan, length(s));
            for j:=0 to length(s)-1 do
            begin
              setlength(arsimpan[j], length(s[j]));
              for k:=0 to length(s[j])-1 do
                arsimpan[j,k]:=s[j,k];
            end;

            setlength(artampung[0], length(s[i]));
            for j:=0 to length(s[i])-1 do
              artampung[0,j]:=s[i,j];
            setlength(artampung[1], length(s[b]));
            for j:=0 to length(s[b])-1 do
              artampung[1,j]:=s[b,j];

            artampung[0,a]:=artampung[1,c];

            for j:=a+1 to length(artampung[0])-2 do
              artampung[0,j]:=s[i,j+1];
            setlength(artampung[0], length(artampung[0])-1);

            setlength(artampung[1], length(artampung[1])+1);
            for j:=length(artampung[1])-2 downto c+1 do
              artampung[1,j+1]:=s[b,j];
            artampung[1,c]:=t1;
            artampung[1,c+1]:=t2;

            K1:=HitungK(artampung[0]);
            K2:=HitungK(artampung[1]);

            if ((K1<Q) and (K2<Q)) then
            begin
              setlength(arsimpan[i], length(artampung[0]));
              setlength(arsimpan[b], length(artampung[1]));
              for j:=0 to length(artampung[0])-1 do
                arsimpan[i,j]:=artampung[0,j];
              for j:=0 to length(artampung[1])-1 do
                arsimpan[b,j]:=artampung[1,j];

              totaljarak2:=TotalJarak(arsimpan);
              W2:=TotalWaktu(arsimpan);
              if (totaljarak2<totaljarak1) and (W2<W1) then
              begin
                for j:=0 to length(arsimpan)-1 do
                begin
                  setlength(arfix[j], length(arsimpan[j]));
                  for k:=0 to length(arsimpan[j])-1 do
                    arfix[j,k]:=arsimpan[j,k];
                end;
                totaljarak1:=totaljarak2;
              end;
            end;
            c:=c+1;
          end;
        end;
        b:=b+1;
      end;
      a:=a+1;
    end;
  end;

  for i:=0 to length(s)-1 do
  begin
    setlength(copySolusi[i], length(arfix[i]));
    for j:=0 to length(arfix[i])-1 do
      copySolusi[i,j]:=arfix[i,j];
  end;
end;

procedure TForm2.Swap22(const s: rute);
var a, b, c, i, j, k, l, t1, t2, K1, K2 : integer;
    totaljarak1, totaljarak2, W1, W2 : real;
    artampung, arsimpan, arfix : rute;
begin
  setlength(arfix, length(s));
  for j:=0 to length(s)-1 do
  begin
    setlength(arfix[j], length(s[j]));
    for k:=0 to length(s[j])-1 do
      arfix[j,k]:=s[j,k];
  end;

  totaljarak1:=totaljarak(arfix);
  W1:=TotalWaktu(arfix);

  setlength(artampung, 2);
  for i:=0 to length(s)-1 do
  begin
    a:=1;
    while a < length(s[i])-2 do
    begin
      t1:=s[i,a];
      t2:=s[i,a+1];
      if i=0 then b:=1 else b:=0;

      while b < length(s) do
      begin
      if i<>b then
      begin
          c:=1;
          while c < length(s[b])-2 do
          begin
            setlength(arsimpan, length(s));
            for j:=0 to length(s)-1 do
            begin
              setlength(arsimpan[j], length(s[j]));
              for k:=0 to length(s[j])-1 do
                arsimpan[j,k]:=s[j,k];
            end;

            setlength(artampung[0], length(s[i]));
            for j:=0 to length(s[i])-1 do
              artampung[0,j]:=s[i,j];
            setlength(artampung[1], length(s[b]));
            for j:=0 to length(s[b])-1 do
              artampung[1,j]:=s[b,j];

            artampung[0,a]:=artampung[1,c];
            artampung[0,a+1]:=artampung[1,c+1];
            artampung[1,c]:=t1;
            artampung[1,c+1]:=t2;

            K1:=HitungK(artampung[0]);
            K2:=HitungK(artampung[1]);

            if ((K1<Q) and (K2<Q)) then
            begin
              for j:=0 to length(artampung[0])-1 do
                arsimpan[i,j]:=artampung[0,j];
              for j:=0 to length(artampung[1])-1 do
                arsimpan[b,j]:=artampung[1,j];

              totaljarak2:=TotalJarak(arsimpan);
              W2:=TotalWaktu(arsimpan);
              if (totaljarak2<totaljarak1) and (W2<W1) then
              begin
                for j:=0 to length(arsimpan)-1 do
                begin
                  setlength(arfix[j], length(arsimpan[j]));
                  for k:=0 to length(arsimpan[j])-1 do
                    arfix[j,k]:=arsimpan[j,k];
                end;
                totaljarak1:=totaljarak2;
              end;
            end;
            c:=c+1;
          end;
        end;
        b:=b+1;
      end;
      a:=a+1;
    end;
  end;

  for i:=0 to length(s)-1 do
  begin
    setlength(copySolusi[i], length(arfix[i]));
    for j:=0 to length(arfix[i])-1 do
      copySolusi[i,j]:=arfix[i,j];
  end;
end;

procedure TForm2.Exchange(const s: rute);
var a, b, i, j, k, t1: integer;
    jaraklama, jarakbaru, W1, W2 : real;
    artampung, arsimpan : array of integer;
begin
  for i:=0 to length(s)-1 do
  begin
    jaraklama:=HitungJarak(s[i]);
    W1:=HitungW(s[i]);
    a := 1;

    setlength(arsimpan, length(s[i]));
    for k:=0 to length(s[i])-1 do
      arsimpan[k]:=s[i,k];

    while a < length(s[i])-2 do
    begin
      t1:=s[i,a];
      b := a+1;
      while b < length(s[i])-1 do
      begin
        setlength(artampung, length(s[i]));
        for j:=0 to length(s[i])-1 do
          artampung[j]:=s[i,j];

        artampung[a]:=artampung[b];
        artampung[b]:=t1;

        jarakbaru:=HitungJarak(artampung);
        W2:=HitungW(arTampung);

        if (jarakbaru<jaraklama) and (W2<W1) then
        begin
          for j:=0 to length(artampung)-1 do
            arsimpan[j]:=artampung[j];
          jaraklama:=jarakbaru;
        end;
        b:=b+1;
      end;
      a:=a+1;
    end;

    for k:=0 to length(s[i])-1 do
      copySolusi[i,k]:=arsimpan[k];
  end;
end;

procedure TForm2.Opt2(const s: rute);
var a,b,c,d,t1,t2 : integer;
    jaraklama,jarakbaru, W1, W2 : real;
    artampung : array of integer;
    arsimpan : rute;
begin
  setlength(arsimpan, length(s));
  for a:=0 to length(s)-1 do
  begin
    setlength(arsimpan[a], length(s[a]));
    for b:=0 to length(s[a])-1 do
      arsimpan[a,b]:=s[a,b];
  end;

  for a:=0 to length(s)-1 do
  begin
    jaraklama:=HitungJarak(arsimpan[a]);
    w1:=HitungW(arsimpan[a]);
    c:=length(arsimpan[a]);

    if (c>=7) then
    begin
      b:=2;
      while b<length(s[a])-4 do
      begin
        t1:=s[a,b];
        t2:=s[a,b+2];

        setlength(artampung, length(s[a]));
        for d:=0 to length(s[a])-1 do
          artampung[d]:=s[a,d];

        artampung[b+2]:=t1;
        artampung[b]:=t2;

        jarakbaru:=HitungJarak(artampung);
        w2:=HitungW(artampung);

        if (jarakbaru<jaraklama) and (w2<w1) then
          for d:=1 to length(s[a])-2 do
            arsimpan[a,d]:=artampung[d];

        b:=b+1;
      end;
    end;
  end;

  for a:=0 to length(arsimpan)-1 do
    for b:=0 to length(arsimpan[a])-1 do
      copySolusi[a,b]:=arsimpan[a,b];
end;

procedure TForm2.OrOpt(const s: rute);
var a,b,c,d,t1,t2 : integer;
    jaraklama,jarakbaru, W1, W2 : real;
    artampung : array of integer;
    arsimpan : rute;
begin
  setlength(arsimpan, length(s));
  for a:=0 to length(s)-1 do
  begin
    setlength(arsimpan[a], length(s[a]));
    for b:=0 to length(s[a])-1 do
      arsimpan[a,b]:=s[a,b];
  end;

  for a:=0 to length(s)-1 do
  begin
    jaraklama:=HitungJarak(arsimpan[a]);
    w1:=HitungW(arsimpan[a]);

    b:=1;
    while b<length(s[a])-2 do
    begin
      t1:=s[a,b];
      t2:=s[a,b+1];

      c:=1;
      while c<length(s[a])-2 do
      begin
        setlength(artampung, length(s[a]));
        for d:=0 to length(s[a])-1 do
          artampung[d]:=s[a,d];

        if c<>b then
        begin
          for d:=b to length(artampung)-2 do
              artampung[d]:=s[a,d+2];

          for d:=length(artampung)-3 downto c do
            artampung[d+1]:=artampung[d-1];

          artampung[c]:=t1;
          artampung[c+1]:=t2;

          jarakbaru:=HitungJarak(artampung);
          w2:=HitungW(artampung);

          if (jarakbaru<jaraklama) and (w2<w1) then
            for d:=1 to length(s[a])-2 do
              arsimpan[a,d]:=artampung[d];
        end;
        c:=c+1;
      end;
      b:=b+1;
    end;
  end;

  for a:=0 to length(arsimpan)-1 do
    for b:=0 to length(arsimpan[a])-1 do
      copySolusi[a,b]:=arsimpan[a,b];
end;

procedure TForm2.Reverse(const s: rute);
var a,b,c,d,t1 : integer;
    jaraklama,jarakbaru, W1, W2 : real;
    artampung : array of integer;
    arsimpan : rute;
begin
  setlength(arsimpan, length(s));
  for a:=0 to length(s)-1 do
  begin
    setlength(arsimpan[a], length(s[a]));
    for b:=0 to length(s[a])-1 do
      arsimpan[a,b]:=s[a,b];
  end;

  for a:=0 to length(s)-1 do
  begin
    jaraklama:=HitungJarak(arsimpan[a]);
    w1:=HitungW(arsimpan[a]);

    b:=1;
    while b<length(s[a])-1 do
    begin
      t1:=s[a,b];

      c:=1;
      while c<length(s[a])-1 do
      begin
        setlength(artampung, length(s[a]));
        for d:=0 to length(s[a])-1 do
          artampung[d]:=s[a,d];

        if c<>b then
        begin
          for d:=b to length(artampung)-2 do
              artampung[d]:=s[a,d+1];

          for d:=length(artampung)-3 downto c do
            artampung[d+1]:=artampung[d];

          artampung[c]:=t1;

          jarakbaru:=HitungJarak(artampung);
          w2:=HitungW(artampung);

          if (jarakbaru<jaraklama) and (w2<w1) then
            for d:=1 to length(s[a])-2 do
              arsimpan[a,d]:=artampung[d];
        end;
        c:=c+1;
      end;
      b:=b+1;
    end;
  end;

  for a:=0 to length(arsimpan)-1 do
    for b:=0 to length(arsimpan[a])-1 do
      copySolusi[a,b]:=arsimpan[a,b];
end;

procedure TForm2.Shift101Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
Shift10(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Shift(1,0)');
for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Shift201Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Shift20(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Shift(2,0)');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Swap111Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Swap11(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Swap(1,1)');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Swap211Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Swap21(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Swap(2,1)');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Swap221Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Swap22(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Swap(2,2)');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Cross1Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Cross(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Cross');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.N2Opt1Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Opt2(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('2-Opt');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.OrOpt1Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      OrOpt(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Or-Opt');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Reverse1Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Reverse(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Reverse');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Exchange1Click(Sender: TObject);
var a,b : integer;
    ruteakhir : string;
begin
      Exchange(copySolusi);
mmOutput.Lines.Add('');
mmOutput.Lines.Add('Exchange');

for a:=0 to length(copySolusi)-1 do
begin
ruteakhir:='';
for b:=0 to length(copySolusi[a])-1 do
        if b<length(copySolusi[a])-1 then
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b])+'-'
        else
          ruteakhir:=ruteakhir+inttostr(copySolusi[a][b]);

      mmOutput.Lines.Add('rute : [ '+ruteakhir+' ], dengan panjang rute '+floattostr(hitungjarak(copySolusi[a]))+' km, kapasitas '+inttostr(HitungK(copySolusi[a]))+', waktu '+floattostr(HitungW(copySolusi[a])));
end;
mmOutput.Lines.Add('total panjang rute '+floattostr(Totaljarak(copysolusi))+' km, total waktu '+floattostr(TotalWaktu(copysolusi)));
end;

procedure TForm2.Button2Click(Sender: TObject);
var i,j,u,v, xC,yC : integer;
    P1,P2 : TPoint;
begin
  if  (edKapasitas.Text='') or (edTW.Text='') or (edKecepatan.Text='') or
      (edA.Text='') or (edB.Text='') or (edP.Text='') or (edM.Text='') or (edIter.Text='') then
      Application.MessageBox('Masukkan Data','Information', MB_OK or MB_ICONEXCLAMATION)
  else
  begin
    for i:= 0 to Length(Solusi)-1 do
    for j:=0 to length(Solusi[i])-2 do
    begin
      u:= Solusi[i, j];
      v:= Solusi[i, j+1];
      P1 := arTitik[u].posisi;
      P2 := arTitik[v].posisi;
      imghasil.Canvas.Pen.Width := 2;
      imghasil.Canvas.Pen.Color := clwhite;
      imghasil.Canvas.MoveTo(P1.X, P1.Y);
      imghasil.Canvas.LineTo(P2.X, P2.Y);
    end;
    
    parameter;

    ACS;

    setlength(copySolusi, length(Solusi));
      for i:=0 to length(Solusi)-1 do
      begin
        setlength(copySolusi[i], length(Solusi[i]));
        for j:=0 to length(Solusi[i])-1 do
          copySolusi[i,j]:=Solusi[i,j];
      end;

    for i:= 0 to Length(Solusi)-1 do
      for j:=0 to length(Solusi[i])-2 do
      begin
        u:= Solusi[i, j];
        v:= Solusi[i, j+1];
        P1 := arTitik[u].posisi;
        P2 := arTitik[v].posisi;
        imghasil.Canvas.Pen.Width := 2;
        imghasil.Canvas.Pen.Color := clGray;
        imghasil.Canvas.MoveTo(P1.X, P1.Y);
        imghasil.Canvas.LineTo(P2.X, P2.Y);
      end;

    PageControl1.ActivePageIndex:=1;
    PageControl2.ActivePageIndex:=1;
  end;
end;

procedure TForm2.Parameter;
begin
  m:=strtoint(edM.Text);
  alfa:=strtofloat(edA.Text);
  beta:=strtofloat(edB.Text);
  rho:=strtofloat(edP.Text);
  Q:=strtoint(edKapasitas.Text);
  TW:=strtofloat(edTW.Text);
  kecepatan:=strtofloat(edKecepatan.Text);
  itermax:=strtoint(edIter.Text);
  itermaxRVND:=strtoint(edRVND.Text);
end;

procedure TForm2.Update;
var i,j,u,v, xC,yC : integer;
    P1,P2 : TPoint;
begin
  for i:= 0 to Length(pilihSolusi)-1 do
    for j:=0 to length(pilihSolusi[i])-2 do
    begin
      u:= pilihSolusi[i, j];
      v:= pilihSolusi[i, j+1];
      P1 := arTitik[u].posisi;
      P2 := arTitik[v].posisi;
      imghasil.Canvas.Pen.Width := 2;
      imghasil.Canvas.Pen.Color := clwhite;
      imghasil.Canvas.MoveTo(P1.X, P1.Y);
      imghasil.Canvas.LineTo(P2.X, P2.Y);
    end;
end;

procedure TForm2.Cover1Click(Sender: TObject);
begin
  Form1.Show;
  Form2.Hide;
end;

end.
