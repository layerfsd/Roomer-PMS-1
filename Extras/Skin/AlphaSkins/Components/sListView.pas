unit sListView;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Graphics, Controls, Forms, ComCtrls, ImgList, StdCtrls, Commctrl, Classes,
  {$IFNDEF DELPHI5}   types,      {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes,    {$ENDIF}
  {$IFDEF LOGGED}     sDebugMsgs, {$ENDIF}
  {$IFDEF TNTUNICODE} TntComCtrls,{$ENDIF}
  sConst, sCommonData, sMessages, acSBUtils;

{$I sDefs.inc}

type
{$IFNDEF NOTFORHELP}
  TColumnResizeEvent = procedure(sender: TCustomListview; columnIndex: Integer; columnWidth: Integer) of object;
{$ENDIF}

{$IFDEF TNTUNICODE}
  TsCustomListView = class(TTntCustomListView)
{$ELSE}
  TsCustomListView = class(TCustomListView)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FhHeaderProc,
    FhDefHeaderProc: Pointer;

    HoverColIndex,
    FPressedColumn: Integer;

    FFlag,
    Loading,
    Invalidating,
    SkipAdvancedDraw,
    FHighlightHeaders: boolean;

    FColumnResizeEvent,
    FEndColumnResizeEvent,
    FBeginColumnResizeEvent: TColumnResizeEvent;

    FOldCustomDrawItem:         TLVCustomDrawItemEvent;
    FOldAdvancedCustomDraw:     TLVAdvancedCustomDrawEvent;
    FOldAdvancedCustomDrawItem: TLVAdvancedCustomDrawItemEvent;

    FhWndHeader: HWND;
    FBoundLabel: TsBoundLabel;
    FCommonData: TsScrollWndData;
    FOnMeasureItem: TMeasureItemEvent;
    procedure CMMouseLeave  (var Message: TMessage);        message CM_MOUSELEAVE;
    procedure WMHitTest     (var Message: TMessage);        message WM_NCHITTEST;
    procedure WMParentNotify(var Message: TWMParentNotify); message WM_PARENTNOTIFY;

    procedure NewCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure UpdateCanvasColors(Active, Selected: boolean);

    procedure NewAdvancedCustomDraw       (Sender: TCustomListView; const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure NewAdvancedCustomDrawItem   (Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure NewAdvancedCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; Stage: TCustomDrawStage;
                                           var DefaultDraw: Boolean; Bmp: TBitmap); overload;
    procedure PrepareCache;
    procedure PaintHeader;
    function GetHeaderColumnRect(const Index: Integer): TRect;
    procedure ColumnSkinPaint(const ControlRect: TRect; const cIndex: Integer);
  protected
    HotItem,
    iSelectIndex: integer;

    NewStyleItems,
    StyleChanging: boolean;

    ListSW: TacScrollWnd;
{$IFNDEF D2006}
    FOnMouseLeave,
    FOnMouseEnter: TNotifyEvent;
{$ENDIF}
    procedure DoBeginColumnResize(const ColumnIndex, ColumnWidth: integer);
    procedure DoEndColumnResize  (const ColumnIndex, ColumnWidth: integer);
    procedure DoColumnResize     (const ColumnIndex, ColumnWidth: integer);

    procedure WMNotify(var msg: TWMNotify); message WM_NOTIFY;

    function FindColumnIndex(const pHeader: pNMHdr): integer;
    function FindColumnWidth(const pHeader: pNMHdr): integer;
    procedure WndProc      (var Message: TMessage); override;
    procedure HeaderWndProc(var Message: TMessage);
    function HeaderOffset: integer;
    procedure InitSkinParams;
    function AllColWidth: integer;
    function FullRepaint: boolean;
    function ItemIsHot(const Item: TListItem; const R: TRect): boolean;
    property BorderStyle;
    function MakeDragImage(Message: TMessage): HImageList;
    procedure InvalidateSmooth(const Always: boolean);
    function GetImageList: TCustomImageList;
    procedure SetViewStyle(Value: TViewStyle); {$IFDEF DELPHI7UP}override;{$ENDIF}
  public
    function ColumnLeft(const Index: integer): integer;
    constructor Create(AOwner: TComponent); override;
    procedure InitControl(const Skinned: boolean); virtual;
    destructor Destroy; override;

    procedure AfterConstruction; override;
    procedure Loaded; override;
    procedure CreateWnd; override;
    procedure SelectItem(const Index: Integer);
  published
{$ENDIF} // NOTFORHELP
{$IFDEF D2009}
    property Action;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelEdges;
    property DoubleBuffered;
    property Groups;
    property GroupView default False;
    property GroupHeaderImages;
{$ENDIF}
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
    property HighlightHeaders: boolean read FHighlightHeaders write FHighlightHeaders default True;
{$IFNDEF NOTFORHELP}
{$IFDEF D2006}
    property OnMouseEnter;
    property OnMouseLeave;
{$ELSE}
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
{$ENDIF}
{$ENDIF} // NOTFORHELP
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
{$IFDEF D2009}
    property OnItemChecked;
{$ENDIF}
    {:@event}
    property OnBeginColumnResize: TColumnResizeEvent read FBeginColumnResizeEvent write FBeginColumnResizeEvent;
    {:@event}
    property OnEndColumnResize:   TColumnResizeEvent read FEndColumnResizeEvent   write FEndColumnResizeEvent;
    {:@event}
    property OnColumnResize:      TColumnResizeEvent read FColumnResizeEvent      write FColumnResizeEvent;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsListView = class(TsCustomListView)
{$IFNDEF NOTFORHELP}
  published
    property Align;
    property AllocBy;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Checkboxes;
    property Color;
    property Columns;
    property ColumnClick;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property FullDrag;
    property GridLines;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property IconOptions;
    property Items;
    property LargeImages;
    property MultiSelect;
    property OwnerData;
    property OwnerDraw;
    property ReadOnly default False;
    property RowSelect;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property ShowWorkAreas;
    property ShowHint;
    property SmallImages;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ViewStyle;
    property Visible;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnAdvancedCustomDrawSubItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnColumnDragged;
    property OnColumnRightClick;
    property OnCompare;
    property OnContextPopup;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDblClick;
    property OnDeletion;
    property OnDrawItem;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSubItemImage;
    property OnDragDrop;
    property OnDragOver;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnStartDock;
    property OnStartDrag;
    property BoundLabel;
    property SkinData;
{$ENDIF} // NOTFORHELP
  end;


{$IFNDEF NOTFORHELP}
{$IFDEF TNTUNICODE}
  TsHackedListItems = class(TTntListItems)
{$ELSE}
  TsHackedListItems = class(TListItems)
{$ENDIF}
  public
    FNoRedraw: Boolean;
  end;
{$ENDIF} // NOTFORHELP


procedure ListViewToCSV(LV: TsListView; const FileName: string);

var
  acSmallCheckBoxes: boolean = True;

implementation

uses
  math,
  {$IFDEF DELPHI7UP}Themes, {$ENDIF}
  sStyleSimply, acntUtils, sVclUtils, sMaskData, sGraphUtils, sSkinProps, sAlphaGraph, sSkinManager, acAlphaImageList, sThirdParty;


procedure ListViewToCSV(LV: TsListView; const FileName: string);
var
  Header: array of string;
  Str: TStringList;
  ColCount: Byte;
  X, Y: Integer;
  TS: string;
begin
  ColCount := LV.Columns.Count;
  SetLength(Header, ColCount);
  for X := 0 to ColCount - 1 do
    Header[X] := TSListView(LV).Columns[X].Caption;

  Str := TStringList.Create;
  for X := High(Header) downto 0 do
    Ts := Ts + Header[X] + s_Comma;

  if Ts[Length(Ts)] = s_Comma then
    Delete (Ts, Length(TS), 1);

  Str.Add(TS);
  for X := 0 To TsListView(LV).Items.Count - 1 do begin
    TS := '';
    for Y := High(Header) downto 0 do
      if Y = 0 then
        Ts := TS + TsListView(LV).Items.Item[X].Caption + s_Comma
      else
        Ts := Ts + TsListView(LV).Items.Item[X].SubItems.Strings[Y - 1] + s_Comma;

    if Ts[Length(Ts)] = s_Comma then
      Delete(Ts, Length(TS), 1);

    Str.Add(TS);
  end;
  if Pos('.csv', LowerCase(FileName)) > 0 then
    Str.SaveToFile(FileName)
  else
    Str.SaveToFile(FileName + '.CSV');

  Str.Free;
end;


constructor TsCustomListView.Create(AOwner: TComponent);
begin
  FhWndHeader := 0;
  FhDefHeaderProc := nil;
  FPressedColumn := -1;
  HotItem := -1;
  Loading := True;
  Invalidating := False;
  FCommonData := TsScrollWndData.Create(Self, True);
  FCommonData.COC := COC_TsListView;
  inherited Create(AOwner);
  SkinData.BGChanged := True;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
  FHighlightHeaders := True;
  HoverColIndex := -2;
  NewStyleItems := True;
  StyleChanging := False;
  FOldAdvancedCustomDraw := nil;
  FOldAdvancedCustomDrawItem := nil;
  try
    FhHeaderProc := MakeObjectInstance(HeaderWndProc);
  except
    Application.HandleException(Self);
  end;
end;


destructor TsCustomListView.Destroy;
begin
  if ListSW <> nil then
    FreeAndNil(ListSW);

  SmallImages := nil;
  LargeImages := nil;
  if FhWndHeader <> 0 then
    SetWindowLong(FhWndHeader, GWL_WNDPROC, LONG_PTR(FhDefHeaderProc));

  if FhHeaderProc <> nil then
    FreeObjectInstance(FhHeaderProc);

  FreeAndNil(FBoundLabel);
  InitControl(False);
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


procedure TsCustomListView.AfterConstruction;
begin
  Loading := True;
  inherited AfterConstruction;
end;


procedure TsCustomListView.WndProc(var Message: TMessage);
var
{$IFDEF D2009}
  si: TScrollInfo;
{$ENDIF}
  R: TRect;
  SavedDC: hdc;
  li: TListItem;
  LastIndex, TopIndex, i, DstPos, Delta: integer;
  FTempItemAdvancedValue: TLVAdvancedCustomDrawItemEvent;
begin
{$IFDEF LOGGED}
//  if (Form1 <> nil) and (Form1.sPageControl1 <> nil) and Form1.sPageControl1.Visible then
    AddToLog(Message);
{$ENDIF}
{$IFNDEF D2006}
  case Message.Msg of
    CM_MOUSEENTER:
      if (Message.LParam = 0) and Assigned(FOnMouseEnter) then
        FOnMouseEnter(Self);

    CM_MOUSELEAVE:
      if (Message.LParam = 0) and Assigned(FOnMouseLeave) then
        FOnMouseLeave(Self);
  end;
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if ListSW <> nil then begin
            Items.BeginUpdate;
            FreeAndNil(ListSW);
            // ScrollBars update
            SetWindowPos(Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
            if not FCommonData.CustomColor then begin
              ListView_SetBkColor    (Handle, ColorToRGB(Color));
              ListView_SetTextBkColor(Handle, ColorToRGB(Color));
            end;
            Items.EndUpdate;
            InitControl(False);
            ListView_SetTextColor(Handle, ColorToRGB(Font.Color));
            RedrawWindow(Handle, nil, 0, RDW_NOCHILDREN);
          end;
          Exit;
        end;

      AC_SETNEWSKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          CommonWndProc(Message, FCommonData);
          InitControl(FCommonData.Skinned);
          Exit;
        end;

      AC_REFRESH:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if FCommonData.Skinned and not Loading then begin
            Items.BeginUpdate;
            InitControl(True);
            if HandleAllocated and Assigned(Ac_UninitializeFlatSB) then
              Ac_UninitializeFlatSB(Handle);

            RefreshEditScrolls(SkinData, ListSW);
            CommonWndProc(Message, FCommonData);
            if not FCommonData.CustomColor then
              Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Color;

            InitSkinParams;
            PrepareCache;
            RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);
            Items.EndUpdate;
          end;
          Exit;
        end;

      AC_ENDPARENTUPDATE:
        if not SkinData.FUpdating and FCommonData.Skinned then begin
          SkinData.PrintDC := 0;
          SkinData.FUpdating := False;
          PaintHeader;
          Exit;
        end;

      AC_PREPARING: begin
        Message.Result := LPARAM(SkinData.FUpdating);
        Exit;
      end;

      AC_BEFORESCROLL: begin
        Message.Result := 1;
        Exit;
      end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssEdit] + 1;

        Exit;
      end
    end;

  if (csCreating in ControlState) or (FCommonData = nil) or not FCommonData.Skinned then
    inherited
  else begin // <- csLoading state is damaged (enabled always)???
    case Message.Msg of
      LVM_CREATEDRAGIMAGE: begin
        Message.Result := MakeDragImage(Message);
        Exit;
      end;

      CM_UIACTIVATE: begin
        Message.Result := 1; // Forbidden a processing by ListWnd (no blinking)
        Exit;
      end;

      LVM_SETCOLUMN, LVM_INSERTCOLUMN:
        with PLVColumn(Message.LParam)^ do
          if iImage = - 1 then
            Mask := Mask and not LVCF_IMAGE;

      WM_PRINT: begin
        if (ViewStyle = vsReport) and (ListSW <> nil) then
          with ListSW do begin
            SavedDC := SaveDC(TWMPaint(Message).DC);
            MoveWindowOrg(TWMPaint(Message).DC, cxLeftEdge + HeaderOffset, cxLeftEdge);
            IntersectClipRect(TWMPaint(Message).DC, 0, 0,
                              SkinData.FCacheBmp.Width  - 2 * cxLeftEdge - integer(sBarVert.fScrollVisible) * GetScrollMetric(sBarVert, SM_SCROLLWIDTH),
                              SkinData.FCacheBmp.Height - 2 * cxLeftEdge - integer(sBarHorz.fScrollVisible) * GetScrollMetric(sBarHorz, SM_SCROLLWIDTH));
            SkinData.PrintDC := TWMPaint(Message).DC;
            HeaderWndProc(Message);
            RestoreDC(TWMPaint(Message).DC, SavedDC);
          end;

        Exit;
      end;

      WM_SETFOCUS, WM_KILLFOCUS: begin
        if IsWindowVisible(Handle) then
          ListSW.SetSkinParams;

        if Selected <> nil then
          Self.UpdateItems(Selected.Index, Selected.Index);
      end;

      WM_ERASEBKGND: begin
        if (SkinData.PrintDC <> 0) and not StyleChanging then begin
          TWMPaint(Message).DC := SkinData.PrintDC;
          inherited;
        end
        else
          if not InUpdating(FCommonData) then begin
            FTempItemAdvancedValue := NewAdvancedCustomDrawItem;
            if (addr(OnAdvancedCustomDrawItem) = addr(FTempITemAdvancedValue)) and not (ViewStyle in [vsSmallIcon, vsIcon]) then begin
              TopIndex := ListView_GetTopIndex(Handle);
              LastIndex := min(TopIndex + ListView_GetCountPerPage(Handle), Items.Count - 1);
              SavedDC := SaveDC(TWMPaint(Message).DC);
              try
                for i := TopIndex to LastIndex do
                  if ListView_GetItemRect(Handle, i, R, LVIR_BOUNDS) then
                    ExcludeClipRect(TWMPaint(Message).DC, R.Left, R.Top, R.Right, R.Bottom);

                inherited;
              finally
                RestoreDC(TWMPaint(Message).DC, SavedDC);
              end;
            end
            else
              inherited;
          end;

        Exit;
      end;

      WM_VSCROLL: begin
        UpdateScrolls(ListSW, True);
        if Message.WParamLo = SB_THUMBTRACK then begin
          if Message.LParam <> 0 then
            DstPos := Message.LParam
          else
            DstPos := Message.WParamHi;
{$IFDEF D2009}
          if GroupView and (ViewStyle = vsReport) then begin
            si.cbSize := SizeOf(TScrollInfo);
            si.fMask := SIF_ALL;
            GetScrollInfo(Handle, SB_VERT, si);
            nLastSBPos := si.nPos
          end;
{$ENDIF}
          if nLastSBPos <> DstPos then begin // If CurPos is changed
            Delta := DstPos - nLastSBPos;
            if (ViewStyle = vsReport) {$IFDEF D2009} and not GroupView {$ENDIF} then begin
              ListView_GetItemRect(Handle, 0, R, LVIR_BOUNDS);
              Delta := Delta * HeightOf(R);
            end;
            if ViewStyle in [vsIcon, vsSmallIcon, vsReport] then begin
              SendMessage(Handle, WM_SETREDRAW, 0, 0);
              ListView_Scroll(Handle, 0, Delta);
              SendMessage(Handle, WM_SETREDRAW, 1, 0);
              R := ClientRect;
              if Delta < 0 then
                R.Bottom := R.Top - Delta
              else
                R.Top := R.Bottom - Delta;

              RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
            end
            else
              ListView_Scroll(Handle, 0, Delta);
          end;
        end
        else begin
          Message.LParam := 0;
          inherited;
        end;
        Exit;
      end;

      WM_NCPAINT:
        if not IsWindowVisible(Handle) then
          Exit
        else
          if SkinData.BGChanged then
            PrepareCache;

      WM_HSCROLL:
        case Message.WParamLo of
          SB_THUMBTRACK: begin
            DstPos := iff(Message.LParam <> 0, Message.LParam, Message.WParamHi);
            Delta := DstPos - nLastSBPos;
            if ViewStyle = vsList then begin
              ListView_GetItemRect(Handle, 0, R, LVIR_BOUNDS);
              Delta := Delta * WidthOf(R);
            end;
            ListView_Scroll(Handle, Delta, 0);
            InvalidateSmooth(False);
            PaintHeader;
            Exit;
          end;

          SB_LINELEFT, SB_LINERIGHT: begin
            inherited;
            InvalidateSmooth(False);
            Exit;
          end;
        end;
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    if {Assigned(FCommonData) and }FCommonData.Skinned then
      case Message.Msg of
        WM_MOUSEMOVE:
          if Win32MajorVersion >= 6 then begin
            R.TopLeft := ScreenToClient(acMousePos);
            li := GetItemAt(R.Left, R.Top);
            if li <> nil then
              if IsValidIndex(HotItem, Items.Count) then // Repaint prev Hot Item
                if li.Index <> HotItem then begin
                  R := Items[HotItem].DisplayRect(drBounds);
                  InvalidateRect(Handle, @R, True);
                  HotItem := -1;
                end
          end;

        CM_MOUSEWHEEL, WM_MOUSEWHEEL:
          if TWMMouseWheel(Message).Keys = 0 then
            InvalidateSmooth(False);

        CN_KEYDOWN, CN_KEYUP:
          case TWMKey(Message).CharCode of
            VK_PRIOR..VK_DOWN:
              InvalidateSmooth(False)
          end;

        CM_SHOWINGCHANGED: begin
          if HandleAllocated and Assigned(Ac_UninitializeFlatSB) then
            Ac_UninitializeFlatSB(Handle);

          RefreshEditScrolls(SkinData, ListSW);
          InitSkinParams;
        end;

        WM_STYLECHANGED:
          if not (csReadingState in ControlState) then begin
            ListView_Scroll(Handle, 0, 0);
            UpdateScrolls(ListSW, True);
          end;

        LVM_DELETEITEM, LVM_REDRAWITEMS, LVM_INSERTITEMA:
          if not FCommonData.Updating then
            UpdateScrolls(ListSW, True);

        WM_NCPAINT:
          PaintHeader;

        CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_MOVE, WM_SIZE, WM_WINDOWPOSCHANGED:
          if FCommonData.Skinned and not (csDestroying in ComponentState) and IsWindowVisible(Handle) then begin
            Perform(WM_NCPAINT, 0, 0);
            Invalidating := True;
            InvalidateSmooth(True);
            Invalidating := False;
            case Message.Msg of
              WM_MOVE, WM_SIZE:
                if FullRepaint then
                  Perform(WM_NCPAINT, 0, 0) // Scrollbars repainting if transparent
            end;
          end;
      end;
  end;

  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);

  case Message.Msg of
    CN_MEASUREITEM, WM_MEASUREITEM:
      if Assigned(FOnMeasureItem) and (ViewStyle = vsReport) then
        with TWMMeasureItem(Message).MeasureItemStruct^ do begin
          i := itemHeight;
          FOnMeasureItem(TListView(Self), integer(itemID), i);
          itemHeight := i;
          Message.Result := 1;
        end;
  end;
