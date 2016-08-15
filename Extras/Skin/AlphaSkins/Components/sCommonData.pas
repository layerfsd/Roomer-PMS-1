unit sCommonData;
{$I sDefs.inc}
//{$DEFINE DEBUG}
//+
interface

uses
  Windows, Graphics, Classes, Controls, SysUtils, extctrls, StdCtrls, Forms, Messages,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF FPC} LMessages, {$ENDIF}
  {$IFDEF DELPHI_XE2} UItypes, {$ENDIF}
  sSkinManager, acntUtils, sConst, sLabel, acThdTimer;


type
  TsCommonData = class;
  TacOuterEffects = class(TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FOwner: TsCommonData;
    FVisibility: TacOuterVisibility;
    procedure SetVisibility(const Value: TacOuterVisibility);
  public
    procedure Invalidate;
    constructor Create(AOwner: TsCommonData);
{$ENDIF}
  published
    property Visibility: TacOuterVisibility read FVisibility write SetVisibility default ovNone;
  end;


  TsCommonData = class(TPersistent)
{$IFNDEF NOTFORHELP}
  protected
    FCustomFont,
    FCustomColor: boolean;
    FOuterCache: TBitmap;
    FSkinSection: TsSkinSection;
    FOuterEffects: TacOuterEffects;
    function GetUpdating: boolean;
    procedure SetSkinSection(const Value: string);
{$IFDEF DEBUG}
    procedure SetBGChanged  (const Value: boolean);
    procedure SetUpdating   (const Value: boolean);
    procedure SetSkinIndex  (const Value: integer);
    procedure SetFOwnerControl(const Value: TControl);
{$ENDIF}
    procedure SetCustomColor(const Value: boolean);
    procedure SetCustomFont (const Value: boolean);
    procedure SetHUEOffset  (const Value: integer);
    procedure SetSaturation (const Value: integer);
    procedure SetColorTone  (const Value: TColor);
    procedure SetSkinManager(const Value: TsSkinManager);
    procedure PaintOuter(PBGInfo: PacBGInfo; Data: Word);
    function GetSkinManager: TsSkinManager;
  public
    SavedColor,
    SavedFontColor: TColor;

    FFocused,
    FUpdating,
    FMouseAbove,
    HalfVisible,
    Loading: boolean;

    COC,
    GlowID,
    Texture,
    FHUEOffset,
    FSaturation,
    BorderIndex,
    ScalePercent,
    FUpdateCount,
    HotTexture: integer;

    PrintDC: hdc;
    FCacheBmp: TBitmap;
    FColorTone: TColor;
    FSWHandle: THandle;
    FOwnerObject: TObject;
    FSkinManager: TsSkinManager;
    AnimTimer: TacThreadedTimer;
    WndProc: TWndMethod;

    BGType,
    CtrlSkinState: word;

    InvalidRectH,
    InvalidRectV: TRect;
{$IFNDEF DEBUG}
    BGChanged: boolean;
    SkinIndex: integer;
    FOwnerControl: TControl;
    property Updating: boolean read GetUpdating write FUpdating default False;
{$ELSE}
    FSkinIndex: integer;
    FBGChanged: boolean;
    FFOwnerControl: TControl;
    property BGChanged: boolean read FBGChanged write SetBGChanged;
    property Updating: boolean read GetUpdating write SetUpdating default False;
    property SkinIndex: integer read FSkinIndex write SetSkinIndex;
    property FOwnerControl: TControl read FFOwnerControl write SetFOwnerControl;
{$ENDIF}
    constructor Create(AOwner: TObject; const CreateCacheBmp: boolean); virtual;
    procedure ClearLinks;
    procedure UpdateIndexes(UpdateMain: boolean = True);
    procedure PaintOuterEffects(OwnerCtrl: TWinControl; Offset: TPoint);
    destructor Destroy; override;
    procedure InitCommonProp;
    procedure RemoveCommonProp;
    procedure Loaded(UpdateColors: boolean = True);
    function RepaintIfMoved: boolean;
    function ManagerStored: boolean;
    function OwnerHandle: THandle;
{$ENDIF} // NOTFORHELP
    procedure BeginUpdate;
    procedure EndUpdate (const Repaint:   boolean = False);
    procedure Invalidate(const UpdateNow: boolean = False);
    function Skinned(const CheckSkinActive: boolean = False): boolean;
    property HUEOffset:  integer read FHUEOffset  write SetHUEOffset  default 0;
    property Saturation: integer read FSaturation write SetSaturation default 0;
    property ColorTone:  TColor  read FColorTone  write SetColorTone  default clNone;
  published
    property CustomColor: boolean read FCustomColor write SetCustomColor default False;
    property CustomFont:  boolean read FCustomFont  write SetCustomFont  default False;
    property SkinManager: TsSkinManager read GetSkinManager write SetSkinManager stored ManagerStored;
    property SkinSection: TsSkinSection read FSkinSection write SetSkinSection;
    property OuterEffects: TacOuterEffects read FOuterEffects write FOuterEffects;
  end;


{$IFNDEF NOTFORHELP}
  TsCtrlSkinData = class(TsCommonData)
  published
    property HUEOffset;
    property Saturation;
    property ColorTone;
  end;


  TacScrollData = class(TPersistent)
  private
    FScrollWidth,
    FButtonsSize: integer;
    procedure SetScrollWidth(const Value: integer);
    procedure SetButtonsSize(const Value: integer);
  protected
    FOwner: TsCommonData;
  public
    constructor Create(AOwner: TsCommonData);
    procedure Invalidate;
  published
    property ScrollWidth: integer read FScrollWidth write SetScrollWidth default -1;
    property ButtonsSize: integer read FButtonsSize write SetButtonsSize default -1;
  end;


  TsScrollWndData = class(TsCommonData)
  private
    FHorzScrollData,
    FVertScrollData: TacScrollData;
  public
    constructor Create(AOwner: TObject; const CreateCacheBmp: boolean = True); override;
    destructor Destroy; override;
  published
    property VertScrollData: TacScrollData read FVertScrollData write FVertScrollData;
    property HorzScrollData: TacScrollData read FHorzScrollData write FHorzScrollData;
  end;
{$ENDIF} // NOTFORHELP


  TsBoundLabel = class(TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FIndent,
    FMaxWidth,
    ScalePercent: integer;

    FUseHTML,
    FEnabledAlways: boolean;

    FFont: TFont;
    FText: acString;
    FLayout: TsCaptionLayout;
    FAllowClick: boolean;
    function GetFont: TFont;
    procedure UpdateAlignment;
    function GetUseSkin: boolean;
    procedure DoClick         (Sender: TObject);
    procedure SetFont         (const Value: TFont);
    procedure SetActive       (const Value: boolean);
    procedure SetUseSkin      (const Value: boolean);
    procedure SetUseHTML      (const Value: boolean);
    procedure SetMaxWidth     (const Value: integer);
    procedure SetIndent       (const Value: integer);
    procedure SetText         (const Value: acString);
    procedure SetLayout       (const Value: TsCaptionLayout);
    procedure SetEnabledAlways(const Value: boolean);
    procedure SetAllowClick   (const Value: boolean);
  public
    FActive: boolean;
    FTheLabel: TsEditLabel;
    FCommonData: TsCommonData;
    procedure AlignLabel;
    procedure UpdateVisibility;
    function DoStoreFont: boolean;
    constructor Create(AOwner: TObject; const CommonData: TsCommonData);
    destructor Destroy; override;
    procedure UpdateScale(NewValue: integer);
    procedure HandleOwnerMsg(const Message: TMessage; const OwnerControl: TControl);
  published
{$ENDIF} // NOTFORHELP
    property UseHTML: boolean read FUseHTML write SetUseHTML default False;

    property Active: boolean read FActive write SetActive default False;
    property AllowClick: boolean read FAllowClick write SetAllowClick default False;
    property Caption: acString read FText write SetText;
    property EnabledAlways: boolean read FEnabledAlways write SetEnabledAlways default False;
    property Indent: integer read FIndent write SetIndent default 0;
    property Font: TFont read GetFont write SetFont stored DoStoreFont;
    property Layout: TsCaptionLayout read FLayout write SetLayout default sclLeft;
    property MaxWidth: integer read FMaxWidth write SetMaxWidth default 0;
    property UseSkinColor: boolean read GetUseSkin write SetUseSkin default True;
  end;

{$IFNDEF NOTFORHELP}
var
  C1, C2: TsColor;
  RestrictDrawing: boolean = False;


function CtrlIsSkinned(const AControl: TControl): boolean;
function WndIsSkinned(const AHandle: THandle): boolean;
function GetCommonData(const AHandle: hwnd): TsCommonData;
function CurrentScale(const SkinData: TsCommonData): integer;

function IsCached(const SkinData: TsCommonData): boolean;

function HaveOuterEffects(SkinData: TsCommonData): boolean;
function InUpdating (const SkinData: TsCommonData; const Reset: boolean = False): boolean;
procedure InitBGInfo(const SkinData: TsCommonData; const PBGInfo: PacBGInfo; const State: integer; Handle: THandle = 0);
function GetBGColor (const SkinData: TsCommonData; const State: integer; const Handle: THandle = 0): TColor;
function GetFontIndex(const Ctrl: TControl; const DefSkinIndex: integer; const SkinManager: TsSkinManager; const State: integer = 0): integer; overload;
function GetFontIndex(const Ctrl: TControl; pInfo: PacPaintInfo): integer; overload;
function GetFontIndex(const CtrlHandle: THandle; pInfo: PacPaintInfo): integer; overload;
procedure ShowGlowingIfNeeded(const SkinData: TsCommonData; const Clicked: boolean = False; const CtrlHandle: HWND = 0; Alpha: byte = MaxByte; DoAnimation: boolean = False; ASkinIndex: integer = -1);
procedure UpdateBmpColors(Bmp: TBitmap; SkinData: TsCommonData; CheckCorners: boolean; State: integer);

procedure InitCacheBmp     (const SkinData: TsCommonData);
function SkinBorderMaxWidth(const SkinData: TsCommonData): integer;

procedure InitIndexes(const SkinData: TsCommonData; const Sections: array of string);
procedure InitBGType(const SkinData: TsCommonData);
procedure UpdateData (const SkinData: TsCommonData);
procedure UpdateControlColors(SkinData: TsCommonData; AllowRepaint: boolean = True);
procedure UpdateSkinState(const SkinData: TsCommonData; const UpdateChildren: boolean = True);
function ControlIsActive (const SkinData: TsCommonData): boolean;
procedure CopyWinControlCache(const Control: TWinControl; const SkinData: TsCommonData; const SrcRect, DstRect: TRect; const DstDC: HDC; const UpdateCorners: boolean;
                              const OffsetX: integer = 0; const OffsetY: integer = 0); overload;
procedure CopyHwndCache(const hwnd: THandle; const SkinData: TsCommonData; const SrcRect, DstRect: TRect; const DstDC: HDC; const UpdateCorners: boolean;
                        const OffsetX: integer = 0; const OffsetY: integer = 0); overload;

function CommonMessage(var Message: TMessage; SkinData: TsCommonData): boolean;
function CommonWndProc(var Message: TMessage; SkinData: TsCommonData): boolean;
function NeedParentFont(SkinData: TsCommonData; State: integer): boolean; overload;
function NeedParentFont(SkinManager: TsSkinManager; SkinIndex, State: integer; Ctrl: TControl = nil): boolean; overload;
function GetRgnFromSkin(ASectionIndex: integer; const CtrlSize: TSize; SM: TsSkinManager = nil): HRGN;
procedure GetTransCorners(ASectionIndex: integer; aBmp: TBitmap; SM: TsSkinManager = nil);

procedure InvalidateParentCache(SkinData: TsCommonData);
function ChildBgIsChanged(SkinData: TsCommonData): boolean;
procedure StopTimer(SkinData: TsCommonData); overload;
procedure StopTimer(var Timer: TacThreadedTimer); overload;
function TimerIsActive(SkinData: TsCommonData): boolean;
function acMouseInWnd(Handle: THandle): boolean;
procedure FinishTimer(ATimer: TacThreadedTimer);
{$ENDIF} // NOTFORHELP
function GetParentCache(const SkinData: TsCommonData): TCacheInfo;
function GetParentCacheHwnd(const cHwnd: hwnd): TCacheInfo;


implementation

uses Math, ComCtrls,
  {$IFDEF CHECKXP} UxTheme, {$ENDIF}
  {$IFNDEF ALITE} sPageControl, sSplitter, acAlphaHints,{$ENDIF}
  sVclUtils, acGlow, sStyleSimply, sSkinProps, sMessages, sMaskData, acSBUtils, sFade,
  acntTypes, sGraphUtils, sAlphaGraph, sSkinProvider, sSpeedButton, sSkinMenus;


const
  acPropStr = 'ACSDATA';


{$IFDEF RUNIDEONLY}
var
  sTerminated: boolean = False;
{$ENDIF}

type
  TAccessLabel = class(TLabel);


procedure StopTimer(SkinData: TsCommonData);
begin
  if Assigned(SkinData) and Assigned(SkinData.AnimTimer) then
    if not (csDestroying in SkinData.AnimTimer.ComponentState) and not SkinData.AnimTimer.Destroyed then begin
      SkinData.AnimTimer.Enabled := False;
      SkinData.AnimTimer.State := -1;
      FreeAndNil(SkinData.AnimTimer.BmpTo);
      FreeAndNil(SkinData.AnimTimer.BmpFrom);
      FreeAndNil(SkinData.AnimTimer.BmpOut);
    end;
end;


procedure StopTimer(var Timer: TacThreadedTimer);
begin
  if Assigned(Timer) then
    if not (csDestroying in Timer.ComponentState) and not Timer.Destroyed then begin
      Timer.Enabled := False;
      Timer.State := -1;
    end;
end;


procedure FinishTimer(ATimer: TacThreadedTimer);
begin
  if Assigned(ATimer) then
    with ATimer do
      if not (csDestroying in ComponentState) and not Destroyed then begin
        Iteration := Iterations - 1;
        Glow := iff(State <= 0, 0, MaxByte);
        Enabled := False;
        TimeHandler;
        if BmpOut <> nil then
          FreeAndNil(BmpOut);
      end;
end;


function TimerIsActive(SkinData: TsCommonData): boolean;
begin
  Result := Assigned(SkinData.AnimTimer) and SkinData.AnimTimer.Enabled;
end;


function IsCached(const SkinData: TsCommonData): boolean;
begin
  with SkinData do
    Result := (CtrlSkinState and ACS_FAST = 0) or HaveOuterEffects(SkinData) or (not (COC in sCanNotBeHot) and ControlIsActive(SkinData));
end;


function CurrentScale(const SkinData: TsCommonData): integer;
begin
  Result := SkinData.ScalePercent;
end;


function GetCommonData(const AHandle: hwnd): TsCommonData;
begin
  Result := TsCommonData(GetProp(AHandle, acPropStr));
end;


function WndIsSkinned(const AHandle: THandle): boolean;
begin
  Result := (GetCommonData(AHandle) <> nil) or (Ac_GetScrollWndFromHwnd(AHandle) <> nil) or GetBoolMsg(AHandle, AC_CTRLHANDLED);
end;


function CtrlIsSkinned(const AControl: TControl): boolean;
begin
  if (AControl is TWinControl) and TWinControl(AControl).HandleAllocated then
    with TWinControl(AControl) do
      Result := (GetCommonData(Handle) <> nil) or (Ac_GetScrollWndFromHwnd(Handle) <> nil) or GetBoolMsg(Handle, AC_CTRLHANDLED)
  else
    Result := AControl.Perform(SM_ALPHACMD, AC_CTRLHANDLED_HI, 0) = 1;
end;


function HaveOuterEffects(SkinData: TsCommonData): boolean;
begin
  with SkinData do
    if (FOwnerObject is TsSkinProvider) or (FOwnerControl is TWinControl) then
      Result := SkinManager.Effects.AllowOuterEffects
    else
      Result := False;
end;


function InUpdating(const SkinData: TsCommonData; const Reset: boolean = False): boolean;
begin
  if Reset then
    SkinData.FUpdating := False;

  if SkinData.Updating then begin
    SkinData.FUpdating := True;
    Result := True;
  end
  else
    Result := False;
end;


procedure UpdateCtrlColors(const SkinData: TsCommonData; const Redraw: boolean);
var
  C: TColor;
begin
  with SkinData do
    if FOwnerControl <> nil then
      with TacAccessControl(FOwnerControl), SkinManager do begin
        if FOwnerControl is TWinControl then begin
          if not TWinControl(FOwnerControl).HandleAllocated {$IFNDEF DELPHI6UP} or not IsWindowVisible(TWinControl(FOwnerControl).Handle) {$ENDIF} then
            Exit;
        end;

        if Skinned and (COC in sEditCtrls) and not ((gd[SkinIndex].Props[0].Transparency = 100) and (gd[SkinIndex].Props[1].Transparency = 100)) then
          if FColorTone <> clNone then begin
            if not CustomColor then begin
              C := ChangeSaturation(ChangeHUE(SkinData.HUEOffset, gd[SkinIndex].Props[0].Color), SkinData.Saturation);
              if Color <> C then
                Color := C;
            end;
            if not CustomFont and (not (COC = COC_TsListView) or ac_AllowHotEdits) then begin
              C := ChangeSaturation(ChangeHUE(SkinData.HUEOffset, gd[SkinIndex].Props[0].FontColor.Color), SkinData.Saturation);
              if Font.Color <> C then
                Font.Color := C;
            end;
          end
          else begin
            if not CustomColor then begin
              C := ChangeSaturation(ChangeHUE(SkinData.HUEOffset, gd[SkinIndex].Props[0].Color), SkinData.Saturation);
              if Color <> C then
                Color := C;
            end;
            if not CustomFont and (not (COC = COC_TsListView) or ac_AllowHotEdits) then begin
              C := ChangeSaturation(ChangeHUE(SkinData.HUEOffset, gd[SkinIndex].Props[0].FontColor.Color), SkinData.Saturation);
              if Font.Color <> C then
                Font.Color := C;
            end;
          end;

        if Redraw then
          SkinData.Invalidate(True);
      end;
end;


procedure InitBGType(const SkinData: TsCommonData);
begin
  with SkinData do begin
    BGType := 0;
    if (SkinManager <> nil) and SkinManager.IsValidSkinIndex(SkinIndex) then
      with SkinManager, gd[SkinIndex].Props[0] do begin
        if (ImagePercent > 0) and (TextureIndex >= 0) then begin
          if ma[TextureIndex].DrawMode in [1, 4, 5, 8, 9, 11, 12] then
            BGType := BGType or BGT_STRETCH;

          if ma[TextureIndex].DrawMode in [0, 1, 3, 5, 10, 12] then
            BGType := BGType or BGT_TEXTURELEFT;

          if ma[TextureIndex].DrawMode in [0, 1, 7, 9, 10, 12] then
            BGType := BGType or BGT_TEXTURERIGHT;

          if ma[TextureIndex].DrawMode in [0, 1, 2, 4, 10, 11] then
            BGType := BGType or BGT_TEXTURETOP;

          if ma[TextureIndex].DrawMode in [0, 1, 6, 8, 10, 11] then
            BGType := BGType or BGT_TEXTUREBOTTOM;
        end;
        if (GradientPercent > 0) and (Length(GradientArray) > 0) then
          case GradientArray[0].Mode1 of
            0: BGType := BGType or BGT_GRADIENTVERT;
            1: BGType := BGType or BGT_GRADIENTHORZ;
            2: BGType := BGType or BGT_GRADIENTHORZ or BGT_GRADIENTVERT;
          end;
      end
  end;
end;


function IsCacheRequired(const SkinData: TsCommonData): integer; // Used for non-active controls only, active controls have cache always
begin
  Result := 0;
  with SkinData do
    if (SkinManager <> nil) and SkinManager.IsValidSkinIndex(SkinIndex) then
      with SkinManager, gd[SkinIndex] do begin
        if ((FOwnerControl is TWinControl) or (FOwnerObject is TsSkinProvider)) and Effects.AllowOuterEffects then
          Exit;

        if BorderIndex >= 0 then // If border exists
          if (ma[BorderIndex].DrawMode and BDM_FILL = BDM_FILL) or (ma[BorderIndex].MaskType = 1) then
            Exit; // If center image is drawn by border mask

        if Props[0].Transparency = 100 then begin // Get cachestate of the parent
          if Props[0].TextureIndex >= 0 then
            if acFillModes[ma[Props[0].TextureIndex].DrawMode] = fmDisTiled then
              Exit; // If special texture used

          if Assigned(FOwnerControl) and Assigned(FOwnerControl.Parent) { and SkinData.Skinned} then
            if not FOwnerControl.Parent.HandleAllocated then // If parent is not ready
              Result := ACS_BGUNDEF
            else
              if not WndIsSkinned(FOwnerControl.Parent.Handle) then // If parent is not skinned
                Result := ACS_FAST
              else
                Result := SendAMessage(FOwnerControl.Parent, AC_GETSKINSTATE);
        end
        else
          if Props[0].Transparency = 0 {If control is semi-transparent} then
            if (Props[0].ImagePercent = 0) and (Props[0].GradientPercent = 0) then begin
              if (FOwnerObject is TsSkinProvider) and Assigned(TsSkinProvider(FOwnerObject).Form.OnPaint) then
                Exit;

              if (ImgTL < 0) and (ImgTR < 0) and (ImgBL < 0) and (ImgBR < 0) then
                Result := ACS_FAST;
            end;
      end
    else
      Result := ACS_FAST;
end;


procedure InitBGInfo(const SkinData: TsCommonData; const PBGInfo: PacBGInfo; const State: integer; Handle: THandle = 0);
var
  WndPos: TPoint;
  WndRect: TRect;
  Parent: TWinControl;
  aState, iTransparency, iGradient, iTexture: integer;
begin
  with SkinData do
    if PBGInfo^.PleaseDraw then begin
      UpdateSkinState(SkinData, False);
      if IsCached(SkinData) then begin
        if BGChanged and (FOwnerControl <> nil) then
          FOwnerControl.Perform(SM_ALPHACMD, AC_PREPARECACHE_HI, 0);

        if not BGChanged then
          with PBGInfo^ do
            BitBlt(DrawDC, R.Left, R.Top, WidthOf(R), HeightOf(R), FCacheBmp.Canvas.Handle, Offset.X, Offset.Y, SRCCOPY);

        PBGInfo^.BgType := btCache;
      end
      else begin
        FillDC(PBGInfo^.DrawDC, PBGInfo^.R, GetBGColor(SkinData, State));
        PBGInfo^.BgType := btFill;
      end;
    end
    else
      with SkinData.SkinManager do begin
        Parent := nil;
        PBGInfo^.Bmp := nil;
        if SkinData.Skinned and (not SkinData.CustomColor {or (SkinData.CtrlSkinState and ACS_FAST <> ACS_FAST)}) then begin
          if State >= gd[SkinData.SkinIndex].States then
            aState := gd[SkinData.SkinIndex].States - 1
          else
            aState := State;

          if aState > ac_MaxPropsIndex then
            aState := ac_MaxPropsIndex;

          iTransparency := gd[SkinIndex].Props[aState].Transparency;
          iTexture      := gd[SkinIndex].Props[aState].ImagePercent;
          iGradient     := gd[SkinIndex].Props[aState].GradientPercent;
          case iTransparency of
            0: with gd[SkinIndex] do begin
              if (iGradient > 0) or (iTexture > 0) or (ImgTL >= 0) or (ImgBL >= 0) or (ImgBR >= 0) or (ImgTR >= 0) or HaveOuterEffects(SkinData) then begin
                PBGInfo^.Color := GetGlobalColor;
                if (FCacheBmp = nil) or FCacheBmp.Empty or (FOwnerControl <> nil) and ((FCacheBmp.Width <> FOwnerControl.Width) or (FCacheBmp.Height <> FOwnerControl.Height)) then begin
                  BGChanged := True;
                  if FCacheBmp <> nil then
                    FCacheBmp.Width := 0;

                  if FOwnerControl <> nil then
                    SendAMessage(FOwnerControl, AC_PREPARECACHE);

                  if (FCacheBmp = nil) or FCacheBmp.Empty then begin
                    PBGInfo^.BgType := btNotReady;
                    Exit;
                  end
                  else begin
                    PBGInfo^.BgType := btCache;
                    if PBGInfo^.PleaseDraw then
                      with PBGInfo^ do
                        BitBlt(DrawDC, R.Left, R.Top, WidthOf(R), HeightOf(R), FCacheBmp.Canvas.Handle, Offset.X, Offset.Y, SRCCOPY)
                    else begin
                      PBGInfo^.Bmp := FCacheBmp;
                      PBGInfo^.Offset := MkPoint;
                    end;
                  end;
                end;
                PBGInfo^.BgType := btCache;
                if PBGInfo^.PleaseDraw then
                  with PBGInfo^ do
                    BitBlt(DrawDC, R.Left, R.Top, WidthOf(R), HeightOf(R), FCacheBmp.Canvas.Handle, Offset.X, Offset.Y, SRCCOPY)
                else begin
                  PBGInfo^.Bmp := FCacheBmp;
                  PBGInfo^.Offset := MkPoint;
                end;
              end
              else begin
                PBGInfo^.Bmp := nil;
                PBGInfo^.BgType := btFill;
                PBGInfo^.Color := GetBGColor(SkinData, State);
                if IsValidImgIndex(BorderIndex) and (ma[BorderIndex].DrawMode and BDM_ACTIVEONLY = 0) then begin
                  with ma[BorderIndex] do
                    PBGInfo^.FillRect := Rect(WL, WT, WR, WB);

                  PBGInfo^.Bmp := FCacheBmp;
                  PBGInfo^.Offset := MkPoint;
                end;
                if PBGInfo^.PleaseDraw then
                  FillDC(PBGInfo^.DrawDC, PBGInfo^.R, PBGInfo^.Color);
              end
            end;

            100: begin
              if (CtrlSkinState and ACS_FAST = 0) and (FCacheBmp <> nil) then begin
                if BGChanged and (FOwnerControl <> nil) then
                  FOwnerControl.Perform(SM_ALPHACMD, AC_PREPARECACHE_HI, 0);

                if not BGChanged then begin // BG is ready
                  PBGInfo^.BgType := btCache;
                  if PBGInfo^.PleaseDraw then
                    with PBGInfo^ do
                      BitBlt(DrawDC, R.Left, R.Top, WidthOf(R), HeightOf(R), FCacheBmp.Canvas.Handle, Offset.X, Offset.Y, SRCCOPY)
                  else begin
                    PBGInfo^.Bmp := FCacheBmp;
                    PBGInfo^.Offset := MkPoint;
                  end;
                end
                else begin
                  PBGInfo^.Bmp := nil;
                  PBGInfo^.BgType := btFill;
                  PBGInfo^.Offset := MkPoint;
                  PBGInfo^.Color := GetBGColor(SkinData, 0);
                end;
                Exit;
              end;
              // Parent BG is returned if no borders and parent is ready
              if FOwnerControl <> nil then begin
                Parent := FOwnerControl.Parent;
                WndPos := MkPoint(FOwnerControl);
              end
              else
                if FOwnerObject is TsSkinProvider then
                  with TsSkinProvider(FOwnerObject) do begin
                    if Form <> nil then begin
                      Parent := Form.Parent;
                      WndPos := MkPoint(Form);
                    end;
                  end
                else
                  Parent := nil;

              if Parent <> nil then begin
                GetBGInfo(PBGInfo, Parent, PBGInfo^.PleaseDraw);
                if PBGInfo^.Bmp <> nil then begin // BgType = btCache or Bmp is assigned
                  inc(PBGInfo^.Offset.X, WndPos.X);
                  inc(PBGInfo^.Offset.Y, WndPos.Y);
                  dec(PBGInfo^.FillRect.Left, WndPos.X);
                  dec(PBGInfo^.FillRect.Top, WndPos.Y);
                end;
              end
              else
                if Handle <> 0 then begin
                  GetBGInfo(PBGInfo, GetParent(Handle));
                  if PBGInfo^.BgType = btCache then begin
                    GetWindowRect(Handle, WndRect);
                    WndPos := WndRect.TopLeft;
                    ScreenToClient(GetParent(Handle), WndPos);
                    inc(PBGInfo^.Offset.X, WndPos.X);
                    inc(PBGInfo^.Offset.Y, WndPos.Y);
                  end;
                end
                else begin
                  PBGInfo^.BgType := btFill;
                  PBGInfo^.Color := DefaultManager.GetGlobalColor
                end;
            end

            else
              if FCacheBmp = nil then begin
                PBGInfo^.Color := clFuchsia; // Debug
                PBGInfo^.BgType := btFill;
              end
              else
                if FCacheBmp.Empty then begin
                  if BGChanged and (FOwnerControl <> nil) then
                    FOwnerControl.Perform(SM_ALPHACMD, AC_PREPARECACHE_HI, 0);

                  if FCacheBmp.Empty then begin
                    SkinData.Updating := True;
                    PBGInfo^.BgType := btNotReady;
                  end
                  else
                    InitBGInfo(SkinData, PBGInfo, State, Handle);
                end
                else begin
                  PBGInfo^.BgType := btCache;
                  if PBGInfo^.PleaseDraw then
                    BitBlt(PBGInfo^.DrawDC, PBGInfo^.R.Left, PBGInfo^.R.Top, WidthOf(PBGInfo^.R), HeightOf(PBGInfo^.R), FCacheBmp.Canvas.Handle, PBGInfo^.Offset.X, PBGInfo^.Offset.Y, SRCCOPY)
                  else begin
                    PBGInfo^.Bmp := FCacheBmp;
                    PBGInfo^.Offset := MkPoint;
                  end;
                end;
          end;
        end
        else begin
          PBGInfo^.BgType := btFill;
          if FOwnerControl <> nil then
            PBGInfo^.Color := ColorToRGB(TacAccessControl(SkinData.FOwnerControl).Color)
          else
            if FOwnerObject is TsSkinProvider then
              PBGInfo^.Color := ColorToRGB(TsSkinProvider(FOwnerObject).Form.Color);

        end;
      end;
end;


function GetBGColor(const SkinData: TsCommonData; const State: integer; const Handle: THandle = 0): TColor;
var
  i, C: integer;
  Hot: boolean;

  function StdColor: TColor;
  begin
    if SkinData.FOwnerControl <> nil then
      Result := TacAccessControl(SkinData.FOwnerControl).Color
    else
      if SkinData.FOwnerObject is TsSkinProvider then
        Result := TsSkinProvider(SkinData.FOwnerObject).Form.Color
      else
        Result := clBtnFace;
  end;

begin
  with SkinData do
    if Skinned then
      with SkinManager do begin
        Hot := (State > 0) and (gd[SkinIndex].States > 1);
        i := gd[SkinIndex].Props[integer(Hot)].Transparency;
        c := gd[SkinIndex].Props[integer(Hot)].Color;
        case i of
          0:
            if Skinned and not CustomColor then
              Result := C
            else
              Result := StdColor;

          100:
            if FOwnerControl <> nil then
              Result := GetControlColor(FOwnerControl.Parent)
            else
              if Handle <> 0 then
                Result := GetControlColor(GetParent(Handle))
              else
                Result := c;//clBtnFace

          else
            if FOwnerControl <> nil then
              Result := BlendColors(c, GetControlColor(FOwnerControl.Parent), i * MaxByte div 100)
            else
              if Handle <> 0 then
                Result := BlendColors(c, GetControlColor(GetParent(Handle)), i * MaxByte div 100)
              else
                Result := clBtnFace;
        end
      end
    else
      Result := StdColor;
end;


function GetFontIndex(const Ctrl: TControl; const DefSkinIndex: integer; const SkinManager: TsSkinManager; const State: integer = 0): integer;
var
  pi: TacPaintInfo;
  i: integer;
begin
  Result := DefSkinIndex;
  if (State = 0) or (DefSkinIndex < 0) or (SkinManager.gd[DefSkinIndex].States <= State) or (SkinManager.gd[DefSkinIndex].Props[State].Transparency >= 40) then
    if Ctrl <> nil {and (Ctrl.Parent <> nil) and (State = 0) }then begin
      pi.SkinManager := SkinManager;
      pi.R := Ctrl.BoundsRect;
      pi.State := State;
      i := Ctrl.Perform(SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(@pi));
      if (i <> 0) and (pi.FontIndex >= 0) then
        Result := pi.FontIndex;
    end;
end;


function GetFontIndex(const Ctrl: TControl; pInfo: PacPaintInfo): integer;
begin
  if Ctrl.Parent <> nil then
    OffsetRect(pInfo.R, Ctrl.Left, Ctrl.Top);

  Result := Ctrl.Perform(SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(pInfo))
end;


function GetFontIndex(const CtrlHandle: THandle; pInfo: PacPaintInfo): integer; overload;
begin
  Result := SendMessage(CtrlHandle, SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(pInfo))
end;


function ParentTextured(const SkinData: TsCommonData): boolean;
begin
  with SkinData.FOwnerControl do
    if Assigned(SkinData.FOwnerControl) and Assigned(Parent) and Parent.HandleAllocated then
      Result := GetBoolMsg(Parent, AC_CHILDCHANGED)
    else
      Result := False;
end;


procedure ShowGlowingIfNeeded(const SkinData: TsCommonData; const Clicked: boolean = False; const CtrlHandle: HWND = 0; Alpha: byte = MaxByte; DoAnimation: boolean = False; ASkinIndex: integer = -1);
var
  DC: hdc;
  p: TPoint;
  WndHandle: HWND;
  GlowCount: integer;
  ParentForm: TCustomForm;
  R, rBox, rWnd, RealBox: TRect;
begin
  if ASkinIndex < 0 then
    ASkinIndex := SkinData.SkinIndex;

  with SkinData do
    if SkinManager.Effects.AllowGlowing and SkinManager.IsValidSkinIndex(ASkinIndex) and not SkinManager.Options.NoMouseHover then begin
      GlowCount := SkinManager.gd[ASkinIndex].GlowCount;
      if GlowCount > 0 then
        if FOwnerControl <> nil then begin
          if FMouseAbove then begin
            if not (csLButtonDown in FOwnerControl.ControlState) and (not Clicked or (GlowID < 0)) then begin
              ParentForm := GetParentForm(FOwnerControl);
              if ParentForm <> nil then begin
                if ParentForm.Parent <> nil then
                  WndHandle := ParentForm.Parent.Handle
                else
                  if (TForm(ParentForm).FormStyle = fsMDIChild) and (MDISkinProvider <> nil) then
                    WndHandle := TsSkinProvider(MDISkinProvider).Form.Handle
                  else
                    WndHandle := ParentForm.Handle;

                if not SkinData.SkinManager.Effects.AllowAnimation then
                  DoAnimation := False
                else
                  if DoAnimation then
                    Alpha := 0;

                if SkinData.GlowID < 0 then // Show a glowing effect
                  if FOwnerControl is TWinControl then begin
                    if GetWindowRect(TWinControl(FOwnerControl).Handle, rWnd) then begin
                      DC := GetWindowDC(TWinControl(FOwnerControl).Handle);
                      if GetClipBox(DC, RealBox) <> 0 then begin
                        OffsetRect(RealBox, rWnd.Left, rWnd.Top);
                        ReleaseDC(TWinControl(FOwnerControl).Handle, DC);
                        GlowID := ShowGlow(RectsAnd(rWnd, RealBox), SkinData.SkinManager.gd[ASkinIndex].ClassName, s_Glow, SkinManager.gd[ASkinIndex].GlowMargin, Alpha, WndHandle, SkinData);
                      end;
                    end;
                  end
                  else begin
                    R.TopLeft := FOwnerControl.ClientToScreen(MkPoint);
                    R.BottomRight := Point(R.Left + FOwnerControl.Width, R.Top + FOwnerControl.Height);
                    GetWindowRect(FOwnerControl.Parent.Handle, rWnd);

                    DC := GetDC(FOwnerControl.Parent.Handle);
                    GetClipBox(DC, RealBox);
                    ReleaseDC(FOwnerControl.Parent.Handle, DC);

                    p := FOwnerControl.Parent.ClientToScreen(MkPoint);
                    OffsetRect(RealBox, p.X, p.Y);

                    rBox := RectsAnd(R, RealBox);
                    GlowID := ShowGlow(RectsAnd(R, RealBox), SkinSection, s_Glow, SkinManager.gd[ASkinIndex].GlowMargin, Alpha, WndHandle, SkinData);
                  end;

                if DoAnimation and (SkinData.GlowID >= 0) then begin
                  SkinData.BGChanged := False;
                  DoChangePaint(SkinData, 1, UpdateGlowing_CB, True, False, False);
                  if SkinData.AnimTimer <> nil then
                    SkinData.AnimTimer.ThreadType := TT_GLOWING;
                end;
              end;
            end;
          end
          else
            HideGlow(GlowID, DoAnimation);
        end
        else
          if CtrlHandle <> 0 then
            if FMouseAbove and (not Clicked or (GlowID = -1)) then begin
              GetWindowRect(CtrlHandle, R);
              DC := GetWindowDC(CtrlHandle);
              GetWindowRect(DC, R);
              GetClipBox(DC, RBox);
              OffsetRect(RBox, R.Left, R.Top);
              ReleaseDC(CtrlHandle, DC);
              GlowID := ShowGlow(RBox, SkinSection, s_Glow, SkinManager.gd[ASkinIndex].GlowMargin, Alpha, GetParentFormHandle(CtrlHandle), SkinData);
            end
            else
              HideGlow(GlowID);
    end;
end;


procedure UpdateBmpColors(Bmp: TBitmap; SkinData: TsCommonData; CheckCorners: boolean; State: integer);
begin
  if SkinData.ColorTone <> clNone then
    ChangeBitmapPixels(Bmp, ChangeColorTone, SkinData.ColorTone, clFuchsia);

  if SkinData.HUEOffset <> 0 then
    ChangeBitmapPixels(Bmp, ChangeColorHUE, SkinData.HUEOffset, clFuchsia);

  if SkinData.Saturation <> 0 then
    ChangeBitmapPixels(Bmp, ChangeColorSaturation, LimitIt(SkinData.Saturation * 255 div 100, -MaxByte, MaxByte), clFuchsia);

  UpdateCorners(SkinData, State);
end;


procedure InitCacheBmp(const SkinData: TsCommonData);
begin
  with SkinData do begin
    if not Assigned(FCacheBmp) then begin
      FCacheBmp := CreateBmp32;
      FCacheBmp.Canvas.OnChange := nil;
      FCacheBmp.Canvas.OnChanging := nil;
    end;
    if FCacheBmp.HandleType <> bmDIB then
      FCacheBmp.HandleType := bmDIB;

    if Assigned(FOwnerControl) then begin
      if FCacheBmp.Width <> FOwnerControl.Width then
        FCacheBmp.Width := max(FOwnerControl.Width, 0);

      if FCacheBmp.Height <> FOwnerControl.Height then
        FCacheBmp.Height := max(FOwnerControl.Height, 0);
    end
  end;
end;


function SkinBorderMaxWidth(const SkinData: TsCommonData): integer;
begin
  Result := 0;
  with SkinData do
    if (BorderIndex >= 0) and (SkinManager.ma[BorderIndex].DrawMode and BDM_ACTIVEONLY = 0) then
      with SkinManager.ma[BorderIndex] do begin
        Result := max(WL, WT);
        if WR > Result then
          Result := WR;

        if WB > Result then
          Result := WB;
      end
end;


function GetParentCache(const SkinData: TsCommonData): TCacheInfo;
var
  BGInfo: TacBGInfo;
begin
  if SkinData.Skinned and Assigned(SkinData.FOwnerControl) then begin
    BGInfo.DrawDC := 0;
    BGInfo.PleaseDraw := False;
    BGInfo.BgType := btUnknown;
    if Assigned(SkinData.FOwnerControl.Parent) then
      GetBGInfo(@BGInfo, SkinData.FOwnerControl.Parent)
    else
      if SkinData.FOwnerControl is TWinControl then
        GetBGInfo(@BGInfo, GetParent(TWinControl(SkinData.FOwnerControl).Handle))
      else begin
        Result.X := 0;
        Result.Y := 0;
        Result.FillColor := GetBGColor(SkinData, 0);
        Result.Ready := False;
        Exit;
      end;

    if BGInfo.BgType = btNotReady then begin
      Result.FillColor := clFuchsia;
      Result.Ready := False;
    end
    else
      Result := BGInfoToCI(@BGInfo);
  end
  else begin
    Result.X := 0;
    Result.Y := 0;
    Result.FillColor := GetBGColor(SkinData, 0);
    Result.Ready := False;
  end;
end;


function GetParentCacheHwnd(const cHwnd: hwnd): TCacheInfo;
var
  pHwnd: hwnd;
  BGInfo: TacBGInfo;
begin
  Result.Ready := False;
  pHwnd := GetParent(cHwnd);
  if pHwnd <> 0 then begin
    BGInfo.PleaseDraw := False;
    GetBGInfo(@BGInfo, pHwnd);
    Result := BGInfoToCI(@BGInfo);
  end
  else
    Result := EmptyCI;
end;


procedure InvalidateParentCache(SkinData: TsCommonData);
begin
  if not InUpdating(SkinData) then
    with SkinData do
      if (FOwnerControl <> niL) and (FOwnerControl.Parent <> nil) and FOwnerControl.Parent.HandleAllocated then begin
//        FOwnerControl.Parent.Perform(SM_ALPHACMD, AC_SETBGCHANGED_HI + 1, 0);
//        FOwnerControl.Parent.Perform(SM_ALPHACMD, AC_PREPARECACHE_HI + 1, 0);
        TrySendMessage(FOwnerControl.Parent.Handle, SM_ALPHACMD, AC_SETBGCHANGED shl 16, 0);
        SendAMessage(FOwnerControl.Parent.Handle, AC_PREPARECACHE);
      end;
end;


procedure InitIndexes(const SkinData: TsCommonData; const Sections: array of string);
var
  i: integer;
begin
  with SkinData do
    if SkinManager <> nil then
      for i := 0 to Length(Sections) - 1 do begin
        if Sections[i] <> '' then begin
          SkinIndex := SkinManager.GetSkinIndex(Sections[i]);
          if SkinIndex >= 0 then begin
            UpdateIndexes(False);
            Exit;
          end;
        end
      end
    else
      SkinIndex := -1;
end;


procedure UpdateScale(const SkinData: TsCommonData);
var
  iScale: integer;
begin
  with SkinData do
    if (SkinManager <> nil) and (FOwnerControl is TWinControl) and not (csLoading in FOwnerControl.ComponentState) then begin
      iScale := SkinManager.GetScale;
      if ScalePercent <> aScalePercents[iScale] then begin
//        SkinData.SkinManager.UpdateScale(TWinControl(FOwnerControl));
        TWinControl(FOwnerControl).ScaleBy(aScalePercents[iScale], ScalePercent);
        ScalePercent := aScalePercents[iScale];
      end;
    end;
end;


procedure UpdateData(const SkinData: TsCommonData);
begin
  with SkinData do begin
{
    if (FOwnerControl <> nil) and (csDesigning in FOwnerControl.ComponentState) then
      if FSkinSection = 'RADIOBUTTON' then // Remove in v11
        FSkinSection := s_Transparent;
}
    if SkinSection = '' then
      case COC of
        // Defining of the SkinIndex only
        COC_TsTrackBar, COC_TsSplitter, COC_TsSpeedButton, COC_TsPanel, COC_TsTabControl,
        COC_TsComboBox, COC_TsColorBox, COC_TsPageControl, COC_TsTabSheet, COC_TsGroupBox,
        COC_TsCheckBox, COC_TsRadioButton, COC_TsButton, COC_TsBitBtn, COC_TsToolBar, COC_TsCoolBar,
        COC_TsTreeView, COC_TsCurrencyEdit, COC_TsSpinEdit..COC_TsListBox, COC_TsScrollBox,
        COC_TsDBEdit, COC_TsDBComboBox, COC_TsDBMemo, COC_TsDBListBox, COC_TsDBGrid,
        COC_TsStatusBar, COC_TsGauge, COC_TsMonthCalendar, COC_TsListView, COC_TsSlider, COC_TsFrameAdapter,
        COC_TsDBLookupListBox, COC_TsDBLookupComboBox, COC_TsFileDirEdit..COC_TsDateEdit:
          UpdateIndexes;

        // Defining of the default SkinSection property
        COC_TsAdapter:
          SkinSection := s_Edit;

        COC_TsComboBoxEx:
          SkinSection := s_ComboBox;

        COC_TsNavButton:
          SkinSection := s_ToolButton;

        COC_TsDragBar:
          SkinSection := s_DragBar;

        COC_TsHeaderControl, COC_TsImage:
          SkinSection := s_CheckBox;

        COC_TsFrameBar:
          SkinSection := s_Bar;

        COC_TsBarTitle:
          SkinSection := s_BarTitle

        else
          if FOwnerObject <> nil then
            SkinSection := FOwnerObject.ClassName;
      end
    else
      UpdateIndexes;
  end;
end;


procedure UpdateControlColors(SkinData: TsCommonData; AllowRepaint: boolean = True);
var
  State: integer;
begin
  with SkinData do
    if FOwnerControl <> nil then
      with TacAccessControl(FOwnerControl) do begin
        if not AllowRepaint and Visible then
          Perform(WM_SETREDRAW, 0, 0);

        if SkinIndex >= 0 then
          with SkinManager.gd[SkinIndex] do begin
            State := integer(ControlIsActive(SkinData));
            if not CustomColor then
              Color := Props[State].Color;

            if not CustomFont and (Font.Color <> Props[State].FontColor.Color) then begin
              SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_CHANGING;
              Font.Color := Props[State].FontColor.Color;
              SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_CHANGING;
            end;
          end;

        if not AllowRepaint and Visible then
          Perform(WM_SETREDRAW, 1, 0);
      end;
end;


procedure UpdateSkinState(const SkinData: TsCommonData; const UpdateChildren: boolean = True);
var
  i: integer;
begin
  with SkinData do begin
    CtrlSkinState := CtrlSkinState and not ACS_FAST;
    if FOwnerControl <> nil then begin
      if ((FOwnerControl is TFrame) or (FOwnerControl is TPanel) or (FOwnerControl is TScrollingWinControl) or (FOwnerControl is TPageControl)) and
            not TPanel(FOwnerControl).DockSite then begin
        i := IsCacheRequired(SkinData);
        if i <> ACS_BGUNDEF then begin
          if i and ACS_FAST <> 0 then
            CtrlSkinState := CtrlSkinState or ACS_FAST
          else
            CtrlSkinState := CtrlSkinState and not ACS_FAST;

          CtrlSkinState := CtrlSkinState and not ACS_BGUNDEF;
        end
        else
          Exit;
      end;
      if UpdateChildren and (FOwnerControl is TWinControl) then
        with TWinControl(FOwnerControl) do
          for i := 0 to ControlCount - 1 do
            SendAMessage(Controls[i], AC_GETSKINSTATE, 1);
    end
    else
      if SkinData.FOwnerObject is TsSkinProvider then begin
        i := IsCacheRequired(SkinData);
        if i <> ACS_BGUNDEF then
          if i and ACS_FAST <> 0 then begin
            if TsSkinProvider(FOwnerObject).Form.FormStyle <> fsMDIForm then
              CtrlSkinState := CtrlSkinState or ACS_FAST;

            CtrlSkinState := CtrlSkinState and not ACS_BGUNDEF;
          end
          else
            CtrlSkinState := 0;
      end;
  end;
end;


function ControlIsActive(const SkinData: TsCommonData): boolean;
begin
  Result := False;
  if SkinData <> nil then
    with SkinData do
      if Assigned(FOwnerControl) and ([csDestroying, csDesigning] * FOwnerControl.ComponentState = []) then
        if FOwnerControl.Enabled then
          if FFocused then
            Result := True
          else
            if (FOwnerControl is TWinControl) and TWinControl(FOwnerControl).HandleAllocated and (TWinControl(FOwnerControl).Handle = GetFocus) then
              Result := not (FOwnerControl is TCustomPanel)
            else
              if FMouseAbove and not (Assigned(SkinManager) and SkinManager.Options.NoMouseHover) then
                Result := not (COC in sForbidMouse) and (not (SkinData.COC in sNoHotEdits) or ac_AllowHotEdits);
end;


procedure TsCommonData.BeginUpdate;
begin
  Inc(FUpdateCount);
  Updating := True;
  CtrlSkinState := CtrlSkinState or ACS_LOCKED;
  if FOwnerControl <> nil then
    FOwnerControl.Perform(SM_ALPHACMD, AC_BEGINUPDATE_HI, 0)
  else
    if FOwnerObject is TsSkinProvider then
      TsSkinProvider(FOwnerObject).ProcessMessage(SM_ALPHACMD, AC_BEGINUPDATE_HI);
//      TrySendMessage(TsSkinProvider(FOwnerObject).Form.Handle, SM_ALPHACMD, AC_BEGINUPDATE_HI, 0);
end;


constructor TsCommonData.Create(AOwner: TObject; const CreateCacheBmp: boolean);
begin
  SkinIndex := -1;
  BorderIndex := -1;
  GlowID := -1;
  Texture := -1;
  HotTexture := -1;
  AnimTimer := nil;
  ScalePercent := 100;
  FSWHandle := 0;
  WndProc := nil;
  if AOwner is TControl then begin
    FOwnerControl := TControl(AOwner);
    if AOwner is TWinControl then
      WndProc := TWinControl(AOwner).WindowProc;
  end
  else
    FOwnerControl := nil;

  FOwnerObject := AOwner;
  Loading := True;
  FFocused := False;
  FMouseAbove := False;
  Updating := False;
  BGChanged := True;
  HalfVisible := True;
  FSkinManager := nil;
  FCacheBmp := nil;
  FOuterCache := nil;
  FUpdateCount := 0;
  CtrlSkinState := ACS_BGUNDEF; // Is not initialized
  BGType := 0;
  PrintDC := 0;
  SavedColor := clNone;
  SavedFontColor := clNone;
  InvalidRectH.Right := 0;
  InvalidRectV.Bottom := 0;

  FSaturation := 0;
  FHUEOffset := 0;
  FColorTone := clNone;

  Texture := -1;
  HotTexture := -1;

  FOuterEffects := TacOuterEffects.Create(Self);
  if CreateCacheBmp then begin
    FCacheBmp := CreateBmp32;
    FCacheBmp.Canvas.OnChange := nil;
  end;
{$IFDEF RUNIDEONLY}
  if not IsIDERunning and not ((FOwnerObject is TComponent) and (csDesigning in TComponent(FOwnerObject).ComponentState)) and not sTerminated then begin
    sTerminated := True;
    ShowWarning(sIsRUNIDEONLYMessage);
  end;
{$ENDIF}
  InitCommonProp;
end;


destructor TsCommonData.Destroy;
begin
  RemoveCommonProp;
  SkinIndex := -1;
  Texture := -1;
  HotTexture := -1;
  FSkinManager := nil;
  ClearLinks;
  if (AnimTimer <> nil) and not AnimTimer.Destroyed then
    FreeAndNil(AnimTimer);

  FreeAndNil(FCacheBmp);
  HideGlow(GlowID);
  FreeAndNil(FOuterEffects);
  if FOuterCache <> nil then
    FreeAndNil(FOuterCache);

  inherited Destroy;
end;


procedure TsCommonData.EndUpdate(const Repaint: boolean = False);
begin
  Dec(FUpdateCount);
  Updating := False;
  CtrlSkinState := CtrlSkinState and not ACS_LOCKED;
  if FUpdateCount <= 0 then begin
    if FOwnerControl <> nil then
      FOwnerControl.Perform(SM_ALPHACMD, AC_ENDUPDATE_HI, 0)
    else
      if FOwnerObject is TsSkinProvider then
        TsSkinProvider(FOwnerObject).ProcessMessage(SM_ALPHACMD, AC_ENDUPDATE_HI);
//        SendMessage(TsSkinProvider(FOwnerObject).Form.Handle, SM_ALPHACMD, AC_ENDUPDATE_HI, 0);

    if Repaint then
      Invalidate(True);
  end;
end;


function TsCommonData.GetSkinManager: TsSkinManager;
begin
  if FSkinManager <> nil then
    Result := FSkinManager
  else
    Result := DefaultManager;
end;


function TsCommonData.GetUpdating: boolean;
var
  sm: TsSkinManager;
begin
  if Self = nil then
    Result := False
  else begin
    sm := SkinManager;
    if sm = nil then
      Result := False
    else begin
      if csDesigning in sm.ComponentState then begin
        Result := False;
        Exit
      end
      else
        Result := FUpdating;

      if not Result then
        if FOwnerControl <> nil then begin
          if not (csDestroying in FOwnerControl.ComponentState) then
            if FUpdating then
              Result := True
            else
              if FOwnerControl.Parent <> nil then
                Result := GetBoolMsg(FOwnerControl.Parent, AC_PREPARING)
              else
                Result := False
        end
        else
          if (FOwnerObject is TsSkinProvider) and (TsSkinProvider(FOwnerObject).Form.Parent <> nil) then
            Result := GetBoolMsg(TsSkinProvider(FOwnerObject).Form.Parent, AC_PREPARING)
          else
            Result := False
    end;
  end;
end;


procedure TsCommonData.Invalidate(const UpdateNow: boolean = False);
begin
  if not Loading then
    if Assigned(FOwnerControl) then begin
      if [csDestroying, csLoading] * FOwnerControl.ComponentState = [] then begin
        BGChanged := True;
        if ControlIsReady(FOwnerControl) then
          if not (FOwnerControl is TWinControl) then
            if COC = COC_TsSpeedButton then
              FOwnerControl.Perform(SM_ALPHACMD, AC_INVALIDATE shl 16, 0)
            else
              FOwnerControl.Repaint
          else
            if TWinControl(FOwnerControl).HandleAllocated then
              RedrawWindow(TWinControl(FOwnerControl).Handle, nil, 0, iff(UpdateNow, RDWA_ALLNOW, RDWA_ALL));
      end;
    end
    else
      if FOwnerObject is TsSkinProvider then begin
        BGChanged := True;
        if TsSkinProvider(FOwnerObject).Form.HandleAllocated then
          RedrawWindow(TsSkinProvider(FOwnerObject).Form.Handle, nil, 0, iff(UpdateNow, RDWA_ALLNOW, RDWA_ALL));
      end;
end;


procedure TsCommonData.Loaded(UpdateColors: boolean = True);
begin
  Loading := False;
  UpdateData(Self);
//  UpdateScale(Self);
  if Skinned and Assigned(FOwnerControl) and Assigned(FOwnerControl.Parent) and not (csLoading in FOwnerControl.ComponentState) then begin
    if FOwnerControl is TWinControl then
      AddToAdapter(TWinControl(FOwnerControl));

    if UpdateColors then
        UpdateCtrlColors(Self, False);
  end;
end;


function TsCommonData.ManagerStored: boolean;
begin
  Result := FSkinManager <> nil;
end;


function TsCommonData.OwnerHandle: THandle;
begin
  try
    if (FOwnerControl <> nil) and not (csDestroying in FOwnerControl.ComponentState) then
      if (FOwnerControl is TWinControl) and TWinControl(FOwnerControl).HandleAllocated then
        Result := TWinControl(FOwnerControl).Handle
      else
        Result := 0
    else
      Result := FSWHandle
  except
    Result := 0;
  end;
end;


const
  iBevelSize = 10;
  USECACHE = $100;
  STATEMASK = 3; // 0 - Normal, 1 - Focused, 2 - Pressed


procedure TsCommonData.PaintOuter(PBGInfo: PacBGInfo; Data: Word);
var
  TmpBmp: TBitmap;
  BGInfo: TacBGInfo;
  op, mNdx, Ndx: integer;
  oRect, WndRect, CacheRect: TRect;

  procedure PaintEffect(Bmp: TBitmap; R, OffsRect: TRect; Ndx, Opacity: integer);
  begin
    DrawSkinRect32Ex(Bmp, R, EmptyCI, SkinManager.ma[Ndx], 0, oRect, Opacity);
  end;

begin
  with SkinManager do
    if Skinned and (OuterEffects.Visibility <> ovNone) and IsValidSkinIndex(SkinIndex) and (SkinManager.gd[SkinIndex].OuterMode > 0) then begin
      mNdx := SkinManager.gd[SkinIndex].OuterMask;
      if mNdx < 0 then begin
        if gd[SkinIndex].OuterMode <= 0 then
          Exit;

        Ndx := gd[SkinIndex].OuterMode - 1;
        if oe[Ndx].Source = 0 then
          Exit;

        with oe[Ndx] do begin
          mNdx := Mask;
          oRect := Rect(OffsetL, OffsetT, OffsetR, OffsetB);
          op := Opacity;
        end;
        if mNdx < 0 then
          Exit;
      end
      else begin
        oRect := gd[SkinIndex].OuterOffset;
        op := gd[SkinIndex].OuterOpacity;
      end;
      BGInfo := PBGInfo^;
      if (BGInfo.Bmp <> nil) and (FOwnerControl <> nil) then begin
        if FOwnerControl <> nil then
          SendAMessage(FOwnerControl, AC_GETOUTRGN, LPARAM(@WndRect))
        else
          if FOwnerObject is TsSkinProvider then
            WndRect := TsSkinProvider(FOwnerObject).Form.BoundsRect
          else
            Exit; // Unknown control

        OffsetRect(WndRect, BGInfo.Offset.X, BGInfo.Offset.Y);
        CacheRect := WndRect;
        with CacheRect do begin
          dec(Left,   oRect.Left);
          dec(Top,    oRect.Top);
          inc(Right,  oRect.Right);
          inc(Bottom, oRect.Bottom);
        end;
        if (Data and USECACHE <> 0) and (FOuterCache <> nil) then begin
          TmpBmp := FOuterCache;
          FOuterCache := CreateBmp32(CacheRect);
          BitBlt(FOuterCache.Canvas.Handle, 0, 0, FOuterCache.Width, FOuterCache.Height, BGInfo.Bmp.Canvas.Handle, CacheRect.Left, CacheRect.Top, SRCCOPY);
          PaintEffect(TmpBmp, MkRect(FOuterCache), oRect, mNdx, op);
          BitBlt(BGInfo.Bmp.Canvas.Handle, CacheRect.Left, CacheRect.Top, FOuterCache.Width, FOuterCache.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
          TmpBmp.Free;
        end
        else begin
          if FOuterCache = nil then
            FOuterCache := CreateBmp32(CacheRect)
          else begin
            FOuterCache.Width  := WidthOf (CacheRect);
            FOuterCache.Height := HeightOf(CacheRect);
          end;
          BitBlt(FOuterCache.Canvas.Handle, 0, 0, FOuterCache.Width, FOuterCache.Height, BGInfo.Bmp.Canvas.Handle, CacheRect.Left, CacheRect.Top, SRCCOPY);
          PaintEffect(BGInfo.Bmp, CacheRect, oRect, mNdx, op);
        end;
      end;
    end;
end;


procedure TsCommonData.PaintOuterEffects;
var
  BGInfo: TacBGInfo;
  Count, I: Integer;
begin
  if Skinned and SkinManager.Effects.AllowOuterEffects then begin
    BGInfo.BgType := btCache;
    BGInfo.Bmp := FCacheBmp;
    BGInfo.Offset := Offset;
    I := 0;
    Count := OwnerCtrl.ControlCount;
    while I < Count do begin
      if ControlIsReady(OwnerCtrl.Controls[I]) and OwnerCtrl.Controls[I].Visible then
        OwnerCtrl.Controls[I].Perform(SM_ALPHACMD, AC_PAINTOUTER_HI, LPARAM(@BGInfo));

      inc(I);
    end;
  end;
end;


function TsCommonData.RepaintIfMoved: boolean;
begin
  if (Self = nil) or not Skinned or{$IFNDEF ALITE}(FOwnerControl is TsTabSheet) or{$ENDIF} (FOwnerControl = nil) then
    Result := True
  else
    if not FOwnerControl.Enabled then
      Result := True
    else
      if (SkinManager.gd[SkinIndex].Props[0].Transparency > 0) and Assigned(FOwnerControl.Parent) and FOwnerControl.Parent.HandleAllocated then
        Result := GetBoolMsg(FOwnerControl.Parent, AC_CHILDCHANGED)
      else
        Result := False;
end;


{$IFDEF DEBUG}
procedure TsCommonData.SetUpdating(const Value: boolean);
begin
  FUpdating := Value;
end;

procedure TsCommonData.SetSkinIndex(const Value: integer);
begin
  FSkinIndex := Value;
end;

procedure TsCommonData.SetBGChanged(const Value: boolean);
begin
  FBGChanged := Value;
end;

procedure TsCommonData.SetFOwnerControl(const Value: TControl);
begin
  if FFOwnerControl <> Value then
    FFOwnerControl := Value;
end;
{$ENDIF}


procedure TsCommonData.SetColorTone(const Value: TColor);
begin
  if FColorTone <> Value then begin
    FColorTone := Value;
    Loaded;
    Invalidate;
  end;
end;


procedure TsCommonData.SetCustomColor(const Value: boolean);
begin
  if FCustomColor <> Value then begin
    FCustomColor := Value;
    if (FOwnerControl <> nil) and not (csLoading in FOwnerControl.ComponentState) and not Loading then
      with TacAccessControl(FOwnerControl) do begin
        if not Value then
          SavedColor := Color
        else
          if SavedColor <> clNone then
            Color := SavedColor
          else
            SavedColor := Color;

        UpdateCtrlColors(Self, True);
      end;
  end;
end;


procedure TsCommonData.SetCustomFont(const Value: boolean);
begin
  if FCustomFont <> Value then begin
    FCustomFont := Value;
    if (FOwnerControl <> nil) and not (csLoading in FOwnerControl.ComponentState) and not Loading then
      with TacAccessControl(FOwnerControl) do begin
        if not Value then
          SavedFontColor := Font.Color
        else
          if SavedFontColor <> clNone then
            Font.Color := SavedFontColor
          else
            SavedFontColor := Font.Color;

        UpdateCtrlColors(Self, True);
      end;
  end;
end;


procedure TsCommonData.SetHUEOffset(const Value: integer);
begin
  if FHUEOffset <> Value then begin
    FHUEOffset := Value;
    Loaded;
    Invalidate;
  end;
end;


procedure TsCommonData.SetSaturation(const Value: integer);
begin
  if FSaturation <> Value then begin
    FSaturation := Value;
    Loaded;
    Invalidate;
  end;
end;


procedure TsCommonData.SetSkinManager(const Value: TsSkinManager);
begin
  if FSkinManager <> Value then begin
    if Value <> DefaultManager then
      FSkinManager := Value
    else
      FSkinManager := nil;

    if (FOwnerControl = nil) or not (csLoading in FOwnerControl.ComponentState) then begin
      if Assigned(Value) and (Length(Value.gd) > 0) then
        UpdateIndexes
      else
        SkinIndex := -1;

      if not Assigned(FOwnerObject) or not (FOwnerObject is TsSkinProvider) then
        if (FOwnerControl <> nil) and (FOwnerControl.Parent <> nil) and not (csDestroying in FOwnerControl.ComponentState) then
          if Assigned(Value) and (Length(Value.gd) > 0) and Value.IsValidSkinIndex(SkinIndex) then
            FOwnerControl.Perform(SM_ALPHACMD, AC_REFRESH_HI, LongWord(Value))
          else
            FOwnerControl.Perform(SM_ALPHACMD, AC_REMOVESKIN_HI, LongWord(Value));
    end;
  end;
end;


procedure TsCommonData.SetSkinSection(const Value: string);
var
  m: TMessage;
begin
  if FSkinSection <> Value then begin
    HideGlow(GlowID);
    FSkinSection := UpperCase(Value);
    if Assigned(SkinManager) and (Length(SkinManager.gd) > 0) then
      UpdateIndexes
    else
      SkinIndex := -1;

    if (FOwnerControl <> nil) and (FOwnerControl.Parent <> nil) and ([csLoading, csReading, csDestroying] * FOwnerControl.ComponentState = []) then begin
      if FOwnerControl is TWinControl then begin
        if FCacheBmp <> nil then
          FCacheBmp.Width := 0;

        m := MakeMessage(SM_ALPHACMD, AC_SETBGCHANGED_HI + 1, 0, 0);
        AlphaBroadCast(TWinControl(FOwnerControl), m);
      end;
      if not FUpdating and not Loading then
        if Assigned(SkinManager) and (Length(SkinManager.gd) > 0) and SkinManager.IsValidSkinIndex(SkinIndex) then
          FOwnerControl.Perform(SM_ALPHACMD, AC_REFRESH_HI + 1, LongWord(SkinManager))
        else
          FOwnerControl.Perform(SM_ALPHACMD, AC_REMOVESKIN_HI, LongWord(SkinManager))
      else
        if not Loading then
          UpdateControlColors(Self, False);
    end
    else
      if FOwnerObject is TsSkinProvider then
        BGChanged := True;
  end;
end;


function TsCommonData.Skinned(const CheckSkinActive: boolean = False): boolean;
var
  SM: TsSkinManager;
begin
  SM := SkinManager;
  if (SM <> nil) and not (csDestroying in SM.ComponentState) and SM.IsValidSkinIndex(SkinIndex) then
    if (FOwnerObject = nil) or not (csDestroying in TComponent(FOwnerObject).ComponentState) then
      if CheckSkinActive then
        Result := SM.CommonSkinData.Active
      else
        Result := True
    else
      Result := False
  else
    Result := False;
end;


function ChildBgIsChanged(SkinData: TsCommonData): boolean;
begin
  Result := True;
{
  if (SkinData.SkinIndex > -1) then
    with SkinData.SkinManager do begin
      if (SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency > 0) and (SkinData.FOwnerControl <> nil) and (SkinData.FOwnerControl.Parent <> nil) then
        Result := ParentTextured(SkinData)
      else
        if (gd[SkinData.SkinIndex].Props[0].GradientPercent + gd[SkinData.SkinIndex].Props[0].ImagePercent > 0) or SkinData.RepaintIfMoved then
          Result := True
        else
          Result := (SkinData.BorderIndex >= 0) and (ma[SkinData.BorderIndex].DrawMode and BDM_FILL = BDM_FILL);

    end
  else
    Result := False
}
end;


function NeedParentFont(SkinData: TsCommonData; State: integer): boolean;
begin
  with SkinData do
    Result := NeedParentFont(SkinManager, SkinIndex, State, FOwnerControl);
end;


function NeedParentFont(SkinManager: TsSkinManager; SkinIndex, State: integer; Ctrl: TControl = nil): boolean;
var
  X, Y: integer;
begin
  with SkinManager do
    if ((Ctrl = nil) or (Ctrl.Parent <> nil)) and (SkinIndex >= 0) then
      with gd[SkinIndex] do begin
        if States <= State then
          State := States - 1;

        Result := Props[min(State, ac_MaxPropsIndex)].Transparency >= 50;
        if Result and (BorderIndex >= 0) then
          with ma[BorderIndex] do
            if State = 0 then
              Result := (DrawMode and BDM_FILL = 0) or (DrawMode and BDM_ACTIVEONLY <> 0)
            else
              if DrawMode and BDM_FILL = 0 then
                Result := True
              else
                if MaskType = 0 then
                  Result := False
                else begin
                  X := R.Left + State * Width + Width div 2;
                  Y := R.Bottom - Height div 2;
                  if Bmp <> nil then
                    Result := GetAPixel(Bmp, X, Y).R >= 127
                  else
                    Result := GetAPixel(SkinManager.MasterBitmap, X, Y).R >= 127
                end;
      end
    else
      Result := False;
end;


function GetRgnFromSkin(ASectionIndex: integer; const CtrlSize: TSize; SM: TsSkinManager = nil): HRGN;
var
  md: TsMaskData;
  Rects: TRects;
  l, i: integer;
  subrgn: HRGN;
begin
  if IsValidIndex(ASectionIndex, Length(SM.gd)) and (SM.gd[ASectionIndex].BorderIndex >= 0) then begin
    SetLength(Rects, 0);
    md := SM.ma[SM.gd[ASectionIndex].BorderIndex];
    AddRgn(Rects, CtrlSize.cx, md, 0, False);
    AddRgn(Rects, CtrlSize.cx, md, CtrlSize.cy - md.WB, True);

    l := Length(Rects);
    Result := CreateRectRgn(0, 0, CtrlSize.cx, CtrlSize.cy);
    if l > 0 then
      for i := 0 to l - 1 do begin
        with Rects[i] do
          subrgn := CreateRectRgn(Left, Top, Right, Bottom);

        CombineRgn(Result, Result, subrgn, RGN_DIFF);
        DeleteObject(subrgn);
      end;
  end
  else
    Result := 0;
end;


procedure GetTransCorners(ASectionIndex: integer; aBmp: TBitmap; SM: TsSkinManager = nil);
var
  md: TsMaskData;
  Rects: TRects;
  l, i: integer;
begin
  if IsValidIndex(ASectionIndex, Length(SM.gd)) and (SM.gd[ASectionIndex].BorderIndex >= 0) then begin
    SetLength(Rects, 0);
    md := SM.ma[SM.gd[ASectionIndex].BorderIndex];
    AddRgn(Rects, aBmp.Width, md, 0, False);
    AddRgn(Rects, aBmp.Width, md, aBmp.Height - md.WB, True);
    l := Length(Rects);
    if l > 0 then
      for i := 0 to l - 1 do
        FillRect32(aBmp, Rects[i], 0, 0);
  end;
end;


function CommonMessage(var Message: TMessage; SkinData: TsCommonData): boolean;
var
  i: integer;
  b: boolean;
begin
  Result := True;
  if SkinData <> nil then
    with SkinData do
      if Message.Msg = SM_ALPHACMD then
        case Message.WParamHi of
          AC_SETSCALE: begin
            ScalePercent := Message.LParam;
            if FOwnerControl is TWinControl then
              AlphaBroadCast(TWinControl(FOwnerControl), Message);

            Result := False;
          end;

          AC_GETSCALE:
            Message.Result := SkinData.ScalePercent;

          AC_REINITSCROLLS:
            if FOwnerControl is TWinControl then
              with TWinControl(FOwnerControl) do begin
                if HandleAllocated then
                  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);

                AlphaBroadCast(TWinControl(FOwnerControl), Message);
              end;

          AC_PRINTING: begin
            if Message.LParam = 0 then
              CtrlSkinState := CtrlSkinState and not ACS_PRINTING
            else
              CtrlSkinState := CtrlSkinState or ACS_PRINTING;

            PrintDC := hdc(Message.LParam);
          end;

          AC_UPDATESECTION:
            if (Message.LParam <> 0) and (UpperCase(SkinSection) = PChar(Message.LParam)^){ GlobalSectionName }then begin
              RestrictDrawing := False;
              Invalidate;
            end;

          AC_PREPARING:
            if InUpdating(SkinData) then
              Message.Result := 1
            else
              if IsCached(SkinData) and not CustomColor then
                if FOwnerControl is TWinControl then begin
                  if (FCacheBmp = nil) or FCacheBmp.Empty then begin
                    SendAMessage(TWinControl(FOwnerControl).Handle, AC_PREPARECACHE);
                    Message.Result := integer(FCacheBmp.Empty);
                    Exit;
                  end;
                  Message.Result := LRESULT((FCacheBmp.Width <> FOwnerControl.Width) or (FCacheBmp.Height <> FOwnerControl.Height));
                end
                else
                  Message.Result := 0
              else
                Message.Result := 0;

          AC_UPDATING:
            FUpdating := Message.WParamLo = 1;
{
          AC_MOUSEENTER: begin
            M := MakeMessage(CM_MOUSEENTER, 0, 0, 0);
            CommonWndProc(M, SkinData);
          end;

          AC_MOUSELEAVE: begin
            M := MakeMessage(CM_MOUSELEAVE, 0, 0, 0);
            CommonWndProc(M, SkinData);
          end;
}
          AC_PAINTOUTER:
            SkinData.PaintOuter(PacBGInfo(Message.LParam), Message.WParamLo);

          AC_GETOUTRGN:
            if FOwnerControl <> nil then
              PRect(Message.LParam)^ := FOwnerControl.BoundsRect
            else
              PRect(Message.LParam)^ := MkRect;

          AC_GETHALFVISIBLE:
            Message.Result := LRESULT(HalfVisible);

          AC_GETFONTINDEX:
            if Skinned then
              with SkinManager.gd[SkinData.SkinIndex] do
                if NeedParentFont(SkinData, PacPaintInfo(Message.LParam)^.State) then
                  if FOwnerControl <> nil then
                    Message.Result := GetFontIndex(FOwnerControl.Parent, PacPaintInfo(Message.LParam))
                  else
                    Message.Result := GetFontIndex(GetParent(FSWHandle), PacPaintInfo(Message.LParam))
                else {
                  if GiveOwnFont or (PacPaintInfo(Message.LParam)^.State = 0) then} begin
                    if States <= PacPaintInfo(Message.LParam)^.State then
                      PacPaintInfo(Message.LParam)^.FontIndex := -1        // Use own child font
                    else
                      PacPaintInfo(Message.LParam)^.FontIndex := SkinIndex;

                    Message.Result := 1;
                  end;

          AC_CLEARCACHE:
            if FCacheBmp <> nil then begin
              if FOwnerControl is TWinControl then
                with FOwnerControl as TWinControl do
                  for i := 0 to ControlCount - 1 do
                    if (Controls[i] is TWinControl) and TWinControl(Controls[i]).HandleAllocated then
                      SendAMessage(TWinControl(Controls[i]).Handle, AC_CLEARCACHE);

              FCacheBmp.Width := 0;
              FCacheBmp.Height := 0;
              BGChanged := True;
            end;

          AC_CHILDCHANGED:
            Message.Result := LRESULT(ChildBgIsChanged(SkinData));

          AC_SETNEWSKIN:
            if ACUInt(Message.LParam) = ACUInt(SkinManager) then begin
              StopTimer(SkinData);
              UpdateData(SkinData);
              InitIndexes(SkinData, [SkinSection]);
              if FCacheBmp <> nil then begin
                FCacheBmp.Height := 0;
                FCacheBmp.Width := 0;
              end;
              UpdateSkinState(SkinData, False);
              RestrictDrawing := False;
            end;

          AC_SETBGCHANGED:
            BGChanged := True;

          AC_SETHALFVISIBLE:
            HalfVisible := True;

          AC_GETSKINDATA:
            Message.Result := LRESULT(SkinData);

          AC_REFRESH:
            if ACUInt(Message.LParam) = ACUInt(SkinManager) then begin
              StopTimer(SkinData);
              BGChanged := True;
              Updating := False;
              UpdateCtrlColors(SkinData, True);
              UpdateSkinState(SkinData, False);
              if (COC in ssScrolledEdits) and (FOwnerControl is TWinControl) then
                SetWindowPos(TWinControl(FOwnerControl).Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
            end;

          AC_REMOVESKIN:
            if ACUInt(Message.LParam) = ACUInt(SkinManager) then begin
              if SkinIndex >= 0 then begin
                StopTimer(SkinData);
                if (SkinManager <> nil) and (csDestroying in SkinManager.ComponentState) then
                  FSkinManager := nil;

                BorderIndex := -1;
                SkinIndex := -1;
                Texture := -1;
                HotTexture := -1;
                Updating := True;
                Result := False;
                if Assigned(FCacheBmp) then begin
                  FCacheBmp.Width := 0;
                  FCacheBmp.Height := 0;
                end;
                if FOwnerControl is TCustomEdit then begin
                  if not CustomColor then
                    TacAccessControl(FOwnerControl).Color := clWindow;

                  if not CustomFont then
                    TacAccessControl(FOwnerControl).Font.Color := clWindowText;

                  RedrawWindow(TCustomEdit(FOwnerControl).Handle, nil, 0, RDWA_FRAME);
                end
                else
                  if (FOwnerControl is TWinControl) then
                    with TWinControl(FOwnerControl) do
                      for i := 0 to ControlCount - 1 do
                        if Controls[i] is TLabel then
                          TLabel(Controls[i]).Font.Color := clWindowText;
              end;
            end;

          AC_GETCONTROLCOLOR:
            if Assigned(FOwnerControl) then
              if Skinned then
                with SkinManager.gd[Skinindex], Props[0], FOwnerControl do
                  case Transparency of
                    0:
                      Message.Result := Color;

                    100:
                      if Parent <> nil then
                        if WndIsSkinned(Parent.Handle) then
                          Message.Result := TrySendMessage(Parent.Handle, SM_ALPHACMD, AC_GETCONTROLCOLOR_HI, 0)
                        else
                          Message.Result := TacAccessControl(Parent).Color
                      else
                        Message.Result := ColorToRGB(TacAccessControl(FOwnerControl).Color);

                    else begin
                      if Parent <> nil then
                        Message.Result := TrySendMessage(Parent.Handle, SM_ALPHACMD, AC_GETCONTROLCOLOR_HI, 0)
                      else
                        Message.Result := ColorToRGB(TacAccessControl(FOwnerControl).Color);
                      // Mixing of colors
                      C1.C := Message.Result;
                      C2.C := Color;
                      C1.R := ((C1.R - C2.R) * Transparency + C2.R shl 8) shr 8;
                      C1.G := ((C1.G - C2.G) * Transparency + C2.G shl 8) shr 8;
                      C1.B := ((C1.B - C2.B) * Transparency + C2.B shl 8) shr 8;
                      Message.Result := C1.C;
                    end
                  end
              else
                Message.Result := ColorToRGB(TacAccessControl(FOwnerControl).Color);

          AC_SETCHANGEDIFNECESSARY: begin
            b := RepaintIfMoved;
            BGChanged := BGChanged or b;
            if FOwnerControl is TWinControl then
              with TWinControl(FOwnerControl) do begin
                if Message.WParamLo = 1 then
                  RedrawWindow(Handle, nil, 0, RDWA_ALLCHILDREN);

                if b then
                  for i := 0 to ControlCount - 1 do
                    if not (csDestroying in Controls[i].ComponentState) then
                      Controls[i].Perform(SM_ALPHACMD, AC_SETCHANGEDIFNECESSARY shl 16 + 1, 0);
              end;
          end;

          AC_GETAPPLICATION:
            Message.Result := LRESULT(Application);

          AC_CTRLHANDLED:
            Message.Result := 1;

          AC_GETBG:
            InitBGInfo(SkinData, PacBGInfo(Message.LParam), integer(FFocused or FMouseAbove and not (COC in sCanNotBeHot)));

          AC_STOPFADING: 
            StopTimer(SkinData);

          AC_GETSKININDEX:
            PacSectionInfo(Message.LParam)^.siSkinIndex := SkinIndex;

          AC_PREPARECACHE:
            SkinData.BGChanged := False;

          AC_ENDPARENTUPDATE:
            if FUpdating and (FOwnerControl is TWinControl) then begin
              if not InUpdating(SkinData, True) then
                RedrawWindow(TWinControl(FOwnerControl).Handle, nil, 0, RDWA_ALLNOW);

              SetParentUpdated(TWinControl(FOwnerControl));
            end;

          AC_GETSKINSTATE:
            if Message.LParam = 1 then
              UpdateSkinState(SkinData)
            else begin
              if CtrlSkinState = ACS_BGUNDEF then {If not initialized yet}
                UpdateSkinState(SkinData, False);

              Message.Result := CtrlSkinState;
            end;

          AC_INVALIDATE:
            Invalidate;

          AC_SETSECTION:
            if Message.LParam <> 0 then begin
              SkinSection := PacSectionInfo(Message.LParam).siName;
              Message.Result := 1;
            end
            else
              Message.Result := 0

          else
            Result := False;
  end;
end;


procedure TsCommonData.UpdateIndexes(UpdateMain: boolean = True);
begin
{$IFNDEF SKININDESIGN}
  if (FOwnerObject is TComponent) and (csDesigning in TComponent(FOwnerObject).ComponentState) and (GetOwnerFrame(TComponent(FOwnerObject)) <> nil) then begin
    SkinIndex  := -1;
    Texture    := -1;
    HotTexture := -1;
    Exit;
  end;
{$ENDIF}
  BGChanged := True;
  if UpdateMain then
    if Assigned(SkinManager) and SkinManager.Active then
      if SkinSection <> '' then
        SkinIndex := SkinManager.GetSkinIndex(SkinSection)
      else
        if (FOwnerControl is TWinControl) and TWinControl(FOwnerControl).HandleAllocated then
          SkinIndex := SendAMessage(FOwnerControl, AC_GETDEFINDEX) - 1
        else
          if FOwnerControl <> nil then
            SkinIndex := FOwnerControl.Perform(SM_ALPHACMD, AC_GETDEFINDEX_HI, 0) - 1
          else
            SkinIndex := -1
    else
      SkinIndex := -1;

  InitBGType(Self);
  CtrlSkinState := ACS_BGUNDEF;
  if SkinIndex >= 0 then begin
    BorderIndex := SkinManager.gd[SkinIndex].BorderIndex;
    Texture     := SkinManager.GetTextureIndex(SkinIndex, s_Pattern);
    HotTexture  := SkinManager.GetTextureIndex(SkinIndex, s_HotPattern);
    UpdateSkinState(Self, False);
  end
  else begin
    BorderIndex := -1;
    Texture     := -1;
    HotTexture  := -1;
  end;
end;


function acMouseInControl(sd: TsCommonData): boolean;
var
  DC: hdc;
  p: TPoint;
  cR, wR: TRect;
  sw: TacMainWnd;
  AHandle: THandle;
begin
  Result := False;
  if sd.FOwnerControl is TWinControl then
    with TWinControl(sd.FOwnerControl) do begin
      AHandle := Handle;
      if IsWindowVisible(AHandle) then begin
        wR := ClientRect;
        p := ScreenToClient(acMousePos);
      end
      else
        Exit;
    end
  else begin
    AHandle := sd.OwnerHandle;
    if (AHandle <> 0) and IsWindowVisible(AHandle) then begin
      GetWindowRect(AHandle, wR);
      GetClientRect(AHandle, cR);
      p := acMousePos;
      p.X := p.X - wR.Left;
      p.Y := p.Y - wR.Top;
      wR := MkRect(WidthOf(cR), HeightOf(cR));
    end
    else
      Exit;
  end;
  sw := TacMainWnd(SendAMessage(AHandle, AC_GETLISTSW));
  if sw is TacScrollWnd then
    with TacScrollWnd(sw) do begin
      if sBarHorz.fScrollVisible then
        inc(wR.Bottom, integer(sbarHorz.fScrollVisible) * GetScrollMetric(sbarHorz, SM_SCROLLWIDTH));

      if sBarVert.fScrollVisible then
        inc(wR.Right, integer(sbarVert.fScrollVisible) * GetScrollMetric(sbarVert, SM_SCROLLWIDTH));
    end;

  Result := PtInRect(wR, p);
  if Result and (AHandle <> 0) then begin // Check if part of control is not visible
    DC := GetDC(AHandle);
    GetClipBox(DC, wR);
    Result := PtInRect(wR, p);
    ReleaseDC(AHandle, DC);
  end;
end;


function acMouseInWnd(Handle: THandle): boolean;
var
  p: TPoint;
  cR, wR: TRect;
  sw: TacMainWnd;
begin
  Result := False;
  if Handle <> 0 then begin
    GetWindowRect(Handle, wR);
    GetClientRect(Handle, cR);
    p := acMousePos;
    p.X := p.X - wR.Left;
    p.Y := p.Y - wR.Top;
    wR := MkRect(WidthOf(cR), HeightOf(cR));
    sw := TacMainWnd(SendAMessage(Handle, AC_GETLISTSW));
    if sw is TacScrollWnd then
      with TacScrollWnd(sw) do begin
        if sBarHorz.fScrollVisible then
          inc(wR.Bottom, integer(sbarHorz.fScrollVisible) * GetScrollMetric(sbarHorz, SM_SCROLLWIDTH));

        if sBarVert.fScrollVisible then
          inc(wR.Right, integer(sbarVert.fScrollVisible) * GetScrollMetric(sbarVert, SM_SCROLLWIDTH));
      end;

    Result := PtInRect(wR, p);
  end;
end;


function CommonWndProc(var Message: TMessage; SkinData: TsCommonData): boolean;
var
  i: integer;
  b: boolean;
begin
  Result := False;
  if SkinData <> nil then
    with SkinData do
      case Message.Msg of
        SM_ALPHACMD: // Common messages for all components
          Result := CommonMessage(Message, SkinData);

        WM_PRINT:
          if not SkinData.Skinned and (Message.WParam <> 0) and (SkinData.FOwnerControl is TWinControl) then begin
            if GetWindowLong(TWinControl(SkinData.FOwnerControl).Handle, GWL_ExSTYLE) and WS_EX_CLIENTEDGE <> 0 then
              i := 2
            else
              i := 0;

            PaintControls(hdc(Message.WParam), TWinControl(SkinData.FOwnerControl), False, Point(i, i));
            Result := True
          end;


{$IFDEF CHECKXP}
        WM_UPDATEUISTATE:
          if Skinned then
            Result := True
          else
            if UseThemes and (FOwnerControl is TWinControl) then
              SetWindowTheme(TWinControl(FOwnerControl).Handle, nil, nil);
{$ENDIF}

{$IFNDEF FPC}
        WM_CONTEXTMENU:
          if (FOwnerControl <> nil) and (TacAccessControl(FOwnerControl).PopupMenu <> nil) and (SkinManager <> nil) then
            SkinManager.SkinableMenus.HookPopupMenu(TacAccessControl(FOwnerControl).PopupMenu, SkinManager.Active);
{$ENDIF}

        CM_VISIBLECHANGED: begin
          if (GlowID >= 0) and (Message.WParam = 0) then
            HideGlow(GlowID, False);

          if (SkinManager <> nil) and (SkinManager.Options.OptimizingPriority = opMemory) and (FOwnerControl <> nil) and
                not (csDestroying in FOwnerControl.ComponentState) and Assigned(FCacheBmp) then begin
            if Message.WParam = 0 then begin
              FCacheBmp.Width  := 0;
              FCacheBmp.Height := 0;
              if (FOwnerControl is TWinControl) then
                with FOwnerControl as TWinControl do
                  for i := 0 to ControlCount - 1 do
                    if (Controls[i] is TWinControl) and TWinControl(Controls[i]).HandleAllocated then
                      SendAMessage(TWinControl(Controls[i]).Handle, AC_CLEARCACHE)
                    else
                      Controls[i].Perform(SM_ALPHACMD, AC_CLEARCACHE_HI, 0);
            end
            else
              Updating := False;

            BGChanged := True;
          end;
        end;

        CM_SHOWINGCHANGED:
          if Assigned(FOwnerControl) and FOwnerControl.Visible then
            Loaded;

        WM_PARENTNOTIFY:
          if (FOwnerControl is TWinControl) and {((Message.WParam and $FFFF) in [WM_CREATE, WM_DESTROY]) and} (Message.WParamLo = WM_CREATE) then
            AddToAdapter(TWinControl(FOwnerControl));

        WM_SETFOCUS:
          if Skinned and (FOwnerControl is TWinControl) then
            with TWinControl(FOwnerControl), SkinManager.gd[SkinIndex] do
              if CanFocus and TabStop and ((Props[0].Transparency <> 100) or (Props[1].Transparency <> 100)) then begin
                BGChanged := True;
                FFocused := True;
                if (COC in sEditCtrls) and (States > 1) then begin
                  BGChanged := True;
                  b := False;
                  if (TacAccessControl(FOwnerControl).Color <> Props[1].Color) and not CustomColor then begin
                    TacAccessControl(FOwnerControl).Color := Props[1].Color;
                    b := True;
                  end;
                  if (TacAccessControl(FOwnerControl).Font.Color <> Props[1].FontColor.Color) and not CustomFont then begin
                    CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                    TacAccessControl(FOwnerControl).Font.Color := Props[1].FontColor.Color;
                    CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                    b := True;
                  end;
                  if b then
                    RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);

                  TrySendMessage(Handle, WM_NCPAINT, 0, 0);
                end;
              end;

        WM_KILLFOCUS:
          if Skinned and (FOwnerControl is TWinControl) then
            with TWinControl(FOwnerControl), SkinManager.gd[SkinIndex] do
              if CanFocus and ((Props[0].Transparency <> 100) or (Props[1].Transparency <> 100)) then begin
                BGChanged := True;
                FFocused := False;
                b := False;
                if (COC in sEditCtrls) and not ControlIsActive(SkinData) then begin
                  if (TacAccessControl(FOwnerControl).Color <> Props[0].Color) and not CustomColor then begin
                    TacAccessControl(FOwnerControl).Color := Props[0].Color;
                    b := True;
                  end;
                  if (TacAccessControl(FOwnerControl).Font.Color <> Props[0].FontColor.Color) and not CustomFont then begin
                    CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                    TacAccessControl(FOwnerControl).Font.Color := Props[0].FontColor.Color;
                    CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                    b := True;
                  end;
                end;
                if FOwnerControl.Visible and (COC in sEditCtrls) then begin
                  BGChanged := True;
                  if b then
                    RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);

                  TrySendMessage(Handle, WM_NCPAINT, 0, 0);
                end;
              end;


        CM_ENABLEDCHANGED, WM_FONTCHANGE: begin
          FMouseAbove := False;
          FFocused := False;
          BGChanged := True;
          if Assigned(FOwnerControl) and not FOwnerControl.Enabled then
            HideGlow(GlowID);
        end;

        CM_MOUSEENTER: begin
          if Skinned and not FMouseAbove then
            with SkinData.SkinManager, gd[SkinIndex] do
              if not (csDesigning in ComponentState) and not Options.NoMouseHover and not ((Props[0].Transparency = 100) and (Props[1].Transparency = 100)) then
                if FOwnerControl is TWinControl then
                  with TWinControl(FOwnerControl) do begin
                    if not (csDesigning in ComponentState) then begin
                      for i := 0 to ControlCount - 1 do
                        if (Controls[i] is TsSpeedButton) and (Controls[i] <> FOwnerControl) and
                             (Controls[i] <> Pointer(Message.LParam)) and TsSpeedButton(Controls[i]).SkinData.FMouseAbove then
                          Controls[i].Perform(CM_MOUSELEAVE, 0, 0);

                      if not (COC in sForbidMouse) then // and (not (SkinData.COC in sNoHotEdits) or ac_AllowHotEdits) then
                        FMouseAbove := True;

                      DefaultManager.ActiveControl := TWinControl(FOwnerControl).Handle;
                      if not (COC in (sCanNotBeHot + ssButtons)) then
                        ShowGlowingIfNeeded(SkinData, False, Handle, MaxByte * integer(not Effects.AllowAnimation), True);

                      if (COC in sEditCtrls) and (not (SkinData.COC in sNoHotEdits) or ac_AllowHotEdits) and (States > 1) then begin
                        BGChanged := True;
                        b := False;
                        if (TacAccessControl(FOwnerControl).Color <> Props[1].Color) and not CustomColor then begin
                          TacAccessControl(FOwnerControl).Color := Props[1].Color;
                          b := True;
                        end;
                        if (TacAccessControl(FOwnerControl).Font.Color <> Props[1].FontColor.Color) and not CustomFont then begin
                          CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                          TacAccessControl(FOwnerControl).Font.Color := Props[1].FontColor.Color;
                          CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                          b := True;
                        end;
                        if b then
                          InvalidateRect(Handle, nil, True);

                        TrySendMessage(Handle, WM_NCPAINT, 0, 0);
                      end;
                    end;
                  end
                else
                  if not (COC in sForbidMouse) then // and (not (SkinData.COC in sNoHotEdits) or ac_AllowHotEdits) then
                    FMouseAbove := True;

{$IFNDEF D2005}
{$IFNDEF ALITE}
            if (acAlphaHints.Manager <> nil) and Assigned(acAlphaHints.Manager.AnimWindow) then
              Application.ActivateHint(acMousePos);
{$ENDIF}
{$ENDIF}
        end;

        CM_MOUSELEAVE:
          if Skinned then
            if FOwnerControl <> nil then
              with TWinControl(FOwnerControl), SkinManager, SkinManager.gd[SkinIndex] do
                if not Options.NoMouseHover and not (csDesigning in ComponentState) and not acMouseInControl(SkinData) then begin
                  if not (COC in sForbidMouse) then
                    FMouseAbove := False;

                  if not (COC in sCanNotBeHot) and not (COC in ssButtons) then
                    HideGlow(GlowID, True);

                  b := False;
                  if (COC in sEditCtrls) and not ControlIsActive(SkinData) and not ((Props[0].Transparency = 100) and (Props[1].Transparency = 100)) then begin
                    if (TacAccessControl(FOwnerControl).Color <> Props[0].Color) and not CustomColor then begin
                      TacAccessControl(FOwnerControl).Color := Props[0].Color;
                      b := True;
                    end;
                    if (TacAccessControl(FOwnerControl).Font.Color <> Props[0].FontColor.Color) and not CustomFont then begin
                      CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                      TacAccessControl(FOwnerControl).Font.Color := Props[0].FontColor.Color;
                      CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                      b := True;
                    end;
                  end;
                  if FOwnerControl.Visible and (COC in sEditCtrls) then begin
                    BGChanged := True;
                    if b then
                      InvalidateRect(Handle, nil, True);

                    TrySendMessage(Handle, WM_NCPAINT, 0, 0);
                  end;
                end;

        WM_CREATE, WM_NCCREATE: // Reinit if recreated
          SkinData.InitCommonProp;

        WM_SIZE:
          if Skinned then begin
            BGChanged := True;
            if OuterEffects.Visibility <> ovNone then
              InvalidateParentCache(SkinData);

            // Add "FullRepaintOnly(SkinData, ssHorizontal)" for optimizing (in Beta)
            if SkinManager.gd[SkinIndex].Props[0].GradientPercent > 0 then // !!! Change to BG type later
{$IFNDEF ALITE}
              if FOwnerControl is TsPageControl then
                with TsPageControl(FOwnerControl), ActivePage do begin
                  if ActivePage <> nil then
                    for i := 0 to ControlCount - 1 do
                      if (i < ControlCount) and not (csDestroying in Controls[i].ComponentState) then
                        Controls[i].Perform(SM_ALPHACMD, AC_SETCHANGEDIFNECESSARY shl 16 + 1, 0);
                end
              else
{$ENDIF}
                if FOwnerControl is TWinControl then
                  with TWinControl(FOwnerControl) do
                    for i := 0 to ControlCount - 1 do
                      if (i < ControlCount) and not (csDestroying in Controls[i].ComponentState) then
                        Controls[i].Perform(SM_ALPHACMD, AC_SETCHANGEDIFNECESSARY shl 16 + 1, 0);

            if (AnimTimer = nil) or not AnimTimer.Enabled then
              HideGlow(GlowID);
          end;

        WM_SHOWWINDOW:
          StopTimer(SkinData);

        WM_MOVE: if Skinned then begin
          if OuterEffects.Visibility <> ovNone then
            InvalidateParentCache(SkinData);

          if RepaintIfMoved then begin
            BGChanged := True;
            if FOwnerControl <> nil then
              FOwnerControl.Perform(SM_ALPHACMD, AC_SETCHANGEDIFNECESSARY shl 16 + 1, 0);
          end;
          HideGlow(GlowID);
        end;
      end;
end;


procedure CopyWinControlCache(const Control: TWinControl; const SkinData: TsCommonData; const SrcRect, DstRect: TRect; const DstDC: HDC;
                              const UpdateCorners: boolean; const OffsetX: integer = 0; const OffsetY: integer = 0);
var
  R: TRect;
  i: integer;
  SaveIndex: HDC;
  Child: TControl;
begin
  if (SkinData.FCacheBmp <> nil) and not SkinData.FCacheBmp.Empty then begin
    if UpdateCorners then
      sAlphaGraph.UpdateCorners(SkinData, 0);

    SaveIndex := SaveDC(DstDC);
    IntersectClipRect(DstDC, DstRect.Left, DstRect.Top, DstRect.Right, DstRect.Bottom);
    try
      for i := 0 to Control.ControlCount - 1 do begin
        Child := Control.Controls[i];
        if (Child is TGraphicControl) and StdTransparency {$IFNDEF ALITE}or (Child is TsSplitter){$ENDIF} then
          Continue;

        with Child do begin
          R := BoundsRect;
          if Visible and RectIsVisible(DstRect, R) then
            if {(csDesigning in ComponentState) or} (csOpaque in ControlStyle) or (Child is TGraphicControl) then
              ExcludeClipRect(DstDC, R.Left + OffsetX, R.Top + OffsetY, R.Right + OffsetX, R.Bottom + OffsetY);
        end;
      end;
      BitBlt(DstDC, DstRect.Left, DstRect.Top, WidthOf(DstRect), HeightOf(DstRect), SkinData.FCacheBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top, SRCCOPY);
    finally
      RestoreDC(DstDC, SaveIndex);
    end;
  end;
end;


procedure CopyHwndCache(const hwnd: THandle; const SkinData: TsCommonData; const SrcRect, DstRect: TRect; const DstDC: HDC; const UpdateCorners: boolean;
                        const OffsetX: integer = 0; const OffsetY: integer = 0); overload;
var
  SaveIndex: HDC;
  hctrl: THandle;
  R, hR: TRect;
  Index: integer;
begin
  if UpdateCorners then
    sAlphaGraph.UpdateCorners(SkinData, 0);

  SaveIndex := SaveDC(DstDC);
  IntersectClipRect(DstDC, DstRect.Left, DstRect.Top, DstRect.Right, DstRect.Bottom);
  try
    hctrl := GetTopWindow(hwnd);
    GetWindowRect(hwnd, R);
    while hctrl <> 0 do begin
      if IsWindowVisible(hctrl) then begin
        GetWindowRect(hctrl, hR);
        OffsetRect(hR, -R.Left - OffsetX, -R.Top - OffsetY);
        if (GetWindowLong(hctrl, GWL_STYLE) and BS_GROUPBOX = BS_GROUPBOX) and
             (GetWindowLong(hctrl, GWL_EXSTYLE) and WS_EX_CLIENTEDGE = 0) {Prevent of Treeview filling} then begin

          if DefaultManager <> nil then
            with DefaultManager, hR do begin
              Index := gd[ConstData.Sections[ssGroupBox]].BorderIndex;
              ExcludeClipRect(DstDC, Left, Top, Right, hR.Top + SendAMessage(hctrl, AC_GETSERVICEINT));
              ExcludeClipRect(DstDC, Left, Top, Left + ma[Index].WL, Bottom);
              ExcludeClipRect(DstDC, Right - ma[Index].WR, Top, Right, Bottom);
              ExcludeClipRect(DstDC, Left, Bottom - ma[Index].WB, Right, Bottom);
            end;
        end
        else
          ExcludeClipRect(DstDC, hR.Left, hR.Top, hR.Right, hR.Bottom);
      end;
      hctrl := GetNextWindow(hctrl, GW_HWNDNEXT);
    end;  
    BitBlt(DstDC, DstRect.Left, DstRect.Top, WidthOf(DstRect), HeightOf(DstRect), SkinData.FCacheBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top, SRCCOPY);
  finally
    RestoreDC(DstDC, SaveIndex);
  end;
end;


procedure TsBoundLabel.SetUseHTML(const Value: boolean);
begin
  if FUseHTML <> Value then begin
    FUseHTML := Value;
    AlignLabel;
  end;
end;


procedure TsBoundLabel.AlignLabel;
begin
  if Assigned(FTheLabel) then
    with TAccessLabel(FTheLabel) do
      if Visible then begin
        Parent.DisableAlign;
        Constraints.MaxWidth := FMaxWidth;
        if FMaxWidth > 0 then
          Width := FMaxWidth
        else
          Width := 9999;

        Height := 0;
        WordWrap := True;
        AutoSize := True;
        AdjustBounds;

        Enabled := FCommonData.FOwnerControl.Enabled or FEnabledAlways;
{$IFNDEF ALITE}
        UseHTML := FUseHTML;
{$ENDIF}
        Align := alNone;
        case Self.Layout of
          sclLeft: begin
            if FocusControl.Align = alLeft then begin
              Align := alLeft;
              Layout := tlCenter;
            end;
            Left := FocusControl.Left - Width - 4 - Indent;
            Top  := FocusControl.Top  + (FocusControl.Height - Height) div 2 - 1;
          end;

          sclTopLeft: begin
            Left := FocusControl.Left;
            Top  := FocusControl.Top - Height - Indent;
          end;

          sclTopCenter: begin
            Left := FocusControl.Left + (FocusControl.Width - Width) div 2;
            Top  := FocusControl.Top  - Height - Indent;
          end;

          sclTopRight: begin
            Left := FocusControl.Left + FocusControl.Width - Width;
            Top  := FocusControl.Top  - Height - Indent;
          end;

          sclLeftTop: begin
            Left := FocusControl.Left - Width - 4 - Indent;
            Top  := FocusControl.Top  + 3;
          end;

          sclBottomLeft: begin
            Left := FocusControl.Left;
            Top  := FocusControl.Top + FocusControl.Height + Indent;
          end;

          sclBottomCenter: begin
            Left := FocusControl.Left + (FocusControl.Width - Width) div 2;
            Top  := FocusControl.Top  + FocusControl.Height + Indent;
          end;

          sclBottomRight: begin
            Left := FocusControl.Left + FocusControl.Width - Width;
            Top  := FocusControl.Top  + FocusControl.Height + Indent;
          end;
        end;
        Parent := FCommonData.FOwnerControl.Parent;
        Parent.EnableAlign;
      end;
end;


constructor TsBoundLabel.Create(AOwner: TObject; const CommonData: TsCommonData);
begin
  FCommonData := CommonData;
  FFont := TFont.Create;
  FActive := False;
  FLayout := sclLeft;
  FAllowClick := False;
  ScalePercent := 100;
  FIndent := 0;
  FEnabledAlways := False;
  FMaxWidth := 0;
  FUseHTML := False;
end;


destructor TsBoundLabel.Destroy;
begin
  FreeAndNil(FFont);
  if Assigned(FTheLabel) then
    FreeAndNil(FTheLabel);

  inherited Destroy;
end;


function TsBoundLabel.DoStoreFont: boolean;
var
  ActFont, TmpFont: TFont;
begin
  TmpFont := TFont.Create;
  if FTheLabel <> nil then
    ActFont := FTheLabel.Font
  else
    ActFont := FFont;

  Result := (ActFont.Color <> TmpFont.Color) or
            (ActFont.Size <> TmpFont.Size) or
{$IFDEF D2005}
            (ActFont.Orientation <> TmpFont.Orientation) or
{$ENDIF}
            (ActFont.Style <> TmpFont.Style) or
            (ActFont.Pitch <> TmpFont.Pitch) or
            (ActFont.Name <> TmpFont.Name);

  TmpFont.Free;
end;


function TsBoundLabel.GetFont: TFont;
begin
  if Assigned(FTheLabel) and Assigned(FTheLabel.Font) then
    Result := FTheLabel.Font
  else
    Result := FFont;
end;


function TsBoundLabel.GetUseSkin: boolean;
begin
  if Assigned(FTheLabel) then
    Result := FTheLabel.UseSkinColor
  else
    Result := True;
end;


procedure TsBoundLabel.HandleOwnerMsg(const Message: TMessage; const OwnerControl: TControl);
begin
  if Assigned(FTheLabel) then
    case Message.Msg of
      SM_ALPHACMD:
        if Message.WParamHi = AC_SETSCALE then begin
          MaxWidth := MulDiv(MaxWidth, Message.LParam, ScalePercent);
          if (FTheLabel <> nil) and Active then
            AlignLabel;

          ScalePercent := Message.LParam;
        end;

      WM_SIZE, WM_WINDOWPOSCHANGED:
        AlignLabel;

      CM_VISIBLECHANGED: begin
        FTheLabel.Visible := OwnerControl.Visible;
        AlignLabel;
      end;

      CM_ENABLEDCHANGED: begin
        FTheLabel.Enabled := OwnerControl.Enabled or FEnabledAlways;
        AlignLabel;
      end;

      CM_BIDIMODECHANGED: begin
        FTheLabel.BiDiMode := OwnerControl.BiDiMode;
        AlignLabel;
      end;
    end;
end;


procedure TsBoundLabel.SetActive(const Value: boolean);
begin
  if FActive <> Value then begin
    FActive := Value;
    UpdateVisibility;
    SetAllowClick(FAllowClick); // Init the event
  end;
end;


procedure TsBoundLabel.SetEnabledAlways(const Value: boolean);
begin
  if FEnabledAlways <> Value then begin
    FEnabledAlways := Value;
    if Active then
      AlignLabel;
  end;
end;


procedure TsBoundLabel.SetFont(const Value: TFont);
begin
  if FTheLabel <> nil then begin
    FTheLabel.Font.Assign(Value);
    if FCommonData.FOwnerControl <> nil then
      FTheLabel.Parent := FCommonData.FOwnerControl.Parent;

    AlignLabel;
  end;
end;


procedure TsBoundLabel.SetIndent(const Value: integer);
begin
  if FIndent <> Value then begin
    FIndent := Value;
    if Active then
      AlignLabel;
  end;
end;


procedure TsBoundLabel.SetLayout(const Value: TsCaptionLayout);
begin
  if FLayout <> Value then begin
    FLayout := Value;
    UpdateAlignment;
    if Active then
      AlignLabel;
  end;
end;


procedure TsBoundLabel.SetMaxWidth(const Value: integer);
begin
  if FMaxWidth <> Value then begin
    FMaxWidth := Value;
    if Active then
      AlignLabel;
  end;
end;


procedure TsBoundLabel.SetText(const Value: acString);
begin
  if FText <> Value then begin
    FText := Value;
    if Active then begin
      FTheLabel.Caption := Value;
      AlignLabel;
    end;
  end;
end;


procedure TsBoundLabel.SetUseSkin(const Value: boolean);
begin
  if Assigned(FTheLabel) then
    FTheLabel.UseSkinColor := Value;
end;


const
  LayoutsArray: array [TsCaptionLayout] of TAlignment = (taRightJustify, taLeftJustify, taCenter, taRightJustify,
                                                         taLeftJustify,  taLeftJustify, taCenter, taRightJustify);

procedure TsBoundLabel.UpdateAlignment;
begin
  if FTheLabel <> nil then
    TAccessLabel(FTheLabel).Alignment := LayoutsArray[FLayout];
end;


procedure TsBoundLabel.UpdateScale(NewValue: integer);
begin
  MaxWidth := MulDiv(MaxWidth, NewValue, ScalePercent);
  if (FTheLabel <> nil) and Active then
    AlignLabel;

  ScalePercent := NewValue;
end;


procedure TsBoundLabel.UpdateVisibility;
begin
//  if not (csLoading in FCommonData.FOwnerControl.ComponentState) then
    if FActive then begin
      if FTheLabel = nil then
        FTheLabel := TsEditLabel.InternalCreate(FCommonData.FOwnerControl, Self);

      with FTheLabel do begin
        Visible := False;
        FocusControl := TWinControl(FCommonData.FOwnerControl);
        UseHtml := Self.UseHTML;
        Parent := FocusControl.Parent;
        UpdateAlignment;
        Name := FocusControl.Name + 'Label';
        if FText = '' then
          FText := FocusControl.Name;

        Caption := FText;
        Visible := FocusControl.Visible or (csDesigning in ComponentState);
        Enabled := FocusControl.Enabled or FEnabledAlways;
        AutoSize := True;
      end;
      AlignLabel;
    end
    else
      FreeAndNil(FTheLabel);
end;


constructor TacScrollData.Create(AOwner: TsCommonData);
begin
  FOwner := AOwner;
  FScrollWidth := -1;
  FButtonsSize := -1;
end;


procedure TacScrollData.Invalidate;
begin
//
end;


procedure TacScrollData.SetButtonsSize(const Value: integer);
begin
  if FButtonsSize <> Value then begin
    FButtonsSize := Value;
    if (FOwner.FOwnerControl is TWinControl) and not (csLoading in FOwner.FOwnerControl.ComponentState) then
      if TWinControl(FOwner.FOwnerControl).HandleAllocated then
        TrySendMessage(TWinControl(FOwner.FOwnerControl).Handle, WM_NCPAINT, 0, 0);
  end;
end;


procedure TacScrollData.SetScrollWidth(const Value: integer);
begin
  if FScrollWidth <> Value then begin
    FScrollWidth := Value;
    if (FOwner.FOwnerControl is TWinControl) and not (csLoading in FOwner.FOwnerControl.ComponentState) then
      if TWinControl(FOwner.FOwnerControl).HandleAllocated then
        SetWindowPos(TWinControl(FOwner.FOwnerControl).Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
  end;
end;


constructor TsScrollWndData.Create(AOwner: TObject; const CreateCacheBmp: boolean = True);
begin
  inherited;
  FVertScrollData := TacScrollData.Create(Self);
  FHorzScrollData := TacScrollData.Create(Self);
end;


destructor TsScrollWndData.Destroy;
begin
  FreeAndNil(FVertScrollData);
  FreeAndNil(FHorzScrollData);
  inherited;
end;


constructor TacOuterEffects.Create(AOwner: TsCommonData);
begin
  FOwner := AOwner;
  FVisibility := ovNone;
end;


procedure TacOuterEffects.Invalidate;
begin
  if (FOwner.FOwnerControl <> nil) and (FOwner.FOwnerControl.Parent <> nil) then
    with FOwner.FOwnerControl.Parent do
      if HandleAllocated and ([csLoading, csDestroying] * ComponentState = []) then begin
        SendAMessage(Handle, AC_INVALIDATE);
        FOwner.Invalidate;
      end;
end;


procedure TacOuterEffects.SetVisibility(const Value: TacOuterVisibility);
begin
  if FVisibility <> Value then begin
    FVisibility := Value;
    if (FOwner.FOwnerControl <> nil) and not (csLoading in FOwner.FOwnerControl.ComponentState) then
      Invalidate;
  end;
end;


procedure TsBoundLabel.SetAllowClick(const Value: boolean);
begin
  FAllowClick := Value;
  if FTheLabel <> nil then
    if Value then begin
      FTheLabel.OnClick := DoClick;
      FTheLabel.OnDblClick := DoClick;
    end
    else begin
      FTheLabel.OnClick := nil;
      FTheLabel.OnDblClick := nil;
    end;
end;


type
  TAccessControl = class(TControl);


procedure TsBoundLabel.DoClick(Sender: TObject);
begin
  if (FCommonData.FOwnerControl <> nil) and not (csDesigning in FCommonData.FOwnerControl.ComponentState) then
    TAccessControl(FCommonData.FOwnerControl).Click;
end;


procedure TsCommonData.InitCommonProp;
var
  h: THandle;
begin
  h := OwnerHandle;
  if h <> 0 then begin
    if not Assigned(WndProc) then
      if FOwnerControl is TWinControl then
        WndProc := TWinControl(FOwnerControl).WindowProc;

    SetProp(h, acPropStr, Cardinal(Self));
  end;
end;


procedure TsCommonData.RemoveCommonProp;
var
  h: THandle;
begin
  if not Application.Terminated then begin
    h := OwnerHandle;
    if h <> 0 then
      RemoveProp(h, acPropStr);
  end;
end;


procedure TsCommonData.ClearLinks;
begin
  FOwnerControl := nil;
  FOwnerObject := nil;
  FSWHandle := 0;
end;

end.


