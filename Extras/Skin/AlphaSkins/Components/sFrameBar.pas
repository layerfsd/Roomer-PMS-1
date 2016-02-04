unit sFrameBar;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ImgList, Menus, comctrls,
  sSpeedButton, sScrollBox, sConst;


type
{$IFNDEF NOTFORHELP}
  TsTitleItem = class;
  TsTitles = class;
  TsTitleState = (stClosed, stOpened, stClosing, stOpening);
{$ENDIF} // NOTFORHELP
  TOnFrameChangeEvent   = procedure (Sender: TObject;    TitleItem: TsTitleItem) of object;
  TOnFrameClosingEvent  = procedure (Sender: TObject;    TitleItem: TsTitleItem; var CanClose:  boolean) of object;
  TOnFrameChangingEvent = procedure (Sender: TObject; NewTitleItem: TsTitleItem; var CanChange: boolean) of object;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsFrameBar = class(TsScrollBox)
{$IFNDEF NOTFORHELP}
  private
    FAnimation,
    FAllowAllOpen,
    FAllowAllClose,
    FAutoFrameSize: boolean;

    FSpacing,
    FActiveFrame,
    FBorderWidth,
    FTitleHeight: integer;

    FItems:      TsTitles;
    FImages:     TCustomImageList;
    FOnChange:   TOnFrameChangeEvent;
    FOnChanging: TOnFrameChangingEvent;
    FOnClosing:  TOnFrameClosingEvent;
    function Offset: integer;
    procedure UpdateWidths;
    function CalcClientRect: TRect;
    function CreateDefaultFrame: TFrame;
    function UpdateFrame(i, y: integer; var h, w: integer): boolean;
    procedure SetAutoFrameSize(const Value: boolean);
    procedure SetAllowAllOpen (const Value: boolean);
    procedure SetItems        (const Value: TsTitles);
    procedure SetImages       (const Value: TCustomImageList);
    procedure SetInteger      (const Index, Value: integer);
  public
    Sizing,
    Arranging: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$ENDIF} // NOTFORHELP
    procedure ArrangeTitles;
    procedure UpdatePositions(DoRepaint: boolean = True); // Fast update
    procedure ChangeSize(Index: integer; AllowAnimation: boolean; Height: integer);
    procedure OpenItem  (Index: integer; AllowAnimation: boolean);
    procedure CloseItem (Index: integer; AllowAnimation: boolean);
    procedure ExpandAll  (AllowAnimation: boolean);
    procedure CollapseAll(AllowAnimation: boolean);
    procedure Rearrange;
  published
{$IFNDEF NOTFORHELP}
    property Align default alLeft;
    property BorderStyle;
    property BorderWidth:      integer index 0 read FBorderWidth write SetInteger default 2;
{$ENDIF} // NOTFORHELP
    property ActiveFrameIndex: integer index 1 read FActiveFrame write SetInteger;
    property TitleHeight:      integer index 2 read FTitleHeight write SetInteger default 28;
    property Spacing:          integer index 3 read FSpacing     write SetInteger default 2;

    property Animation:     boolean read FAnimation     write FAnimation      default True;
    property AllowAllClose: boolean read FAllowAllClose write FAllowAllClose  default False;
    property AllowAllOpen:  boolean read FAllowAllOpen  write SetAllowAllOpen default False;
    property AutoFrameSize: boolean read FAutoFrameSize write SetAutoFrameSize;

    property Images: TCustomImageList read FImages write SetImages;
    property Items: TsTitles read FItems write SetItems;

    {:@event}
    property OnChange:   TOnFrameChangeEvent   read FOnChange   write FOnChange;
    {:@event}
    property OnChanging: TOnFrameChangingEvent read FOnChanging write FOnChanging;
    {:@event}
    property OnClosing:  TOnFrameClosingEvent  read FOnClosing  write FOnClosing;
  end;


