unit sCommonData;
{$I sDefs.inc}
//{$DEFINE DEBUG}

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
    FUpdateCount,
    HotTexture: integer;

    PrintDC: hdc;
    FCacheBmp: TBitmap;
    FColorTone: TColor;
    FSWHandle: THandle;
    FOwnerObject: TObject;
    FSkinManager: TsSkinManager;
    AnimTimer: TacThreadedTimer;

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
    FMaxWidth: integer;

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
    function DoStoreFont: boolean;
    constructor Create(AOwner: TObject; const CommonData: TsCommonData);
    destructor Destroy; override;
    procedure HandleOwnerMsg(const Message: TMessage; const OwnerControl: TControl);
  published
{$ENDIF} // NOTFORHELP
    property Active: boolean read FActive write SetActive default False;
    property AllowClick: boolean read FAllowClick write SetAllowClick default False;
    property Caption: acString read FText write SetText;
    property EnabledAlways: boolean read FEnabledAlways write SetEnabledAlways default False;
    property Indent: integer read FIndent write SetIndent default 0;
    property Font: TFont read GetFont write SetFont stored DoStoreFont;
    property Layout: TsCaptionLayout read FLayout write SetLayout default sclLeft;
    property MaxWidth: integer read FMaxWidth write SetMaxWidth default 0;
    property UseHTML: boolean read FUseHTML write SetUseHTML default False;
    property UseSkinColor: boolean read GetUseSkin write SetUseSkin default True;
  end;

{$IFNDEF NOTFORHELP}
var
  C1, C2: TsColor;
  RestrictDrawing: boolean = False;


function WndIsSkinned    (const AHandle: THandle): boolean;
function GetCommonData(const AHandle: hwnd): TsCommonData;

function IsCached(const SkinData: TsCommonData): boolean;

function HaveOuterEffects(SkinData: TsCommonData): boolean;
function InUpdating (const SkinData: TsCommonData; const Reset: boolean = False): boolean;
procedure InitBGInfo(const SkinData: TsCommonData; const PBGInfo: PacBGInfo; const State: integer; Handle: THandle = 0);
function GetBGColor (const SkinData: TsCommonData; const State: integer; const Handle: THandle = 0): TColor;
function GetFontIndex(const Ctrl: TControl; const DefSkinIndex: integer; const SkinManager: TsSkinManager; const State: integer = 0): integer; overload;
function GetFontIndex(const Ctrl: TControl; pInfo: PacPaintInfo): integer; overload;
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
function NeedParentFont(SkinData: TsCommonData): boolean;

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
  sGraphUtils, sAlphaGraph, sSkinProvider, sSpeedButton, sSkinMenus;


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
        Glow := iff(State < 1, 0, MaxByte);
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
    Result := (CtrlSkinState and ACS_FAST <> ACS_FAST) or HaveOuterEffects(SkinData) or (not (COC in sCanNotBeHot) and ControlIsActive(SkinData));
end;


function GetCommonData(const AHandle: hwnd): TsCommonData;
begin
  Result := TsCommonData(GetProp(AHandle, acPropStr));
end;


function WndIsSkinned(const AHandle: THandle): boolean;
begin
  Result := (GetCommonData(AHandle) <> nil) or (Ac_GetScrollWndFromHwnd(AHandle) <> nil) or GetBoolMsg(AHandle, AC_CTRLHANDLED{delete in Beta});
end;


function HaveOuterEffects(SkinData: TsCommonData): boolean;
begin
  if (SkinData.FOwnerObject is TsSkinProvider) or (SkinData.FOwnerControl is TWinControl) then
    Result := SkinData.SkinManager.Effects.AllowOuterEffects
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
      with TsHackedControl(FOwnerControl), SkinManager do begin
        if (FOwnerControl is TWinControl) and not TWinControl(FOwnerControl).HandleAllocated then
          Exit;

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
          SkinData.Invalidate;
      end;
end;


procedure InitBGType(const SkinData: TsCommonData);
begin
  with SkinData do begin
    BGType := 0;
    if (SkinManager <> nil) and (SkinIndex >= 0) then
      with SkinManager.gd[SkinIndex].Props[0] do begin
        if (ImagePercent <> 0) then begin
          if SkinManager.ma[SkinManager.gd[SkinIndex].Props[0].TextureIndex].DrawMode in [1, 4, 5, 8, 9, 11, 12] then
            BGType := BGType or BGT_STRETCH;

          if SkinManager.ma[SkinManager.gd[SkinIndex].Props[0].TextureIndex].DrawMode in [0, 1, 3, 5, 10, 12] then
            BGType := BGType or BGT_TEXTURELEFT;

          if SkinManager.ma[SkinManager.gd[SkinIndex].Props[0].TextureIndex].DrawMode in [0, 1, 7, 9, 10, 12] then
            BGType := BGType or BGT_TEXTURERIGHT;

          if SkinManager.ma[SkinManager.gd[SkinIndex].Props[0].TextureIndex].DrawMode in [0, 1, 2, 4, 10, 11] then
            BGType := BGType or BGT_TEXTURETOP;

          if SkinManager.ma[SkinManager.gd[SkinIndex].Props[0].TextureIndex].DrawMode in [0, 1, 6, 8, 10, 11] then
            BGType := BGType or BGT_TEXTUREBOTTOM;
        end;

        if (GradientPercent <> 0) and (Length(GradientArray) > 0) then
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
      with SkinManager.gd[SkinIndex] do begin
        if ((FOwnerControl is TWinControl) or (FOwnerObject is TsSkinProvider)) and SkinManager.Effects.AllowOuterEffects then
          Exit;

        if (BorderIndex > -1) then // If border exists
          if (SkinManager.ma[BorderIndex].DrawMode and BDM_FILL = BDM_FILL) or (SkinManager.ma[BorderIndex].MaskType = 1) then
            Exit; // If center image is drawn by border mask

        if (Props[0].Transparency = 100) then begin // Get cachestate of the parent
          if (SkinManager.gd[SkinIndex].Props[0].TextureIndex >= 0) then
            if acFillModes[SkinManager.ma[SkinManager.gd[SkinIndex].Props[0].TextureIndex].DrawMode] = fmDisTiled then
              Exit; // If special texture used

          if Assigned(FOwnerControl) and Assigned(FOwnerControl.Parent) { and SkinData.Skinned} then
            if not FOwnerControl.Parent.HandleAllocated then // If parent is not ready
              Result := ACS_BGUNDEF
            else
              if SendAMessage(FOwnerControl.Parent, AC_CTRLHANDLED) <> 1 then // If parent is not skinned
                Result := ACS_FAST
              else
                Result := SendAMessage(FOwnerControl.Parent, AC_GETSKINSTATE);
        end
        else
          if (Props[0].Transparency = 0) {If control is semi-transparent} then
            if (SkinManager.gd[SkinIndex].Props[0].ImagePercent = 0) and (SkinManager.gd[SkinIndex].Props[0].GradientPercent = 0) then begin
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
          FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_PREPARECACHE), 0);

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
                if IsValidImgIndex(BorderIndex) and (ma[BorderIndex].DrawMode and BDM_ACTIVEONLY <> BDM_ACTIVEONLY) then begin
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
              if (CtrlSkinState and ACS_FAST <> ACS_FAST) and (FCacheBmp <> nil) then begin
                if BGChanged and (FOwnerControl <> nil) then
                  FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_PREPARECACHE), 0);

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

              if (Parent <> nil) then begin
                GetBGInfo(PBGInfo, Parent, PBGInfo^.PleaseDraw);
                if (PBGInfo^.Bmp <> nil) then begin // BgType = btCache or Bmp is assigned
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
                    FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_PREPARECACHE), 0);

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
            PBGInfo^.Color := ColorToRGB(TsHackedControl(SkinData.FOwnerControl).Color)
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
      Result := TsHackedControl(SkinData.FOwnerControl).Color
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
              Result := MixColors(c, GetControlColor(FOwnerControl.Parent), i / 100)
            else
              if Handle <> 0 then
                Result := MixColors(c, GetControlColor(GetParent(Handle)), i / 100)
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
  if (Ctrl <> nil) {and (Ctrl.Parent <> nil) and (State = 0) }then begin
    pi.SkinManager := SkinManager;
    pi.R := Ctrl.BoundsRect;
    i := Ctrl.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETFONTINDEX), LParam(@pi));
