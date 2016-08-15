unit acPopupController;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  Forms, Windows, Graphics, SysUtils, Classes, Controls, Messages,
  acThdTimer;


type
  TsPopupController = class;

  TacFormHandler = class(TObject)
  protected
    ClientCtrl: TWinControl;
    FormWndProc: TWndMethod;
    CtrlWndProc: TWndMethod;
    CheckTimer: TacThreadedTimer;
    Controller: TsPopupController;
    OldOnClose: TCloseEvent;
    constructor Create(AForm: TForm; ACtrl: TWinControl);
    procedure UpdateRgn(AHandle: THandle);
    procedure UpdateRgnBmp(aBmp: TBitmap);
    procedure CloseForm(CallProc: boolean = True);
    procedure DoTimer(Sender: TObject);
    procedure DoWndProc (var Message: TMessage);
    procedure DoCtrlProc(var Message: TMessage);
    procedure UnInitFormHandler;
  public
    Closed: boolean;
    PopupForm: TForm;
    PopupCtrl: TWinControl;
    ParentForm: TForm;
    destructor Destroy; override;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsPopupController = class(TComponent)
  protected
    AnimDirection: integer;
    function InitFormHandler(AForm: TForm; Ctrl: TWinControl): integer;
    procedure DoDeactivate(Sender: TObject);
    procedure DoClose(Sender: TObject; var Action: TCloseAction);
  public
    SkipOpen: boolean;
    FormHandlers: array of TacFormHandler;
    function GetFormIndex(Form: TForm): integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure KillAllForms(ExceptChild: TForm);
    function PopupCount(ExceptForm: TForm): integer;
    function HasChild(Parent: TForm): boolean;
    function PopuChildCount(ExceptForm: TForm): integer;
    procedure AnimShowPopup(aForm: TForm; wTime: word = 0; BlendValue: byte = MaxByte);
    procedure ShowForm(AForm: TForm; AOwnerControl: TWinControl; AnimTime: integer = 80);
    procedure ShowFormPos(AForm: TForm; ALeftTop: TPoint; AnimTime: integer = 80);
  end;


procedure ShowPopupForm(AForm: TForm; AOwnerControl: TWinControl); overload;
procedure ShowPopupForm(AForm: TForm; ALeftTop: TPoint); overload;
function AttachShadowForm(aForm: TForm; DoShow: boolean = True): TCustomForm;

var
  acIntController: TsPopupController = nil;

implementation

uses
  math,
  {$IFNDEF DELPHI6UP} acD5Ctrls, {$ENDIF}
  sMessages, sGraphUtils, acntUtils, sVclUtils, StdCtrls, sComboBox, sConst, sSkinProvider,
  sAlphaGraph, acntTypes, acPopupCtrls, sComboBoxes, sCommonData, sSKinManager;

var
  rShadowBmp: TBitmap = nil;


procedure ShowPopupForm(AForm: TForm; AOwnerControl: TWinControl);
begin
  if acIntController = nil then
    acIntController := TsPopupController.Create(nil)
  else
    acIntController.KillAllForms(AForm);

  acIntController.ShowForm(AForm, AOwnerControl);
end;


procedure ShowPopupForm(AForm: TForm; ALeftTop: TPoint); overload;
begin
  if acIntController = nil then
    acIntController := TsPopupController.Create(nil)
  else
    acIntController.KillAllForms(AForm);

  acIntController.ShowFormPos(AForm, ALeftTop);
end;


function TsPopupController.InitFormHandler(AForm: TForm; Ctrl: TWinControl): integer;
begin
  Result := GetFormIndex(AForm);
  if Result < 0 then begin
    Result := Length(FormHandlers);
    SetLength(FormHandlers, Result + 1);
    FormHandlers[Result] := TacFormHandler.Create(AForm, Ctrl);
    FormHandlers[Result].Controller := Self;

    AForm.OnDeactivate := DoDeactivate;

    if Assigned(AForm.OnClose) and not Assigned(FormHandlers[Result].OldOnClose) then
      FormHandlers[Result].OldOnClose := AForm.OnClose;

    AForm.OnClose := DoClose;
  end;
end;


procedure TsPopupController.KillAllForms(ExceptChild: TForm);
var
  i: integer;
  ParentForm: TForm;