{$IFNDEF NOTFORHELP}
  TsTitles = class(TCollection)
  private
    FOwner: TsFrameBar;
  protected
    function  GetItem(Index: Integer): TsTitleItem;
    procedure SetItem(Index: Integer; Value: TsTitleItem);
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TsFrameBar);
    destructor Destroy; override;
    property Items[Index: Integer]: TsTitleItem read GetItem write SetItem; default;
  end;


  TsTitleButton = class(TsSpeedButton)
  protected
    Alpha,
    TempState: integer;
    FOwner: TsFrameBar;
    Active: boolean;
    procedure Ac_CMMouseEnter; override;
  public
    TitleItem: TsTitleItem;
    constructor InternalCreate(AOwner: TsFrameBar; Index: integer);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PrepareCache: boolean; override;
    function CurrentState: integer; override;
    property TextAlignment default taLeftJustify;
    property OnClick;
  end;
{$ENDIF} // NOTFORHELP


  TCreateFrameEvent  = procedure (Sender: TObject; var Frame: TCustomFrame) of object;
  TFrameDestroyEvent = procedure (Sender: TObject; var Frame: TCustomFrame; var CanDestroy: boolean) of object;


  TsTitleItem = class(TCollectionItem)
{$IFNDEF NOTFORHELP}
  private
    FTag: Longint;
    FCursor: TCursor;
    FOwner: TsTitles;
    FCaption: acString;
    FVisible: boolean;
    FImageIndex: integer;

    FOnClick,
    FOnFrameShow,
    FOnFrameClose,
    FOnTitleItemDestroy: TNotifyEvent;

    FOnCreateFrame:      TCreateFrameEvent;
    FOnFrameDestroy:     TFrameDestroyEvent;
    function GetMargin: integer;
    function GetSpacing: integer;

    function GetPopupMenu: TPopupMenu;
    function GetSkinSection: string;
    function GetTextAlignment: TAlignment;
    procedure TitleButtonClick(Sender: TObject);
    procedure SetTextAlignment(const Value: TAlignment);
    procedure SetCaption      (const Value: acString);
    procedure SetVisible      (const Value: boolean);
    procedure SetSkinSection  (const Value: string);
    procedure SetPopupMenu    (const Value: TPopupMenu);
    procedure SetCursor       (const Value: TCursor);
    procedure SetImageIndex   (const Value: integer);
    procedure SetMargin       (const Value: integer);
    procedure SetSpacing      (const Value: integer);
  protected
    TempHeight: real;
    LastBottom: integer;
    procedure SetIndex(Value: Integer); override;
  public
{$ENDIF} // NOTFORHELP
    TitleButton: TsTitleButton;
    Frame: TCustomFrame;
    State: TsTitleState;
{$IFNDEF NOTFORHELP}
    FrameSize: integer;
    Closing: boolean;
    Obj: TObject;
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    constructor Create(Collection: TCollection); override;
  published
    property DisplayName;
{$ENDIF} // NOTFORHELP
    property ImageIndex: integer read FImageIndex write SetImageIndex default -1;
    property Margin:     integer read GetMargin   write SetMargin     default 5;
    property Spacing:    integer read GetSpacing  write SetSpacing    default 8;

    property Caption:       acString   read FCaption         write SetCaption;
    property Cursor:        TCursor    read FCursor          write SetCursor;
    property SkinSection:   string     read GetSkinSection   write SetSkinSection;
    property Tag:           Longint    read FTag             write FTag              default 0;
    property TextAlignment: TAlignment read GetTextAlignment write SetTextAlignment;
    property Visible:       boolean    read FVisible         write SetVisible        default True;
    property PopupMenu:     TPopupMenu read GetPopupMenu     write SetPopupMenu;

    property OnCreateFrame:  TCreateFrameEvent  read FOnCreateFrame      write FOnCreateFrame;
    property OnFrameDestroy: TFrameDestroyEvent read FOnFrameDestroy     write FOnFrameDestroy;
    property OnClick:        TNotifyEvent       read FOnClick            write FOnClick;
    property OnFrameShow:    TNotifyEvent       read FOnFrameShow        write FOnFrameShow;
    property OnFrameClose:   TNotifyEvent       read FOnFrameClose       write FOnFrameClose;
    property OnDestroy:      TNotifyEvent       read FOnTitleItemDestroy write FOnTitleItemDestroy;
  end;


implementation

uses
  stdctrls,
  sMessages, sSkinProps, sVCLUtils, sFrameAdapter, sLabel, acntUtils, acSBUtils, sGraphUtils, sCommonData, sFade;


const
  Speed = 1.5;//2;

var
  DontAnim: boolean;
  bCanChange: boolean = False;


constructor TsTitles.Create(AOwner: TsFrameBar);
begin
  inherited Create(TsTitleItem);
  FOwner := AOwner;
end;


destructor TsTitles.Destroy;
begin
  inherited Destroy;
  FOwner := nil;
end;


function TsTitles.GetItem(Index: Integer): TsTitleItem;
begin
  Result := TsTitleItem(inherited GetItem(Index));
end;


function TsTitles.GetOwner: TPersistent;
begin
  Result := FOwner;
end;


procedure TsTitles.SetItem(Index: Integer; Value: TsTitleItem);
begin
  inherited SetItem(Index, Value);
  FOwner.UpdatePositions;
end;


procedure TsTitles.Update(Item: TCollectionItem);
begin
  inherited;
  if (UpdateCount = 0) and FOwner.HandleAllocated then
    FOwner.UpdatePositions;
end;


