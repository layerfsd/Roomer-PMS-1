unit acAlphaHints;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, ExtCtrls, Graphics,
  {$IFDEF TNTUNICODE} TntForms, TntControls, {$ENDIF}
  {$IFDEF DELPHI7UP} Types, {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFNDEF FPC} sHtmlParse, {$ENDIF}
  sGraphUtils, sConst, acntUtils, acPNG, acThdTimer;


{$IFNDEF NOTFORHELP}
const
  AddInterval = 0;
  StepDivid   = 2;
  Speed       = 5;

  DefAnimationTime = 120;
{$ENDIF}


type
{$IFNDEF NOTFORHELP}
  TacShowHintEvent = procedure(var   HintStr: String; var   CanShow: Boolean; var HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo; var Frame: TFrame) of object;
  TacMeasureEvent  = procedure(const HintStr: String; const HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo; var NewWidth, NewHeight: integer) of object;
  TacPaintEvent    = procedure(const HintStr: String; const HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo; ARect: TRect; ABmp: TBitmap; var DefaultDraw: Boolean) of object;
  TacMousePosition = (mpLeftTop, mpLeftBottom, mpRightTop, mpRightBottom);
  TacBorderDrawMode = (dmRepeat, dmStretch);
  TsAlphaHints        = class;
  TacHintImage        = class;
  TacHintTemplate     = class;
  TacHintTemplates    = class;
  TacCustomHintWindow = class;
{$IFDEF D2009}
  THintInfo = Controls.THintInfo;
{$ENDIF}


  TacBorderDrawModes = class(TPersistent)
  private
    FTop,
    FLeft,
    FRight,
    FCenter,
    FBottom: TacBorderDrawMode;
    FOwner: TacHintImage;
    procedure SetDrawMode(const Index: Integer; const Value: TacBorderDrawMode);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TacHintImage);
    procedure SaveToStream  (AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
  published
    property Top    : TacBorderDrawMode index 0 read FTop    write SetDrawMode default dmStretch;
    property Left   : TacBorderDrawMode index 1 read FLeft   write SetDrawMode default dmStretch;
    property Bottom : TacBorderDrawMode index 2 read FBottom write SetDrawMode default dmStretch;
    property Right  : TacBorderDrawMode index 3 read FRight  write SetDrawMode default dmStretch;
    property Center : TacBorderDrawMode index 4 read FCenter write SetDrawMode default dmStretch;
  end;


  TacBordersSizes = class(TPersistent)
  private
    function GetInteger(const Index: Integer): integer;
  protected
    FTop,
    FLeft,
    FRight,
    FBottom: integer;
    FOwner: TacHintImage;
    procedure AssignTo(Dest: TPersistent); override;
  public
    CheckSize: boolean;
    constructor Create(AOwner: TacHintImage);
    procedure SetInteger(Index: integer; Value: integer);
    procedure SetValues(ALeft, ATop, ARight, ABottom: integer);
    procedure SaveToStream  (AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
  published
    property Top    : integer index 0 read GetInteger write SetInteger default 0;
    property Left   : integer index 1 read GetInteger write SetInteger default 0;
    property Bottom : integer index 2 read GetInteger write SetInteger default 0;
    property Right  : integer index 3 read GetInteger write SetInteger default 0;
  end;


  TacHintImage = class(TPersistent)
  private
    FOffsetHorz,
    FOffsetVert: integer;

    FShadowSizes,
    FClientMargins,
    FBordersWidths: TacBordersSizes;

    FBorderDrawModes: TacBorderDrawModes;
    function GetImgHeight: integer;
    function GetImgWidth:  integer;
    procedure SetImage        (const Value: TPngGraphic);
    procedure SetImgHeight    (const Value: integer);
    procedure SetImgWidth     (const Value: integer);
    procedure SetOffsetHorz   (const Value: integer);
    procedure SetOffsetVert   (const Value: integer);
    procedure SetClientMargins(const Value: TacBordersSizes);
    procedure SetBordersWidths(const Value: TacBordersSizes);
    procedure SetShadowSizes  (const Value: TacBordersSizes);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadData (Reader: TStream);
    procedure WriteData(Writer: TStream);
    procedure AssignTo(Dest: TPersistent); override;
    function BitmapStored: boolean;
  public
    FOwner: TacHintTemplate;
    FImage: TPngGraphic;
    FImageData: TMemoryStream;
    constructor Create(AOwner: TacHintTemplate);
    destructor Destroy; override;
    procedure StreamChanged;
    procedure ImageChanged;
    procedure SavetoStream  (AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
  published
    property OffsetHorz: integer read FOffsetHorz write SetOffsetHorz default 0;
    property OffsetVert: integer read FOffsetVert write SetOffsetVert default 0;
    property ImageHeight: integer read GetImgHeight write SetImgHeight;
    property ImageWidth:  integer read GetImgWidth  write SetImgWidth;
    property Image: TPngGraphic read FImage write SetImage stored BitmapStored;
    property BorderDrawModes: TacBorderDrawModes read FBorderDrawModes write FBorderDrawModes stored True;
    property ClientMargins: TacBordersSizes read FClientMargins write SetClientMargins;
    property BordersWidths: TacBordersSizes read FBordersWidths write SetBordersWidths;
    property ShadowSizes:   TacBordersSizes read FShadowSizes   write SetShadowSizes;
  end;


  TacHintAlign = (haHorzCenter, haVertCenter);

  TacHintTemplate = class(TCollectionItem)
  private
    FImageDefault,
    FImageRightTop,
    FImageLeftBottom,
    FImageRightBottom: TacHintImage;

    FFont: TFont;
    FName: acString;
    FHintAlign: TacHintAlign;
    procedure SetHintImage(const Index: Integer; const Value: TacHintImage);
    procedure SetFont(const Value: TFont);
  protected
    FOwner: TacHintTemplates;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function SingleImageUsed: boolean;
  published
    property ImageDefault    : TacHintImage index 0 read FImageDefault     write SetHintImage;
    property Img_LeftBottom  : TacHintImage index 1 read FImageLeftBottom  write SetHintImage;
    property Img_RightBottom : TacHintImage index 2 read FImageRightBottom write SetHintImage;
    property Img_RightTop    : TacHintImage index 3 read FImageRightTop    write SetHintImage;
    property Font: TFont read FFont write SetFont;
    property HintAlign: TacHintAlign read FHintAlign write FHintAlign default haHorzCenter;
    property Name: acString read FName write FName;
  end;


  TacHintTemplates = class(TCollection)
  protected
    FOwner: TsAlphaHints;
    function GetItem (Index: Integer): TacHintTemplate;
    procedure SetItem(Index: Integer; Value: TacHintTemplate);
    function GetOwner: TPersistent; override;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TsAlphaHints);
    destructor Destroy; override;
    property Items[Index: Integer]: TacHintTemplate read GetItem write SetItem; default;
  end;


  TsShowTimer = class(TacThreadedTimer)
  public
    x,
    y,
    dx,
    dy,
    StepB: real;

    HintWidth,
    HintHeight: integer;

    Step,
    StepCount,
    Transparency: integer;

    SrcRect: TRect;
    FBmpSize: TSize;
    FBmpTopLeft: TPoint;
    CurrentHintForm: TacCustomHintWindow;

    procedure Init(HintForm: TacCustomHintWindow; w, h: integer);
    procedure IntOnTimer(Sender: TObject);
  end;


  TacShowHintData = record
    Width,
    Height: integer;
    Position: TPoint;
    Caption: acString;
    Control: TControl;
    Image: TBitmap;
    ImageAlignment: TacSide;
  end;


  TacHintState = (hsNormal, hsInit);
{$ENDIF}

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsAlphaHints = class(TComponent)
{$IFNDEF NOTFORHELP}
  private
    FMaxWidth,
    FPauseHide,
    FOldHintPause: integer;

    FAnimated,
    FHTMLMode,
    FAutoAlignment: boolean;

    FHintPos: TPoint;
    FOnPaint: TacPaintEvent;
    FTextAlignment: TAlignment;
    FOnMeasure: TacMeasureEvent;
    TmpShowData: TacShowHintData;
    FOnShowHint: TacShowHintEvent;
    FDefaultMousePos: TacMousePosition;
{$IFNDEF ACHINTS}
    FActive,
    FUseSkinData: boolean;

    FOnChange,
    FOnHideHint: TNotifyEvent;

    HintTimeCtrl: TControl;
    FTemplateIndex: integer;
    FTemplateName: TacStrValue;
    FSkinSection: TsSkinSection;
    FTemplates: TacHintTemplates;
{$ENDIF}
    function GetAnimated: boolean;
{$IFNDEF ACHINTS}
    procedure SetActive       (const Value: boolean);
    procedure SetSkinData     (const Value: boolean);
    procedure SetPauseHide    (const Value: integer);
{$ENDIF}
    procedure SetTemplates    (const Value: TacHintTemplates);
    procedure SetTemplateName (const Value: TacStrValue);
    procedure SetAutoAlignment(const Value: boolean);
    procedure UpdateHWClass;
  protected
    HideTimer,
    CheckTimer: TacThreadedTimer;

    FCacheBmp,
    OldAlphaBmp: TBitmap;

    Blend: real;
    State: TacHintState;
    CmpChanging: boolean;
    ShowTimer: TsShowTimer;
    CurrentHintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo;
    procedure AssignTo(Dest: TPersistent); override;
    procedure ResetHintInfo;
    procedure OnHideTimer (Sender: TObject);
    procedure OnCtrlTimer (Sender: TObject);
    procedure OnCheckTimer(Sender: TObject);
  public
    NewWindow,
    AnimWindow: TForm;
    FHintLocation: TPoint;

    HintShowing: boolean;
    HintFrame: TFrame;

    HintWindow: {$IFDEF TNTUNICODE}TTntHintWindow{$ELSE}THintwindow{$ENDIF};

    NewBounds: TRect;
    procedure OnShowHintApp(var HintStr: string; var CanShow: Boolean; var HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Changed;
    procedure CheckAutoHintPos;
    procedure InitTemplate;
    procedure AfterConstruction; override;
    procedure ShowHint(TheControl: TControl; const HintText: string; HideTime: word = 0); overload;
    procedure ShowHint(Position:   TPoint;   const HintText: string; HideTime: word = 0); overload;
    procedure ShowHint(ShowHintData: TacShowHintData;                HideTime: word = 0); overload;
    procedure HideHint;
    procedure HideAll;
    procedure KillTimer;
    procedure RepaintHint;
    function Skinned: boolean;
    procedure SaveToStream(AStream: TMemoryStream);
    procedure SaveToFile(FileName: string);
    procedure StartCheckTimer;
    procedure StartHideTimer(HideTime: integer = 0);

    function LoadFromStream(AStream: TMemoryStream): TacHintTemplate;
    function LoadFromFile(FileName: string): TacHintTemplate;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property DefaultMousePos: TacMousePosition read FDefaultMousePos write FDefaultMousePos default mpLeftTop;
    property IsHintShowing: Boolean read HintShowing;
    property TemplateIndex: integer read FTemplateIndex;
  published
{$ENDIF}
    property Active: boolean read FActive write SetActive default True;
    property AutoAlignment: boolean read FAutoAlignment write SetAutoAlignment default False;
    property Animated: boolean read GetAnimated write FAnimated default True;
    property MaxWidth: integer read FMaxWidth write FMaxWidth default 120;
    property Templates: TacHintTemplates read FTemplates write SetTemplates;
    property TemplateName: TacStrValue read FTemplateName write SetTemplateName;
    property TextAlignment: TAlignment read FTextAlignment write FTextAlignment default taCenter;
    property HTMLMode: boolean read FHTMLMode write FHTMLMode default False;
    property PauseHide: integer read FPauseHide write SetPauseHide default 5000;
{$IFNDEF ACHINTS}
    property SkinSection: TsSkinSection read FSkinSection write FSkinSection;
    property UseSkinData: boolean read FUseSkinData write SetSkinData default False;
{$ENDIF}
    property OnShowHint: TacShowHintEvent read FOnShowHint write FOnShowHint;
    property OnHideHint: TNotifyEvent read FOnHideHint write FOnHideHint;
    property OnMeasure: TacMeasureEvent read FOnMeasure write FOnMeasure;
    property OnPaint: TacPaintEvent read FOnPaint write FOnPaint;
  end;


{$IFNDEF NOTFORHELP}
  TacCustomHintWindow = class({$IFDEF TNTUNICODE}TTntHintWindow{$ELSE}THintWindow{$ENDIF})
  private
    Text: string;
    procedure PrepareMask;
    procedure WMEraseBkGND(var Message: TWMPaint);   message WM_ERASEBKGND;
    procedure WMNCPaint   (var Message: TWMPaint);   message WM_NCPaint;
    procedure WMDestroy   (var Message: TWMDestroy); message WM_DESTROY;
  protected
    BodyBmp,
    MaskBmp,
    AlphaBmp: TBitmap;

    BGIndex,
    SkinIndex,
    BorderIndex: integer;

    rgn: hrgn;
    FMousePos: TacMousePosition;
    procedure CreateAlphaBmp(const Width, Height: integer); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetMask: TBitmap;
    function GetBody: TBitmap;
    function GetMousePosition: TPoint;
    function MainRect: TRect;
    function SkinMargin(Border: byte): integer;
    procedure TextOut(Bmp: TBitmap);
    function FullLayer: boolean;
    function ShadowSizes: TRect;
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
  public
    procedure ActivateHint(Rect: TRect; const AHint: string); {$IFNDEF TNTUNICODE} override; {$ENDIF}
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; {$IFNDEF TNTUNICODE} override; {$ENDIF}
    function CreateHintWindow(R: TRect): TForm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoDestroy; virtual;
    procedure OnCloseHint;
    function GetArrowPos(var Rect: TRect; const mPos: TPoint): TacMousePosition;
    procedure UpdateWnd(w, h: integer);
  end;


var
  Manager: TsAlphaHints;
{$ENDIF}

{$IFDEF ACHINTS}
procedure Register;
{$ENDIF}

implementation

uses
  math,
  {$IFNDEF WIN64} acZLibEx, {$ELSE} ZLib, {$ENDIF}
  {$IFNDEF ACHINTS} sVclUtils, sMessages, sSkinProps, sSkinManager, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sAlphaGraph, sStyleSimply;

{$R acHints.res}

const
  SkinBorderWidth = 4;

  acAlignmentArray: array [TAlignment] of word = (DT_LEFT, DT_RIGHT, DT_CENTER);


var
  Image:           TacHintImage    = nil;
  acHintWindow:    THintWindow     = nil;
  DefaultTemplate: TacHintTemplate = nil;
  Template:        TacHintTemplate = nil;
  acLocalUpd:      boolean         = False;


type
  TacPngHintWindow = class(TacCustomHintWindow)
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoDestroy; override;
    procedure CreateAlphaBmp(const Width, Height: integer); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; {$IFNDEF TNTUNICODE} override; {$ENDIF}
  end;


{$IFDEF ACHINTS}
procedure Register;
begin
  RegisterComponents('AlphaTools', [TsAlphaHints]);
end;
{$ENDIF}


constructor TsAlphaHints.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTemplateIndex := -1;
  FCacheBmp := CreateBmp32;
  HintFrame := nil;
  FHTMLMode := False;
  FHintLocation.X := 0;
  FHintLocation.Y := 0;
  FPauseHide := 5000;
  FMaxWidth := 120;
  FDefaultMousePos := mpLeftTop;
  FTextAlignment := taCenter;
  FTemplates := TacHintTemplates.Create(Self);
  HintShowing := False;
  FAnimated := True;
  FAutoAlignment := False;
  FActive := True;
  AnimWindow := nil;
  State := hsNormal;
  OldAlphaBmp := nil;
  Blend := 0;
end;


destructor TsAlphaHints.Destroy;
begin
  Application.OnShowHint := nil;
  HintWindowClass := THintWindow;
  UpdateHWClass;
  FreeAndNil(FTemplates);
  FreeAndNil(FCacheBmp);

  HideTimer.Free;
  if ShowTimer <> nil then
    FreeAndNil(ShowTimer);

  if AnimWindow <> nil then
    FreeAndNil(AnimWindow);

  if NewWindow <> nil then
    FreeAndNil(NewWindow);

  if CheckTimer <> nil then
    CheckTimer.Free;

  if OldAlphaBmp <> nil then
    FreeAndNil(OldAlphaBmp);
    
  inherited;
end;


procedure TsAlphaHints.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) and (Tag <> ExceptTag) then begin
    Application.HintHidePause := FPauseHide;
    FHintPos := Point(-1, -1);
    Application.OnShowHint := OnShowHintApp;
  end;
{$IFNDEF ACHINTS}
  if FSkinSection = '' then
    FSkinSection := s_Hint;
{$ENDIF}
  UpdateHWClass;
end;


procedure TsAlphaHints.OnShowHintApp(var HintStr: string; var CanShow: Boolean; var HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo);
begin
  FHintPos := HintInfo.HintPos;
  if FAutoAlignment then begin
    CurrentHintInfo := HintInfo;
    InitTemplate;
    CheckAutoHintPos;
    HintInfo.HintPos := FHintPos;
  end;

  if Assigned(FOnShowHint) then begin
    ResetHintInfo;
    FOnShowHint(HintStr, CanShow, HintInfo, HintFrame)
  end
  else
    inherited;

  CurrentHintInfo := HintInfo;
  if (FHintPos.x <> HintInfo.HintPos.x) or (FHintPos.y <> HintInfo.HintPos.y) then
    FHintPos := HintInfo.HintPos;
end;


procedure TsAlphaHints.ShowHint(TheControl: TControl; const HintText: string; HideTime: word = 0);
var
  b: boolean;
  HL: TPoint; // Hint location
  HintRect: TRect;
  NewText: string;
  HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo;
begin
  if (ShowTimer <> nil) and ShowTimer.Enabled then begin
    FreeAndNil(AnimWindow);
    AnimWindow := NewWindow;
    NewWindow := nil;
    FreeAndNil(ShowTimer);
  end;
  if Assigned(TheControl) then begin
    HintTimeCtrl := TheControl;
    HL := MkPoint;
    // Does hint need to be created?
    if not Assigned(HintWindow) then
      HintWindow := TacPngHintWindow.Create(Self);

    // Was hint creation successful?
    if Assigned(HintWindow) then
      with TacCustomHintWindow(HintWindow) do begin
        HintRect := CalcHintRect(iff(FMaxWidth < 1, Screen.Width, FMaxWidth), HintText, nil);

        FHintLocation := TheControl.ClientToScreen(HL);
        FHintLocation := Point(FHintLocation.x + TheControl.Width div 2, FHintLocation.Y + TheControl.Height div 3);
        if Assigned(OnShowHint) then begin
          b := True;
          HintFrame := nil;
          HintInfo.HintControl := TheControl;
          HintInfo.HintPos := FHintLocation;
          // Save orig. props
          Text := HintText;
          ResetHintInfo;
          NewText := HintText;
          OnShowHint(NewText, b, HintInfo, HintFrame);
          if (NewText <> HintText) or (HintFrame <> nil) then
            HintRect := CalcHintRect(iff(FMaxWidth < 1, Screen.Width, FMaxWidth), NewText, NIL);

          CurrentHintInfo := HintInfo;
          FHintLocation := HintInfo.HintPos;
        end
        else
          if HintText <> '' then begin
            NewText := HintText;
            HintRect := CalcHintRect(iff(FMaxWidth < 1, Screen.Width, FMaxWidth), NewText, NIL);
          end;

        ActivateHint(HintRect, NewText);
        Manager.FHintLocation := Point(0, 0);
      end;

    StartHideTimer(HideTime);
  end;
end;


procedure TsAlphaHints.ShowHint(ShowHintData: TacShowHintData; HideTime: word = 0);
var
  HL: TPoint; // Hint location
  HintRect: TRect;
  NewText: string;
begin
  if (ShowTimer <> nil) and ShowTimer.Enabled then begin
    FreeAndNil(AnimWindow);
    AnimWindow := NewWindow;
    NewWindow := nil;
    FreeAndNil(ShowTimer);
  end;
  if Manager <> nil then begin
    if ShowHintData.Control <> nil then
      HintTimeCtrl := ShowHintData.Control
    else
      HintTimeCtrl := CtrlUnderMouse;

    TmpShowData := ShowHintData;
    if TmpShowData.Control <> nil then
      HL := MkPoint
    else
      HL := ShowHintData.Position;
    // Does hint need to be created?
    if not Assigned(HintWindow) then
      HintWindow := TacPngHintWindow.Create(Self);

    // Was hint creation successful?
    if Assigned(HintWindow) then
      with TacCustomHintWindow(HintWindow) do begin
        FMousePos := Manager.FDefaultMousePos;
        HintRect := Rect(HL.X, HL.Y, HL.X + TmpShowData.Width, HL.Y + TmpShowData.Height);
        FHintLocation := HL;
        HintRect := CalcHintRect(TmpShowData.Width, TmpShowData.Caption, @TmpShowData);
        ActivateHint(HintRect, NewText);
        Manager.FHintLocation := Point(0, 0);
      end;

    StartHideTimer(HideTime);
    FillMemory(@TmpShowData, SizeOf(TmpShowData), 0);
  end;
end;


procedure TsAlphaHints.HideHint;
begin
  HintFrame := nil;
  FreeAndNil(HintWindow);
  HintTimeCtrl := nil;
end;


procedure TsAlphaHints.HideAll;
begin
  ResetHintInfo;
  HideHint;
  FreeAndNil(AnimWindow);
  FreeAndNil(NewWindow);
end;


procedure TsAlphaHints.AfterConstruction;
begin
  inherited;
{$IFNDEF ACHINTS}
  if FSkinSection = '' then
    FSkinSection := s_Hint;
{$ENDIF}
end;


function TsAlphaHints.GetAnimated: boolean;
begin
  Result := FAnimated;
end;


function TsAlphaHints.Skinned: boolean;
begin
{$IFNDEF ACHINTS}
  if Assigned(Manager) and Assigned(DefaultManager) and UseSkinData then
    Result := (Manager.SkinSection <> '') and (DefaultManager.GetSkinIndex(Manager.SkinSection) >= 0)
  else
{$ENDIF}
    Result := False
end;


{$IFNDEF ACHINTS}
procedure TsAlphaHints.SetSkinData(const Value: boolean);
begin
  FUseSkinData := Value;
end;
{$ENDIF}


procedure TsAlphaHints.SetPauseHide(const Value: integer);
begin
  if FPauseHide <> Value then begin
    FPauseHide := Value;
    if not (csDesigning in ComponentState) and (Tag <> ExceptTag) then
      Application.HintHidePause := FPauseHide;
  end;
end;


procedure TsAlphaHints.SetActive(const Value: boolean);
begin
  FActive := Value;
  if not FActive then
    HideAll;

  UpdateHWClass;
end;


procedure TsAlphaHints.UpdateHWClass;
begin
  if not (csDesigning in ComponentState) and (Tag <> ExceptTag) {Edit mode for component in editor} then
    if FActive and acLayered and not (csDestroying in ComponentState) then begin
      Manager := Self;
      HintWindowClass := TacPngHintWindow
    end
    else begin
      Manager := nil;
      HintWindowClass := THintWindow;
    end;
end;


procedure TsAlphaHints.SetTemplates(const Value: TacHintTemplates);
begin
  FTemplates.Assign(Value);
end;


procedure TsAlphaHints.SetTemplateName(const Value: TacStrValue);
var
  i: integer;
begin
  FTemplateIndex := -1;
  FTemplateName := Value;
  for i := 0 to Templates.Count - 1 do
    if UpperCase(Templates[i].Name) = UpperCase(Value) then begin
      FTemplateIndex := i;
      Break;
    end;
end;


procedure TsAlphaHints.SetAutoAlignment(const Value: boolean);
begin
  FAutoAlignment := Value;
  FHintLocation := Point(0, 0);
end;


procedure TsAlphaHints.AssignTo(Dest: TPersistent);
var
  DstCmp: TsAlphaHints;
begin
  if Dest <> nil then begin
    DstCmp := TsAlphaHints(Dest);
    DstCmp.Templates.Clear;
    Templates.AssignTo(DstCmp.Templates);
    DstCmp.TemplateName := TemplateName;
    DstCmp.Animated := Animated;
    DstCmp.AutoAlignment := AutoAlignment;
    DstCmp.DefaultMousePos := DefaultMousePos;
    DstCmp.HTMLMode := HTMLMode;
    DstCmp.PauseHide := PauseHide;
    DstCmp.SkinSection := SkinSection;
    DstCmp.UseSkinData := UseSkinData;
  end
  else
    inherited;
end;


procedure TsAlphaHints.Changed;
begin
  if not (csLoading in ComponentState) and Assigned(FOnChange) then
    FOnChange(Self);
end;


procedure TsAlphaHints.CheckAutoHintPos;
var
  R: TRect;

  function GetControlRect(Ctrl: TControl): TRect;
  begin
    if Ctrl is TWinControl then
      GetWindowRect(TWinControl(Ctrl).Handle, Result)
    else begin
      GetWindowRect(Ctrl.Parent.Handle, Result);
      inc(Result.Top,  Ctrl.Top);
      inc(Result.Left, Ctrl.Left);
      Result.Right  := Result.Left + Ctrl.Width;
      Result.Bottom := Result.Top  + Ctrl.Height;
    end;
  end;

begin
  if (Manager <> nil) and Manager.AutoAlignment and (Manager.CurrentHintInfo.HintControl <> nil) then begin
    R := GetControlRect(Manager.CurrentHintInfo.HintControl);
    if Template.HintAlign = haHorzCenter then begin
      Manager.FHintPos.X := R.Left + WidthOf(R) div 2;
      if (Image = Template.FImageRightBottom) or (Image = Template.FImageLeftBottom) then
        Manager.FHintPos.Y := R.Top
      else
        Manager.FHintPos.Y := R.Bottom;
    end
    else begin
      Manager.FHintPos.Y := R.Top + HeightOf(R) div 2;
      if (Image = Template.FImageRightTop) or (Image = Template.FImageRightBottom) then
        Manager.FHintPos.X := R.Left
      else
        Manager.FHintPos.X := R.Right;
    end;
    if (Image = Template.FImageRightTop) or (Image = Template.FImageRightBottom) then
      dec(Manager.FHintPos.X, Image.ShadowSizes.Right)
    else
      inc(Manager.FHintPos.X, Image.ShadowSizes.Left);

    if (Image = Template.FImageRightBottom) or (Image = Template.FImageLeftBottom) then
      dec(Manager.FHintPos.Y, Image.ShadowSizes.Bottom)
    else
      inc(Manager.FHintPos.Y, Image.ShadowSizes.Top);

    inc(Manager.FHintPos.X, Image.OffsetHorz); // yello
    inc(Manager.FHintPos.Y, Image.OffsetVert);
    FHintLocation := Manager.FHintPos;
  end;
end;


procedure TsAlphaHints.InitTemplate;
begin
  if (TemplateIndex >= 0) and (TemplateIndex < Templates.Count) then
    Template := Templates[FTemplateIndex]
  else
    Template := DefaultTemplate;

  if (Self.DefaultMousePos <> mpLeftTop) and not Template.SingleImageUsed then
    case Self.DefaultMousePos of
      mpLeftBottom:  Image := Template.Img_LeftBottom;
      mpRightTop:    Image := Template.Img_RightTop;
      mpRightBottom: Image := Template.FImageRightBottom;
    end
  else
    Image := Template.FImageDefault;
end;


procedure TsAlphaHints.ShowHint(Position: TPoint; const HintText: string; HideTime: word = 0);
var
  b: boolean;
  HintRect: TRect;
  NewText: string;
  TmpCtrl: TControl;
  HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo;
begin
  if (ShowTimer <> nil) and ShowTimer.Enabled then begin
    FreeAndNil(AnimWindow);
    AnimWindow := NewWindow;
    NewWindow := nil;
    FreeAndNil(ShowTimer);
  end;
  TmpCtrl := CtrlUnderMouse;
  if HintTimeCtrl <> TmpCtrl then
    HideAll;

  HintTimeCtrl := TmpCtrl;
  // Does hint need to be created?
  if not Assigned(HintWindow) then
    HintWindow := TacPngHintWindow.Create(Self);

  // Was hint creation successful?
  if Assigned(HintWindow) then begin
    with TacCustomHintWindow(HintWindow) do begin
      FHintLocation := Position;
      HintRect := CalcHintRect(iff(FMaxWidth < 1, Screen.Width, FMaxWidth), HintText, nil);
      if Assigned(OnShowHint) then begin
        b := True;
        HintFrame := nil;
        HintInfo.HintControl := nil;
        HintInfo.HintPos := FHintLocation;
        // Save orig. props
        Text := HintText;
        ResetHintInfo;
        NewText := HintText;
        OnShowHint(NewText, b, HintInfo, HintFrame);
        if (NewText <> HintText) or (HintFrame <> nil) then
          HintRect := CalcHintRect(iff(FMaxWidth < 1, Screen.Width, FMaxWidth), NewText, nil);

        FHintLocation := HintInfo.HintPos;
      end
      else
        if HintText <> '' then begin
          NewText := HintText;
          HintRect := CalcHintRect(iff(FMaxWidth < 1, Screen.Width, FMaxWidth), NewText, nil);
        end;

      ActivateHint(HintRect, NewText);
      FHintLocation := Point(0, 0);
    end;
    StartHideTimer(HideTime);
  end;
end;


procedure TsAlphaHints.KillTimer;
begin
  if (ShowTimer <> nil) and ShowTimer.Enabled then begin // If animation is not finished
    ShowTimer.Enabled := False; // Can be removed?
    FreeAndNil(ShowTimer);
  end;
end;


procedure TsAlphaHints.RepaintHint;
var
  b: boolean;
  HintInfo: {$IFDEF D2009}Controls.{$ENDIF}THintInfo;
  F: TFrame;
begin
  if (acHintWindow <> nil) and HintShowing then begin
    if Assigned(OnShowHint) then begin
      b := True;
      F := HintFrame;
      HintInfo := CurrentHintInfo;
      OnShowHint(HintInfo.HintStr, b, HintInfo, F);
      CurrentHintInfo := HintInfo;
    end;
    TacCustomHintWindow(acHintWindow).UpdateWnd(0, 0);
  end;
end;


procedure TsAlphaHints.ResetHintInfo;
begin
  if Assigned(HintFrame) then
    FreeAndNil(HintFrame);

  if Manager <> nil then
    Manager.HintShowing := False;
end;


procedure TacCustomHintWindow.ActivateHint(Rect: TRect; const AHint: string);
{$IFNDEF ACHINTS}
var
  w, h: integer;
  p: TPoint;
{$ENDIF}
begin
{$IFNDEF ACHINTS}
  if Assigned(Manager) then begin
    Manager.State := hsInit;
    FreeAndNil(Manager.CheckTimer);
    Manager.HintShowing := True;

    if (Manager.AnimWindow <> nil) then // If moved
      if (Manager.AnimWindow.Width = 0) or (Manager.AnimWindow.Left = 0) and (Manager.AnimWindow.Top = 0) then
        FreeAndNil(Manager.AnimWindow) // Fix for DevEx hints
      else
        if (Manager.ShowTimer <> nil) and Manager.ShowTimer.Enabled then begin // If prev animation is not finished
          Manager.KillTimer;
          if Manager.NewWindow = nil then // If was showing animation
            if AlphaBmp <> nil then begin
              if Manager.OldAlphaBmp <> nil then
                Manager.OldAlphaBmp.Free;

              Manager.OldAlphaBmp := AlphaBmp;
              AlphaBmp := nil;
            end;
        end;

    Manager.KillTimer;
//    Application.ProcessMessages; // Patch for refresh of columns in cxGrid
    if Manager.Active then
      Text := AHint
    else
      Caption := AHint;

    if (Manager.FHintLocation.X = 0) or (Manager.FHintLocation.Y = 0) then
      p := Rect.TopLeft
    else
      p := Manager.FHintLocation;

    w := WidthOf(Rect);
    h := HeightOf(Rect);
    OffsetRect(Rect, p.x - Rect.Left - ShadowSizes.Left, p.y - Rect.Top - ShadowSizes.Top);

    // Show std window as fully transparent //
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED or WS_EX_NOACTIVATE);
    SetBounds(Rect.Left, Rect.Top, w, h);
    SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) and not NCS_DROPSHADOW);
    ShowWindow(Handle, SW_SHOWNOACTIVATE);

    FMousePos := GetArrowPos(Rect, p);
    if not Manager.Skinned and (FMousePos in [mpLeftBottom, mpRightBottom]) and not Manager.AutoAlignment then
      dec(Rect.Top, 16);

    Rect.Right := Rect.Left + w;
    Rect.Bottom := Rect.Top + h;
    Manager.FCacheBmp.Width := w;
    Manager.FCacheBmp.Height := h;

    Manager.NewBounds := Rect;
    if Manager.AnimWindow = nil then
      Manager.AnimWindow := CreateHintWindow(Rect);

    if acLayered then
      if Manager.Animated then begin
        FreeAndNil(Manager.ShowTimer);
        Manager.ShowTimer := TsShowTimer.Create(nil);
        Manager.ShowTimer.Enabled := False;
        Manager.ShowTimer.Init(Self, w, h)
      end
      else begin
        if IsNTFamily then begin
          CreateAlphaBmp(w, h);
          SetFormBlendValue(Manager.AnimWindow.Handle, AlphaBmp, MaxByte);
          ShowWindow(Manager.AnimWindow.Handle, SW_SHOWNOACTIVATE);
          SetWindowPos(Manager.AnimWindow.Handle, HWND_TOPMOST, Manager.NewBounds.Left, Manager.NewBounds.Top, w, h, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOOWNERZORDER);
        end
        else
          SetWindowPos(Manager.AnimWindow.Handle, HWND_TOPMOST, 0, 0, w, h, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOOWNERZORDER);

        if AlphaBmp <> nil then begin
          if Manager.OldAlphaBmp <> nil then
            Manager.OldAlphaBmp.Free;

          Manager.OldAlphaBmp := AlphaBmp;
          AlphaBmp := nil;
        end;
      end;

    Manager.State := hsNormal;
    Manager.FHintPos.x := -1;
{$ELSE}
    inherited;
{$ENDIF}
    if Manager.TmpShowData.Control <> nil then
      Manager.HintTimeCtrl := Manager.TmpShowData.Control
    else
      Manager.HintTimeCtrl := CtrlUnderMouse;

    Manager.StartHideTimer;
  end;
