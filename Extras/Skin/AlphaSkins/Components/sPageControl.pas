unit sPageControl;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, extctrls, menus,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFDEF TNTUNICODE} TntComCtrls, TntGraphics, {$ENDIF}
  sCommonData, sConst, sSpeedButton, acSBUtils, acThdTimer;


type
{$IFNDEF NOTFORHELP}
  TacCloseAction = (acaHide, acaFree);
  TacCloseBtnClick = procedure(Sender: TComponent; TabIndex: integer; var CanClose: boolean; var Action: TacCloseAction) of object;
  TacTabMouseEvent = procedure(Sender: TComponent; TabIndex: integer) of object;


  TsPageControl = class;
  TsTabSheet = class;

  TsTabSkinData = class(TPersistent)
  private
    FCustomColor,
    FCustomFont: boolean;
    FPage: TsTabSheet;
    FSkinSection: string;
    procedure SetCustomFont (const Value: boolean);
    procedure SetSkinSection(const Value: string);
  published
    property CustomColor: boolean read FCustomColor write FCustomColor default False;
    property CustomFont:  boolean read FCustomFont  write SetCustomFont default False;
    property SkinSection: TsSkinSection read FSkinSection write SetSkinSection;
  end;


  TacTabType = (ttButton, ttMenu, ttTab);

{$IFDEF TNTUNICODE}
  TsTabSheet = class(TTntTabSheet)
{$ELSE}
  TsTabSheet = class(TTabSheet)
{$ENDIF}
  private
    FTabSkin,
    FButtonSkin: TsSkinSection;

    FTabMenu: TPopupMenu;
    FTabType: TacTabType;
    FUseCloseBtn: boolean;
    FOnClickBtn: TNotifyEvent;
    FCommonData: TsTabSkinData;
    procedure SetUseCloseBtn(const Value: boolean);
    procedure SetButtonSkin (const Value: TsSkinSection);
    procedure SetTabSkin    (const Value: TsSkinSection);
    procedure SetTabMenu    (const Value: TPopupMenu);
    procedure SetTabType    (const Value: TacTabType);
  protected
    AnimTimer: TacThreadedTimer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateParams (var Params: TCreateParams); override;
    procedure WMEraseBkGnd (var Message: TWMPaint); message WM_ERASEBKGND;
    procedure WMNCPaint    (var Message: TWMPaint); message WM_NCPAINT;
    procedure WndProc      (var Message: TMessage); override;
  published
    property ButtonSkin:  TsSkinSection read FButtonSkin  write SetButtonSkin;
    property TabType:     TacTabType    read FTabType     write SetTabType default ttTab;
    property TabMenu:     TPopupMenu    read FTabMenu     write SetTabMenu;
    property TabSkin:     TsSkinSection read FTabSkin     write SetTabSkin;
    property SkinData:    TsTabSkinData read FCommonData  write FCommonData;
    property UseCloseBtn: boolean       read FUseCloseBtn write SetUseCloseBtn default True;
    property OnClickBtn:  TNotifyEvent  read FOnClickBtn  write FOnClickBtn;
  end;


  TacTabData = record
    GlyphRect,
    TextRect,
    BtnRect,
    ArrowRect,
    FocusRect:      TRect;
    TextSize:       TSize;
    TextPos:        TPoint;
    ArrowDirection: TacSide;
  end;

  TacTabChangingEvent = procedure(Sender: TObject; NewPage: TsTabSheet; var AllowChange: Boolean) of object;
{$ENDIF}

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsPageControl = class(TTntPageControl)
{$ELSE}
  TsPageControl = class(TPageControl)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FOnCloseBtnClick: TacCloseBtnClick;
    StoredVisiblePageCount: integer;
    FAnimatEvents: TacAnimatEvents;
    FCloseBtnSkin: TsSkinSection;
    FNewDockSheet: TsTabSheet;
    FCommonData: TsCommonData;
    FShowCloseBtns: boolean;
    FAllowAnimSwitching: boolean;
    TabsBG: TBitmap;
    procedure CheckUpDown;
    procedure CMHintShow(var Message: TMessage);  message CM_HINTSHOW;
    procedure CNNotify  (var Message: TWMNotify); message CN_NOTIFY;

    procedure StdPaint(var Message: TWMPaint);
    procedure DrawStdTabs(DC: hdc);
    procedure DrawStdTab(PageIndex: Integer; State: integer; DC: hdc);

    procedure InitTabContentData(Canvas: TCanvas; Page: TTabSheet; TabRect: TRect; State: integer; IsTabMenu: boolean; var Data: TacTabData);

    procedure AcPaint(const Message: TWMPaint);
    procedure DrawSkinTabs(Bmp: TBitmap);
    procedure DrawSkinTab(PageIndex: Integer; State: integer; DstDC: hdc);

    function GetTabLayout(PageIndex: Integer; R: TRect): TacTabLayout;
    function GetNeighborIndex(PageIndex: Integer; Next: boolean): integer;
    function PageRect: TRect;
    function TabsRect: TRect;
    function TabsBGRect: TRect;
    procedure KillTimers;
    function GetActivePage: TsTabSheet;
    procedure UpdateBtnData;
    function SpinSection: string;
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
  private
    FShowFocus,
    FShowUpDown,
    FActiveIsBold,
    FRotateCaptions,
    FReflectedGlyphs,
    FActiveTabEnlarged,
    FAccessibleDisabledPages: boolean;

    FTabMargin,
    FTabPadding,
    FTabSpacing,
    FTabsLineIndex,
    FHoveredBtnIndex,
    FPressedBtnIndex: integer;

    FOnTabMouseEnter,
    FOnTabMouseLeave: TacTabMouseEvent;

    FTabAlignment: TAlignment;
    FTabsLineSkin: TsSkinSection;
    FOnPageChanging: TacTabChangingEvent;
    function GetActivePageIndex: Integer;
    procedure SetTabAlignment     (const Value: TAlignment);
    procedure SetActiveTabEnlarged(const Value: boolean);
    procedure SetShowUpDown       (const Value: boolean);
    procedure SetHoveredBtnIndex  (const Value: integer);
    procedure SetActivePageIndex  (const Value: Integer);
    procedure SetCurItem          (const Value: integer);
    procedure SetInt (const Index: Integer; const Value: integer);
    procedure SetBool(const Index: Integer; const Value: boolean);
    procedure SetTabsLineSkin(const Value: TsSkinSection);
    procedure SetCloseBtnSkin(const Value: TsSkinSection);
    procedure SetActivePage(const Value: TsTabSheet);
  protected
    FCurItem,
    BtnIndex,
    BtnWidth,
    DroppedDownItem,
    BtnHeight: integer;
    SpinWnd: TacSpinWnd;
    function BtnOffset(TabHeight: integer; Active: boolean): integer;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure PaintButton(DC: hdc; TabRect: TRect; State: integer);
    procedure RepaintTab(Ndx: integer; AllowAnimation: boolean = True);
    function VisibleTabsCount: integer;
    function IsSpecialTab(i: integer; IsMenu: boolean = False): boolean;
    function CheckActiveTab(PageIndex: integer): TTabSheet;
    function PageIndexFromTabIndex(TabIndex: Integer): Integer;
    function SkinTabRect(Index: integer; Active: boolean): TRect;

    function PrepareCache: boolean;
{$IFDEF DELPHI7UP}
    procedure SetTabIndex(Value: Integer); override;
{$ENDIF}
  public
    property ActivePageIndex: integer read GetActivePageIndex write SetActivePageIndex;
    property CurItem: integer read FCurItem write SetCurItem default -1;
    property ShowUpDown: boolean read FShowUpDown write SetShowUpDown default True;
    property HoveredBtnIndex: integer read FHoveredBtnIndex write SetHoveredBtnIndex default -1;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WndProc(var Message: TMessage); override;
    procedure Loaded; override;
    function GetTabUnderMouse(p: TPoint): integer;
    procedure AfterConstruction; override;
    procedure UpdateActivePage; override;
    procedure CloseClick(Sender: TObject);
    procedure SetPadding(Value: boolean);
  published
    property AccessibleDisabledPages: boolean read FAccessibleDisabledPages write FAccessibleDisabledPages default True;
    property ActiveTabEnlarged:       boolean read FActiveTabEnlarged       write SetActiveTabEnlarged     default True;
    property ActivePage: TsTabSheet read GetActivePage write SetActivePage;
    property AnimatEvents: TacAnimatEvents read FAnimatEvents write FAnimatEvents default [aeGlobalDef];
    property Style;
{$ENDIF}
    property CloseBtnSkin: TsSkinSection read FCloseBtnSkin write SetCloseBtnSkin;

    property ActiveIsBold:       boolean index 0 read FActiveIsBold       write SetBool default False;
    property ReflectedGlyphs:    boolean index 1 read FReflectedGlyphs    write SetBool default False;
    property RotateCaptions:     boolean index 2 read FRotateCaptions     write SetBool default False;
    property ShowCloseBtns:      boolean index 3 read FShowCloseBtns      write SetBool default False;
    property ShowFocus:          boolean index 4 read FShowFocus          write SetBool default True;
    property AllowAnimSwitching: boolean index 5 read FAllowAnimSwitching write SetBool default True;

    property TabMargin:  integer index 0 read FTabMargin  write SetInt default 3;
    property TabPadding: integer index 1 read FTabPadding write SetInt default 0;
    property TabSpacing: integer index 2 read FTabSpacing write SetInt default 6;
    property TabsLineSkin: TsSkinSection read FTabsLineSkin write SetTabsLineSkin;
    property SkinData: TsCommonData read FCommonData write FCommonData;
    property TabAlignment: TAlignment read FTabAlignment write SetTabAlignment default taCenter;

    property OnDblClick;
    property OnCloseBtnClick: TacCloseBtnClick    read FOnCloseBtnClick write FOnCloseBtnClick;
    property OnPageChanging:  TacTabChangingEvent read FOnPageChanging  write FOnPageChanging;
    property OnTabMouseEnter: TacTabMouseEvent    read FOnTabMouseEnter write FOnTabMouseEnter;
    property OnTabMouseLeave: TacTabMouseEvent    read FOnTabMouseLeave write FOnTabMouseLeave;
  end;


procedure DeletePage(Page: TsTabSheet); // Page removing without switching to the first page

implementation

uses
  math, Commctrl, Buttons,
  {$IFDEF DELPHI7UP}Themes, {$ENDIF}
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sMessages, sVclUtils, acntUtils, sMaskData, sStyleSimply, acAlphaImageList,
  sSkinProps, sAlphaGraph, sDefaults, sGraphUtils, sSkinManager, sFade, sThirdParty;


procedure InitTabData(Timer: TacThreadedTimer; AData: TObject; AIteration: integer; AAnimProc: TacAnimProc; AState: integer; AFast: boolean);
begin
  with Timer do begin
    Enabled := False;
    AnimData := AData;
    Iterations := acMaxIterations;
    if AState = 0 then
      Iterations := acMultipNormal * Iterations;

    if AFast then
      Iterations := Iterations div 2;

    if (BmpOut <> nil) then
      CopyFrom(BmpFrom, BmpOut, MkRect(BmpOut));

    case AState of
      0: case State of
        1:   Iteration := max(0, (acMaxIterations - Iteration) * 2)
        else Iteration := 0;
      end;

      1: case State of
        0, 2, 3: Iteration := AIteration;
        else     Iteration := 0
      end

      else Iteration := 0
    end;

    Value := LimitIt(Round(MaxByte * Iteration / Iterations), 0, MaxByte);
    ValueStep := (MaxByte - Value) / Iterations;

    Interval := acTimerInterval;
    AnimProc := AAnimProc;
    OldState := State;
    State    := AState;
    Enabled  := True;
  end;
end;


function UpdateTab_CB(Data: TObject; Iteration: integer): boolean;
var
  b: byte;
  DC: HDC;
  R: TRect;
  Bmp: TBitmap;
  pc: TsPageControl;