procedure TsFrameBar.ArrangeTitles;
var
  Steps, sDiv, i, ii, sHeight, cWidth, AutoHeight: integer;
  b, CanDestroy, DoAnimation: boolean;
  ti: TsTitleItem;
  lTicks: DWord;
  cRect: TRect;
  rDelta: real;

  procedure SetActive(Index: integer; Active: boolean);
  begin
    if (Items[Index].TitleButton.Active <> Active) and (Items[Index].State in [stClosed, stOpened]) then begin
      Items[Index].TitleButton.Active := Active;
      Items[Index].TitleButton.SkinData.Invalidate;
    end;
  end;

  procedure LockControl(Locked: boolean);
  begin
    Perform(WM_SETREDRAW, integer(not Locked), 0);
    if Locked then
      SkinData.BeginUpdate
    else
      SkinData.EndUpdate;
  end;

  procedure DoOpened(ti: TsTitleItem);
  var
    j: integer;
  begin
    FActiveFrame := i;
    if AutoHeight <> -1 then begin
      sDiv := AutoHeight;
      ti.FrameSize := AutoHeight;
      if ti.Frame <> nil then
        ti.Frame.Height := AutoHeight
    end;
    j := -1;
    UpdateFrame(i, sHeight - Offset, j, cWidth);
    if (sDiv = 0) and (ti.Frame <> nil) then
      sDiv := ti.Frame.Height;
  end;

  procedure DoClosed(ti: TsTitleItem);
  begin
    if FActiveFrame = i then
      FActiveFrame := -1;

    if ti.Frame <> nil then begin
      CanDestroy := True;
      if Assigned(ti.FOnFrameDestroy) then
        ti.FOnFrameDestroy(Items[i], Items[i].Frame, CanDestroy);

      if CanDestroy then
        FreeAndNil(ti.Frame);

      ti.FrameSize := 0;
      sDiv := 0;
      if ti.Frame <> nil then
        UpdateFrame(i, sHeight - Offset, sDiv, cWidth);

      ti.FrameSize := 0;
    end;
  end;

  procedure DoOpening(ti: TsTitleItem);
  begin
    if (ii = Steps) then begin
      if ti.Frame <> nil then
        if (AutoHeight <> -1) then begin
          sDiv := AutoHeight;
          ti.FrameSize := AutoHeight;
          if ti.Frame <> nil then
            ti.Frame.Height := AutoHeight
        end
        else
          sDiv := ti.Frame.Height
    end
    else
      if Steps <> 0 then begin
        if ti.Frame <> nil then begin
          rDelta := (ti.Frame.Height - ti.TempHeight) / Speed;
          if ti.TempHeight = 0 then
            rDelta := rDelta + (ti.Frame.Height - rDelta) / Speed;

          ti.TempHeight := ti.TempHeight + rDelta;
        end;
        sDiv := Round(ti.TempHeight);
      end;

    if  ti.Frame <> nil then
      ti.TitleButton.Alpha := Round((sDiv / ti.Frame.Height) * MaxByte)
    else
      ti.TitleButton.Alpha := 0;

    ti.TitleButton.SkinData.BGChanged := True;
    lTicks := GetTickCount;
    if UpdateFrame(i, sHeight - Offset, sDiv, cWidth) then begin
      if (ii = Steps) or (ti.Frame <> nil) and (ti.TempHeight = ti.Frame.Height) then
        ti.State := stOpened
      else
        if Steps > 0 then
          while lTicks + acTimerInterval > GetTickCount do {wait here};
    end;
  end;

  procedure DoClosing(ti: TsTitleItem);
  var
    j: integer;
  begin
    ti.TitleButton.Alpha := ii;
    ti.TitleButton.SkinData.BGChanged := True;
    lTicks := GetTickCount;
    if Assigned(FOnClosing) then begin
      b := True;
      FOnClosing(Self, ti, b);
      if not b then begin
        ti.State := stOpened;
        if AutoHeight <> -1 then begin
          ti.FrameSize := AutoHeight;
          if ti.Frame <> nil then
            ti.Frame.Height := AutoHeight
        end;
        j := -1;
        UpdateFrame(i, sHeight - Offset, j, cWidth);
        inc(sHeight, FSpacing);
        Exit;
      end;
    end;
    if Steps = 0 then
      sDiv := 0
    else begin
      rDelta := (ti.Frame.Height - ti.TempHeight) / Speed;
      ti.TempHeight := ti.TempHeight + rDelta;
      sDiv := ti.Frame.Height - Round(ti.TempHeight);
    end;

    if ti.Frame <> nil then
      ti.TitleButton.Alpha := Round((sDiv / ti.Frame.Height) * MaxByte)
    else
      ti.TitleButton.Alpha := MaxByte;

    if (ii = Steps) or (rDelta < 1) then begin
      ti.Closing := False;
      CanDestroy := True;

      if Assigned(ti.FOnFrameDestroy) then
        ti.FOnFrameDestroy(ti, ti.Frame, CanDestroy);

      if CanDestroy then
        FreeAndNil(ti.Frame)
      else
        ti.Frame.Visible := False;

      ti.FrameSize := 0;
      sDiv := 0;
      ti.State := stClosed;
      SetActive(i, False);
      if ti.Frame <> nil then
        UpdateFrame(i, sHeight - Offset, sDiv, cWidth);

      inc(sHeight, FSpacing);
      Exit;
    end
    else begin
      UpdateFrame(i, sHeight - Offset, sDiv, cWidth);
      if Steps > 0 then
        while lTicks + acTimerInterval > GetTickCount do {wait here};
    end;
  end;