//    i := SendAMessage(Ctrl, AC_GETFONTINDEX, LParam(@pi));
{
    if (Ctrl is TWinControl) and TWinControl(Ctrl).HandleAllocated then
      i := SendMessage(TWinControl(Ctrl).Handle, SM_ALPHACMD, MakeWParam(0, AC_GETFONTINDEX), LParam(@pi))
    else
      i := Ctrl.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETFONTINDEX), LParam(@pi));
}
    if i <> 0 then
      Result := pi.FontIndex;
  end;
end;


function GetFontIndex(const Ctrl: TControl; pInfo: PacPaintInfo): integer;
begin
//  if (Ctrl is TCustomForm)
  if Ctrl.Parent <> nil then
    OffsetRect(pInfo.R, Ctrl.Left, Ctrl.Top);

  Result := Ctrl.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETFONTINDEX), LParam(pInfo))
{
  if (Ctrl is TWinControl) and TWinControl(Ctrl).HandleAllocated then
    Result := SendMessage(TWinControl(Ctrl).Handle, SM_ALPHACMD, MakeWParam(0, AC_GETFONTINDEX), LParam(pInfo))
  else
    if (Ctrl is TGraphicControl) then
      Result := Ctrl.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETFONTINDEX), LParam(pInfo))
    else
      Result := 0;
}
end;


function ParentTextured(const SkinData: TsCommonData): boolean;
begin
  if Assigned(SkinData.FOwnerControl) and Assigned(SkinData.FOwnerControl.Parent) and SkinData.FOwnerControl.Parent.HandleAllocated then
    Result := GetBoolMsg(SkinData.FOwnerControl.Parent, AC_CHILDCHANGED)
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
        if (FOwnerControl <> nil) then begin
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

                if (SkinData.GlowID < 0) then // Show a glowing effect
                  if (FOwnerControl is TWinControl) then begin
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
    ChangeBitmapPixels(Bmp, ChangeColorSaturation, LimitIt(Trunc(SkinData.Saturation * 2.55), -MaxByte, MaxByte), clFuchsia);

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
  if (SkinData.BorderIndex > -1) and (SkinData.SkinManager.ma[SkinData.BorderIndex].DrawMode and BDM_ACTIVEONLY <> BDM_ACTIVEONLY) then
    with SkinData.SkinManager.ma[SkinData.BorderIndex] do begin
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
        FOwnerControl.Parent.Perform(SM_ALPHACMD, MakeWParam(1, AC_SETBGCHANGED), 0);
        FOwnerControl.Parent.Perform(SM_ALPHACMD, MakeWParam(1, AC_PREPARECACHE), 0);
//        SendMessage(FOwnerControl.Parent.Handle, SM_ALPHACMD, MakeWParam(1, AC_SETBGCHANGED), 0);
//        SendAMessage(FOwnerControl.Parent.Handle, AC_PREPARECACHE);
      end;
end;


procedure InitIndexes(const SkinData: TsCommonData; const Sections: array of string);
var
  i: integer;
begin
  if SkinData.SkinManager <> nil then
    for i := 0 to Length(Sections) - 1 do begin
      if Sections[i] <> '' then begin
        SkinData.SkinIndex := SkinData.SkinManager.GetSkinIndex(Sections[i]);
        if SkinData.SkinIndex >= 0 then begin
          SkinData.UpdateIndexes(False);
          Exit;
        end;
      end
    end
  else
    SkinData.SkinIndex := -1;
end;


