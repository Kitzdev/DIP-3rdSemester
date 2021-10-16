unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ExtDlgs, StdCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonSave: TBitBtn;
    ButtonLoad: TBitBtn;
    ButtonWarna: TBitBtn;
    ButtonRed: TBitBtn;
    ButtonGreen: TBitBtn;
    ButtonBlue: TBitBtn;
    ButtonGray: TBitBtn;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonBlueClick(Sender: TObject);
    procedure ButtonGrayClick(Sender: TObject);
    procedure ButtonGreenClick(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonRedClick(Sender: TObject);
    procedure ButtonWarnaClick(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

{ TFormUtama }
uses
  windows;

var
  bitmapR, bitmapG, bitmapB : array [0..1000, 0..1000] of byte;

procedure TFormUtama.ButtonLoadClick(Sender: TObject);
var
  x, y : integer;
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile (OpenPictureDialog1.FileName);
    for y := 0 to Image1.height - 1 do
    begin
      for x := 0 to Image1.height - 1 do
      begin
        bitmapR[x,y] := GetRValue(image1.Canvas.Pixels[x,y]);
        bitmapG[x,y] := GetGValue(image1.Canvas.Pixels[x,y]);
        bitmapB[x,y] := GetBValue(image1.Canvas.Pixels[x,y]);
      end;
    end;
  end;
end;

procedure TFormUtama.ButtonGreenClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to image1.Height - 1 do
  begin
    for x := 0 to image1.Width - 1 do
    begin
      image1.Canvas.Pixels[x,y] :=  RGB(0, bitmapG[x,y], 0)
    end;
  end;
end;

procedure TFormUtama.ButtonBlueClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to image1.Height - 1 do
  begin
    for x := 0 to image1.Width - 1 do
    begin
      image1.Canvas.Pixels[x,y] := RGB(0, 0, bitmapB[x,y]);
    end;
  end;
end;

procedure TFormUtama.ButtonSaveClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    image1.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TFormUtama.ButtonGrayClick(Sender: TObject);
var
  x, y : integer;
  gray : byte;
begin
  for y := 0 to image1.Height - 1 do
  begin
    for x := 0 to image1.Width - 1 do
    begin
      gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
      image1.Canvas.Pixels[x,y] := RGB(gray, gray, gray);
    end;
  end;
end;

procedure TFormUtama.ButtonRedClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to image1.Height - 1 do
  begin
    for x := 0 to image1.Width - 1 do
    begin
      image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], 0, 0);
    end;
  end;
end;

procedure TFormUtama.ButtonWarnaClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to image1.Height - 1 do
  begin
    for x := 0 to image1.Width - 1 do
    begin
      image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
    end;
  end;
end;

end.