begin
  if not visible or Arranging or (csReading in ComponentState) or (Items.Count = 0) then
    FActiveFrame := -1
  else
    if Items.UpdateCount <= 0 then begin
      DoAnimation := FAnimation and ((SkinData.SkinManager = nil) or SkinData.SkinManager.Effects.AllowAnimation);
      if not DontAnim and DoAnimation and not (csDesigning in ComponentState) and Visible and not (csLoading in ComponentState)  then
        Steps := acMaxIterations
      else
        Steps := 0;

      cRect := CalcClientRect;
      Arranging := True;
      sHeight := 0;
      AutoHeight := -1;
      bCanChange := True;
      if not ShowHintStored then begin
        AppShowHint := Application.ShowHint;
        Application.ShowHint := False;
        ShowHintStored := True;
      end;

      FadingForbidden := True;
      if AutoFrameSize then begin
        AutoScroll := False;
        sHeight := cRect.Top;
        for i := 0 to Items.Count - 1 do
          if Items[i].Visible and (Items[i].TitleButton <> nil) and Items[i].TitleButton.Visible then begin
            inc(sHeight, FTitleHeight);
            if (Items[i].State in [stOpened, stOpening]) then
              inc(sHeight, BorderWidth);

            inc(sHeight, BorderWidth);
          end;

        AutoHeight := HeightOf(cRect) - sHeight;
      end;

      for i := 0 to Items.Count - 1 do
        if Items[i].TitleButton <> nil then begin
          Items[i].LastBottom := Items[i].TitleButton.Top + Items[i].TitleButton.Height;
          Items[i].TitleButton.SkinData.FMouseAbove := False;
          StopTimer(Items[i].TitleButton.SkinData);
        end;

      for ii := 0 to Steps do begin
        LockControl(True);
        sHeight := cRect.Top;
        cWidth := WidthOf(cRect);
        for i := 0 to Items.Count - 1 do begin
          ti := Items[i];
          if ti.Visible and (ti.TitleButton <> nil) and ti.TitleButton.Visible then begin
            ti.TitleButton.SetBounds(cRect.Left, sHeight - Offset, cWidth, FTitleHeight);
            if ti.TitleButton.Parent <> Self then
              ti.TitleButton.Parent := Self;

            inc(sHeight, FTitleHeight);
            if (ii = 0) then begin
              ti.TempHeight := 0;
              if (ti.Frame <> nil) then
                ti.FrameSize := ti.Frame.Height;
            end;
            sDiv := ti.FrameSize;
            if (sDiv = 0) and (ti.State = stOpening) and not DoAnimation then
              ti.State := stOpened;

            case ti.State of
              stOpening: DoOpening(ti);
              stClosing: DoClosing(ti);
              stOpened:  DoOpened (ti);
              stClosed:  DoClosed (ti);
            end;
            inc(sHeight, FSpacing);
            if (ti.Frame <> nil) and (ti.State in [stOpened, stOpening, stClosing]) then begin
              if ti.Frame.Parent = nil then
                ti.Frame.Parent := Self;

              inc(sHeight, sDiv);
            end;
            if (ti.Frame <> nil) and (ti.State = stOpened) then
              SetWindowRgn(ti.Frame.Handle, 0, False);

            inc(sHeight, BorderWidth);
            SetActive(i, ti.State in [stOpened, stOpening]);
          end;
        end;
        LockControl(False);
        if Showing then begin
          InvalidateRect(Handle, nil, True);
          RedrawWindow(Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_UPDATENOW);
          SetParentUpdated(Self);
        end;
        if Assigned(acMagnForm) then
          SendMessage(acMagnForm.Handle, SM_ALPHACMD, MakeWParam(0, AC_REFRESH), 0);
      end;
      bCanChange := False;
      FadingForbidden := False;
      inc(sHeight, BorderWidth + 2 * integer(BorderStyle = bsSingle));
      if VertScrollBar.Range <> sHeight then
        VertScrollBar.Range := sHeight;

      Arranging := False;
      UpdateWidths;
      if Showing then
        RedrawWindow(Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);

      if Assigned(acMagnForm) then
        SendMessage(acMagnForm.Handle, SM_ALPHACMD, MakeWParam(0, AC_REFRESH), 0);

      Application.ShowHint := AppShowHint;
      ShowHintStored := False;
    end;
end;


function TsFrameBar.CalcClientRect: TRect;
begin
  if HandleAllocated then
    Windows.GetClientRect(Handle, Result)
  else
    Result := MkRect(Self);


  InflateRect(Result,  -BorderWidth, -BorderWidth);
end;


procedure TsFrameBar.ChangeSize(Index: integer; AllowAnimation: boolean; Height: integer);
begin
  if Assigned(Items[Index].Frame) then begin
    Items[Index].FrameSize := Height;
    Items[Index].Frame.Height := Height;
  end;
  Items[Index].FrameSize := Height;
  if AllowAnimation then
    Items[Index].State := stOpening
  else
    Items[Index].State := stOpened;

  DontAnim := not AllowAnimation;
  ArrangeTitles;
  DontAnim := False;
end;


procedure TsFrameBar.CloseItem(Index: integer; AllowAnimation: boolean);
begin
  if AllowAnimation then
    Items[Index].State := stClosing
  else
    Items[Index].State := stClosed;

  DontAnim := not AllowAnimation;
  ArrangeTitles;
  DontAnim := False;
  if Assigned(Items[Index].FOnFrameClose) then
    Items[Index].FOnFrameClose(Items[Index]);
end;


procedure TsFrameBar.CollapseAll(AllowAnimation: boolean);
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do
    if AllowAnimation then
      Items[i].State := stClosing
    else
      Items[i].State := stClosed;

  ArrangeTitles;
end;


constructor TsFrameBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsFrameBar;
  FItems := TsTitles.Create(Self);
  Caption := s_Space;
  Align := alLeft;
  BevelOuter := bvLowered;
  FTitleHeight := 28;
  VertScrollBar.Tracking := True;
  HorzScrollBar.Visible := False;
  FBorderWidth := 2;
  FAnimation := True;
  FAllowAllClose := False;
  FAllowAllOpen := False;
  FActiveFrame := -1;
end;


function TsFrameBar.CreateDefaultFrame: TFrame;
var
  lbl: TsLabel;
begin
  Result := TFrame.Create(Self);
  Result.Height := 150;
  TsFrameAdapter.Create(Result).SkinData.SkinManager := Self.SkinData.FSkinManager;
  TsFrameAdapter.Create(Result).SkinData.SkinSection := s_BarPanel;
  lbl := TsLabel.Create(Result);
  with lbl do begin
    lbl.Align := alClient;
    Caption := 'Frame creation'#13#10'event has not been defined.';
    Alignment := taCenter;
    Layout := tlCenter;
    WordWrap := True;
    lbl.Font.color := clRed;
    Parent := Result;
  end;
end;


destructor TsFrameBar.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;


procedure TsFrameBar.ExpandAll(AllowAnimation: boolean);
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do
    if AllowAnimation then
      Items[i].State := stOpening
    else
      Items[i].State := stOpened;

  ArrangeTitles;
end;


procedure TsFrameBar.Loaded;
var
  i: integer;
