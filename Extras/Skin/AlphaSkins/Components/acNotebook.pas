unit acNoteBook;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Messages, Windows, SysUtils, Classes, Controls, Forms, Graphics, ExtCtrls,
  {$IFNDEF DELPHI5} types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sCommonData, acSBUtils;


type
{$IFNDEF NOTFORHELP}
  TacWndArray = array of TacMainWnd;
{$ENDIF}

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsNotebook = class(TNoteBook)
{$IFNDEF NOTFORHELP}
  private
    FCommonData: TsCommonData;
    wa: TacWndArray;
  public
    procedure Loaded; override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    procedure WndProc(var Message: TMessage); override;
  published
    property Align;
    property Anchors;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property Enabled;
    property Constraints;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
{$ENDIF}
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;

{$IFNDEF NOTFORHELP}
  TsPage = class(TPage); // For compatibility with old version
{$ENDIF}


implementation

uses
  sMessages, sVclUtils, sGraphUtils, acntUtils, sConst, sSkinProps, sStyleSimply;


constructor TsNotebook.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsCheckBox;
  inherited Create(AOwner);
end;


destructor TsNotebook.Destroy;
var
  i: integer;
begin
  FreeAndNil(FCommonData);
  for i := 0 to Length(wa) - 1 do
    if (wa[i] <> nil) and wa[i].Destroyed then
      FreeAndNil(wa[i]);

  inherited Destroy;
end;


procedure TsNotebook.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


procedure TsNotebook.Loaded;
begin
  inherited;
  FCommonData.Loaded;
end;


type
  TacPageWnd = class(TacMainWnd)
  protected
    Notebook: TsNotebook;
    Page: TPage;
  public
    function PrepareCache: boolean;
    procedure AC_WMPaint(const Message: TWMPaint);
    procedure acWndProc(var Message: TMessage); override;
  end;


var
  bFlag: boolean = False;

  