begin
  Result := False;
  if Data is TsTabSheet then
    with TsTabSheet(Data) do
      if Assigned(AnimTimer.BmpFrom) and Assigned(AnimTimer.BmpTo) then begin
        pc := TsPageControl(PageControl);
        R := pc.SkinTabRect(TabIndex, TsTabSheet(Data) = pc.ActivePage);
        Bmp := CreateBmpLike(AnimTimer.BmpTo);
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, AnimTimer.BmpFrom.Canvas.Handle, 0, 0, SRCCOPY);

        TsTabSheet(Data).AnimTimer.Value := AnimTimer.Value + TsTabSheet(Data).AnimTimer.ValueStep;
        b := LimitIt(Round(AnimTimer.Value), 0, MaxByte);

        SumBitmaps(Bmp, AnimTimer.BmpTo, MaxByte - b);
        DC := GetDC(pc.Handle);
        try
          BitBlt(DC, R.Left, R.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        finally
          ReleaseDC(pc.Handle, DC);
        end;
        Bmp.Free;
        if (TsTabSheet(Data).AnimTimer.Iteration >= TsTabSheet(Data).AnimTimer.Iterations) then begin
          if (TsTabSheet(Data).AnimTimer.State in [0, 3]) and (b < MaxByte) then begin
            Result := UpdateTab_CB(Data, Iteration);
            Exit;
          end;
        end
        else
          Result := True;
      end;
end;


type
  TsTabBtn = class(TsSpeedButton)
  public
    Page: TsTabSheet;
    constructor Create(AOwner:TComponent); override;
    procedure Paint; override;
    procedure UpdateGlyph;
  end;


const
  BtnOffsX = 4; // Offset of the Close button from right border
  iBtnSize  = 15;

var
  acBtnPressed: boolean = False;


procedure DeletePage(Page: TsTabSheet);
begin
  if (Page <> nil) then begin
    if (Page.PageIndex > 0) then
      Page.PageIndex := Page.PageIndex - 1;

    Page.Free
  end;
end;


procedure TsPageControl.AfterConstruction;
begin
  inherited;
  SkinData.Loaded;
end;


procedure TsPageControl.CheckUpDown;
var
  Wnd: HWND;
  sp: TacSkinParams;
begin
  if not (csLoading in ComponentState) and not (csCreating in ControlState) and HandleAllocated then
    if FCommonData.Skinned then begin
      Wnd := FindWindowEx(Handle, 0, UPDOWN_CLASS, nil);
      if (Wnd <> 0) then
        if FShowUpDown then begin
          if (SpinWnd <> nil) and (SpinWnd.CtrlHandle <> Wnd) then
            FreeAndNil(SpinWnd);

          if SpinWnd = nil then begin
            sp.SkinSection := SpinSection;
            sp.Control := nil;
            SpinWnd := TacSpinWnd.Create(Wnd, nil, SkinData.SkinManager, sp);
            InitCtrlData(Wnd, SpinWnd.ParentWnd, SpinWnd.WndRect, SpinWnd.ParentRect, SpinWnd.WndSize, SpinWnd.WndPos);
          end;
        end
        else
          DestroyWindow(Wnd);
    end
    else
      if SpinWnd <> nil then
        FreeAndNil(SpinWnd);
end;


procedure TsPageControl.CMDockClient(var Message: TCMDockClient);
var
  IsVisible: Boolean;
  DockCtl: TControl;
  I: Integer;
begin
  with Message do begin
    Result := 0;
    DockCtl := DockSource.Control;
    for I := 0 to PageCount - 1 do
      if DockCtl.Parent = Pages[I] then begin
        Pages[I].PageIndex := PageCount - 1;
        Exit;
      end;

    FNewDockSheet := TsTabSheet.Create(Self);
    try
      try
        if DockCtl is TCustomForm then
          FNewDockSheet.Caption := TCustomForm(DockCtl).Caption;

        FNewDockSheet.PageControl := Self;
        DockCtl.Dock(Self, DockSource.DockRect);
      except
        FNewDockSheet.Free;
        raise;
      end;
      IsVisible := DockCtl.Visible;
      FNewDockSheet.TabVisible := IsVisible;
      if IsVisible then
        ActivePage := FNewDockSheet;

      DockCtl.Align := alClient;
    finally
      FNewDockSheet := nil;
    end;
  end;
end;


procedure TsPageControl.CMHintShow(var Message: TMessage);
var
  Item: integer;
  P: TPoint;
begin
  with TCMHintShow(Message) do begin
    Item := GetTabUnderMouse(Point(HintInfo.CursorPos.X, HintInfo.CursorPos.Y));
    if (Item <> -1) and (Pages[Item].Hint <> '') then
      with HintInfo^ do begin
        P := ClientToScreen(HintInfo.CursorPos);
        P.X := P.X + GetSystemMetrics(SM_CXCURSOR) div 2;
        P.Y := P.Y + GetSystemMetrics(SM_CYCURSOR) div 2;
        HintInfo.HintPos := P;
        HintInfo.HintStr := Pages[Item].Hint;
        Message.Result := 0;
      end
    else
      inherited;
  end;
end;


procedure TsPageControl.CNNotify(var Message: TWMNotify);
begin
  if FCommonData.Skinned then
    case Message.NMHdr^.code of
      TCN_SELCHANGE: begin
        if not (csDesigning in ComponentState) and FAllowAnimSwitching and FCommonData.SkinManager.AnimEffects.PageChange.Active and SkinData.SkinManager.Effects.AllowAnimation and (ow <> nil) then begin
          KillTimers;
          inherited;
          FCommonData.Updating := True;
          AnimShowControl(Self, FCommonData.SkinManager.AnimEffects.PageChange.Time, MaxByte);//, atBluring);
          if ActivePage <> nil then
            RedrawWindow(ActivePage.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN);
        end
        else
          if (ActivePage <> nil) and not InUpdating(SkinData) then begin
            SkinData.Updating := True;
            inherited;
            SkinData.Updating := False;
            FCommonData.BGChanged := True;
            RedrawWindow(Handle, nil, 0, RDW_UPDATENOW or RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN);
          end
          else
            inherited;

        Exit;
      end;

      TCN_SELCHANGING:
        if not (csDesigning in ComponentState) and FAllowAnimSwitching and FCommonData.SkinManager.AnimEffects.PageChange.Active and FCommonData.SkinManager.Effects.AllowAnimation then begin
          PrepareForAnimation(Self);
          FCommonData.Updating := True; // Do not try to paint controls
        end
    end;

  inherited;
  if FCommonData.Skinned then
    case Message.NMHdr^.code of
      TCN_SELCHANGING:
        if (Message.Result = 1) or (ow = nil) {Animation cancelled} then begin
          FCommonData.Updating := False;
          Perform(WM_SETREDRAW, 1, 0);
          if ow <> nil then
            FreeAndNil(ow);

//          SendMessage(Handle, WM_MOUSEMOVE, 0, 0);
        end;
    end;
end;


constructor TsPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsPageControl;
  FAnimatEvents := [aeGlobalDef];
  FShowCloseBtns := False;
  FShowUpDown := True;
  FShowFocus := True;
  FHoveredBtnIndex := -1;
  FPressedBtnIndex := -1;
  FTabsLineIndex := -1;
  FRotateCaptions := False;
  FActiveIsBold := False;
  FAccessibleDisabledPages := True;
  FActiveTabEnlarged := True;
  FAllowAnimSwitching := True;
  FTabAlignment := taCenter;
  TabsBG := CreateBmp32;
  FTabSpacing := 6;
  FTabMargin := 3;
  FReflectedGlyphs := False;
  DroppedDownItem := -1;
  SpinWnd := nil;
  FCurItem := -1;
end;


destructor TsPageControl.Destroy;
begin
  TabsBG.Free;
  if Assigned(SpinWnd) then
    FreeAndNil(SpinWnd);

  if Assigned(FCommonData) then
    FreeAndNil(FCommonData);

  inherited Destroy;
end;


procedure TsPageControl.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  if FNewDockSheet <> nil then
    Client.Parent := FNewDockSheet;
end;


const
  TabsMargin = 15;
  TabOffsets: array[boolean] of integer = (-2, -1);
  TabsBGOffset: array[TTabPosition] of TPoint = ((x:0; y:0), (x:0; y:-TabsMargin), (x:0; y:0), (x:-TabsMargin; y:0)); // tpTop, tpBottom, tpLeft, tpRight


procedure TsPageControl.DrawSkinTab(PageIndex, State: integer; DstDC: hdc);
var
  C: TColor;
  CI: TCacheInfo;
  OldFont: hFont;
  Flags: Cardinal;
  SavedDC, DC: hdc;
  Page: TsTabSheet;
  SM: TsSkinManager;
  bTabMenu: boolean;
  lCaption: ACString;
  dContent: TacTabData;
  TabLayout: TacTabLayout;
  TempBmp: Graphics.TBitmap;
  aRect, rTab, rTabs, rBmp: TRect;
  TabsCovering, TabIndex, TabState: integer;
begin
  if (PageIndex >= 0) and not FCommonData.FUpdating then begin
    bTabMenu := IsSpecialTab(PageIndex);
    Page := TsTabSheet(Pages[PageIndex]);
    if not (csDestroying in Page.ComponentState) and Page.TabVisible then begin
      rTab := SkinTabRect(Page.TabIndex, (State = 2) and not bTabMenu);
      if (State <> 0) and (rTab.Left < 0) or IsRectEmpty(rTab) then
        Exit;

      SM := FCommonData.SkinManager;
      if SM.ConstData.Tabs[tlSingle][asTop].SkinIndex >= 0 then begin
        // Tabs drawing
        TabState := State;
        if bTabMenu then begin
          if TsTabSheet(Page).TabSkin <> '' then
            TabIndex := SM.GetSkinIndex(Page.TabSkin)
          else
            TabIndex := SM.ConstData.Sections[ssMenuButton];

          if TabIndex < 0 then
            if Page.TabType = ttMenu then
              TabIndex := SM.ConstData.Sections[ssMenuItem]
            else
              TabIndex := SM.ConstData.Sections[ssSpeedButton];

          InflateRect(rTab, TabOffsets[TabPosition in [tpTop, tpBottom]], TabOffsets[not (TabPosition in [tpTop, tpBottom])])
        end
        else
          if TsTabSheet(Page).TabSkin <> '' then
            TabIndex := SM.GetSkinIndex(Page.TabSkin)
          else
            case Style of
              tsTabs: begin
                TabLayout := GetTabLayout(PageIndex, rTab);
                TabIndex := SM.ConstData.Tabs[TabLayout][acTabSides[TabPosition]].SkinIndex;
                if TabIndex < 0 then
                  TabIndex := SM.ConstData.Tabs[tlSingle][acTabSides[TabPosition]].SkinIndex;
              end;

              tsButtons:
                TabIndex := SM.ConstData.Sections[ssButton]

              else
                TabIndex := SM.ConstData.Sections[ssToolButton];
            end;

        aRect := rTab;
{$IFDEF TNTUNICODE}
        if Page is TTntTabSheet then
          lCaption := TTntTabSheet(Page).Caption
        else
{$ENDIF}
          lCaption := Page.Caption;

        TabsCovering := 0;
        if (Style = tsTabs) and (Page.TabType = ttTab) then
          if Page.TabSkin = '' then
            TabsCovering := SM.CommonSkinData.TabsCovering
          else
            if Page.TabSkin = s_RibbonTab then
              TabsCovering := SM.CommonSkinData.RibbonCovering;

        // Draw tab on bitmap
        TempBmp := CreateBmp32(rTab);
        rBmp := MkRect(TempBmp);
        if Page.SkinData.CustomFont then
          TempBmp.Canvas.Font.Assign(Page.Font)
        else begin
          TempBmp.Canvas.Font.Assign(Font);
          TempBmp.Canvas.Font.Color := SM.gd[TabIndex].Props[min(State, ac_MaxPropsIndex)].FontColor.Color;
        end;
        if ActiveIsBold and (Page = ActivePage) then
          TempBmp.Canvas.Font.Style := TempBmp.Canvas.Font.Style + [fsBold];

        TempBmp.Canvas.Brush.Style := bsClear;
        if (TabIndex >= 0) and (SM.gd[TabIndex].States <= TabState) then
          TabState := SM.gd[TabIndex].States - 1;

        if TabsCovering > 0 then
          CI := MakeCacheInfo(FCommonData.FCacheBmp)
        else begin
          rTabs := TabsBGRect;
          CI := MakeCacheInfo(TabsBG, TabsBGOffset[TabPosition].X - rTabs.Left, TabsBGOffset[TabPosition].Y - rTabs.Top);
        end;

        PaintItem(TabIndex, CI, True, TabState, rBmp, rTab.TopLeft, TempBmp, SM);
        // End of tabs drawing
        if TabPosition in [tpTop, tpBottom] then begin
          if TabsCovering > 0 then
            InflateRect(rBmp, -TabsCovering * 2, 0);
        end
        else
          if TabsCovering > 0 then
            InflateRect(rBmp, 0, -TabsCovering * 2);

        if not OwnerDraw then begin
          // Tab content drawing
          TempBmp.Canvas.Lock;
          Flags := DT_SINGLELINE or DT_VCENTER;// or DT_LEFT;
          if UseRightToLeftReading then
            Flags := Flags or DT_RTLREADING or DT_NOCLIP;

          OldFont := 0;
          if (TabPosition in [tpLeft, tpRight]) and not RotateCaptions or (TabPosition in [tpTop, tpBottom]) and RotateCaptions then // If vertical text
            OldFont := MakeAngledFont(TempBmp.Canvas.Handle, TempBmp.Canvas.Font, -2700); // Rotated font initialization
          // Get coordinates for tab content
          InitTabContentData(TempBmp.Canvas, Page, rBmp, State, bTabMenu, dContent);
          // Draw glyph if rect is not empty
          if not IsRectEmpty(dContent.GlyphRect) then
            if (Images is TsAlphaImageList) and SM.Effects.DiscoloredGlyphs then begin
              if State = 0 then
                if TabIndex <> -1 then
                  C := SM.gd[TabIndex].Props[0].Color
                else
                  C := clBtnFace
              else
                C := clNone;

              DrawAlphaImgList(Images, TempBmp, dContent.GlyphRect.Left, dContent.GlyphRect.Top, Page.ImageIndex, 0, C, 0, 1, ReflectedGlyphs)
            end
            else
              Images.Draw(TempBmp.Canvas, dContent.GlyphRect.Left, dContent.GlyphRect.Top, Page.ImageIndex, True);

          // Write Text
          if dContent.ArrowRect.Left = dContent.ArrowRect.Right then
            Flags := Flags or DT_END_ELLIPSIS; // Draw ellipsis if not menu

          if OldFont <> 0 then begin // If font is rotated
            lCaption := CutText(TempBmp.Canvas, lCaption, HeightOf(dContent.TextRect));
            acTextRect(TempBmp.Canvas, dContent.TextRect, dContent.TextPos.X, dContent.TextPos.Y, lCaption);
            SelectObject(TempBmp.Canvas.Handle, OldFont); // Returning prev. font
          end
          else
            if Page.SkinData.CustomFont then
              acTextRect(TempBmp.Canvas, dContent.TextRect, dContent.TextPos.X, dContent.TextPos.Y, lCaption)
            else
              WriteText32(TempBmp, PacChar(lCaption), True, dContent.TextRect, Flags, TabIndex, boolean(State), SM);
          // Paint focus rect
          if not IsRectEmpty(dContent.FocusRect) then begin
            TempBmp.Canvas.Pen.Color := clWindowFrame;
            TempBmp.Canvas.Brush.Color := clBtnFace;
            TempBmp.Canvas.Brush.Style := bsClear;
            TempBmp.Canvas.DrawFocusRect(dContent.FocusRect);
          end;
          // Paint Close btn
          if not IsRectEmpty(dContent.BtnRect) then
            PaintButton(TempBmp.Canvas.Handle, dContent.BtnRect, integer(FHoveredBtnIndex = PageIndex) + integer(FPressedBtnIndex = PageIndex));
          // Draw Arrow
          if not IsRectEmpty(dContent.ArrowRect) then
            DrawColorArrow(TempBmp.Canvas, SkinData.SkinManager.gd[TabIndex].Props[TabState].FontColor.Color, dContent.ArrowRect, dContent.ArrowDirection);

          if not Page.Enabled or not Enabled then
            BlendTransRectangle(TempBmp, 0, 0, FCommonData.FCacheBmp, rTab, DefDisabledBlend);

          BitBlt(DstDC, aRect.Left, aRect.Top, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
          TempBmp.Canvas.Unlock;
        end
        else
          if Assigned(OnDrawTab) then begin
            BitBlt(DstDC, aRect.Left, aRect.Top, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
            DC := Canvas.Handle;
            Canvas.Handle := DstDC;
            SavedDC := SaveDC(Canvas.Handle);
            OnDrawTab(Self, Page.TabIndex, aRect, State <> 0);
            RestoreDC(Canvas.Handle, SavedDC);
            Canvas.Handle := DC;
          end;

        FreeAndNil(TempBmp);
      end;
    end;
  end;
end;


procedure TsPageControl.DrawSkinTabs(Bmp: TBitmap);
var
  i: integer;
  CI: TCacheInfo;
  R, RTabsBG: TRect;
begin
  if not (csDestroying in ComponentState) then begin
    CI := GetParentCache(FCommonData);
    R := TabsRect;

    if ActivePage <> nil then begin
      RTabsBG := RectsAnd(PageRect, SkinTabRect(ActivePage.TabIndex, True));
      if not IsRectEmpty(RTabsBG) then
        if not ci.Ready then
          FillDC(Bmp.Canvas.Handle, RTabsBG, CI.FillColor)
        else
          BitBlt(Bmp.Canvas.Handle, RTabsBG.Left, RTabsBG.Top, WidthOf(RTabsBG), HeightOf(RTabsBG),
                 ci.Bmp.Canvas.Handle, ci.X + Left + RTabsBG.Left, ci.Y + Top + RTabsBG.Top, SRCCOPY);
    end;

    Bmp.Canvas.Lock;
    if FTabsLineIndex >= 0 then
      PaintItem(FTabsLineIndex, CI, True, 0, R, Point(0, 0), Bmp, SkinData.SkinManager)
    else
      if not ci.Ready then
        FillDC(Bmp.Canvas.Handle, R, CI.FillColor)
      else
        BitBlt(Bmp.Canvas.Handle, R.Left, R.Top, min(WidthOf(R), ci.Bmp.Width), min(HeightOf(R), ci.Bmp.Height),
               ci.Bmp.Canvas.Handle, ci.X + Left + R.Left, ci.Y + Top + R.Top, SRCCOPY);

    if Bmp = SkinData.FCacheBmp then begin
      RTabsBG := TabsBGRect;
      TabsBG.Width  := WidthOf (RTabsBG);
      TabsBG.Height := HeightOf(RTabsBG);
      BitBlt(TabsBG.Canvas.Handle, 0, 0, TabsBG.Width, TabsBG.Height, Bmp.Canvas.Handle, R.Left - TabsBGOffset[TabPosition].X, R.Top - TabsBGOffset[TabPosition].Y, SRCCOPY);
      FillAlphaRect(TabsBG, MkRect(TabsBG), MaxByte);
    end;

    for i := PageCount - 1 downto 0 do
      if Pages[i].TabVisible and ((Pages[i] <> ActivePage) or (TsTabSheet(Pages[i]).TabType <> ttTab)) then
        DrawSkinTab(i, iff((DroppedDownItem = i) or ((FPressedBtnIndex = i) and (TsTabSheet(Pages[i]).TabType <> ttTab)), 2, integer(CurItem = i)), Bmp.Canvas.Handle);

    // Draw active tab
    if (Tabs.Count > 0) and (ActivePage <> nil) and (ActivePage.TabType = ttTab) then
      DrawSkinTab(ActivePage.PageIndex, 2, Bmp.Canvas.Handle);

    Bmp.Canvas.UnLock;
  end;
end;


function TsPageControl.GetActivePage: TsTabSheet;
begin
  Result := TsTabSheet(inherited ActivePage);
end;


function TsPageControl.GetTabUnderMouse(p: TPoint): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to PageCount - 1 do
    if Pages[i] = ActivePage then begin
      if PtInRect(SkinTabRect(Pages[i].TabIndex, True), p) then begin
        Result := i;
        Exit;
      end;
    end
    else
      if PtInRect(TabRect(Pages[i].TabIndex), p) then begin
        Result := i;
        Exit;
      end;
end;


procedure TsPageControl.Loaded;
begin
  inherited;
  SkinData.Loaded;
  if ActivePage <> nil then begin
    AddToAdapter(ActivePage);
    CheckUpDown;
    inherited ActivePage := CheckActiveTab(ActivePage.PageIndex);
  end;
  if FTabPadding <> 0 then begin
    UpdateBtnData;
    Perform(WM_SIZE, 0, 0);
  end;
end;


function TsPageControl.PageRect: TRect;
var
  r: TRect;
begin
  Result := MkRect(Width, Height);
  if Tabs.Count > 0 then begin
    AdjustClientRect(r);
    case TabPosition of
      tpTop:    Result.Top    := R.Top    - TopOffset;
      tpBottom: Result.Bottom := R.Bottom + BottomOffset;
      tpLeft:   Result.Left   := R.Left   - LeftOffset
      else      Result.Right  := R.Right  + RightOffset;
    end;
  end;
end;


procedure TsPageControl.RepaintTab(Ndx: integer; AllowAnimation: boolean = True);
var
  R: TRect;
  Bmp: TBitmap;
  DC, SavedDC: hdc;
  State, i: integer;

  function GetTabState: integer;
  begin
    if (Ndx <> CurItem) or not HotTrack and (State = 1) then
      Result := 0
    else
      if (CurItem = FPressedBtnIndex) then
        Result := 4
      else
        if (CurItem = FHoveredBtnIndex) then
          Result := 3
        else
          Result := 1 + integer((FPressedBtnIndex = CurItem) or (DroppedDownItem = CurItem));
  end;

begin
  if not (FCommonData.FUpdating and SkinData.Skinned) and BetWeen(Ndx, 0, PageCount - 1) then begin
    if SkinData.Skinned then begin
      if not SkinData.SkinManager.Effects.AllowAnimation then
        AllowAnimation := False;

      R := TsPageControl(Pages[Ndx].PageControl).SkinTabRect(Pages[Ndx].TabIndex, Pages[Ndx] = ActivePage);
      Bmp := CreateBmpLike(SkinData.FCacheBmp);
      DrawSkinTabs(Bmp);
      if AllowAnimation then
        with TsTabSheet(Pages[Ndx]) do begin
          State := GetTabState;
          i := GetNewTimer(AnimTimer, Pages[Ndx], State);
          if AnimTimer.BmpFrom <> nil then
            FreeAndNil(AnimTimer.BmpFrom);

          if AnimTimer.BmpTo <> nil then
            AnimTimer.BmpFrom := AnimTimer.BmpTo;

          if AnimTimer.BmpFrom = nil then begin
            AnimTimer.BmpFrom := CreateBmp32(R);
            BitBlt(AnimTimer.BmpFrom.Canvas.Handle, 0, 0, AnimTimer.BmpFrom.Width, AnimTimer.BmpFrom.Height, TsPageControl(Pages[Ndx].PageControl).SkinData.FCacheBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
          end;
          AnimTimer.BmpTo := CreateBmp32(AnimTimer.BmpFrom);
          BitBlt(AnimTimer.BmpTo.Canvas.Handle, 0, 0, AnimTimer.BmpTo.Width, AnimTimer.BmpTo.Height, Bmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
          if (AnimTimer.State = -1) or (State <> AnimTimer.State) then begin // Not started already
            InitTabData(AnimTimer, Pages[Ndx], i, UpdateTab_CB, State, (State = 2) and (TabType <> ttTab) or (State = 4));
            UpdateTab_CB(Pages[Ndx], i);
          end;
        end
      else begin
        DC := GetDC(Handle);
        SavedDC := SaveDC(DC);
        try
          BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), Bmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
        finally
          RestoreDC(DC, SavedDC);
          ReleaseDC(Handle, DC);
        end;
      end;
      Bmp.Free;
    end
    else begin
      State := GetTabState;
      DC := GetDC(Handle);
      SavedDC := SaveDC(DC);
      try
        R := TabRect(Pages[Ndx].TabIndex);
        if (ActivePage <> nil) and (ActivePage.TabType = ttTab) and (Pages[Ndx] <> ActivePage) then begin
          InterSectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
          R := TabRect(ActivePage.TabIndex);
          InflateRect(R, 2, 2);
          ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom)
        end;
        if (DroppedDownItem = Ndx) then
          State := 2;

        if (Pages[Ndx] = ActivePage) then
          State := 2
        else
          if (State > 2) then
            State := 1;

        DrawStdTab(Ndx, State, DC);
      finally
        RestoreDC(DC, SavedDC);
        ReleaseDC(Handle, DC);
      end;
    end;
  end
end;


procedure TsPageControl.SetActivePage(const Value: TsTabSheet);
begin
  if Value <> nil then begin
    inherited ActivePage := CheckActiveTab(Value.PageIndex);
    AddToAdapter(ActivePage);
    if not Value.TabVisible and not SkinData.FUpdating then
      SetParentUpdated(Value); // Update because TCM_SETCURSEL is not received
  end
  else
    inherited ActivePage := nil;
end;


function TsPageControl.SkinTabRect(Index: integer; Active: boolean): TRect;
var
  aTabsCovering: integer;

  function GetTabCovering(aIndex: integer): integer;
  begin
    Result := 0;
    if TsTabSheet(Pages[aIndex]).TabType = ttTab then
      if TsTabSheet(Pages[aIndex]).TabSkin = '' then
        Result := FCommonData.SkinManager.CommonSkinData.TabsCovering
      else
        if TsTabSheet(Pages[aIndex]).TabSkin = s_RibbonTab then
          Result := FCommonData.SkinManager.CommonSkinData.RibbonCovering;
  end;

begin
  Result := MkRect;
  if BetWeen(Index, 0, PageCount - 1) then begin
    Result := TabRect(Index);
    if FActiveTabEnlarged then begin
      if (Style = tsTabs) and (Result.Left <> Result.Right) and Active then
        InflateRect(Result, 2, 2);

      aTabsCovering := 0;
      if (Style = tsTabs) and (FCommonData.SkinManager <> nil) then
        if TsTabSheet(Pages[Index]).TabType = ttTab then
          aTabsCovering := GetTabCovering(Index)
        else
          if Index > 0 then 
            Result.Left := Result.Left + (GetTabCovering(Index - 1) + 1)
          else
            if Index < Self.PageCount - 1 then
              Result.Right := Result.Right - (GetTabCovering(Index + 1) + 1);

      if TabPosition in [tpTop, tpBottom] then begin
        if aTabsCovering > 0 then begin
          OffsetRect (Result, aTabsCovering, 0);
          InflateRect(Result, aTabsCovering, 0);
        end;
      end
      else
        if aTabsCovering > 0 then begin
          OffsetRect (Result, 0, aTabsCovering);
          InflateRect(Result, 0, aTabsCovering);
        end;
    end
    else
      if TabPosition in [tpLeft, tpRight] then begin
        InflateRect(Result, 2, 2 * integer(Active));
        if TabPosition = tpLeft then
          if Active then
            inc(Result.Right)
          else
            dec(Result.Right)
      end
      else
        InflateRect(Result, 0, 2);
  end;
end;


function TsPageControl.SpinSection: string;
begin
  if SkinData.SkinManager.ConstData.Sections[ssUpDown] < 0 then
    Result := s_Button
  else
    Result := s_UpDown;
end;


function TsPageControl.TabsRect: TRect;
var
  R: TRect;
begin
  if Tabs.Count > 0 then begin
    Result := MkRect(Width, Height);
    AdjustClientRect(R);
    case TabPosition of
      tpTop:    Result.Bottom := R.Top    - TopOffset;
      tpBottom: Result.Top    := R.Bottom + BottomOffset;
      tpLeft:   Result.Right  := R.Left   - LeftOffset
      else      Result.Left   := R.Right  + RightOffset;
    end;
  end
  else
    Result := MkRect;
end;


function TsPageControl.TabsBGRect: TRect;
var
  R: TRect;
begin
  if Tabs.Count > 0 then begin
    Result := MkRect(Width, Height);
    AdjustClientRect(R);
    case TabPosition of
      tpTop:    Result.Bottom := R.Top    - TopOffset    + TabsMargin;
      tpBottom: Result.Top    := R.Bottom + BottomOffset - TabsMargin;
      tpLeft:   Result.Right  := R.Left   - LeftOffset   + TabsMargin
      else      Result.Left   := R.Right  + RightOffset  - TabsMargin;
    end;
  end
  else
    Result := MkRect;
end;


procedure TsPageControl.UpdateActivePage;
var
  DC, SavedDC: hdc;
begin
  inherited;
  if FCommonData.Skinned and not SkinData.SkinManager.AnimEffects.PageChange.Active and FAllowAnimSwitching and FCommonData.SkinManager.Effects.AllowAnimation and not FCommonData.Updating then
    if StoredVisiblePageCount <> VisibleTabsCount then begin
      Perform(WM_PAINT, 0, 0);
      if Assigned(ActivePage) then
        ActivePage.Repaint
    end
    else
      if ActivePage <> nil then begin // Active tab repainting
        DC := GetDC(Handle);
        SavedDC := SaveDC(DC);
        SkinData.BGChanged := True;
        try
          DrawSkinTab(ActivePage.PageIndex, 2, DC)
        finally
          RestoreDC(DC, SavedDC);
          ReleaseDC(Handle, DC);
        end;
      end
      else
        FCommonData.Invalidate;
end;


function TsPageControl.VisibleTabsCount: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to PageCount - 1 do
    if Pages[i].TabVisible then
      inc(Result);
end;


procedure TsPageControl.AcPaint(const Message: TWMPaint);
var
  R: TRect;
  b: boolean;
  DC, SavedDC: hdc;
begin
  if not (csDestroying in Parent.ComponentState) and not (csLoading in ComponentState) then begin
    if not InUpdating(FCommonData, False) then
      FCommonData.FUpdating := GetBoolMsg(Parent, AC_PREPARING); // Transparent BG may be not ready if PageControl haven't cached BG

    if not FCommonData.FUpdating then begin
      if (SkinData.CtrlSkinState and ACS_PRINTING = ACS_PRINTING) and (Message.DC = SkinData.PrintDC) then
        DC := Message.DC
      else
        DC := GetDC(Handle);

      try
        // If transparent and form resizing processed
        b := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
        GetClipBox(DC, R); // If control is shown partially (remember it)
        FCommonData.HalfVisible := (WidthOf(R) <> Width) or (HeightOf(R) <> Height);
        if b then // If cache is changed
          if not PrepareCache then
            Exit;

        // Output to DC
        if DroppedDownItem >= 0 then begin // If TabMenu is dropped down then don't repaint
          SavedDC := SaveDC(DC);
          R := TabRect(DroppedDownItem);
          ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
          CopyWinControlCache(Self, FCommonData,  MkRect, MkRect(Self), DC, True);
          RestoreDC(DC, SavedDC);
        end
        else
          CopyWinControlCache(Self, FCommonData,  MkRect, MkRect(Self), DC, True);

        sVCLUtils.PaintControls(DC, Self, True, MkPoint); // Paint skinned TGraphControls
        if (ActivePage <> nil) then begin // Draw active tab
{$IFDEF D2005}
          if (csDesigning in ComponentState) then
            RedrawWindow(ActivePage.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ERASE);
{$ENDIF}
          if (ActivePage.BorderWidth > 0) then
            ActivePage.Perform(WM_NCPAINT, 0, 0);

          SetParentUpdated(Self);
        end;
      finally
        if DC <> Message.DC then
          ReleaseDC(Handle, DC);
      end;
    end;
    StoredVisiblePageCount := VisibleTabsCount;
  end;
end;


function CanBeActive(Page: TsTabSheet; PageControl: TsPageControl): boolean;
var
  b: boolean;
begin
  if (Page <> nil) and (Page.TabType = ttTab) and (PageControl.AccessibleDisabledPages or Page.Enabled) then
    if Assigned(PageControl.OnPageChanging) then begin
      b := True;
      PageControl.OnPageChanging(PageControl, Page, b);
      Result := b;
    end
    else
      Result := True
  else
    Result := False;
end;


procedure TsPageControl.WndProc(var Message: TMessage);
var
  R: TRect;
  p: TPoint;
  b: boolean;
  aMsg: tagMsg;
  DC, SavedDC: hdc;
  PS: TPaintStruct;
  Page: TsTabSheet;
  TabData: TacTabData;
  NewItem, i: integer;
  Act: TacCloseAction;
begin
{$IFDEF LOGGED}
  if (Tag = 7) and Parent.Parent.HandleAllocated and IsWindowVisible(Parent.Parent.Handle) then
    AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_PAINT:
      if (Visible or (csDesigning in ComponentState)) then begin
        BeginPaint(Handle, PS);
        TWMPaint(Message).DC := GetDC(Handle);
        try
          if FCommonData.Skinned then begin
            if IsCached(FCommonData) and not InAnimationProcess or (csDesigning in ComponentState) then begin
              b := False;
              for i := 0 to PageCount - 1 do
                if (TsTabSheet(Pages[i]).AnimTimer <> nil) and TsTabSheet(Pages[i]).AnimTimer.Enabled then begin
                  b := True;
                  Break;
                end;

              if not b then
                AcPaint(TWMPaint(Message));

              Message.Result := 1;
            end;
          end
          else
            StdPaint(TWMPaint(Message));
        finally
          ReleaseDC(Handle, TWMPaint(Message).DC);
          EndPaint(Handle, PS);
        end;
        Message.Result := 0;
        Exit;
      end
      else
        inherited;

    TCM_SETCURSEL: begin
      KillTimers;
      inherited;
      if FCommonData.Skinned then begin
        FCommonData.BGChanged := True;
        RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME);
        if not SkinData.FUpdating then
          SetParentUpdated(Self);
      end
      else
        RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_FRAME);

      Exit;
    end;

    TCM_SETIMAGELIST: begin
      inherited;
      if HandleAllocated then
        Perform(WM_SIZE, 0, 0);

      CheckUpDown;
      Exit;
    end;

    CM_DIALOGKEY:
      if (TWMKey(Message).CharCode = Ord(#9)) and (GetKeyState(VK_CONTROL) < 0) and (ActivePage <> nil) then begin
        Page := nil;
        if ActivePage.PageIndex = PageCount - 1 then
          i := 0
        else
          i := ActivePage.PageIndex + 1;

        while i < PageCount do begin
          if Pages[i].TabVisible then begin
            Page := TsTabSheet(Pages[i]);
            Break;
          end;
          inc(i);
        end;
        if not CanBeActive(Page, Self) then
          Exit;
      end;

    WM_KEYDOWN:
      if ActivePage <> nil then
        case Message.WParamLo of
          VK_LEFT: begin
            Page := nil;
            for i := ActivePage.PageIndex - 1 downto 0 do
              if Pages[i].TabVisible then begin
                Page := TsTabSheet(Pages[i]);
                Break;
              end;

            if not CanBeActive(Page, Self) then
              Exit;
          end;

          VK_RIGHT: begin
            Page := nil;
            for i := ActivePage.PageIndex + 1 to PageCount - 1 do
              if Pages[i].TabVisible then begin
                Page := TsTabSheet(Pages[i]);
                Break;
              end;

            if not CanBeActive(Page, Self) then
              Exit;
          end;
        end;

    WM_MOUSELEAVE, CM_MOUSELEAVE:
      if not (csDesigning in ComponentState) and not (csDestroying in ComponentState) and (CurItem <> -1) then begin
        p := ScreeNToClient(acMousePos);
        R := TabsRect;
        if not SkinData.Skinned then
          inherited;

        FPressedBtnIndex := -1;
        FHoveredBtnIndex := -1;
        acBtnPressed := False;
        if BetWeen(CurItem, 0, PageCount - 1) and Assigned(FOnTabMouseLeave) then
          FOnTabMouseLeave(Self, CurItem);

        CurItem := -1;
        Exit;
      end;

    WM_MOUSEMOVE:
      if not (csDesigning in ComponentState) and not (csDestroying in ComponentState) then begin
        if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) then
          DefaultManager.ActiveControl := Handle;

        p.x := TCMHitTest(Message).XPos;
        p.y := TCMHitTest(Message).YPos;
        NewItem := GetTabUnderMouse(p);
        if BetWeen(NewItem, 0, PageCount - 1) and TsTabSheet(Pages[NewItem]).Enabled then begin // If tab is hovered
          Page := TsTabSheet(Pages[NewItem]);
          inherited;
          if not SkinData.Skinned or not SkinData.SkinManager.Effects.AllowAnimation then begin
            PeekMessage(aMsg, Handle, WM_PAINT, WM_PAINT, PM_REMOVE); // Prevent an automatic repainting
            Application.ProcessMessages;
          end;
          if FShowCloseBtns then
            case Page.TabType of
              ttTab: begin // Check if Close button was hovered
                InitTabContentData(Canvas, Page, TabRect(Page.TabIndex), 1 + integer(Page = ActivePage), False, TabData);
                if PtInRect(TabData.BtnRect, p) then begin
                  if (FHoveredBtnIndex <> NewItem) then begin
                    i := FHoveredBtnIndex;
                    FHoveredBtnIndex := NewItem;
                    RepaintTab(FHoveredBtnIndex);
                    if (i <> -1) then
                      RepaintTab(i);
                  end;
                end
                else
                  if (FHoveredBtnIndex <> -1) then begin
                    FHoveredBtnIndex := -1;
                    FPressedBtnIndex := -1;
                    RepaintTab(NewItem);
                  end;
              end
            end;

          if (NewItem <> CurItem) then begin // If hot item is changed
            if BetWeen(CurItem, 0, PageCount - 1) then begin
              if ShowHint and (Page.Hint <> '') then begin
                Application.HideHint;
                Application.ActivateHint(acMousePos);
              end;
              if Assigned(FOnTabMouseLeave) then
                FOnTabMouseLeave(Self, CurItem);

              if (ActivePage = Pages[NewItem]) and ((CurItem <> ActivePageIndex) or ShowCloseBtns) then
                NewItem := -1;
            end;
            if Assigned(FOnTabMouseEnter) then
              FOnTabMouseEnter(Self, NewItem);

            CurItem := NewItem;
          end;
        end
        else begin
          FHoveredBtnIndex := -1;
          FPressedBtnIndex := -1;
          if (CurItem <> -1) and ((CurItem <> ActivePageIndex) or ShowCloseBtns) then begin
            CurItem := -1;
            acBtnPressed := False;
          end;
        end;
        Exit;
      end;

    WM_LBUTTONUP, WM_LBUTTONDOWN:
      if not (csDesigning in ComponentState) then begin
        if not Enabled then
          Exit;

        p.x := TCMHitTest(Message).XPos;
        p.y := TCMHitTest(Message).YPos;
        NewItem := GetTabUnderMouse(p);
        if (NewItem > -1) then begin // If tab is pressed
          Page := TsTabSheet(Pages[NewItem]);
          if not FAccessibleDisabledPages and not Page.Enabled then
            Exit;

          case Page.TabType of
            ttMenu: begin
              if (Page.TabMenu <> nil) and (Message.Msg = WM_LBUTTONDOWN) then begin
                DroppedDownItem := NewItem;
                RepaintTab(NewItem, False);
                p := ClientToScreen(MkPoint);
                R := TabRect(Page.TabIndex);
                TempControl := pointer(Self);
                Page.TabMenu.PopupComponent := Self;
                if (TabPosition in [tpLeft, tpRight]) and not RotateCaptions or (TabPosition in [tpTop, tpBottom]) and RotateCaptions then
                  Page.TabMenu.Popup(p.X + R.Right, p.Y + R.Top)
                else
                  Page.TabMenu.Popup(p.X + R.Left, p.Y + R.Bottom - 2);

                Page.TabMenu.PopupComponent := nil;
                TempControl := nil;
              end;
              DroppedDownItem := -1;
              CurItem := -1;
              KillTimers;
              FCommonData.Updating := False;
              RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW or RDW_FRAME);
              Perform(WM_NCPAINT, 0, 0);
              Exit;
            end;

            ttButton:
              if Page.Enabled then begin
                i := FPressedBtnIndex;
                FPressedBtnIndex := iff(Message.Msg = WM_LBUTTONDOWN, NewItem, -1);
                RepaintTab(NewItem);
                if (Message.Msg <> WM_LBUTTONDOWN) and (i = NewItem) and Assigned(Page.OnClickBtn) then
                  Page.OnClickBtn(Pages[NewItem]);

                Exit;
              end;

            else
              if FShowCloseBtns and Page.UseCloseBtn then begin
                InitTabContentData(Canvas, Page, TabRect(Page.TabIndex), 1 + integer(Page = ActivePage), IsSpecialTab(NewItem), TabData);
                if PtInRect(TabData.BtnRect, p) then begin
                  FPressedBtnIndex := iff(Message.Msg = WM_LBUTTONDOWN, NewItem, -1);
                  RepaintTab(NewItem);
                  if (WM_LBUTTONUP = Message.Msg) then begin
                    if not acBtnPressed then
                      Exit;

                    Act := acaFree;
                    b := True;
                    if Assigned(OnCloseBtnClick) then
                      OnCloseBtnClick(Self, NewItem, b, Act);

                    if b and (Pages[NewItem] <> nil) then begin
                      i := ActivePageIndex;
                      Perform(WM_SETREDRAW, 0, 0);
                      KillTimers;
                      SkinData.BeginUpdate;
                      if Act = acaFree then
                        Page.Free
                      else
                        Page.TabVisible := False;

                      if BetWeen(i, 0, PageCount - 1) then begin
                        ActivePage := TsTabSheet(Pages[min(i, PageCount - 1)]);
                        if Assigned(OnChange) then
                          OnChange(Self);
                      end;
                      SkinData.EndUpdate;
                      Perform(WM_SETREDRAW, 1, 0);
                      FCommonData.BGChanged := True;
                      RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW or RDW_FRAME);
                    end;
                    acBtnPressed := False;
                    FPressedBtnIndex := -1;
                  end
                  else
                    acBtnPressed := True;

                  Exit;
                end
                else begin
                  if not CanBeActive(Page, Self) then
                    Exit; // Preventing of the page activation

                  if (WM_LBUTTONUP = Message.Msg) then
                    FPressedBtnIndex := -1;
                end;
              end
              else begin
                if (Page = ActivePage) and CanFocus then
                  SetFocus;

                if not CanBeActive(Page, Self) or (Page = ActivePage) then
                  Exit; // Preventing of the page activation
              end;
          end;
        end;
      end;
  end;
  if (Message.Msg = SM_ALPHACMD) and Assigned(FCommonData) then
    case Message.WParamHi of
      AC_REMOVESKIN: begin
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and (SkinData.SkinIndex >= 0) then begin
          CommonWndProc(Message, FCommonData);
          CheckUpDown;
          UpdateBtnData;
          AlphaBroadcast(Self, Message);
          if HandleAllocated and Showing and not (csLoading in ComponentState) and not (csDestroying in ComponentState) then
            RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
        end
        else
          AlphaBroadcast(Self, Message);

        Exit;
      end;

      AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          if (Message.LParam = LPARAM(SkinData.SkinManager)) then begin
            KillTimers;
            CommonWndProc(Message, FCommonData);
            UpdateBtnData;
            if HandleAllocated and Showing and not (csLoading in ComponentState) then
              RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);

            AddToAdapter(ActivePage);
            CheckUpDown;
            if (SpinWnd <> nil) then
              SendMessage(SpinWnd.CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          end;
          AlphaBroadcast(Self, Message);
          Exit;
        end;

      AC_SETNEWSKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          AlphaBroadcast(Self, Message);
          if (Message.LParam = LPARAM(SkinData.SkinManager)) then
            CommonWndProc(Message, FCommonData);

          UpdateBtnData;
          if not (csLoading in ComponentState) and not aSkinChanging and HandleAllocated then
            Perform(WM_SIZE, 0, 0);

          FTabsLineIndex := SkinData.SkinManager.GetSkinIndex(FTabsLineSkin);
          Exit;
        end;

      AC_PREPARECACHE: begin
        if not InUpdating(SkinData) then
          PrepareCache;

        Exit;
      end;

      AC_GETOUTRGN: begin
        PRect(Message.LParam)^ := PageRect;
        OffsetRect(PRect(Message.LParam)^, Left, Top);
        Exit;
      end;

      AC_ENDPARENTUPDATE: begin
        if FCommonData.FUpdating then
          if not GetBoolMsg(Parent, AC_PREPARING) and not InUpdating(SkinData, True) then
            RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_UPDATENOW)
          else begin
            FCommonData.FUpdating := True;
            SetParentUpdated(Self);
          end
        else
          if (SkinData.CtrlSkinState and ACS_FAST = ACS_FAST) and Assigned(ActivePage) then
            SetParentUpdated(ActivePage);

        Exit;
      end;

      AC_ENDUPDATE:
        if not FCommonData.FUpdating then begin
          RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_UPDATENOW or RDW_ERASE or RDW_FRAME);
          SetParentUpdated(Self);
        end;

      AC_MOUSELEAVE: begin
        Perform(WM_MOUSELEAVE, 0, 0);
        Exit;
      end;

      AC_GETBG: begin
        CommonMessage(Message, FCommonData);
        PacBGInfo(Message.LParam).FillRect := MkRect;
        Exit;
      end;

      AC_GETSKINSTATE: begin
        if Message.LParam = 1 then begin
          if (Parent <> nil) and Parent.HandleAllocated then begin
            UpdateSkinState(FCommonData, False); // Copy Skin state from Parent
            if ActivePage <> nil then
              for i := 0 to ActivePage.ControlCount - 1 do
                ActivePage.Controls[i].Perform(SM_ALPHACMD, MakeWParam(0, AC_GETSKINSTATE), 1);