begin
  inherited;
  for i := 0 to Items.Count - 1 do begin
    Items[i].TitleButton.SkinData.SkinManager := SkinData.FSkinManager;
    Items[i].TitleButton.Cursor := Items[i].Cursor;
  end;
  if Visible then
    Rearrange;
end;


procedure TsFrameBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
end;


function TsFrameBar.Offset: integer;
var
  sbi: TScrollInfo;
begin
  if SkinData.Skinned then
    if Assigned(ListSW) and (ListSW.sBarVert <> nil) and ListSW.sBarVert.fScrollVisible then
      Result := ListSW.sBarVert.ScrollInfo.nPos
    else
      Result := 0
  else begin
    sbi.cbSize := SizeOf(TScrollInfo);
    sbi.fMask := SIF_POS;
    if GetScrollInfo(Handle, SB_VERT, sbi) then
      Result := sbi.nPos
    else
      Result := 0;
  end;
end;


procedure TsFrameBar.OpenItem(Index: integer; AllowAnimation: boolean);
var
  l, i: integer;
  ClosedItems: array of integer;
begin
  if (Index = -1) or (Index >= Items.Count) then
    raise Exception.Create('Open Index Out of Range: ' + IntToStr(Index));

  FActiveFrame := Index;
  if AllowAnimation then
    Items[Index].State := stOpening
  else
    Items[Index].State := stOpened;

  if not AllowAllOpen then begin
    for i := 0 to Items.Count - 1 do
      if Items[i].State = stOpened then begin
        Items[i].State := stClosing;
        if (i <> Index) and Assigned(Items[Index].FOnFrameClose) then begin
          l := Length(ClosedItems);
          SetLength(ClosedItems, l + 1);
          ClosedItems[l] := i;
        end;
      end;

    Items[Index].State := stOpened;
  end;
  DontAnim := not AllowAnimation;
  ArrangeTitles;
  DontAnim := False;

  if Assigned(Items[Index].FOnFrameShow) then
    Items[Index].FOnFrameShow(Items[Index]);

  for i := 0 to Length(ClosedItems) - 1 do
    if (ClosedItems[i] < Items.Count) and Assigned(Items[Index].FOnFrameClose) then
      Items[ClosedItems[i]].FOnFrameClose(Items[ClosedItems[i]]);
end;


procedure TsFrameBar.Rearrange;
begin
  DontAnim := True;
  ArrangeTitles;
  DontAnim := False;
end;


procedure TsFrameBar.SetAllowAllOpen(const Value: boolean);
begin
  if FAllowAllOpen <> Value then begin
    if Value and FAutoFrameSize then
      FAutoFrameSize := False;

    FAllowAllOpen := Value;
    if not (csLoading in ComponentState) then
      Rearrange;
  end;
end;


procedure TsFrameBar.SetAutoFrameSize(const Value: boolean);
begin
  if FAutoFrameSize <> Value then begin
    if Value then begin
      if AllowAllOpen then
        AllowAllOpen := False;

      AutoScroll := False;
    end;
    FAutoFrameSize := Value;
    if not (csLoading in ComponentState) then
      Rearrange;
  end;
end;


procedure TsFrameBar.SetImages(const Value: TCustomImageList);
var
  i: integer;
begin
  if FImages <> Value then begin
    FImages := Value;
    for i := 0 to Items.Count - 1 do
      if Items[i].TitleButton.Visible then
        Items[i].TitleButton.Images := Images;
  end;
end;


procedure TsFrameBar.SetInteger(const Index, Value: integer);
begin
  case Index of
    0: begin
      if FBorderWidth <> Value then begin
        FBorderWidth := Value;
        RecreateWnd;
        if not (csLoading in ComponentState) then
          Rearrange;
      end;
    end;

    1: begin
      if (Value >= 0) and (Value < Items.Count) then
        OpenItem(Value, True);

      FActiveFrame := Value;
    end;

    2: begin
      if FTitleHeight <> Value then begin
        FTitleHeight := Value;
        if not (csLoading in ComponentState) then
          Rearrange;
      end;
    end;

    3: begin
      if FSpacing <> Value then begin
        FSpacing := Value;
        if not (csLoading in ComponentState) then
          Rearrange;
      end;
    end;
  end;
end;


procedure TsFrameBar.SetItems(const Value: TsTitles);
begin
  FItems.Assign(Value);
end;


function TsFrameBar.UpdateFrame(i, y: integer; var h, w: integer): boolean;
var
  rgn: hrgn;

  procedure CallOnChange;
  begin
    if (Items[i].Frame <> nil) then begin
      if bCanChange and Assigned(FOnChange) then
        FOnChange(Self, Items[i]);

      bCanChange := False;
    end;
  end;