procedure TsNotebook.WndProc(var Message: TMessage);
var
  i: integer;
  Page: TPage;
  sd: TsCommonData;
  sp: TacSkinParams;
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
        end;

        AC_GETAPPLICATION: begin
          Message.Result := LRESULT(Application);
          Exit;
        end;

        AC_REMOVESKIN: begin
          for i := 0 to ControlCount - 1 do
            if Controls[i] is TPage then
              SendMessage(TPage(Controls[i]).Handle, Message.Msg, Message.WParam, Message.LParam);

          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, FCommonData);
            RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);
          end;
          Exit;
        end;

        AC_SETNEWSKIN: begin
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then
            CommonWndProc(Message, FCommonData);

          for i := 0 to ControlCount - 1 do
            if Controls[i] is TPage then
              SendMessage(TPage(Controls[i]).Handle, Message.Msg, Message.WParam, Message.LParam);

          Exit;
        end;

        AC_REFRESH: begin
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, FCommonData);
            RedrawWindow(Handle, nil, 0, RDWA_ALL);
          end;
          for i := 0 to ControlCount - 1 do
            if Controls[i] is TPage then begin
              SendMessage(TPage(Controls[i]).Handle, Message.Msg, Message.WParam, Message.LParam);
              sd := TsCommonData(SendMessage(TPage(Controls[PageIndex]).Handle, SM_ALPHACMD, MakeWParam(0, AC_GETSKINDATA), 0));
              if (sd <> nil) and (sd.SkinSection <> SkinData.SkinSection) then
                sd.SkinSection := SkinData.SkinSection;
            end;

          Exit;
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.ConstData.Sections[ssCheckBox] + 1;

          Exit;
        end;

        AC_GETBG:
          if (SkinData.SkinManager <> nil) and SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinIndex) then begin
            InitBGInfo(FCommonData, PacBGInfo(Message.LParam), 0);
            if PacBGInfo(Message.LParam)^.BgType in [btNotReady, btFill] then
              Exit;
            // If BG is not ready yet
            if SkinData.BGChanged and ((SkinData.FCacheBmp.Width <> Width) or (SkinData.FCacheBmp.Height <> Height)) and not SkinData.Updating then begin
              if (Parent = nil) or not Parent.HandleAllocated or GetBoolMsg(Parent.Handle, ac_CtrlHandled) then begin // If parent is skinned
                PacBGInfo(Message.LParam)^.BgType := btNotReady;
                Exit;
              end;
            end;
            if (WidthOf(ClientRect) <> Width) and (PacBGInfo(Message.LParam)^.BgType = btCache) and not PacBGInfo(Message.LParam)^.PleaseDraw then begin
              inc(PacBGInfo(Message.LParam)^.Offset.X, BorderWidth + BevelWidth * (integer(BevelInner <> bvNone) + integer(BevelOuter <> bvNone)));
              inc(PacBGInfo(Message.LParam)^.Offset.Y, BorderWidth + BevelWidth * (integer(BevelInner <> bvNone) + integer(BevelOuter <> bvNone)));
            end;
            Exit;
          end;

        AC_GETCONTROLCOLOR:
          if SkinData.FOwnerControl <> nil then begin
            CommonMessage(Message, SkinData);
            Exit;
          end;

        AC_PREPARECACHE: begin
          CommonMessage(Message, SkinData);
          Exit;
        end;

        AC_INVALIDATE: begin
          if PageIndex >= 0 then begin
            sd := TsCommonData(SendMessage(TPage(Controls[PageIndex]).Handle, SM_ALPHACMD, AC_GETSKINDATA_HI, 0));
            if (sd <> nil) and (sd.SkinSection <> SkinData.SkinSection) then
              sd.SkinSection := SkinData.SkinSection;
          end;
          Exit;
        end;
      end;

    WM_PARENTNOTIFY: begin
      case Message.WParamLo of
        WM_CREATE:
          for i := 0 to ControlCount - 1 do
            if (Self.Controls[i] is TPage) and (TPage(Controls[i]).Handle = THandle(Message.LParam)) then begin
              Page := TPage(Controls[i]);
              sd := TsCommonData.Create(Page, True);
              sd.COC := SkinData.COC;
              sd.SkinSection := SkinData.SkinSection;
              sd.Loaded;
              sd.FOwnerObject := Page;
              sd.FOwnerControl := Page;
              sd.SkinManager := SkinData.SkinManager;

              SetLength(wa, Length(wa) + 1);
              wa[Length(wa) - 1] := TacPageWnd.Create(Page.Handle, sd, SkinData.SkinManager, sp);
              wa[Length(wa) - 1].OwnSkinData := True;
              TacPageWnd(wa[Length(wa) - 1]).Notebook := Self;
              TacPageWnd(wa[Length(wa) - 1]).Page := Page;
              AddToAdapter(Self);
              Break;
            end;
      end;
    end;
  end;
  if not ControlIsReady(Self) or (FCommonData = nil) or not FCommonData.Skinned then
    inherited
  else
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_ENDPARENTUPDATE:
          for i := 0 to ControlCount - 1 do
            if Controls[i] is TPage then
              SendMessage(TPage(Controls[i]).Handle, Message.Msg, Message.WParam, Message.LParam);

        AC_PREPARING: begin
          Message.Result := LRESULT(FCommonData.Updating);
          Exit;
        end

        else
          CommonMessage(Message, FCommonData);
      end
    else begin
      case Message.Msg of
        CM_SHOWINGCHANGED, CM_VISIBLECHANGED: begin
          inherited;
          exit;
        end;

        WM_ERASEBKGND:
          if not bFlag then begin
            bFlag := True;
            if IsValidIndex(PageIndex, Length(wa)) then begin
              Message.Result := SendMessage(wa[PageIndex].CtrlHandle, Message.Msg, Message.WParam, 1);
              Exit;
            end;
            bFlag := False;
          end;
      end;
      CommonWndProc(Message, FCommonData);
      inherited;
    end;