end;


procedure TsCustomListView.Loaded;
begin
  Loading := True;
  inherited Loaded;
  Loading := False;
end;


function TsCustomListView.MakeDragImage(Message: TMessage): HImageList;
var
  Bmp: TBitmap;
  Ico: HIcon;
  R: TRect;
begin
  ListView_GetItemRect(Handle, Message.WParam, R, LVIR_BOUNDS);
  Result := ImageList_Create(WidthOf(R), HeightOf(R), ILC_COLOR32 or ILC_MASK, 0, 1);
  Bmp := CreateBmp32(R);
  BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Canvas.Handle, R.Left, R.Top, SRCCOPY);
  FillAlphaRect(Bmp, MkRect(Bmp), $FF, $FFFFFF);
  if IsNTFamily then
    try
      Ico := MakeCompIcon(Bmp, ColorToRGB(TColor(ImageList_GetBkColor(Result))));
    except
      Ico := 0;
    end
  else
    Ico := MakeIcon32(Bmp);

  Bmp.Free;
  ImageList_SetBkColor(Result, clNone);
  ImageList_AddIcon(Result, Ico);
end;


procedure TsCustomListView.CMMouseLeave(var Message: TMessage);
var
  p: TPoint;
  r: TRect;
begin
  if FCommonData.Skinned and (ViewStyle = vsReport) then begin
    p := ClientToScreen(Point(Left, Top));
    r := Rect(p.x, p.y, p.x + Width, p.y + Height);
    if not PtInRect(r, acMousePos) then
      inherited;

    if (HoverColIndex >= 0) or (FPressedColumn >= 0) then begin
      HoverColIndex := -2;
      FPressedColumn := -1;
      PaintHeader;
    end;
  end;
  inherited;