begin
  Result := False;
  if Items.Count > i then begin
    if (Items[i].Frame = nil) and not (csDesigning in ComponentState) then begin
      if Assigned(Items[i].OnCreateFrame) then
        Items[i].OnCreateFrame(Items[i], Items[i].Frame)
      else
        Items[i].Frame := CreateDefaultFrame;

      CallOnChange;
    end
    else
      if not Items[i].Frame.Visible and (h <> 0) then begin
        Items[i].Frame.Visible := True;
        CallOnChange;
      end;

    if (Items[i].Frame <> nil) and Items[i].Frame.Visible then begin
      if (Items[i].FrameSize = 0) then
        Items[i].FrameSize := Items[i].Frame.Height;

      if h = -1 then begin
        h := Items[i].FrameSize; // if frame has not been created
        Items[i].Frame.Height := Items[i].FrameSize;
      end;
      if h < Items[i].LastBottom - y then
        h := Items[i].LastBottom - y
      else
        if h = 0 then // Frame was created and will be opened now
          h := Round(Items[i].Frame.Height / Speed);

      if h > Items[i].FrameSize then
        h := Items[i].FrameSize;

      if h = 0 then begin
        rgn := CreateRectRgn(-1, -1, -1, -1);
        SetWindowRgn(Items[i].Frame.Handle, rgn, False);
        Items[i].Frame.Visible := False;
      end
      else begin
        if h = Items[i].Frame.Height then
          SetWindowRgn(Items[i].Frame.Handle, 0, False)
        else begin
          if Items[i].Frame.Parent = nil then
            Items[i].Frame.Parent := Self;

          rgn := CreateRectRgn(0, Items[i].Frame.Height - h, w, Items[i].Frame.Height);
          SetWindowRgn(Items[i].Frame.Handle, rgn, False);
        end;
        Items[i].Frame.Visible := True;
      end;

      Items[i].Frame.SetBounds(Items[i].TitleButton.Left, y - (Items[i].Frame.Height - h), w, Items[i].Frame.Height);
      Result := True;
    end;
  end;
end;


procedure TsFrameBar.UpdatePositions;
var
  cRect: TRect;
  CanDestroy: boolean;
  sDiv, i, j, sHeight, cWidth, AutoHeight: integer;
begin
  if not Visible or Arranging or (csReading in ComponentState) or (csDestroying in ComponentState) or (Items.Count = 0) then
    FActiveFrame := -1
  else
    if Items.UpdateCount <= 0 then begin
      cRect := CalcClientRect;
      Arranging := True;
      AutoHeight := -1;
      bCanChange := True;
      if AutoFrameSize then begin
        AutoScroll := False;
        sHeight := cRect.Top;
        for i := 0 to Items.Count - 1 do
          if Items[i].Visible and (Items[i].TitleButton <> nil) and Items[i].TitleButton.Visible then begin
            inc(sHeight, FTitleHeight);
            if (Items[i].State in [stOpened]) then
              inc(sHeight, BorderWidth);

            inc(sHeight, BorderWidth);
          end;

        AutoHeight := HeightOf(cRect) - sHeight;
      end;
      SkinData.BeginUpdate;
      Perform(WM_SETREDRAW, 0, 0);
      sHeight := cRect.Top;
      cWidth := WidthOf(cRect);
      for i := 0 to Items.Count - 1 do
        if Items[i].Visible and (Items[i].TitleButton <> nil) and Items[i].TitleButton.Visible then begin
          Items[i].TitleButton.SetBounds(cRect.Left, sHeight - Offset, cWidth, FTitleHeight);
          if Items[i].TitleButton.Parent <> Self then
            Items[i].TitleButton.Parent := Self;

          inc(sHeight, FTitleHeight);
          if Items[i].Frame <> nil then begin
            Items[i].FrameSize := Items[i].Frame.Height;
            sDiv := Items[i].FrameSize;
          end
          else begin
            Items[i].FrameSize := 0;
            sDiv := 0;
          end;
          if (Items[i].State = stOpening) then
            Items[i].State := stOpened;

          case Items[i].State of
            stOpened: begin
              FActiveFrame := i;
              if AutoHeight <> -1 then begin
                Items[i].FrameSize := AutoHeight;
                if Items[i].Frame <> nil then
                  Items[i].Frame.Height := Items[i].FrameSize;
              end
              else
                if Items[i].Frame <> nil then
                  Items[i].FrameSize := Items[i].Frame.Height;

              j := -1;
              UpdateFrame(i, sHeight - Offset, j, cWidth);
              sDiv := Items[i].Frame.Height;
              inc(sHeight, FSpacing);
            end;

            stClosed: begin
              if FActiveFrame = i then
                FActiveFrame := -1;

              if Items[i].Frame <> nil then begin
                CanDestroy := True;
                if Assigned(Items[i].FOnFrameDestroy) then
                  Items[i].FOnFrameDestroy(Items[i], Items[i].Frame, CanDestroy);

                if CanDestroy then
                  FreeAndNil(Items[i].Frame);

                Items[i].FrameSize := 0;
                sDiv := 0;
                if Items[i].Frame <> nil then
                  UpdateFrame(i, sHeight - Offset, sDiv, cWidth);

                Items[i].FrameSize := 0;
              end;
              inc(sHeight, FSpacing);
            end;
          end;
          if (Items[i].Frame <> nil) and (Items[i].State in [stOpened]) then begin
            if Items[i].Frame.Parent = nil then
              Items[i].Frame.Parent := Self;

            inc(sHeight, sDiv + BorderWidth);
          end;
          inc(sHeight, BorderWidth);
        end;

      if Assigned(acMagnForm) then
        SendMessage(acMagnForm.Handle, SM_ALPHACMD, MakeWParam(0, AC_REFRESH), 0);

      bCanChange := False;
      inc(sHeight, BorderWidth + 2 * integer(BorderStyle = bsSingle));
      if VertScrollBar.Range <> sHeight then
        VertScrollBar.Range := sHeight;

      Arranging := False;
      Perform(WM_SETREDRAW, 1, 0);
      SkinData.EndUpdate;
      if Showing and DoRepaint then
        RedrawWindow(Handle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);

      if Assigned(acMagnForm) then
        SendMessage(acMagnForm.Handle, SM_ALPHACMD, MakeWParam(0, AC_REFRESH), 0);
    end;
end;


procedure TsFrameBar.UpdateWidths;
var
  i, cWidth: integer;
