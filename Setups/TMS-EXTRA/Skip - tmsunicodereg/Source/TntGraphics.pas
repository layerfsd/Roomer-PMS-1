{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 - 2008 by TMS software                                   }
{ Email : info@tmssoftware.com                                              }
{ Web : http://www.tmssoftware.com                                          }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit TntGraphics;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  Graphics, Windows;

procedure WideCanvasTextRect(Canvas: TCanvas; Rect: TRect; X, Y: Integer; const Text: WideString);
procedure WideCanvasTextOut(Canvas: TCanvas; X, Y: Integer; const Text: WideString);
function WideCanvasTextExtent(Canvas: TCanvas; const Text: WideString): TSize;
function WideDCTextExtent(hDC: THandle; const Text: WideString): TSize;
function WideCanvasTextWidth(Canvas: TCanvas; const Text: WideString): Integer;
function WideCanvasTextHeight(Canvas: TCanvas; const Text: WideString): Integer;

type
  TTntPicture = TPicture;

implementation

procedure WideCanvasTextRect(Canvas: TCanvas; Rect: TRect; X, Y: Integer; const Text: WideString);
begin
  Canvas.TextRect(Rect, X, Y, Text);
end;

procedure WideCanvasTextOut(Canvas: TCanvas; X, Y: Integer; const Text: WideString);
begin
  Canvas.TextOut(X, Y, Text);
end;

function WideDCTextExtent(hDC: THandle; const Text: WideString): TSize;
begin
  Result.cx := 0;
  Result.cy := 0;
  Windows.GetTextExtentPoint32(hDC, Text, Length(Text), Result);
end;

function WideCanvasTextExtent(Canvas: TCanvas; const Text: WideString): TSize;
begin
  Result := Canvas.TextExtent(Text);
end;

function WideCanvasTextWidth(Canvas: TCanvas; const Text: WideString): Integer;
begin
  Result := WideCanvasTextExtent(Canvas, Text).cX;
end;

function WideCanvasTextHeight(Canvas: TCanvas; const Text: WideString): Integer;
begin
  Result := WideCanvasTextExtent(Canvas, Text).cY;
end;


{$ENDIF}


{$IFNDEF DELPHI_UNICODE}

interface

uses
  Graphics, Windows;

{TNT-WARN TextRect}
procedure WideCanvasTextRect(Canvas: TCanvas; Rect: TRect; X, Y: Integer; const Text: WideString);
{TNT-WARN TextOut}
procedure WideCanvasTextOut(Canvas: TCanvas; X, Y: Integer; const Text: WideString);
{TNT-WARN TextExtent}
function WideCanvasTextExtent(Canvas: TCanvas; const Text: WideString): TSize;
function WideDCTextExtent(hDC: THandle; const Text: WideString): TSize;
{TNT-WARN TextWidth}
function WideCanvasTextWidth(Canvas: TCanvas; const Text: WideString): Integer;
{TNT-WARN TextHeight}
function WideCanvasTextHeight(Canvas: TCanvas; const Text: WideString): Integer;


type
{TNT-WARN TPicture}
  TTntPicture = class(TPicture{TNT-ALLOW TPicture})
  public
    procedure LoadFromFile(const Filename: WideString);
    procedure SaveToFile(const Filename: WideString);
  end;

implementation

uses
  SysUtils, TntSysUtils, TntWindows;

type
  TAccessCanvas = class(TCanvas);



procedure WideCanvasTextRect(Canvas: TCanvas; Rect: TRect; X, Y: Integer; const Text: WideString);
var
  Options: Longint;
begin
  with TAccessCanvas(Canvas) do begin
    Changing;
    RequiredState([csHandleValid, csFontValid, csBrushValid]);
    Options := ETO_CLIPPED or TextFlags;
    if Brush.Style <> bsClear then
      Options := Options or ETO_OPAQUE;
    if ((TextFlags and ETO_RTLREADING) <> 0) and
       (CanvasOrientation = coRightToLeft) then Inc(X, WideCanvasTextWidth(Canvas, Text) + 1);

    Tnt_ExtTextOutW(Handle, X, Y, Options, @Rect, PWideChar(Text), Length(Text), nil);

    Changed;
  end;
end;

procedure WideCanvasTextOut(Canvas: TCanvas; X, Y: Integer; const Text: WideString);
begin
  with TAccessCanvas(Canvas) do
  begin
    Changing;
    RequiredState([csHandleValid, csFontValid, csBrushValid]);
    if CanvasOrientation = coRightToLeft then Inc(X, WideCanvasTextWidth(Canvas, Text) + 1);

    Tnt_ExtTextOutW(Handle, X, Y, TextFlags, nil, PWideChar(Text), Length(Text), nil);

    MoveTo(X + WideCanvasTextWidth(Canvas, Text), Y);
    Changed;
  end;
end;

function WideDCTextExtent(hDC: THandle; const Text: WideString): TSize;
begin
  Result.cx := 0;
  Result.cy := 0;
  Windows.GetTextExtentPoint32W(hDC, PWideChar(Text), Length(Text), Result);
end;

function WideCanvasTextExtent(Canvas: TCanvas; const Text: WideString): TSize;
begin
  with TAccessCanvas(Canvas) do begin
    RequiredState([csHandleValid, csFontValid]);
    Result := WideDCTextExtent(Handle, Text);
  end;
end;

function WideCanvasTextWidth(Canvas: TCanvas; const Text: WideString): Integer;
begin
  Result := WideCanvasTextExtent(Canvas, Text).cX;
end;

function WideCanvasTextHeight(Canvas: TCanvas; const Text: WideString): Integer;
begin
  Result := WideCanvasTextExtent(Canvas, Text).cY;
end;

{ TTntPicture }

procedure TTntPicture.LoadFromFile(const Filename: WideString);
var
  ShortName: WideString;
begin
  ShortName := WideExtractShortPathName(Filename);
  if WideSameText(WideExtractFileExt(FileName), '.jpeg') // the short name ends with ".JPE"!
  or (ShortName = '') then // GetShortPathName failed
    inherited LoadFromFile(FileName)
  else
    inherited LoadFromFile(WideExtractShortPathName(Filename));
end;

procedure TTntPicture.SaveToFile(const Filename: WideString);
var
  TempFile: WideString;
begin
  if Graphic <> nil then begin
    // create to temp file (ansi safe file name)
    repeat
      TempFile := WideExtractFilePath(Filename) + IntToStr(Random(MaxInt)) + WideExtractFileExt(Filename);
    until not WideFileExists(TempFile);
    CloseHandle(WideFileCreate(TempFile)); // make it a real file so that it has a temp
    try
      // save
      Graphic.SaveToFile(WideExtractShortPathName(TempFile));
      // rename
      WideDeleteFile(Filename);
      if not WideRenameFile(TempFile, FileName) then
        RaiseLastOSError;
    finally
      WideDeleteFile(TempFile);
    end;
  end;
end;

{$ENDIF}

end.
