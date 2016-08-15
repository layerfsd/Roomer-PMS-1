unit sBevel;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, 
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  sCommonData;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsBevel = class(TBevel)
{$IFNDEF NOTFORHELP}
  private
    FCommonData: TsCommonData;
  protected
    StoredBevel: TBevelStyle;
    StoredShape: TBevelShape;
    procedure Paint; override;
    property SkinData: TsCommonData read FCommonData write FCommonData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Invalidate; override;
    procedure CheckSkinSection;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
{$ENDIF}
  end;


implementation

uses sConst, sMessages, sVCLUtils, sGraphUtils, sSkinProps, acntUtils;


procedure TsBevel.AfterConstruction;
begin
  inherited;
  CheckSkinSection;
  FCommonData.Loaded;
end;


procedure TsBevel.CheckSkinSection;
begin
  if Shape = bsFrame then
    FCommonData.SkinSection := s_GroupBox
  else
    FCommonData.SkinSection := iff(Style = bsLowered, s_PanelLow, s_Panel);
end;


constructor TsBevel.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsSpeedButton;
  inherited;
end;


destructor TsBevel.Destroy;
begin
  FreeAndNil(FCommonData);
  inherited;
end;


procedure TsBevel.Invalidate;
begin
  if StoredBevel <> Style then begin
    StoredBevel := Style;
    CheckSkinSection;
    FCommonData.BGChanged := True;
  end;
  if StoredShape <> Shape then begin
    StoredShape := Shape;
    CheckSkinSection;
    FCommonData.BGChanged := True;
  end;
  inherited;
end;


procedure TsBevel.Loaded;
begin
  inherited;
  CheckSkinSection;
  FCommonData.Loaded;
end;


procedure TsBevel.Paint;
const
  BorderWidth = 3;
var
  ParentBG: TacBGInfo;
begin
  if SkinData.Skinned then begin
    if SkinData.BGChanged then begin
      InitCacheBmp(SkinData);
      ParentBG.PleaseDraw := False;
      GetBGInfo(@ParentBG, PArent);
      PaintItem(SkinData.SkinIndex, BGInfoToCI(@ParentBG), False, 0, MkRect(Self), Point(Left, Top), SkinData.FCacheBmp, SkinData.SkinManager);
    end;
    case Shape of
      bsBox, bsFrame: BitBltBorder(Canvas.Handle, 0, 0, Width, Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, BorderWidth);
      bsTopLine:      BitBlt(Canvas.Handle, BorderWidth, 0, Width - 2 * BorderWidth, BorderWidth, SkinData.FCacheBmp.Canvas.Handle, BorderWidth, 0, SRCCOPY);
      bsLeftLine:     BitBlt(Canvas.Handle, 0, BorderWidth, BorderWidth, Height - 2 * BorderWidth, SkinData.FCacheBmp.Canvas.Handle, 0, BorderWidth, SRCCOPY);
      bsRightLine:    BitBlt(Canvas.Handle, Width - BorderWidth, BorderWidth, BorderWidth, Height - 2 * BorderWidth, SkinData.FCacheBmp.Canvas.Handle, Width - BorderWidth, 0, SRCCOPY);
      bsBottomLine:   BitBlt(Canvas.Handle, BorderWidth, Height - BorderWidth, Width - 2 * BorderWidth, BorderWidth, SkinData.FCacheBmp.Canvas.Handle, BorderWidth, Height - BorderWidth, SRCCOPY);
      bsSpacer:       inherited;
    end;
  end
  else
    inherited;
end;


procedure TsBevel.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_GETAPPLICATION: begin
        Message.Result := LRESULT(Application);
        Exit;
      end;

      AC_SETNEWSKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          CommonWndProc(Message, FCommonData);
          Exit;
        end;

      AC_REMOVESKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not (csDestroying in ComponentState) then begin
          CommonWndProc(Message, FCommonData);
          if Visible then
            Repaint;
        end;

      AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          CommonWndProc(Message, FCommonData);
          if Visible then
            Repaint;

          Exit;
        end;

      AC_INVALIDATE: begin
        FCommonData.FUpdating := False;
        FCommonData.BGChanged := True;
        Repaint;
        Exit;
      end;
    end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      WM_ERASEBKGND:
        Exit;

      WM_WINDOWPOSCHANGED, WM_SIZE:
        if Visible then
          FCommonData.BGChanged := True;
    end;
    CommonWndProc(Message, FCommonData);
    inherited;
  end;
end;

end.