end;


function TsCustomListView.HeaderOffset: integer;
begin
  Result := integer(BorderStyle <> bsNone);
end;


procedure TsCustomListView.HeaderWndProc(var Message: TMessage);
var
  Info: THDHitTestInfo;
  CurIndex, w: integer;

  function MouseToColIndex(p: TSmallPoint): integer;
  var
    ltPoint: TPoint;
    i: integer;
    rc: TRect;
  begin
    if Assigned(ListSW) and Assigned(ListSW.sBarHorz) then
      w := ListSW.sBarHorz.ScrollInfo.nPos
    else
      w := 0;

    ltPoint := ScreenToClient(Point(p.x + w, p.y));
    Result := -2;
    for i := 0 to Header_GetItemCount(FhWndHeader) - 1 do begin
      rc := GetHeaderColumnRect(i);
      if PtInRect(rc, ltPoint) then begin
        Result := Header_OrderToIndex(FhWndHeader, i);
        Exit;
      end;
    end;
  end;
  
begin
  if (ViewStyle = vsReport) and Assigned(FCommonData) and FCommonData.Skinned then
    try
      with Message do begin
        case Msg of
          SM_ALPHACMD:
            case Message.WParamHi of
              AC_MOUSELEAVE: begin
                HoverColIndex := -2;
                PaintHeader;
                if not acMouseInControl(Self) then
                  Perform(CM_MOUSELEAVE, 0, 0);

                Exit;
              end;
            end;

          WM_NCHITTEST:
            if ColumnClick then begin
              Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
              if FCommonData.Skinned and FHighLightHeaders then begin
                CurIndex := MouseToColIndex(TWMNCHitTest(Message).Pos);
                if HoverColIndex <> CurIndex then begin
                  HoverColIndex := CurIndex;
                  FCommonData.SkinManager.ActiveControl := FhWndHeader;
                  PaintHeader;
                end;
              end;
            end;

          WM_LBUTTONUP:
            if ColumnClick then begin
              FPressedColumn := -1;
              FFlag := False;
            end;

          WM_PRINT:
            PaintHeader;

          WM_PAINT:
            if FCommonData.Skinned then begin
              PaintHeader;
              Exit;
            end;

          WM_ERASEBKGND:
            Exit;

          WM_NCDESTROY: begin
            Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
            FhWndHeader := 0;
            FhDefHeaderProc := nil;
            Exit;
          end;

          WM_WINDOWPOSCHANGING: begin
            if Assigned(ListSW) and Assigned(ListSW.sBarHorz) then
              w := ListSW.sBarHorz.ScrollInfo.nPos
            else
              w := 0;

            TWMWindowPosChanging(Message).WindowPos^.X := HeaderOffset - w;
          end;
        end;
        Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
        case Msg of
          WM_LBUTTONDOWN:
            if ColumnClick then begin
              FFlag := True;
              Info.Point := Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos);
              SendMessage(FhWndHeader, HDM_HITTEST, 0, Integer(@Info));
              if (Info.Flags and HHT_ONDIVIDER = 0) and (Info.Flags and HHT_ONDIVOPEN = 0) then
                FPressedColumn := Info.Item
              else
                FPressedColumn := -1;

              RedrawWindow(FhWndHeader, nil, 0, RDW_INVALIDATE);
            end;

          WM_MOUSEMOVE:
            if FFlag then
              UpdateScrolls(ListSW, True)
        end;
      end;
    except
      Application.HandleException(Self);
    end
  else
    with Message do
      Result := CallWindowProc(FhDefHeaderProc, FhWndHeader, Msg, WParam, LParam);
end;


procedure TsCustomListView.WMParentNotify(var Message: TWMParentNotify);
var
  WndName: string;
begin
  with Message do
    try
      SetLength(WndName, 96);
      SetLength(WndName, GetClassName(ChildWnd, PChar(WndName), Length(WndName)));
      if (WndName = WC_HEADER) and (Event in [WM_CREATE, WM_DESTROY]) then begin
        if FhWndHeader <> 0 then begin
          SetWindowLong(FhWndHeader, GWL_WNDPROC, LONG_PTR(FhDefHeaderProc));
          FhWndHeader := 0;
        end;
        if FhWndHeader = 0 then begin
          FhWndHeader := ChildWnd;
          FhDefHeaderProc := Pointer(GetWindowLong(FhWndHeader, GWL_WNDPROC));
          SetWindowLong(FhWndHeader, GWL_WNDPROC, LONG_PTR(FhHeaderProc));
        end;
      end;
  except
    Application.HandleException(Self);
  end;
  inherited;
end;


procedure TsCustomListView.PaintHeader;
var
  i, Index, Count, RightPos: Integer;
  rc, HeaderR: TRect;
  PS: TPaintStruct;
begin
  BeginPaint(FhWndHeader, PS);
  try
    if not FCommonData.FCacheBmp.Empty and not StyleChanging then begin
      RightPos := 0;
      Count := Header_GetItemCount(FhWndHeader) - 1;
      if Count >= 0 then
        // Draw Columns Headers
        for i := 0 to Count do begin
          rc := GetHeaderColumnRect(i);
          if not IsRectEmpty(rc) then begin
            Index := Header_OrderToIndex(FhWndHeader, i);
            ColumnSkinPaint(rc, Index);
          end;
          if RightPos < rc.Right then
            RightPos := rc.Right;
        end
      else
        rc := GetHeaderColumnRect(0);
      // Draw background section
      if Windows.GetWindowRect(FhWndHeader, HeaderR) then begin
        rc := Rect(RightPos, 0, WidthOf(HeaderR), HeightOf(HeaderR));
        if not IsRectEmpty(rc) then
          ColumnSkinPaint(rc, -1);
      end;
    end;
  finally
    EndPaint(FhWndHeader, PS);
  end;
end;


function TsCustomListView.GetHeaderColumnRect(const Index: Integer): TRect;
var
  SectionOrder: array of Integer;
  rc: TRect;
begin
  if FhWndHeader <> 0 then begin
    if {Self.FullDrag and} (Columns.Count > 0) then begin
      SetLength(SectionOrder, Columns.Count);
      Header_GetOrderArray(FhWndHeader, Columns.Count, PInteger(SectionOrder));
      Header_GETITEMRECT(FhWndHeader, SectionOrder[Index] , @rc);
    end
    else
      Header_GETITEMRECT(FhWndHeader, Index, @rc);

    Result := rc;
  end
  else
    Result := MkRect;
end;


procedure TsCustomListView.ColumnSkinPaint(const ControlRect: TRect; const cIndex: Integer);
const
  HDF_SORTDOWN = $0200;
  HDF_SORTUP   = $0400;
var
  C: TColor;
  tmpdc: HDC;
  ws: acString;
  CI: TCacheInfo;
  ArrowSide: TacSide;
  R, gR, TextRC: TRect;
  ts, ArrowSize: TSize;
  TempBmp: Graphics.TBitmap;
  Buf: array [0..128] of acChar;
  gWidth, ArrowIndex, Flags, State, si, rWidth: integer;
  Item: {$IFDEF TNTUNICODE}THDItemW{$ELSE}THDItem{$ENDIF};
