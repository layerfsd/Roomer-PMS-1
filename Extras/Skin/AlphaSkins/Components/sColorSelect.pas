unit sColorSelect;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Buttons, sSpeedButton;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsColorSelect = class(TsSpeedButton)
{$IFNDEF NOTFORHELP}
  private
    FColorValue: TColor;
    FCustomColors: TStrings; 
    FOnChange: TNotifyEvent;
    FImgWidth: integer;
    FImgHeight: integer;
    FStandardDlg: boolean;
    procedure SetCustomColors(const Value: TStrings);
    procedure SetColorValue(const Value: TColor);
    procedure SetImgHeight(const Value: integer);
    procedure SetImgWidth (const Value: integer);
  public
    ColorDialog: TColorDialog;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
    procedure UpdateGlyph(Repaint: boolean = True);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
{$ENDIF} // NOTFORHELP
    property CustomColors: TStrings read FCustomColors write SetCustomColors;
    property ColorValue: TColor read FColorValue write SetColorValue;
    property ImgWidth:  integer read FImgWidth  write SetImgWidth  default 15;
    property ImgHeight: integer read FImgHeight write SetImgHeight default 15;
    property StandardDlg: boolean read FStandardDlg write FStandardDlg default False;
  end;

implementation

uses acntUtils, sDialogs, sCommonData, sMessages, sAlphaGraph, sConst;


procedure TsColorSelect.AfterConstruction;
begin
  inherited;
  UpdateGlyph(False);
end;


procedure TsColorSelect.Click;
var
  cd: TColorDialog;
begin
  if ColorDialog = nil then
    if FStandardDlg then
      cd := TColorDialog.Create(Self)
    else
      cd := TsColorDialog.Create(Self)
  else
    cd := ColorDialog;

  cd.Color := ColorValue;
  cd.CustomColors.Assign(FCustomColors);
  if cd.Execute then begin
    ColorValue := cd.Color;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
  FCustomColors.Free;
  if ColorDialog <> cd then
    FreeAndNil(cd);

  inherited Click;
end;


constructor TsColorSelect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCustomColors := TStringList.Create;
  FImgHeight := 15;
  FImgWidth := 15;
  FStandardDlg := False;
end;


procedure TsColorSelect.Loaded;
begin
  inherited;
  UpdateGlyph(False);
end;


procedure TsColorSelect.SetColorValue(const Value: TColor);
begin
  if FColorValue <> Value then begin
    FColorValue := Value;
    Glyph.Assign(nil);
    UpdateGlyph;
  end;
end;


procedure TsColorSelect.SetImgHeight(const Value: integer);
begin
  if FImgHeight <> Value then begin
    FImgHeight := Value;
    Glyph.Assign(nil);
    UpdateGlyph;
  end;
end;


procedure TsColorSelect.SetImgWidth(const Value: integer);
begin
  if FImgWidth <> Value then begin
    FImgWidth := Value;
    Glyph.Assign(nil);
    UpdateGlyph;
  end;
end;


procedure TsColorSelect.UpdateGlyph;
begin
  if not (csLoading in ComponentState) then
    if (FImgHeight <> 0) and (FImgWidth <> 0) and (Glyph.Canvas.Pixels[FImgWidth div 2, FImgHeight div 2] <> ColorValue) then begin
      Glyph.OnChange := nil;
      OldOnChange := nil;
      Glyph.PixelFormat := pf32bit;
      Glyph.Width := FImgWidth;
      Glyph.Height := FImgHeight;
      FillRect32(Glyph, MkRect(FImgWidth, FImgHeight), ColorToRGB(ColorValue));
      // Transparent pixels in corners
      Glyph.Canvas.Pixels[0, FImgHeight - 1]             := sFuchsia.C;
      Glyph.Canvas.Pixels[0, 0]                          := sFuchsia.C;
      Glyph.Canvas.Pixels[FImgWidth - 1, FImgHeight - 1] := sFuchsia.C;
      Glyph.Canvas.Pixels[FImgWidth - 1, 0]              := sFuchsia.C;
      if Repaint then begin
        SkinData.BGChanged := True;
        GraphRepaint;
      end;
    end;
end;


procedure TsColorSelect.SetCustomColors(const Value: TStrings);
begin
  FCustomColors.Assign(Value);
end;


procedure TsColorSelect.WndProc(var Message: TMessage);
begin
  inherited;
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then
          UpdateGlyph;
    end;
end;

end.