end;


procedure TacPageWnd.AC_WMPaint(const Message: TWMPaint);
var
  b: boolean;
  DC, SaveIndex: HDC;
  R: TRect;
  w: integer;
  ClRect: TRect;
begin
  if not (csDestroying in SkinData.FOwnerControl.ComponentState) then begin
    if (SkinData.FOwnerControl.Parent <> nil) and (csCreating in SkinData.FOwnerControl.Parent.ControlState) then
      Exit;

    if not SkinData.Updating then begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      if Message.DC = 0 then
        DC := GetWindowDC(Page.Handle)
      else
        DC := Message.DC;

      SaveIndex := SaveDC(DC);
      try
        // If transparent and form resizing processed
        b := SkinData.HalfVisible or SkinData.BGChanged;
        if SkinData.RepaintIfMoved then begin
          GetClipBox(DC, R);
          SkinData.HalfVisible := (WidthOf(R) <> Page.Width) or (HeightOf(R) <> Page.Height)
        end
        else
          SkinData.HalfVisible := False;

        if b then
          PrepareCache;

        GetClientRect(CtrlHandle, ClRect);
        w := (WidthOf(WndRect) - WidthOf(ClRect)) div 2;
        if Page <> nil then begin
          CopyWinControlCache(Page, SkinData, Rect(w, w, 0, 0), MkRect(Page.Width - 2 * w, Page.Height - 2 * w), DC, True);
          sVCLUtils.PaintControls(DC, Page, b and SkinData.RepaintIfMoved, MkPoint);
          SetParentUpdated(Page);
        end
        else
          BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);

      finally
        RestoreDC(DC, SaveIndex);
        if Message.DC = 0 then
          ReleaseDC(Page.Handle, DC);
      end;
    end;
  end;
end;