begin
  try
    TempBmp := CreateBmp32(ControlRect);
    R := MkRect(TempBmp);
    if FPressedColumn >= 0 then
      State := iff(FPressedColumn = cIndex, 2, 0)
    else
      State := integer(HoverColIndex = cIndex);

    CI.Ready := False;
    CI.FillColor := Color;
    si := PaintSection(TempBmp, SkinData.SkinManager.ConstData.Sections[ssColHeader], SkinData.SkinManager.ConstData.Sections[ssButton], State, SkinData.SkinManager, ControlRect.TopLeft, CI.FillColor);
    TempBmp.Canvas.Font.Assign(Font);
    TextRC := R;
    InflateRect(TextRC, -4, -1);
    TempBmp.Canvas.Brush.Style := bsClear;
    FillChar(Item, SizeOf(Item), 0);
    FillChar(Buf, SizeOf(Buf), 0);
    Item.pszText := PacChar(@Buf);
    Item.cchTextMax := SizeOf(Buf);
    Item.Mask := HDI_TEXT or HDI_FORMAT or HDI_IMAGE or HDI_BITMAP;
    if (cIndex >= 0) and bool(SendMessage(FHwndHeader, {$IFDEF TNTUNICODE}HDM_GETITEMW{$ELSE}HDM_GETITEM{$ENDIF}, cIndex, LPARAM(@Item))) then begin
      ws := acString(Item.pszText);
      Flags := DT_END_ELLIPSIS or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER;
      if (SmallImages = nil) or (Item.fmt and (LVCFMT_IMAGE or LVCFMT_COL_HAS_IMAGES) = 0) then begin
        Item.iImage := -1;
        gWidth := 0;
      end
      else
        gWidth := SmallImages.Width + 4;

      if item.fmt and HDF_SORTDOWN <> 0 then begin
        ArrowSide := asBottom;
        ArrowIndex := SkinData.SkinManager.ConstData.ScrollBtns[asBottom].GlyphIndex;
      end
      else
        if item.fmt and HDF_SORTUP <> 0 then begin
          ArrowSide := asTop;
          ArrowIndex := SkinData.SkinManager.ConstData.ScrollBtns[asTop].GlyphIndex;
        end
        else begin
          ArrowSide := asLeft;
          ArrowIndex := -2;
        end;

      if ArrowIndex <> -2 then
        if ArrowIndex >= 0 then
          ArrowSize := MkSize(SkinData.SkinManager.ma[ArrowIndex].Width + 6, SkinData.SkinManager.ma[ArrowIndex].Height)
        else
          ArrowSize := MkSize(6, 3)
      else
        ArrowSize := MkSize;

      {$IFDEF TNTUNICODE}GetTextExtentPoint32W{$ELSE}GetTextExtentPoint32{$ENDIF}(TempBmp.Canvas.Handle, PacChar(ws), Length(ws), ts);
      inc(ts.cx, 6);
      rWidth := WidthOf(ControlRect, True) - 6;
      case Item.fmt and $0ff of
        HDF_CENTER:
          if ts.cx + gWidth + ArrowSize.cx + 6 >= rWidth then begin
            TextRc.Left := gWidth + 6;
            TextRc.Right := TextRc.Right - ArrowSize.cx;
          end
          else begin
            TextRc.Left := (WidthOf(TextRc) - ts.cx - ArrowSize.cx - gWidth) div 2 + TextRc.Left + gWidth;
            TextRc.Right := TextRc.Left + ts.cx;
          end;

        HDF_RIGHT: begin
          TextRc.Right := TextRc.Right - ArrowSize.cx;
          if ts.cx + gWidth + ArrowSize.cx + 6 >= rWidth then
            TextRc.Left := gWidth + 6
          else
            TextRc.Left := TextRc.Right - ts.cx;
        end

        else begin
          TextRc.Left := TextRc.Left + gWidth;
          TextRc.Right := min(rWidth, TextRc.Left + ts.cx);
        end
      end;
      if ArrowIndex >= 0 then
        DrawSkinGlyph(TempBmp, Point(TextRc.Right + 6, (HeightOf(TextRc) - ArrowSize.cy) div 2), State, 1, SkinData.SkinManager.ma[ArrowIndex], MakeCacheInfo(TempBmp))
      else
        if (ArrowIndex < 0) and (ArrowSide <> asLeft) then begin
          gR.Left := TextRc.Right + 6;
          gR.Top := (HeightOf(TextRc) - ArrowSize.cy) div 2;
          gR.Right := gR.Left + 6;
          gR.Bottom := gR.Top + 3;
          C := SkinData.SkinManager.gd[si].Props[min(State, ac_MaxPropsIndex)].FontColor.Color;
          DrawColorArrow(TempBmp, C, gR, ArrowSide);
        end;

      if State = 2 then
        OffsetRect(TextRc, 1, 1);

      if UseRightToLeftReading then
        Flags := Flags or DT_RTLREADING;

      acWriteTextEx(TempBmp.Canvas, PacChar(ws), True, TextRc, Flags, si, State <> 0, SkinData.SkinManager);
      if item.iImage >= 0 then
        if (SmallImages is TsAlphaImageList) and SkinData.SkinManager.Effects.DiscoloredGlyphs then begin
          if State = 0 then
            if si >= 0 then
              C := FCommonData.SkinManager.gd[si].Props[0].Color
            else
              C := clBtnFace
          else
            C := clNone;

          DrawAlphaImgList(SmallImages, TempBmp, TextRc.Left - gWidth, (HeightOf(TextRc) - SmallImages.Height) div 2 + integer(State = 2),
                           Item.iImage, 0, C, 0, 1, False)
        end
        else
          SmallImages.Draw(TempBmp.Canvas,
                           TextRc.Left - gWidth, (HeightOf(TextRc) - SmallImages.Height) div 2 + integer(State = 2),
                           Item.iImage, Enabled);
    end;

    if SkinData.PrintDC = 0 then
      tmpdc := GetDC(FhWndHeader)
    else
      tmpdc := SkinData.PrintDC;

    try
      BitBlt(tmpdc, ControlRect.Left, ControlRect.Top, R.Right, R.Bottom, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      if SkinData.PrintDC = 0 then
        ReleaseDC(FhWndHeader, tmpdc);
    end;
    FreeAndNil(TempBmp);
  except
    Application.HandleException(Self);
  end;
end;


procedure TsCustomListView.PrepareCache;
begin
  InitCacheBmp(SkinData);
  PaintItem(FCommonData, GetParentCache(FCommonData), False, 0, MkRect(Self), Point(Left, Top), FCommonData.FCacheBmp, True);
  FCommonData.BGChanged := False;
end;


procedure TsCustomListView.WMHitTest(var Message: TMessage);
begin
  inherited;
  if FCommonData.Skinned and (HoverColIndex >= 0) and FHighLightHeaders then begin
    HoverColIndex := -2;
    PaintHeader;
  end;
end;


function TsCustomListView.AllColWidth: integer;
var
  i, w, c: integer;
begin
  Result := 0;
  c := Columns.Count - 1;
  for i := 0 to c do begin
    w := integer(ListView_GetColumnWidth(Handle, i));
    if abs(w) > 999999 then
      Exit;

    Result := integer(Result + w);
  end
end;


procedure TsCustomListView.NewAdvancedCustomDraw(Sender: TCustomListView; const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  R: TRect;
  SavedDC: hdc;
  i, TopIndex, LastIndex: integer;
begin
  if not (csDesigning in ComponentState) and Assigned(FOldAdvancedCustomDraw) then
    FOldAdvancedCustomDraw(Sender, Arect, Stage, DefaultDraw)
  else begin
    DefaultDraw := False;
    if not StyleChanging and not (Stage in [cdPostErase, cdPostPaint]) then begin
      if Stage in [cdPreErase, cdPrePaint] then begin
        DefaultDraw := True;
        if SkinData.Skinned then begin
          if InUpdating(FCommonData) then
            Exit;

          if SkinData.BGChanged then
            PrepareCache;
        end;
        if FullRepaint then begin
          SavedDC := SaveDC(Canvas.Handle);
          if (Stage in [cdPrePaint]) and Invalidating then begin
            if not (ViewStyle in [vsSmallIcon, vsIcon]) then
              TopIndex := ListView_GetTopIndex(Handle)
            else
              TopIndex := 0;

            if ViewStyle in [vsReport, vsList] then
              LastIndex := TopIndex + ListView_GetCountPerPage(Handle) -1
            else
              LastIndex := Items.Count - 1;

            for i := TopIndex to LastIndex do begin
              if ListView_GetItemRect(Handle, i, R, LVIR_ICON) then
                ExcludeClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);

              if ListView_GetItemRect(Handle, i, R, LVIR_LABEL) then
                ExcludeClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);
            end;
          end;
          BitBlt(Canvas.Handle, 0, 0, ClientWidth, ClientHeight, FCommonData.FCacheBmp.Canvas.Handle,
                 integer(BorderStyle = bsSingle) * 2, integer(BorderStyle = bsSingle) * 2, SRCCOPY);
          RestoreDC(Canvas.Handle, SavedDC);
          if (Stage in [cdPrePaint]) and not SkinData.CustomColor then begin
            // Ensure that the items are drawn transparently
            SetBkMode(Canvas.Handle, TRANSPARENT);
            ListView_SetTextBkColor(Handle, CLR_NONE);
            ListView_SetBKColor    (Handle, CLR_NONE);
          end;
        end;
        if Stage = cdPreErase then
          DefaultDraw := False
      end;
    end
    else
      if Stage = cdPostErase then
        DefaultDraw := False;
  end
end;


function TsCustomListView.FullRepaint: boolean;
begin
  Result := False;
end;


procedure TsCustomListView.InvalidateSmooth(const Always: boolean);
begin
  if FullRepaint then
    if Always then
      InvalidateRect(Handle, nil, False)
    else
      case ViewStyle of
        vsList:
          with ListSW.sBarHorz.ScrollInfo do
            if (nPos < nMax - 1) and (nPos > nMin) then
              InvalidateRect(Handle, nil, False);

        vsReport: begin
          GetScrollInfo(Handle, SB_VERT, ListSW.sBarVert.ScrollInfo);
          with ListSW.sBarVert.ScrollInfo do
            if (nPos < nMax - Font.Size - 3) and (nPos > nMin) then
              InvalidateRect(Handle, nil, False);
        end;
      end;
end;


procedure TsCustomListView.SelectItem(const Index: Integer);
begin
  if IsValidIndex(Index, Items.Count) then begin
    TListItem(Items[Index]).Selected := True;
    TListItem(Items[Index]).Focused := True;
    SendMessage(Handle, LVM_ENSUREVISIBLE, Index, 0);
  end;
end;


procedure TsCustomListView.SetViewStyle(Value: TViewStyle);
begin
  if not StyleChanging then
    if HandleAllocated then begin
      StyleChanging := True;
      SkinData.BeginUpdate;
      inherited;
      StyleChanging := False;
      ListView_Arrange(Handle, LVA_DEFAULT);
      SkinData.EndUpdate;
      if SkinData.Skinned then begin
        RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ERASE);
        if ViewStyle = vsReport then
          PaintHeader;
      end;
    end
    else
      inherited;
end;