procedure UpdateData(const SkinData: TsCommonData);
begin
  with SkinData do begin
    if (FOwnerControl <> nil) and (csDesigning in FOwnerControl.ComponentState) then
      if FSkinSection = 'RADIOBUTTON' then // Remove in v11
        FSkinSection := s_Transparent;

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
      with TsHackedControl(FOwnerControl) do begin
        if not AllowRepaint then
          Perform(WM_SETREDRAW, 0, 0);

        State := integer(ControlIsActive(SkinData));
        if not CustomColor and (SkinIndex >= 0) then
          Color := SkinManager.gd[SkinIndex].Props[State].Color;

        if not CustomFont and (SkinIndex >= 0) and (Font.Color <> SkinManager.gd[SkinIndex].Props[State].FontColor.Color) then begin
          SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_CHANGING;
          Font.Color := SkinManager.gd[SkinIndex].Props[State].FontColor.Color;
          SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_CHANGING;
        end;

        if not AllowRepaint then
          Perform(WM_SETREDRAW, 1, 0);
      end;
end;


procedure UpdateSkinState(const SkinData: TsCommonData; const UpdateChildren: boolean = True);
var
  i: integer;
begin
  SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_FAST;
  if SkinData.FOwnerControl <> nil then begin
    if ((SkinData.FOwnerControl is TFrame) or
          (SkinData.FOwnerControl is TPanel) or
            (SkinData.FOwnerControl is TScrollingWinControl) or
              (SkinData.FOwnerControl is TPageControl)) and
                not TPanel(SkinData.FOwnerControl).DockSite then begin
      i := IsCacheRequired(SkinData);
      if i <> ACS_BGUNDEF then begin
        if i and ACS_FAST = ACS_FAST then
          SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_FAST
        else
          SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_FAST;

        SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_BGUNDEF;
      end
      else
        Exit;
    end;
    if UpdateChildren and (SkinData.FOwnerControl is TWinControl) then
      with TWinControl(SkinData.FOwnerControl) do
        for i := 0 to ControlCount - 1 do
          SendAMessage(Controls[i], AC_GETSKINSTATE, 1);
  end
  else
    if SkinData.FOwnerObject is TsSkinProvider then begin
      i := IsCacheRequired(SkinData);
      if i <> ACS_BGUNDEF then
        if i and ACS_FAST = ACS_FAST then begin
          if TsSkinProvider(SkinData.FOwnerObject).Form.FormStyle <> fsMDIForm then
            SkinData.CtrlSkinState := SkinData.CtrlSkinState or ACS_FAST;

          SkinData.CtrlSkinState := SkinData.CtrlSkinState and not ACS_BGUNDEF;
        end
        else
          SkinData.CtrlSkinState := 0;
    end;
end;


function ControlIsActive(const SkinData: TsCommonData): boolean;
begin
  Result := False;
  if SkinData <> nil then
    with SkinData do
      if Assigned(FOwnerControl) and not (csDestroying in FOwnerControl.ComponentState) then
        if FOwnerControl.Enabled and not (csDesigning in FOwnerControl.ComponentState) then
          if FFocused then
            Result := True
          else
            if (FOwnerControl is TWinControl) and TWinControl(SkinData.FOwnerControl).HandleAllocated and (TWinControl(FOwnerControl).Handle = GetFocus) then
              Result := not (FOwnerControl is TCustomPanel)
            else
              if SkinData.FMouseAbove and not (Assigned(SkinData.SkinManager) and SkinData.SkinManager.Options.NoMouseHover) then
                Result := not (SkinData.COC in sForbidMouse) and (not (SkinData.COC in sNoHotEdits) or ac_AllowHotEdits);
end;


procedure TsCommonData.BeginUpdate;
begin
  Inc(FUpdateCount);
  Updating := True;
  CtrlSkinState := CtrlSkinState or ACS_LOCKED;
  if FOwnerControl <> nil then
    FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_BEGINUPDATE), 0)
  else
    if FOwnerObject is TsSkinProvider then
      SendMessage(TsSkinProvider(FOwnerObject).Form.Handle, SM_ALPHACMD, MakeWParam(0, AC_BEGINUPDATE), 0);
end;


constructor TsCommonData.Create(AOwner: TObject; const CreateCacheBmp: boolean);
begin
  SkinIndex := -1;
  BorderIndex := -1;
  GlowID := -1;
  Texture := -1;
  HotTexture := -1;
  AnimTimer := nil;
  FSWHandle := 0;
  if AOwner is TControl then
    FOwnerControl := TControl(AOwner)
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

  if Assigned(FCacheBmp) then
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
  If FUpdateCount <= 0 then begin
    if FOwnerControl <> nil then
      FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_ENDUPDATE), 0)
    else
      if FOwnerObject is TsSkinProvider then
        SendMessage(TsSkinProvider(FOwnerObject).Form.Handle, SM_ALPHACMD, MakeWParam(0, AC_ENDUPDATE), 0);

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
  if (Self = nil) then
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
        if (FOwnerControl <> nil) then begin
          if not (csDestroying in FOwnerControl.ComponentState) then
            if FUpdating then
              Result := True
            else
              if (FOwnerControl.Parent <> nil) then
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
var
  Flags: Cardinal;
begin
  if not Loading then begin
    if Assigned(FOwnerControl) then begin
      if not ((csDestroying in FOwnerControl.ComponentState) or (csLoading in FOwnerControl.ComponentState)) then begin
        BGChanged := True;
        if ControlIsReady(FOwnerControl) then
          if not (FOwnerControl is TWinControl) then
            FOwnerControl.Repaint
          else
            if TWinControl(FOwnerControl).HandleAllocated then begin
              Flags := RDW_FRAME or RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN;
              if UpdateNow then
                Flags := Flags or RDW_UPDATENOW;

              RedrawWindow(TWinControl(FOwnerControl).Handle, nil, 0, Flags);
            end;
      end;
    end
    else
      if FOwnerObject is TsSkinProvider then begin
        BGChanged := True;
        if TsSkinProvider(FOwnerObject).Form.HandleAllocated then begin
          Flags := RDW_FRAME or RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN;
          if UpdateNow then
            Flags := Flags or RDW_UPDATENOW;

          RedrawWindow(TsSkinProvider(FOwnerObject).Form.Handle, nil, 0, Flags);
        end;
      end;
  end;
end;


procedure TsCommonData.Loaded(UpdateColors: boolean = True);
begin
  Loading := False;
  UpdateData(Self);
  if Skinned and Assigned(FOwnerControl) and Assigned(FOwnerControl.Parent) and not (csLoading in FOwnerControl.ComponentState) then begin
    if FOwnerControl is TWinControl then
      AddToAdapter(TWinControl(FOwnerControl));

    if UpdateColors then
      UpdateCtrlColors(Self, False);
  end;
