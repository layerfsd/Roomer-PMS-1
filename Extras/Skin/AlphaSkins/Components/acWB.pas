unit acWB;
{$I sDefs.inc}
//{$DEFINE LOGGED}

//{$DEFINE CPPWEBBROWSER}

interface

uses
  Windows, Messages, SysUtils, Controls, Graphics, Classes, ExtCtrls, Variants, SHDocVw, MSHTML, Activex,
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sCommonData, acSBUtils, sScrollBar, sSkinManager, sPanel, sSkinProps;


type
  TacWBWnd = class;
  TacWBScrollBar = class;


  TacWBContainer = class(TsPanel)
  public
    WB: TWebBrowser;
    WBWnd: TacWBWnd;
    VScrollBar: TacWBScrollBar;
    HScrollBar: TacWBScrollBar;
    SkinSection: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WndProc(var Message: TMessage); override;
    procedure Invalidate; override;
    procedure UpdateScrollsWB(SizeChanged: boolean = True);
    procedure UpdateRgn;
  end;


  TacWBScrollBar = class(TsScrollBar)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    Container: TacWBContainer;
    destructor Destroy; override;
  end;


{$IFDEF CPPWEBBROWSER}
  TCommandStateChange = procedure(Sender: TObject; Command: Integer; Enable: WordBool) of object;
  TNavigateComplete2  = procedure(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant) of object;
  TDocumentComplete   = procedure(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant) of object;
  TBeforeNavigate2    = procedure(Sender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
                                  var Cancel: WordBool) of object;
{$ELSE}
  {$IFNDEF DELPHI_XE}
  TCommandStateChange = procedure(Sender: TObject; Command: Integer; Enable: WordBool) of object;
  TNavigateComplete2  = procedure(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant) of object;
  TDocumentComplete   = procedure(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant) of object;
  TBeforeNavigate2    = procedure(Sender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
                                  var Cancel: WordBool) of object;
  {$ELSE}
  TCommandStateChange = procedure(ASender: TObject; Command: Integer; Enable: WordBool) of object;
    {$IFDEF DELPHI_XE2}
  TDocumentComplete   = procedure(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant) of object;
  TNavigateComplete2  = procedure(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant) of object;
  TBeforeNavigate2    = procedure(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant; const Flags: OleVariant;
                                  const TargetFrameName: OleVariant; const PostData: OleVariant; const Headers: OleVariant; var Cancel: WordBool) of object;
    {$ELSE}
  TDocumentComplete   = procedure(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant) of object;
  TNavigateComplete2  = procedure(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant) of object;
  TBeforeNavigate2    = procedure(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant; var Flags: OleVariant;
                                  var TargetFrameName: OleVariant; var PostData: OleVariant; var Headers: OleVariant; var Cancel: WordBool) of object;
    {$ENDIF}
  {$ENDIF}
{$ENDIF}


  TScrollsUpdater = class(TTimer)
  public
    WB: TacMainWnd;
    Iterations: integer;
    constructor CreateOwned(AOwner: TacMainWnd);
    destructor Destroy; override;
    procedure OnAnimTimer(Sender: TObject);
  end;


  TacWBWnd = class(TacScrollWnd)
  public
    WB: TWebBrowser;
    Container: TacWBContainer;
    bLoading: boolean;

    OldBeforeNavigate2: TBeforeNavigate2;
    OldNavigateComplete2: TNavigateComplete2;
    OldDocumentComplete: TDocumentComplete;
    OldCommandStateChange: TCommandStateChange;

    ScrollsUpdater: TScrollsUpdater;

    constructor Create(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinParams: TacSkinParams; Repaint: boolean = True); override;
    destructor Destroy; override;
    function ScrollPos(Vert: boolean): integer;
    procedure acWndProc(var Message: TMessage); override;
    procedure InitEvents(Skinned: boolean);