procedure TsCustomListView.UpdateCanvasColors(Active, Selected: boolean);
begin
  if (SkinData.SkinManager <> nil) and SkinData.SkinManager.CommonSkinData.Active then begin
    if Selected then
      Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(SkinData.FFocused or Active)
    else
      if SkinData.CustomFont then
        Canvas.Font.Color := Font.Color
      else
        Canvas.Font.Color := ColorToRGB(SkinData.SkinManager.gd[SkinData.SkinIndex].Props[integer(SkinData.FFocused or Active)].FontColor.Color);

    if SkinData.CustomColor then
      Canvas.Brush.Color := Color
    else
      Canvas.Brush.Color := ColorToRGB(SkinData.SkinManager.gd[SkinData.SkinIndex].Props[integer(SkinData.FFocused or Active)].Color);
  end;
end;


procedure TsCustomListView.InitControl(const Skinned: boolean);
var
  FTempValue:             TLVAdvancedCustomDrawEvent;
  FTempItemValue:         TLVCustomDrawItemEvent;
  FTempItemAdvancedValue: TLVAdvancedCustomDrawItemEvent;
begin
  if not (csDesigning in ComponentState) then
    if Skinned then begin
      if Assigned(OnAdvancedCustomDraw) then begin
        FTempValue := NewAdvancedCustomDraw;
        if not Assigned(FOldAdvancedCustomDraw) and (addr(OnAdvancedCustomDraw) <> addr(FTempValue)) then
          FOldAdvancedCustomDraw := OnAdvancedCustomDraw;
      end
      else
        FOldAdvancedCustomDraw := nil;

      OnAdvancedCustomDraw := NewAdvancedCustomDraw;

      if not Assigned(OnDrawItem) then begin
        if Assigned(OnAdvancedCustomDrawItem) then begin
          FTempItemAdvancedValue := NewAdvancedCustomDrawItem;
          if not Assigned(FOldAdvancedCustomDrawItem) and (addr(OnAdvancedCustomDrawItem) <> addr(FTempITemAdvancedValue)) then
            FOldAdvancedCustomDrawItem := OnAdvancedCustomDrawItem;
        end
        else
          FOldAdvancedCustomDrawItem := nil;

        OnAdvancedCustomDrawItem := NewAdvancedCustomDrawItem;

        if Assigned(OnCustomDrawItem) then begin
          FTempItemValue := NewCustomDrawItem;
          if not Assigned(FOldCustomDrawItem) and (addr(OnCustomDrawItem) <> addr(FTempITemValue)) then
            FOldCustomDrawItem := OnCustomDrawItem;
        end
        else
          FOldCustomDrawItem := nil;

        OnCustomDrawItem := NewCustomDrawItem;
      end;
    end
    else begin
      if Assigned(FOldAdvancedCustomDraw) then begin
        OnAdvancedCustomDraw := FOldAdvancedCustomDraw;
        FOldAdvancedCustomDraw := nil;
      end
      else begin
        FTempValue := NewAdvancedCustomDraw;
        if addr(OnAdvancedCustomDraw) = addr(FTempValue) then
          OnAdvancedCustomDraw := nil;
      end;

      if not Assigned(OnDrawItem) then begin
        if Assigned(FOldAdvancedCustomDrawItem) then begin
          OnAdvancedCustomDrawItem := FOldAdvancedCustomDrawItem;
          FOldAdvancedCustomDrawItem := nil;
        end
        else begin
          FTempItemAdvancedValue := NewAdvancedCustomDrawItem;
          if addr(OnAdvancedCustomDrawItem) = addr(FTempItemAdvancedValue) then
            OnAdvancedCustomDrawItem := nil;
        end;
        if Assigned(FOldCustomDrawItem) then begin
          OnCustomDrawItem := FOldCustomDrawItem;
          FOldCustomDrawItem := nil;
        end
        else begin
          FTempItemValue := NewCustomDrawItem;
          if addr(OnCustomDrawItem) = addr(FTempItemValue) then
            OnCustomDrawItem := nil;
        end;
      end;
    end;
end;


procedure TsCustomListView.CreateWnd;
var
  Wnd: Hwnd;
begin
  inherited;
  try
    FCommonData.Loaded(False);
    if HandleAllocated then
      RefreshEditScrolls(SkinData, ListSW);
  except
    Application.HandleException(Self);
  end;
  if FCommonData.Skinned then begin
    if not FCommonData.CustomColor then
      Color := FCommonData.SkinManager.gd[FCommonData.SkinIndex].Props[0].Color;

    InitControl(True);
  end;
{$IFDEF DELPHI7UP}
  {$IFNDEF D2010}
  if NewStyleItems and ThemeServices.ThemesEnabled and (Win32MajorVersion >= 6) then
    Ac_SetWindowTheme(Handle, 'explorer', nil); // do not localize
  {$ENDIF}
{$ENDIF}
  Wnd := GetWindow(Handle, GW_CHILD);
  SetWindowLong(Wnd, GWL_STYLE, GetWindowLong(Wnd, GWL_STYLE) and not HDS_FULLDRAG);
end;


function EllipsifyEnd(DC: hDC; const sText: acString; Width, Height: integer; dwFlags: Cardinal): acstring;
var
  rct: TRect;
  len_str: integer;
  i: integer;
  sTemp: string;
begin
  Result := sText;
  if sText <> '' then begin
    rct := MkRect(0, Width);
    acDrawText(DC, PacChar(sText), rct, dwFlags or DT_CALCRECT);
    if rct.Bottom > Height then begin
      len_str := Length(sText);
      Result := sText;
      for i := len_str downto 1 do begin
        Delete(Result, i, 1);
        sTemp := Result + s_Ellipsis;
        rct.Right := Width;
        rct.Bottom := 0;
        acDrawText(DC, PacChar(sTemp), rct, dwFlags or DT_CALCRECT);
        if rct.Bottom <= Height then begin
          Result := Result + s_Ellipsis;
          Exit;
        end
      end;
      Result := s_Ellipsis;
    end;
  end;
end;