//                SendAMessage(ActivePage.Controls[i], AC_GETSKINSTATE, 1);
          end;
        end
        else
          Message.Result := FCommonData.CtrlSkinState;

        Exit;
      end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.GetSkinIndex(s_PageControl + sTabPositions[TabPosition]) + 1;

        Exit;
      end

      else
        if CommonMessage(Message, FCommonData) then
          Exit;
    end
  else
    if (FCommonData <> nil) and FCommonData.Skinned(True) then
      case Message.Msg of
        4871:
          FCommonData.BGChanged := True; // Items were added

        WM_KILLFOCUS, WM_SETFOCUS:
          if not (csDesigning in ComponentState) then begin
            FCommonData.BGChanged := True;
            inherited;
            if (ActivePage <> nil) and not InUpdating(FCommonData) then
              RepaintTab(ActivePage.PageIndex, False);

            Exit;
          end

        else
          Exit;
      end;

  if Assigned(FCommonData) and FCommonData.Skinned then begin
    if CommonWndProc(Message, FCommonData) then
      Exit;

    case Message.Msg of
      WM_PRINT: begin
        CheckUpDown;
        SkinData.Updating := False;
        AcPaint(TWMPaint(Message));
        if (SpinWnd <> nil) and IsWindowVisible(SpinWnd.CtrlHandle) then begin
          SavedDC := SaveDC(TWMPaint(Message).DC);
          try
            MoveWindowOrg(TWMPaint(Message).DC, SpinWnd.WndPos.X, SpinWnd.WndPos.Y);
            SendMessage(SpinWnd.CtrlHandle, WM_PAINT, Message.WParam, Message.LParam);
          finally
            RestoreDC(TWMPaint(Message).DC, SavedDC);
          end;
        end;
        Exit;
      end;

      WM_NCPAINT: begin
        if InAnimationProcess or (DroppedDownItem <> -1) then
          Exit;

        if ActivePage <> nil then begin
          if InUpdating(FCommonData) then
            Exit;

          DC := GetDC(Handle);
          SavedDC := SaveDC(DC);
          try
            if FCommonData.BGChanged then
              PrepareCache;

            if (ActivePage <> nil) then begin
              R := ActivePage.BoundsRect;
              ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
            end;
            CopyWinControlCache(Self, FCommonData, MkRect, MkRect(Self), DC, True);
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(Handle, DC);
          end;
        end;
        if (SpinWnd <> nil) and not FCommonData.BGChanged then
          RedrawWindow(SpinWnd.CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);

        Message.Result := 0;
      end;

      WM_ERASEBKGND: begin
        if not (InAnimationProcess or (SkinData.CtrlSkinState and ACS_FAST <> ACS_FAST)) and not InAnimationProcess then
          AcPaint(TWMPaint(Message));

        Message.Result := 1;
        Exit
      end;

      WM_STYLECHANGED, WM_STYLECHANGING:
        if not (csLoading in ComponentState) then begin
          KillTimers;
          FCommonData.BGChanged := True;
        end;

      WM_HSCROLL:
        if not (csLoading in ComponentState) then begin
          KillTimers;
          FCommonData.BGChanged := True;
          inherited;
          RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME);
          Exit;
        end;

      WM_PARENTNOTIFY:
        if not ((csDesigning in ComponentState) or (csLoading in ComponentState)) and (Message.WParamLo in [WM_CREATE, WM_DESTROY]) then begin
          i := PageCount;
          inherited;
          if (Message.WParamLo = WM_CREATE) then
            if (srThirdParty in SkinData.SkinManager.SkinningRules) and (i <> PageCount) then
              AddToAdapter(Self);

          CheckUpDown;
          Exit;
        end;

      CM_CONTROLLISTCHANGE: begin
        i := PageCount;
        inherited;
        if i <> PageCount then begin
          CheckUpDown;
          if (srThirdParty in SkinData.SkinManager.SkinningRules) then
            AddToAdapter(Self);
        end;
        Exit;
      end;
    end;
  end;
  inherited;
  case Message.Msg of
    WM_STYLECHANGED:
      if not (csLoading in ComponentState) then begin
        FCommonData.UpdateIndexes;
        if FCommonData.Skinned then begin
          UpdateBtnData;
          CheckUpDown;
        end;
      end;

    CM_DIALOGCHAR:
      if FCommonData.Skinned then begin
        FCommonData.BGChanged := True;
        RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME);
        SetParentUpdated(Self);
      end;

    TCM_DELETEITEM:
      if FCommonData.Skinned and not SkinData.FUpdating then
        SkinData.BGChanged := True;

    WM_LBUTTONDBLCLK:
      if BetWeen(CurItem, 0, PageCount - 1) and ((Style <> tsTabs) or (TsTabSheet(Pages[CurItem]).TabType = ttButton)) then
        RepaintTab(CurItem, False); // If button is dblclicked

    WM_CREATE:
      if HandleAllocated then begin
        UpdateBtnData;
        Perform(WM_SIZE, 0, 0); // Update tab sizes after creation or style changing
        CheckUpDown;
      end;

    CM_ENABLEDCHANGED:
      if not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
        SkinData.Invalidate;
  end;