end;


function TsCommonData.ManagerStored: boolean;
begin
  Result := (FSkinManager <> nil)
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
  if (OuterEffects.Visibility = ovNone) and Skinned or not Skinned or (SkinIndex >= Length(SkinManager.gd)) then
    Exit;

  mNdx := SkinManager.gd[SkinIndex].OuterMask;
  if mNdx < 0 then begin
    if SkinManager.gd[SkinIndex].OuterMode <= 0 then
      Exit;

    Ndx := SkinManager.gd[SkinIndex].OuterMode - 1;
    if SkinManager.oe[Ndx].Source = 0 then
      Exit;

    with SkinManager.oe[Ndx] do begin
      mNdx := Mask;
      oRect := Rect(OffsetL, OffsetT, OffsetR, OffsetB);
      op := Opacity;
    end;
    if mNdx < 0 then
      Exit;
  end
  else begin
    oRect := SkinManager.gd[SkinIndex].OuterOffset;
    op := SkinManager.gd[SkinIndex].OuterOpacity;
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
    if (Data and USECACHE = USECACHE) and (FOuterCache <> nil) then begin
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
        OwnerCtrl.Controls[I].Perform(SM_ALPHACMD, MakeWParam(0, AC_PAINTOUTER), LPARAM(@BGInfo));

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
      UpdateCtrlColors(Self, True);
  end;
end;


procedure TsCommonData.SetCustomFont(const Value: boolean);
begin
  if FCustomFont <> Value then begin
    FCustomFont := Value;
    if (FOwnerControl <> nil) and not (csLoading in FOwnerControl.ComponentState) and not Loading then
      UpdateCtrlColors(Self, True);
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

    if (FOwnerControl <> nil) and (csLoading in FOwnerControl.ComponentState) then
      Exit;

    if Assigned(Value) and (Length(Value.gd) > 0) then
      UpdateIndexes
    else
      SkinIndex := -1;

    if not Assigned(FOwnerObject) or not (FOwnerObject is TsSkinProvider) then
      if (FOwnerControl <> nil) and (FOwnerControl.Parent <> nil) and not (csDestroying in FOwnerControl.ComponentState) then
        if Assigned(Value) and (Length(Value.gd) > 0) and Value.IsValidSkinIndex(SkinIndex) then
          FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_REFRESH), LongWord(Value))
        else
          FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_REMOVESKIN), LongWord(Value));
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

    if (FOwnerControl <> nil) and not (csLoading in FOwnerControl.ComponentState) and not (csReading in FOwnerControl.ComponentState) and
         (FOwnerControl.Parent <> nil) and not (csDestroying in FOwnerControl.ComponentState) then begin

      if FOwnerControl is TWinControl then begin
        if FCacheBmp <> nil then
          FCacheBmp.Width := 0;

        m := MakeMessage(SM_ALPHACMD, MakeWParam(1, AC_SETBGCHANGED), 0, 0);
        AlphaBroadCast(TWinControl(FOwnerControl), m);
      end;
      if not FUpdating and not Loading then
        if Assigned(SkinManager) and (Length(SkinManager.gd) > 0) and SkinManager.IsValidSkinIndex(SkinIndex) then
          FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(1, AC_REFRESH), LongWord(SkinManager))
        else
          FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_REMOVESKIN), LongWord(SkinManager))
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
  Result := False;
  try
    SM := SkinManager;
    if (SM <> nil) and not (csDestroying in SM.ComponentState) and SM.IsValidSkinIndex(SkinIndex) then begin
      if (Self.FOwnerObject <> nil) and (csDestroying in TComponent(Self.FOwnerObject).ComponentState) then
        Exit;

      if CheckSkinActive then
        Result := SkinManager.CommonSkinData.Active
      else
        Result := True;
    end;
  except
    Result := False;
  end;
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