procedure TsCustomListView.NewAdvancedCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  SectionOrder: array of Integer;
  ImgLst: HIMAGELIST;
  Bmp: TBitmap;
  ACanvas: TCanvas;
  rState, fText, aRect, cRect, iRect, CellRect: TRect;
  ActNdx, ColNdx, cw, sNdx, ColLeft, ColWidth: integer;
  vStyle: TViewStyle;
  CI: TCacheInfo;
  Size: TSize;
  DrawStyle: Cardinal;
  ImgList: TCustomImageList;
  b, bSelected, bHot: boolean;
  CheckState: TCheckBoxState;
  iDrawStyle: TDrawingStyle;

  function GetColumnIndex: integer;
  var
    i: integer;
  begin
    Result := 0;
    if Columns.Count > 0 then begin
      SetLength(SectionOrder, Columns.Count);
      Header_GetOrderArray(FhWndHeader, Columns.Count, PInteger(SectionOrder));
      for i := 0 to Columns.Count - 1 do
        if SectionOrder[i] = 0 then begin
          Result := i;
          Exit;
        end;
    end;
  end;


  procedure InitRects(var aImage, aCheck, aText, aSelect, aState: TRect);
  var
    cw, cx, cy, h: integer;
  begin
    aSelect := Item.DisplayRect(drSelectBounds);
    h := HeightOf(aSelect);
    OffsetRect(aSelect, -iRect.Left, -iRect.Top);
    if vStyle <> vsReport then begin
      aText := Item.DisplayRect(drLabel);
      OffsetRect(aText, -iRect.Left, -iRect.Top);
      InflateRect(aText, 1, 1);
      rState.Right := rState.Left;

      if CheckBoxes then
        cw := CheckWidth(SkinData.SkinManager, acSmallCheckBoxes) + 2
      else
        cw := 0;

      if Item.ImageIndex >= 0 then begin
        if ImgList <> nil then begin
          cx := ImgList.Width;
          cy := ImgList.Height;
        end
        else begin
          if vStyle = vsIcon then
            ImgLst := ListView_GetImageList(Handle, LVSIL_NORMAL)
          else
            ImgLst := ListView_GetImageList(Handle, LVSIL_SMALL);

          if ImgLst <> 0 then
            ImageList_GetIconSize(ImgLst, cx, cy)
          else
            cx := 0;
        end;

        if (cx <> 0) and ListView_GetItemRect(Handle, Item.Index, aImage, LVIR_ICON) and not IsRectEmpty(aImage) then begin
          if Win32MajorVersion > 5 then // if Vista or newer
            if vStyle in [vsList, vsReport] then
              aImage.Left := aImage.Left + (WidthOf(aImage) - cx) div 2
            else
              aImage.Left := aImage.Left + (WidthOf(aImage) - cx - cw) div 2 + cw
          else
            aImage.Left := aImage.Left + (WidthOf(aImage) - cx) div 2;

          if vStyle <> vsIcon then
            aImage.Top := aImage.Top + (Bmp.Height - cy) div 2;

          OffsetRect(aImage, -iRect.Left, -iRect.Top);
        end
        else
          aImage.Right := aImage.Left;
      end
      else
        aImage.Right := aImage.Left;

      if CheckBoxes then begin
        if vStyle = vsIcon then
          if aImage.Right <> aImage.Left then begin
            aCheck := Item.DisplayRect(drIcon);
            if Win32MajorVersion > 5 then begin // if Vista and newer
              aCheck.Left := aCheck.Left + (WidthOf(aCheck) - LargeImages.Width - cw) div 2 - iRect.Left;
              aCheck.Top := iRect.Top + aImage.Top + (ImgList.Height - cw) div 2 - iRect.Top;
            end
            else begin
              aCheck.Left := aCheck.Left + (WidthOf(aCheck) - LargeImages.Width) div 2 - cw - 2 - iRect.Left;
              aCheck.Top := aCheck.Bottom - cw - iRect.Top;
            end;
          end
          else begin
            if Win32MajorVersion > 5 then // if Vista and newer
              aCheck.Top := 2
            else
              aCheck.Top := Item.DisplayRect(drLabel).Top - cw - 6;

            aCheck.Left := (WidthOf(iRect) - cw - 2) div 2;
          end
        else begin
          aCheck.Top := 0;
          aCheck.Left := (19 - cw) div 2// 3
        end;
        aCheck.Bottom := aCheck.Top + cw;
        aCheck.Right := aCheck.Left + cw;
      end;
    end
    else begin
      if CheckBoxes then begin
        cw := CheckWidth(SkinData.SkinManager, acSmallCheckBoxes) + 2;
        aCheck.Left   := ColLeft + (19 - cw) div 2 - iRect.Left;
        aCheck.Right  := aCheck.Left + cw;
        aCheck.Top    := 0;
        aCheck.Bottom := HeightOf(iRect);
      end
      else begin
        aCheck.Left := ColLeft - iRect.Left;
        aCheck.Right := aCheck.Left;
      end;

      if (StateImages <> nil) and IsValidIndex(Item.StateIndex, GetImageCount(StateImages)) then begin
        aState.Top := (h - StateImages.Height) div 2;
        aState.Bottom := aState.Top + StateImages.Height;
        aState.Left := aCheck.Right;
        aState.Right := aState.Left + StateImages.Width;
      end
      else begin
        aState := aCheck;
        aState.Left := aState.Right;
      end;
      if CheckBoxes then
        inc(aState.Left, 2);

      if SmallImages <> nil then begin
        cx := ImgList.Width;
        cy := ImgList.Height;
        aImage.Top := (h - cy) div 2;
      end
      else begin
        if vStyle = vsIcon then
          ImgLst := ListView_GetImageList(Handle, LVSIL_NORMAL)
        else
          ImgLst := ListView_GetImageList(Handle, LVSIL_SMALL);

        if ImgLst <> 0 then begin
          aImage := Item.DisplayRect(drIcon);
          ImageList_GetIconSize(ImgLst, cx, cy);
        end
        else
          cx := 0;

        aImage.Top := (HeightOf(aImage) - cy) div 2;
      end;

      aImage.Left  := aState.Right;
      if aState.Left <> aState.Right then
        inc(aImage.Left, 2);

      if (cx > 0) {and Between(Item.ImageIndex, 0, c - 1) }then begin
        aImage.Right := aImage.Left + cx;
        aImage.Bottom := aImage.Top + cy;
      end
      else
        aImage.Right := rState.Right;

      aText.Left := aImage.Right + 1;
      if GetCapture = FhWndHeader then // If columns is in resizing
        aText.Right := ColLeft + ColWidth - 2
      else
        if ColWidth <> -1 then
          aText.Right := ColLeft + ColWidth
        else
          aText.Right := iRect.Right;

      aText.Top := 0;
      aText.Bottom := HeightOf(iRect);
      aSelect.Left := ColLeft;
    end;
  end;


  procedure PaintThisRow;
  var
    i: integer;
    rImage, rCheck, rText, rSelect: TRect;
  begin
    DrawStyle := DrawStyle or DT_END_ELLIPSIS;
    InitRects(rImage, rCheck, rText, rSelect, rState);
    aRect := MkRect(Bmp.Width - integer(GridLines), Bmp.Height - integer(GridLines));
    if bSelected then
      if sNdx < 0 then
        FillDC(Bmp.Canvas.Handle, aRect, Canvas.Brush.Color)
      else begin
        PaintItem(sNdx, CI, True, integer(Focused or (cdsFocused in State)), aRect, Point(iRect.Left, iRect.Top), Bmp, SkinData.SkinManager);
        if bHot then begin
          fText := iRect;
          if BorderStyle <> bsNone then
            OffsetRect(fText, 2, 2);

          BlendTransRectangle(Bmp, 0, 0, FCommonData.FCacheBmp, fText, 128);
        end;
      end
    else
      FillDC(ACanvas.Handle, aRect, Canvas.Brush.Color);

    ACanvas.Brush.Style := bsClear; // Text will be drawn later
    ACanvas.Brush.Color := Canvas.Brush.Color;
    SetBkMode(ACanvas.Handle, TRANSPARENT);

    if StateImages <> nil then begin
      if IsValidIndex(Item.StateIndex, GetImageCount(StateImages)) then begin
        fText.Left := 2;
        cw := StateImages.Width + 2;
        fText.Right := fText.Left + cw;
        fText.Top := iRect.Top;
        fText.Bottom := iRect.Bottom;

        CI.X := fText.Left;
        CI.Y := fText.Top;
        if Bmp <> nil then begin
          if not bSelected then
            FillDC(Bmp.Canvas.Handle, fText, Canvas.Brush.Color);

          if Item.StateIndex >= 0 then
            StateImages.Draw(Bmp.Canvas, rState.Left + 2, (Bmp.Height - StateImages.Height) div 2, Item.StateIndex, True);
        end
        else
          if Item.StateIndex >= 0 then begin
            Bmp := CreateBmp32(cw, fText.Bottom - fText.Top);
            FillDC(Bmp.Canvas.Handle, MkRect(Bmp), Canvas.Brush.Color);
            StateImages.Draw(Bmp.Canvas, 0, 0, Item.StateIndex, True);
            BitBlt(Canvas.Handle, fText.Left, fText.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
            FreeAndNil(Bmp);
          end;
      end;
    end
    else
      if CheckBoxes then begin
        CheckState := sConst.CheckBoxStates[integer(Item.Checked)];
        CI.X := rCheck.Left;
        CI.Y := rCheck.Top;
        if not bSelected then
          FillDC(Bmp.Canvas.Handle, rCheck, Canvas.Brush.Color)
        else
          CI := MakeCacheInfo(Bmp);

        acDrawCheck(rCheck, CheckState, True, Bmp, CI, SkinData.SkinManager, acSmallCheckBoxes);
      end;

    // Glyph
    if (SmallImages <> nil) and (rImage.Left <> rImage.Right) then
      SmallImages.Draw(ACanvas, rImage.Left, rImage.Top, Item.ImageIndex, {$IFDEF DELPHI6UP}dsNormal, itImage{$ELSE}True{$ENDIF});

    if rText.Right > rText.Left then begin
      inc(rText.Left);
      if (sNdx < 0) or (SkinData.CustomFont) then
        if SkinData.CustomFont then
          AcDrawText(ACanvas.Handle, {$IFDEF TNTUNICODE}TTntListItem{$ENDIF}(Item).Caption, rText, DrawStyle)
        else begin
          SetTextColor(ACanvas.Handle, ColorToRGB(ACanvas.Font.Color));
          AcDrawText(ACanvas.Handle, {$IFDEF TNTUNICODE}TTntListItem{$ENDIF}(Item).Caption, rText, DrawStyle);
        end
      else
        acWriteTextEx(ACanvas, PacChar({$IFDEF TNTUNICODE}TTntListItem{$ENDIF}(Item).Caption), True, rText, DrawStyle, sNdx, Focused {and not bHot}, SkinData.SkinManager);
    end;

    if GridLines and (Mouse.Capture = 0) {If column is not resized} then begin // Draw grid horz line
      ACanvas.Pen.Color := SkinData.SkinManager.CommonSkinData.SysInactiveBorderColor;
      ACanvas.MoveTo(0, Bmp.Height - 1);
      ACanvas.LineTo(Width, Bmp.Height - 1);
    end;
    cw := Columns[0].Width;
    i := Columns.Count;
    SetLength(SectionOrder, i);
    Header_GetOrderArray(FhWndHeader, Columns.Count, PInteger(SectionOrder));

    for i := 0 to Length(SectionOrder) - 1 do begin
      ActNdx := SectionOrder[i];
      if (ActNdx <> 0) and (Columns[i].Width <> 0) then begin
        if ActNdx <= Columns.Count - 1 then begin
          b := True;
          NewAdvancedCustomDrawSubItem(Self, Item, ActNdx - 1, State, Stage, b, Bmp)
        end;
        if GridLines and (Mouse.Capture = 0) {If column is not resized} then begin // Draw grid vert lines
          ACanvas.MoveTo(cw, 0);
          ACanvas.LineTo(cw, Bmp.Height - 1);
        end;
        inc(cw, Columns[ActNdx].Width);
      end;
    end;
  end;

  procedure PaintThisCell;
  var
    i: integer;
    R, rImage, rCheck, rText, rSelect: TRect;
  begin
    InitRects(rImage, rCheck, rText, rSelect, rState);
    CellRect := Item.DisplayRect(drBounds);
    case vStyle of
      vsReport:
        DrawStyle := DrawStyle or DT_END_ELLIPSIS;

      vsIcon: begin
        DrawStyle := DrawStyle and not DT_SINGLELINE and not DT_VCENTER and not DT_NOCLIP and not DT_EXPANDTABS;
        DrawStyle := DrawStyle or DT_CENTER or DT_WORDBREAK or DT_END_ELLIPSIS or DT_WORD_ELLIPSIS;
        if bSelected then begin
          SetBkMode(ACanvas.Handle, TRANSPARENT);
          R := rText;
          AcDrawText(ACanvas.Handle, Item.Caption, R, DrawStyle or DT_CALCRECT {and not DT_END_ELLIPSIS and not DT_WORD_ELLIPSIS});
          rText.Bottom := min(R.Bottom + 2, aRect.Bottom);
        end
      end;
    end;

    if bSelected then begin
      case vStyle of
        vsSmallIcon, vsList: begin
          acGetTextExtent(ACanvas.Handle, Item.Caption, Size);
          rText.Right := min(rText.Left + Size.cx + 5, aRect.Right);
        end;
      end;
      if sNdx < 0 then begin
        FillDC(ACanvas.Handle, rSelect, SkinData.SkinManager.GetHighLightColor(Focused or (cdsFocused in State)));
        SetBkMode(ACanvas.Handle, TRANSPARENT);
      end
      else begin
        if Win32MajorVersion >= 6 then begin
          cRect := rText;
          if vStyle = vsReport then begin
            inc(cRect.Left, ColLeft);
            cRect.Right := cRect.Left + ColWidth;
          end;
        end
        else
          cRect := Rect(aRect.Left, 0, min(aRect.Right, aRect.Left + WidthOf(rText)), Bmp.Height);

        // Paint selection
        PaintItem(sNdx, CI, True, integer(Focused), rSelect, MkPoint, Bmp, SkinData.SkinManager);
        if bHot then begin
          cRect := iRect;
          cw := integer(BorderStyle <> bsNone) * (1 + integer(Ctl3d));
          OffsetRect(cRect, cw, cw);
          BlendTransRectangle(Bmp, 0, 0, FCommonData.FCacheBmp, cRect, 128);
          OffsetRect(cRect, -cw, -cw);
        end;
        SetBkMode(ACanvas.Handle, TRANSPARENT);
      end;
    end
    else
      sNdx := -1;

    if rText.Left < rText.Right then begin
      if not (vStyle in [vsIcon, vsReport]) then begin
        inc(rText.Left);
        InflateRect(rText, -1, 0);
      end;
      if (sNdx < 0) or SkinData.CustomFont then begin
        SetTextColor(Bmp.Canvas.Handle, ColorToRGB(Canvas.Font.Color));
        AcDrawText(Bmp.Canvas.Handle, {$IFDEF TNTUNICODE}TTntListItem{$ENDIF}(Item).Caption, rText, DrawStyle);
      end
      else begin
        acWriteTextEx(ACanvas, PacChar({$IFDEF TNTUNICODE}TTntListItem{$ENDIF}(Item).Caption), True, rText, DrawStyle, sNdx, Focused, SkinData.SkinManager);
        if not RowSelect then begin
//          Canvas.Font.Color := Font.Color;
          ACanvas.Font.Color := Canvas.Font.Color;
        end;
      end;
      if bSelected and Focused and (sNdx < 0) then
        DrawFocusRect(ACanvas.Handle, rText);
    end;
{    if bSelected and Focused then
      iDrawStyle := dsFocus
    else          }
      iDrawStyle := dsNormal;

    if (StateImages <> nil) and IsValidIndex(Item.StateIndex, GetImageCount(StateImages)) and (rState.Left <> rState.Right) {and (vStyle = vsList)} then
{$IFDEF DELPHI6UP}
      StateImages.Draw(Bmp.Canvas, rState.Left, rState.Top, Item.StateIndex, iDrawStyle, itImage)
{$ELSE}
      StateImages.Draw(Bmp.Canvas, rState.Left, rState.Top, Item.StateIndex, True)
{$ENDIF}
    else
      if CheckBoxes then
        acDrawCheck(rCheck, sConst.CheckBoxStates[integer(Item.Checked)], True, Bmp, MakeCacheInfo(Bmp), SkinData.SkinManager, acSmallCheckBoxes);

    if Item.ImageIndex >= 0 then begin
      if rImage.Right > rImage.Left then begin
        if ImgList <> nil then
{$IFDEF DELPHI6UP}
          ImgList.Draw(Bmp.Canvas, rImage.Left, rImage.Top, Item.ImageIndex, iDrawStyle, itImage)
{$ELSE}
          ImgList.Draw(Bmp.Canvas, rImage.Left, rImage.Top, Item.ImageIndex, True)
{$ENDIF}
        else begin
          if vStyle = vsIcon then
            ImgLst := ListView_GetImageList(Handle, LVSIL_NORMAL)
          else
            ImgLst := ListView_GetImageList(Handle, LVSIL_SMALL);

          if ImgLst <> 0 then
            ImageList_Draw(ImgLst, Item.ImageIndex, Bmp.Canvas.Handle, rImage.Left, rImage.Top, iff(bSelected and Focused, ILD_FOCUS, 0) or ILD_TRANSPARENT);
        end;
      end;
    end;
    if vStyle = vsReport then begin
      if GridLines and (Mouse.Capture = 0) {If column is not in resizing}then begin // Draw grid horz line
//        ACanvas.Pen.Color := ColorToRGB(clBtnFace);//$EFEFEF;
        ACanvas.Pen.Color := SkinData.SkinManager.CommonSkinData.SysInactiveBorderColor;
        ACanvas.MoveTo(0, Bmp.Height - 1);//aRect.Bottom);
        ACanvas.LineTo(Width, Bmp.Height - 1);//aRect.Bottom);
        cw := Columns[0].Width;
      end;
      SetLength(SectionOrder, Columns.Count);
      Header_GetOrderArray(FhWndHeader, Columns.Count, PInteger(SectionOrder));
      Bmp.Canvas.Lock;
      for i := 0 to Length(SectionOrder) - 1 do begin
        ActNdx := SectionOrder[i];
        if (ActNdx <> 0) and (Columns[i].Width <> 0) then begin
          b := True;
          NewAdvancedCustomDrawSubItem(Self, Item, ActNdx - 1, State, Stage, b, Bmp);
          if GridLines and (Mouse.Capture = 0) {If column is not in resizing}then begin // Draw grid vert lines
            ACanvas.MoveTo(cw, 0);//aRect.Top);
            ACanvas.LineTo(cw, Bmp.Height - 1);//aRect.Bottom);
            inc(cw, Columns[ActNdx].Width);
          end;
        end;
      end;
      Bmp.Canvas.Unlock;
    end;
  end;

  function PaintThisItem: boolean;
  begin
    Result := False;
    ColNdx := GetColumnIndex;
    if vStyle = vsReport then begin
      ColWidth := ListView_GetColumnWidth(Handle, 0);
      ColLeft := iRect.Left + ColumnLeft(ColNdx);
    end
    else begin
      ColWidth := 0;
      ColLeft  := 0;
    end;
    if bSelected then
      sNdx := iSelectIndex
    else
      if ItemIsHot(Item, iRect) then begin
        bHot := True;
        bSelected := True;
        sNdx := iSelectIndex;
      end
      else
        sNdx := -1;

    ImgList := GetImageList;
    if not IsRectEmpty(iRect) then begin
      if (vStyle = vsReport) and RowSelect then
        PaintThisRow
      else
        PaintThisCell;

      Result := True;
    end;
  end;

begin
  if not (csDesigning in ComponentState) {$IFDEF DELPHI6UP}and Canvas.HandleAllocated{$ENDIF} and not (SkipAdvancedDraw and Assigned(FOldCustomDrawItem)) then begin
    if Assigned(FOldAdvancedCustomDrawItem) then begin
      FOldAdvancedCustomDrawItem(Sender, Item, State, Stage, DefaultDraw);
      if not DefaultDraw then
        Exit;
    end;
    if Stage in [cdPrePaint, cdPostPaint] then begin
      bSelected := Item.Selected and not (HideSelection and not Focused);
      cw := 0;
      CI.Bmp := nil;
      CI.Ready := False;
      CI.FillColor := Color;
      vStyle := ViewStyle;
      DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER;// or DT_CLIP;
      if UseRightToLeftReading then
        DrawStyle := DrawStyle or DT_RTLREADING;

      bHot := False;
      // Check rect of item
      if ListView_GetItemRect(Handle, Item.Index, iRect, LVIR_BOUNDS) and
           (iRect.Left <> -2147483613 {is not ready}) and not IsRectEmpty(iRect) then begin

        Bmp := CreateBmp32(iRect);
        ACanvas := Bmp.Canvas;
        aRect := MkRect(Bmp);
        ACanvas.Brush.Color := Canvas.Brush.Color;
        ACanvas.FillRect(aRect);
        ACanvas.Font.Assign(Canvas.Font);
        DefaultDraw := not PaintThisItem;
        BitBlt(TAccessCanvas(Canvas).FHandle, iRect.Left, iRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        FreeAndNil(Bmp);
      end;
    end;
  end;
end;


function TsCustomListView.GetImageList: TCustomImageList;
begin
  if ViewStyle in [vsIcon] then
    Result := LargeImages
  else
    Result := SmallImages;
end;


function TsCustomListView.ColumnLeft(const Index: integer): integer;
var
  i: integer;
  SectionOrder: array of Integer;
begin
  Result := 0;
  SetLength(SectionOrder, Columns.Count);
  Header_GetOrderArray(FhWndHeader, Columns.Count, PInteger(SectionOrder));
  for i := 0 to Index - 1 do
    inc(Result, ListView_GetColumnWidth(Handle, SectionOrder[i]));
end;


procedure TsCustomListView.InitSkinParams;
begin
  iSelectIndex := SkinData.SkinManager.ConstData.Sections[ssSelection];
end;


procedure TsCustomListView.NewAdvancedCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean; Bmp: TBitmap);
var
  OldColor: TColor;
  bSelected: boolean;
  DrawStyle: Cardinal;
  OldDC, SavedDC: hdc;
  fText, aRect, bRect: TRect;
  iNdx, ColNdx, sNdx: integer;
  SectionOrder: array of Integer;
begin
  if not (csDesigning in ComponentState) and (ViewStyle = vsReport) then begin
    bSelected := RowSelect and Item.Selected and not (HideSelection and not Focused);
    UpdateCanvasColors(cdsHot in State, bSelected);
    OldColor := Bmp.Canvas.Brush.Color;
    if Assigned(OnAdvancedCustomDrawSubItem) {and not bSelected }then begin
      OldDC := Canvas.Handle;
      Canvas.Handle := Bmp.Canvas.Handle;
      Canvas.Font.Color := Bmp.Canvas.Font.Color;
      Canvas.Brush.Color := Bmp.Canvas.Brush.Color;
      Bmp.Canvas.Lock;
      SavedDC := SaveDC(Canvas.Handle);
      aRect := Item.DisplayRect(drBounds);
      MoveWindowOrg(Canvas.Handle, 0, -aRect.Top);
      IntersectClipRect(Canvas.Handle, 0, 0, aRect.Right, aRect.Bottom);
      OldColor := Canvas.Brush.Color;
      OnAdvancedCustomDrawSubItem(Sender, Item, SubItem + 1, State, Stage, DefaultDraw);
      RestoreDC(Canvas.Handle, SavedDC);
      Bmp.Canvas.UnLock;
      Canvas.Handle := OldDC;
      if not DefaultDraw then
        Exit;
    end;
    if SubItem < Columns.Count - 1 then begin
      if Assigned(OnCustomDrawSubItem) {and not bSelected} then begin
        OldDC := Canvas.Handle;
        Canvas.Handle := Bmp.Canvas.Handle;
        Canvas.Font.Color := Bmp.Canvas.Font.Color;
        Canvas.Brush.Color := Bmp.Canvas.Brush.Color;
        Bmp.Canvas.Lock;
        SavedDC := SaveDC(Canvas.Handle);
        aRect := Item.DisplayRect(drBounds);
        MoveWindowOrg(Canvas.Handle, 0, -aRect.Top);
        IntersectClipRect(Canvas.Handle, 0, 0, aRect.Right, aRect.Bottom);
        OldColor := Canvas.Brush.Color;
        OnCustomDrawSubItem(Sender, Item, SubItem + 1, State, DefaultDraw);
        RestoreDC(Canvas.Handle, SavedDC);
        Bmp.Canvas.UnLock;
        Canvas.Handle := OldDC;
        if not DefaultDraw then
          Exit;
      end;

      bRect := mkRect(Bmp);
      if SkinData.Skinned then
        if Stage in [cdPrePaint, cdPostPaint] then begin
          ColNdx := SubItem + 1;
          if Columns.Count > 0 then begin
            SetLength(SectionOrder, Columns.Count);
            Header_GetOrderArray(FhWndHeader, Columns.Count, PInteger(SectionOrder));
            for iNdx := 0 to Columns.Count - 1 do
              if SectionOrder[iNdx] = SubItem + 1 then begin
                ColNdx := iNdx;
                Break;
              end;
          end;
          aRect.Left := ColumnLeft(ColNdx);
          aRect.Right := aRect.Left + ListView_GetColumnWidth(Handle, SubItem + 1) + 4;
          if aRect.Left = aRect.Right then
            Exit;

          fText.Left   := aRect.Left;
          fText.Right  := aRect.Right - 4;
          fText.Top    := 0;//aRect.Top;
          fText.Bottom := Bmp.Height;
          Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
          Bmp.Canvas.Font.Color := Canvas.Font.Color;
          if not bSelected and not (cdsHot in State) and (OldColor <> Canvas.Brush.Color) then
            FillDC(Bmp.Canvas.Handle, fText, Canvas.Brush.Color);

          // Text rect receiving
          if SubItem < Item.SubItems.Count then begin
            iNdx := Item.SubItemImages[SubItem];
            if Assigned(SmallImages) then
              if IsValidIndex(iNdx, GetImageCount(SmallImages)) then begin
                SmallImages.Draw(Bmp.Canvas, fText.Left + 1, fText.Top + (fText.Bottom - fText.Top - SmallImages.Height) div 2, iNdx);
                inc(fText.Left, SmallImages.Width + 2);
              end;

            fText.Left := fText.Left + 3;
            DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS or GetStringFlags(Self, Columns[ColNdx].Alignment);
            sNdx := iff(bSelected, iSelectIndex, -1);
            if sNdx < 0 then begin
              if not Enabled then
                if Bmp <> nil then begin
                  Bmp.Canvas.Font.Color := AverageColor(Bmp.Canvas.Font.Color, Color);
                  Bmp.Canvas.Brush.Style := bsClear;
                  Bmp.Canvas.Brush.Color := OldColor;
                end;

              SelectObject(Bmp.Canvas.Handle, Canvas.Font.Handle);
              if (cdsHot in State) and HotTrack and RowSelect then
                SetTextColor(Bmp.Canvas.Handle, SkinData.SkinManager.Palette[pcSelectionText_Focused])
              else
                SetTextColor(Bmp.Canvas.Handle, Canvas.Font.Color);// SkinData.SkinManager.gd[SkinData.SkinIndex].Props[integer(SkinData.FFocused)].FontColor.Color);//ColorToRGB(Canvas.Font.Color));

              SetBkMode(Bmp.Canvas.Handle, TRANSPARENT);
              AcDrawText(Bmp.Canvas.Handle, Item.SubItems[SubItem], fText, DrawStyle);
            end
            else
              if Bmp <> nil then begin
                if not SkinData.CustomFont then begin
                  if bSelected and (not HideSelection or FCommonData.FFocused) then begin
                    Bmp.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(Focused or (cdsFocused in State));
                    if Assigned(OnCustomDrawSubItem) then begin
                      OldDC := Canvas.Handle;
                      Canvas.Handle := Bmp.Canvas.Handle;
                      Canvas.Font.Color := Bmp.Canvas.Font.Color;
                      Bmp.Canvas.Lock;

                      SavedDC := SaveDC(Canvas.Handle);
                      MoveWindowOrg(Canvas.Handle, 0, -aRect.Top);
                      IntersectClipRect(Canvas.Handle, 0, 0, aRect.Right, aRect.Bottom);
                      OnCustomDrawSubItem(Sender, Item, SubItem + 1, State, DefaultDraw);
                      RestoreDC(Canvas.Handle, SavedDC);
                      Canvas.Handle := OldDC;
                      Bmp.Canvas.UnLock;
                      if not DefaultDraw then
                        Exit;

                      if Canvas.Font.Color <> Bmp.Canvas.Font.Color then
                        SelectObject(Bmp.Canvas.Handle, Canvas.Font.Handle)
                      else
                        SelectObject(Bmp.Canvas.Handle, Bmp.Canvas.Font.Handle);

                      SetBkMode(Bmp.Canvas.Handle, TRANSPARENT);
                    end;
                  end
                  else
                    Bmp.Canvas.Font.Color := Canvas.Font.Color;
                end
                else
                  Bmp.Canvas.Font.Color := Canvas.Font.Color;

                if not Enabled then
                  Bmp.Canvas.Font.Color := AverageColor(Bmp.Canvas.Font.Color, Color);

                Bmp.Canvas.Brush.Style := bsClear;
                AcDrawText(Bmp.Canvas.Handle, Item.SubItems[SubItem], fText, DrawStyle);
              end;
          end;
          Canvas.Brush.Color := OldColor;//Bmp.Canvas.Brush.Color;
          Bmp.Canvas.Font.Color := Canvas.Font.Color;
          DefaultDraw := False;
        end;
    end;
  end;
end;


procedure TsCustomListView.DoBeginColumnResize(const columnIndex, columnWidth: integer);
begin
  if Assigned(FBeginColumnResizeEvent) then
    FBeginColumnResizeEvent(Self, ColumnIndex, ColumnWidth);
end;


procedure TsCustomListView.DoColumnResize(const ColumnIndex, ColumnWidth: integer);
begin
  if Assigned(FColumnResizeEvent) then
    FColumnResizeEvent(Self, ColumnIndex, ColumnWidth);
end;


procedure TsCustomListView.DoEndColumnResize(const ColumnIndex, ColumnWidth: integer);
begin
  if Assigned(FEndColumnResizeEvent) then
    FEndColumnResizeEvent(Self, ColumnIndex, ColumnWidth);
end;


function TsCustomListView.FindColumnIndex(const pHeader: pNMHdr): integer;
var
  hwndHeader: HWND;
  iteminfo: THdItem;
  itemindex: Integer;
  buf: array [0..128] of Char;
begin
  Result := -1;
  hwndHeader := pHeader^.hwndFrom;
  itemindex  := pHDNotify(pHeader)^.Item;
  FillChar(iteminfo, sizeof(iteminfo), 0);

  iteminfo.Mask := HDI_TEXT;
  iteminfo.pszText := buf;
  iteminfo.cchTextMax := sizeof(buf) - 1;
  Header_GetItem(hwndHeader, itemindex, iteminfo);
  if CompareStr(Columns[itemindex].Caption, iteminfo.pszText) = 0 then
    Result := itemindex
  else
    for itemindex := 0 to Columns.count - 1 do
      if CompareStr(Columns[itemindex].Caption, iteminfo.pszText) = 0 then begin
        Result := itemindex;
        Exit;
      end;
end;


function TsCustomListView.FindColumnWidth(const pHeader: pNMHdr): integer;
begin
  Result := -1;
  with PHDNotify(pHeader)^ do
    if Assigned(pItem) and (pItem^.mask and HDI_WIDTH <> 0) then
      Result := pItem^.cxy;
end;


procedure TsCustomListView.WMNotify(var msg: TWMNotify);
begin
  inherited;
  case msg.NMHdr^.code Of
    HDN_ENDTRACK:   DoEndColumnResize   (FindColumnIndex(msg.NMHdr), FindColumnWidth(msg.NMHdr));
    HDN_BEGINTRACK: DoBeginColumnResize (FindColumnIndex(msg.NMHdr), FindColumnWidth(msg.NMHdr));
    HDN_TRACK:      DoColumnResize      (FindColumnIndex(msg.NMHdr), FindColumnWidth(msg.NMHdr));
  end;
end;


procedure TsCustomListView.NewCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  bSelected: boolean;
  iRect: TRect;
begin
  if not (csDesigning in ComponentState) {$IFDEF DELPHI6UP}and Canvas.HandleAllocated{$ENDIF} then
    if ListView_GetItemRect(Handle, Item.Index, iRect, LVIR_BOUNDS) and (iRect.Left <> -2147483613 {is not ready}) and not IsRectEmpty(iRect) then begin
      bSelected := Item.Selected and not (HideSelection and not Focused);
      Canvas.Font.Assign(Font);
      UpdateCanvasColors(Focused or (cdsFocused in State), bSelected and not ItemIsHot(Item, iRect));
      if Assigned(FOldCustomDrawItem) then begin
        FOldCustomDrawItem(Sender, Item, State, DefaultDraw);
        if not DefaultDraw then
          Exit;
      end;
      SkipAdvancedDraw := False;
      NewAdvancedCustomDrawItem(Sender, Item, State, cdPrePaint, DefaultDraw);
      SkipAdvancedDraw := True;
      DefaultDraw := False;
    end;
end;


function TsCustomListView.ItemIsHot(const Item: TListItem; const R: TRect): boolean;
var
  cRect, nRect: TRect;
  p: TPoint;
begin
  Result := False;
  if (Win32MajorVersion >= 6) and (GetCapture = 0) {If mouse is not pressed} and HotTrack then begin
    p := Self.ScreenToClient(acMousePos);
    if PtInRect(ClientRect, p) then
      if PtInRect(R, p) then begin
        GetClipBox(Canvas.Handle, cRect);
        nRect.Left   := max(R.Left,   cRect.Left);
        nRect.Top    := max(R.Top,    cRect.Top);
        nRect.Right  := min(R.Right,  cRect.Right);
        nRect.Bottom := min(R.Bottom, cRect.Bottom);
        if PtInRect(nRect, p) then begin
          if IsValidIndex(HotItem, Items.Count) and (HotItem <> Item.Index) then begin // Repaint prev Hot Item
            cRect := Items[HotItem].DisplayRect(drBounds);
            InvalidateRect(Handle, @cRect, True);
          end;
          HotItem := Item.Index;
          Result := True;
        end;
      end;
  end;
end;

end.