end;


procedure TsPageControl.CloseClick(Sender: TObject);
var
  i: integer;
  ToClose: boolean;
  Act: TacCloseAction;
begin
  ToClose := True;
  Act := acaFree;
  if Assigned(OnCloseBtnClick) then
    OnCloseBtnClick(Self, TsTabBtn(Sender).Page.TabIndex, ToClose, Act);

  if ToClose then begin
    i := ActivePageIndex;
    if Act = acaFree then
      FreeAndNil(TsTabBtn(Sender).Page)
    else
      TsTabBtn(Sender).Page.TabVisible := False;

    if (i < PageCount) and (i <> 0) then
      ActivePageIndex := i;

    TsTabBtn(Sender).Visible := False;
    RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW);
  end;
end;


procedure TsPageControl.PaintButton(DC: hdc; TabRect: TRect; State: integer);
const
  sx = 'X';
var
  TmpBmp: TBitmap;
begin
  if BtnIndex >= 0 then begin
    TmpBmp := CreateBmp32(BtnWidth, BtnHeight);
    BitBlt(TmpBmp.Canvas.Handle, 0, 0, BtnWidth, BtnHeight, DC, TabRect.Left, TabRect.Top, SRCCOPY);
    if CloseBtnSkin = '' then
      DrawSkinGlyph(TmpBmp, Point(BtnWidth - WidthOfImage(FCommonData.SkinManager.ma[BtnIndex]), 0), State, 1, FCommonData.SkinManager.ma[BtnIndex], MakeCacheInfo(TmpBmp))
    else begin
      PaintItem(BtnIndex, MakeCacheInfo(TmpBmp), True, State, MkRect(TmpBmp), MkPoint, TmpBmp, SkinData.SkinManager);
      SelectObject(TmpBmp.Canvas.Handle, CreatePen(PS_SOLID, 2, clRed));
      MoveToEx(TmpBmp.Canvas.Handle, 4, 4, nil);
      LineTo(TmpBmp.Canvas.Handle, TmpBmp.Width - 5, TmpBmp.Height - 5);
      MoveToEx(TmpBmp.Canvas.Handle, 4, TmpBmp.Height - 5, nil);
      LineTo(TmpBmp.Canvas.Handle, TmpBmp.Width - 5, 4);
    end;
    BitBlt(DC, TabRect.Left, TabRect.Top, BtnWidth, BtnHeight, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(TmpBmp);
  end;
end;


var
  bUpdating: boolean = False;

procedure TsPageControl.UpdateBtnData;
begin
  BtnWidth := iBtnSize;
  BtnHeight := iBtnSize;
  if FCommonData.Skinned then
    with FCommonData.SkinManager do
      if CloseBtnSkin <> '' then
        BtnIndex := GetSkinIndex(CloseBtnSkin)
      else begin
        BtnIndex := GetMaskIndex(ConstData.IndexGlobalInfo, s_SmallIconClose);
        if BtnIndex < 0 then
          BtnIndex := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconClose);

        if BtnIndex > -1 then begin
          BtnWidth := max(WidthOfImage(ma[BtnIndex]), 8);
          BtnHeight := HeightOfImage(ma[BtnIndex]);
        end;
      end;

  if not bUpdating then begin
    bUpdating := True;
    SetPadding(FShowCloseBtns);
    bUpdating := False;
  end;
