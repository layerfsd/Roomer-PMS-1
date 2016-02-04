unit sLabel;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFDEF DELPHI_XE2} UItypes, {$ENDIF}
  {$IFDEF DELPHI7UP} Types, {$ENDIF}
  {$IFDEF TNTUNICODE} TntControls, TntStdCtrls, TntGraphics, {$ENDIF}
  {$IFNDEF ALITE} sHtmlParse, {$ENDIF}
  {$IFDEF FPC} LMessages, {$ENDIF}
  sConst, sMessages, sSkinManager;


type
{$IFNDEF NOTFORHELP}
  TsShadowMode = (smNone, smCustom, smSkin1);
  TsKindType = (ktStandard, ktCustom, ktSkin);
{$ENDIF}


{$IFNDEF NOTFORHELP}
  TsCustomLabel = class(TCustomLabel)
  private
    FOnMouseLeave,
    FOnMouseEnter: TNotifyEvent;
    FSkinSection: string;
    FSkinManager: TsSkinManager;
{$IFDEF TNTUNICODE}
    function GetCaption: TWideCaption;
    function IsCaptionStored: Boolean;
    procedure SetCaption(const Value: TWideCaption);
    function GetHint: WideString;
    function IsHintStored: Boolean;
    procedure SetHint(const Value: WideString);
    procedure CMHintShow  (var Message: TMessage);      message CM_HINTSHOW;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    function GetLabelText: WideString; reintroduce; virtual;
{$ENDIF}
    procedure SetSkinSection(const Value: string);
    procedure SetSkinManager(const Value: TsSkinManager);
    function GetSkinManager: TsSkinManager;
  protected
    function GetCurrentFont: TFont; virtual;
    function TextColor: TColor; virtual;
    procedure WndProc(var Message: TMessage); override;
    function ManagerStored: boolean;
  public
    FSkinIndex: integer;
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
{$IFNDEF FPC}
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
{$ENDIF}
    property Font;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property SkinManager: TsSkinManager read GetSkinManager write SetSkinManager stored ManagerStored;
    property SkinSection: string read FSkinSection write SetSkinSection;
{$IFDEF TNTUNICODE}
    property Caption: TWideCaption read GetCaption write SetCaption stored IsCaptionStored;
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
{$ELSE}
    property Caption;
{$ENDIF}
{$IFDEF D2005}
    property EllipsisPosition;
{$ENDIF}
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent default True;
{$IFDEF D2010}
    property Touch;
{$ENDIF}
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;


  TsClassSkinData = record
    CustomColor,
    CustomFont: boolean;
  end;
{$ENDIF} // NOTFORHELP


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsLabel = class(TsCustomLabel)
{$IFNDEF NOTFORHELP}
  private
    FUseSkinColor: boolean;
  protected
    function TextColor: TColor; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Font;
{$ENDIF} // NOTFORHELP
    property UseSkinColor: boolean read FUseSkinColor write FUseSkinColor default True;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFNDEF ALITE}
  TsHTMLLabel = class(TsLabel)
{$IFNDEF NOTFORHELP}
  private
    HotLink,
    PressedLink: integer;
    FUseHTML: boolean;
    Links: TacLinks;
    FShowMode: TsWindowShowMode;
    function GetPlainCaption: acString;
    procedure SetUseHTML(const Value: boolean);
  public
    procedure DoClick(LinkIndex: integer);
    constructor Create(AOwner: TComponent); override;
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
    procedure WndProc(var Message: TMessage); override;
{$ENDIF} // NOTFORHELP
  published
    property PlainCaption: acString read GetPlainCaption;
    property UseHTML: boolean read FUseHTML write SetUseHTML default True;
    property ShowMode: TsWindowShowMode read FShowMode write FShowMode default soDefault;
  end;
{$ENDIF}