end;


constructor TacCustomHintWindow.Create(AOwner: TComponent);
begin
  inherited;
  acHintWindow := Self;
  BorderWidth  := 0;
  SkinIndex    := -1;
  BorderIndex  := -1;
  BGIndex      := -1;
end;


procedure TacCustomHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not WS_BORDER;
end;


function TacCustomHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
var
  sHTML: TsHtml;
  Lnks: TacLinks;
  i, w, h: integer;
  HintText: acString;
  HintInfo: THintInfo;
begin
  if Assigned(Manager) then begin
{$IFNDEF ACHINTS}
    if Manager.Skinned and Assigned(DefaultManager) and DefaultManager.Active then begin
      SkinIndex := DefaultManager.GetSkinIndex(Manager.SkinSection);
      if SkinIndex >= 0 then begin
        BorderIndex := DefaultManager.GetMaskIndex(SkinIndex, s_BordersMask);
        BGIndex     := DefaultManager.GetTextureIndex(SkinIndex, Manager.SkinSection, s_Pattern);
      end
      else begin
        SkinIndex   := DefaultManager.ConstData.Sections[ssEdit];
        BorderIndex := DefaultManager.GetMaskIndex(SkinIndex, s_BordersMask);
        BGIndex     := DefaultManager.GetTextureIndex(SkinIndex, s_Edit, s_Pattern);
      end;
    end;
{$ENDIF}
    if Manager.TmpShowData.Width <> 0 then
      Result := Rect(0, 0, Manager.TmpShowData.Width, Manager.TmpShowData.Height)
    else begin
      if Manager.HintFrame <> nil then
        Result := MkRect(Manager.HintFrame)
      else begin
{$IFDEF TNTUNICODE}
        if (TntApplication <> nil) and (TntApplication.Hint <> '') then
          HintText := TntApplication.Hint
        else
          HintText := AHint;
{$ELSE}
        HintText := AHint;
{$ENDIF}
        Result := MkRect(iff(Manager.MaxWidth <= 0, Screen.Width, Manager.MaxWidth), 0);
{$IFNDEF ACHINTS}
        if Manager.Skinned then
          Manager.FCacheBmp.Canvas.Font.Assign(Screen.HintFont);
{$ENDIF}
        if Manager.FHTMLMode then begin
          sHTML := TsHtml.Create;
          sHTML.Init(Manager.FCacheBmp, HintText, Result);
          Result := sHTML.HtmlText(Lnks, True);
          FreeAndNil(sHTML);
        end
        else
          acDrawText(Manager.FCacheBmp.Canvas.Handle, PacChar(HintText), Result, DT_CALCRECT or acAlignmentArray[Manager.TextAlignment] or DT_VCENTER or DT_WORDBREAK or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly);
      end;

      if Assigned(Manager.OnMeasure) then begin
        HintInfo.HintControl := Manager.CurrentHintInfo.HintControl;
        HintInfo.HintPos := Manager.CurrentHintInfo.HintPos;
        w := WidthOf(Result);
        h := HeightOf(Result);
        Manager.OnMeasure(HintText, HintInfo, w, h);
        Result.Right := Result.Left + w;
        Result.Bottom := Result.Top + h;
      end;
    end;

    if Manager.Skinned then begin
      i := SkinMargin(0) + SkinMargin(2) + SkinBorderWidth * 2;
      Inc(Result.Right, i);
      Inc(Result.Bottom, SkinMargin(1) + SkinMargin(3) + SkinBorderWidth * 2);
    end;
  end;
