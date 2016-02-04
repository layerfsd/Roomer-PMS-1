unit sMemo;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, StdCtrls,
  {$IFDEF TNTUNICODE} TntStdCtrls, TntClasses, TntSysUtils, TntActnList, TntControls, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sConst, sCommonData, sDefaults, acSBUtils;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsMemo = class(TTntMemo)
{$ELSE}
  TsMemo = class(TMemo)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FOnVScroll,
    FOnScrollCaret: TNotifyEvent;

    FBoundLabel: TsBoundLabel;
    FCommonData: TsScrollWndData;
    FDisabledKind: TsDisabledKind;
    procedure SetDisabledKind(const Value: TsDisabledKind);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    ListSW: TacScrollWnd;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
    property Text;
    property CharCase;
    Property OnScrollCaret: TNotifyEvent read FOnScrollCaret write FOnScrollCaret;
    Property OnVScroll:     TNotifyEvent read FOnVScroll     write FOnVScroll;
{$ENDIF} // NOTFORHELP
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
{$IFDEF TNTUNICODE}
    property SelText;
    property SelStart;
    property SelLength;
{$ENDIF}
  end;


implementation

uses Menus,
  sStyleSimply, sVCLUtils, sMessages, sSkinProps;


procedure TsMemo.AfterConstruction;
begin
  inherited AfterConstruction;
  FCommonData.Loaded;
end;


constructor TsMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque];
  FCommonData := TsScrollWndData.Create(Self);
  FCommonData.COC := COC_TsMemo;
  FDisabledKind := DefDisabledKind;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
end;


destructor TsMemo.Destroy;
begin
  if ListSW <> nil then
    FreeAndNil(ListSW);
    
  FreeAndNil(FBoundLabel);
  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  inherited Destroy;
end;


procedure TsMemo.Loaded;
begin
  inherited Loaded;
  FCommonData.Loaded;
  RefreshEditScrolls(SkinData, ListSW);
end;


procedure TsMemo.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsMemo.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  State: integer;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit;
        end; // AlphaSkins supported

        AC_SETNEWSKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonWndProc(Message, FCommonData);
            Exit;
          end;

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            if ListSW <> nil then
              FreeAndNil(ListSW);

            CommonWndProc(Message, FCommonData);
            RecreateWnd;
            Exit;
          end;

        AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            CommonWndProc(Message, FCommonData);
            RefreshEditScrolls(SkinData, ListSW);
            if HandleAllocated and Visible then
              RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);

            Exit;
          end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssEdit] + 1;

          Exit;
        end;
      end;

    CM_FONTCHANGED:
      if Showing and HandleAllocated then
        RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME);
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      WM_PAINT: begin
        // Correction of used color if not equal
        if not SkinData.CustomColor and (SkinData.SkinIndex >= 0) then
          with SkinData.SkinManager.gd[SkinData.SkinIndex] do begin
            State := integer(SkinData.FFocused or SkinData.FMouseAbove and MayBeHot(SkinData));
            if (Color <> Props[State].Color) then
              Color := Props[State].Color;

            if (Font.Color <> Props[State].FontColor.Color) then
              Font.Color := Props[State].FontColor.Color;
          end;

        if InUpdating(FCommonData) then begin // Exit if parent is not ready yet
          BeginPaint(Handle, PS);
          EndPaint  (Handle, PS);
          Exit;
        end;
        inherited;
        Exit;
      end;
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    case Message.Msg of
      CM_SHOWINGCHANGED:
        RefreshEditScrolls(SkinData, ListSW);

      CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_SETFONT:
        FCommonData.Invalidate;

      CM_TEXTCHANGED, CM_CHANGED:
        if Assigned(ListSW) then
          UpdateScrolls(ListSW, True);

      EM_SETSEL:
        if Assigned(FOnScrollCaret) then
          FOnScrollCaret(Self);

      WM_HSCROLL, WM_VSCROLL:
        if (Message.Msg = WM_VSCROLL) and Assigned(FOnVScroll) then
          FOnVScroll(Self);
    end;
  end;
  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;


procedure TsMemo.KeyDown(var Key: Word; Shift: TShiftState);
var
  M: tagMsg;
begin
  inherited KeyDown(Key, Shift);
  if (ShortCut(Key, Shift) = scCtrl + ord('A')) then begin
    SelectAll;
    Key := 0;
    PeekMessage(M, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
end;

end.