procedure TacPageWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  M: TMessage;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end;

      AC_SETNEWSKIN: begin
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
          CommonWndProc(Message, SkinData);

        AlphaBroadCastCheck(Skindata.FOwnerControl, CtrlHandle, Message);
        Exit;
      end;

      AC_GETDEFINDEX: begin
        if SkinData.SkinManager <> nil then
          Message.Result := SkinData.SkinManager.ConstData.Sections[ssCheckBox] + 1;

        Exit;
      end;
    end;

  if SkinData.Skinned then begin
    if Message.Msg = SM_ALPHACMD then
      case Message.WParamHi of
        AC_REMOVESKIN: begin
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, SkinData);
            RedrawWindow(Page.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW or RDW_NOERASE or RDW_ALLCHILDREN);
          end;
          AlphaBroadCastCheck(Skindata.FOwnerControl, CtrlHandle, Message);
          Exit;
        end;

        AC_PREPARECACHE: begin
          PrepareCache;
          SkinData.BGChanged := False;
          Exit;
        end;

        AC_REFRESH: begin
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then
            CommonWndProc(Message, SkinData);

          AlphaBroadCastCheck(Skindata.FOwnerControl, CtrlHandle, Message);
        end;

        AC_CHILDCHANGED: begin
          CommonMessage(Message, SkinData);
          Exit;
        end;

        AC_GETBG:
          if (SkinData.SkinManager <> nil) and SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinIndex) then begin
            InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0);
            if PacBGInfo(Message.LParam)^.BgType in [btNotReady, btFill] then
              Exit;
            // If BG is not ready yet
            if SkinData.BGChanged and ((SkinData.FCacheBmp.Width <> NoteBook.Width) or (SkinData.FCacheBmp.Height <> NoteBook.Height)) and not SkinData.Updating then
              if (NoteBook.Parent = nil) or not NoteBook.Parent.HandleAllocated or WndIsSkinned(NoteBook.Parent.Handle) then begin // If parent is skinned
                PacBGInfo(Message.LParam)^.BgType := btNotReady;
                SkinData.FUpdating := True;
                Exit;
              end;

            Exit;
          end;

        AC_ENDPARENTUPDATE: begin
          if not InUpdating(SkinData, True) then
            RedrawWindow(CtrlHandle, nil, 0, RDWA_NOCHILDRENNOW);

          SetParentUpdated(Page);
          Exit;
        end;

        AC_PREPARING: begin
          Message.Result := LRESULT(Notebook.SkinData.Updating or SkinData.BGChanged);
          Exit;
        end;

        AC_GETCONTROLCOLOR: begin
          CommonMessage(Message, SkinData);
          Exit;
        end

        else
          if CommonMessage(Message, SkinData) then
            Exit;
      end;

    case Message.Msg of
      WM_ERASEBKGND:
        if not DlgMode then begin
          if (Page <> nil) and (csDesigning in Page.ComponentState) then
            inherited;

          AC_WMPaint(TWMPaint(Message));
          Message.Result := 1;
          Exit;
        end;

      WM_NCPAINT:
        if DlgMode then begin
          AC_WMPaint(TWMPaint(MakeMessage(WM_NCPAINT, 0, 0, 0)));
          Exit;
        end
        else
          if SkinData.BGChanged then
            PrepareCache;

      WM_PRINT:
        if not DlgMode then begin
          SkinData.BGChanged := True;
          Message.LParam := 1;
          AC_WMPaint(TWMPaint(Message));
        end;

      WM_PAINT:
        if not DlgMode then begin
          InvalidateRect(CtrlHandle, nil, True);
          BeginPaint(CtrlHandle, PS);
          EndPaint(CtrlHandle, PS);
          Exit;
        end;

      CM_SHOWINGCHANGED:
        if SkinData.FOwnerControl.Visible then begin
          if SkinData.SkinManager.Options.OptimizingPriority = opMemory then
            SkinData.FUpdating := False;

          AddToAdapter(TWinControl(SkinData.FOwnerControl));
          M := MakeMessage(SM_ALPHACMD, AC_SETNEWSKIN_HI, Longint(SkinData.SkinManager), 0);
          AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
          M := MakeMessage(SM_ALPHACMD, AC_REFRESH_HI, Longint(SkinData.SkinManager), 0);
          AlphaBroadCastCheck(SkinData.FOwnerControl, CtrlHandle, M);
        end;

      WM_SIZE, WM_MOVE:
        SkinData.BGChanged := True;

      WM_PARENTNOTIFY:
        if Message.WParamLo in [WM_CREATE, WM_DESTROY] then begin
          inherited;
          if (Message.WParamLo = WM_CREATE) and Assigned(Notebook) then
            AddToAdapter(Notebook);

          Exit;
        end;

      CM_VISIBLECHANGED: begin
        SkinData.BGChanged := True;
        SkinData.FUpdating := False;
        if Message.WParam = 1 then begin
          PrepareCache;
          inherited;
          if Page <> nil then
            SetParentUpdated(Page);
        end
        else
          inherited;

        Exit;
      end;
    end;
  end;
  inherited;
end;


function TacPageWnd.PrepareCache: boolean;
var
  ParentBG: TacBGInfo;
  CI: TCacheInfo;
begin
  InitCacheBmp(SkinData);
  GetBGInfo(@ParentBG, NoteBook.Parent);
  if ParentBg.BgType = btNotReady then begin
    Result := False;
    SkinData.FUpdating := True;
  end
  else begin
    Result := True;
    CI := BGInfoToCI(@ParentBG);
    PaintItem(SkinData, CI, False, 0, MkRect(SkinData.FCacheBMP), MkPoint(Notebook), SkinData.FCacheBMP, True);
    SkinData.BGChanged := False;
  end;
end;


initialization
    Classes.RegisterClasses([TsPage]); // For compatibility with old versions

finalization

end.