function NeedParentFont(SkinData: TsCommonData): boolean;
begin
  Result := (SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].Transparency > 50) and
            ((SkinData.BorderIndex < 0) or
             (SkinData.SkinManager.ma[SkinData.BorderIndex].DrawMode and BDM_FILL <> BDM_FILL) or
             (SkinData.SkinManager.ma[SkinData.BorderIndex].DrawMode and BDM_ACTIVEONLY = BDM_ACTIVEONLY)) and
            (SkinData.FOwnerControl.Parent <> nil);
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
          AC_REINITSCROLLS:
            if FOwnerControl is TWinControl then
              with TWinControl(FOwnerControl) do begin
                if HandleAllocated then
                  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOCOPYBITS or SWP_NOSENDCHANGING or SWP_NOREPOSITION or SWP_FRAMECHANGED);

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
            if SkinData.Skinned then
              with SkinData.SkinManager.gd[SkinData.SkinIndex] do
                if NeedParentFont(SkinData) then
                  Message.Result := GetFontIndex(SkinData.FOwnerControl.Parent, PacPaintInfo(Message.LParam))
                else
                  if GiveOwnFont then begin
                    PacPaintInfo(Message.LParam)^.FontIndex := SkinData.SkinIndex; {Remove "GiveOwnFont" with updating of all skins}
                    Message.Result := 1;
                  end;
{                  else
                    Message.Result := 0
            else

              if FOwnerControl <> nil then begin
                PacPaintInfo(Message.LParam)^.FontIndex := ColorToRGB(TsHackedControl(FOwnerControl).Font.Color);
                Message.Result := 1;
              end
              else

              Message.Result := 0;}

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
            if (ACUInt(Message.LParam) = ACUInt(SkinManager)) then begin
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
            if (ACUInt(Message.LParam) = ACUInt(SkinManager)) then begin
              StopTimer(SkinData);
              BGChanged := True;
              Updating := False;
              UpdateCtrlColors(SkinData, True);
              UpdateSkinState(SkinData, False);
              if (COC in ssScrolledEdits) and (FOwnerControl is TWinControl) then
                SetWindowPos(TWinControl(FOwnerControl).Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_FRAMECHANGED);
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
                if (FOwnerControl is TCustomEdit) then begin
                  if not CustomColor then
                    TsHackedControl(FOwnerControl).Color := clWindow;

                  if not CustomFont then
                    TsHackedControl(FOwnerControl).Font.Color := clWindowText;

                  RedrawWindow(TCustomEdit(FOwnerControl).Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);
                end
                else
                  if (FOwnerControl is TWinControl) then
                    for i := 0 to TWinControl(FOwnerControl).ControlCount - 1 do
                      if TWinControl(FOwnerControl).Controls[i] is TLabel then
                        TLabel(TWinControl(FOwnerControl).Controls[i]).Font.Color := clWindowText;
              end;
            end;

          AC_GETCONTROLCOLOR:
            if Assigned(FOwnerControl) then
              if Skinned then
                case SkinManager.gd[SkinIndex].Props[0].Transparency of
                  0:
                    Message.Result := SkinManager.gd[SkinIndex].Props[0].Color;

                  100:
                    if FOwnerControl.Parent <> nil then
                      if GetBoolMsg(FOwnerControl.Parent, AC_CTRLHANDLED) then
                        Message.Result := SendMessage(FOwnerControl.Parent.Handle, SM_ALPHACMD, MakeWParam(0, AC_GETCONTROLCOLOR), 0)
                      else
                        Message.Result := TsHackedControl(FOwnerControl.Parent).Color
                    else
                      Message.Result := ColorToRGB(TsHackedControl(FOwnerControl).Color);

                  else begin
                    if FOwnerControl.Parent <> nil then
                      Message.Result := SendMessage(FOwnerControl.Parent.Handle, SM_ALPHACMD, MakeWParam(0, AC_GETCONTROLCOLOR), 0)
                    else
                      Message.Result := ColorToRGB(TsHackedControl(FOwnerControl).Color);
                    // Mixing of colors
                    C1.C := Message.Result;
                    with SkinManager.gd[Skinindex].Props[0] do begin
                      C2.C := Color;
                      C1.R := ((C1.R - C2.R) * Transparency + C2.R shl 8) shr 8;
                      C1.G := ((C1.G - C2.G) * Transparency + C2.G shl 8) shr 8;
                      C1.B := ((C1.B - C2.B) * Transparency + C2.B shl 8) shr 8;
                    end;
                    Message.Result := C1.C;
                  end
                end
              else
                Message.Result := ColorToRGB(TsHackedControl(FOwnerControl).Color);

          AC_SETCHANGEDIFNECESSARY: begin
            b := RepaintIfMoved;
            BGChanged := BGChanged or b;
            if FOwnerControl is TWinControl then begin
              if (Message.WParamLo = 1) then
                RedrawWindow(TWinControl(FOwnerControl).Handle, nil, 0, RDW_NOERASE + RDW_NOINTERNALPAINT + RDW_INVALIDATE + RDW_ALLCHILDREN);

              if b and Assigned(FOwnerControl) then
                for i := 0 to TWinControl(FOwnerControl).ControlCount - 1 do
                  if (i < TWinControl(FOwnerControl).ControlCount) and not (csDestroying in TWinControl(FOwnerControl).Controls[i].ComponentState) then
                    TWinControl(FOwnerControl).Controls[i].Perform(SM_ALPHACMD, MakeWParam(1, AC_SETCHANGEDIFNECESSARY), 0);
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
            PacSectionInfo(Message.LParam)^.SkinIndex := SkinIndex;

          AC_PREPARECACHE:
            SkinData.BGChanged := False;

          AC_ENDPARENTUPDATE:
            if FUpdating and (FOwnerControl is TWinControl) then begin
              if not InUpdating(SkinData, True) then
                RedrawWindow(TWinControl(FOwnerControl).Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_UPDATENOW);

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
              SkinSection := PacSectionInfo(Message.LParam).Name;
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
            SkinIndex := FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETDEFINDEX), 0) - 1
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
  Handle: THandle;
