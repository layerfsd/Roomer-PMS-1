unit sRichEdit;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ComCtrls,
  {$IFDEF TNTUNICODE} TntComCtrls, {$ENDIF}
  sConst, sCommonData, sDefaults, acSBUtils;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsRichEdit = class(TTntRichEdit)
{$ELSE}
  TsRichEdit = class(TRichEdit)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FCommonData: TsScrollWndData;
    FDisabledKind: TsDisabledKind;
    FBoundLabel: TsBoundLabel;
    procedure SetDisabledKind(const Value: TsDisabledKind);
    procedure WMPrint(var Message: TWMPaint); message WM_PRINT;
  public
    ListSW: TacScrollWnd;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc (var Message: TMessage); override;
  published
    property Text;
{$ENDIF} // NOTFORHELP
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
  end;


implementation

uses
  CommCtrl, RichEdit,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sVCLUtils, sStyleSimply, sMessages, sGraphUtils, sAlphaGraph, sSkinProps;


procedure TsRichEdit.AfterConstruction;
begin
  inherited AfterConstruction;
  if HandleAllocated then
    RefreshEditScrolls(SkinData, ListSW);

  UpdateData(FCommonData);
end;


constructor TsRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsScrollWndData.Create(Self, True);
  FCommonData.COC := COC_TsMemo;
  FDisabledKind := DefDisabledKind;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
  Perform(WM_USER + 53{EM_EXLIMITTEXT}, 0, $7FFFFFF0);
end;


destructor TsRichEdit.Destroy;
begin
  if ListSW <> nil then
    FreeAndNil(ListSW);

  FreeAndNil(FBoundLabel);
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  inherited Destroy;
end;


procedure TsRichEdit.Loaded;
begin
  inherited Loaded;
  FCommonData.Loaded(False);
  RefreshEditScrolls(SkinData, ListSW);
end;


procedure TsRichEdit.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsRichEdit.WMPrint(var Message: TWMPaint);
var
  SavedDC: hdc;
  Range: TFormatRange;
begin
  if SkinData.Skinned then begin
    FillChar(Range, SizeOf(TFormatRange), 0);

    Range.rc.Left := 0;
    Range.rc.Top  := 0;
    Range.rc.Right  := (Width  - 6) * 1440 div Screen.PixelsPerInch;
    Range.rc.Bottom := (Height - 6) * 1440 div Screen.PixelsPerInch;

    Range.hdc := Message.DC;
    Range.hdcTarget := Message.DC;
    Range.chrg.cpMax := -1;
    Range.chrg.cpMin := 0;

    SavedDC := SaveDC(Message.DC);
    try
      MoveWindowOrg(Message.DC, ListSW.cxLeftEdge, ListSW.cxLeftEdge);
      SkinData.Updating := False;
      SendMessage(Handle, WM_ERASEBKGND, WPARAM(Message.DC), Message.Unused);
      MoveWindowOrg(Message.DC, 1, 1);
      IntersectClipRect(Message.DC, 0, 0,
        SkinData.FCacheBmp.Width  - 2 * ListSW.cxLeftEdge - integer(ListSW.sBarVert.fScrollVisible) * GetScrollMetric(ListSW.sBarVert, SM_SCROLLWIDTH),
        SkinData.FCacheBmp.Height - 2 * ListSW.cxLeftEdge - integer(ListSW.sBarHorz.fScrollVisible) * GetScrollMetric(ListSW.sBarHorz, SM_SCROLLWIDTH));

      SendMessage(Handle, EM_FORMATRANGE, 1, LPARAM(@Range));
//      SendMessage(Handle, WM_PRINTCLIENT, WPARAM(Message.DC), Message.Unused);
//      DefaultHandler(Message);
    finally
      RestoreDC(Message.DC, SavedDC);
    end;
    SendMessage(Handle, EM_FORMATRANGE, 0, 0);
    ControlState := ControlState + [csPaintCopy];

    if SkinData.BGChanged then
      PrepareCache(SkinData, Handle, False);

    if BorderStyle <> bsNone then begin
      UpdateCorners(SkinData, 0);
      BitBltBorder(TWMPaint(Message).DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, 2);
    end;
    Ac_NCDraw(ListSW, Handle, -1, TWMPaint(Message).DC);
    Message.Result := 2;
  end;
end;


procedure TsRichEdit.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end; // AlphaSkins supported

      AC_GETAPPLICATION: begin
        Message.Result := LRESULT(Application);
        Exit;
      end;

      AC_REMOVESKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and not (csDestroying in ComponentState) then begin
          if ListSW <> nil then begin
            FreeAndNil(ListSW);
//            if not FCommonData.CustomFont then
            DefAttributes.Color := Font.Color;
            RecreateWnd;
          end;
          Exit;
        end;

      AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and Visible then begin
          RefreshEditScrolls(SkinData, ListSW);
          CommonMessage(Message, FCommonData);
          if FCommonData.Skinned then
            if not FCommonData.CustomFont and (DefAttributes.Color <> FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].FontColor.Color) then
              DefAttributes.Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].FontColor.Color;

          Perform(WM_NCPAINT, 0, 0);
          Exit;
        end;

      AC_SETNEWSKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          CommonMessage(Message, FCommonData);
          Exit;
        end;

      AC_GETDISKIND:
        if Message.LParam <> 0 then
          PsDisabledKind(Message.LParam)^ := DisabledKind;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssEdit] + 1;

        Exit;
      end;
    end;

  if not ControlIsReady(Self) or not Assigned(FCommonData) or not FCommonData.Skinned then
    inherited
  else begin
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_ENDPARENTUPDATE:
          if FCommonData.Updating then begin
            if not InUpdating(FCommonData, True) then
              Perform(WM_NCPAINT, 0, 0);

            Exit;
          end;
      end;

    CommonWndProc(Message, FCommonData);
    inherited;
    case Message.Msg of
      TB_SETANCHORHIGHLIGHT, WM_SIZE:
        Perform(WM_NCPAINT, 0, 0);

      CM_SHOWINGCHANGED:
        RefreshEditScrolls(SkinData, ListSW);

      CM_ENABLEDCHANGED: begin
        if not FCommonData.CustomColor then
          with FCommonData.SkinManager.gd[FCommonData.SkinIndex] do begin
            Color := Props[0].Color;
            if not Enabled then
              Font.Color := AverageColor(Props[0].FontColor.Color, Color)
            else
              Font.Color := Props[0].FontColor.Color;

            DefAttributes.Color := Font.Color;
          end;

        FCommonData.Invalidate
      end;
    end;
  end;
  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;

end.