end;


procedure TacCustomHintWindow.WMEraseBkGND(var Message: TWMPaint);
begin
  Message.Result := 1;
end;


procedure TacCustomHintWindow.WMNCPaint(var Message: TWMPaint);
begin
  if Assigned(Manager) then
    PrepareMask;

  Message.Result := 1;
end;


procedure TacCustomHintWindow.TextOut(Bmp: TBitmap);
const
  TextIdent = 4;
var
  DefaultDraw: boolean;
  aText: acString;
  Lnks: TacLinks;
{$IFNDEF ACHINTS}
  Flags: Integer;
{$ENDIF}
  R, RCalc, RText: TRect;
  GlyphPos: TPoint;
  SaveIndex: hdc;
  sHTML: TsHtml;
  i: integer;
begin
  R := MainRect;
  if Manager.Skinned then begin
    R.Left   := R.Left   + SkinMargin(0) + SkinBorderWidth;
    R.Top    := R.Top    + SkinMargin(1) + SkinBorderWidth;
    R.Right  := R.Right  - SkinMargin(2) - SkinBorderWidth;
    R.Bottom := R.Bottom - SkinMargin(3) - SkinBorderWidth;
  end
  else begin
    inc(R.Left,   Image.ClientMargins.Left);
    inc(R.Top,    Image.ClientMargins.Top);
    dec(R.Right,  Image.ClientMargins.Right);
    dec(R.Bottom, Image.ClientMargins.Bottom);
  end;

  DefaultDraw := True;
  if Manager.TmpShowData.Width <> 0 then begin // If manual showing with HintShowData struct
    if Manager.TmpShowData.Image <> nil then begin
      case Manager.TmpShowData.ImageAlignment of
        asLeft: begin
          GlyphPos.X := R.Left;
          GlyphPos.Y := R.Top + (Manager.TmpShowData.Height - Manager.TmpShowData.Image.Height) div 2;
          inc(R.Left, Manager.TmpShowData.Image.Width + TextIdent);
        end;

        asRight: begin
          GlyphPos.X := R.Left + Manager.TmpShowData.Width - Manager.TmpShowData.Image.Width;
          GlyphPos.Y := R.Top + (Manager.TmpShowData.Height - Manager.TmpShowData.Image.Height) div 2;
          dec(R.Right, Manager.TmpShowData.Image.Width + TextIdent);
        end;

        asTop: begin
          GlyphPos.X := R.Left + (Manager.TmpShowData.Width - Manager.TmpShowData.Image.Width) div 2;
          GlyphPos.Y := R.Top;
          inc(R.Top, Manager.TmpShowData.Image.Height + TextIdent);
        end;

        asBottom: begin
          GlyphPos.X := R.Left + (Manager.TmpShowData.Width - Manager.TmpShowData.Image.Width) div 2;
          GlyphPos.Y := R.Top + Manager.TmpShowData.Height - Manager.TmpShowData.Image.Height;
          dec(R.Bottom, Manager.TmpShowData.Image.Height + TextIdent);
        end;
      end;

      if Manager.TmpShowData.Image.PixelFormat = pf32bit then
        CopyBmp32(Rect(GlyphPos.X, GlyphPos.Y, GlyphPos.X + Manager.TmpShowData.Image.Width, GlyphPos.Y + Manager.TmpShowData.Image.Height),
                MkRect(Manager.TmpShowData.Image), Bmp, Manager.TmpShowData.Image, EmptyCI, False, Graphics.clNone, 0, False)
      else
        Bmp.Canvas.Draw(GlyphPos.X, GlyphPos.Y, Manager.TmpShowData.Image);
    end;

    if Manager.TmpShowData.Caption <> '' then
      RCalc := R;
      acDrawText(Bmp.Canvas.Handle, PacChar(Manager.TmpShowData.Caption), RCalc, DT_NOPREFIX or DT_WORDBREAK or DT_CALCRECT);
      RText.Left := R.Left + (WidthOf(R) - WidthOf(RCalc)) div 2;
      RText.Top := R.Top + (HeightOf(R) - HeightOf(RCalc)) div 2;
      RText.Right := RText.Left + WidthOf(RCalc);
      RText.Bottom := RText.Top + HeightOf(RCalc);

      if Manager.Skinned then begin
        Flags := DT_EXPANDTABS or DT_NOCLIP or DT_WORDBREAK or acAlignmentArray[Manager.TextAlignment] or DrawTextBiDiModeFlagsReadingOnly or DT_VCENTER;
        if Application.IsRightToLeft then
          Flags := Flags or DT_RTLREADING;

        WriteText32(Bmp, PacChar(Manager.TmpShowData.Caption), True, RText, Flags, SkinIndex, False, DefaultManager);
      end
      else begin
        if (Template <> nil) then
          Bmp.Canvas.Font.Color := Template.Font.Color;

        Bmp.Canvas.Brush.Style := bsClear;
        if Bmp.Canvas.Font.Color < 0 then
          Bmp.Canvas.Font.Color := 0;

        acDrawText(Bmp.Canvas.Handle, PacChar(Manager.TmpShowData.Caption), RText, acAlignmentArray[Manager.TextAlignment] or DT_NOPREFIX or DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly or DT_VCENTER);
      end;
  end

  else begin
    if Assigned(Manager.OnPaint) then begin
{$IFDEF TNTUNICODE}
      if (TntApplication <> nil) and (TntApplication.Hint <> '') then
        aText := TntApplication.Hint
      else
{$ENDIF}
        aText := iff(Text <> '', Text, Caption);

      Manager.OnPaint(aText, Manager.CurrentHintInfo, R, Bmp, DefaultDraw);
    end;

    if DefaultDraw then
      if Manager.HintFrame <> nil then begin
        Manager.HintFrame.Visible := False;
        Manager.HintFrame.SetBounds(R.Left, R.Top, Manager.HintFrame.Width, Manager.HintFrame.Height);
        Manager.HintFrame.Parent := Self;
        Manager.HintFrame.Visible := True;
        SaveIndex := SaveDC(Bmp.Canvas.Handle);
        Bmp.Canvas.Lock;
        for i := 0 to Manager.HintFrame.ControlCount - 1 do
          if Manager.HintFrame.Controls[i].Visible then begin
            MovewindowOrg(Bmp.Canvas.Handle, R.Left + Manager.HintFrame.Controls[i].Left, R.Top + Manager.HintFrame.Controls[i].Top);
            Manager.HintFrame.Controls[i].Perform(WM_PAINT, WPARAM(Bmp.Canvas.Handle), 0);
            MovewindowOrg(Bmp.Canvas.Handle, -R.Left - Manager.HintFrame.Controls[i].Left, -R.Top - Manager.HintFrame.Controls[i].Top);
            FillAlphaRect(Bmp, R, MaxByte);
          end;
        // Next two line are called after labels painting for avoiding of "Reflected text" error
        Bmp.PixelFormat := pf32bit;
        Bmp.HandleType := bmDIB;
        Bmp.Canvas.UnLock;
        RestoreDC(Bmp.Canvas.Handle, SaveIndex);
      end
      else begin
        OffsetRect(R, -1, 0);
        Bmp.Canvas.Brush.Style := bsClear;
        Bmp.Canvas.Pen.Style := psSolid;
{$IFDEF TNTUNICODE}
        if (TntApplication <> nil) and (TntApplication.Hint <> '') then
          aText := TntApplication.Hint
        else
{$ENDIF}
          aText := iff(Text <> '', Text, Caption);