begin
  Result := False;
  if sd.FOwnerControl is TWinControl then begin
    Handle := TWinControl(sd.FOwnerControl).Handle;
    if IsWindowVisible(Handle) then begin
      wR := sd.FOwnerControl.ClientRect;
      p := sd.FOwnerControl.ScreenToClient(acMousePos);
    end
    else
      Exit;
  end
  else begin
    Handle := sd.OwnerHandle;
    if (Handle <> 0) and IsWindowVisible(Handle) then begin
      GetWindowRect(Handle, wR);
      GetClientRect(Handle, cR);
      p := acMousePos;
      p.X := p.X - wR.Left;
      p.Y := p.Y - wR.Top;
      wR := MkRect(WidthOf(cR), HeightOf(cR));
    end
    else
      Exit;
  end;
  sw := TacMainWnd(SendAMessage(Handle, AC_GETLISTSW));
  if (sw is TacScrollWnd) then begin
    if TacScrollWnd(sw).sBarHorz.fScrollVisible then
      inc(wR.Bottom, integer(TacScrollWnd(sw).sbarHorz.fScrollVisible) * GetScrollMetric(TacScrollWnd(sw).sbarHorz, SM_SCROLLWIDTH));

    if TacScrollWnd(sw).sBarVert.fScrollVisible then
      inc(wR.Right, integer(TacScrollWnd(sw).sbarVert.fScrollVisible) * GetScrollMetric(TacScrollWnd(sw).sbarVert, SM_SCROLLWIDTH));
  end;
  Result := PtInRect(wR, p);
  if Result and (Handle <> 0) then begin // Check if part of control is not visible
    DC := GetDC(Handle);
    GetClipBox(DC, wR);
    Result := PtInRect(wR, p);
    ReleaseDC(Handle, DC);
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
    if (sw is TacScrollWnd) then begin
      if TacScrollWnd(sw).sBarHorz.fScrollVisible then
        inc(wR.Bottom, integer(TacScrollWnd(sw).sbarHorz.fScrollVisible) * GetScrollMetric(TacScrollWnd(sw).sbarHorz, SM_SCROLLWIDTH));

      if TacScrollWnd(sw).sBarVert.fScrollVisible then
        inc(wR.Right, integer(TacScrollWnd(sw).sbarVert.fScrollVisible) * GetScrollMetric(TacScrollWnd(sw).sbarVert, SM_SCROLLWIDTH));
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
          if (FOwnerControl <> nil) and (TsHackedControl(FOwnerControl).PopupMenu <> nil) and (SkinManager <> nil) then
            SkinManager.SkinableMenus.HookPopupMenu(TsHackedControl(FOwnerControl).PopupMenu, SkinManager.Active);
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
                      Controls[i].Perform(SM_ALPHACMD, MakeWPAram(0, Word(AC_CLEARCACHE)), 0);
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
          if (FOwnerControl is TWinControl) and ((Message.WParam and $FFFF) in [WM_CREATE, WM_DESTROY]) and (Message.WParamLo = WM_CREATE) then
            AddToAdapter(TWinControl(FOwnerControl));

        WM_SETFOCUS:
          if (FOwnerControl is TWinControl) and
                Skinned and
                  TWinControl(FOwnerControl).CanFocus and
                    TWinControl(FOwnerControl).TabStop and
                      not ((SkinManager.gd[SkinIndex].Props[0].Transparency = 100) and
                        (SkinManager.gd[SkinIndex].Props[1].Transparency = 100)) then begin
            BGChanged := True;
            FFocused := True;
            if (COC in sEditCtrls) and (SkinManager.gd[SkinIndex].States > 1) then begin
              BGChanged := True;
              b := False;
              if (TsHackedControl(FOwnerControl).Color <> SkinManager.gd[SkinIndex].Props[1].Color) and not CustomColor then begin
                TsHackedControl(FOwnerControl).Color := SkinManager.gd[SkinIndex].Props[1].Color;
                b := True;
              end;
              if (TsHackedControl(FOwnerControl).Font.Color <> SkinManager.gd[SkinIndex].Props[1].FontColor.Color) and not CustomFont then begin
                CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                TsHackedControl(FOwnerControl).Font.Color := SkinManager.gd[SkinIndex].Props[1].FontColor.Color;
                CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                b := True;
              end;
              if b then
                InvalidateRect(TWinControl(FOwnerControl).Handle, nil, True);

              SendMessage(TWinControl(FOwnerControl).Handle, WM_NCPAINT, 0, 0);
            end;
          end;

        WM_KILLFOCUS:
          if (FOwnerControl is TWinControl) and
               Skinned and
                 TWinControl(FOwnerControl).CanFocus and
                   not ((SkinManager.gd[SkinIndex].Props[0].Transparency = 100) and (SkinManager.gd[SkinIndex].Props[1].Transparency = 100)) then begin
            BGChanged := True;
            FFocused := False;
            b := False;
            if (COC in sEditCtrls) and not ControlIsActive(SkinData) then begin
              if (TsHackedControl(FOwnerControl).Color <> SkinManager.gd[SkinIndex].Props[0].Color) and not CustomColor then begin
                TsHackedControl(FOwnerControl).Color := SkinManager.gd[SkinIndex].Props[0].Color;
                b := True;
              end;
              if (TsHackedControl(FOwnerControl).Font.Color <> SkinManager.gd[SkinIndex].Props[0].FontColor.Color) and not CustomFont then begin
                CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                TsHackedControl(FOwnerControl).Font.Color := SkinManager.gd[SkinIndex].Props[0].FontColor.Color;
                CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                b := True;
              end;
            end;
            if FOwnerControl.Visible and (COC in sEditCtrls) then begin
              BGChanged := True;
              if b then
                InvalidateRect(TWinControl(FOwnerControl).Handle, nil, True);

              SendMessage(TWinControl(FOwnerControl).Handle, WM_NCPAINT, 0, 0);
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
          if SkinData.Skinned and not SkinData.FMouseAbove and not (csDesigning in SkinData.SkinManager.ComponentState) and
               not SkinData.SkinManager.Options.NoMouseHover and
                 not ((SkinData.SkinManager.gd[SkinIndex].Props[0].Transparency = 100) and (SkinManager.gd[SkinIndex].Props[1].Transparency = 100)) then
            if (FOwnerControl is TWinControl) and (DefaultManager <> nil) then
              with TWinControl(FOwnerControl) do begin
                if csDesigning in ComponentState then
                  Exit;

                for i := 0 to ControlCount - 1 do
                  if (Controls[i] is TsSpeedButton) and (Controls[i] <> FOwnerControl) and
                       (Controls[i] <> Pointer(Message.LParam)) and TsSpeedButton(Controls[i]).SkinData.FMouseAbove then
                    Controls[i].Perform(CM_MOUSELEAVE, 0, 0);

                if not (COC in sForbidMouse) then // and (not (SkinData.COC in sNoHotEdits) or ac_AllowHotEdits) then
                  FMouseAbove := True;

                DefaultManager.ActiveControl := TWinControl(FOwnerControl).Handle;
                if not (COC in sCanNotBeHot) and not (COC in [COC_TsButton, COC_TsBitBtn, COC_TsSpeedButton]) then
                  ShowGlowingIfNeeded(SkinData, False, TWinControl(FOwnerControl).Handle, MaxByte * integer(not SkinData.SkinManager.Effects.AllowAnimation), True);

                if (COC in sEditCtrls) and (not (SkinData.COC in sNoHotEdits) or ac_AllowHotEdits) and (SkinManager.gd[SkinIndex].States > 1) then begin
                  BGChanged := True;
                  b := False;
                  if (TsHackedControl(FOwnerControl).Color <> SkinManager.gd[SkinIndex].Props[1].Color) and not CustomColor then begin
                    TsHackedControl(FOwnerControl).Color := SkinManager.gd[SkinIndex].Props[1].Color;
                    b := True;
                  end;
                  if (TsHackedControl(FOwnerControl).Font.Color <> SkinManager.gd[SkinIndex].Props[1].FontColor.Color) and not CustomFont then begin
                    CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                    TsHackedControl(FOwnerControl).Font.Color := SkinManager.gd[SkinIndex].Props[1].FontColor.Color;
                    CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                    b := True;
                  end;
                  if b then
                    InvalidateRect(TWinControl(FOwnerControl).Handle, nil, True);

                  SendMessage(TWinControl(FOwnerControl).Handle, WM_NCPAINT, 0, 0);
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
          if (FOwnerControl <> nil) and Skinned and not SkinManager.Options.NoMouseHover then
            if not (csDesigning in FOwnerControl.ComponentState) and not acMouseInControl(SkinData) then begin
              if not (COC in sForbidMouse) then
                FMouseAbove := False;

              if not (COC in sCanNotBeHot) and not (COC in [COC_TsButton, COC_TsBitBtn, COC_TsSpeedButton]) then
                HideGlow(GlowID, True);

              b := False;
              if (COC in sEditCtrls) and not ControlIsActive(SkinData) and not ((SkinManager.gd[SkinIndex].Props[0].Transparency = 100) and (SkinManager.gd[SkinIndex].Props[1].Transparency = 100)) then begin
                if (TsHackedControl(FOwnerControl).Color <> SkinManager.gd[SkinIndex].Props[0].Color) and not CustomColor then begin
                  TsHackedControl(FOwnerControl).Color := SkinManager.gd[SkinIndex].Props[0].Color;
                  b := True;
                end;
                if (TsHackedControl(FOwnerControl).Font.Color <> SkinManager.gd[SkinIndex].Props[0].FontColor.Color) and not CustomFont then begin
                  CtrlSkinState := CtrlSkinState or ACS_CHANGING;
                  TsHackedControl(FOwnerControl).Font.Color := SkinManager.gd[SkinIndex].Props[0].FontColor.Color;
                  CtrlSkinState := CtrlSkinState and not ACS_CHANGING;
                  b := True;
                end;
              end;
              if FOwnerControl.Visible and (COC in sEditCtrls) then begin
                BGChanged := True;
                if b then
                  InvalidateRect(TWinControl(FOwnerControl).Handle, nil, True);

                SendMessage(TWinControl(FOwnerControl).Handle, WM_NCPAINT, 0, 0);
              end;
            end;

        WM_SIZE:
          if Skinned then begin
            BGChanged := True;
            if OuterEffects.Visibility in [ovAlways] then
              InvalidateParentCache(SkinData);
            // Add "FullRepaintOnly(SkinData, ssHorizontal)" for optimizing (in Beta)
{$IFNDEF ALITE}
            if (FOwnerControl is TsPageControl) then begin
              if Skinned and (Length(SkinManager.gd) > SkinIndex) and
                (SkinManager.gd[SkinIndex].Props[0].GradientPercent > 0) and
                  (TsPageControl(FOwnerControl).ActivePage <> nil) then

                for i := 0 to TsPageControl(FOwnerControl).ActivePage.ControlCount - 1 do
                  if (i < TsPageControl(FOwnerControl).ActivePage.ControlCount) and not (csDestroying in TsPageControl(FOwnerControl).ActivePage.Controls[i].ComponentState) then
                    TsPageControl(FOwnerControl).ActivePage.Controls[i].Perform(SM_ALPHACMD, MakeWParam(1, AC_SETCHANGEDIFNECESSARY), 0);
            end
            else
{$ENDIF}
              if (FOwnerControl is TWinControl) then
                if Skinned and (Length(SkinManager.gd) > SkinIndex) and (SkinManager.gd[SkinIndex].Props[0].GradientPercent > 0) then
                  for i := 0 to TWinControl(FOwnerControl).ControlCount - 1 do
                    if (i < TWinControl(FOwnerControl).ControlCount) and not (csDestroying in TWinControl(FOwnerControl).Controls[i].ComponentState) then
                      TWinControl(FOwnerControl).Controls[i].Perform(SM_ALPHACMD, MakeWParam(1, AC_SETCHANGEDIFNECESSARY), 0);
            if (SkinData.AnimTimer = nil) or not SkinData.AnimTimer.Enabled then
              HideGlow(GlowID);
          end;

        WM_SHOWWINDOW:
          StopTimer(SkinData);

        WM_MOVE: if Skinned then begin
          if OuterEffects.Visibility in [ovAlways] then
            InvalidateParentCache(SkinData);

          if RepaintIfMoved then begin
            BGChanged := True;
            if (FOwnerControl <> nil) then
              FOwnerControl.Perform(SM_ALPHACMD, MakeWParam(1, AC_SETCHANGEDIFNECESSARY), 0);
          end;
          HideGlow(GlowID);
        end;
      end;