begin
  if Items.UpdateCount <= 0 then begin
    Arranging := True;
    cWidth := WidthOf(CalcClientRect);
    for i := 0 to Items.Count - 1 do
      if (Items[i].TitleButton <> nil) and Items[i].TitleButton.Visible and Items[i].Visible then begin
        if Items[i].TitleButton.Width <> cWidth then begin
          Items[i].TitleButton.SkinData.BGChanged := True;
          Items[i].TitleButton.Width := cWidth;
        end;
        if (Items[i].Frame <> nil) and (Items[i].Frame.Width <> cWidth) then
          Items[i].Frame.Width := cWidth;
      end;

    Arranging := False;
    if AutoScroll then
      UpdateScrolls(ListSW);
  end;
end;


procedure TsFrameBar.WndProc(var Message: TMessage);
var
  i: integer;
begin
  inherited;
  case Message.Msg of
    WM_SIZE:
      if Showing then
        if AutoFrameSize then
          Rearrange
        else begin
          UpdateWidths;
          RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);
        end;

    CM_VISIBLECHANGED:
      if Showing then
        Rearrange;

    CM_ENABLEDCHANGED: begin
      for i := 0 to Items.Count - 1 do begin
        Items[i].TitleButton.Enabled := Enabled;
        if Items[i].Frame <> nil then
          Items[i].Frame.Enabled := Enabled;
      end;
      Repaint;
    end;
  end;
  if Message.Msg = cardinal(SM_ALPHACMD) then
    case Message.WParamHi of
      AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and SkinData.Skinned then begin
          SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_FRAMECHANGED);
          UpdateWidths;
        end;
    end;
end;


procedure TsTitleItem.Assign(Source: TPersistent);
var
  Src: TsTitleItem;
begin
  if Source <> nil then begin
    Src         := TsTitleItem(Source);
    Tag         := Src.Tag;
    Cursor      := Src.Cursor;
    Margin      := Src.Margin;
    Spacing     := Src.Spacing;
    Caption     := Src.Caption;
    Visible     := Src.Visible;
    PopupMenu   := Src.PopupMenu;
    ImageIndex  := Src.ImageIndex;
    SkinSection := Src.SkinSection;
  end
  else
    inherited;
end;


constructor TsTitleItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTag := 0;
  FOwner := TsTitles(Collection);
  TitleButton := TsTitleButton.InternalCreate(FOwner.FOwner, Index);
  TitleButton.TitleItem := Self;
  TitleButton.OnClick := TitleButtonClick;
  FVisible := True;
  FImageIndex := -1;
  State := stClosed;
  FOwner.FOwner.UpdatePositions;
end;


destructor TsTitleItem.Destroy;
begin
  if Assigned(FOnTitleItemDestroy) then
    FOnTitleItemDestroy(Self);

  if not (csDestroying in FOwner.FOwner.ComponentState) and (TitleButton <> nil) then begin
    TitleButton.Visible := False;
    TitleButton.Free;
    TitleButton := nil;
    if Frame <> nil then
      FreeAndNil(Frame);
  end;
  if Assigned(FOnTitleItemDestroy) then
    FOnTitleItemDestroy(self);

  inherited Destroy;
  if not (csDestroying in FOwner.FOwner.ComponentState) then
    FOwner.FOwner.UpdatePositions;
end;


function TsTitleItem.GetMargin: integer;
begin
  Result := TitleButton.Margin;
end;


function TsTitleItem.GetPopupMenu: TPopupMenu;
begin
  if TitleButton <> nil then
    Result := TitleButton.PopupMenu
  else
    Result := nil
end;


function TsTitleItem.GetSkinSection: string;
begin
  Result := TitleButton.SkinData.SkinSection;
end;


function TsTitleItem.GetSpacing: integer;
begin
  Result := 0;
  if Result <> TitleButton.Spacing then begin
    Result := TitleButton.Spacing;
    if csDesigning in TitleButton.ComponentState then
      TitleButton.SkinData.Invalidate;
  end;
end;


function TsTitleItem.GetTextAlignment: TAlignment;
begin
  if TitleButton <> nil then
    Result := TitleButton.TextAlignment
  else
    Result := taLeftJustify;
end;


procedure TsTitleItem.SetCaption(const Value: acString);
begin
  TitleButton.Caption := Value;
  FCaption := Value;
  FOwner.FOwner.UpdatePositions;
end;


procedure TsTitleItem.SetCursor(const Value: TCursor);
begin
  if FCursor <> Value then begin
    FCursor := Value;
    if TitleButton <> nil then
      TitleButton.Cursor := Value;
  end;
end;


procedure TsTitleItem.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> Value then begin
    FImageIndex := Value;
    TitleButton.ImageIndex := Value;
    if TitleButton.Images <> FOwner.FOwner.Images then
      TitleButton.Images := FOwner.FOwner.Images;

    FOwner.FOwner.UpdatePositions;
  end;
end;


procedure TsTitleItem.SetIndex(Value: Integer);
begin
  inherited;
  FOwner.FOwner.ArrangeTitles;
end;


procedure TsTitleItem.SetMargin(const Value: integer);
begin
  if TitleButton.Margin <> Value then begin
    TitleButton.Margin := Value;
    if csDesigning in TitleButton.ComponentState then
      TitleButton.SkinData.Invalidate;
  end;
end;


procedure TsTitleItem.SetPopupMenu(const Value: TPopupMenu);
begin
  if TitleButton <> nil then
    TitleButton.PopupMenu := Value;
end;


procedure TsTitleItem.SetSkinSection(const Value: string);
begin
  TitleButton.SkinData.SkinSection := Value
end;


procedure TsTitleItem.SetSpacing(const Value: integer);
begin
  TitleButton.Spacing := Value;
