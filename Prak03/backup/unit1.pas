unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ExtDlgs, StdCtrls, ComCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonContrast: TButton;
    ButtonInvers: TButton;
    ButtonBiner: TBitBtn;
    ButtonSave: TBitBtn;
    ButtonLoad: TBitBtn;
    ButtonWarna: TBitBtn;
    ButtonGray: TBitBtn;
    ButtonBrightness: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    kLabel: TLabel;
    GLabel: TLabel;
    PLabel: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    procedure ButtonContrastClick(Sender: TObject);
    procedure ButtonInversClick(Sender: TObject);
    procedure ButtonBinerClick(Sender: TObject);
    procedure ButtonBrightnessClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonGrayClick(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
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
  end;
  for y := 0 to image1.height - 1 do
  begin
    for x := 0 to image1.width - 1 do
    begin
      bitmapR[x,y] := GetRValue(image1.Canvas.Pixels[x,y]);
      bitmapG[x,y] := GetGValue(image1.Canvas.Pixels[x,y]);
      bitmapB[x,y] := GetBValue(image1.Canvas.Pixels[x,y]);
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

procedure TFormUtama.ButtonBinerClick(Sender: TObject);
var
  x, y, gray : integer;
begin
  for y := 0 to image1.Height - 1 do
  begin
    for x := 0 to image1.Width - 1 do
    begin
      gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
      if gray <= trackbar1.position then
      begin
         image1.canvas.pixels[x,y] := RGB(0,0,0);
      end
      else
      begin
         image1.canvas.pixels[x,y] := RGB(255, 255, 255);
      end;
    end;
  end;
end;

procedure TFormUtama.ButtonInversClick(Sender: TObject);
var
  x, y, redvalue, greenvalue, bluevalue : integer;
begin
  for y := 0 to image1.height - 1 do
     begin
       for x := 0 to image1.width  -1 do
       begin
         redvalue := 255 - GetRValue(image1.Canvas.Pixels[x,y]);
         if redvalue  < 0 then redvalue := 0;
         if redvalue > 255 then redvalue := 255;
         greenvalue := 255 - GetGValue(image1.Canvas.Pixels[x,y]);
         if greenvalue < 0 then greenvalue := 0;
         if greenvalue > 255 then greenvalue := 255;
         bluevalue := 255 - GetBValue(image1.Canvas.Pixels[x,y]);
         if bluevalue < 0 then bluevalue := 0;
         if bluevalue > 255 then bluevalue := 255;
         image2.canvas.pixels[x,y] := RGB(redvalue, greenvalue, bluevalue);
       end;
     end;
end;

procedure TFormUtama.ButtonContrastClick(Sender: TObject);
  var
  x, y, redvalue, greenvalue, bluevalue, G, P : integer;
begin
     P := trackbar2.position;
     G := trackbar3.position;
     for y := 0 to image1.height - 1 do
     begin
       for x := 0 to image1.width  -1 do
       begin
         redvalue := G * (GetRValue(image1.Canvas.Pixels[x,y]) - P) + P;
         if redvalue  < 0 then redvalue := 0;
         if redvalue > 255 then redvalue := 255;
         greenvalue := G * (GetGValue(image1.Canvas.Pixels[x,y]) - P) + P;
         if greenvalue < 0 then greenvalue := 0;
         if greenvalue > 255 then greenvalue := 255;
         bluevalue := G * (GetBValue(image1.Canvas.Pixels[x,y]) - P) + P;
         if bluevalue < 0 then bluevalue := 0;
         if bluevalue > 255 then bluevalue := 255;
         image2.canvas.pixels[x,y] := RGB(redvalue, greenvalue, bluevalue);
       end;
     end;
end;

procedure TFormUtama.ButtonBrightnessClick(Sender: TObject);
var
  x, y, redvalue, greenvalue, bluevalue : integer;
begin
     for y := 0 to image1.height - 1 do
     begin
       for x := 0 to image1.width  -1 do
       begin
         redvalue := GetRValue(image1.Canvas.Pixels[x,y]) + trackbar1.position;
         if redvalue  < 0 then redvalue := 0;
         if redvalue > 255 then redvalue := 255;
         greenvalue := GetGValue(image1.Canvas.Pixels[x,y]) + trackbar1.position;
         if greenvalue < 0 then greenvalue := 0;
         if greenvalue > 255 then greenvalue := 255;
         bluevalue := GetBValue(image1.Canvas.Pixels[x,y]) + trackbar1.position;
         if bluevalue < 0 then bluevalue := 0;
         if bluevalue > 255 then bluevalue := 255;
         image2.canvas.pixels[x,y] := RGB(redvalue, greenvalue, bluevalue);
       end;
     end;
end;

end.