end;


procedure CopyWinControlCache(const Control: TWinControl; const SkinData: TsCommonData; const SrcRect, DstRect: TRect; const DstDC: HDC;
                              const UpdateCorners: boolean; const OffsetX: integer = 0; const OffsetY: integer = 0);
var
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
        if (Control.Controls[i] is TGraphicControl) and StdTransparency {$IFNDEF ALITE}or (Control.Controls[i] is TsSplitter){$ENDIF} then
          Continue;

        if Child.Visible and (Child.Left < DstRect.Right) and (Child.Top < DstRect.Bottom) and (Child.Left + Child.Width > DstRect.Left) and (Child.top + Child.Height > DstRect.Top) then
          if (csDesigning in Child.ComponentState) or (csOpaque in Child.ControlStyle) or (Control.Controls[i] is TGraphicControl) then
            ExcludeClipRect(DstDC, Child.Left + OffsetX, Child.Top + OffsetY, Child.Left + Child.Width + OffsetX, Child.Top + Child.Height + OffsetY);
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
    while (hctrl <> 0) do begin
      if IsWindowVisible(hctrl) then begin
        GetWindowRect(hctrl, hR);
        OffsetRect(hR, -R.Left - OffsetX, -R.Top - OffsetY);
        if (GetWindowLong(hctrl, GWL_STYLE) and BS_GROUPBOX = BS_GROUPBOX) and
             (GetWindowLong(hctrl, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> WS_EX_CLIENTEDGE) {Prevent of Treeview filling} then begin

          if DefaultManager <> nil then begin
            Index := DefaultManager.GetMaskIndex(DefaultManager.ConstData.Sections[ssGroupBox], s_BordersMask);
            ExcludeClipRect(DstDC, hR.Left, hR.Top, hR.Right, hR.Top + SendAMessage(hctrl, AC_GETSERVICEINT));
            ExcludeClipRect(DstDC, hR.Left, hR.Top, hR.Left + DefaultManager.MaskWidthLeft(Index), hR.Bottom);
            ExcludeClipRect(DstDC, hR.Right - DefaultManager.MaskWidthRight(Index), hR.Top, hR.Right, hR.Bottom);
            ExcludeClipRect(DstDC, hR.Left, hR.Bottom - DefaultManager.MaskWidthBottom(Index), hR.Right, hR.Bottom);
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
  if Assigned(FTheLabel) and FTheLabel.Visible then begin
    FTheLabel.Parent.DisableAlign;
    FTheLabel.Constraints.MaxWidth := FMaxWidth;
    if FMaxWidth > 0 then
      FTheLabel.Width := FMaxWidth
    else
      FTheLabel.Width := 9999;

    FTheLabel.Height := 0;
    FTheLabel.WordWrap := True;
    FTheLabel.AutoSize := True;
    TAccessLabel(FTheLabel).AdjustBounds;

    FTheLabel.Enabled := FCommonData.FOwnerControl.Enabled or FEnabledAlways;
{$IFNDEF ALITE}
    FTheLabel.UseHTML := FUseHTML;
{$ENDIF}
    FTheLabel.Align := alNone;
    case Layout of
      sclLeft: begin
        if FTheLabel.FocusControl.Align = alLeft then begin
          FTheLabel.Align := alLeft;
          TLabel(FTheLabel).Layout := tlCenter;
        end;

        FTheLabel.Left := FTheLabel.FocusControl.Left - FTheLabel.Width - 4 - Indent;
        FTheLabel.Top  := FTheLabel.FocusControl.Top  + (FTheLabel.FocusControl.Height - FTheLabel.Height) div 2 - 1;
      end;

      sclTopLeft: begin
        FTheLabel.Left := FTheLabel.FocusControl.Left;
        FTheLabel.Top  := FTheLabel.FocusControl.Top - FTheLabel.Height - Indent;
      end;

      sclTopCenter: begin
        FTheLabel.Left := FTheLabel.FocusControl.Left + (FTheLabel.FocusControl.Width - FTheLabel.Width) div 2;
        FTheLabel.Top  := FTheLabel.FocusControl.Top  - FTheLabel.Height - Indent;
      end;

      sclTopRight: begin
        FTheLabel.Left := FTheLabel.FocusControl.Left + FTheLabel.FocusControl.Width - FTheLabel.Width;
        FTheLabel.Top  := FTheLabel.FocusControl.Top  - FTheLabel.Height - Indent;
      end;

      sclLeftTop: begin
        FTheLabel.Left := FTheLabel.FocusControl.Left - FTheLabel.Width - 4 - Indent;
        FTheLabel.Top  := FTheLabel.FocusControl.Top  + 3;
      end;

      sclBottomLeft: begin
        FTheLabel.Left := FTheLabel.FocusControl.Left;
        FTheLabel.Top  := FTheLabel.FocusControl.Top + FTheLabel.FocusControl.Height + Indent;
      end;

      sclBottomCenter: begin
        FTheLabel.Left := FTheLabel.FocusControl.Left + (FTheLabel.FocusControl.Width - FTheLabel.Width) div 2;
        FTheLabel.Top  := FTheLabel.FocusControl.Top  + FTheLabel.FocusControl.Height + Indent;
      end;

      sclBottomRight: begin
        FTheLabel.Left := FTheLabel.FocusControl.Left + FTheLabel.FocusControl.Width - FTheLabel.Width;
        FTheLabel.Top  := FTheLabel.FocusControl.Top  + FTheLabel.FocusControl.Height + Indent;
      end;
    end;
    FTheLabel.Parent := FCommonData.FOwnerControl.Parent;
//    if FMaxWidth <> 0 then
//      FTheLabel.WordWrap := FTheLabel.Width >= FTheLabel.Constraints.MaxWidth - 4;
    FTheLabel.Parent.EnableAlign;
  end;
end;


constructor TsBoundLabel.Create(AOwner: TObject; const CommonData: TsCommonData);
begin
  FCommonData := CommonData;
  FFont := TFont.Create;
  FActive := False;
  FLayout := sclLeft;
  FAllowClick := False;
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
    if Value then begin
      FActive := True;
      if FTheLabel = nil then
        FTheLabel := TsEditLabel.InternalCreate(FCommonData.FOwnerControl, Self);

      FTheLabel.Visible := False;
      FTheLabel.Parent := FCommonData.FOwnerControl.Parent;
      FTheLabel.FocusControl := TWinControl(FCommonData.FOwnerControl);
      UpdateAlignment;
      FTheLabel.Name := FCommonData.FOwnerControl.Name + 'Label';
      if FText = '' then
        FText := FCommonData.FOwnerControl.Name;

      FTheLabel.Caption := FText;
      FTheLabel.Visible := FCommonData.FOwnerControl.Visible or (csDesigning in FTheLabel.ComponentState);
      FTheLabel.Enabled := FCommonData.FOwnerControl.Enabled or FEnabledAlways;
      FTheLabel.AutoSize := True;
      AlignLabel;
    end
    else begin
      if Assigned(FTheLabel) then
        FreeAndNil(FTheLabel);

      FActive := False;
    end;
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
    TsLabel(FTheLabel).Alignment := LayoutsArray[FLayout];
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
      SendMessage(TWinControl(FOwner.FOwnerControl).Handle, WM_NCPAINT, 0, 0);
  end;
end;


procedure TacScrollData.SetScrollWidth(const Value: integer);
begin
  if FScrollWidth <> Value then begin
    FScrollWidth := Value;
    if (FOwner.FOwnerControl is TWinControl) and not (csLoading in FOwner.FOwnerControl.ComponentState) then
      SetWindowPos(TWinControl(FOwner.FOwnerControl).Handle, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_NOCOPYBITS or SWP_NOSENDCHANGING or SWP_NOREPOSITION or SWP_FRAMECHANGED);
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
      if HandleAllocated and not (csLoading in ComponentState) and not (csDestroying in ComponentState) then
        SendAMessage(FOwner.FOwnerControl.Parent.Handle, AC_INVALIDATE);
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
  if h <> 0 then
    SetProp(h, acPropStr, Cardinal(Self));
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