begin
  if ExceptChild <> nil then
    ParentForm := TForm(GetOwnerForm(ExceptChild.Owner))
  else
    ParentForm := nil;

  for i := 0 to Length(FormHandlers) - 1 do
    if (FormHandlers[i] <> nil) and (FormHandlers[i].PopupForm <> nil) and (FormHandlers[i].PopupForm <> ParentForm) then
       FormHandlers[i].PopupForm.Close;

  if PopupCount(nil) = 0 then begin
    for i := 0 to Length(FormHandlers) - 1 do
      FreeAndNil(FormHandlers[i]);

    SetLength(FormHandlers, 0);
  end;
end;


function TsPopupController.PopuChildCount(ExceptForm: TForm): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Length(FormHandlers) - 1 do
    if (FormHandlers[i] <> nil) and
         (FormHandlers[i].PopupForm <> nil) and
           (FormHandlers[i].ParentForm = ExceptForm) and
             IsWindowVisible(FormHandlers[i].PopupForm.Handle) then
      inc(Result);
end;


function TsPopupController.PopupCount(ExceptForm: TForm): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Length(FormHandlers) - 1 do
    if (FormHandlers[i] <> nil) and
         (FormHandlers[i].PopupForm <> nil) and
           (FormHandlers[i].PopupForm <> ExceptForm) and
              IsWindowVisible(FormHandlers[i].PopupForm.Handle) then
      inc(Result);
end;


function TsPopupController.GetFormIndex(Form: TForm): integer;
var
  i, l: integer;
begin
  Result := -1;
  l := Length(FormHandlers);
  for i := 0 to l - 1 do
    if FormHandlers[i].PopupForm = Form then begin
      Result := i;
      Exit;
    end;
end;


function TsPopupController.HasChild(Parent: TForm): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to Length(FormHandlers) - 1 do
    if (FormHandlers[i].PopupForm <> Parent) and (FormHandlers[i].PopupCtrl <> nil) then
      if GetParentForm(FormHandlers[i].PopupCtrl) = Parent then begin
        Result := True;
        Exit;
      end;
end;


constructor TsPopupController.Create(AOwner: TComponent);
begin
  inherited;
  SkipOpen := False;
end;


destructor TsPopupController.Destroy;
var
  i: integer;
begin
  for i := 0 to Length(FormHandlers) - 1 do
    FreeAndNil(FormHandlers[i]);

  SetLength(FormHandlers, 0);
  inherited;
end;


procedure TsPopupController.DoClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  i := GetFormIndex(TForm(Sender));
  if i >= 0 then
    FormHandlers[i].CloseForm(False);
end;


procedure TsPopupController.DoDeactivate(Sender: TObject);
begin
  if Sender <> nil then
    TForm(Sender).Close
end;


procedure TsPopupController.AnimShowPopup(aForm: TForm; wTime: word = 0; BlendValue: byte = MaxByte);
const
//  DebugOffsX = 100; DebugOffsY = -100;
  DebugOffsX = 0; DebugOffsY = 0;
  acwPopupDiv = 2;
var
  AnimBmp, acDstBmp: TBitmap;
  AnimForm: TacGlowForm;
  MaxTransparency: byte;

  DC: hdc;
  h: hwnd;
  fR: TRect;
  lTicks: DWord;
  Flags: Cardinal;
  FBmpSize: TSize;
  FBmpTopLeft: TPoint;
  FBlend: TBlendFunction;
  hNdx, i, StepCount: integer;
  dx, dy, l, t, r, b, trans, p: real;

  procedure Anim_Init;
  begin
    trans := 0;
    p := MaxTransparency / StepCount;
    if AnimDirection and 1 = 0 then begin
      t := 0;
      b := 0;
      dy := (acDstBmp.Height - b) / acwPopupDiv;
    end
    else begin
      t := acDstBmp.Height;
      b := acDstBmp.Height;
      dy := acDstBmp.Height / acwPopupDiv;
    end;
    if AnimDirection and 2 = 0 then begin
      l := 0;
      if FormHandlers[GetFormIndex(aForm)].PopupCtrl <> nil then
        r := FormHandlers[GetFormIndex(aForm)].PopupCtrl.Width
      else
        r := 0;

      dx := (acDstBmp.Width - r) / acwPopupDiv;
    end
    else begin
      if FormHandlers[GetFormIndex(aForm)].PopupCtrl <> nil then
        l := acDstBmp.Width - FormHandlers[GetFormIndex(aForm)].PopupCtrl.Width
      else
        l := 0;

      r := acDstBmp.Width;
      dx := acDstBmp.Width / acwPopupDiv;
    end;
  end;

  procedure Anim_DoNext;
  begin
    trans := min(Trans + p, MaxTransparency);
    FBlend.SourceConstantAlpha := Round(Trans);
    StretchBlt(AnimBmp.Canvas.Handle, Round(l), Round(t), Round(r - l), Round(b - t), acDstBmp.Canvas.Handle, 0, 0, acDstBmp.Width, acDstBmp.Height, SRCCOPY);
  end;

  procedure Anim_GoToNext;
  begin
    if AnimDirection and 1 = 0 then begin
      t := 0;
      b := acDstBmp.Height - dy;
    end
    else begin
      t := dy;
      b := acDstBmp.Height;
    end;
    if AnimDirection and 2 = 0 then begin
      l := 0;
      r := acDstBmp.Width - dx;
    end
    else begin
      l := dx;
      r := acDstBmp.Width;
    end;
    dx := dx / acwPopupDiv;
    dy := dy / acwPopupDiv;
  end;

  procedure UpdateShadowPos(AHandle: THandle; OwnerBounds: TacBounds; ABlend: byte);
  var
    lPos: TacLayerPos;
  begin
    with lPos do begin
      Bounds := OwnerBounds;
      lPos.LayerBlend := ABlend;
    end;
    SendAMessage(AHandle, AC_UPDATESHADOW, LParam(@lPos));
  end;