end;


procedure TsTitleItem.SetTextAlignment(const Value: TAlignment);
begin
  if TitleButton <> nil then
    TitleButton.TextAlignment := Value;
end;


procedure TsTitleItem.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    if Value then begin
      TitleButton.SkinData.UpdateIndexes;
      TitleButton.Parent := FOwner.FOwner;
    end
    else
      TitleButton.Parent := nil;

    FOwner.FOwner.ArrangeTitles;
  end;
end;


procedure TsTitleItem.TitleButtonClick;
var
  l, i: integer;
  ClosedItems: array of integer;
  b: boolean;
begin
  if not (csDesigning in FOwner.FOwner.ComponentState) then begin
    if Assigned(TitleButton) and Assigned(FOnClick) then
      FOnClick(TitleButton);

    case State of
      stClosed: begin
        State := stOpening;
        if Assigned(FOwner.FOwner.FOnChanging) then begin
          b := True;
          FOwner.FOwner.FOnChanging(FOwner.FOwner, Self, b);
          if not b then begin
            State := stClosed;
            Exit;
          end;
        end;
        if not FOwner.FOwner.AllowAllOpen then
          for i := 0 to FOwner.Count - 1 do
            if FOwner[i].State = stOpened then begin
              FOwner[i].State := stClosing;
              if (i <> Index) and Assigned(FOwner[i].FOnFrameClose) then begin
                l := Length(ClosedItems);
                SetLength(ClosedItems, l + 1);
                ClosedItems[l] := i;
              end;
            end;
      end;

      stOpened: begin
        if Assigned(FOwner.FOwner.FOnChanging) then begin
          b := True;
          FOwner.FOwner.FOnChanging(FOwner.FOwner, Self, b);
          if not b then
            Exit;
        end;
        if FOwner.FOwner.AllowAllClose then begin
          FOwner[Index].State := stClosing;
          if Assigned(FOwner[Index].FOnFrameClose) then begin
            l := Length(ClosedItems);
            SetLength(ClosedItems, l + 1);
            ClosedItems[l] := Index;
          end;
        end;
      end;
    end;
    FOwner.FOwner.ArrangeTitles;
    if (State = stOpened) and Assigned(FOnFrameShow) then
      FOnFrameShow(Self);

    for i := 0 to Length(ClosedItems) - 1 do
      if (ClosedItems[i] < FOwner.Count) and Assigned(FOwner[i].FOnFrameClose) then
        FOwner[ClosedItems[i]].FOnFrameClose(FOwner[ClosedItems[i]]);
  end;
end;


procedure TsTitleButton.Ac_CMMouseEnter;
begin
  if Assigned(OnMouseEnter) then
    OnMouseEnter(Self);

  if not SkinData.FMouseAbove and not (ButtonStyle in [tbsDivider, tbsSeparator]) and not SkinData.SkinManager.Options.NoMouseHover then begin
    SkinData.FMouseAbove := True;
    SkinData.SkinManager.ActiveGraphControl := Self;
    if not FMenuOwnerMode then
      DoChangePaint(SkinData, 1, UpdateGraphic_CB, EventEnabled(aeMouseEnter, AnimatEvents), False, not Active)
    else
      SkinData.BGChanged := True;
  end;
end;


constructor TsTitleButton.Create(AOwner: TComponent);
begin
  inherited;
  Active := False;
end;


function TsTitleButton.CurrentState: integer;
begin
  if TempState >= 0 then
    Result := TempState
  else
    Result := inherited CurrentState;

  if Active and SkinData.Skinned and SkinData.SkinManager.IsValidImgIndex(SkinData.BorderIndex) then
    case Result of
      0:
        Result := iff(SkinData.SkinManager.ma[SkinData.BorderIndex].ImageCount > 3, 3, 1);

      else
        if SkinData.SkinManager.ma[SkinData.BorderIndex].ImageCount > 3 then
          Result := 3;
    end;
end;


destructor TsTitleButton.Destroy;
begin
  inherited;
  FOwner.UpdatePositions;
end;


constructor TsTitleButton.InternalCreate(AOwner: TsFrameBar; Index: integer);
var
  i: Integer;
begin
  inherited Create(AOwner);
  TempState := -1;
  FOwner := AOwner;
  SkinData.COC := COC_TsBarTitle;
  i := 0;
  repeat
    inc(i);
    if AOwner.FindComponent('sTitleButton' + IntToStr(i)) = nil then begin
      Name := 'sTitleButton' + IntToStr(i);
      break;
    end;
  until False;
  Alignment := taLeftJustify;
  Spacing := 8;
  Margin := 5;
  FOwner.UpdatePositions;
  TextAlignment := taLeftJustify;
end;


function TsTitleButton.PrepareCache: boolean;
var
  Bmp: TBitmap;
begin
  if TitleItem.State in [stClosing, stOpening] then begin // Receive new image
    Active := TitleItem.State = stOpening;
    if TitleItem.State = stOpening then
      TempState := 4
    else
      TempState := integer(SkinData.FMouseAbove);

    Result := inherited PrepareCache;
    Bmp := TBitmap.Create;
    CopyBmp(Bmp, SkinData.FCacheBmp);
    Active := TitleItem.State <> stOpening;
    TempState := -1;
  end
  else begin
    Bmp := nil;
    Result := inherited PrepareCache;
  end;
  if Bmp <> nil then begin // Mix images
    SumBitmaps(SkinData.FCacheBmp, Bmp, iff(TitleItem.State = stOpening, MaxByte - Alpha, Alpha));
    Bmp.Free;
  end;
end;

end.