{$IFNDEF NOTFORHELP}
  TsEditLabel = class({$IFNDEF ALITE}TsHTMLLabel{$ELSE}TsLabel{$ENDIF})
  public
    BoundLabel: TObject;
    constructor InternalCreate(AOwner: TComponent; BoundStruct: TObject);
    destructor Destroy; override;
  end;
{$ENDIF} // NOTFORHELP


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsWebLabel = class(TsLabel)
{$IFNDEF NOTFORHELP}
  private
    FNormalFont: TFont;
    procedure SetHoverFont (const Value: TFont);
    procedure SetNormalFont(const Value: TFont);
  protected
    FHoverFont: TFont;
    FURL: string;
    FShowMode: TsWindowShowMode;
    function TextColor: TColor; override;
    function GetCurrentFont: TFont; override;
    procedure CMParentFontChanged(var Message: TMessage);       message CM_PARENTFONTCHANGED;
    procedure CMMouseEnter       (var Message: TMessage);       message CM_MOUSEENTER;
    procedure CMMouseLeave       (var Message: TMessage);       message CM_MOUSELEAVE;
    procedure WMEraseBkGnd       (var Message: TWMLButtonDown); message WM_ERASEBKGND;
    procedure WMLButtonDown      (var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  public
    MouseAbove: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
    property Font: TFont read FNormalFont write SetNormalFont;
    property Cursor default crHandPoint;
{$ENDIF} // NOTFORHELP
    property HoverFont: TFont read FHoverFont write SetHoverFont;
    property ShowMode: TsWindowShowMode read FShowMode write FShowMode default soDefault;
    property URL: string read FURL write FURL;
  end;


  TsKind = class(TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FColor: TColor;
    FOwner: TControl;
    FKindType: TsKindType;
    procedure SetKindType(const Value: TsKindType);
    procedure SetColor(const Value: TColor);
  public
    constructor Create(AOwner: TControl);
    destructor Destroy; override;
  published
{$ENDIF} // NOTFORHELP
    property KindType: TsKindType read FKindType write SetKindType default ktSkin;
    property Color: TColor read FColor write SetColor default clWhite;
  end;


  TsLabelFX = class;

  TShadowData = record
    Blur,
    Offset,
    Alpha: integer;
    Color: TColor;
  end;


{$IFNDEF NOTFORHELP}
  TacOffsetKeeper = class(TPersistent)
  private
    FRightBottom, FLeftTop: integer;
  published
    property LeftTop: integer read FLeftTop write FLeftTop stored True;
    property RightBottom: integer read FRightBottom write FRightBottom stored True;
  end;
{$ENDIF} // NOTFORHELP


  TsShadow = class(TPersistent)
{$IFNDEF NOTFORHELP}
  private
    FDistance,
    FBlurCount: Integer;

    FBuffered: Boolean;
    FColor: TColor;
    ParentControl: TsLabelFX;
    FMode: TsShadowMode;
    FAlphaValue: byte;
    FOffsetKeeper: TacOffsetKeeper;
    procedure UpdateRGB;
    procedure SetBlurCount (const Value: Integer);
    procedure SetDistance  (const Value: Integer);
    procedure SetColor     (const Value: TColor);
    procedure SetMode      (const Value: TsShadowMode);
    procedure SetAlphaValue(const Value: byte);
  public
    sr, sg, sb: Integer;
    constructor Create(AOwner: TComponent; Control: TsLabelFX);
    destructor Destroy; override;
    property ShadowBuffered: Boolean read FBuffered write FBuffered default False;
  published
{$ENDIF} // NOTFORHELP
    property AlphaValue: byte read FAlphaValue write SetAlphaValue default MaxByte;
    property BlurCount: Integer read FBlurCount write SetBlurCount default 4;
    property Color: TColor read FColor write SetColor default clBlack;
    property Distance: Integer read FDistance write SetDistance default 1;
    property Mode: TsShadowMode read FMode write SetMode default smSkin1;
    property OffsetKeeper: TacOffsetKeeper read FOffsetKeeper write FOffsetKeeper;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  // Used shading algorithm by Gennady Ermakovets (gen@godeltech.com)
  TsLabelFX = class(TsCustomLabel)
{$IFNDEF NOTFORHELP}
  private
    FAngle,
    OffsTopLeft,
    FMaskBitsSize: Integer;

    IntPosChanging,
    FNeedInvalidate: boolean;

    FMask: TBitmap;
    FMaskBits: Pointer;
    FShadow: TsShadow;
    FKind: TsKind;
    procedure SetAngle(const Value: integer);
  public
{$IFNDEF FPC}
    procedure AdjustBounds; override;
{$ENDIF}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure WndProc (var Message: TMessage); override;
{$IFNDEF FPC}
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
{$ENDIF}
    function CurrentShadowData: TShadowData;
    function CurrentFontColor: TColor;
    procedure UpdatePosition;
  published
    property Font;
{$ENDIF} // NOTFORHELP
    property Angle: integer read FAngle write SetAngle;
    property Kind: TsKind read FKind write FKind;
    property Shadow: TsShadow read FShadow write FShadow;
  end;


(* ///////////////////////////////////////////////////////////////////////
TsStickyLabel component was based on the TGMSStickyLabel control code

GMSStickyLabel v1.1 July/5/97        by Glenn Shukster & Jacques Scoatarin

  GMS COMPUTING INC.                 Phone         (905)771-6458
  53 COLVIN CRES.                    Fax                   -6819
  THORNHILL, ONT.                    Compuserve:       72734,123
  CANADA  L4J 2N7                    InternetId:Gms@Shaw.wave.ca
                                     http://members.tor.shaw.wave.ca/~gms/

  Jacques Scoatarin                  Phone (357)2-492591
  52 Athalassis Ave, (flat 202)      InternetId:j.scoatarin@cytanet.com.cy
  Nicosia, Cyprus
/////////////////////////////////////////////////////////////////////// *)
{$IFNDEF NOTFORHELP}
  TAlignTo = (altLeft, altTop, altBottom,  altRight);
{$ENDIF}
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsStickyLabel = class(TsLabel)
{$IFNDEF NOTFORHELP}
  private
    FAttachTo: TControl;
    FAlignTo: TAlignTo;
    FGap: Integer;
    FOldWinProc: TWndMethod;
    FRealigning: Boolean;
    Procedure SetGap(Value: Integer);
    procedure SetAttachTo(Value: TControl);
    Procedure SetAlignTo(Value: TAlignTo);
    procedure NewWinProc(var Message: TMessage);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Adjust(MoveLabel: boolean);
  published
    property Font;
{$ENDIF} // NOTFORHELP
    property AlignTo: TAlignTo read FAlignTo write SetAlignTo default altLeft;
    property AttachTo: TControl read FAttachTo write SetAttachTo;
    Property Gap: Integer Read FGap write SetGap Default 2;
  end;


implementation

uses ShellAPI, math,
  {$IFDEF TNTUNICODE} TntWindows, {$ENDIF}
  sVCLUtils, sGraphUtils, acntUtils, sCommonData, sDefaults, sStyleSimply;


var
  FontChanging: boolean;


function GetParentCache(Control: TControl): TCacheInfo;
var
  ParentBG: TacBGInfo;
begin
  ParentBG.PleaseDraw := False;
  GetBGInfo(@ParentBG, Control.Parent);
  Result := BGInfoToCI(@ParentBG);
end;


constructor TsCustomLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSkinManager := nil;
  Transparent := True;
end;


{$IFNDEF FPC}
{$IFDEF TNTUNICODE}
procedure TsCustomLabel.DoDrawText(var Rect: TRect; Flags: Integer);
begin
  if (SkinManager <> nil) and SkinManager.CommonSkinData.Active then begin
    Canvas.Font := Font;
    Canvas.Font.Color := TextColor;
  end;
  if not TntLabel_DoDrawText(Self, Rect, Flags, GetLabelText) then
    inherited;
end;
{$ELSE}
procedure TsCustomLabel.DoDrawText(var Rect: TRect; Flags: Longint);
{$IFDEF D2005}
const
  Ellipsis: array [TEllipsisPosition] of Longint = (0, DT_PATH_ELLIPSIS, DT_END_ELLIPSIS, DT_WORD_ELLIPSIS);
var
  NewRect: TRect;
  DText, Text: string;
  Height, Delim: Integer;
{$ELSE}
var
  Text: string;
{$ENDIF}
begin
  if (SkinManager = nil) or not SkinManager.CommonSkinData.Active then
    inherited
  else begin
    Text := GetLabelText;
    if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and (Text[1] = '&') and (Text[2] = #0)) then
      Text := Text + s_Space;

    if not ShowAccelChar then
      Flags := Flags or DT_NOPREFIX;

    Flags := DrawTextBiDiModeFlags(Flags);
    Canvas.Font := GetCurrentFont;
{$IFDEF D2005}
    if (EllipsisPosition <> epNone) and not AutoSize then begin
      DText := Text;
      Flags := Flags and not DT_EXPANDTABS;
      Flags := Flags or Ellipsis[EllipsisPosition];
      if WordWrap and (EllipsisPosition in [epEndEllipsis, epWordEllipsis]) then
        repeat
          NewRect := Rect;
          Dec(NewRect.Right, Canvas.TextWidth(s_Ellipsis));
          acDrawText(Canvas.Handle, DText, NewRect, Flags or DT_CALCRECT);
          Height := NewRect.Bottom - NewRect.Top;
          if (Height > ClientHeight) and (Height > Canvas.Font.Height) then begin
            Delim := LastDelimiter(s_Space + #9, Text);
            if Delim = 0 then
              Delim := Length(Text);

            Dec(Delim);
  {$IF NOT DEFINED(CLR)}
            if ByteType(Text, Delim) = mbLeadByte then
              Dec(Delim);
  {$IFEND}
            Text := Copy(Text, 1, Delim);
            DText := Text + s_Ellipsis;
            if Text = '' then
              Break;
          end
          else
            Break;
        until False;

      if Text <> '' then
        Text := DText;
    end;
{$ENDIF}
    Canvas.Font.Color := TextColor;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end;
end;
{$ENDIF}
{$ENDIF}


function TsCustomLabel.GetCurrentFont: TFont;
begin
  Result := inherited Font;
end;


{$IFDEF TNTUNICODE}
function TsCustomLabel.GetCaption: TWideCaption;
begin
  Result := TntControl_GetText(Self);
end;


function TsCustomLabel.IsCaptionStored: Boolean;
begin
  Result := TntControl_IsCaptionStored(Self)
end;


procedure TsCustomLabel.SetCaption(const Value: TWideCaption);
begin
  TntControl_SetText(Self, Value);
  AdjustBounds;
end;


function TsCustomLabel.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;


function TsCustomLabel.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;


procedure TsCustomLabel.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;


procedure TsCustomLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  TntLabel_CMDialogChar(Self, Message, Caption);
end;


procedure TsCustomLabel.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;


function TsCustomLabel.GetLabelText: WideString;
begin
  Result := Caption;
end;
{$ENDIF}


procedure TsCustomLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
begin
  FSkinIndex := -1;
  if not (csDestroying in ComponentState) then begin
    if not FontChanging then begin
      FontChanging := True;
      if (SkinSection <> '') and (SkinManager <> nil) and SkinManager.Active then begin
        FSkinIndex := SkinManager.GetSkinIndex(SkinSection);
        if (FSkinIndex >= 0) and (Font.Color <> SkinManager.gd[FSkinIndex].Props[0].FontColor.Color) then
          Font.Color := SkinManager.gd[FSkinIndex].Props[0].FontColor.Color;
      end
{$IFDEF TNTUNICODE}
      else
        Font.Color := TextColor
{$ENDIF}
      ;
        
      FontChanging := False;
    end;
    if FSkinIndex > 0 then
      PaintItem(FSkinIndex, GetParentCache(Self), True, 0, MkRect(Self), Point(Left, Top), Canvas.Handle);
  end;
  inherited Paint;
  FSkinIndex := -1;
end;


var
  acLabelFontChanging: boolean = False;

procedure TsCustomLabel.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CM_FONTCHANGED:
      if not (csDestroying in ComponentState) and not (csLoading in ComponentState) and not acLabelFontChanging then begin
        if not FontChanging then begin
          acLabelFontChanging := True;
{$IFNDEF FPC}
          if AutoSize then
            AdjustBounds;
{$ENDIF}
          Invalidate;
          acLabelFontChanging := False;
        end;
        Exit
      end;

    CM_MOUSEENTER:
      if Assigned(FOnMouseEnter) then
        FOnMouseEnter(Self);
  end;
  inherited;
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN, AC_REFRESH:
          if (csDesigning in ComponentState) and not (csDestroying in ComponentState) then
            Invalidate;

        AC_GETFONTINDEX:
          if (SkinManager <> nil) and SkinManager.Active and (Parent <> nil) and (SkinSection = '') then
//            with SkinManager.gd[FSkinIndex] do
{              if FSkinIndex >= 0 then
                Message.Result := GetFontIndex(Parent, PacPaintInfo(Message.LParam))
              else
//                if GiveOwnFont then}
                begin
                  Message.Result := GetFontIndex(Parent, PacPaintInfo(Message.LParam));
//                  PacPaintInfo(Message.LParam)^.FontIndex := -1;//FSkinIndex; {Remove "GiveOwnFont" with updating of all skins}
//                  Message.Result := 1;
                end;
      end;

    CM_MOUSELEAVE:
      if Assigned(FOnMouseLeave) then
        FOnMouseLeave(Self);
  end;
end;


function TsCustomLabel.ManagerStored: boolean;
begin
  Result := (FSkinManager <> nil)
end;


procedure TsCustomLabel.SetSkinSection(const Value: string);
begin
  if FSkinSection <> Value then begin
    FSkinSection := Value;
    Repaint;
  end;
end;


function TsCustomLabel.TextColor: TColor;
begin
  if Enabled then
    Result := SkinManager.Palette[pcLabelText]
  else
    Result := MixColors(ColorToRGB(Font.Color), GetControlColor(Parent), DefDisabledBlend);
end;


procedure TsCustomLabel.SetSkinManager(const Value: TsSkinManager);
begin
  if FSkinManager <> Value then begin
    FSkinManager := Value;
    Repaint;
  end;
end;


function TsCustomLabel.GetSkinManager: TsSkinManager;
begin
  if FSkinManager <> nil then
    Result := FSkinManager
  else
    Result := DefaultManager;
end;


procedure TsWebLabel.CMMouseEnter(var Message: TMessage);
var
  R: TRect;
begin
  inherited;
  if Enabled then begin
    MouseAbove := True;
    if AutoSize then begin
      Invalidate;
      Update;
{$IFNDEF FPC}
      AdjustBounds;
{$ENDIF}
    end;
    R := BoundsRect;
    InvalidateRect(Parent.Handle, @R, True);
  end;
end;


function FontIsEqual(Font1, Font2: TFont): boolean;
begin
  Result := (Font1.Style = Font2.Style) and (Font1.Size = Font2.Size) and (Font1.Color = Font2.Color) and (Font1.Name = Font2.Name);
end;


procedure TsWebLabel.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_GETTEXTLENGTH:
      if (FNormalFont <> nil) and not FontIsEqual(FNormalFont, inherited Font) then
        SetNormalFont(Font);
  end;
  inherited WndProc(Message);
end;


procedure TsWebLabel.CMMouseLeave(var Message: TMessage);
var
  R: TRect;
begin
  inherited;
  if Enabled then begin
    MouseAbove := False;
    if AutoSize then begin
      Invalidate;
      Update;
{$IFNDEF FPC}
      AdjustBounds;
{$ENDIF}
    end;
    R := BoundsRect;
    InvalidateRect(Parent.Handle, @R, True);
  end;
end;


procedure TsWebLabel.CMParentFontChanged(var Message: TMessage);
var
  c: TColor;
begin
  inherited;
  if ParentFont and Assigned(Parent) then begin
    C := FNormalFont.Color;
    FNormalFont.Assign(TsHackedControl(Parent).Font);
    FHoverFont.Name := Font.Name;
    FHoverFont.Size := Font.Size;
    FNormalFont.Color := C;
  end;
end;


constructor TsWebLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FShowMode := soDefault;
  FHoverFont := TFont.Create;
  FNormalFont := TFont.Create;
  FNormalFont.OnChange := inherited Font.OnChange;
  Cursor := crHandPoint;
  ControlStyle := ControlStyle + [csOpaque];
  Transparent := True;
end;


destructor TsWebLabel.Destroy;
begin
  if Assigned(FHoverFont) then
    FreeAndNil(FHoverFont);

  if Assigned(FNormalFont) then
    FreeAndNil(FNormalFont);

  inherited Destroy;
end;


function TsWebLabel.GetCurrentFont: TFont;
begin
  if MouseAbove and not (csDesigning in ComponentState) then
    Result := FHoverFont
  else
    Result := FNormalFont;
end;


procedure TsWebLabel.Loaded;
begin
  inherited Loaded;
  inherited Font.Assign(FNormalFont);
end;


procedure TsWebLabel.SetHoverFont(const Value: TFont);
begin
  FHoverFont.Assign(Value);
end;


procedure TsWebLabel.SetNormalFont(const Value: TFont);
begin
  inherited Font.Assign(Value);
  FNormalFont.Assign(Value);
  Paint;
end;


function TsWebLabel.TextColor: TColor;
var
  DefManager: TsSkinManager;
  Ndx: integer;
begin
  DefManager := SkinManager;
  if MouseAbove and not (csDesigning in ComponentState) and Enabled then
    if UseSkinColor and (DefManager <> nil) and DefManager.Active then
      Result := DefManager.Palette[pcWebTextHot]
    else
      Result := FHoverFont.Color // TCTop
  else
    if not (csDestroying in ComponentState) and
         (DefManager <> nil) and
           DefManager.Active and
             UseSkinColor {$IFNDEF SKININDESIGN}and
               not ((csDesigning in ComponentState) and
                 (GetOwnerFrame(Self) <> nil)){$ENDIF} then begin
      Ndx := GetFontIndex(Self, -1, DefManager);
      if Ndx < 0 then
        Result := DefManager.Palette[pcWebText]
      else
        Result := DefManager.gd[Ndx].Props[0].FontColor.Color;
    end
    else
      Result := ColorToRGB(FNormalFont.Color);
  if not Enabled then  
    Result := MixColors(Result, GetControlColor(Parent), DefDisabledBlend);
end;


procedure TsWebLabel.WMEraseBkGnd(var Message: TWMLButtonDown);
begin
  //
end;


procedure TsWebLabel.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  if FURL <> '' then
    ShellExecute(Application.{$IFDEF FPC}MainFormHandle{$ELSE}Handle{$ENDIF}, 'open', PChar(FURL), nil, nil, ord(FShowMode));
end;


destructor TsEditLabel.Destroy;
begin
  if BoundLabel <> nil then
    TsBoundLabel(BoundLabel).FActive := False;

  inherited Destroy;
end;


constructor TsEditLabel.InternalCreate(AOwner: TComponent; BoundStruct: TObject);
begin
  inherited Create(AOwner);
  BoundLabel := BoundStruct;
end;


procedure TsStickyLabel.Adjust(MoveLabel: boolean);
var
  Alignment: TAlignTo;
  iNewTop, iNewLeft: Integer;
  MoveRelativeTo, Mover: TControl;
begin
  FRealigning := True;
  if FAttachTo <> nil then begin
    if MoveLabel then begin
      MoveRelativeTo := FAttachTo;
      Mover := Self;
      Alignment := FAlignTo;
    end
    else begin
      MoveRelativeTo := Self;
      Mover := FAttachTo;
      Alignment := altRight;
      case FAlignTo of
        altTop:    Alignment := altBottom;
        altRight:  Alignment := altLeft;
        altBottom: Alignment := altTop;
      end;
    end;
    case Alignment of
      altLeft: begin
        iNewTop :=  MoveRelativeTo.Top + (MoveRelativeTo.Height - Mover.Height) div 2;
        iNewLeft := MoveRelativeTo.Left - Mover.Width - FGap;
      end;

      altRight: begin
        iNewTop :=  MoveRelativeTo.Top + (MoveRelativeTo.Height - Mover.Height) div 2;
        iNewLeft := MoveRelativeTo.Left + MoveRelativeTo.Width + FGap;
      end;

      altTop: begin
        iNewTop := MoveRelativeTo.Top - Mover.Height - FGap;
        iNewLeft := MoveRelativeTo.Left;
      end;

      else begin
        iNewTop := MoveRelativeTo.Top + MoveRelativeTo.Height + FGap;
        iNewLeft := MoveRelativeTo.Left;
      end;
    end;
    { Set all propertied in one call to avoid multiple re-drawing & pos changes }
    Mover.SetBounds(iNewLeft, iNewTop, Mover.Width, Mover.Height);
  end;
  FRealigning := False;
end;


constructor TsStickyLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGap := 2;
  FRealigning := False;
end;


destructor TsStickyLabel.Destroy;
begin
  SetAttachTo(nil);
  inherited Destroy;
end;


procedure TsStickyLabel.NewWinProc(var Message: TMessage);
begin
  if not (csDestroying in ComponentState) then
    if Assigned(FAttachTo) and (not FRealigning) then begin
      FRealigning := True;
      try
        case(Message.Msg) of
          CM_ENABLEDCHANGED:
            Enabled := FAttachTo.Enabled;

          CM_VISIBLECHANGED:
            Visible := FAttachTo.Visible;

          WM_SIZE, WM_MOVE, WM_WINDOWPOSCHANGED:
            Adjust(Message.Msg <> WM_SIZE);
        end;
      finally
        FRealigning := FALSE;
      end;
    end;

  if Assigned(FOldWinProc) then
    FOldWinProc(Message);
end;


procedure TsStickyLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FAttachTo) then
    SetAttachTo(nil);

  inherited Notification(AComponent, Operation);
end;


procedure TsStickyLabel.SetAlignTo(Value: TAlignTo);
begin
  if (FAlignTo <> Value) then begin
    FAlignTo := Value;
    Adjust(True);
  end;
end;


procedure TsStickyLabel.SetAttachTo(Value: TControl);
begin
  if(Value <> FAttachTo) then begin
    if (Assigned(FAttachTo)) then
      FAttachTo.WindowProc := FOldWinProc;

    FAttachTo := Value;
    if (Assigned(Value)) then begin
      Adjust(True);
      Enabled := FAttachTo.Enabled;
      Visible := FAttachTo.Visible;
      FOldWinProc := FAttachTo.WindowProc;
      FAttachTo.WindowProc := NewWinProc;
    end;
  end;
end;


procedure TsStickyLabel.SetGap(Value: Integer);
begin
  if (FGap <> Value) then begin
    FGap := Value;
    Adjust(True);
  end;
end;


procedure TsStickyLabel.WndProc(var Message: TMessage);
begin
  if not (csDestroying in ComponentState) and Assigned(FAttachTo) and not FRealigning then begin
    FRealigning := True;
    try
      if Message.Msg = WM_WINDOWPOSCHANGED then
        Adjust(False);
    finally
      FRealigning := False;
    end;
  end;
  inherited WndProc(Message);
end;


constructor TsShadow.Create(AOwner: TComponent; Control: TsLabelFX);
begin
  FColor := clBlack;
  FBlurCount := 4;
  FDistance := 1;
  FMode := smSkin1;
  FAlphaValue := MaxByte;
  ParentControl := Control;
  FOffsetKeeper := TacOffsetKeeper.Create;
end;


destructor TsShadow.Destroy;
begin
  FreeAndNil(FOffsetKeeper);
  inherited;
end;


procedure TsShadow.SetBlurCount(const Value: Integer);
begin
  if FBlurCount <> Value then begin
    FBlurCount := Value;
    ParentControl.UpdatePosition;
    ParentControl.Invalidate;
  end;
end;


procedure TsShadow.SetDistance(const Value: Integer);
begin
  if FDistance <> Value then begin
    FDistance := Value;
    ParentControl.UpdatePosition;
    ParentControl.Invalidate;
  end;
end;


procedure TsShadow.SetColor(const Value: TColor);
begin
  if FColor <> Value then begin
    FColor := Value;
    UpdateRGB;
    ParentControl.Invalidate;
  end;
end;


procedure TsShadow.SetMode(const Value: TsShadowMode);
begin
  if FMode <> Value then begin
    FMode := Value;
    UpdateRGB;
    ParentControl.UpdatePosition;
    ParentControl.Invalidate;
  end;
end;


procedure TsShadow.UpdateRGB;
var
  rgb: Integer;
begin
  rgb := ColorToRGB(FColor);
  sr := rgb          and MaxByte;
  sg := (rgb shr 8)  and MaxByte;
  sb := (rgb shr 16) and MaxByte;
end;


procedure TsShadow.SetAlphaValue(const Value: byte);
begin
  if FAlphaValue <> Value then begin
    FAlphaValue := Value;
    ParentControl.Invalidate;
  end;
end;


{$IFNDEF FPC}
procedure TsLabelFX.AdjustBounds;
const
  WordWraps: array [Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  R: TRect;
  Text: acString;
  rad, rcos, rsin: real;
  AAlignment: TAlignment;
  Size, ActSize, OldSize: TSize;
  X, Y, OffsTopLeft, OffsRightBottom: integer;
begin
  if not (csReading in ComponentState) and not (csLoading in ComponentState) then begin
    AAlignment := Alignment;
    if UseRightToLeftAlignment then
      ChangeBiDiModeAlignment(AAlignment);

    with CurrentShadowData do begin
      OffsTopLeft     := min(0, Offset - Blur);
      OffsRightBottom := Max(0, Offset + Blur);
    end;
    X := Left;
    Y := Top;
    if AutoSize then begin
      DC := GetDC(0);
      Text := GetLabelText;
      if ((Text = '') or ShowAccelChar and (Text[1] = '&') and (Text[2] = #0)) then
        Text := Text + s_Space;

      SelectObject(DC, Font.Handle);
      R := MkRect(MaxInt, 0);
      acDrawText(DC, Text, R, (DT_EXPANDTABS or DT_CALCRECT or DT_NOPREFIX) or WordWraps[WordWrap]);
      Size := MkSize(R);
      if Angle <> 0 then begin
        rad := Pi * Angle / 180;
        rcos := cos(rad);
        rsin := sin(rad);
        ActSize := MkSize(Round(Size.cx * abs(rcos) + Size.cy * abs(rsin)), Round(Size.cx * abs(rsin) + Size.cy * abs(rcos)));
        Size := ActSize;
      end;
      ActSize := Size;
      ReleaseDC(0, DC);

      inc(Size.cx, - OffsTopLeft + OffsRightBottom);
      inc(Size.cy, - OffsTopLeft + OffsRightBottom);

      OldSize := MkSize(Width  + Shadow.OffsetKeeper.LeftTop - Shadow.OffsetKeeper.RightBottom,
                        Height + Shadow.OffsetKeeper.LeftTop - Shadow.OffsetKeeper.RightBottom);

      case AAlignment of
        taLeftJustify:  X := X - Shadow.OffsetKeeper.LeftTop + OffsTopLeft;
        taCenter:       X := X - (Shadow.OffsetKeeper.LeftTop - OffsTopLeft - Shadow.OffsetKeeper.RightBottom + OffsRightBottom) div 2;
        taRightJustify: begin
          X := X + 2 * (OffsTopLeft + Width - Shadow.OffsetKeeper.RightBottom) - OldSize.cx;
          X := X - ActSize.cx;
        end;
      end;

      case Layout of
        tlTop:    Y := Y - Shadow.OffsetKeeper.LeftTop + OffsTopLeft;
        tlCenter: Y := Y - (Shadow.OffsetKeeper.LeftTop - OffsTopLeft - Shadow.OffsetKeeper.RightBottom + OffsRightBottom) div 2;
        tlBottom: Y := Y + OffsTopLeft + Height - Shadow.OffsetKeeper.RightBottom - OldSize.cy;
      end;
      if Layout = tlBottom then
        Y := Y + OffsTopLeft + Height - Shadow.OffsetKeeper.RightBottom - ActSize.cy;

      SetBounds(X, Y, Size.cx, Size.cy);
    end
    else begin
      OldSize.cx := Width  + Shadow.OffsetKeeper.LeftTop - Shadow.OffsetKeeper.RightBottom;
      OldSize.cy := Height + Shadow.OffsetKeeper.LeftTop - Shadow.OffsetKeeper.RightBottom;
      case AAlignment of
        taLeftJustify:  X := X - Shadow.OffsetKeeper.LeftTop + OffsTopLeft;
        taCenter:       X := X - (Shadow.OffsetKeeper.LeftTop - OffsTopLeft - Shadow.OffsetKeeper.RightBottom + OffsRightBottom) div 2;
        taRightJustify: X := X + OffsTopLeft + Width - Shadow.OffsetKeeper.RightBottom - OldSize.cx;
      end;

      case Layout of
        tlTop:    Y := Y - Shadow.OffsetKeeper.LeftTop + OffsTopLeft;
        tlCenter: Y := Y - (Shadow.OffsetKeeper.LeftTop - OffsTopLeft - Shadow.OffsetKeeper.RightBottom + OffsRightBottom) div 2;
        tlBottom: Y := Y + OffsTopLeft + Height - Shadow.OffsetKeeper.RightBottom - OldSize.cy;
      end;
      inc(OldSize.cx, - OffsTopLeft + OffsRightBottom);
      inc(OldSize.cy, - OffsTopLeft + OffsRightBottom);
      SetBounds(X, Y, OldSize.cx, OldSize.cy);
    end;
  end;
end;
{$ENDIF}


constructor TsLabelFX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSkinIndex := -1;
  FShadow := TsShadow.Create(AOwner, Self);
  FKind := TsKind.Create(Self);
  FMask := CreateBmp32;
  FMaskBits := nil;
  IntPosChanging := False;
  FNeedInvalidate := True;
end;


function TsLabelFX.CurrentFontColor: TColor;
begin
  case FKind.KindType of
    ktStandard:
      Result := ColorToRGB(Color);

    ktCustom:
      Result := ColorToRGB(Kind.Color);

    else {ktSkin}
      if (SkinManager <> nil) and SkinManager.CommonSkinData.Active then begin
        if SkinSection <> '' then
          FSkinIndex := SkinManager.GetSkinIndex(SkinSection);

        if FSkinIndex = -1 then
          if (SkinManager.ConstData.IndexGlobalInfo > -1) and
               (SkinManager.ConstData.IndexGlobalInfo <= Length(DefaultManager.gd) - 1) and
                 (SkinManager.gd[DefaultManager.ConstData.IndexGlobalInfo].Props[0].FontColor.Left <> -1) then
            Result := ColorToRGB(SkinManager.gd[DefaultManager.ConstData.IndexGlobalInfo].Props[0].FontColor.Left)
          else
            Result := ColorToRGB(Kind.Color)
        else
          Result := ColorToRGB(SkinManager.gd[FSkinIndex].Props[0].FontColor.Color);
      end
      else
        Result := ColorToRGB(Kind.Color);
  end;
end;


function TsLabelFX.CurrentShadowData: TShadowData;
begin
  case FShadow.Mode of
    smCustom: begin
      Result.Color  := FShadow.Color;
      Result.Blur   := FShadow.BlurCount;
      Result.Offset := FShadow.FDistance;
      Result.Alpha  := FShadow.AlphaValue;
    end;

    smSkin1:
      with SkinManager do begin
        if (SkinManager <> nil) and Active and (CommonSkinData.Shadow1Blur <> -1) then begin
          Result.Color  := CommonSkinData.Shadow1Color;
          Result.Blur   := CommonSkinData.Shadow1Blur;
          Result.Offset := CommonSkinData.Shadow1Offset;
        end
        else begin
          Result.Color  := FShadow.Color;
          Result.Blur   := FShadow.BlurCount;
          Result.Offset := FShadow.FDistance;
        end;
        Result.Alpha := FShadow.AlphaValue;
      end

    else begin
      Result.Blur   := 0;
      Result.Color  := 0;
      Result.Offset := 0;
      Result.Alpha  := 0;
    end;
  end;
end;


destructor TsLabelFX.Destroy;
begin
  FreeAndNil(FShadow);
  FreeAndNil(FMask);
  FreeAndNil(FKind);
  if FMaskBits <> nil then
    FreeMem(FMaskBits);

  inherited;
end;


procedure DrawDisabledText(DC: hdc; Text: PacChar; aRect: TRect; Flags: integer; Angle: integer; Offset: TPoint);
begin
  OffsetRect(aRect, 1, 1);
  SetTextColor(DC, ColorToRGB(clBtnHighlight));
  if Angle = 0 then
    acDrawText(DC, Text, aRect, Flags)
  else
{$IFDEF TNTUNICODE}
    ExtTextOutW(DC, aRect.Left + Offset.X, aRect.Top + Offset.Y, 0, @aRect, PacChar(Text), Length(Text), nil);
{$ELSE}
    ExtTextOut(DC, aRect.Left + Offset.X, aRect.Top + Offset.Y, 0, @aRect, PAnsiChar(Text), Length(Text), nil);
{$ENDIF}
  OffsetRect(aRect, -1, -1);
  SetTextColor(DC, ColorToRGB(clBtnShadow));
  if Angle = 0 then
    acDrawText(DC, PacChar(Text), aRect, Flags)
  else
    {$IFDEF TNTUNICODE}ExtTextOutW{$ELSE}ExtTextOut{$ENDIF}(DC, aRect.Left + Offset.X, aRect.Top + Offset.Y, 0, @aRect, PacChar(Text), Length(Text), nil);
end;


{$IFNDEF FPC}
procedure TsLabelFX.DoDrawText(var Rect: TRect; Flags: Longint);
const
  LB_BORDER = 3;
var
  sP: TPoint;
  invert: byte;
  Text: acString;
  x, y, i: Integer;
  aRect, DstRect: TRect;
  MaskOffs, D0, D: PByte;
  cr, cg, cb, DeltaD, W, H, nW, nH: Integer;
  offs_North, offs_South, offs_West, offs_East: PByte;
  ShadowData: TShadowData;
  rgb, OffsRightBottom: Integer;
  rad, rcos, rsin: real;
  Size: TSize;

  procedure AddMask;
  var
    DeltaS, y, x: Integer;
    MaskOffs, S0, S: PByte;
  begin // Fill mask
    MaskOffs := PByte(Integer(FMaskBits) + W + 1);
    if InitLine(FMask, Pointer(S0), DeltaS) then
      for y := 0 to FMask.Height - 1 do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        for x := 0 to FMask.Width - 1 do begin
          if S^ <> 0 then
            MaskOffs^ := MaxByte;

          S := PByte(Integer(S) + 4);
          MaskOffs := PByte(Integer(MaskOffs) + 1);
        end;
        MaskOffs := PByte(Integer(MaskOffs) + 2);
      end;
  end;

begin
  if not (csLoading in ComponentState) and ((FShadow.Mode <> smNone) or (FSkinIndex >= 0)) then begin // If not standard kind
    aRect := Rect;
    ShadowData := CurrentShadowData;
    rgb := ColorToRGB(ShadowData.Color);
    Shadow.sr := rgb and MaxByte;
    Shadow.sg := (rgb shr 8) and MaxByte;
    Shadow.sb := (rgb shr 16) and MaxByte;
    // If orig. offset is not initialized yet
    OffsTopLeft := Min(0, ShadowData.Offset - ShadowData.Blur);
    OffsRightBottom := Max(0, ShadowData.Offset + ShadowData.Blur);
    // Prepare text
    Text := GetLabelText;
    if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and (Text[1] = '&') and (Text[2] = #0)) then
      Text := Text + s_Space;

    // Prepare flags
    Flags := DrawTextBiDiModeFlags(Flags) or DT_NOCLIP;
    if not ShowAccelChar then
      Flags := Flags or DT_NOPREFIX;

    if WordWrap then
      Flags := Flags or DT_WORDBREAK and not DT_SINGLELINE
    else
      Flags := Flags or DT_SINGLELINE;

    Canvas.Font.Assign(Font);
    Size := GetStringSize(Font.Handle, Text, Flags, WordWrap, WidthOf(aRect));

    if Angle <> 0 then begin
      // Calc size and offset of text
      MakeAngledFont(Canvas.Handle, Font, Angle * 10);
      rad := Pi * Angle / 180;
      rcos := cos(rad);
      rsin := sin(rad);

      nW := Round(Size.cx * abs(rcos) + Size.cy * abs(rsin));
      nH := Round(Size.cx * abs(rsin) + Size.cy * abs(rcos));

      sP.X := Round((Size.cx - Size.cx * rcos - Size.cy * rsin) / 2) + (nW - Size.cx) div 2;
      sP.Y := Round((Size.cy * (1 - rcos) + Size.cx * rsin) / 2) + (nH - Size.cy) div 2;
    end
    else begin
      nW := Size.cx;
      nH := Size.cy;
    end;

    case Alignment of
      taLeftJustify: begin
        DstRect.Left := aRect.Left;
        DstRect.Left := DstRect.Left - min(0, ShadowData.Offset - ShadowData.Blur);
      end;

      taCenter: begin
        DstRect.Left := (aRect.Right - nW - OffsRightBottom - OffsTopLeft) div 2;
        DstRect.Left := DstRect.Left + ShadowData.Offset;
      end;

      taRightJustify:
        DstRect.Left := aRect.Right - nW - OffsRightBottom;
    end;
    DstRect.Right := DstRect.Left + nW;
    case Layout of
      tlTop: begin
        DstRect.Top := aRect.Top;
        DstRect.Top := DstRect.Top - min(0, ShadowData.Offset - ShadowData.Blur);
      end;

      tlCenter: begin
        DstRect.Top := (aRect.Bottom - nH - OffsRightBottom - OffsTopLeft) div 2;
        DstRect.Top := DstRect.Top + ShadowData.Offset;
      end;

      tlBottom:
        DstRect.Top := aRect.Bottom - nH - OffsRightBottom;
    end;

    DstRect.Bottom := DstRect.Top + nH;

    if not Enabled then
      DrawDisabledText(Canvas.Handle, PacChar(Text), DstRect, Flags, Angle, sP)
    else begin
      SetTextColor(Canvas.Handle, CurrentFontColor);
      if (Flags and DT_CALCRECT <> DT_CALCRECT) and (ShadowData.Color <> clNone) and (ShadowData.Blur <> 0) then begin
        if (FNeedInvalidate) or (not FShadow.FBuffered) then begin
          // Clear a mask BG (black = 0)
          FMask.Width := WidthOf(Rect, True);
          FMask.Height := HeightOf(Rect, True);
          FMask.Canvas.Brush.Color := 0;
          FMask.Canvas.FillRect(MkRect(FMask));
          // Text props
          if Angle = 0 then begin
            FMask.Canvas.Font.Assign(Font);
            FMask.Canvas.Font.Color := clWhite;
          end
          else begin
            MakeAngledFont(FMask.Canvas.Handle, Font, Angle * 10);
            SetTextColor(FMask.Canvas.Handle, ColorToRGB(clWhite));
          end;
          // Draw a white mask text
          OffsetRect(DstRect, ShadowData.Offset, ShadowData.Offset);
          if Angle = 0 then
            acDrawText(FMask.Canvas.Handle, PacChar(Text), DstRect, Flags)
          else
{$IFDEF TNTUNICODE}
            ExtTextOutW(FMask.Canvas.Handle, DstRect.Left + sP.X, DstRect.Top + sP.Y, 0, @DstRect, PacChar(Text), Length(Text), nil);
{$ELSE}
            ExtTextOut(FMask.Canvas.Handle, DstRect.Left + sP.X, DstRect.Top + sP.Y, 0, @DstRect, PChar(Text), Length(Text), nil);
{$ENDIF}
          W := FMask.Width + 2;
          H := FMask.Height + 2;
          if FMaskBitsSize < W * H * 2 then begin
            FMaskBitsSize := W * H * 2;
            ReallocMem(FMaskBits, FMaskBitsSize);
          end;
          FillChar(PChar(FMaskBits)^, W * H * 2, 0);
          // Blur the mask
          for i := 1 to ShadowData.Blur do begin
            MaskOffs := PByte(Integer(FMaskBits) + W + 1);
            AddMask;
            offs_North := PByte(Integer(MaskOffs) - W);
            offs_South := PByte(Integer(MaskOffs) + W);
            offs_West  := PByte(Integer(MaskOffs) - 1);
            offs_East  := PByte(Integer(MaskOffs) + 1);
            for y := 0 to H - 3 do begin
              for x := 0 to W - 3 do begin
                MaskOffs^ := (offs_North^ + offs_South^ + offs_West^ + offs_East^) shr 2;
                MaskOffs   := PByte(Integer(MaskOffs)   + 1);
                offs_North := PByte(Integer(offs_North) + 1);
                offs_South := PByte(Integer(offs_South) + 1);
                offs_West  := PByte(Integer(offs_West)  + 1);
                offs_East  := PByte(Integer(offs_East)  + 1);
              end;
              MaskOffs   := PByte(Integer(MaskOffs)   + 2);
              offs_North := PByte(Integer(offs_North) + 2);
              offs_South := PByte(Integer(offs_South) + 2);
              offs_West  := PByte(Integer(offs_West)  + 2);
              offs_East  := PByte(Integer(offs_East)  + 2);
            end;
          end;

          MaskOffs := PByte(Integer(FMaskBits) + FMask.Width + 3);
          if InitLine(FMask, Pointer(D0), DeltaD) then
            if Transparent then begin
              // GetBackground
              BitBlt(FMask.Canvas.Handle, 0, 0, FMask.Width, FMask.Height, Canvas.Handle, 0, 0, SRCCOPY);
              // setAlpha
              for y := 0 to FMask.Height - 1  do begin
                D := Pointer(LongInt(D0) + DeltaD * Y);
                for x := 0 to FMask.Width - 1 do begin
                  MaskOffs^ := MaskOffs^ * ShadowData.Alpha shr 8;
                  invert := not MaskOffs^;
                  D^ := (D^ * invert + FShadow.sb * MaskOffs^) shr 8;
                  D := PByte(Integer(D) + 1);
                  D^ := (D^ * invert + FShadow.sg * MaskOffs^) shr 8;
                  D := PByte(Integer(D) + 1);
                  D^ := (D^ * invert + FShadow.sr * MaskOffs^) shr 8;
                  D := PByte(Integer(D) + 2);
                  MaskOffs := PByte(Integer(MaskOffs) + 1);
                end;
                MaskOffs := PByte(Integer(MaskOffs) + 2);
              end;
            end
            else begin
              // SetAlpha
              i := ColorToRGB(Color);
              cr := i and MaxByte;
              cg := (i shr 8) and MaxByte;
              cb := (i shr 16) and MaxByte;
              for y := 0 to FMask.Height - 1  do begin
                D := Pointer(LongInt(D0) + DeltaD * Y);
                for x := 0 to FMask.Width - 1 do begin
                  MaskOffs^ := MaskOffs^ * ShadowData.Alpha shr 8;
                  invert := not MaskOffs^;
                  D^ := (cb * invert + FShadow.sb * MaskOffs^) shr 8;
                  D := PByte(Integer(D) + 1);
                  D^ := (cg * invert + FShadow.sg * MaskOffs^) shr 8;
                  D := PByte(Integer(D) + 1);
                  D^ := (cr * invert + FShadow.sr * MaskOffs^) shr 8;
                  D := PByte(Integer(D) + 2);
                  MaskOffs := PByte(Integer(MaskOffs) + 1);
                end;
                MaskOffs := PByte(Integer(MaskOffs) + 2);
              end;
            end;

          FNeedInvalidate := False;
        end; // Need Invalidate
        BitBlt(Canvas.Handle, 0, 0, FMask.Width, FMask.Height, FMask.Canvas.Handle, 0, 0, SRCCOPY);
        OffsetRect(DstRect, -ShadowData.Offset, -ShadowData.Offset);
        if Angle = 0 then
          if FSkinIndex = -1 then
            acDrawText(Canvas.Handle, PacChar(Text), DstRect, Flags)
          else
            acWriteTextEx(Canvas, PacChar(Text), Enabled, DstRect, Flags, FSkinIndex, False, SkinManager)
        else
{$IFDEF TNTUNICODE}
          ExtTextOutW(Canvas.Handle, DstRect.Left + sP.X, DstRect.Top + sP.Y, 0, @DstRect, PacChar(Text), Length(Text), nil);
{$ELSE}
          ExtTextOut(Canvas.Handle, DstRect.Left + sP.X, DstRect.Top + sP.Y, 0, @DstRect, PChar(Text), Length(Text), nil);
{$ENDIF}
      end
      else
        acDrawText(Canvas.Handle, PacChar(Text), DstRect, Flags); // Calc size of text

      if (Flags and DT_CALCRECT = DT_CALCRECT) and (ShadowData.Color <> clNone) and (ShadowData.Blur <> 0) then begin
        inc(aRect.Right, OffsRightBottom - OffsTopLeft);
        inc(aRect.Bottom, OffsRightBottom - OffsTopLeft);
      end;
    end;
  end
  else
    inherited;
end;
{$ENDIF}


procedure TsLabelFX.Invalidate;
begin
  if WordWrap and (Angle <> 0) then
    Angle := 0;

  inherited;
end;


procedure TsLabelFX.SetAngle(const Value: integer);
begin
  if FAngle <> Value then begin
    FAngle := Value;
    if (Value <> 0) and WordWrap then
      WordWrap := False;

{$IFNDEF FPC}
    if AutoSize then
      AdjustBounds
    else
{$ENDIF}
      Invalidate;
  end;
end;


procedure TsLabelFX.UpdatePosition;
var
  CurrentOffset1, CurrentOffset2: integer;
begin
  if not (csLoading in ComponentState) then begin
    with CurrentShadowData do begin
      CurrentOffset1 := min(0, CurrentShadowData.Offset - CurrentShadowData.Blur);
      CurrentOffset2 := max(0, Offset + Blur);
    end;
    if (CurrentOffset1 <> Shadow.OffsetKeeper.LeftTop) or (CurrentOffset2 <> Shadow.OffsetKeeper.RightBottom) then begin
      IntPosChanging := True;
{$IFNDEF FPC}
      AdjustBounds;
{$ENDIF}
      Shadow.OffsetKeeper.LeftTop := CurrentOffset1;
      Shadow.OffsetKeeper.RightBottom := CurrentOffset2;
      IntPosChanging := False;
    end;
  end;
end;


procedure TsLabelFX.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  inherited;
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN, AC_SETNEWSKIN:
          if not (csDestroying in ComponentState) then
            UpdatePosition;
      end;

    WM_WINDOWPOSCHANGED, WM_SIZE, WM_MOVE:
      if (FShadow <> nil) and not IntPosChanging then
        with CurrentShadowData do begin
          Shadow.OffsetKeeper.LeftTop := min(0, Offset - Blur);
          Shadow.OffsetKeeper.RightBottom := Max(0, Offset + Blur);
        end;
  end;
end;


constructor TsKind.Create(AOwner: TControl);
begin
  FKindType := ktSkin;
  FColor := clWhite;
  FOwner := AOwner
end;


destructor TsKind.Destroy;
begin
  inherited;
end;


procedure TsKind.SetColor(const Value: TColor);
begin
  if FColor <> Value then begin
    FColor := Value;
    FOwner.Invalidate
  end
end;


procedure TsKind.SetKindType(const Value: TsKindType);
begin
  if FKindType <> Value then begin
    FKindType := Value;
    FOwner.Invalidate
  end
end;


constructor TsLabel.Create(AOwner: TComponent);
begin
  inherited;
  FUseSkinColor := True;
end;


function TsLabel.TextColor: TColor;
var
  Ndx: integer;
begin
  with SkinManager do
    if FUseSkinColor and (SkinManager <> nil) and CommonSkinData.Active then begin
      Ndx := GetFontIndex(Self, GetSkinIndex(SkinSection), SkinManager);
      if Between(Ndx, 0, Length(gd) - 1) then
        Result := gd[Ndx].Props[0].FontColor.Color
      else
        Result := Palette[pcLabelText];

      if not Enabled then
        Result := MixColors(Result, GetControlColor(Parent), DefDisabledBlend);
    end
    else
      Result := Font.Color;
end;


{$IFNDEF ALITE}
procedure TsHTMLLabel.DoClick(LinkIndex: integer);
begin
  if Links[LinkIndex].URL <> '' then
    ShellExecute(Application.Handle, 'open', PChar(Links[LinkIndex].URL), nil, nil, ord(FShowMode));
end;


procedure TsHTMLLabel.DoDrawText(var Rect: TRect; Flags: Longint);
var
  Html: TsHtml;
  R, CalcRect: TRect;
  w: integer;
  Bmp: TBitmap;
begin
  if FUseHTML then begin
    if Caption <> '' then begin
      Html := TsHtml.Create;
      R := Rect;
      Bmp := TBitmap.Create;
      Bmp.Height := Height;
      Bmp.Width := Width;
      Bmp.Canvas.Font.Assign(Font);
      Bmp.Canvas.Brush.Style := bsClear;
      Bmp.Canvas.Font.Color := TextColor;
      try
        HTML.SkinManager := SkinManager;
        if (Flags and DT_CALCRECT <> 0) then begin
          HTML.Init(Bmp, Caption, MkRect, HotLink, PressedLink);
          Rect := HTML.HTMLText(Links, True);
        end
        else begin
          HTML.Init(Bmp, Caption, R, HotLink, PressedLink);
          if Alignment <> taLeftJustify then begin
            CalcRect := HTML.HTMLText(Links, True);
            w := WidthOf(CalcRect);
            case Alignment of
              taCenter:       R.Left := (WidthOf(R) - w) div 2;
              taRightJustify: R.Left := R.Right - w;
            end;
            R.Right := R.Left + WidthOf(CalcRect);
            HTML.Area := R;
            HTML.CurX := R.Left;
            HTML.CurY := R.Top;
          end;
          BitBlt(Bmp.Canvas.Handle, 0, 0, Width, Height, Canvas.Handle, 0, 0, SRCCOPY);
          HTML.HTMLText(Links);
          BitBlt(Canvas.Handle, 0, 0, Width, Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end;
      finally
        Bmp.Free;
        Html.Free;
      end;
    end;
  end
  else
    inherited;
end;


procedure TsHTMLLabel.WndProc(var Message: TMessage);
var
  ActNdx: integer;

  function ActiveLink: integer;
  var
    i: integer;
  begin
    Result := -1;
    for i := 0 to Length(Links) - 1 do
      if PtInRect(Links[i].Bounds, ScreenToClient(acMousePos)) then begin
        Result := i;
        Exit;
      end;
  end;

begin
  case Message.Msg of
    WM_LBUTTONDOWN:
      if HotLink >= 0 then begin
        PressedLink := HotLink;
        Repaint;
      end;

    WM_LBUTTONUP:
      if (PressedLink >= 0) then begin
        if HotLink >= 0 then
          DoClick(PressedLink);

        PressedLink := -1;
        Repaint;
      end;

    WM_MOUSEMOVE: begin
      ActNdx := ActiveLink;
      if (ActNdx >= 0) then begin
        if (HotLink <> ActNdx) then begin
          HotLink := ActNdx;
          Cursor := crHandPoint;
          Repaint;
        end;
      end
      else
        if HotLink >= 0 then begin
          HotLink := -1;
          Cursor := crDefault;
          Repaint;
        end;
    end;

    WM_MOUSELEAVE, CM_MOUSELEAVE:
      if (HotLink >= 0) or (PressedLink >= 0) then begin
        HotLink := -1;
        PressedLink := -1;
        Cursor := crDefault;
        Repaint;
      end;
  end;
  inherited
end;


constructor TsHTMLLabel.Create(AOwner: TComponent);
begin
  inherited;
  FUseHTML := True;
  HotLink := -1;
  PressedLink := -1;
  FShowMode := soDefault;
end;


function TsHTMLLabel.GetPlainCaption: acString;
var
  TagStart, TagEnd, TagLength: integer;
begin
  Result := Caption;
  TagStart := Pos('<', Result);
  while (TagStart > 0) and (TagStart < Length(Result)) do begin
    TagEnd := Pos('>', Result);
    if TagEnd = 0 then
      Exit;
      
    TagLength := TagEnd - TagStart + 1;
    Delete(Result, TagStart, TagLength);
    TagStart := Pos( '<', Result);
  end;
end;


procedure TsHTMLLabel.SetUseHTML(const Value: boolean);
begin
  if FUseHTML <> Value then begin
    FUseHTML := Value;
    Repaint;
  end;
end;
{$ENDIF}

initialization
  Classes.RegisterClasses([TsEditLabel])

finalization

end.