end;


procedure TsPageControl.SetCloseBtnSkin(const Value: TsSkinSection);
begin
  if FCloseBtnSkin <> Value then begin
    FCloseBtnSkin := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsPageControl.SetShowUpDown(const Value: boolean);
var
  Wnd: THandle;
begin
  FShowUpDown := Value;
  if not FShowUpDown then begin
    if (SpinWnd <> nil) then begin
      Wnd := SpinWnd.CtrlHandle;
      FreeAndNil(SpinWnd);
    end
    else
      Wnd := FindWindowEx(Handle, 0, UPDOWN_CLASS, nil);

    if Wnd <> 0 then
      DestroyWindow(Wnd);
  end
  else
    if not (csLoading in ComponentState) then
      RecreateWnd;
end;


procedure TsPageControl.SetPadding(Value: boolean);
const
  OffsArray: array [boolean, boolean] of integer = ((7, 4), (6, 4));
var
  i, TabsCovering: integer;
begin
  if HandleAllocated then begin
    if FCommonData.Skinned then
      TabsCovering := FCommonData.SkinManager.CommonSkinData.TabsCovering
    else
      TabsCovering := 0;

    i := OffsArray[Value, Images = nil];
    if Value then
      SendMessage(Handle, TCM_SETPADDING, 0, MakeLParam(BtnWidth div 2 + i + FTabPadding + TabsCovering, 3))
    else
      SendMessage(Handle, TCM_SETPADDING, 0, MakeLParam(i + FTabPadding + TabsCovering, 3));
  end;
end;


function TsPageControl.BtnOffset(TabHeight: integer; Active: boolean): integer;
begin
  Result := (TabHeight - iBtnSize - 1) div 2 - 2
end;


function TsPageControl.IsSpecialTab(i: integer; IsMenu: boolean = False): boolean;
begin
  Result := Pages[i].TabVisible and (TsTabSheet(Pages[i]).TabType <> ttTab);
  if Result and IsMenu then
    Result := TsTabSheet(Pages[i]).TabType = ttMenu;
end;


procedure TsPageControl.KillTimers;
var
  i: integer;
begin
  for i := 0 to PageCount - 1 do
    with TsTabSheet(Pages[i]) do
      if AnimTimer <> nil then
        FreeAndNil(AnimTimer);
end;


function TsPageControl.CheckActiveTab(PageIndex: integer): TTabSheet;
var
  i: integer;
begin
  if IsSpecialTab(PageIndex) or not Pages[PageIndex].TabVisible then begin
    for i := PageIndex to PageCount - 1 do
      if not IsSpecialTab(i) then begin
        Result := Pages[i];
        Exit;
      end;

    for i := PageIndex downto 0 do
      if not IsSpecialTab(i) then begin
        Result := Pages[i];
        Exit;
      end;
  end;
  Result := Pages[PageIndex];
end;


{$IFDEF DELPHI7UP}
procedure TsPageControl.SetTabIndex(Value: Integer);
var
  PageIndex: integer;
begin
  if BetWeen(Value, 0, PageCount - 1) then begin
    PageIndex := PageIndexFromTabIndex(Value);
    if BetWeen(PageIndex, 0, PageCount - 1) then
      if (TsTabSheet(Pages[PageIndex]).TabType = ttTab) then begin
        inherited;
        AddToAdapter(ActivePage);
      end;
  end
  else
    inherited;
end;
{$ENDIF}