{$IFDEF CPPWEBBROWSER}
    procedure DoBeforeNavigate2(Sender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
                                var Cancel: WordBool);
    procedure DoNavigateComplete2(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure DoDocumentComplete(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure DoCommandStateChange(Sender: TObject; Command: Integer; Enable: WordBool);
{$ELSE}
  {$IFNDEF DELPHI_XE}
    procedure DoBeforeNavigate2(Sender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
                                var Cancel: WordBool);
    procedure DoNavigateComplete2(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure DoDocumentComplete(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure DoCommandStateChange(Sender: TObject; Command: Integer; Enable: WordBool);
  {$ELSE}
    {$IFDEF DELPHI_XE2}
    procedure DoDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure DoNavigateComplete2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure DoBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant; const Flags: OleVariant;
                                const TargetFrameName: OleVariant; const PostData: OleVariant; const Headers: OleVariant; var Cancel: WordBool);
    {$ELSE}
    procedure DoDocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure DoNavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure DoBeforeNavigate2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant; var Flags: OleVariant;
                                var TargetFrameName: OleVariant; var PostData: OleVariant; var Headers: OleVariant; var Cancel: WordBool);

    {$ENDIF}
    procedure DoCommandStateChange(ASender: TObject; Command: Integer; Enable: WordBool);
  {$ENDIF}
{$ENDIF}
    procedure DoScrollV(Sender: TObject);
    procedure DoScrollH(Sender: TObject);
    procedure UpdateScrolls(SizeChanged: boolean = True);
  end;


implementation

uses
  Forms,
  acntUtils, sMessages;


const
  bWidth = 2;


procedure TacWBWnd.acWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  inherited acWndProc(Message);
  if Assigned(Container) then
    case Message.Msg of
      WM_DESTROY:
        InitEvents(False);

      CM_MOUSEWHEEL, WM_WINDOWPOSCHANGING, WM_WINDOWPOSCHANGED, WM_SIZE:
        if not Container.VScrollBar.DrawingForbidden {If not locked} then
          UpdateScrolls(True);

      CM_VISIBLECHANGED: begin
        UpdateScrolls;
        Container.Visible := WB.Visible;
      end;
    end;
end;


constructor TacWBWnd.Create(AHandle: hwnd; ASkinData: TsCommonData; ASkinManager: TsSkinManager; const SkinParams: TacSkinParams; Repaint: boolean = True);
begin
  inherited;
  bLoading := False;
  OldBeforeNavigate2 := nil;
  if SkinData.FOwnerControl <> nil then begin
    WB := TWebBrowser(SkinData.FOwnerControl);
    InitEvents(True);
    Container := TacWBContainer.Create(nil);
    Container.SkinSection := s_Edit;
//    Container.Tag := 5;
    Container.WB := WB;
    Container.WBWnd := Self;
    Container.Name := SkinData.FOwnerControl.Name + 'Cntnr';
    Container.Caption := '';
    Container.VScrollBar.OnChange := DoScrollV;
    Container.HScrollBar.OnChange := DoScrollH;
    UpdateScrolls;
  end
  else begin
    Container := nil;
    WB := nil;
  end;
end;


destructor TacWBWnd.Destroy;
begin
  if not Application.Terminated and (WB <> nil) and not (csDestroying in WB.ComponentState) then
    InitEvents(False);

  if Container <> nil then
    FreeAndNil(Container);

  if ScrollsUpdater <> nil then
    FreeAndNil(ScrollsUpdater);

  inherited;
end;


procedure TacWBWnd.UpdateScrolls;
begin
  if (Container <> nil) and not Destroyed then
    Container.UpdateScrollsWB(SizeChanged);
end;


procedure TacWBWnd.DoBeforeNavigate2;
begin
  if Assigned(OldBeforeNavigate2) then
{$IFNDEF DELPHI_XE}
    TBeforeNavigate2(OldBeforeNavigate2)( Sender, pDisp, URL, Flags, TargetFrameName, PostData, Headers, Cancel);
{$ELSE}
    TBeforeNavigate2(OldBeforeNavigate2)(ASender, pDisp, URL, Flags, TargetFrameName, PostData, Headers, Cancel);
{$ENDIF}
  bLoading := True;
  UpdateScrolls;
end;


procedure TacWBWnd.DoCommandStateChange;
begin
  bLoading := False;
  UpdateScrolls;
  if Assigned(OldCommandStateChange) then
{$IFNDEF DELPHI_XE}
    OldCommandStateChange(Sender, Command, Enable);
{$ELSE}
    TCommandStateChange(OldCommandStateChange)(ASender, Command, Enable);
{$ENDIF}
end;


procedure TacWBWnd.DoDocumentComplete;
begin
  bLoading := False;
  UpdateScrolls;
  if Assigned(OldDocumentComplete) then
{$IFNDEF DELPHI_XE}
    TDocumentComplete(OldDocumentComplete)( Sender, pDisp, URL);
{$ELSE}
    TDocumentComplete(OldDocumentComplete)(ASender, pDisp, URL);
{$ENDIF}
  if ScrollsUpdater = nil then
    ScrollsUpdater := TScrollsUpdater.CreateOwned(Self)
  else begin
    ScrollsUpdater.Iterations := 20;
    ScrollsUpdater.Enabled := True;
  end;
end;


procedure TacWBWnd.DoNavigateComplete2;
begin
  UpdateScrolls;
  if Assigned(OldNavigateComplete2) then
{$IFNDEF DELPHI_XE}
    TNavigateComplete2(OldNavigateComplete2)( Sender, pDisp, URL);
{$ELSE}
    TNavigateComplete2(OldNavigateComplete2)(ASender, pDisp, URL);
{$ENDIF}
end;


procedure TacWBWnd.DoScrollH(Sender: TObject);
begin
  if WB.Document <> nil then
    IHTMLWindow2(IHTMLDocument2(WB.Document).ParentWindow).Scroll(Container.HScrollBar.Position, Container.VScrollBar.Position);
end;


procedure TacWBWnd.DoScrollV(Sender: TObject);
begin
  if WB.Document <> nil then
    IHTMLWindow2(IHTMLDocument2(WB.Document).ParentWindow).Scroll(Container.HScrollBar.Position, Container.VScrollBar.Position);
end;


procedure TacWBWnd.InitEvents(Skinned: boolean);
var
  ABeforeNavigate2: TBeforeNavigate2;
  ANavigateComplete2: TNavigateComplete2;
  ADocumentComplete: TDocumentComplete;
  ACommandStateChange: TCommandStateChange;
begin
  if not (csDesigning in WB.ComponentState) then
    if Skinned then begin
{$IFDEF CPPWEBBROWSER}
      if Assigned(WB.OnBeforeNavigate2) then begin
        ABeforeNavigate2 := DoBeforeNavigate2;
        // If nor defined already
        if not Assigned(OldBeforeNavigate2) and (addr(WB.OnBeforeNavigate2) <> addr(ABeforeNavigate2)) then
          OldBeforeNavigate2 := WB.OnBeforeNavigate2;
      end
      else
        OldBeforeNavigate2 := nil;

      WB.OnBeforeNavigate2 := DoBeforeNavigate2;

      if Assigned(WB.OnNavigateComplete2) then begin
        ANavigateComplete2 := DoNavigateComplete2;
        if not Assigned(OldNavigateComplete2) and (addr(WB.OnNavigateComplete2) <> addr(ANavigateComplete2)) then
          OldNavigateComplete2 := WB.OnNavigateComplete2;
      end
      else
        OldNavigateComplete2 := nil;

      WB.OnNavigateComplete2 := DoNavigateComplete2;

      if Assigned(WB.OnDocumentComplete) then begin
        ADocumentComplete := DoDocumentComplete;
        if not Assigned(OldDocumentComplete) and (addr(WB.OnDocumentComplete) <> addr(ADocumentComplete)) then
          OldDocumentComplete := WB.OnDocumentComplete;
      end
      else
        OldDocumentComplete := nil;

      WB.OnDocumentComplete := DoDocumentComplete;

      if Assigned(WB.OnCommandStateChange) then begin
        ACommandStateChange := DoCommandStateChange;
        // If nor defined already
        if not Assigned(OldCommandStateChange) and (addr(WB.OnCommandStateChange) <> addr(ACommandStateChange)) then
          OldCommandStateChange := WB.OnCommandStateChange;
      end
      else
        OldCommandStateChange := nil;

      WB.OnCommandStateChange := DoCommandStateChange;
{$ELSE}
      if Assigned(WB.OnBeforeNavigate2) then begin
        ABeforeNavigate2 := DoBeforeNavigate2;
        // If nor defined already
        if not Assigned(OldBeforeNavigate2) and (addr(WB.OnBeforeNavigate2) <> addr(ABeforeNavigate2)) then
          OldBeforeNavigate2 := WB.OnBeforeNavigate2;
      end
      else
        OldBeforeNavigate2 := nil;

      WB.OnBeforeNavigate2 := DoBeforeNavigate2;

      if Assigned(WB.OnNavigateComplete2) then begin
        ANavigateComplete2 := DoNavigateComplete2;
        if not Assigned(OldNavigateComplete2) and (addr(WB.OnNavigateComplete2) <> addr(ANavigateComplete2)) then
          OldNavigateComplete2 := WB.OnNavigateComplete2;
      end
      else
        OldNavigateComplete2 := nil;

      WB.OnNavigateComplete2 := DoNavigateComplete2;

      if Assigned(WB.OnDocumentComplete) then begin
        ADocumentComplete := DoDocumentComplete;
        if not Assigned(OldDocumentComplete) and (addr(WB.OnDocumentComplete) <> addr(ADocumentComplete)) then
          OldDocumentComplete := WB.OnDocumentComplete;
      end
      else
        OldDocumentComplete := nil;

      WB.OnDocumentComplete := DoDocumentComplete;

      if Assigned(WB.OnCommandStateChange) then begin
        ACommandStateChange := DoCommandStateChange;
        // If nor defined already
        if not Assigned(OldCommandStateChange) and (addr(WB.OnCommandStateChange) <> addr(ACommandStateChange)) then
          OldCommandStateChange := WB.OnCommandStateChange;
      end
      else
        OldCommandStateChange := nil;

      WB.OnCommandStateChange := DoCommandStateChange;
{$ENDIF}
    end
    else begin
      if Assigned(OldBeforeNavigate2) then begin
        WB.OnBeforeNavigate2 := OldBeforeNavigate2;
        OldBeforeNavigate2 := nil;
      end
      else begin
        ABeforeNavigate2 := DoBeforeNavigate2;
        if addr(WB.OnBeforeNavigate2) = addr(ABeforeNavigate2) then
          WB.OnBeforeNavigate2 := nil;
      end;

      if Assigned(OldNavigateComplete2) then begin
        WB.OnNavigateComplete2 := OldNavigateComplete2;
        OldNavigateComplete2 := nil;
      end
      else begin
        ANavigateComplete2 := DoNavigateComplete2;
        if addr(WB.OnNavigateComplete2) = addr(ANavigateComplete2) then
          WB.OnNavigateComplete2 := nil;
      end;

      if Assigned(OldDocumentComplete) then begin
        WB.OnDocumentComplete := OldDocumentComplete;
        OldDocumentComplete := nil;
      end
      else begin
        ADocumentComplete := DoDocumentComplete;
        if addr(WB.OnDocumentComplete) = addr(ADocumentComplete) then
          WB.OnDocumentComplete := nil;
      end;

      if Assigned(OldCommandStateChange) then begin
        WB.OnCommandStateChange := OldCommandStateChange;
        OldCommandStateChange := nil;
      end
      else begin
        ACommandStateChange := DoCommandStateChange;
        if addr(WB.OnCommandStateChange) = addr(ACommandStateChange) then
          WB.OnCommandStateChange := nil;
      end;
    end
end;


function TacWBWnd.ScrollPos(Vert: boolean): integer;
begin
  if (WB.Document <> nil) and (IHtmldocument2(WB.Document).Body <> nil) then
    if Vert then
      if Variant(WB.Document).DocumentElement.scrollTop = 0 then
        Result := IHtmldocument2(WB.Document).Body.getAttribute('ScrollTop', 0)
      else
        Result := Variant(WB.Document).DocumentElement.scrollTop
    else
      if Variant(WB.Document).DocumentElement.scrollLeft = 0 then
        Result := IHtmldocument2(WB.Document).Body.getAttribute('ScrollLeft', 0)
      else
        Result := Variant(WB.Document).DocumentElement.scrollLeft
  else
    Result := 0;
end;


procedure TacWBContainer.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  inherited;
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_REFRESH:
        UpdateScrollsWB(True);
    end
  else
    case Message.Msg of
      WM_WINDOWPOSCHANGING:
        if VScrollBar <> nil then
          VScrollBar.SkinData.Invalidate();
    end;
end;


constructor TacWBContainer.Create(AOwner: TComponent);
begin
  inherited;
  VScrollBar := TacWBScrollBar.Create(nil);
  VScrollBar.Kind := sbVertical;
  VScrollBar.Parent := Self;
  VScrollBar.Name := 'ScrollBarVert';
  VScrollBar.TabStop := False;
  VScrollBar.Container := Self;

  HScrollBar := TacWBScrollBar.Create(nil);
  HScrollBar.Visible := False;
  HScrollBar.Parent := Self;
  HScrollBar.Name := 'ScrollBarHorz';
  HScrollBar.TabStop := False;
  HScrollBar.Container := Self;
end;


destructor TacWBContainer.Destroy;
begin
  if VScrollBar <> nil then begin
    VScrollBar.OnChange := nil;
    VScrollBar.Free;
  end;
  if HScrollBar <> nil then begin
    HScrollBar.OnChange := nil;
    HScrollBar.Free;
  end;
  WBWnd.Container := nil;
  inherited;
end;


procedure TacWBContainer.Invalidate;
begin
  if (SkinData <> nil) and (SkinData.SkinSection <> SkinSection) then
    SkinData.SkinSection := SkinSection;

  inherited;
end;


procedure TacWBContainer.UpdateRgn;
var
  Rgn, SubRgn: hrgn;
begin
  Rgn := CreateRectRgn(0, 0, Width, Height);
  SubRgn := CreateRectRgn(bWidth, bWidth, Width - integer(VScrollBar.Visible) * VScrollBar.Width - bWidth, Height - integer(HScrollBar.Visible) * HScrollBar.Height - bWidth);
  CombineRgn(Rgn, Rgn, SubRgn, RGN_DIFF);
  DeleteObject(SubRgn);
  SetWindowRgn(Handle, Rgn, True {repainting is required});
end;


procedure TacWBContainer.UpdateScrollsWB;
var
  bVisibleH, bVisibleV: boolean;
  siH, siV: TScrollInfo;
  w, h: integer;
  s: string;
  body, documentElement: OleVariant;
begin
  if not WBWnd.bLoading and
       Assigned(WB.Document) and
         (IHtmldocument2(WB.Document).Body <> nil) and
           not VScrollBar.DrawingForbidden then begin
    // Lock scrolls
    VScrollBar.DrawingForbidden := True;
    HScrollBar.DrawingForbidden := True;
    // Preventing of the "out of range" error
    VScrollBar.LargeChange := 1;
    HScrollBar.LargeChange := 1;
    VScrollBar.PageSize := 1;
    HScrollBar.PageSize := 1;

    documentElement := Variant(WB.Document).documentElement;
    Body := IHtmldocument2(WB.Document).Body;

    // Scrolls data receiving
    siV.nMax := documentElement.scrollHeight;
    siH.nMax := documentElement.scrollWidth;

    w := WB.ClientWidth;
    h := WB.ClientHeight;

    if h = siV.nMax then begin
      siH.nMax := WB.OleObject.Document.Body.ScrollWidth;
      siV.nMax := WB.OleObject.Document.Body.ScrollHeight;
    end;

    s := documentElement.Style.OverflowY;
    if (s = 'scroll') then
      bVisibleV := True
    else
      if (s = 'visible') or (s = 'hidden') then
        bVisibleV := False
      else begin
        bVisibleV := siV.nMax > h;
        VScrollBar.Enabled := (h < integer(siV.nMax)) and (h > 0) and (siV.nMax > 0) and (siV.nMax <> h);
      end;

    if bVisibleV then
      inc(siH.nMax, GetSystemMetrics(SM_CXVSCROLL){ + 3});

    bVisibleH := (w < integer(siH.nMax)) and (w > 0) and (siH.nMax > 0);

    if bVisibleH then begin
      inc(siV.nMax, GetSystemMetrics(SM_CYHSCROLL){ + 3});
      bVisibleV := siV.nMax > h;
      VScrollBar.Enabled := (h < integer(siV.nMax)) and (h > 0) and (siV.nMax > 0) and (siV.nMax <> h);
    end;

    siV.nPage := h;
    siH.nPage := w;
    if siV.nPage > 0 then begin
      siV.nPos := WBWnd.ScrollPos(True);

      if siV.nPos < siV.nMax then begin
        VScrollBar.SetParams(siV.nPos, 0, siV.nMax);
        VScrollBar.PageSize := siV.nPage;
        VScrollBar.LargeChange := siV.nPage;
        VScrollBar.SmallChange := 32;

        siH.nPos := WBWnd.ScrollPos(False);

        if integer(siH.nPage) > siH.nMax then
          siH.nPage := siH.nMax;

        if integer(siH.nPage) < 0 then
          siH.nPage := 0;

        if siH.nMax >= integer(siH.nPage) then
          HScrollBar.SetParams(siH.nPos, 0, siH.nMax);

        HScrollBar.LargeChange := siH.nPage;
        HScrollBar.PageSize := siH.nPage;
        HScrollBar.SmallChange := 32;

        SetBounds(WB.Left, WB.Top, WB.Width, WB.Height);
        // Sizes of scrolls
        VScrollBar.Width := GetScrollMetric(WBWnd.sBarVert, SM_SCROLLWIDTH);
    //    VScrollBar.Width := GetSystemMetrics(SM_CXHTHUMB);
        HScrollBar.Height := GetScrollMetric(WBWnd.sBarHorz, SM_SCROLLWIDTH);
    //    HScrollBar.Height := GetSystemMetrics(SM_CYVTHUMB);

        VScrollBar.Height := Height - integer(bVisibleH) * (HScrollBar.Height) - 2 * bWidth;
        HScrollBar.Width := WB.Width - VScrollBar.Width - 2 * bWidth;

        VScrollBar.Left := WB.Width - VScrollBar.Width - bWidth;
        VScrollBar.Top := bWidth;

        HScrollBar.Left := bWidth;
        HScrollBar.Top := WB.Height - HScrollBar.Height - bWidth;

        Parent := TWinControl(WB).Parent;

        if not HScrollBar.Visible and bVisibleH then
          HScrollBar.Visible := True
        else
          if not bVisibleH then
            HScrollBar.Visible := False;

        if not VScrollBar.Visible and bVisibleV then
          VScrollBar.Visible := True
        else
          if not bVisibleV then
            VScrollBar.Visible := False;

        if SizeChanged then
          UpdateRgn;
        // Unlock scrolls
        VScrollBar.DrawingForbidden := False;
        HScrollBar.DrawingForbidden := False;

        BringToFront;
      end;
    end;
  end;
end;


destructor TacWBScrollBar.Destroy;
begin
  if Kind = sbVertical then
    Container.VScrollBar := nil
  else
    Container.HScrollBar := nil;

  inherited;
end;


procedure TacWBScrollBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_NOACTIVATE;
end;


constructor TScrollsUpdater.CreateOwned(AOwner: TacMainWnd);
begin
  inherited Create(nil);
  WB := TacMainWnd(AOwner);
  Iterations := 10;
  Interval := 100;
  OnTimer := OnAnimTimer;
end;


destructor TScrollsUpdater.Destroy;
begin
  Enabled := False;
  inherited;
end;


procedure TScrollsUpdater.OnAnimTimer(Sender: TObject);
begin
  if (WB <> nil) and (TacWBWnd(WB).WB <> nil) and not (csDestroying in TacWBWnd(WB).WB.ComponentState) and not Application.Terminated and (Iterations > 0) then begin
    dec(Iterations);
    TacWBWnd(WB).UpdateScrolls(False);
    if TacWBWnd(WB).ScrollPos(True) > 0 then // Updated already
      Iterations := 0;
  end
  else
    Iterations := 0;

  if Iterations = 0 then
    Enabled := False;
end;

end.