begin
  AnimForm := TacGlowForm.CreateNew(nil);
  InAnimationProcess := True;
  acDstBmp := CreateBmp32(aForm);
  acDstBmp.Canvas.Lock;
  SkinPaintTo(acDstBmp, aForm);
  if acDstBmp <> nil then begin
    FillAlphaRect(acDstBmp, MkRect(acDstBmp), MaxByte);
    acDstBmp.Canvas.UnLock;
    FBmpSize := MkSize(acDstBmp);
    StepCount := wTime div acTimerInterval;
    FBmpTopLeft := MkPoint;
{$IFDEF DELPHI7UP}
    MaxTransparency := iff(aForm.AlphaBlend, aForm.AlphaBlendValue, MaxByte);
{$ELSE}
    MaxTransparency := MaxByte;
{$ENDIF}
    if StepCount > 0 then
      FBlend.SourceConstantAlpha := 0
    else
      FBlend.SourceConstantAlpha := MaxTransparency;

    FBlend.BlendOp := AC_SRC_OVER;
    FBlend.BlendFlags := 0;
    FBlend.AlphaFormat := AC_SRC_ALPHA;

    GetWindowRect(aForm.Handle, fR);
    h := HWND_TOPMOST;

    if GetWindowLong(AnimForm.Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
      SetWindowLong(AnimForm.Handle, GWL_EXSTYLE, GetWindowLong(AnimForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

    DC := GetDC(0);
    UpdateLayeredWindow(AnimForm.Handle, DC, nil, @FBmpSize, acDstBmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
    ReleaseDC(0, DC);

    AnimForm.SetBounds(fR.Left + DebugOffsX, fR.Top + DebugOffsY, acDstBmp.Width, acDstBmp.Height);

    Flags := SWP_NOACTIVATE or SWP_NOREDRAW or SWP_NOCOPYBITS or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING;
    SetWindowPos(AnimForm.Handle, h, AnimForm.Left, AnimForm.Top, FBmpSize.cx, FBmpSize.cy, Flags);// or SWP_NOREDRAW);

    hNdx := GetFormIndex(aForm);
    if hNdx >= 0 then
      FormHandlers[hNdx].UpdateRgnBmp(acDstBmp);

    ShowWindow(AnimForm.Handle, SW_SHOWNOACTIVATE);

    AnimBmp := CreateBmp32(FBmpSize);
    FillDC(AnimBmp.Canvas.Handle, MkRect(AnimBmp), 0);
    SetStretchBltMode(AnimBmp.Canvas.Handle, COLORONCOLOR);

    if StepCount > 0 then begin
      Anim_Init;
      i := 0;
      while i <= StepCount do begin
        Anim_DoNext;
        lTicks := GetTickCount;

        DC := GetDC(0);
        UpdateLayeredWindow(AnimForm.Handle, DC, nil, @FBmpSize, AnimBmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
        UpdateShadowPos(aForm.Handle, acBounds(aForm.Left + Round(l), aForm.Top + Round(t), Round(r - l), Round(b - t)), FBlend.SourceConstantAlpha);
        ReleaseDC(0, DC);

        Anim_GoToNext;
        inc(i);
        if StepCount > 0 then
          while lTicks + acTimerInterval > GetTickCount do {wait here};
      end;
      FBlend.SourceConstantAlpha := MaxTransparency;
    end;
    SetWindowPos(AnimForm.Handle, 0, fR.Left + DebugOffsX, fr.Top + DebugOffsY, FBmpSize.cx, FBmpSize.cy, Flags or SWP_NOZORDER);
    DC := GetDC(0);
    UpdateLayeredWindow(AnimForm.Handle, DC, nil, @FBmpSize, acDstBmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
    ReleaseDC(0, DC);
    FreeAndNil(AnimBmp);
//{$IFDEF DELPHI7UP}
//    if aForm.AlphaBlend then
    DoLayered(aForm.Handle, True, BlendValue);
//{$ENDIF}
    aForm.Visible := True;
    SetWindowPos(aForm.Handle, AnimForm.Handle, 0, 0, 0, 0, SWPA_ZORDER);
    InAnimationProcess := False;
//    aForm.Perform(WM_SETREDRAW, 1, 0); // Vista and newer
//    while not RedrawWindow(aForm.Handle, nil, 0, RDWA_ALLNOW) do;
    while not RedrawWindow(aForm.Handle, nil, 0, RDWA_ALLNOW and not RDW_FRAME) do;
    FreeAndNil(acDstBmp);

    if AeroIsEnabled then
      Sleep(2 * acTimerInterval); // Removing of blinking in Aero

    SetWindowPos(AnimForm.Handle, aForm.Handle, 0, 0, 0, 0, SWPA_ZORDER);
    FreeAndNil(AnimForm)
  end;
end;


type
  TacShadowForm = class(TacGlowForm)
  protected
    FOwnerForm: TForm;
    OldWndProc: TWndMethod;
    FDestroyed: boolean;
    function OwnerBlend: byte;
    procedure AC_WMNCHitTest(var Message: TMessage); message WM_NCHITTEST;
  public
    Locked: boolean;
    procedure UpdateShadowPos;
    function ShadowTemplate: TBitmap;
    function ShadowSize: TRect;
    procedure KillShadow;
    procedure SetNewPos(aLeft, aTop, aWidth, aHeight: integer; BlendValue: byte);
    constructor CreateNew(AOwner: TComponent; Dummy: Integer  = 0); override;
    procedure NewWndProc(var Message: TMessage);
  end;


procedure TacShadowForm.AC_WMNCHitTest(var Message: TMessage);
begin
  Message.Result := HTTRANSPARENT;
end;


constructor TacShadowForm.CreateNew(AOwner: TComponent; Dummy: Integer  = 0);
begin
  inherited;
  FOwnerForm := TForm(AOwner);
  OldWndProc := FOwnerForm.WindowProc;
  FOwnerForm.WindowProc := NewWndProc;
  FDestroyed := False;
end;


procedure TacShadowForm.SetNewPos(aLeft, aTop, aWidth, aHeight: integer; BlendValue: byte);

  procedure UpdateLayer;
  var
    DC: hdc;
    sbw: integer;
    ShSizes: TRect;
    FBmpSize: TSize;
    FBmpTopLeft: TPoint;
    FBlend: TBlendFunction;
    ShadowBmp, AlphaBmp: TBitmap;
  begin
    with ShadowSize do
      FBmpSize := MkSize(aWidth + Left + Right, aHeight + Top + Bottom);

    AlphaBmp := CreateBmp32(FBmpSize);
    // Paint shadow bmp
    ShadowBmp := ShadowTemplate;
    ShSizes := ShadowSize;
    sbw := (ShadowBmp.Width - 1) div 2;
    FillRect32(AlphaBmp, MkRect(AlphaBmp), 0, 0);

    PaintControlByTemplate(AlphaBmp, ShadowBmp, MkRect(AlphaBmp),
        MkRect(ShadowBmp),
        Rect(sbw, sbw, sbw, sbw),
        ShSizes, Rect(1, 1, 1, 1), False, False); // For internal shadows - stretch only allowed

    FBlend.BlendOp := AC_SRC_OVER;
    FBlend.BlendFlags := 0;
    FBlend.AlphaFormat := AC_SRC_ALPHA;
    FBlend.SourceConstantAlpha := BlendValue;
    FBmpTopLeft := MkPoint;

    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

    DC := GetDC(0);
    try
      UpdateLayeredWindow(Handle, DC, nil, @FBmpSize, AlphaBmp.Canvas.Handle, @FBmpTopLeft, clNone, @FBlend, ULW_ALPHA);
    finally
      ReleaseDC(0, DC);
    end;
    with ShadowSize do
      SetBounds(aLeft - Left, aTop - Top, FBmpSize.cx, FBmpSize.cy);

    ShowWindow(Handle, SW_SHOWNOACTIVATE);
    SetWindowPos(Handle, FOwnerForm.Handle, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);
    AlphaBmp.Free;
  end;

begin
  if not FDestroyed then
    UpdateLayer;
end;


function TacShadowForm.ShadowTemplate: TBitmap;
begin
  Result := rShadowBmp;
end;


function TacShadowForm.ShadowSize: TRect;
const
  sSize = 9;
begin
  Result := Rect(sSize, sSize, sSize, sSize);
end;


procedure TacShadowForm.KillShadow;
begin
  if not FDestroyed then begin
    FDestroyed := True;
    FOwnerForm.WindowProc := OldWndProc;
    FOwnerForm := nil;
    Hide;
    Release;
//    Free;
  end;
end;


procedure TacShadowForm.NewWndProc(var Message: TMessage);
begin
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_UPDATESHADOW: begin
          Locked := False;
          with PacLayerPos(Message.LParam)^ do
            SetNewPos(Bounds.BLeft, Bounds.BTop, Bounds.BWidth, Bounds.BHeight, LayerBlend);

          Exit;
        end;
      end;

    WM_CLOSE, WM_DESTROY:
      KillShadow;

    WM_SHOWWINDOW:
      if Message.WParam = 0 then
        KillShadow;
  end;

  OldWndProc(Message);
  case Message.Msg of
    WM_WINDOWPOSCHANGED, WM_WINDOWPOSCHANGING, WM_SIZE:
      if not Locked and ((FOwnerForm = nil) or not IsWindowVisible(FOwnerForm.Handle)) then
        KillShadow
      else
        UpdateShadowPos;
  end;
end;


function TacShadowForm.OwnerBlend: byte;
begin
{$IFDEF DELPHI7UP}
  if FOwnerForm.AlphaBlend then
    Result := FOwnerForm.AlphaBlendValue
  else
{$ENDIF}
    Result := MaxByte;
end;


procedure TacShadowForm.UpdateShadowPos;
var
  OwnerBounds: TSrcRect;
begin
  if not Locked and (FOwnerForm <> nil) and FOwnerForm.HandleAllocated then begin
    GetWindowRect(FOwnerForm.Handle, TRect(OwnerBounds));
    with OwnerBounds do
      SetNewPos(SLeft, STop, FOwnerForm.Width, FOwnerForm.Height, OwnerBlend);
  end;
end;


function AttachShadowForm(aForm: TForm; DoShow: boolean = True): TCustomForm;
begin
  Result := TacShadowForm.CreateNew(aForm);
  TacShadowForm(Result).Locked := not DoShow;
end;


procedure TsPopupController.ShowForm(AForm: TForm; AOwnerControl: TWinControl; AnimTime: integer = 80);
var
  ctrlRect, formRect: TRect;
  ShadowForm: TacShadowForm;
  ParentForm: TCustomForm;
  bAlphaBlendValue: byte;
  HandlerIndex: integer;
  sp: TsSkinProvider;
begin
  if (AForm <> nil) and (AOwnerControl <> nil) and not SkipOpen then begin
    ShadowForm := TacShadowForm(AttachShadowForm(AForm, False));

    sp := GetSkinProvider(aForm);
    if sp <> nil then
      sp.AllowAnimation := False;

    AForm.Visible := False;
//    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
{$IFDEF DELPHI7UP}
    bAlphaBlendValue := iff(AForm.AlphaBlend, AForm.AlphaBlendValue, MaxByte);
{$ELSE}
    bAlphaBlendValue := MaxByte;
{$ENDIF}

    AForm.BorderStyle := bsNone;
    HandlerIndex := InitFormHandler(AForm, AOwnerControl);

{$IFDEF DELPHI7UP}
    SetWindowLong(AForm.Handle, GWL_STYLE, GetWindowLong(AForm.Handle, GWL_STYLE) or WS_CLIPSIBLINGS or NativeInt(WS_POPUP));
{$ELSE}
    SetWindowLong(AForm.Handle, GWL_STYLE, GetWindowLong(AForm.Handle, GWL_STYLE) or cARDINAL(WS_CLIPSIBLINGS or WS_POPUP));
{$ENDIF}

    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
    DoLayered(AForm.Handle, True);

    if DefaultManager <> nil then
      DefaultManager.UpdateScale(AForm);

    GetWindowRect(AOwnerControl.Handle, ctrlRect);
    with TSrcRect(acWorkRect(ctrlRect.TopLeft)), TDstRect(formRect) do begin
      DTop := ctrlRect.Bottom - 2;
      DLeft := ctrlRect.Left;
      DBottom := DTop + AForm.Height;
      DRight := DLeft + AForm.Width;
      AForm.SetBounds(DLeft, DTop, AForm.Width, AForm.Height);
      if DBottom > SBottom then begin
        DBottom := ctrlRect.Top - 1;
        DTop := DBottom - AForm.ClientHeight;
        if DTop < STop then begin
          DTop := STop;
          DBottom := DTop + AForm.Height;
        end;
        AForm.SetBounds(DLeft, DTop, AForm.Width, AForm.Height);
        AnimDirection := 1;
      end
      else
        AnimDirection := 0;

      if DRight > SRight then begin
        DRight := SRight;
        DLeft := DRight - AForm.ClientWidth;
        AForm.SetBounds(DLeft, DTop, AForm.Width, AForm.Height);
        AnimDirection := AnimDirection or 2;
      end;
    end;

    ParentForm := FormHandlers[HandlerIndex].ParentForm;
    if (ParentForm is TForm) and (TForm(ParentForm).FormStyle = fsStayOnTop) then
      AForm.FormStyle := fsStayOnTop;

    SetWindowPos(AForm.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);

    AForm.Visible := True;
//    ShadowForm.Locked := False;
    AnimShowPopup(AForm, AnimTime, bAlphaBlendValue);
//    if sp <> nil then // If not animated
//      sp.AllowAnimation := b;

    if not ShadowForm.FDestroyed then
      ShadowForm.UpdateShadowPos;
  end;
  SkipOpen := False;
end;


procedure TsPopupController.ShowFormPos(AForm: TForm; ALeftTop: TPoint; AnimTime: integer);
var
  ctrlRect, formRect: TRect;
  ShadowForm: TacShadowForm;
  ParentForm: TCustomForm;
  bAlphaBlendValue: byte;
  HandlerIndex: integer;
  sp: TsSkinProvider;
begin
  if (AForm <> nil) and not SkipOpen then begin
    ShadowForm := TacShadowForm(AttachShadowForm(AForm, False));

    sp := GetSkinProvider(aForm);
    if sp <> nil then
      sp.AllowAnimation := False;

    AForm.Visible := False;
//    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
{$IFDEF DELPHI7UP}
    bAlphaBlendValue := iff(AForm.AlphaBlend, AForm.AlphaBlendValue, MaxByte);
{$ELSE}
    bAlphaBlendValue := MaxByte;
{$ENDIF}

    AForm.BorderStyle := bsNone;
    HandlerIndex := InitFormHandler(AForm, nil);

{$IFDEF DELPHI7UP}
    SetWindowLong(AForm.Handle, GWL_STYLE, GetWindowLong(AForm.Handle, GWL_STYLE) or WS_CLIPSIBLINGS or NativeInt(WS_POPUP));
{$ELSE}
    SetWindowLong(AForm.Handle, GWL_STYLE, GetWindowLong(AForm.Handle, GWL_STYLE) or WS_CLIPSIBLINGS or WS_POPUP);
{$ENDIF}

    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
    DoLayered(AForm.Handle, True);

    if DefaultManager <> nil then
      DefaultManager.UpdateScale(AForm);

    ctrlRect.TopLeft := ALeftTop;
    ctrlRect.BottomRight := ALeftTop;
    with TSrcRect(acWorkRect(ctrlRect.TopLeft)), TDstRect(formRect) do begin
      DTop := ctrlRect.Bottom - 2;
      DLeft := ctrlRect.Left;
      DBottom := DTop + AForm.Height;
      DRight := DLeft + AForm.Width;
      AForm.SetBounds(DLeft, DTop, AForm.Width, AForm.Height);
      if DBottom > SBottom then begin
        DBottom := ctrlRect.Top - 1;
        DTop := DBottom - AForm.ClientHeight;
        if DTop < STop then begin
          DTop := STop;
          DBottom := DTop + AForm.Height;
        end;
        AForm.SetBounds(DLeft, DTop, AForm.Width, AForm.Height);
        AnimDirection := 1;
      end
      else
        AnimDirection := 0;

      if DRight > SRight then begin
        DRight := SRight - 1;
        DLeft := DRight - AForm.ClientWidth;
        AForm.SetBounds(DLeft, DTop, AForm.Width, AForm.Height);
        AnimDirection := AnimDirection or 2;
      end;
    end;

    ParentForm := FormHandlers[HandlerIndex].ParentForm;
    if (ParentForm is TForm) and (TForm(ParentForm).FormStyle = fsStayOnTop) then
      AForm.FormStyle := fsStayOnTop;

    SetWindowPos(AForm.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWPA_SHOWZORDERONLY);

    AForm.Visible := True;
    AnimShowPopup(AForm, AnimTime, bAlphaBlendValue);

    if not ShadowForm.FDestroyed then
      ShadowForm.UpdateShadowPos;
  end;
  SkipOpen := False;
end;


procedure TacFormHandler.UpdateRgn(AHandle: THandle);
var
  i: integer;
  sd: TsCommonData;
  Rgn: hrgn;
begin
  ClientCtrl := nil;
  for i := 0 to PopupForm.ControlCount - 1 do
    if (PopupForm.Controls[i].Align = alClient) and (PopupForm.Controls[i] is TWinControl) then begin
      ClientCtrl := TWinControl(PopupForm.Controls[i]);
      Break;
    end;

  if ClientCtrl <> nil then begin
    sd := TsCommonData(ClientCtrl.Perform(SM_ALPHACMD, AC_GETSKINDATA_HI, 0));
    if (sd <> nil) and sd.Skinned then begin
      Rgn := GetRgnFromSkin(sd.SkinIndex, MkSize(ClientCtrl.Width, ClientCtrl.Height), sd.SkinManager);
      SetWindowRgn(AHandle, Rgn, False);
    end;
  end;
end;


procedure TacFormHandler.UpdateRgnBmp(aBmp: TBitmap);
var
  i: integer;
  sd: TsCommonData;
begin
  ClientCtrl := nil;
  for i := 0 to PopupForm.ControlCount - 1 do
    if (PopupForm.Controls[i].Align = alClient) and (PopupForm.Controls[i] is TWinControl) then begin
      ClientCtrl := TWinControl(PopupForm.Controls[i]);
      Break;
    end;

  if (ClientCtrl <> nil) and (ClientCtrl.Width = aBmp.Width) and (ClientCtrl.Height = aBmp.Height) then begin
    sd := TsCommonData(ClientCtrl.Perform(SM_ALPHACMD, AC_GETSKINDATA_HI, 0));
    if (sd <> nil) and sd.Skinned then
      GetTransCorners(sd.SkinIndex, aBmp, sd.SkinManager);
  end;
end;


type
  TAccessComboBox   = class(TsCustomComboBox);
  TAccessComboBoxEx = class(TsCustomComboBoxEx);

procedure TacFormHandler.CloseForm(CallProc: boolean = True);
var
  aForm: TForm;
  ca: TCloseAction;
  sd: TsCommonData;
begin
  CheckTimer.Enabled := False;
  if not Closed and (PopupForm <> nil) and PopupForm.CloseQuery then begin
    Closed := True;
    ca := caHide;
    if Assigned(OldOnClose) then
      OldOnClose(PopupForm, ca);
{
    if ca = caNone then begin
      Closed := False;
      Exit;
    end;
}
    if ca = caNone then
      Closed := False
    else begin
      if PopupCtrl is TsCustomComboBox then
        with TAccessComboBox(PopupCtrl) do begin
          FDropDown := False;
          SkinData.Invalidate;
        end
      else{
        if PopupCtrl is TsCustomComboBoxEx then
          with TAccessComboBoxEx(PopupCtrl) do begin
            FDropDown := False;
            SkinData.Invalidate;
          end
        else}
          PopupCtrl.Perform(SM_ALPHACMD, AC_POPUPCLOSED shl 16, LParam(PopupForm));

      PopupForm.WindowProc := FormWndProc;

      sd := GetCommonData(PopupForm.Handle);
      if sd <> nil then
        sd.WndProc := nil;//FormWndProc;

      FormWndProc := nil;

      if PopupCtrl <> nil then
        PopupCtrl.WindowProc := CtrlWndProc;

      aForm := PopupForm;
      UnInitFormHandler;
      PopupForm := nil;
      PopupCtrl := nil;
      if CallProc then
        case ca of
          caHide:
            aForm.Hide;

          caFree:
            aForm.Free;
        end;

      if not Application.Active and (ParentForm <> nil) then
        SendMessage(ParentForm.Handle, WM_NCACTIVATE, 0, 0); // Update caption as inactive
    end;
  end;
end;


constructor TacFormHandler.Create(AForm: TForm; ACtrl: TWinControl);
var
  sd: TsCommonData;
begin
  inherited Create;
  PopupForm := AForm;
  PopupCtrl := ACtrl;
  Closed := False;
  FormWndProc := AForm.WindowProc;
  PopupForm.WindowProc := DoWndProc;
  sd := GetCommonData(PopupForm.Handle);
  if sd <> nil then
    sd.WndProc := DoWndProc;

  if ACtrl <> nil then begin
    CtrlWndProc := ACtrl.WindowProc;
    PopupCtrl.WindowProc := DoCtrlProc;
    ParentForm := TForm(GetParentForm(ACtrl));
  end
  else
    ParentForm := nil;

  CheckTimer := TacThreadedTimer.Create(nil);
  CheckTimer.Interval := 100;
  CheckTimer.OnTimer := DoTimer;
end;


destructor TacFormHandler.Destroy;
begin
  FreeAndNil(CheckTimer);
  inherited;
end;


procedure TacFormHandler.DoCtrlProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_MOUSEWHEEL:
      PopupForm.DefaultHandler(Message);

    CM_FOCUSCHANGED, CM_CANCELMODE, WM_RBUTTONDOWN, WM_LBUTTONDOWN: begin
//      if not (Ctrl is TCustomComboBox) then
//        Controller.SkipOpen := Message.Msg = WM_LBUTTONDOWN;

//      if not (PopupCtrl is TsCustomComboBoxEx) then
//        Controller.SkipOpen := Message.Msg = WM_LBUTTONDOWN;

      CloseForm;
    end
    else
      CtrlWndProc(Message);
  end;
end;


procedure TacFormHandler.DoTimer(Sender: TObject);
var
  CaptHandle: THandle;

  function ContainsWnd(AHandle, AParent: THandle): boolean;
  begin
    if AHandle = AParent then
      Result := True
    else
      if AHandle <> 0 then
        Result := ContainsWnd(GetParent(AHandle), AParent)
      else
        Result := False
  end;

begin
  if PopupForm <> nil then
    if not Application.Active then
      Closeform
    else begin
      CaptHandle := GetCapture;
      if CaptHandle <> 0 then
        if not ContainsWnd(CaptHandle, PopupForm.Handle) and ((PopupCtrl = nil) or not ContainsWnd(CaptHandle, PopupCtrl.Handle)) then
          if not Controller.HasChild(PopupForm) then
            Closeform;
    end;
end;


procedure TacFormHandler.DoWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
{    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN:


      end;
}

    CM_VISIBLECHANGED, CM_SHOWINGCHANGED:
      if PopupForm <> nil then begin
        if Message.WParam = 1 then
          UpdateRgn(PopupForm.Handle);

        FormWndProc(Message);
      end;
{
    WM_MOUSEWHEEL:
      PopupForm.DefaultHandler(Message);
}
    WM_MOUSEACTIVATE:
      Message.Result := MA_NOACTIVATE

    else
      if Assigned(FormWndProc) then
        FormWndProc(Message);
  end;
end;


procedure TacFormHandler.UnInitFormHandler;
begin
  if PopupForm <> nil then begin
    PopupForm.OnDeactivate := nil;
    if Assigned(OldOnClose) then
      PopupForm.OnClose := OldOnClose;
  end;
end;


var
  rst: TResourceStream = nil;

initialization
  rst := TResourceStream.Create(hInstance, 'acSHDI', RT_RCDATA);
  rShadowBmp := TBitmap.Create;
  LoadBmpFromPngStream(rShadowBmp, rst);
  UpdateTransPixels(rShadowBmp);
  FreeAndNil(rst);


finalization
  FreeAndNil(rShadowBmp);
  FreeAndNil(acIntController);

end.