procedure TsPageControl.StdPaint(var Message: TWMPaint);
var
  R: TRect;
  DC, SavedDC: hdc;
  Bmp: TBitmap;
{$IFDEF DELPHI7UP}
  Page: TThemedTab;
  Details: TThemedElementDetails;
{$ENDIF}
begin
  if not (csDestroying in Parent.ComponentState) and not (csLoading in ComponentState) then begin
    Bmp := CreateBmp32(Self);
    DC := Bmp.Canvas.Handle;
    Canvas.Handle := DC;
    Canvas.Lock;
    Bmp.Canvas.Lock;
    R := MkRect(Width, Height);
    try
      if Style = tsTabs then begin
{$IFDEF DELPHI7UP}
        if acThemesEnabled then begin
          // Transparent part drawing
          R := MkRect(Width, Height);
          Page := ttBody;
          Details := acThemeServices.GetElementDetails(Page);
          acThemeServices.DrawParentBackground(Handle, DC, @Details, True);
          acThemeServices.DrawElement(DC, Details, R);
          // Page painting
          R := PageRect;
          Page := ttPane;
          Details := acThemeServices.GetElementDetails(Page);
          acThemeServices.DrawParentBackground(Handle, DC, @Details, False);
          acThemeServices.DrawElement(DC, Details, R);
        end
        else
{$ENDIF}
        begin
          R := PageRect;
          FillDC(DC, ClientRect, ColorToRGB(Color));
          DrawEdge(DC, R, EDGE_RAISED, BF_RECT);
        end;
      end
      else
{IFDEF DELPHI7UP
        if acThemesEnabled then begin
          Page := ttBody;
          Details := acThemeServices.GetElementDetails(Page);
          acThemeServices.DrawParentBackground(Handle, DC, @Details, False);
        end
        else
ENDIF}
          FillDC(DC, R, Color);

      DrawStdTabs(DC);
    finally
      Canvas.UnLock;
    end;
    StoredVisiblePageCount := VisibleTabsCount;

    if (Message.DC <> 0) then begin
      SavedDC := 0;
      DC := Message.DC;
    end
    else begin
      DC := GetDC(Handle);
      SavedDC := SaveDC(DC);
    end;

    try
      BitBlt(DC, 0, 0, Width, Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      if DC <> Message.DC then begin
        RestoreDC(DC, SavedDC);
        ReleaseDC(Handle, DC);
      end;
    end;
    Bmp.Canvas.UnLock;
    Bmp.Free;
    Message.Result := 1;
  end;
end;


procedure DrawCloseBtn(DC: hdc; R: TRect; State: integer);
{$IFDEF DELPHI7UP}
var
  tw: TThemedWindow;
  Details: TThemedElementDetails;
{$ENDIF}
begin
{$IFDEF DELPHI7UP}
  if acThemesEnabled then begin
    case State of
      0:   tw := twSmallCloseButtonNormal;
      1:   tw := twSmallCloseButtonHot;
      else tw := twSmallCloseButtonPushed;
    end;
    Details := acThemeServices.GetElementDetails(tw);
    acThemeServices.DrawElement(DC, Details, R);
  end
  else
{$ENDIF}
  begin
    FillDC(DC, R, clWhite);
    InflateRect(R, -1, -1);
    case State of
      0: FillDC(DC, R, $005858AB);
      1: FillDC(DC, R, clRed);
      2: FillDC(DC, R, clMaroon);
    end;
    SelectObject(DC, CreatePen(PS_SOLID, 2, clWhite));
    MoveToEx(DC, R.Left  + 3, R.Top    + 3, nil);
    LineTo  (DC, R.Right - 4, R.Bottom - 4);
    MoveToEx(DC, R.Left  + 3, R.Bottom - 4, nil);
    LineTo  (DC, R.Right - 4, R.Top    + 3);
  end;
end;


procedure TsPageControl.DrawStdTab(PageIndex, State: integer; DC: hdc);
const
  AntiPosArray: array [TTabPosition] of integer = (BF_BOTTOM, BF_TOP, BF_RIGHT, BF_LEFT);
  Spacing = 3;
  FixOffset = 6;
var
{$IFDEF DELPHI7UP}
  Details: TThemedElementDetails;
  Tab: TThemedTab;
  ToolBtn: TThemedToolBar;
  Btn: TThemedButton;
{$ENDIF}
  SavedDC: hdc;
  OldFont: hFont;
  aRect, R, rTmp: TRect;
  Page: TsTabSheet;
  TempBmp: TBitmap;
  lCaption: ACString;
  Flags: Cardinal;
  bTabMenu: boolean;
  dContent: TacTabData;
begin
  if (PageIndex >= 0) then begin
    bTabMenu := IsSpecialTab(PageIndex);
    Page := TsTabSheet(Pages[PageIndex]);
    R := TabRect(Pages[PageIndex].TabIndex);
    if (State <> 0) and (R.Left < 0) then
      Exit;

    if bTabMenu then
      if TabPosition in [tpTop, tpBottom] then
        InflateRect(R, -3, -1)
      else
        InflateRect(R, -1, -3)
    else
      if (State = 2) and not bTabMenu and (Style = tsTabs) then
        InflateRect(R, 2, 2);

    TempBmp := CreateBmp32(R);
    TempBmp.Canvas.Font.Assign(Font);// := Font;
    SelectObject(TempBmp.Canvas.Handle, TempBmp.Canvas.Font.Handle);
    if ActiveIsBold and (Page = ActivePage) then
      TempBmp.Canvas.Font.Style := TempBmp.Canvas.Font.Style + [fsBold];

    TempBmp.Canvas.Brush.Style := bsClear;
    aRect := MkRect(TempBmp);
    if not Page.TabVisible then
      Exit;
  {$IFDEF DELPHI7UP}
    if acThemesEnabled then begin
      // Tabs drawing
      if bTabMenu then begin
        if State = 0 then
          BitBlt(TempBmp.Canvas.Handle, 0, 0, TempBmp.Width, TempBmp.Height, DC, R.Left, R.Top, SRCCOPY) { Copy background }
        else
          FillDC(TempBmp.Canvas.Handle, MkRect(TempBmp), Color);

        if Page.TabType = ttMenu then begin
          case State of
            0:
              TempBmp.Canvas.Font.Color := clMenuText;

            1, 2: begin
              FillDC(TempBmp.Canvas.Handle, Rect(1, 1, TempBmp.Width - 1, TempBmp.Height - 1), clMenuHighlight);
              TempBmp.Canvas.Font.Color := clHighlightText;
            end;
          end;
          Details.Part := -1;
        end
        else begin
          case State of
            0:   ToolBtn := ttbButtonNormal;
            1:   ToolBtn := ttbButtonHot;
            else ToolBtn := ttbButtonPressed;
          end;
          Details := acThemeServices.GetElementDetails(ToolBtn);
        end;
      end
      else
        case Style of
          tsTabs: begin
            if (TabPosition <> tpTop) then // Others tabs are not supported by API
              case State of
                0: begin
                  ToolBtn := ttbButtonPressed;
                  Details := acThemeServices.GetElementDetails(ToolBtn);
                end;
                1: begin
                  ToolBtn := ttbButtonHot;
                  Details := acThemeServices.GetElementDetails(ToolBtn);
                end;
                2: begin
                  Tab := ttPane;
                  Details := acThemeServices.GetElementDetails(Tab);
                end;
              end
            else begin // Draw buttons with a special offset (tabs emulation)
              case State of
                0:   Tab := ttTabItemNormal;
                1:   Tab := ttTabItemHot;
                else Tab := ttTabItemSelected;
              end;
              Details := acThemeServices.GetElementDetails(Tab);
            end;
            case TabPosition of
              tpTop:    acThemeServices.DrawElement(TempBmp.Canvas.Handle, Details, aRect); // Draw tab
              tpBottom: acThemeServices.DrawElement(TempBmp.Canvas.Handle, Details, Rect(0, -FixOffset, TempBmp.Width, TempBmp.Height)); // Draw button
              tpLeft:   acThemeServices.DrawElement(TempBmp.Canvas.Handle, Details,  MkRect(TempBmp.Width + FixOffset, TempBmp.Height)); // Draw button
              tpRight:  acThemeServices.DrawElement(TempBmp.Canvas.Handle, Details, Rect(-FixOffset, 0, TempBmp.Width, TempBmp.Height)); // Draw button
            end;
            Details.Part := -1;
          end;

          tsButtons: begin
            case State of
              0:   Btn := tbPushButtonNormal;
              1:   Btn := tbPushButtonHot
              else Btn := tbPushButtonPressed;
            end;
            Details := acThemeServices.GetElementDetails(Btn);
          end

          else begin
            if R.Left > 6 then begin // Draw a separator
              rTmp := Rect(R.Left - 6, R.Top, R.Left, R.Bottom);
              DrawEdge(DC, rTmp, EDGE_ETCHED, BF_LEFT);
            end;
            case State of
              0: begin
                FillDC(TempBmp.Canvas.Handle, MkRect(TempBmp), Color); { Fill background }
                ToolBtn := ttbButtonNormal;
              end;

              1: begin
                FillDC(TempBmp.Canvas.Handle, MkRect(TempBmp), Color); { Fill background }
                ToolBtn := ttbButtonHot;
              end

              else
                ToolBtn := ttbButtonPressed;
            end;
            Details := acThemeServices.GetElementDetails(ToolBtn);
          end;
        end;

      if Details.Part <> -1 then
        acThemeServices.DrawElement(TempBmp.Canvas.Handle, Details, aRect); // Draw tab
    end
    else
  {$ENDIF}
    begin // Draw without themes (very od style)
      FillDC(TempBmp.Canvas.Handle, aRect, Color);
      if bTabMenu then
        if Page.TabType = ttMenu then
          case State of
            1, 2: begin
              FillDC(TempBmp.Canvas.Handle, Rect(1, 1, TempBmp.Width - 1, TempBmp.Height - 1), {$IFDEF DELPHI7UP}clMenuHighlight{$ELSE}clHighlight{$ENDIF});
              TempBmp.Canvas.Font.Color := clHighlightText;
            end;
          end
        else
          case State of
            1: Frame3D(TempBmp.Canvas, aRect, ColorToRGB(clWhite),     ColorToRGB(clBtnShadow), 1);
            2: Frame3D(TempBmp.Canvas, aRect, ColorToRGB(clBtnShadow), ColorToRGB(clWhite),     1);
          end
      else
        case Style of
          tsTabs:
            DrawEdge(TempBmp.Canvas.Handle, aRect, EDGE_RAISED, BF_RECT and not AntiPosArray[TabPosition]);

          tsButtons:
            case State of
              0, 1: DrawEdge(TempBmp.Canvas.Handle, aRect, EDGE_RAISED, BF_RECT);
              2:    DrawEdge(TempBmp.Canvas.Handle, aRect, EDGE_SUNKEN, BF_RECT);
            end;

          else begin
            if R.Left > 6 then begin // Draw a separator
              rTmp := Rect(R.Left - 6, R.Top, R.Left, R.Bottom);
              DrawEdge(DC, rTmp, EDGE_ETCHED, BF_LEFT);
            end;
            case State of
              1:
                Frame3D(TempBmp.Canvas, aRect, ColorToRGB(clWhite), ColorToRGB(clBtnShadow), 1);

              2: begin
                FillDC(TempBmp.Canvas.Handle, aRect, ColorToRGB(cl3DLight));
                DrawEdge(TempBmp.Canvas.Handle, aRect, EDGE_SUNKEN, BF_RECT);
              end;
            end;
          end;
        end;
    end;
    if not OwnerDraw then begin
      // Drawing of tab content
      Flags := DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS;
      if UseRightToLeftReading then
        Flags := Flags or DT_RTLREADING or DT_NOCLIP;
{$IFDEF TNTUNICODE}
      if Page is TTntTabSheet then
        lCaption := TTntTabSheet(Page).Caption
      else
{$ENDIF}
        lCaption := Page.Caption;

      OldFont := 0;
      if (TabPosition in [tpLeft, tpRight]) and not RotateCaptions or (TabPosition in [tpTop, tpBottom]) and RotateCaptions then // If vertical text
        OldFont := MakeAngledFont(TempBmp.Canvas.Handle, TempBmp.Canvas.Font, -2700); // Rotated font initialization
      // Get coordinates for tab content
      InitTabContentData(TempBmp.Canvas, Page, aRect, State, bTabMenu, dContent);
      // Draw glyph if rect is not empty
      if not IsRectEmpty(dContent.GlyphRect) then
        Images.Draw(TempBmp.Canvas, dContent.GlyphRect.Left, dContent.GlyphRect.Top, Page.ImageIndex, Page.Enabled and Enabled);
      // Write Text
      if Page.SkinData <> nil then
        if OldFont <> 0 then  // If font is rotated
          SetTextColor(TempBmp.Canvas.Handle, ColorToRGB(iff(Page.SkinData.CustomFont, Page.Font.Color, clBtnText)))
        else
          TempBmp.Canvas.Font.Color := ColorToRGB(iff(Page.SkinData.CustomFont, Page.Font.Color, clBtnText));

      if not Page.Enabled or not Enabled then
        TempBmp.Canvas.Font.Color := MixColors(TempBmp.Canvas.Font.Color, ColorToRGB(clBtnFace), sDefaults.DefDisabledBlend);

      TempBmp.Canvas.Brush.Style := bsClear;
      if OldFont <> 0 then begin // If font is rotated
        lCaption := CutText(TempBmp.Canvas, lCaption, HeightOf(dContent.TextRect));
        acTextRect(TempBmp.Canvas, dContent.TextRect, dContent.TextPos.X, dContent.TextPos.Y, lCaption);
        SelectObject(TempBmp.Canvas.Handle, OldFont); // Returning prev. font
      end
      else
        acWriteText(TempBmp.Canvas, PacChar(lCaption), True, dContent.TextRect, Flags);
//        WriteText32(TempBmp, PacChar(lCaption), True, dContent.TextRect, Flags, -1, True, SkinData.SkinManager);
      // Paint focus rect
      if not IsRectEmpty(dContent.FocusRect) then begin
        TempBmp.Canvas.Pen.Color := clWindowFrame;
        TempBmp.Canvas.Brush.Color := clBtnFace;
        TempBmp.Canvas.DrawFocusRect(dContent.FocusRect);
      end;
      // Paint Close btn
      if not IsRectEmpty(dContent.BtnRect) then
        DrawCloseBtn(TempBmp.Canvas.Handle, dContent.BtnRect, integer(FHoveredBtnIndex = PageIndex) + integer(FPressedBtnIndex = PageIndex));
      // Draw Arrow
      if not IsRectEmpty(dContent.ArrowRect) then
        DrawColorArrow(TempBmp.Canvas, TempBmp.Canvas.Font.Color, dContent.ArrowRect, dContent.ArrowDirection);
    end
    else
      if Assigned(OnDrawTab) then begin
        Canvas.Handle := TempBmp.Canvas.Handle;
        SavedDC := SaveDC(Canvas.Handle);
        Canvas.Lock;
        MoveWindowOrg(Canvas.Handle, -R.Left, -R.Top);
        OnDrawTab(Self, Page.TabIndex, R, State <> 0);
        Canvas.UnLock;
        RestoreDC(Canvas.Handle, SavedDC);
        BitBlt(DC, R.Left, R.Top, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
      end;

    BitBlt(DC, R.Left, R.Top, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY); // Copy Tab to DC
    TempBmp.Free;
  end;
end;


procedure TsPageControl.DrawStdTabs(DC: hdc);
var
  i: integer;
begin
  for i := 0 to PageCount - 1 do
    if Pages[i].TabVisible and (Pages[i] <> ActivePage) then
      if DroppedDownItem = i then
        DrawStdTab(i, 2, DC)
      else
        DrawStdTab(i, integer(CurItem = i), DC);

  // Draw active tab
  if (Tabs.Count > 0) and (ActivePage <> nil) and (ActivePage.TabType = ttTab) then
    DrawStdTab(ActivePage.PageIndex, 2, DC);
end;


const
  ArrowSize = 9;

procedure TsPageControl.InitTabContentData(Canvas: TCanvas; Page: TTabSheet; TabRect: TRect; State: integer; IsTabMenu: boolean; var Data: TacTabData);
var
  IsVertical, ArrowUnderText: boolean;
  lCaption: ACString;
  R: TRect;
begin
{$IFDEF TNTUNICODE}
  if Page is TTntTabSheet then
    lCaption := TTntTabSheet(Page).Caption
  else
{$ENDIF}
    lCaption := Page.Caption; // Text size received

  FillChar(R, SizeOf(TRect), 0);
  acDrawText(Canvas.Handle, lCaption, R, DT_CALCRECT);
  Data.TextSize := MkSize(R);
  if RotateCaptions then
    IsVertical := TabPosition in [tpTop, tpBottom]
  else
    IsVertical := TabPosition in [tpLeft, tpRight];

  if not IsVertical then begin
    // Correcting of tab rect
    if TabPosition = tpTop then
      dec(TabRect.Bottom, 2)
    else
      inc(TabRect.Top, 2);

    if not IsTabMenu then
      if Style = tsTabs then
        if TabPosition = tpTop then begin
          inc(TabRect.Top, 2);
          if (State = 2) and FActiveTabEnlarged then
            OffsetRect(TabRect, -1, -2)
          else
            OffsetRect(TabRect, 0, 1);
        end
        else
          if (State = 2) and FActiveTabEnlarged then
            OffsetRect(TabRect, -1, -2)
          else
            OffsetRect(TabRect, 0, -2)
      else
        OffsetRect(TabRect, 0, 1);

    Data.TextRect := TabRect;
    // Arrow rect
    if IsTabMenu and (TsTabSheet(Page).TabType = ttMenu) then begin
      ArrowUnderText := False;
      if TabPosition in [tpTop, tpBottom] then // Can arrow be placed under text?
        if HeightOf(TabRect) - Data.TextSize.cy - 6 > ArrowSize then
          ArrowUnderText := True;

      Data.ArrowDirection := asBottom;
      if not ArrowUnderText then begin
        Data.ArrowRect.Left   := Data.TextRect.Right - ArrowSize - 4;
        Data.ArrowRect.Top    := Data.TextRect.Top   + (HeightOf(Data.TextRect) - ArrowSize) div 2 + 1;
        Data.ArrowRect.Right  := Data.ArrowRect.Left + ArrowSize;
        Data.ArrowRect.Bottom := Data.ArrowRect.Top  + ArrowSize;
        if (State = 2) and FActiveTabEnlarged then
          if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
            OffsetRect(Data.ArrowRect, 1, 1);
      end;
    end
    else begin
      Data.ArrowRect := MkRect;
      ArrowUnderText := False;
    end;
    // Close btn rect
    if FShowCloseBtns and not IsTabMenu and TsTabSheet(Page).UseCloseBtn then begin
      Data.BtnRect.Left   := TabRect.Right    - BtnWidth - BtnOffsX;
      Data.BtnRect.Top    := TabRect.Top      + (HeightOf(TabRect) - BtnHeight) div 2;
      Data.BtnRect.Right  := TabRect.Right    - BtnOffsX;
      Data.BtnRect.Bottom := Data.BtnRect.Top + BtnHeight;
      Data.TextRect.Right := Data.BtnRect.Left;
      inc(Data.TextRect.Left, TabPadding);
      if (State = 2) and FActiveTabEnlarged then begin
        OffsetRect(TabRect, 3, 0);
        if TabPosition = tpTop then
          OffsetRect(Data.BtnRect, 1, 1)
        else
          OffsetRect(Data.BtnRect, 0, 2);
      end;
    end
    else
      Data.BtnRect := MkRect;
    // Image rect
    if (Images <> nil) and (Page.ImageIndex > -1) and (Page.ImageIndex <= GetImageCount(Images) - 1) then begin
      if not IsRectEmpty(Data.BtnRect) or (TabAlignment = taLeftJustify) then // If button exists or left aligned
        Data.GlyphRect.Left := TabRect.Left + TabMargin // then content aligned to the left
      else // Glyph with text are aligned to center
        if (TabAlignment = taRightJustify) then
          Data.GlyphRect.Left := TabRect.Right - Data.TextSize.cx - Images.Width - TabSpacing - TabMargin
        else
          Data.GlyphRect.Left := max(Data.TextRect.Left + (WidthOf(Data.TextRect) - (Data.TextSize.cx + Images.Width + TabSpacing)) div 2, TabRect.Left + TabMargin);

      Data.GlyphRect.Top := TabRect.Top + (HeightOf(TabRect) - Images.Height) div 2;
      Data.GlyphRect.Right := Data.GlyphRect.Left + Images.Width;
      Data.GlyphRect.Bottom := Data.GlyphRect.Top + Images.Height;
      Data.TextRect.Left := Data.GlyphRect.Right + TabSpacing; // Change text rect
      if (State = 2) and FActiveTabEnlarged then
        if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(Data.GlyphRect, 1, integer(Style = tsTabs))
    end
    else begin
      Data.GlyphRect := MkRect;
      if (TabAlignment = taLeftJustify) or
           (Data.BtnRect.Left <> Data.BtnRect.Right) or
             (Data.ArrowRect.Left <> Data.ArrowRect.Right) or
               (ShowCloseBtns and (TsTabSheet(Page).TabType = ttTab)) then // If button or arrow exists or left aligned
        Data.TextRect.Left := TabRect.Left + TabMargin + TabPadding
      else
        if (TabAlignment = taRightJustify) then
          Data.TextRect.Left := TabRect.Right - Data.TextSize.cx - TabMargin
        else
          Data.TextRect.Left := TabRect.Left + (WidthOf(TabRect) - Data.TextSize.cx) div 2;

    end;
    Data.TextRect.Right := min(Data.TextRect.Left + Data.TextSize.cx + 2, Data.TextRect.Right - integer(Data.ArrowRect.Left = Data.BtnRect.Right) * 3); //
    Data.TextRect.Top := Data.TextRect.Top + (HeightOf(Data.TextRect) - Data.TextSize.cy) div 2;
    Data.TextRect.Bottom := Data.TextRect.Top + Data.TextSize.cy;
    if ArrowUnderText then begin
      if TabPosition in [tpTop, tpBottom] then begin
        OffsetRect(Data.TextRect, 0, -4);
        Data.ArrowRect.Left   := Data.TextRect.Left + (WidthOf(Data.TextRect) - ArrowSize) div 2;
        Data.ArrowRect.Top    := Data.TextRect.Bottom;
        Data.ArrowRect.Right  := Data.ArrowRect.Left + ArrowSize;
        Data.ArrowRect.Bottom := Data.ArrowRect.Top + ArrowSize;
      end;
      if (State = 2) and FActiveTabEnlarged then
        if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(Data.ArrowRect, 1, 1);
    end;
    // Focus rect
    if FShowFocus and (Focused or FCommonData.FFocused) and (State = 2) and FActiveTabEnlarged and (Page.Caption <> '') and not IsTabMenu then begin
      Data.FocusRect := Data.TextRect;
      InflateRect(Data.FocusRect, 3, 0);
      inc(Data.FocusRect.Bottom, 3);
    end
    else
      Data.FocusRect := MkRect;

    if (State = 2) and FActiveTabEnlarged then
      if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
        OffsetRect(Data.TextRect, 1, 1);

    Data.TextPos.X := Data.TextRect.Left;
    Data.TextPos.Y := Data.TextRect.Top;
  end
  else begin
    if IsTabMenu then begin
      if (State = 2) then
        if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(TabRect, 1, 1);
    end
    else
      if (State = 2) and FActiveTabEnlarged then
        if not SkinData.Skinned or (SkinData.SkinManager <> nil) and SkinData.SkinManager.ButtonsOptions.ShiftContentOnClick then
          OffsetRect(TabRect, -1, -1);

    Data.TextRect := TabRect;
    // Arrow rect
    if IsTabMenu and (TsTabSheet(Page).TabType = ttMenu) then begin
      Data.ArrowRect.Top    := Data.TextRect.Top + 8;
      Data.ArrowRect.Left   := Data.TextRect.Left + (WidthOf(Data.TextRect) - ArrowSize) div 2;
      Data.ArrowRect.Right  := Data.ArrowRect.Left + ArrowSize;
      Data.ArrowRect.Bottom := Data.ArrowRect.Top + ArrowSize;
      Data.TextRect.Top := Data.ArrowRect.Bottom + 2;
      Data.ArrowDirection := asRight;
      if (State = 2) then
        if IsVertical then
          OffsetRect(Data.ArrowRect, 0, -1)
        else
          OffsetRect(Data.ArrowRect, 0, 1);
    end
    else
      Data.ArrowRect := MkRect;
    // Close btn rect
    if FShowCloseBtns and not IsTabMenu and TsTabSheet(Page).UseCloseBtn then begin
      Data.BtnRect.Top    := TabRect.Top + BtnOffsX;
      Data.BtnRect.Left   := TabRect.Left + (WidthOf(TabRect) - BtnWidth) div 2;
      Data.BtnRect.Right  := Data.BtnRect.Left + BtnWidth;
      Data.BtnRect.Bottom := Data.BtnRect.Top + BtnHeight;
      Data.TextRect.Top := Data.BtnRect.Bottom + 2;
      if (State = 2) and FActiveTabEnlarged then begin
        OffsetRect(TabRect, 0, -2);
        OffsetRect(Data.BtnRect, 2, 2);
      end;
    end
    else
      Data.BtnRect := MkRect;
    // Image rect
    if (Images <> nil) and (Page.ImageIndex > -1) and (Page.ImageIndex <= GetImageCount(Images) - 1) then begin
      if not IsRectEmpty(Data.BtnRect) then          // If button exists
        Data.GlyphRect.Bottom := TabRect.Bottom - 3 // then content aligned to bottom
      else // Glyph with text are aligned to center
        Data.GlyphRect.Bottom := min(TabRect.Bottom - (HeightOf(TabRect) - (Data.TextSize.cx + Images.Height + TabSpacing)) div 2, TabRect.Bottom - 3);

      Data.GlyphRect.Top := Data.GlyphRect.Bottom - Images.Height;
      Data.GlyphRect.Left := TabRect.Left + (WidthOf(TabRect) - Images.Width) div 2 + 1;
      Data.GlyphRect.Right := Data.GlyphRect.Left + Images.Width;
      if (State = 2) and FActiveTabEnlarged then
        if IsVertical and IsTabMenu then
          OffsetRect(Data.GlyphRect, 3, 0);

      Data.TextRect.Bottom := Data.GlyphRect.Top - TabSpacing; // Change text rect
    end
    else begin
      Data.GlyphRect := MkRect;
      if not IsRectEmpty(Data.BtnRect) then // If button exists
        Data.TextRect.Bottom := TabRect.Bottom - 5
      else
        Data.TextRect.Bottom := TabRect.Bottom - (HeightOf(TabRect) - Data.TextSize.cx) div 2;
    end;
    Data.TextRect.Top := max(Data.TextRect.Bottom - Data.TextSize.cx - 2, Data.TextRect.Top + 3);
    Data.TextRect.Left := Data.TextRect.Left + (WidthOf(Data.TextRect) - Data.TextSize.cy) div 2;
    Data.TextRect.Right := Data.TextRect.Left + Data.TextSize.cy + 2;
    // Focus rect
    if FShowFocus and Focused and (State = 2) and FActiveTabEnlarged and (Page.Caption <> '') and not IsTabMenu then begin
      Data.FocusRect := Data.TextRect;
      InflateRect(Data.FocusRect, 1, 3);
      inc(Data.FocusRect.Right, 2);
    end
    else
      Data.FocusRect := MkRect;

    Data.TextPos.X := Data.TextRect.Left + (WidthOf(Data.TextRect) - Data.TextSize.cy) div 2;
    Data.TextPos.Y := Data.TextRect.Bottom;
  end;
end;


procedure TsPageControl.SetHoveredBtnIndex(const Value: integer);
begin
  FHoveredBtnIndex := Value;
end;


procedure TsPageControl.SetInt(const Index, Value: integer);
begin
  case Index of
    0: if FTabMargin <> Value then begin
      FTabMargin := Value;
      SkinData.Invalidate(True);
    end;

    1: if FTabPadding <> Value then begin
      FTabPadding := Value;
      if not (csLoading in ComponentState) then begin
        UpdateBtnData;
        if HandleAllocated then
          Perform(WM_SIZE, 0, 0);

        FCommonData.Invalidate;
      end;
    end;

    2: if FTabSpacing <> Value then begin
      FTabSpacing := Value;
      SkinData.Invalidate(True);
    end;
  end;
end;


function TsPageControl.GetActivePageIndex: Integer;
begin
  Result := inherited ActivePageIndex;
end;


procedure TsPageControl.SetActivePageIndex(const Value: Integer);
begin
  if BetWeen(Value, 0, PageCount - 1) and (TsTabSheet(Pages[Value]).TabType = ttTab) then begin
    inherited ActivePageIndex := Value;
    if not Pages[Value].TabVisible then
      SetParentUpdated(Pages[Value]); // Update because TCM_SETCURSEL is not received
  end;
end;


procedure TsPageControl.SetBool(const Index: Integer; const Value: boolean);
var
  R: TRect;
begin
  case Index of
    0: if FActiveIsBold <> Value then begin
      FActiveIsBold := Value;
      if not (csLoading in ComponentState) and (Visible or (csDesigning in ComponentState)) then begin
        SkinData.BGChanged := True;
        RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INVALIDATE);
      end;
    end;

    1: if FReflectedGlyphs <> Value then begin
      FReflectedGlyphs := Value;
      SkinData.Invalidate(True);
    end;

    2: if FRotateCaptions <> Value then begin
      FRotateCaptions := Value;
      if not (csLoading in ComponentState) and (Visible or (csDesigning in ComponentState)) then begin
        Perform(WM_SETREDRAW, 0, 0);
        if FRotateCaptions then begin
          if PageCount > 0 then
            R := TabRect(0)
          else
            R := MkRect(24, 24);

          if TabPosition in [tpTop, tpBottom] then begin
            TabWidth := HeightOf(R);
            TabHeight := max(WidthOf(R), 140);
          end
          else begin
            TabWidth := WidthOf(R);
            TabHeight := max(HeightOf(R), 140);
          end;
        end
        else begin
          TabHeight := 0;
          TabWidth := 0;
        end;
        SkinData.BGChanged := True;
        Perform(WM_SETREDRAW, 1, 0);
        RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
      end;
    end;

    3: if FShowCloseBtns <> Value then begin
      FShowCloseBtns := Value;
      UpdateBtnData;
      if HandleAllocated and not(csLoading in ComponentState) then begin
        Perform(WM_SIZE, 0, 0);
        if SkinData.Skinned then
          RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW);
      end;
    end;

    4: if FShowFocus <> Value then begin
      FShowFocus := Value;
      SkinData.Invalidate;
    end;

    5:
      FAllowAnimSwitching := Value;
  end;