{$IFNDEF ACHINTS}
        if Manager.Skinned then
          Bmp.Canvas.Font.Assign(Screen.HintFont);
{$ENDIF}

        if Manager.FHTMLMode then begin
{$IFNDEF ACHINTS}
          if Manager.Skinned then
            Bmp.Canvas.Font.Color := DefaultManager.gd[SkinIndex].Props[0].Fontcolor.Color
          else
            if (Template <> nil) then
              Bmp.Canvas.Font.Color := Template.Font.Color;

          if Bmp.Canvas.Font.Color < 0 then
            Bmp.Canvas.Font.Color := 0;

{$ENDIF}
          sHTML := TsHtml.Create;
          sHTML.AlphaChannel := True;
          sHTML.Init(Bmp, aText, R);
          sHTML.HtmlText(Lnks);
          FreeAndNil(sHTML);
        end
        else
{$IFNDEF ACHINTS}
          if Manager.Skinned then begin
            Flags := DT_EXPANDTABS or DT_NOCLIP or DT_WORDBREAK or acAlignmentArray[Manager.TextAlignment] or DrawTextBiDiModeFlagsReadingOnly;
            if Application.IsRightToLeft then
              Flags := Flags or DT_RTLREADING;

            WriteText32(Bmp, PacChar(aText), True, R, Flags, SkinIndex, False, DefaultManager);
          end
          else
{$ENDIF}
          begin
            if (Template <> nil) then
              Bmp.Canvas.Font.Color := Template.Font.Color;

            if Bmp.Canvas.Font.Color < 0 then
              Bmp.Canvas.Font.Color := 0;

            acDrawText(Bmp.Canvas.Handle, PacChar(aText), R, acAlignmentArray[Manager.TextAlignment] or DT_NOPREFIX or DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
          end;
      end;
  end;
end;


function TacCustomHintWindow.MainRect: TRect;
begin
  Result := MkRect(WidthOf(Manager.NewBounds), HeightOf(Manager.NewBounds));
end;


procedure TacCustomHintWindow.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit
      end; // AlphaSkins supported

      AC_GETBG: begin
        PacBGInfo(Message.LParam)^.Bmp := BodyBmp;
        PacBGInfo(Message.LParam)^.Offset := MkPoint;
        if BodyBmp <> nil then
          PacBGInfo(Message.LParam)^.BgType := btCache
        else begin
          PacBGInfo(Message.LParam)^.BgType := btFill;
          PacBGInfo(Message.LParam)^.Color := Color;
        end;
        Exit;
      end;

      AC_CHILDCHANGED:
        Message.LParam := 1;
    end;

  inherited;
  if Manager <> nil then
    case Message.Msg of
      WM_SHOWWINDOW:
        case Message.WParam of
          1: // Show
            acHintWindow := Self;

          0: // Hide
            OnCloseHint;
        end;

      WM_SIZE, WM_MOVE:
        if (Manager.AnimWindow <> nil) and (Manager.State <> hsInit) then begin
          Manager.AnimWindow.SetBounds(Left, Top, Manager.AnimWindow.Width, Manager.AnimWindow.Height);
          Manager.NewBounds := Manager.AnimWindow.BoundsRect;
        end;
    end;
end;


procedure TacCustomHintWindow.DoDestroy;
begin
  OnCloseHint;
  if Manager <> nil then begin
    Manager.HintShowing := False;
    if AlphaBmp <> nil then begin
      if Manager.OldAlphaBmp <> nil then
        FreeAndNil(Manager.OldAlphaBmp);

      Manager.OldAlphaBmp := AlphaBmp;
      AlphaBmp := nil;
    end;
  end
  else
    if Assigned(AlphaBmp) then
      FreeAndNil(AlphaBmp);

  if Assigned(MaskBmp) then
    FreeAndNil(MaskBmp);

  if Assigned(BodyBmp) then
    FreeAndNil(BodyBmp);
end;


destructor TacCustomHintWindow.Destroy;
begin
  DoDestroy;
  inherited;
end;


procedure TacCustomHintWindow.WMDestroy(var Message: TWMDestroy);
begin
  DoDestroy;
  inherited;
end;


function TacCustomHintWindow.GetMousePosition: TPoint;
begin
  if (Manager.FHintPos.x = -1) then
    Result := acMousePos
  else
    Result := Manager.FHintPos;
end;


procedure TacCustomHintWindow.Paint;
begin
//
end;

procedure TacCustomHintWindow.PrepareMask;
begin
  rgn := 0;
  FreeAndNil(MaskBmp);
  MaskBmp := GetMask;
{$IFNDEF ACHINTS}
  if Assigned(MaskBmp) and Manager.Skinned then begin // Defining window region by MaskBmp
    GetRgnFromBmp(rgn, MaskBmp, clWhite);
    SetWindowRgn(Handle, rgn, False);
  end
{$ENDIF}
end;


function TacCustomHintWindow.GetMask: TBitmap;
{$IFNDEF ACHINTS}
var
  White, Black: TsColor_;
  x, y, h, w: integer;
  S0, S: PRGBAArray;
  DeltaS: integer;
  CI: TCacheInfo;
  CC: TsColor;
{$ENDIF}
begin
{$IFNDEF ACHINTS}
  CC.I := -65282;   // R:254 G:0 B:255 A:255
  CI.FillColor := CC.C;
  CI.Ready := False;
  CC.A := 0;
  CI.Bmp := nil;
  White.C := clWhite;
  Black.I := 0;
  Result := CreateBmpLike(Manager.FCacheBmp);
  PaintItemFast(SkinIndex, BorderIndex, BGIndex, BGIndex, CI, True, 0, MkRect(Self), MkPoint, Result, DefaultManager);
  h := Result.Height - 1;
  w := Result.Width - 1;
  CC.B := 254;
  CC.R := MaxByte;
  CC.A := 255;
  if InitLine(Result, Pointer(S0), DeltaS) then
    for y := 0 to h do begin
      S := Pointer(LongInt(S0) + DeltaS * Y);
      for x := 0 to w do
        with S[X] do
          if C = CC.C then
            C := $FFFFFF
          else
            C := 0;
    end;
{$ENDIF}
end;


function TacCustomHintWindow.GetBody: TBitmap;
{$IFNDEF ACHINTS}
var
  R: TRect;
  Mode: integer;
  CI: TCacheInfo;
  ABmp, SBmp: TBitmap;
{$ENDIF}
begin
{$IFNDEF ACHINTS}
  CI.Ready := False;
  CI.FillColor := sFuchsia.C;
  TsColor(CI.FillColor).A := 0;
  Result := CreateBmpLike(Manager.FCacheBmp);
  if Manager.HintFrame <> nil then
    BodyBmp := Result;

  R := ClientRect;
  if (DefaultManager.gd[SkinIndex].Props[0].Transparency = 100) and (BorderIndex >= 0) then
    with DefaultManager.ma[BorderIndex] do begin // Used BorderMask
      if Bmp = nil then
        SBmp := DefaultManager.MasterBitmap
      else
        SBmp := Bmp;

      ABmp := sGraphUtils.CreateAlphaBmp(SBmp, R);
      Mode := integer(DefaultManager.ma[BorderIndex].DrawMode and BDM_STRETCH = BDM_STRETCH);
      PaintControlByTemplate(Result, ABmp, MkRect(Result), MkRect(ABmp),
                             Rect(WL, WT, WR, WB), Rect(WL, WT, WR, WB),
                             Rect(Mode, Mode, Mode, Mode), True, True); // For internal shadows - stretch only allowed
      ABmp.Free;
      TextOut(Result);
      UpdateAlpha(Result);
    end
  else begin
    PaintItemFast(SkinIndex, BorderIndex, BGIndex, BGIndex, CI, True, 0, MkRect(Self), MkPoint, Result, DefaultManager);
    TextOut(Result);
  end;
{$ENDIF}
end;


function TacCustomHintWindow.SkinMargin(Border: byte): integer;
begin
{$IFNDEF ACHINTS}
  if BorderIndex >= 0 then
    with DefaultManager.ma[BorderIndex] do
      case Border of
        0:   if WL > 0 then Result := WL else Result := WidthOf(R)  div (ImageCount * 3);
        1:   if WT > 0 then Result := WT else Result := HeightOf(R) div ((MaskType  + 1) * 3);
        2:   if WR > 0 then Result := WR else Result := WidthOf(R)  div (ImageCount * 3)
        else if WB > 0 then Result := WB else Result := HeightOf(R) div ((MaskType  + 1) * 3);
      end
  else
{$ENDIF}
    Result := 0;
end;


procedure TacCustomHintWindow.CreateAlphaBmp;
var
  c: TsColor_;
  FBlend: TBlendFunction;
  D0, S0, M0, SH0, D, S, M, SH: PRGBAArray;
  x, y, DeltaD, DeltaS, DeltaM, DeltaSH: integer;
begin
  FBlend := DefBlend;
  FBlend.SourceConstantAlpha := MaxByte;
  if AlphaBmp <> nil then
    FreeAndNil(AlphaBmp);
    
  AlphaBmp := CreateBmp32(Width, Height);
  PrepareMask;
  if Assigned(BodyBmp) then
    FreeAndNil(BodyBmp);

  BodyBmp := GetBody;
  if (DefaultManager.gd[SkinIndex].Props[0].Transparency = 100) and (BorderIndex >= 0) then { BorderMask used }
    AlphaBmp.Assign(BodyBmp)
  else begin
    FillDC(Manager.FCacheBmp.Canvas.Handle, MkRect(Self), clWhite);
    if InitLine(BodyBmp, Pointer(S0), DeltaS) and
         InitLine(AlphaBmp, Pointer(D0), DeltaD) and
           InitLine(MaskBmp, Pointer(M0), DeltaM) and
             InitLine(Manager.FCacheBmp, Pointer(SH0), DeltaSH) then
      for y := 0 to Height - 1 do begin
        S := Pointer(LongInt(S0) + DeltaS * Y);
        D := Pointer(LongInt(D0) + DeltaD * Y);
        M := Pointer(LongInt(M0) + DeltaM * Y);
        SH := Pointer(LongInt(SH0) + DeltaSH * Y);
        for x := 0 to Width - 1 do begin
          if M[X].R = MaxByte then begin
            c.I := 0;
            c.A := MaxByte - SH[X].R;
          end
          else begin
            c := S[X];
            if S[X].C = sFuchsia.C then
              c.A := 0
            else
              c.A := MaxByte;
          end;
          D[X] := c;
        end;
      end;
  end;
  if Assigned(BodyBmp) then
    FreeAndNil(BodyBmp);
end;


function TacCustomHintWindow.GetArrowPos(var Rect: TRect; const mPos: TPoint): TacMousePosition;
const
  pArray: array [boolean, boolean] of TacMousePosition = ((mpRightBottom, mpLeftBottom), (mpRightTop, mpLeftTop));
var
  t, l, Auto: boolean;
  h, w: integer;
{$IFDEF DELPHI6UP}
  Monitor: TMonitor;
{$ENDIF}

  procedure SetLeft(Value: integer; al: boolean);
  begin
    Rect.Left := Value;
    l := al;
    Auto := True;
  end;

  procedure SetTop(Value: integer; at: boolean);
  begin
    Rect.Top := Value;
    t := at;
    Auto := True;
  end;

begin
  FMousePos := Manager.FDefaultMousePos;
  Result := FMousePos;

  dec(Rect.Right,  ShadowSizes.Right);
  dec(Rect.Bottom, ShadowSizes.Bottom);
  inc(Rect.Left,   ShadowSizes.Left);
  inc(Rect.Top,    ShadowSizes.Top);

  w := WidthOf(Rect);
  h := HeightOf(Rect);
  t := not (FMousePos in [mpLeftBottom, mpRightBottom]);
  l := not (FMousePos in [mpRightTop, mpRightBottom]);
  if not t then
    OffsetRect(Rect, 0, - h);

  if not l then
    OffsetRect(Rect, - w, 0);

  Auto := False; // Calc arrow position
{$IFDEF DELPHI6UP}
  Monitor := Screen.MonitorFromPoint(Rect.TopLeft);
  if Monitor = nil then
    Exit;
    
  if Rect.Bottom > Monitor.Top + Monitor.Height then
    if Manager.Skinned then
      SetTop(Monitor.Top + Monitor.Height - h, False)
    else
      if Template.SingleImageUsed then
        SetTop(mPos.Y - (Rect.Bottom - (Monitor.Top + Monitor.Height)), False)
      else
        SetTop(mPos.Y - h, False);

  if Rect.Top < Monitor.Top then
    SetTop(Monitor.Top, True);

  if Rect.Right > Monitor.Left + Monitor.Width then
    if Manager.Skinned then
      SetLeft(Monitor.Left + Monitor.Width - w, False)
    else
      if Template.SingleImageUsed then
        SetLeft(mPos.X - (Rect.Right - (Monitor.Left + Monitor.Width)), False)
      else
        SetLeft(mPos.X - w, False);

  if Rect.Left < Monitor.Left then
    SetLeft(Monitor.Left, True);
{$ELSE}
  if Rect.Bottom > Screen.Height then
    SetTop(mPos.y - h, False);

  if Rect.Top < 0 then
    SetTop(mPos.y, True);

  if Rect.Right > Screen.Width then
    SetLeft(mPos.x - w, False);

  if Rect.Left < 0 then
    SetLeft(mPos.x, True);
{$ENDIF}
  if Auto then
    Result := pArray[t, l];

  inc(Rect.Right,  ShadowSizes.Right);
  inc(Rect.Bottom, ShadowSizes.Bottom);
  dec(Rect.Left,   ShadowSizes.Left);
  dec(Rect.Top,    ShadowSizes.Top);
end;


procedure TacCustomHintWindow.UpdateWnd;
var
  lTicks: DWord;
  i, StepCount: integer;
  FBlend: TBlendFunction;
  SrcRect, DstRect: TRect;
  StepB, Blend, dx, dy, x, y: real;
begin
  if w = 0 then
    if acHintWindow <> nil then
      w := acHintWindow.Width
    else
      w := Manager.AnimWindow.Width;

  if h = 0 then
    if acHintWindow <> nil then
      h := acHintWindow.Height
    else
      h := Manager.AnimWindow.Height;

  CreateAlphaBmp(w, h);
  if not Manager.HintShowing then
    SetFormBlendValue(Manager.AnimWindow.Handle, AlphaBmp, 0);
    
  FBlend := DefBlend;
  // Show window with hint
  if Manager.Animated and IsNTFamily and not Manager.HintShowing then begin
    if not (csDestroying in ComponentState) then begin
      if Manager.Skinned and (DefaultManager.gd[SkinIndex].Props[0].Transparency <> 100) then
        i := DefaultManager.gd[SkinIndex].Props[0].Transparency
      else
        i := 0;

      StepCount := max(DefAnimationTime div acTimerInterval, 1);
      FBlend.SourceConstantAlpha := 0;
      if (Manager.AnimWindow <> nil) then begin
        SrcRect := Manager.AnimWindow.BoundsRect;
        DstRect := Manager.NewBounds;
        FBlend.SourceConstantAlpha := MaxByte - i;
        dx := (DstRect.Left - SrcRect.Left) / StepCount;
        dy := (DstRect.Top - SrcRect.Top) / StepCount;
        x := SrcRect.Left;
        y := SrcRect.Top;
        for i := 0 to StepCount - 1 do begin
          x := x + dx;
          y := y + dy;
          lTicks := GetTickCount;
          Manager.AnimWindow.Left := Round(x);
          Manager.AnimWindow.Top  := Round(y);
          while lTicks + acTimerInterval > GetTickCount do {wait here};
        end;
        if (Manager.NewWindow <> nil) then
          FreeAndNil(Manager.NewWindow);

        SetFormBlendValue(Manager.AnimWindow.Handle, AlphaBmp, MaxByte);
        ShowWindow(Manager.AnimWindow.Handle, SW_SHOWNOACTIVATE);
      end
      else begin
        i := Max(0, Min(100, i));
        StepB := Round(MaxByte - 2.55 * i) / StepCount;
        Blend := 0;
        SetFormBlendValue(Manager.AnimWindow.Handle, AlphaBmp, 0);
        ShowWindow(Manager.AnimWindow.Handle, SW_SHOWNOACTIVATE);
        for i := 0 to StepCount - 1 do begin
          lTicks := GetTickCount;
          Blend := Blend + StepB;
          if not (csDestroying in ComponentState) then
            SetFormBlendValue(Manager.AnimWindow.Handle, AlphaBmp, Round(Blend))
          else
            Break;

          while lTicks + acTimerInterval > GetTickCount do {wait here};
        end;
      end;
    end;
  end
  else
    if IsNTFamily then begin
      SetFormBlendValue(Manager.AnimWindow.Handle, AlphaBmp, MaxByte);
      ShowWindow(Manager.AnimWindow.Handle, SW_SHOWNOACTIVATE);
    end
    else
      SetWindowPos(Manager.AnimWindow.Handle, HWND_TOPMOST, 0, 0, w, h, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOOWNERZORDER);// or SWP_NOCOPYBITS);

  Manager.HintShowing := True;
  if AlphaBmp <> nil then begin
    if Manager.OldAlphaBmp <> nil then
      Manager.OldAlphaBmp.Free;
      
    Manager.OldAlphaBmp := AlphaBmp;
    AlphaBmp := nil;
  end;
end;


function TacPngHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
var
  DefRect: TRect;
  p: TPoint;

  procedure UpdateHintRect;
  begin
    Inc(Result.Right, Image.ClientMargins.Left + Image.ClientMargins.Right);
    Inc(Result.Bottom, Image.ClientMargins.Top + Image.ClientMargins.Bottom);
  end;

begin
  if Manager <> nil then
    if not Manager.Skinned then begin
      Manager.InitTemplate;
      Manager.FCacheBmp.Canvas.Font.Assign(Template.FFont);

      DefRect := inherited CalcHintRect(MaxWidth, AHint, AData);

      Result := DefRect;
      UpdateHintRect;
      if (Manager.TmpShowData.Control <> nil) then begin
        Manager.FHintLocation := Manager.TmpShowData.Position;
        Manager.CurrentHintInfo.HintControl := Manager.TmpShowData.Control;
        Manager.CheckAutoHintPos;
        OffsetRect(Result, Manager.FHintLocation.x, Manager.FHintLocation.y);
      end
      else
        if (Manager.TmpShowData.Width <> 0) then
          p := Manager.TmpShowData.Position
        else begin
          if (Manager.FHintLocation.X = 0) or (Manager.FHintLocation.Y = 0) then
            p := GetMousePosition
          else
            p := Manager.FHintLocation;

          OffsetRect(Result, p.x, p.y);
          FMousePos := GetArrowPos(Result, p);
        end;
        
      OffsetRect(Result, - ShadowSizes.Left, - ShadowSizes.Top);
      Result := DefRect;
      case FMousePos of
        mpRightTop: begin
          if Template.FImageRightTop.Image.Empty then
            Template.FImageRightTop.StreamChanged;

          if not Template.FImageRightTop.Image.Empty then begin
            Image := Template.FImageRightTop;
            Manager.CheckAutoHintPos;
          end;
        end;

        mpLeftBottom: begin
          if Template.FImageLeftBottom.Image.Empty then
            Template.FImageLeftBottom.StreamChanged;

          if not Template.FImageLeftBottom.Image.Empty then begin
            Image := Template.FImageLeftBottom;
            Manager.CheckAutoHintPos;
          end;
        end;

        mpRightBottom: begin
          if Template.FImageRightBottom.Image.Empty then
            Template.FImageRightBottom.StreamChanged;

          if not Template.FImageRightBottom.Image.Empty then begin
            Image := Template.FImageRightBottom;
            Manager.CheckAutoHintPos;
          end;
        end;
      end;
      UpdateHintRect;
    end
    else begin
      DefRect := inherited CalcHintRect(MaxWidth, AHint, AData);
      if (Manager.TmpShowData.Control <> nil) then begin
        Manager.FHintLocation := Manager.TmpShowData.Position;
        Manager.CurrentHintInfo.HintControl := Manager.TmpShowData.Control;
        Manager.CheckAutoHintPos;
        OffsetRect(Result, Manager.FHintLocation.x, Manager.FHintLocation.y);
      end;
      Result := DefRect;
    end
end;


function TacCustomHintWindow.ShadowSizes: TRect;
const
  Offset = 1;
begin
  if Manager.Active then
    if Manager.Skinned then
      if FullLayer then
        Result := Rect(max(0, SkinMargin(0) - Offset), max(0, SkinMargin(1) - Offset), max(0, SkinMargin(2) - Offset), max(0, SkinMargin(3) - Offset))
      else
        Result := MkRect
    else
      case FMousePos of
        mpLeftTop:     with Template.FImageDefault.ShadowSizes     do Result := Rect(Left, Top, Right, Bottom);
        mpRightTop:    with Template.FImageRightTop.ShadowSizes    do Result := Rect(Left, Top, Right, Bottom);
        mpLeftBottom:  with Template.FImageLeftBottom.ShadowSizes  do Result := Rect(Left, Top, Right, Bottom);
        mpRightBottom: with Template.FImageRightBottom.ShadowSizes do Result := Rect(Left, Top, Right, Bottom);
      end
  else
    Result := MkRect;
end;


constructor TacPngHintWindow.Create(AOwner: TComponent);
begin
  inherited;
end;


procedure TacPngHintWindow.CreateAlphaBmp(const Width, Height: integer);
var
  SrcBmp, TempBmp: TBitmap;
  FBlend: TBlendFunction;
begin
  if Manager.Skinned then
    inherited
  else begin
    SetWindowRgn(Handle, 0, False);
    if AlphaBmp <> nil then
      FreeAndNil(AlphaBmp);

    AlphaBmp := CreateBmp32(Width, Height);
    FBlend := DefBlend;
    FBlend.SourceConstantAlpha := MaxByte;
    if (Template <> nil) then begin
      if Image.FImage.Empty and (Image.FImageData.Size <> 0) then begin
        Image.FImageData.Seek(0, 0);
        Image.FImage.LoadFromStream(Image.FImageData);
      end;
      if not Image.FImage.Empty then begin
        SrcBmp := Image.FImage;
        PaintControlByTemplate(AlphaBmp, SrcBmp, MkRect(AlphaBmp), MkRect(SrcBmp),
            Rect(Image.BordersWidths.Left, Image.BordersWidths.Top, Image.BordersWidths.Right, Image.BordersWidths.Bottom),
            Rect(MaxByte, MaxByte, MaxByte, MaxByte),
            Rect(ord(Image.BorderDrawModes.Left), ord(Image.BorderDrawModes.Top), ord(Image.BorderDrawModes.Right), ord(Image.BorderDrawModes.Bottom)),
            boolean(ord(Image.BorderDrawModes.Center)));
      end;
    end;
    TempBmp := TBitmap.Create;
    TempBmp.Assign(AlphaBmp);
    if Template <> nil then
      AlphaBmp.Canvas.Font.Assign(Template.FFont);

    TextOut(AlphaBmp);
    CopyChannel32(AlphaBmp, TempBmp, 3);
    FreeAndNil(TempBmp);
    UpdateAlpha(AlphaBmp);
  end;
end;


procedure TacHintTemplate.AssignTo(Dest: TPersistent);
begin
  if Dest <> nil then begin
    ImageDefault   .AssignTo(TacHintTemplate(Dest).ImageDefault);
    Img_LeftBottom .AssignTo(TacHintTemplate(Dest).Img_LeftBottom);
    Img_RightBottom.AssignTo(TacHintTemplate(Dest).Img_RightBottom);
    Img_RightTop   .AssignTo(TacHintTemplate(Dest).Img_RightTop);
    TacHintTemplate(Dest).HintAlign := HintAlign;
    TacHintTemplate(Dest).Font.Assign(Font);
    TacHintTemplate(Dest).Name := Name;
  end
  else
    inherited;
end;


constructor TacHintTemplate.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FOwner := TacHintTemplates(Collection);
  FImageDefault     := TacHintImage.Create(Self);
  FImageLeftBottom  := TacHintImage.Create(Self);
  FImageRightBottom := TacHintImage.Create(Self);
  FImageRightTop    := TacHintImage.Create(Self);
  FFont := TFont.Create;
  FHintAlign := haHorzCenter;
end;


destructor TacHintTemplate.Destroy;
begin
  FreeAndNil(FImageDefault);
  FreeAndNil(FImageLeftBottom);
  FreeAndNil(FImageRightBottom);
  FreeAndNil(FImageRightTop);
  FreeAndNil(FFont);
  inherited Destroy;
end;


function TacHintTemplate.SingleImageUsed: boolean;
begin
  Result := (Img_LeftBottom.FImageData.Size = 0) and Template.FImageLeftBottom.FImage.Empty;
end;



procedure TacHintTemplate.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  FOwner.FOwner.Changed;
end;


procedure TacHintTemplate.SetHintImage(const Index: Integer; const Value: TacHintImage);
begin
  case Index of
    0: FImageDefault    .Assign(Value);
    1: FImageLeftBottom .Assign(Value);
    2: FImageRightBottom.Assign(Value);
    3: FImageRightTop   .Assign(Value);
  end;
end;


procedure TacHintTemplates.AssignTo(Dest: TPersistent);
var
  i: integer;
  TmpSrc, TmpDst: TacHintTemplate;
begin
  if Dest <> nil then begin
    TacHintTemplates(Dest).Clear;
    for i := 0 to Count - 1 do begin
      TacHintTemplates(Dest).Add;
      TmpSrc := GetItem(i);
      TmpDst := TacHintTemplates(Dest).GetItem(i);
      TmpSrc.AssignTo(TmpDst);
    end;
  end
  else
    inherited;
end;


constructor TacHintTemplates.Create(AOwner: TsAlphaHints);
begin
  FOwner := AOwner;
  inherited Create(TacHintTemplate);
end;


destructor TacHintTemplates.Destroy;
begin
  inherited Destroy;
  FOwner := nil;
end;


function TacHintTemplates.GetItem(Index: Integer): TacHintTemplate;
begin
  Result := TacHintTemplate(inherited GetItem(Index));
end;


function TacHintTemplates.GetOwner: TPersistent;
begin
  Result := FOwner;
end;


procedure TacHintTemplates.SetItem(Index: Integer; Value: TacHintTemplate);
begin
  inherited SetItem(Index, Value);
end;


procedure TacBordersSizes.AssignTo(Dest: TPersistent);
begin
  if Dest <> nil then
    TacBordersSizes(Dest).SetValues(Left, Top, Right, Bottom)
  else
    inherited;
end;


constructor TacBordersSizes.Create(AOwner: TacHintImage);
begin
  FTop    := 0;
  FLeft   := 0;
  FBottom := 0;
  FRight  := 0;
  FOwner := AOwner;
  CheckSize := False;
end;


function TacBordersSizes.GetInteger(const Index: Integer): integer;
begin
  Result := 0;
  case Index of
    0: Result := FTop;
    1: Result := FLeft;
    2: Result := FBottom;
    3: Result := FRight;
  end;
  if Result < 0 then
    Result := 0;
end;


procedure TacBordersSizes.LoadFromStream(AStream: TStream);
begin
  AStream.Read(FTop,    SizeOf(FTop));
  AStream.Read(FLeft,   SizeOf(FLeft));
  AStream.Read(FRight,  SizeOf(FRight));
  AStream.Read(FBottom, SizeOf(FBottom));
end;


procedure TacBordersSizes.SaveToStream(AStream: TStream);
begin
  AStream.Write(FTop,    SizeOf(FTop));
  AStream.Write(FLeft,   SizeOf(FLeft));
  AStream.Write(FRight,  SizeOf(FRight));
  AStream.Write(FBottom, SizeOf(FBottom));
end;


procedure TacBordersSizes.SetValues(ALeft, ATop, ARight, ABottom: integer);
begin
  Left   := ALeft;
  Top    := ATop;
  Right  := ARight;
  Bottom := ABottom;
end;


procedure TacBordersSizes.SetInteger(Index, Value: integer);
const
  CenterPiece = 1;
begin
  if CheckSize then
    case Index of
      0: begin
        FTop := min(Value, FOwner.ImageHeight - CenterPiece);
        FBottom := min(FBottom, FOwner.ImageHeight - FTop - CenterPiece);
      end;

      1: begin
        FLeft := min(Value, FOwner.ImageWidth - CenterPiece);
        FRight := min(FRight, FOwner.ImageWidth - FLeft - CenterPiece);
      end;

      2: begin
        FBottom := min(Value, FOwner.ImageHeight - CenterPiece);
        FTop := min(FTop, FOwner.ImageHeight - FBottom - CenterPiece);
      end;

      3: begin
        FRight := min(Value, FOwner.ImageWidth - CenterPiece);
        FLeft := min(FLeft, FOwner.ImageWidth - FRight - CenterPiece);
      end;
    end
  else
    case Index of
      0: FTop    := Value;
      1: FLeft   := Value;
      2: FBottom := Value;
      3: FRight  := Value;
    end;

  if not acLocalUpd and (FOwner.FOwner.FOwner <> nil) then begin
    acLocalUpd := True;
    FOwner.FOwner.FOwner.FOwner.Changed;
    acLocalUpd := False;
  end;
end;


constructor TacHintImage.Create(AOwner: TacHintTemplate);
begin
  FImageData := TMemoryStream.Create;
  FImage := TPngGraphic.Create;
  FOwner := AOwner;
  FBordersWidths := TacBordersSizes.Create(Self);
  FClientMargins := TacBordersSizes.Create(Self);
  FShadowSizes   := TacBordersSizes.Create(Self);
  FBorderDrawModes := TacBorderDrawModes.Create(Self);
  FOffsetHorz := 0;
  FOffsetVert := 0;
end;


destructor TacHintImage.Destroy;
begin
  FreeAndNil(FBorderDrawModes);
  FreeAndNil(FClientMargins);
  FreeAndNil(FBordersWidths);
  FreeAndNil(FShadowSizes);
  FreeAndNil(FImage);
  FreeAndNil(FImageData);
  inherited Destroy;
end;


function TacHintImage.GetImgHeight: integer;
begin
  if FImage.Empty then
    Result := 0
  else
    Result := Image.Height;
end;


function TacHintImage.GetImgWidth: integer;
begin
  if FImage.Empty then
    Result := 0
  else
    Result := Image.Width;
end;


procedure TacHintImage.SetClientMargins(const Value: TacBordersSizes);
begin
  FClientMargins.Assign(Value);
end;


procedure TacHintImage.SetImage(const Value: TPngGraphic);
begin
  FImage.Assign(Value);
  ImageChanged;
  FOwner.FOwner.FOwner.Changed;
end;


procedure TacHintImage.SetOffsetHorz(const Value: integer);
begin
  FOffsetHorz := Value;
  FOwner.FOwner.FOwner.Changed;
end;


procedure TacHintImage.SetOffsetVert(const Value: integer);
begin
  FOffsetVert := Value;
  FOwner.FOwner.FOwner.Changed;
end;


procedure TacHintImage.SetImgHeight(const Value: integer);
begin
//
end;


procedure TacHintImage.SetImgWidth(const Value: integer);
begin
//
end;


procedure TacHintImage.SetBordersWidths(const Value: TacBordersSizes);
begin
  FBordersWidths.Assign(Value);
end;


procedure TacHintImage.ImageChanged;
var
  h, w: integer;
begin
  w := FImage.Width - 1;
  h := FImage.Height - 1;

  BordersWidths.FLeft  := w div 2;
  BordersWidths.FRight := BordersWidths.FLeft;
  ClientMargins.FLeft  := BordersWidths.FLeft;
  ClientMargins.FRight := BordersWidths.FLeft;

  BordersWidths.FTop    := h div 2;
  BordersWidths.FBottom := BordersWidths.FTop;
  ClientMargins.FTop    := BordersWidths.FTop;
  ClientMargins.FBottom := BordersWidths.FTop;
end;


procedure TacHintImage.AssignTo(Dest: TPersistent);
begin
  if Dest <> nil then begin
    TacHintImage(Dest).Image.Assign(Image);
    if FImageData.Size > 0 then begin
      FImageData.Seek(0, 0);
      TacHintImage(Dest).FImageData.LoadFromStream(FImageData);
    end
    else
      TacHintImage(Dest).FImageData.Size := 0;

    TacHintImage(Dest).OffsetHorz := OffsetHorz;
    TacHintImage(Dest).OffsetVert := OffsetVert;
    TacHintImage(Dest).ClientMargins  .Assign(ClientMargins);
    TacHintImage(Dest).BorderDrawModes.Assign(BorderDrawModes);
    TacHintImage(Dest).BordersWidths  .Assign(BordersWidths);
    TacHintImage(Dest).ShadowSizes    .Assign(ShadowSizes);
  end
  else
    inherited;
end;


procedure TacBorderDrawModes.AssignTo(Dest: TPersistent);
begin
  if Dest <> nil then begin
    TacBorderDrawModes(Dest).Top    := Top;
    TacBorderDrawModes(Dest).Left   := Left;
    TacBorderDrawModes(Dest).Bottom := Bottom;
    TacBorderDrawModes(Dest).Right  := Right;
    TacBorderDrawModes(Dest).Center := Center;
  end
  else
    inherited;
end;


constructor TacBorderDrawModes.Create(AOwner: TacHintImage);
begin
  FBottom := dmStretch;
  FLeft   := dmStretch;
  FTop    := dmStretch;
  FRight  := dmStretch;
  FCenter := dmStretch;
  FOwner  := AOwner;
end;


procedure TacBorderDrawModes.LoadFromStream(AStream: TStream);
begin
  AStream.Read(FTop,    SizeOf(FTop));
  AStream.Read(FLeft,   SizeOf(FLeft));
  AStream.Read(FRight,  SizeOf(FRight));
  AStream.Read(FBottom, SizeOf(FBottom));
  AStream.Read(FCenter, SizeOf(FCenter));
end;


procedure TacBorderDrawModes.SaveToStream(AStream: TStream);
begin
  AStream.Write(FTop,    SizeOf(FTop));
  AStream.Write(FLeft,   SizeOf(FLeft));
  AStream.Write(FRight,  SizeOf(FRight));
  AStream.Write(FBottom, SizeOf(FBottom));
  AStream.Write(FCenter, SizeOf(FCenter));
end;


procedure TacBorderDrawModes.SetDrawMode(const Index: Integer; const Value: TacBorderDrawMode);
begin
  case Index of
    0: FTop    := Value;
    1: FLeft   := Value;
    2: FBottom := Value;
    3: FRight  := Value;
    4: FCenter := Value;
  end;
  if FOwner.FOwner.FOwner <> nil then
    FOwner.FOwner.FOwner.FOwner.Changed;
end;


var
  HintStream: TResourceStream;


function TacCustomHintWindow.FullLayer: boolean;
begin
  Result := not Manager.Skinned or acLayered and ((DefaultManager.gd[SkinIndex].Props[0].Transparency = 100) and (BorderIndex >= 0));
end;


procedure TsAlphaHints.OnHideTimer(Sender: TObject);
begin
  HideHint;
  HideTimer.Enabled := False;
end;


procedure TsAlphaHints.OnCtrlTimer(Sender: TObject);
var
  Ctrl: TControl;
begin
  Ctrl := CtrlUnderMouse;
  if (Ctrl <> HintTimeCtrl) or (HintTimeCtrl = nil) then begin
    TacThreadedTimer(Sender).Enabled := False;
    HideTimer.Enabled := False;
    HideAll;
    HintTimeCtrl := nil;
  end;
end;


procedure TacHintImage.SetShadowSizes(const Value: TacBordersSizes);
begin
  FShadowSizes.Assign(Value);
end;


const
  ahAbbr: array [1..4] of AnsiChar = 'AShh';
  BufSize = 64;


function TsAlphaHints.LoadFromStream(AStream: TMemoryStream): TacHintTemplate;
var
  c: AnsiChar;
  i, n: integer;
  s: AnsiString;
  AStyle: TFontStyles;
  Buf: array [1..4] of AnsiChar;
  FontBuf: array [1..BufSize - 1] of AnsiChar;
begin
  AStream.Seek(0, 0);
  AStream.Read(Buf, SizeOf(Buf));
  if Buf = ahAbbr then begin
    Result := TacHintTemplate(Templates.Add);
    AStream.Read(c, 1);
    // Font
    AStream.Read(i, SizeOf(i));
    Result.Font.Color := TColor(i);
    if integer(Result.Font.Color) < 0 then
      Result.Font.Color := 0;

    AStream.Read(i, SizeOf(i));
    Result.Font.Size := i;
    AStream.Read(AStyle, SizeOf(AStyle));
    Result.Font.Style := AStyle;

    AStream.Read(n, SizeOf(n));
    AStream.Read(FontBuf, n);
    SetString(s, PAnsiChar(@FontBuf[1]), n);
    Result.Font.Name := s;

    Result.FImageDefault.LoadFromStream(AStream);
    if (c = CharOne) and (AStream.Position < AStream.Size) then begin // Other three images
      Result.FImageRightTop   .LoadFromStream(AStream);
      Result.FImageRightBottom.LoadFromStream(AStream);
      Result.FImageLeftBottom .LoadFromStream(AStream);
    end;
  end
  else begin
    Result := nil;
    ShowError('Unknown file format');
  end;
end;


procedure TsAlphaHints.SaveToStream(AStream: TMemoryStream);
var
  i, l: integer;
  s: AnsiString;
  AStyle: TFontStyles;
begin
  if (FTemplateIndex >= 0) and (FTemplateIndex < Templates.Count) then
    Template := Templates[FTemplateIndex]
  else
    Template := DefaultTemplate;

  if Template <> nil then begin
    AStream.Size := 0;
    AStream.Write(ahAbbr, SizeOf(ahAbbr));
    s := iff(Template.FImageRightTop <> nil, CharOne, ZeroChar);
    AStream.Write(AnsiChar(s[1]), 1);
    // Font
    if integer(Template.Font.Color) < 0 then begin
      i := 0;
      AStream.Write(i, SizeOf(Template.Font.Color))
    end
    else
      AStream.Write(Template.Font.Color, SizeOf(Template.Font.Color));

    i := Template.Font.Size;
    AStream.Write(i, SizeOf(i));

    AStyle := Template.Font.Style;
    AStream.Write(AStyle, SizeOf(AStyle));

    l := Length(Template.Font.Name);
    AStream.Write(l, SizeOf(l));
    s := Template.Font.Name;
    for i := 1 to l do
      AStream.Write(AnsiChar(s[i]), 1);

    // Images
    Template.FImageDefault.SaveToStream(AStream);
    if (Template.FImageRightTop <> nil) and not Template.SingleImageUsed then begin // Other three images
      Template.FImageRightTop   .SaveToStream(AStream);
      Template.FImageRightBottom.SaveToStream(AStream);
      Template.FImageLeftBottom .SaveToStream(AStream);
    end;
  end;
end;


procedure TacHintImage.SavetoStream(AStream: TStream);
var
  i: integer;
  c: AnsiChar;
  TmpStream: TMemoryStream;
begin
  BorderDrawModes.SaveToStream(AStream);
  BordersWidths  .SaveToStream(AStream);
  ClientMargins  .SaveToStream(AStream);
  ShadowSizes    .SaveToStream(AStream);
  if FImageData.Size = 0 then begin
    TmpStream := TMemoryStream.Create;
    c := ZeroChar;
    AStream.Write(c, 1);
    FImage.SaveToStream(TmpStream);
    i := TmpStream.Size;
    AStream.Write(i, SizeOf(i));
    TmpStream.Seek(0, 0);
    TmpStream.SaveToStream(AStream);
    TmpStream.Free;
  end
  else begin
    c := CharOne;
    AStream.Write(c, 1);
    i := FImageData.Size;
    AStream.Write(i, SizeOf(i));
    FImageData.SaveToStream(AStream);
  end;
end;


procedure TsAlphaHints.SaveToFile(FileName: string);
var
  OutStream: TMemoryStream;
begin
  if FileExists(FileName) then
    DeleteFile(FileName);

  OutStream := TMemoryStream.Create;
  try
    SaveToStream(OutStream);
    OutStream.SaveToFile(FileName);
  finally
    OutStream.Free;
  end;
end;


function TsAlphaHints.LoadFromFile(FileName: string): TacHintTemplate;
var
  InStream: TMemoryStream;
  p: integer;
  s: string;
begin
  InStream := TMemoryStream.Create;
  try
    InStream.LoadFromFile(FileName);
    Result := LoadFromStream(InStream);
    if Result <> nil then begin
      s := ExtractFileName(FileName);
      p := Pos(s_Dot, s);
      Delete(s, p, Length(s) - p + 1);
      Result.Name := s;
    end;
  finally
    InStream.Free;
  end;
end;


procedure TacHintImage.LoadFromStream(AStream: TStream);
var
  l: integer;
  c: AnsiChar;
  Bmp: TBitmap;
  TmpStream: TMemoryStream;
begin
  BorderDrawModes.LoadFromStream(AStream);
  BordersWidths  .LoadFromStream(AStream);
  ClientMargins  .LoadFromStream(AStream);
  ShadowSizes    .LoadFromStream(AStream);
  AStream.Read(c, 1);
  AStream.Read(l, SizeOf(l));
  if FImage = nil then
    FImage := TPngGraphic.Create;

  if c = ZeroChar then begin // If bitmap
    TmpStream := TMemoryStream.Create;
    Bmp := TBitmap.Create;
    try
      TmpStream.CopyFrom(AStream, l);
      TmpStream.Seek(0, 0);
      Bmp.LoadFromStream(TmpStream);
      FImage.Assign(Bmp);
    finally
      FImageData.Size := 0;
      Bmp.Free;
      TmpStream.Free;
    end;
  end
  else begin
    FImageData.CopyFrom(AStream, l);
    FImageData.Seek(0, 0);
    FImage.LoadFromStream(FImageData);
  end;
end;


function TacHintImage.BitmapStored: boolean;
begin
  Result := FImageData.Size = 0;
end;


procedure TacHintImage.StreamChanged;
var
  aPng: TPngGraphic;
begin
  if FImageData.Size <> 0 then begin
    aPng := TPngGraphic.Create;
    try
      FImageData.Seek(0, 0);
      aPng.LoadFromStream(FImageData);
      FImage.Assign(aPng);
      FOwner.FOwner.FOwner.Changed;
    finally
      aPng.FreeImage;
      aPng.Free;
    end;
  end;
end;


procedure TacHintImage.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ImgData', ReadData, WriteData, True);
end;


procedure TacHintImage.ReadData(Reader: TStream);
begin
  FImageData.LoadFromStream(Reader);
end;


procedure TacHintImage.WriteData(Writer: TStream);
begin
  FImageData.SaveToStream(Writer);
end;


function TacCustomHintWindow.CreateHintWindow(R: TRect): TForm;
begin
  Result := TForm.Create(nil);
  Result.Visible := False;
  Result.BorderStyle := bsNone;
  Result.Tag := ExceptTag;

  SetWindowLong(Result.Handle, GWL_EXSTYLE, GetWindowLong(Result.Handle, GWL_EXSTYLE) or WS_EX_NOACTIVATE or WS_EX_LAYERED or WS_EX_TRANSPARENT or WS_EX_TOPMOST);// or WS_EX_TOOLWINDOW);
  SetWindowPos(Result.Handle, HWND_TOPMOST, R.Left, R.Top, WidthOf(R), HeightOf(R), SWP_NOACTIVATE or SWP_NOOWNERZORDER);
  if FullLayer then
    SetClassLong(Result.Handle, GCL_STYLE, GetClassLong(Result.Handle, GCL_STYLE) and not NCS_DROPSHADOW)
  else
    SetClassLong(Result.Handle, GCL_STYLE, GetClassLong(Result.Handle, GCL_STYLE) or NCS_DROPSHADOW);

//  Result.FormStyle := fsStayOnTop;
  ShowWindow(Result.Handle, SW_SHOWNOACTIVATE);
end;


procedure TsAlphaHints.StartCheckTimer;
begin
  if CheckTimer <> nil then
    CheckTimer.Free;

  CheckTimer := TacThreadedTimer.Create(nil);
  CheckTimer.Enabled := False;
  CheckTimer.OnTimer := OnCheckTimer;
  CheckTimer.Interval := Application.HintShortPause + {Application.HintPause + }300;
  CheckTimer.Enabled := True;
end;


procedure TsAlphaHints.StartHideTimer(HideTime: integer = 0);
begin
{
  if HideTimer <> nil then begin
    HideTimer.OnTimer(HideTimer);
    HideTimer.Enabled := False;
    HideTimer.Free;
  end;
}
  if HideTimer = nil then
    HideTimer := TacThreadedTimer.Create(Self);

  HideTimer.Enabled := False;
  if HideTime <> 0 then begin
    HideTimer.Interval := HideTime;
    HideTimer.OnTimer := OnHideTimer;
  end
  else begin
    HideTimer.Interval := 300;
    HideTimer.OnTimer := OnCtrlTimer;
  end;
  HideTimer.Enabled := True;
end;


procedure TsAlphaHints.OnCheckTimer(Sender: TObject);
begin
  if (Manager <> nil) and ((acHintWindow = nil) or not IsWindowVisible(acHintWindow.Handle) or not Manager.HintShowing) then begin // ????
    Blend := 0;
    if (AnimWindow <> nil) then
      FreeAndNil(AnimWindow);

    if (NewWindow <> nil) then
      FreeAndNil(NewWindow);

    Application.HintPause := Manager.FOldHintPause;
  end;
  if CheckTimer <> nil then
    CheckTimer.Enabled := False;
end;


procedure TsShowTimer.Init(HintForm: TacCustomHintWindow; w, h: integer);
var
  FBlend: TBlendFunction;
begin
  Interval := acTimerInterval + AddInterval;
  OnTimer := IntOnTimer;
  Step := 0;
  StepCount := max({10 * }DefAnimationTime div acTimerInterval, 1) * StepDivid;
  CurrentHintForm := HintForm;
  FBlend := DefBlend;
  FBlend.SourceConstantAlpha := 0;
  if Manager.Skinned and (DefaultManager.gd[CurrentHintForm.SkinIndex].Props[0].Transparency <> 100) then
    Transparency := Round(DefaultManager.gd[CurrentHintForm.SkinIndex].Props[0].Transparency * 2.55)
  else
    Transparency := 0;

  FBmpSize := MkSize(w, h);
  FBmpTopLeft := MkPoint;
  CurrentHintForm.CreateAlphaBmp(FBmpSize.cx, FBmpSize.cy);

  Transparency := Max(0, Min(MaxByte, Transparency));
  StepB := (MaxByte - Transparency) / StepCount;
  SrcRect := Manager.AnimWindow.BoundsRect;

  if (CurrentHintForm <> nil) and (CurrentHintForm.FMousePos in [mpRightTop, mpRightBottom]) then
    dx := -(Manager.NewBounds.Left - SrcRect.Left) / Speed
  else
    dx := (Manager.NewBounds.Left - SrcRect.Left) / Speed;

  if (CurrentHintForm <> nil) and (CurrentHintForm.FMousePos in [mpLeftBottom, mpRightBottom]) then
    dy := -(Manager.NewBounds.Top - SrcRect.Top) / Speed
  else
    dy := (Manager.NewBounds.Top - SrcRect.Top) / Speed;

  x := SrcRect.Left;
  y := SrcRect.Top; 
  Enabled := True;
  if Manager.FOldHintPause = 0 then
    Manager.FOldHintPause := Application.HintPause;

  Application.HintPause := 100;
end;


procedure TsShowTimer.IntOnTimer(Sender: TObject);
begin
  if not (csDestroying in ComponentState) and
       (Manager.AnimWindow <> nil) and
         Manager.AnimWindow.HandleAllocated and
           (CurrentHintForm <> nil) and
             (CurrentHintForm.AlphaBmp <> nil) then
    with Manager do begin
      if (Step < StepCount) and (Blend <= MaxByte - Transparency - StepB) then begin
        inc(Step);
        Manager.Blend := Blend + StepB;
        if (dx <> 0) or (dy <> 0) then begin // Change position
          x := x + dx;
          y := y + dy;
          dx := (Manager.NewBounds.Left - x) / Speed;
          dy := (Manager.NewBounds.Top - y) / Speed;
          if (NewWindow <> nil) then // Recreate window if shadow mode must be changed
            if (GetClassLong(NewWindow.Handle, GCL_STYLE) and NCS_DROPSHADOW = NCS_DROPSHADOW) = CurrentHintForm.FullLayer then
              FreeAndNil(NewWindow);

          if (NewWindow = nil) then
            NewWindow := CurrentHintForm.CreateHintWindow(SrcRect);

          if OldAlphaBmp = nil then
            OldAlphaBmp := CreateBmp32;

          SetWindowPos(AnimWindow.Handle, HWND_TOPMOST, Round(x), Round(y), OldAlphaBmp.Width, OldAlphaBmp.Height, SWP_NOACTIVATE or SWP_NOOWNERZORDER);
          SetFormBlendValue(AnimWindow.Handle, OldAlphaBmp, MaxByte - Round(Blend));

          SetWindowPos(NewWindow.Handle, AnimWindow.Handle, Round(x), Round(y), CurrentHintForm.AlphaBmp.Width, CurrentHintForm.AlphaBmp.Height, SWP_NOACTIVATE or SWP_NOOWNERZORDER);
          SetFormBlendValue(NewWindow.Handle, CurrentHintForm.AlphaBmp, Round(Blend));
        end
        else begin // Change transparency only
          SetFormBlendValue(AnimWindow.Handle, CurrentHintForm.AlphaBmp, Round(Blend));
          ShowWindow(AnimWindow.Handle, SW_SHOWNOACTIVATE);
        end;
      end
      else begin // Finish
        Enabled := False;
        if (NewWindow <> nil) then begin // If was moved
          FreeAndNil(AnimWindow);
          AnimWindow := NewWindow;
          NewWindow := nil;
        end;
        SetFormBlendValue(AnimWindow.Handle, CurrentHintForm.AlphaBmp, MaxByte - Transparency);
        SetWindowPos(AnimWindow.Handle, HWND_TOPMOST, NewBounds.Left, NewBounds.Top, WidthOf(NewBounds), HeightOf(NewBounds), SWP_NOACTIVATE or SWP_NOOWNERZORDER);
        Blend := 0;
        if CurrentHintForm.AlphaBmp <> nil then begin // Save previous image for future animation
          if OldAlphaBmp <> nil then
            OldAlphaBmp.Free;

          OldAlphaBmp := CurrentHintForm.AlphaBmp;
          CurrentHintForm.AlphaBmp := nil;
        end;
      end;
  end;
end;


procedure TacCustomHintWindow.OnCloseHint;
begin
  if (Manager <> nil) then begin
    if Manager.ShowTimer <> nil then begin
      Manager.ShowTimer.Enabled := False;
      Manager.ResetHintInfo;
    end;
    if acHintWindow = Self then
      acHintWindow := nil;

    if Assigned(Manager.OnHideHint) then
      Manager.OnHideHint(Manager);

    Manager.StartCheckTimer;
  end;
end;


procedure TacPngHintWindow.DoDestroy;
begin
  if AlphaBmp <> nil then
    FreeAndNil(AlphaBmp);

  inherited;
end;


initialization
  DefaultTemplate := TacHintTemplate.Create(nil);
  HintStream := TResourceStream.Create(hInstance, 'ACHINT', RT_RCDATA);
  with DefaultTemplate.ImageDefault do begin
    DefaultTemplate.ImageDefault.Image.LoadFromStream(HintStream);
    BordersWidths.SetValues(11, 10, 14, 15);
    ShadowSizes  .SetValues( 6,  5,  7,  8);
    ClientMargins.SetValues(11,  8, 16, 15);
  end;
  FreeAndNil(HintStream);
  

finalization
  FreeAndNil(DefaultTemplate);

end.