end;


function TsPageControl.PageIndexFromTabIndex(TabIndex: Integer): Integer;
var
  i, j: integer;
begin
  Result := -1;
  j := -1;
  for i := 0 to min(TabIndex, PageCount - 1) do begin
    inc(Result);
    if Pages[i].TabVisible then
      inc(j);

    if TabIndex = j then
      Exit;
  end;
end;


procedure TsPageControl.SetCurItem(const Value: integer);
var
  Old: integer;
begin
  if (FCurItem <> Value) then begin
    Old := FCurItem;
    FCurItem := Value;
    if (DroppedDownItem = -1) then begin
      if (BetWeen(Value, 0, PageCount - 1)) then
        if (Pages[Value] <> ActivePage) or ShowCloseBtns then
          RepaintTab(Value); // Repaint new tab

      if (BetWeen(Old, 0, PageCount - 1)) then
        if (Pages[Old] <> ActivePage) or ShowCloseBtns then
          RepaintTab(Old); // Repaint old tab in normal state
    end;
  end;
end;


function TsPageControl.PrepareCache: boolean;
var
  R: TRect;
  i: integer;
  CI: TCacheInfo;
begin
  InitCacheBmp(SkinData);
  Result := True;
//  InitCacheBmp(SkinData);
  CI := GetParentCache(FCommonData);
  R := PageRect;
  PaintItemBG(FCommonData, CI, 0, R, Point(Left + R.Left, Top + r.Top), FCommonData.FCacheBmp);
  with FCommonData.SkinManager.gd[SkinData.SkinIndex], FCommonData.SkinManager do begin
    if IsValidImgIndex(ImgTL) then
      DrawSkinGlyph(FCommonData.FCacheBmp, Point(R.Left, R.Top), 0, 1, ma[ImgTL], MakeCacheInfo(FCommonData.FCacheBmp));

    if IsValidImgIndex(ImgTR) then
      DrawSkinGlyph(FCommonData.FCacheBmp, Point(R.Right - WidthOfImage(ma[ImgTR]), R.Top), 0, 1, ma[ImgTR], MakeCacheInfo(FCommonData.FCacheBmp));

    if IsValidImgIndex(ImgBL) then
      DrawSkinGlyph(FCommonData.FCacheBmp, Point(0, R.Bottom - HeightOfImage(ma[ImgBL])), 0, 1, ma[ImgBL], MakeCacheInfo(FCommonData.FCacheBmp));

    if IsValidImgIndex(ImgBR) then
      DrawSkinGlyph(FCommonData.FCacheBmp, Point(R.Right - WidthOfImage(ma[ImgBR]), R.Bottom - HeightOfImage(ma[ImgBR])), 0, 1, ma[ImgBR], MakeCacheInfo(FCommonData.FCacheBmp));
  end;
  if FCommonData.BorderIndex > -1 then
    DrawSkinRect(FCommonData.FCacheBmp, R, CI, FCommonData.SkinManager.ma[FCommonData.BorderIndex], 0, True);

  if (ActivePage <> nil) and not (csDestroying in ActivePage.ComponentState) and (ActivePage.SkinData.SkinSection <> '') then begin
    i := FCommonData.SkinManager.GetSkinIndex(ActivePage.SkinData.SkinSection);
    if FCommonData.SkinManager.IsValidSkinIndex(i) then begin
      R := ActivePage.BoundsRect;
      PaintItem(i, MakeCacheInfo(FCommonData.FCacheBmp), True, 0, R, MkPoint, FCommonData.FCacheBmp, FCommonData.SkinManager);
    end;
  end;
  R := PageRect;
  if Tabs.Count > 0 then
    DrawSkinTabs(FCommonData.FCacheBmp);

  if ActivePage <> nil then
    SkinData.PaintOuterEffects(ActivePage, MkPoint(ActivePage));

  FCommonData.BGChanged := False;
end;


procedure TsPageControl.SetTabAlignment(const Value: TAlignment);
begin
  if FTabAlignment <> Value then begin
    FTabAlignment := Value;
    SkinData.Invalidate(True);
  end;
end;


procedure TsPageControl.SetTabsLineSkin(const Value: TsSkinSection);
begin
  if FTabsLineSkin <> Value then begin
    FTabsLineSkin := Value;
    if SkinData.SkinManager <> nil then
      FTabsLineIndex := SkinData.SkinManager.GetSkinIndex(FTabsLineSkin);

    FCommonData.Invalidate;
  end;
end;


constructor TsTabSheet.Create(AOwner: TComponent);
begin
  inherited;
  FCommonData := TsTabSkinData.Create;
  FCommonData.FPage := Self;
  FUseCloseBtn := True;
  FTabType := ttTab;
end;


procedure TsTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;


destructor TsTabSheet.Destroy;
begin
  if AnimTimer <> nil then begin
    AnimTimer.Enabled := False;
    FreeAndNil(AnimTimer);
  end;

  FreeAndNil(FCommonData);
  inherited;
end;


procedure TsTabSheet.SetButtonSkin(const Value: TsSkinSection);
begin
  if FButtonSkin <> Value then begin
    FButtonSkin := Value;
    if PageControl <> nil then
      TsPageControl(PageControl).SkinData.Invalidate;
  end;
end;


procedure TsTabSheet.SetTabMenu(const Value: TPopupMenu);
begin
  if FTabMenu <> Value then
    FTabMenu := Value;
end;


procedure TsTabSheet.SetTabSkin(const Value: TsSkinSection);
begin
  if FTabSkin <> Value then begin
    FTabSkin := Value;
    if (PageControl <> nil) and not (csLoading in PageControl.ComponentState) and (Visible or (csDesigning in ComponentState)) then begin
      TsPageControl(PageControl).SkinData.BGChanged := True;
      RedrawWindow(PageControl.Handle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INVALIDATE);
    end;
  end;
end;


procedure TsTabSheet.SetTabType(const Value: TacTabType);
begin
  if FTabType <> Value then begin
    FTabType := Value;
    if TabSkin = '' then
      case Value of
        ttMenu:   TabSkin := s_MenuButton;
        ttButton: TabSkin := s_SpeedButton;
      end
    else
      if Value = ttTab then
        TabSkin := '';

    if PageControl <> nil then begin
      TsPageControl(PageControl).UpdateBtnData;
      Perform(CM_TEXTCHANGED, 0, 0);
      inherited PageControl.ActivePage := TsPageControl(PageControl).CheckActiveTab(PageControl.ActivePage.PageIndex);
    end;
  end;
end;


procedure TsTabSheet.SetUseCloseBtn(const Value: boolean);
begin
  if FUseCloseBtn <> Value then begin
    FUseCloseBtn := Value;
    if (PageControl <> nil) and not (csLoading in PageControl.ComponentState) then
      TsPageControl(PageControl).RepaintTab(TabIndex, False);
  end;
end;


procedure TsTabSheet.WMEraseBkGnd(var Message: TWMPaint);
begin
  if not (csDestroying in ComponentState) and (PageControl <> nil) and not (csDestroying in PageControl.ComponentState) and
       TsPageControl(PageControl).SkinData.Skinned and Showing then begin
{$IFDEF D2005}
    if (csDesigning in PageControl.ComponentState) then
      inherited; // Fixing of designer issue
{$ENDIF}
    TsPageControl(PageControl).SkinData.FUpdating := TsPageControl(PageControl).SkinData.Updating;
    if (Message.DC = 0) or
         (TsPageControl(PageControl).SkinData.CtrlSkinState and ACS_PRINTING = ACS_PRINTING) and (Message.DC <> TsPageControl(PageControl).SkinData.PrintDC) then
      Exit;

    if not TsPageControl(PageControl).SkinData.FUpdating then begin
      if TsPageControl(PageControl).SkinData.BGChanged then
        TsPageControl(PageControl).PrepareCache;

      CopyWinControlCache(Self, TsPageControl(PageControl).SkinData, Rect(Left + BorderWidth, Top + BorderWidth, 0, 0), MkRect(Self), Message.DC, False);
      sVCLUtils.PaintControls(Message.DC, Self, True, MkPoint);
      SetParentUpdated(Self);
    end;
    Message.Result := 1;
  end
  else
    inherited;
end;


procedure TsTabSheet.WMNCPaint(var Message: TWMPaint);
var
  DC: hdc;
begin
  if not (csDestroying in ComponentState) and (BorderWidth > 0) and Showing and not InAnimationProcess then begin
    if TsPageControl(PageControl).SkinData.Skinned then begin
      TsPageControl(PageControl).SkinData.Updating := TsPageControl(PageControl).SkinData.Updating;
      if not TsPageControl(PageControl).SkinData.FUpdating then begin
        if (TsPageControl(PageControl).SkinData.CtrlSkinState and ACS_PRINTING = ACS_PRINTING) and (Message.DC = TsPageControl(PageControl).SkinData.PrintDC) then
          DC := Message.DC
        else
          DC := GetWindowDC(Handle);

        BitBltBorder(DC, 0, 0, Width, Height, TsPageControl(PageControl).SkinData.FCacheBmp.Canvas.Handle, Left, Top, BorderWidth);
        if DC <> Message.DC then
          ReleaseDC(Handle, DC);
      end;
    end
    else begin
{$IFDEF DELPHI7UP}
      if acThemesEnabled then
        inherited
      else
{$ENDIF}
      begin
        DC := GetWindowDC(Handle);
        FillDCBorder(DC, MkRect(Self), BorderWidth, BorderWidth, BorderWidth, BorderWidth, Color);
        if DC <> Message.DC then
          ReleaseDC(Handle, DC);
      end;
    end;
    Message.Result := 1;
  end;
end;


procedure TsTabSheet.WndProc(var Message: TMessage);
var
  i: integer;
  b: boolean;
  PS: TPaintStruct;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if PageControl <> nil then
    if (Message.Msg = SM_ALPHACMD) then
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit
        end;

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit
        end;

        AC_REMOVESKIN: begin
          if Message.LParam = LPARAM(TsPageControl(PageControl).SkinData.SkinManager) then
            Repaint;

          AlphaBroadCast(Self, Message);
        end;

        AC_SETNEWSKIN:
          AlphaBroadCast(Self, Message);

        AC_REFRESH: begin
          if (Message.LParam = LPARAM(TsPageControl(PageControl).SkinData.SkinManager)) and (Visible or (csDesigning in ComponentState)) then
            Repaint;

          AlphaBroadCast(Self, Message);
        end;

        AC_GETBG:
          if TsPageControl(PageControl).SkinData.Skinned then begin
            if (SkinData <> nil) and (SkinData.SkinSection <> '') and not TsPageControl(PageControl).SkinData.FCacheBmp.Empty then begin
              PacBGInfo(Message.LParam).BgType := btCache;
              PacBGInfo(Message.LParam).Bmp := TsPageControl(PageControl).SkinData.FCacheBmp;
              PacBGInfo(Message.LParam).Offset := MkPoint;
            end
            else begin
              CommonMessage(Message, TsPageControl(PageControl).SkinData);
              if PacBGInfo(Message.LParam).BgType = btNotReady then begin
                TsPageControl(PageControl).SkinData.Updating := True;
                Exit;
              end;
              PacBGInfo(Message.LParam).FillRect := MkRect;
            end;
            if (PacBGInfo(Message.LParam)^.Bmp <> nil) and not PacBGInfo(Message.LParam)^.PleaseDraw then begin
              PacBGInfo(Message.LParam)^.Offset.X := PacBGInfo(Message.LParam)^.Offset.X + Left + BorderWidth;
              PacBGInfo(Message.LParam)^.Offset.Y := PacBGInfo(Message.LParam)^.Offset.Y + Top  + BorderWidth;
              if PacBGInfo(Message.LParam)^.BgType = btFill then begin
                PacBGInfo(Message.LParam).FillRect.Left := PacBGInfo(Message.LParam)^.Offset.X - PacBGInfo(Message.LParam).FillRect.Left;
                PacBGInfo(Message.LParam).FillRect.Top  := PacBGInfo(Message.LParam)^.Offset.Y - PacBGInfo(Message.LParam).FillRect.Top;
              end;
            end;
            Exit;
          end;

        AC_GETCONTROLCOLOR:
          if TsPageControl(PageControl).SkinData.Skinned then begin
            Message.Result := PageControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETCONTROLCOLOR), 0);
            Exit;
          end;

        AC_PREPARING:
          if TsPageControl(PageControl).SkinData.Skinned then begin
            Message.Result := LRESULT(TsPageControl(PageControl).SkinData.Updating);
            Exit;
          end;

        AC_CHILDCHANGED:
          with TsPageControl(PageControl).SkinData do
            if Skinned then begin
              Message.Result := LRESULT((SkinManager.gd[SkinIndex].Props[0].GradientPercent + SkinManager.gd[SkinIndex].Props[0].ImagePercent > 0) or RepaintIfMoved);
              Exit;
            end;

        AC_GETSKININDEX: begin
          if (SkinData <> nil) and (SkinData.SkinSection <> '') then begin
            PacSectionInfo(Message.LParam)^.SkinIndex := TsPageControl(PageControl).SkinData.SkinManager.GetSkinIndex(SkinData.SkinSection);
            if PacSectionInfo(Message.LParam)^.SkinIndex < 0 then
              PacSectionInfo(Message.LParam)^.SkinIndex := TsPageControl(PageControl).SkinData.SkinIndex;
          end
          else
            PacSectionInfo(Message.LParam)^.SkinIndex := TsPageControl(PageControl).SkinData.SkinIndex;

          Exit
        end;

        AC_ENDPARENTUPDATE: begin
          RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW);
          SetParentUpdated(Self);
          Exit;
        end;

        AC_GETSKINSTATE: begin
          if Message.LParam = 1 then
            for i := 0 to ControlCount - 1 do
              SendAMessage(Controls[i], AC_GETSKINSTATE, 1)
          else begin
            if TsPageControl(PageControl).SkinData.CtrlSkinState and ACS_BGUNDEF = ACS_BGUNDEF then
              UpdateSkinState(TsPageControl(PageControl).SkinData, False);

            Message.Result := TsPageControl(PageControl).SkinData.CtrlSkinState;
          end;
          Exit;
        end;

        AC_GETDEFINDEX: begin
          if TsPageControl(PageControl).SkinData.SkinManager <> nil then
            Message.Result := TsPageControl(PageControl).SkinData.SkinManager.GetSkinIndex(s_TabSheet) + 1;

          Exit;
        end;

        AC_GETFONTINDEX:
          with TsPageControl(PageControl) do begin
            if SkinData.Skinned then
              with SkinData.SkinManager.gd[SkinData.SkinIndex] do
                if NeedParentFont(SkinData) then begin
                  inc(PacPaintInfo(Message.LParam)^.R.Left, SkinData.FOwnerControl.Left);
                  inc(PacPaintInfo(Message.LParam)^.R.Top,  SkinData.FOwnerControl.Top);
                  Message.Result := GetFontIndex(SkinData.FOwnerControl.Parent, PacPaintInfo(Message.LParam))
                end
                else
                  if GiveOwnFont then begin
                    PacPaintInfo(Message.LParam)^.FontIndex := SkinData.SkinIndex;
                    Message.Result := 1;
                  end;

            Exit;
          end;

          AC_SETCHANGEDIFNECESSARY:
            with TsPageControl(PageControl).SkinData do begin
              b := RepaintIfMoved;
              BGChanged := BGChanged or b;
              if FOwnerControl is TWinControl then begin
                if (Message.WParamLo = 1) then
                  RedrawWindow(Handle, nil, 0, RDW_NOERASE + RDW_NOINTERNALPAINT + RDW_INVALIDATE + RDW_ALLCHILDREN);

                if b then
                  for i := 0 to ControlCount - 1 do
                    if (i < ControlCount) and not (csDestroying in Controls[i].ComponentState) then
                      Controls[i].Perform(SM_ALPHACMD, MakeWParam(1, AC_SETCHANGEDIFNECESSARY), 0);
              end;
              Exit;
            end;
      end
    else
      if TsPageControl(PageControl).SkinData.Skinned then
        case Message.Msg of
          WM_MOUSEMOVE:
            if not (csDesigning in ComponentState) then
              if (DefaultManager <> nil) and not (csDesigning in DefaultManager.ComponentState) then
                DefaultManager.ActiveControl := Handle;

          WM_PARENTNOTIFY:
            if not ((csDesigning in ComponentState) or (csLoading in ComponentState)) and (Message.WParamLo in [WM_CREATE, WM_DESTROY]) then begin
              inherited;
              if Message.WParamLo = WM_CREATE then begin
                AddToAdapter(Self);
                if Message.LParam <> 0 then
                  SendAMessage(THandle(Message.LParam), AC_GETSKINSTATE, 1);
              end;
              Exit;
            end;

          WM_PAINT:
            if (Visible or (csDesigning in ComponentState)) then begin
              if not (csDestroying in ComponentState) and (Parent <> nil) then // Background update
                InvalidateRect(Handle, nil, True); // Background update (for repaint of graphic controls and for tabsheets refreshing)

              BeginPaint(Handle, PS);
              EndPaint(Handle, PS);
              Message.Result := 0;
              Exit
            end;

          WM_PRINT: begin
            WMEraseBkGnd(TWMPaint(Message));
            Message.Result := 0;
            Exit
          end;

          CM_TEXTCHANGED:
            TsPageControl(PageControl).SkinData.BGChanged := True;
        end;

  inherited;
  if (PageControl <> nil) and TsPageControl(PageControl).SkinData.Skinned then
    case Message.Msg of
      CM_VISIBLECHANGED:
        if (TsPageControl(PageControl).SkinData.SkinManager.Options.OptimizingPriority = opMemory) and not (csDestroying in ComponentState) then
          if not Visible then begin
            for i := 0 to ControlCount - 1 do
              if (Controls[i] is TWinControl) and TWinControl(Controls[i]).HandleAllocated then
                SendAMessage(TWinControl(Controls[i]).Handle, AC_CLEARCACHE)
          end
          else begin
            with TsPageControl(PageControl).SkinData.SkinManager do
              if not (AnimEffects.PageChange.Active and TsPageControl(PageControl).AllowAnimSwitching and Effects.AllowAnimation) then
                RedrawWindow(Parent.Handle, nil, 0, RDW_ERASE or RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);

            SetParentUpdated(Handle);
          end;

      WM_SIZE:
        if IsWindowVisible(Handle) then
          CommonWndProc(Message, TsPageControl(PageControl).SkinData);

      CM_TEXTCHANGED:
        TsPageControl(PageControl).KillTimers;

      CM_ENABLEDCHANGED:
        if not (csDestroying in ComponentState) and not (csLoading in ComponentState) and (Parent <> nil) then begin
          TsPageControl(Parent).SkinData.BGChanged := True;
          RedrawWindow(Parent.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME);
        end;
    end;
end;


procedure TsTabSkinData.SetCustomFont(const Value: boolean);
begin
  FCustomFont := Value;
  if (FPage <> nil) and (FPage.PageControl <> nil) and not (csLoading in FPage.PageControl.ComponentState) then begin
    TsPageControl(FPage.PageControl).SkinData.BGChanged := True;
    RedrawWindow(FPage.PageControl.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_FRAME or RDW_NOERASE);
  end;
end;


procedure TsTabSkinData.SetSkinSection(const Value: string);
begin
  FSkinSection := Value;
end;


constructor TsTabBtn.Create(AOwner: TComponent);
begin
  inherited;
  Flat := True;
  UpdateGlyph;
end;


procedure TsTabBtn.Paint;
{$IFDEF DELPHI7UP}
var
  PaintRect: TRect;
  Button: TThemedWindow;
  Details: TThemedElementDetails;
{$ENDIF}
begin
{$IFDEF DELPHI7UP}
  if acThemesEnabled then begin
    if FState in [bsDown, bsExclusive] then
      Button := twSmallCloseButtonPushed
    else
      if MouseInControl then
        Button := twSmallCloseButtonHot
      else
        Button := twSmallCloseButtonNormal;

    Details := acThemeServices.GetElementDetails(Button);
    PerformEraseBackground(Self, Canvas.Handle);
    PaintRect := MkRect(Width, Height);
    acThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
  end
  else
{$ENDIF}
    inherited
end;


procedure TsTabBtn.UpdateGlyph;
begin
  Caption := 'X';
  Font.Style := [fsBold];
  Font.Color := clRed;
end;


function TsPageControl.GetTabLayout(PageIndex: Integer; R: TRect): TacTabLayout;
begin
  if {(PageIndex <> ActivePageIndex) and} (SkinData.SkinManager.ConstData.Tabs[tlFirst][acTabSides[TabPosition]].SkinIndex >= 0) then
    if (GetNeighborIndex(PageIndex, False) < 0) then
      Result := tlFirst
    else
      if GetNeighborIndex(PageIndex, True) < 0 then
        Result := tlLast
      else
        Result := tlMiddle
  else
    Result := tlSingle;
end;


function TsPageControl.GetNeighborIndex(PageIndex: Integer; Next: boolean): integer;
var
  i: integer;
begin
  Result := -1;
  if Next then
    for i := PageIndex + 1 to PageCount - 1 do begin
      if Pages[i].TabVisible and (TsTabSheet(Pages[i]).TabType = ttTab) then begin
        Result := i;
        Exit;
      end;
    end
  else
    for i := PageIndex - 1 downto 0 do
      if Pages[i].TabVisible and (TsTabSheet(Pages[i]).TabType = ttTab) then begin
        Result := i;
        Exit;
      end;
end;


procedure TsPageControl.SetActiveTabEnlarged(const Value: boolean);
begin
  if FActiveTabEnlarged <> Value then begin
    FActiveTabEnlarged := Value;
    SkinData.Invalidate;
  end;
end;

end.
