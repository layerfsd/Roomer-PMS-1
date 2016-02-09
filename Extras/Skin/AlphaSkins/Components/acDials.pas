unit acDials;
{$I sDefs.inc}
///{$DEFINE LOGGED}

interface

uses
  {$IFDEF FPC} JwaWinUser, {$ENDIF}
  Controls, Graphics, Messages, SysUtils, Classes, Forms, menus, StdCtrls, Windows,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF FPC} LMessages, {$ENDIF}
  sSkinProvider, acSBUtils, sCommonData, sSkinManager, sConst;

type
  TacBorderStyle = (acbsDialog, acbsSingle, acbsNone, acbsSizeable, acbsToolWindow, acbsSizeToolWin);
  TacDialogWnd = class;
  TacProvider = class;


  TacSystemMenu = class(TsCustomSysMenu)
  public
    FOwner: TacDialogWnd;
    ItemRestore:  TMenuItem;
    ItemMove:     TMenuItem;
    ItemSize:     TMenuItem;
    ItemMinimize: TMenuItem;
    ItemMaximize: TMenuItem;
    ItemClose:    TMenuItem;
    constructor Create(AOwner: TComponent); override;
    function EnabledMove: boolean;
    function EnabledSize: boolean;
    procedure UpdateItems;

    procedure RestoreClick(Sender: TObject);
    procedure MoveClick   (Sender: TObject);
    procedure SizeClick   (Sender: TObject);
    procedure MinClick    (Sender: TObject);
    procedure MaxClick    (Sender: TObject);
    procedure CloseClick  (Sender: TObject);

    function EnabledMax: boolean; override;
    function EnabledMin: boolean; override;
    function EnabledRestore: boolean; override;

    function VisibleClose: boolean; override;
    function VisibleMax:   boolean; override;
    function VisibleMin:   boolean; override;
    function VisibleSize:  boolean;
  end;


  TacDialogWnd = class(TacScrollWnd)
  protected
    CurrentHT,
    FCaptionSkinIndex: integer;

    Initialized,
    FFormActive,
    FWMPaintForbidden: boolean;

    ArOR: TAOR;
    MoveTimer: TacMoveTimer;
    procedure InitExBorders(const Active: boolean);
  public
    ButtonMin,
    ButtonMax,
    ButtonHelp,
    ButtonClose: TsCaptionButton;

    TitleBG,
    TempBmp,
    TitleGlyph: TBitmap;

    dwStyle,
    dwExStyle: ACNativeInt;

    CoverForm: TForm;
    BorderForm: TacBorderForm;
    LastClientRect: TRect;
    TitleIcon: HIcon;
    TitleFont: TFont;
    FormState: Cardinal;
    RgnChanged: boolean;
    BorderStyle: TacBorderStyle;
    Adapter: TacCtrlAdapter;
    SystemMenu: TacSystemMenu;
    Provider: TacProvider;
    TitleIndex: integer;
    TitleSection: string;
    procedure SendToAdapter(Message: TMessage);
    // Drawing
    procedure MakeTitleBG;
    procedure PaintAll;
    procedure PaintBorderIcons;
    procedure PaintCaption(const DC: hdc);
    procedure PaintForm(var DC: hdc);
    procedure PrepareTitleGlyph;
    procedure RepaintButton(i: integer);

    procedure acWndProc(var Message: TMessage); override;
    procedure AfterCreation; override;
    destructor Destroy; override;
    procedure InitParams;
    procedure UpdateIconsIndexes;
    procedure KillAnimations;
    // Messages
    procedure Ac_WMPaint        (var Message: TWMPaint);
    procedure Ac_WMNCPaint      (var Message: TMessage);
    procedure Ac_WMNCHitTest    (var Message: TMessage);
    procedure Ac_WMNCLButtonDown(var Message: TWMNCLButtonDown);
    procedure Ac_WMLButtonUp    (var Message: TMessage);
    procedure Ac_WMNCActivate   (var Message: TMessage);
    procedure Ac_DrawStaticItem (var Message: TWMDrawItem);
    function  HTProcess         (var Message: TWMNCHitTest): integer;
    procedure SetHotHT(i: integer; Repaint: boolean = True);
    procedure SetPressedHT(i: integer);
{$IFNDEF FPC}
    procedure DropSysMenu(x, y: integer);
{$ENDIF}
    // Calculations
    function AboveBorder(Message: TWMNCHitTest): boolean;
    function BorderHeight: integer;
    function ButtonHeight(Index: integer): integer;
    function CaptionHeight(CheckSkin: boolean = True): integer;
    function CursorToPoint(x, y: integer): TPoint;
    function FormActive: boolean;
    function HeaderHeight: integer;
    function OffsetX: integer;
    function OffsetY: integer;
    function IconRect: TRect;
    function ShadowSize: TRect;
    function SysButtonWidth(const Btn: TsCaptionButton): integer;
    function TitleBtnsWidth: integer;

    function VisibleMax:     boolean;
    function VisibleMin:     boolean;
    function VisibleHelp:    boolean;
    function VisibleClose:   boolean;
    function VisibleRestore: boolean;

    function EnabledMax:     boolean;
    function EnabledMin:     boolean;
    function EnabledClose:   boolean;
    function EnabledRestore: boolean;
  end;


  TacProvider = class(TComponent)
  public
    CtrlHandle: THandle;
    sp: TsSkinProvider;
    ListSW: TacDialogWnd;
    acSkinnedCtrls: TList;
    destructor Destroy; override;
    procedure InitForm(Form: TCustomForm);
    function InitSkin(aHandle: hwnd): boolean;
    function InitHwndControls(hWnd: hwnd): boolean;
    function PrintHwndControls(hWnd: hwnd; DC: hdc): boolean;
    function AddControl(aHwnd: hwnd): boolean;
  end;


{$IFNDEF NOMNUHOOK}
  TacMnuArray = array of TacMnuWnd;
{$ENDIF}

var
  HookCallback: HHOOK;
  acSupportedList: TList;
  DlgLeft: integer = -1;
  DlgTop:  integer = -1;
{$IFNDEF NOMNUHOOK}
  MnuArray: TacMnuArray;
{$ENDIF}


function AddSupportedForm(hwnd: THandle; cStruct: PCreateStruct = nil): boolean;
function SkinHookCBT(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
function GetWndText(hwnd: THandle): WideString;
procedure UpdateRgn(ListSW: TacDialogWnd; Repaint: boolean = True);
procedure StartBlendOnMovingDlg(dw: TacDialogWnd);
procedure ClearMnuArray;


implementation

uses
  Commctrl, math, CommDlg,
{$IFDEF LOGGED}sDebugMsgs,{$ENDIF}
  sVclUtils, sMessages, acntUtils, sSkinProps, sGraphUtils, sMaskData, ExtCtrls,
  sAlphaGraph, sStyleSimply, sDefaults, acGlow, sThirdParty;


const
  rsfName = '#32770';
  s_TMessageForm = 'TMessageForm';


var
  biClicked:   boolean = False;
  RgnChanging: boolean = False;


procedure BroadCastHwnd(const hWnd: hwnd; Message: TMessage);
var
  hCtrl: THandle;
begin
  hCtrl := GetTopWindow(hWnd);
  while hCtrl <> 0 do begin
    SendMessage(hCtrl, Message.Msg, Message.WParam, Message.LParam);
    hCtrl := GetNextWindow(hCtrl, GW_HWNDNEXT);
  end;
end;


procedure FinishBlendOnMovingDlg(dw: TacDialogWnd);
var
  cx, cy: integer;
  TmpForm: TForm;
begin
  if dw.BorderForm <> nil then begin
    SetFormBlendValue(dw.BorderForm.AForm.Handle, dw.SkinData.FCacheBmp, MaxByte);
    cy := dw.BorderForm.OffsetY;
    cx := SkinBorderWidth(dw.BorderForm) - SysBorderWidth(dw.CtrlHandle, dw.BorderForm, False) + dw.ShadowSize.Left;
    // Update the form position
    SetWindowPos(dw.CtrlHandle, dw.BorderForm.AForm.Handle, dw.BorderForm.AForm.Left + cx, dw.BorderForm.AForm.Top + cy, 0, 0, {SWP_NOACTIVATE or }SWP_NOSENDCHANGING or SWP_NOREDRAW or SWP_NOZORDER or SWP_NOOWNERZORDER or SWP_NOSIZE);
    SetWindowPos(dw.BorderForm.AForm.Handle, 0, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOREDRAW or SWP_NOMOVE or SWP_NOOWNERZORDER or SWP_NOSIZE);
    dw.FormState := dw.FormState and not FS_BLENDMOVING;
    SetWindowLong(dw.CtrlHandle, GWL_EXSTYLE, GetWindowLong(dw.CtrlHandle, GWL_EXSTYLE) and not WS_EX_LAYERED);
    SetFocus(dw.CtrlHandle);
    RedrawWindow(dw.CtrlHandle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME or RDW_ALLCHILDREN or RDW_UPDATENOW);
    Sleep(40); // Avoid a blinking
    SetWindowPos(dw.BorderForm.AForm.Handle, dw.CtrlHandle, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOMOVE or SWP_NOREDRAW);
  end
  else begin
    TmpForm := MakeCoverForm(dw.CtrlHandle);
    SetWindowLong(dw.CtrlHandle, GWL_EXSTYLE, GetWindowLong(dw.CtrlHandle, GWL_EXSTYLE) and not WS_EX_LAYERED);
    UpdateWindow(dw.CtrlHandle);
    if Assigned(dw.MoveTimer) then
      dw.MoveTimer.Enabled := False;

    SetFocus(dw.CtrlHandle);
    RedrawWindow(dw.CtrlHandle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN or RDW_UPDATENOW);
    FreeAndNil(TmpForm);
    dw.FormState := dw.FormState and not FS_BLENDMOVING;
  end;
  if Assigned(dw.MoveTimer) then begin
    dw.MoveTimer.CurrentBlendValue := MaxByte;
    FreeAndNil(dw.Movetimer);
  end;
  if dw.BorderForm <> nil then begin
    dw.BorderForm.ExBorderShowing := False;
    dw.BorderForm.UpdateExBordersPos;
  end;
end;


procedure StartBlendOnMovingDlg(dw: TacDialogWnd);
var
  TmpForm: TForm;
begin
  if (dw.FormState and FS_BLENDMOVING <> FS_BLENDMOVING) then 
    if dw.SkinData.SkinManager.AnimEffects.BlendOnMoving.Active then begin
      dw.FormState := dw.FormState or FS_BLENDMOVING;
      if Assigned(dw.MoveTimer) then
        FreeAndNil(dw.Movetimer);

      dw.Movetimer := TacMoveTimer.CreateOwned(Application, True);
      dw.MoveTimer.CurrentBlendValue := MaxByte;

      dw.Movetimer.BorderForm := dw.BorderForm;
      dw.Movetimer.FormHandle := dw.CtrlHandle;

      dw.MoveTimer.BlendValue := dw.SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue;
      dw.MoveTimer.BlendStep := (MaxByte - dw.MoveTimer.BlendValue) div 30;
      dw.MoveTimer.Interval := acTimerInterval;
      if dw.BorderForm <> nil then begin
        dw.BorderForm.UpdateExBordersPos(True);
        dw.BorderForm.ExBorderShowing := True;
        SetWindowPos(dw.CtrlHandle, dw.BorderForm.AForm.Handle, 0, 0, 0, 0, SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOMOVE or SWP_NOREDRAW);
        SetWindowLong(dw.CtrlHandle, GWL_EXSTYLE, GetWindowLong(dw.CtrlHandle, GWL_EXSTYLE) or WS_EX_LAYERED);
        SetFormBlendValue(dw.CtrlHandle, nil, 0);
        dw.MoveTimer.Enabled := True;
        dw.BorderForm.AForm.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
      end
      else begin
        TmpForm := MakeCoverForm(dw.CtrlHandle);
        if GetWindowLong(dw.CtrlHandle, GWL_EXSTYLE) and WS_EX_LAYERED <> WS_EX_LAYERED then
          SetWindowLong(dw.CtrlHandle, GWL_EXSTYLE, GetWindowLong(dw.CtrlHandle, GWL_EXSTYLE) or WS_EX_LAYERED);

        SetLayeredWindowAttributes(dw.CtrlHandle, clNone, MaxByte, ULW_ALPHA);
        RedrawWindow(dw.CtrlHandle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_UPDATENOW);
        FreeAndNil(TmpForm);
        dw.MoveTimer.Enabled := True;
        SendMessage(dw.CtrlHandle, WM_SYSCOMMAND, SC_DRAGMOVE, 0);
      end;
      FinishBlendOnMovingDlg(dw);
    end;
end;


function VisibleDlgCount: integer;
var
  i: integer;
  ap: TacProvider;
begin
  Result := 0;
  for i := 0 to acSupportedList.Count - 1 do begin
    ap := TacProvider(acSupportedList[i]);
    if (ap <> nil) and (ap.sp = nil) and ((ap.ListSW <> nil) and IsWindowVisible(ap.ListSW.CtrlHandle) or IsWindowVisible(ap.CtrlHandle)) then
      inc(Result);
  end;
end;


function ControlExists(CtrlHandle: hwnd; const Name: string): boolean;
var
  hCtrl: THandle;
begin
  Result := False;
  hCtrl := GetTopWindow(CtrlHandle);
  while hCtrl <> 0 do begin
    if (LowerCase(GetWndClassName(hCtrl)) = Name) then begin
      Result := True;
      Exit;
    end
    else
      if ControlExists(hCtrl, Name) then begin
        Result := True;
        Exit;
      end;

    hCtrl := GetNextWindow(hCtrl, GW_HWNDNEXT);
  end;
end;


procedure CleanArray;
var
  i: integer;
  ap: TacProvider;
begin
  if acSupportedList <> nil then
    for i := 0 to acSupportedList.Count - 1 do begin
      ap := TacProvider(acSupportedList[i]);
      if (ap <> nil) and (ap.ListSW <> nil) and ap.ListSW.Destroyed then begin
        acSupportedList[i] := nil;
        FreeAndNil(ap);
      end;
    end;
end;


function SkinHookCBT(code: integer; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  wHandle: THandle;
{$IFDEF FPC}
  cw: ^TCBTCreateWndW;
{$ELSE}
  cw: ^TCBTCreateWnd;
  sp: TacSkinParams;
  i: integer;
{$ENDIF}
  l: longint;
begin
{  if (code in [HCBT_SETFOCUS, HCBT_ACTIVATE]) and (GetProp(THandle(WParam), s_NoFocusProp) <> 0) then begin
    Result := 1; // Prevent
    Exit;
  end;}
  Result := CallNextHookEx(HookCallback, Code, wParam, lParam);
  if (Application <> nil) and not (csDestroying in Application.ComponentState) then
    case code of
      HCBT_CREATEWND:
        if wParam <> 0 then begin
          wHandle := Thandle(wParam);
          cw := pointer(lparam);
          l := longint(cw.lpcs^.lpszClass);
          case l of
            32768: {$IFNDEF NOMNUHOOK} // Menu
              if (DefaultManager <> nil) and DefaultManager.SkinnedPopups then
                if not WndIsSkinned(wHandle{GetBoolMsg(wHandle, ac_CtrlHandled}) then begin
                  i := length(MnuArray);
                  SetLength(MnuArray, i + 1);
                  sp.SkinSection := s_MainMenu;
                  sp.Control := nil;
                  MnuArray[i] := TacMnuWnd.Create(wHandle, nil, DefaultManager, sp, False);
                  MnuArray[i].CtrlHandle := wHandle;
                end
            {$ENDIF};

            32770: // Sys dialog
              AddSupportedForm(wHandle);

            0..32767, 32769, 32771..MaxWord:
              // Skipped

            else
              if GetWndClassName(wHandle) <> 'TPUtilWindow' then
                if (cw.lpcs^.dwExStyle <> 0) and (cw.lpcs^.Style <> 0) then begin
                  if (Application.MainForm <> nil) and (not Application.MainForm.HandleAllocated or (Application.MainForm.Handle = wHandle)) then
                    Exit;

                  if (GetParent(wHandle) = 0) then
                    AddSupportedForm(wHandle);
                end
          end;
        end;

      HCBT_ACTIVATE:
        AddSupportedForm(THandle(wParam));

//      HCBT_DESTROYWND:
//        CleanArray;
    end;
end;


function FindFormInList(hwnd: THandle): TObject;
var
  i: integer;
  ap: TacProvider;
begin
  Result := nil;
  if (acSupportedList <> nil) and not Application.Terminated then
    for i := 0 to acSupportedList.Count - 1 do begin
      ap := TacProvider(acSupportedList[i]);
      if (ap <> nil) and (ap.CtrlHandle = hwnd) then begin
        Result := ap;
        Break;
      end;
    end;
end;


function FindFormOnScreen(hwnd: THandle): TCustomForm;
var
  i, j: integer;
  f: TCustomForm;
begin
  Result := nil;
  for i := Screen.CustomFormCount - 1 downto 0 do begin
    f := Screen.CustomForms[i];
    if (f = nil) or (csDestroying in f.ComponentState) then
      Continue;

    if not f.HandleAllocated then
      Continue;

    if f.Handle = hwnd then begin
      Result := f;
      Exit;
    end;
    with TForm(f) do
      if FormStyle = fsMDIForm then
        for j := 0 to MDIChildCount - 1 do
          if MDIChildren[j].Handle = hwnd then begin
            Result := TForm(f).MDIChildren[j];
            Exit;
          end;
  end;
end;

function AddSupportedForm(hwnd: THandle; cStruct: PCreateStruct = nil): boolean;
var
  i: integer;
  ap: TacProvider;
  Form: TCustomForm;
  pClassName: PChar;
  DlgData: TacSysDlgData;
begin
  Result := False;
  if (DefaultManager <> nil) and not (csDestroying in Application.ComponentState) then
    if not WndIsSkinned(hwnd){GetBoolMsg(hwnd, AC_CTRLHANDLED)} then begin
      if (cStruct <> nil) and (Length(cStruct^.lpszClass) > 0) then
        pClassName := cStruct^.lpszClass
      else
        pClassName := PChar(GetWndClassName(hwnd));

      if (GetWindowLong(hwnd, GWL_STYLE) and WS_POPUP = WS_POPUP) and (GetWindowLong(hwnd, GWL_STYLE) and WS_BORDER <> WS_BORDER) then
        Exit;

      if FindFormInList(hwnd) = nil then begin
        Form := FindFormOnScreen(hwnd);
        if (Form <> nil) then begin
          if (Form.Tag and ExceptTag = ExceptTag) then
            Exit;

          if not (csLoading in Form.ComponentState) or (TForm(Form).FormStyle = fsMDIChild) then begin
            for i := 0 to ThirdPartySkipForms.Count - 1 do
              if lstrcmp(pClassName, PChar(ThirdPartySkipForms[i])) = 0 then
                Exit;

            if lstrcmp(pClassName, PChar(s_TMessageForm)) = 0 then begin
              if not (srStdDialogs in DefaultManager.SkinningRules) then
                Exit;
            end
            else
              if not (srStdForms in DefaultManager.SkinningRules) then
                Exit;

            ap := TacProvider.Create(Form);
            acSupportedList.add(ap);
            ap.InitForm(Form);
            if Assigned(ap.sp) then
              ap.sp.MakeSkinMenu := False;
            // Add MDIChild which haven't a SkinProvider
            if TForm(Form).FormStyle = fsMDIForm then
              for i := 0 to TForm(Form).MDIChildCount - 1 do
                if not WndIsSkinned(TForm(Form).MDIChildren[i].Handle{ GetBoolMsg(TForm(Form).MDIChildren[i].Handle, AC_CTRLHANDLED}) then begin
                  ap := TacProvider.Create(TForm(Form).MDIChildren[i]);
                  acSupportedList.add(ap);
                  ap.InitForm(TForm(Form).MDIChildren[i]);
                end;
          end
        end
        else
          if ((pClassName = rsfName) or (pClassName = 'NativeHWNDHost')) and (GetParent(hwnd) = 0) {Prevent of control skinning, if not a Windows dialog} then
            if srStdDialogs in DefaultManager.SkinningRules then
              if (VisibleDlgCount > ac_DialogsLevel - 1) and not ControlExists(hwnd, 'toolbarwindow32') then
                Exit
              else begin
                Result := True;
                if Assigned(DefaultManager.OnSysDlgInit) then begin
                  DlgData.WindowHandle := hwnd;
                  DefaultManager.OnSysDlgInit(DlgData, Result);
                end;
                if Result then begin
                  ap := TacProvider.Create(nil);
                  ap.CtrlHandle := hwnd;
                  if not ap.InitSkin(hwnd) then
                    FreeAndNil(ap)
                  else
                    acSupportedList.add(ap);
                end;
                Exit;
              end
            else
              Exit;

        Result := True;
      end;
    end;
end;


function TacProvider.AddControl(aHwnd: hwnd): boolean;
var
  R: TRect;
  st: dword;
  i: integer;
  Wnd: TacMainWnd;
  sp: TacSkinParams;
  Style: ACNativeInt;
  pClassName: string;
begin
  Result := False;
  if (aHwnd <> 0) then begin
    Result := True;
    if WndIsSkinned(aHwnd{GetBoolMsg(aHwnd, AC_CTRLHANDLED}) then
      Exit;

    acDlgMode := True;
    pClassName := LowerCase(GetWndClassName(aHwnd));
    Style := GetWindowLong(aHwnd, GWL_STYLE);
    Wnd := nil;
    sp.SkinSection := '';
    sp.Control := nil;
    sp.VertScrollSize := -1;
    sp.HorzScrollSize := -1;
    sp.VertScrollBtnSize := -1;
    sp.HorzScrollBtnSize := -1;
    sp.UseSkinColor := True;
    sp.UseSkinFontColor := True;
    if pClassName = 'static' then begin
      st := Style and SS_TYPEMASK;
      if (Style and SS_ICON = SS_ICON) or (Style and SS_BITMAP = SS_BITMAP) then // Icon or Bitmap
        if (GetWindowLong(aHwnd, GWL_EXSTYLE) and WS_EX_STATICEDGE = WS_EX_STATICEDGE) then begin
          sp.SkinSection := s_Edit;
          Wnd := TacEdgeWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
        end
        else
          Wnd := TacIconWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
      else
        if not (Style and SS_OWNERDRAW = SS_OWNERDRAW) then
          if not (st in [SS_SIMPLE, SS_GRAYRECT, SS_WHITERECT]) then
            Wnd := TacStaticWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
    end
    else
      if (pClassName = rsfName) then
        Wnd := TacTransPanelWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
      else
        if (pClassName = 'tpanel') then begin
          sp.SkinSection := s_Transparent;
          Wnd := TacPanelWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
          Wnd.SkinData.FOwnerControl := FindControl(aHwnd);
          if (Wnd.SkinData.FOwnerControl <> nil) and (Wnd.SkinData.FOwnerControl is TWinControl) then begin
            for i := 0 to TWinControl(Wnd.SkinData.FOwnerControl).ControlCount - 1 do
              if TWinControl(Wnd.SkinData.FOwnerControl).Controls[i] is TCustomLabel then begin
                TsHackedControl(TWinControl(Wnd.SkinData.FOwnerControl).Controls[i]).Font.Color := ListSW.SkinData.SkinManager.GetGlobalFontColor;
                TLabel(TWinControl(Wnd.SkinData.FOwnerControl).Controls[i]).Transparent := True;
              end
              else
                if TWinControl(Wnd.SkinData.FOwnerControl).Controls[i] is TWinControl then
                  AddControl(TWinControl(TWinControl(Wnd.SkinData.FOwnerControl).Controls[i]).Handle);

            TsHackedControl(Wnd.SkinData.FOwnerControl).Color := ListSW.SkinData.SkinManager.GetGlobalColor;
          end;
        end
        else
          if pClassName = 'tsilentpaintpanel' then begin
            sp.SkinSection := s_GroupBox;
            Wnd := TacPanelWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
            Wnd.SkinData.FOwnerControl := FindControl(aHwnd);
            if Wnd.SkinData.FOwnerControl <> nil then begin
              TacPanelWnd(Wnd).Panel := TacAccessPanel(Wnd.SkinData.FOwnerControl);
              TPanel(Wnd.SkinData.FOwnerControl).Caption := '';
              TacPanelWnd(Wnd).Panel.Tag := 999;
            end;
            Wnd.SkinData.BGChanged := True;
          end
          else
            if pClassName = 'edit' then begin
              if ListSW <> nil then
                ListSW.FWMPaintForbidden := False;

              if IsWindowVisible(aHwnd) then begin // Solving a problem in non-sizeable file dialogs
                sp.SkinSection := s_Edit;
                Wnd := TacEditWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp, not ListSW.SkinData.FCacheBmp.Empty);
                TacEditWnd(Wnd).DlgMode := True;
              end
            end
            else
              if (pClassName = 'button') and (Style and BS_OWNERDRAW <> BS_OWNERDRAW) or (pClassName = 'tbutton') then
                if Style and BS_GROUPBOX = BS_GROUPBOX then begin
                  sp.SkinSection := s_GroupBox;
                  Wnd := TacGroupBoxWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                end
                else
                  if (Style and BS_AUTOCHECKBOX = BS_AUTOCHECKBOX) or (Style and BS_CHECKBOX = BS_CHECKBOX) or (Style and BS_3STATE = BS_3STATE) then
                    Wnd := TacCheckBoxWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                  else
                    if (Style and BS_AUTORADIOBUTTON = BS_AUTORADIOBUTTON) or (Style and BS_RADIOBUTTON = BS_RADIOBUTTON) then
                      Wnd := TacCheckBoxWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                    else
                      Wnd := TacBtnWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
              else
                if pClassName = 'combobox' then begin
                  if ListSW <> nil then
                    ListSW.FWMPaintForbidden := False;

                  sp.SkinSection := s_ComboBox;
                  Wnd := TacComboBoxWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp, not ListSW.SkinData.FCacheBmp.Empty);
                  TacEditWnd(Wnd).DlgMode := True;
                end
                else
                  if pClassName = 'combolbox' then begin
                    if ListSW <> nil then
                      ListSW.FWMPaintForbidden := False;

                    sp.SkinSection := s_ComboBox;
                    Wnd := TacEditWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                  end
                  else
                    if pClassName = 'comboboxex32' then begin
                      if ListSW <> nil then
                        ListSW.FWMPaintForbidden := False;

                      sp.SkinSection := s_ComboBox;
                      Wnd := TacComboBoxWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                    end
                    else
                      if pClassName = 'scrollbar' then begin
                        Style := GetWindowLong(aHwnd, GWL_STYLE);
                        if Style and SBS_SIZEGRIP = SBS_SIZEGRIP then
                          Wnd := TacSizerWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                      end
                      else
                        if pClassName = 'systabcontrol32' then begin
                          if ((Style and TCS_OWNERDRAWFIXED) <> TCS_OWNERDRAWFIXED) then begin
                            sp.SkinSection := s_PageControl;
                            Wnd := TacTabControlWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                          end;
                        end
                        else
                          if pClassName = 'syslistview32' then begin
                            sp.SkinSection := s_Edit;
                            Wnd := TacListViewWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                            TacEditWnd(Wnd).DlgMode := True;
                          end
                          else
                            if pClassName = UPDOWN_CLASS then begin
                              sp.SkinSection := s_SpeedButton_Small;
                              Wnd := TacSpinWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                              TacSpinWnd(Wnd).lOffset := 2;
                            end
                            else
                              if pClassName = TRACKBAR_CLASS then begin
                                sp.SkinSection := s_TrackBar;
                                Wnd := TacTrackWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                              end
                              else
                                if pClassName = 'listbox' then begin
                                  if ListSW <> nil then
                                    ListSW.FWMPaintForbidden := False;

                                  sp.SkinSection := s_Edit;
                                  Wnd := TacEditWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                                  TacEditWnd(Wnd).DlgMode := True;
                                end
                                else
                                  if (pClassName = 'link window') or (pClassName = 'syslink') then
                                    Wnd := TacLinkWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                                  else
                                    if pClassName = 'toolbarwindow32' then begin
                                      if GetWindowLong(aHwnd, GWL_STYLE) and TBSTYLE_WRAPABLE = TBSTYLE_WRAPABLE then begin
                                        sp.SkinSection := s_Bar;
                                        Wnd := TacToolBarWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                                      end
                                      else begin
                                        sp.SkinSection := s_Transparent;
                                        Wnd := TacToolBarWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                                      end;
                                    end
                                    else
                                      if pClassName = 'systreeview32' then begin
                                        sp.SkinSection := s_Edit;
                                        Wnd := TacTreeViewWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp);
                                        TacEditWnd(Wnd).DlgMode := True;
                                      end
                                      else
                                        if pClassName = 'shbrowseforfolder' then
                                          Wnd := TacTransPanelWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                                        else
                                          if pClassName = 'ctrlnotifysink' then
                                            // Skip
                                          else
                                            // Vista+ file dialogs elements
                                            if (pClassName = 'rebarwindow32') or
                                                 (pClassName = 'msctls_progress32') or
                                                   (pClassName = 'universalsearchband') or
                                                     (pClassName = 'address band root') or
                                                       (pClassName = 'workerw') or
                                                         (pClassName = 'search box') or
                                                           (pClassName = 'travelband') or
                                                             (pClassName = 'breadcrumb parent') then begin
                                              if IsWindowVisible(aHwnd) then
                                                Wnd := TacContainerWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                                            end
                                            else
                                              if (pClassName = 'directuihwnd') then begin // search panel in new file dialogs
                                                GetWindowRect(aHwnd, R);
                                                if HeightOf(R) = 24 then
                                                  Wnd := TacSearchWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, sp)
                                              end
  {
                                              else
                                                if pClassName = 'searcheditboxwrapperclass' then
                                                  Wnd := TacContainerWnd.Create(aHwnd, nil, ListSW.SkinData.SkinManager, s_Transparent)};
    if Wnd <> nil then begin
      acSkinnedCtrls.Add(Wnd);
      InitCtrlData(CtrlHandle, Wnd.ParentWnd, Wnd.WndRect, Wnd.ParentRect, Wnd.WndSize, Wnd.WndPos);
    end;
    acDlgMode := False;
  end;
end;


destructor TacProvider.Destroy;
var
  i: integer;
begin
  if (sp = nil) then begin
    if acSkinnedCtrls <> nil then begin
      for i := 0 to acSkinnedCtrls.Count - 1 do
        if acSkinnedCtrls[i] <> nil then
          TObject(acSkinnedCtrls[i]).Free;

      FreeAndNil(acSkinnedCtrls);
    end;
    if (ListSW <> nil) then
      FreeAndNil(ListSW);
  end
  else
    for i := 0 to acSupportedList.Count - 1 do
      if acSupportedList[i] = Self then begin
        acSupportedList[i] := nil;
        Break;
      end;

  inherited;
end;


procedure TacProvider.InitForm(Form: TCustomForm);
begin
  sp := TsSkinProvider.CreateRT(Form);
  sp.UseGlobalColor := False; // Solving a maximizing problem when some controls have defined the OnPaint event
  sp.Form := TForm(Form);
  CtrlHandle := sp.Form.Handle;
  if AeroIsEnabled then begin // Special initialization is required later
    if sp.Adapter = nil then
      sp.Loaded;

    RedrawWindow(sp.Form.Handle, nil, 0, {RDW_FRAME or }RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE or RDW_UPDATENOW);
    SendMessage(sp.Form.Handle, WM_NCPAINT, 0, 0);
  end
  else // Updating of standard and 3rd-party ctrls
    if not IsIDERunning then begin // Avoiding of DbgBreakPoint issue
      UpdateWindow(sp.Form.Handle);
      RedrawWindow(sp.Form.Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE);
    end;

  sp.MakeSkinMenu := (Form.BorderStyle in [bsSizeable, bsSingle]) and DefMakeSkinMenu;
end;


function TacProvider.InitHwndControls(hWnd: hwnd): boolean;
var
  hCtrl: THandle;
begin
  Result := True;
  hCtrl := GetTopWindow(hWnd);
  while hCtrl <> 0 do begin
    if not InitHwndControls(hCtrl) then begin
      Result := False;
      Exit;
    end;
    if (GetWindowLong(hCtrl, GWL_STYLE) and WS_CHILD) = WS_CHILD then
      if not AddControl(hCtrl) then begin
        Result := False;
        Exit;
      end;

    hCtrl := GetNextWindow(hCtrl, GW_HWNDNEXT);
  end;
end;


procedure InitDialog(hwnd: THandle; var ListSW: TacDialogWnd);
var
  sp: TacSkinParams;
begin
  if Assigned(DefaultManager) and DefaultManager.Active then begin
    if Assigned(Ac_UninitializeFlatSB) then
      Ac_UninitializeFlatSB(hwnd);

    if (ListSW <> nil) and ListSW.Destroyed then
      FreeAndNil(ListSW);

    if ListSW = nil then begin
      sp.SkinSection := s_Dialog;
      sp.HorzScrollBtnSize := -1;
      sp.VertScrollBtnSize := -1;
      sp.HorzScrollSize := -1;
      sp.VertScrollSize := -1;
      sp.UseSkinColor := True;
      sp.UseSkinFontColor := True;
      sp.Control := nil;
      ListSW := TacDialogWnd.Create(hwnd, nil, DefaultManager, sp, False);
      ListSW.CtrlHandle := hwnd;
    end;
  end
  else begin
    if ListSW <> nil then
      FreeAndNil(ListSW);

    if Assigned(Ac_InitializeFlatSB) then
      Ac_InitializeFlatSB(hwnd);
  end;
end;


function TacProvider.InitSkin(aHandle: hwnd): boolean;
var
  i: integer;
begin
  Result := True;
  CtrlHandle := aHandle;
  acSkinnedCtrls := TList.Create;
  if (ListSW = nil) and (DefaultManager <> nil) and DefaultManager.Active then begin
    InitDialog(CtrlHandle, ListSW);
    ListSW.Provider := Self;
    if (DlgLeft <> -1) or (DlgTop <> -1) then
      SetWindowPos(CtrlHandle, 0, DlgLeft, DlgTop, 0, 0, SWP_NOOWNERZORDER or SWP_NOREDRAW or SWP_NOSIZE);

    if InitHwndControls(CtrlHandle) then begin
      ListSW.InitParams;
      SendAMessage(CtrlHandle, AC_SETNEWSKIN, longword(DefaultManager));
    end
    else begin
      for i := 0 to acSupportedList.Count - 1 do
        if acSupportedList[i] = Self then
          acSupportedList[i] := nil;

      Result := False;
    end;
  end;
end;


function TacProvider.PrintHwndControls(hWnd: hwnd; DC: hdc): boolean;
var
  hCtrl: THandle;
  lpPos: TPoint;
  SavedDC: hdc;
  R: TRect;
begin
  Result := False;
  hCtrl := GetTopWindow(hWnd);
  while hCtrl <> 0 do begin
    SavedDC := SaveDC(DC);
    GetWindowRect(hCtrl, R);
    lpPos := R.TopLeft;
    ScreenToClient(GetParent(hCtrl), lpPos);
    MoveWindowOrg(DC, lpPos.X, lpPos.Y);
    if ((GetWindowLong(hCtrl, GWL_STYLE) and WS_CHILD) = WS_CHILD) and ((GetWindowLong(hCtrl, GWL_STYLE) and WS_VISIBLE) = WS_VISIBLE) then begin
      SendAMessage(hCtrl, AC_PRINTING, LPARAM(DC));
      SendMessage(hCtrl, WM_PRINT, LPARAM(DC), 0);
      SendAMessage(hCtrl, AC_PRINTING, 0);
    end;
    PrintHwndControls(hCtrl, DC);
    RestoreDC(DC, SavedDC);
    hCtrl := GetNextWindow(hCtrl, GW_HWNDNEXT);
  end;
end;


procedure DrawAppIcon(ListSW: TacDialogWnd);
var
  SmallIcon: HIcon;
  IcoSize: TSize;
  x, y: integer;
begin
  if ListSW.TitleIcon <> 0 then begin
    IcoSize := MkSize(GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CYSMICON));
    x := SysBorderWidth(ListSW.CtrlHandle, ListSW.BorderForm) + ListSW.SkinData.SkinManager.CommonSkinData.BILeftMargin;
    y := (ListSW.CaptionHeight + SysBorderHeight(ListSW.CtrlHandle, ListSW.BorderForm) - IcoSize.cy) div 2;
    if ListSW.BorderForm <> nil then begin
      inc(x, ListSW.BorderForm.ShadowSize.Left);
      inc(y, ListSW.BorderForm.ShadowSize.Top);
    end;
    SmallIcon := Windows.CopyImage(ListSW.TitleIcon, IMAGE_ICON, IcoSize.cx, IcoSize.cy, LR_COPYFROMRESOURCE);
    if SmallIcon <> 0 then begin
      DrawIconEx(ListSW.SkinData.FCacheBmp.Canvas.Handle, x, y, SmallIcon, IcoSize.cx, IcoSize.cy, 0, 0, DI_NORMAL);
      DestroyIcon(SmallIcon);
    end
    else
      DrawIconEx(ListSW.SkinData.FCacheBmp.Canvas.Handle, x, y, LoadIcon(0, IDI_APPLICATION), IcoSize.cx, IcoSize.cy, 0, 0, DI_NORMAL);
  end
end;


function GetWndText(hwnd: THandle): WideString;
var
  buf: array[0..1000] of char;
begin
  Result := '';
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
    SetLength(Result, GetWindowTextLengthW(hwnd) + 1);
    GetWindowTextW(hwnd, PWideChar(Result), Length(Result));
    SetLength(Result, Length(Result) - 1);
  end
  else begin
    SendMessage(hwnd, WM_GETTEXT, 1000, LPARAM(@buf));
    Result := StrPas(buf);
  end;
end;


procedure FillArOR(ListSW: TacDialogWnd);
var
  i: integer;
begin
  SetLength(ListSW.ArOR, 0);
  if ListSW.SkinData.SkinManager.IsValidImgIndex(ListSW.SkinData.BorderIndex) then begin
    // TopBorderRgn
    AddRgn(ListSW.ArOR, ListSW.WndSize.cx, ListSW.SkinData.SkinManager.ma[ListSW.SkinData.BorderIndex], 0, False);
    // BottomBorderRgn
    AddRgn(ListSW.ArOR, ListSW.WndSize.cx, ListSW.SkinData.SkinManager.ma[ListSW.SkinData.BorderIndex], ListSW.WndSize.cy - ListSW.SkinData.SkinManager.ma[ListSW.SkinData.BorderIndex].WB, True);
  end;
  // TitleRgn
  if ListSW.SkinData.SkinManager.IsValidSkinIndex(ListSW.TitleIndex) then begin
    i := ListSW.SkinData.SkinManager.GetMaskIndex(ListSW.TitleIndex, ListSW.TitleSection, s_BordersMask);
    if ListSW.SkinData.SkinManager.IsValidImgIndex(i) then
      AddRgn(ListSW.ArOR, ListSW.WndSize.cx, ListSW.SkinData.SkinManager.ma[i], 0, False);
  end;
end;


function GetRgnFromArOR(ListSW: TacDialogWnd; X: integer = 0; Y: integer = 0): hrgn;
var
  l, i: integer;
  subrgn: HRGN;
begin
  l := Length(ListSW.ArOR);
  Result := CreateRectRgn(X, Y, ListSW.WndSize.cx + X, ListSW.WndSize.cy + Y);
  if l > 0 then
    for i := 0 to l - 1 do begin
      subrgn := CreateRectRgn(ListSW.ArOR[i].Left + X, ListSW.ArOR[i].Top + Y, ListSW.ArOR[i].Right + X, ListSW.ArOR[i].Bottom + Y);
      CombineRgn(Result, Result, subrgn, RGN_DIFF);
      DeleteObject(subrgn);
    end;
end;


procedure UpdateRgn(ListSW: TacDialogWnd; Repaint: boolean = True);
const
  BE_ID = $41A2;
  CM_BEWAIT = CM_BASE + $0C4D;
var
  rgn: HRGN;
  sbw: integer;
begin
  if IsIconic(ListSW.CtrlHandle) or (ListSW.BorderStyle <> acbsNone) then
    with ListSW do
      if SendMessage(CtrlHandle, CM_BEWAIT, BE_ID, 0) <> BE_ID then begin // BE compatibility
        RgnChanging := True;
        if (BorderForm <> nil) then begin
          sbw := SysBorderWidth(CtrlHandle, BorderForm, False);
{$IFNDEF NOFONTSCALEPATCH}
          if ListSW.SkinData.SkinManager.SysFontScale > 0 then
            rgn := CreateRectRgn(sbw, SysBorderHeight(CtrlHandle, BorderForm, False) + CaptionHeight(False) + SysBorderWidth(CtrlHandle, BorderForm, False) - 1, WndSize.cx - sbw, WndSize.cy - sbw + 1)
          else
{$ENDIF}
            rgn := CreateRectRgn(sbw, SysBorderHeight(CtrlHandle, BorderForm, False) + CaptionHeight(False) + SysBorderWidth(CtrlHandle, BorderForm, False), WndSize.cx - sbw, WndSize.cy - sbw);
        end
        else
          rgn := GetRgnFromArOR(ListSW);

        SetWindowRgn(CtrlHandle, rgn, Repaint); // True - repainting required
      end;
end;


type
  TExcludeData = record
    CtrlHandle: hwnd;
    DC: hdc;
    OffsetX: integer;
    OffsetY: integer;
  end;
  PExcludeData = ^TExcludeData;


function EnumCtrls(Child: HWND; Data: LParam): BOOL; stdcall;
var
  eData: TExcludeData;
  Style: Cardinal;
  Pos: TPoint;
  R: TRect;
begin
  eData := PExcludeData(Data)^;
  Result := True;
  if (GetParent(Child) = eData.CtrlHandle) then begin
    Style := GetWindowLong(Child, GWL_STYLE);
    if (Style and WS_VISIBLE = WS_VISIBLE) then begin
      if (LowerCase(GetWndClassName(Child)) = 'static') and (Style and WS_TABSTOP = WS_TABSTOP) then
        Exit; // Skip Colors panel in Color dialog

      GetWindowRect(Child, R);
      Pos := R.TopLeft;
      ScreenToClient(eData.CtrlHandle, Pos);
      OffsetRect(R, Pos.X - R.Left + eData.OffsetX, Pos.Y - R.Top + eData.OffsetY);
      if (Style and BS_GROUPBOX <> BS_GROUPBOX) then
        ExcludeClipRect(eData.DC, R.Left, R.Top, R.Right, R.Bottom);
    end;
  end;
end;


procedure ExcludeControls(const DC: hdc; const Ctrl: hwnd; const OffsetX: integer; const OffsetY: integer);
var
  eData: TExcludeData;
begin
  if not Application.IsRightToLeft then begin
    eData.CtrlHandle := Ctrl;
    eData.DC := DC;
    eData.OffsetX := OffsetX;
    eData.OffsetY := OffsetY;
    EnumChildWindows(Ctrl, @EnumCtrls, LPARAM(@eData));
  end;
end;


procedure TacDialogWnd.acWndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  X, Y, i: integer;
  cR, rClient: TRect;
begin
{$IFDEF LOGGED}
  if (SkinData <> nil) and (SkinData.SkinSection <> 'DIALOG') then
    AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_DESTROY, WM_NCDESTROY: begin
      if (OldProc <> nil) or Assigned(OldWndProc) then begin
        Message.Result := CallPrevWndProc(CtrlHandle, Message.Msg, Message.WParam, LPARAM(Message.LParam));
        UninitializeACWnd(CtrlHandle, False, False, TacMainWnd(Self));
        Destroyed := True;
      end
      else
        Message.Result := SendMessage(CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

      Exit;
    end;

    SM_ALPHACMD:
      case Message.WParamHi of
        AC_SETNEWSKIN: begin
          InitExBorders(SkinData.SkinManager.ExtendedBorders);
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            SkinData.UpdateIndexes;
            FCaptionSkinIndex := SkinData.SkinManager.ConstData.Sections[ssCaption];
            if (SkinData.SkinManager <> nil) then
              UpdateIconsIndexes;

            BroadCastHwnd(CtrlHandle, Message);
          end;
          Exit;
        end;

        AC_REFRESH: begin
          SkinData.UpdateIndexes;
          InitExBorders(SkinData.SkinManager.ExtendedBorders);
          SkinData.Invalidate;
          if (BorderForm <> nil) and IsWindowVisible(CtrlHandle) then
            BorderForm.UpdateExBordersPos;

          Exit;
        end;

        AC_PREPARING:
          if (SkinData <> nil) then begin
            Message.Result := LRESULT(SkinData.FUpdating);
            Exit;
          end;

        AC_GETBORDERWIDTH: begin
          GetWindowRect(CtrlHandle, cR);
          GetClientRect(CtrlHandle, rClient);
          Message.Result := (WidthOf(cR) - WidthOf(rClient)) div 2;
{
          if (ListSW <> nil) and (ListSW.cxLeftEdge <> 0) then
            Message.Result := ListSW.cxLeftEdge
          else
            Message.Result := Message.LParam;
}
          Exit;
        end;

        AC_UPDATING: begin
          SkinData.FUpdating := Message.WParamLo = 1;
          if SkinData.Updating then
            SkinData.BGChanged := True;
        end;

        AC_GETCONTROLCOLOR: begin
          Message.Result := GetBGColor(SkinData, 0);
          Exit;
        end;

        AC_GETBG: begin
          if PacBGInfo(Message.LParam)^.PleaseDraw then begin
            inc(PacBGInfo(Message.LParam)^.Offset.X, OffsetX);
            inc(PacBGInfo(Message.LParam)^.Offset.Y, OffsetY);
          end;
          InitBGInfo(SkinData, PacBGInfo(Message.LParam), 0);
          if (PacBGInfo(Message.LParam)^.BgType = btCache) then
            if not PacBGInfo(Message.LParam)^.PleaseDraw then begin
              if PacBGInfo(Message.LParam)^.Bmp = nil then begin
                PaintAll;
                PacBGInfo(Message.LParam)^.Bmp := SkinData.FCacheBmp;
              end;
              PacBGInfo(Message.LParam)^.Offset := Point(OffsetX, OffsetY);
            end;

          Exit;
        end;

        AC_UPDATECHILDREN:
          Provider.InitHwndControls(CtrlHandle); // SysListView re-init

        AC_CHILDCHANGED: begin
          Message.Result := LRESULT((SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].GradientPercent + SkinData.SkinManager.gd[SkinData.SkinIndex].Props[0].ImagePercent > 0));
          Exit;
        end;

        AC_PARENTCLOFFSET: begin
          Message.Result := MakeLong(Word(OffsetX), Word(OffsetY));
          Exit
        end;

        AC_INVALIDATE:
          if BorderForm <> nil then
            BorderForm.UpdateExBordersPos(False);
      end;

    DM_SETDEFID: begin
      inherited;
      Provider.InitHwndControls(CtrlHandle); // Additional searching of controls
      RedrawWindow(CtrlHandle, nil, 0, RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_UPDATENOW);
      Exit;
    end;

    CM_VISIBLECHANGED: begin
      inherited;
      if (Message.WParam = 0) then
        KillAnimations;

      Exit;
    end;

    WM_GETDLGCODE:
      Exit;

    WM_MOUSEMOVE:
      if IsWindowEnabled(CtrlHandle) then
        DefaultManager.ActiveControl := 0;

    WM_NCHITTEST: begin
      Ac_WMNCHitTest(Message);
      Exit;
    end;

    WM_MOUSELEAVE:
      SetHotHT(0);

    WM_NCLBUTTONDOWN: begin
      if (BorderForm <> nil) and (TWMNCLButtonDown(Message).HitTest = HTOBJECT) then begin
        Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        Exit;
      end;

      if (BorderForm <> nil) and (TWMNCLButtonDown(Message).HitTest = HTTRANSPARENT) then
        TWMNCLButtonDown(Message).HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message))
      else
        if not (TWMNCLButtonDown(Message).HitTest in [HTLEFT .. HTBOTTOMRIGHT]) { If statusbar with grip exists } then
          TWMNCLButtonDown(Message).HitTest := HTProcess(TWMNCHitTest(Message));

      Ac_WMNCLButtonDown(TWMNCLButtonDown(Message));
      Exit;
    end;

    WM_NCRBUTTONDOWN:
      if (TWMNCLButtonUp(Message).HitTest in [HTCAPTION, HTSYSMENU]) then
        Exit;

    WM_CTLCOLORDLG: begin
      Message.Result := LRESULT(CreateSolidBrush(DefaultManager.GetGlobalColor));
      Exit;
    end;

    WM_DRAWITEM:
      case TWMDrawItem(Message).DrawItemStruct.CtlType of
        ODT_STATIC:
          Ac_DrawStaticItem(TWMDrawItem(Message));
      end;

    WM_NCRBUTTONUP: begin
      if (BorderForm <> nil) and (TWMNCLButtonDown(Message).HitTest = HTTRANSPARENT) then
        TWMNCLButtonDown(Message).HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message));

      case TWMNCLButtonUp(Message).HitTest of
        HTCAPTION, HTSYSMENU: begin
          SetHotHT(0);
{$IFNDEF FPC}
          DropSysMenu(TWMNCLButtonUp(Message).XCursor, TWMNCLButtonUp(Message).YCursor);
{$ENDIF}
        end
      end;
      Exit;
    end;

    WM_NCLBUTTONUP, WM_LBUTTONUP: begin
      if (BorderForm <> nil) and (TWMNCLButtonDown(Message).HitTest = HTTRANSPARENT) then
        TWMNCLButtonDown(Message).HitTest := BorderForm.Ex_WMNCHitTest(TWMNCHitTest(Message));

      Ac_WMLButtonUp(Message);
      Exit;
    end;

    WM_NCLBUTTONDBLCLK: begin
      case TWMNCHitMessage(Message).HitTest of
        HTSYSMENU:
          SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_CLOSE, 0);

        HTCAPTION: begin
          if EnabledMax or EnabledRestore then begin
            if IsZoomed(CtrlHandle) or IsIconic(CtrlHandle) then
              SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_RESTORE, 0)
            else
              SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
                
            SystemMenu.UpdateItems;
          end;
          TWMNCHitMessage(Message).HitTest := 0;
        end;
      end;
      Exit;
    end;

    WM_SETFOCUS: begin
      Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      RedrawWindow(GetActiveWindow, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE or RDW_ERASE or RDW_UPDATENOW);
      Exit;
    end;

    WM_ERASEBKGND: begin
      InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
      if not Initialized then begin
        Initialized := True;
        Provider.InitHwndControls(CtrlHandle); // Additional searching of controls
      end;
      Caption := GetWndText(CtrlHandle);
      Ac_WMPaint(TWMPaint(Message));
      Message.Result := 1;
      Exit;
    end;

    WM_PAINT: begin
      if not FWMPaintForbidden then
        Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam)
      else begin
        BeginPaint(CtrlHandle, PS);
        EndPaint(CtrlHandle, PS);
        Message.Result := 0;
      end;
      Exit;
    end;

    WM_NCPAINT:
      if IsWindowVisible(CtrlHandle) then begin
        if not Initialized then begin
          Initialized := True;
          Provider.InitHwndControls(CtrlHandle); // Additional searching of controls
        end;
        InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
        if IsRectEmpty(LastClientRect) then begin
          GetClientRect(CtrlHandle, rClient);
          LastClientRect := MkRect(WidthOf(rClient), HeightOf(rClient));
        end;
        Caption := GetWndText(CtrlHandle);
        if Assigned(BorderForm) and Assigned(BorderForm.AForm) and not IsWindowVisible(BorderForm.AForm.Handle) and IsWindowVisible(CtrlHandle) and not InAnimationProcess then
          // First showing
          if AeroIsEnabled then begin
            if SkinData.BGChanged then
              PaintAll;

            UpdateRgn(Self, False); // Prevent an Aero borders showing
            BorderForm.UpdateExBordersPos(True, MaxByte);
            SetFocus(CtrlHandle);
          end
          else
            BorderForm.UpdateExBordersPos(False);

        Ac_WMNCPaint(Message);
        Exit;
      end;

    WM_SHOWWINDOW: begin
      // Prevent of animation in Aero
      if AeroIsEnabled then
        SetWindowLong(CtrlHandle, GWL_EXSTYLE, GetWindowLong(CtrlHandle, GWL_EXSTYLE) or WS_EX_LAYERED);

      Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      if AeroIsEnabled then
        SetWindowLong(CtrlHandle, GWL_EXSTYLE, GetWindowLong(CtrlHandle, GWL_EXSTYLE) and not WS_EX_LAYERED);

      InitDwm(CtrlHandle, True);
{$IFNDEF NOWNDANIMATION}
      // Start Animation
      if (Message.WParamLo = 1) and
           DefaultManager.AnimEffects.DialogShow.Active and
             (DefaultManager.AnimEffects.DialogShow.Time > 0) and
               SkinData.SkinManager.Effects.AllowAnimation then begin
        Caption := GetWndText(CtrlHandle);
        Provider.InitHwndControls(CtrlHandle);
        SkinData.FUpdating := False;
        AnimShowDlg(Provider.ListSW, DefaultManager.AnimEffects.DialogShow.Time, MaxByte, DefaultManager.AnimEffects.DialogShow.Mode);
      end;
      // Finish Animation
{$ENDIF}
      Exit;
    end;
{$IFNDEF NOWNDANIMATION}

    WM_COMMAND:
      if (Message.WParam = 2) or (Message.WParam = WM_ACTIVATE) then
        if (SkinData.SkinManager.AnimEffects.DialogHide.Active) and SkinData.SkinManager.Effects.AllowAnimation and (SkinData.SkinManager.AnimEffects.DialogHide.Time > 0) then begin
          PrintDlgClient(Self, SkinData.FCacheBmp, True);
          if BorderForm <> nil then begin
            SetWindowRgn(BorderForm.AForm.Handle, 0, False);
            SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, MaxByte);
            BorderForm.ExBorderShowing := True;
            Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
            Exit;
          end
          else begin
            if CoverForm <> nil then
              FreeAndNil(CoverForm);

            CoverForm := MakeCoverForm(CtrlHandle);
          end;
        end;
{$ENDIF}

    WM_WINDOWPOSCHANGED: begin
      if (TWMWindowPosChanged(Message).WindowPos.Flags and SWP_HIDEWINDOW = SWP_HIDEWINDOW) and acLayered then
        RgnChanged := True;

      Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
{$IFNDEF NOWNDANIMATION}
      if (TWMWindowPosChanged(Message).WindowPos.Flags and SWP_HIDEWINDOW = SWP_HIDEWINDOW) and acLayered then begin
        if (SkinData.SkinManager.AnimEffects.DialogHide.Active) and
             (SkinData.SkinManager.AnimEffects.DialogHide.Time > 0) and
               SkinData.SkinManager.Effects.AllowAnimation then begin
          AnimHideDlg(Self);
          DoLayered(CtrlHandle, False);
        end;
        InitExBorders(False);
      end
      else
{$ENDIF}
        if (BorderForm <> nil) and not SkinData.FUpdating and IsWindowVisible(CtrlHandle) and (FormState and FS_BLENDMOVING <> FS_BLENDMOVING) then
          BorderForm.UpdateExBordersPos(False);

      Exit;
    end;

    WM_SIZE:
      if (BorderForm <> nil) then begin
        if not SkinData.FUpdating then begin
          GetClientRect(CtrlHandle, rClient);
          if ((WidthOf(rClient) < WidthOf(LastClientRect)) or (HeightOf(rClient) < HeightOf(LastClientRect)) or (WidthOf(LastClientRect) = 0)) then begin
            i := SkinData.SkinManager.GetMaskIndex(SkinData.SkinIndex, s_ImgTopRight);
            if i > -1 then begin
              X := WidthOfImage (SkinData.SkinManager.ma[i]);
              Y := HeightOfImage(SkinData.SkinManager.ma[i]);
              cR := Rect(LastClientRect.Right - X, LastClientRect.Bottom - Y, LastClientRect.Right, LastClientRect.Bottom);
              InvalidateRect(CtrlHandle, @cR, not IsCached(SkinData));
            end;
            i := SkinData.SkinManager.GetMaskIndex(SkinData.SkinIndex, s_ImgBottomRight);
            if i > -1 then begin
              X := WidthOfImage (SkinData.SkinManager.ma[i]);
              Y := HeightOfImage(SkinData.SkinManager.ma[i]);
              cR := Rect(LastClientRect.Right - X, LastClientRect.Bottom - Y, LastClientRect.Right, LastClientRect.Bottom);
              InvalidateRect(CtrlHandle, @cR, not IsCached(SkinData));
            end;
          end;
          SkinData.FUpdating := True;
          if AeroIsEnabled then
            SendMessage(CtrlHandle, WM_SETREDRAW, 0, 0);

          Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
          if AeroIsEnabled then
            SendMessage(CtrlHandle, WM_SETREDRAW, 1, 0);

          SkinData.FUpdating := False;
          if not InAnimationProcess then
            if IsWindowVisible(CtrlHandle) then begin
              if (SkinData.FCacheBmp = nil) or (WndSize.cx <> SkinData.FCacheBmp.Width) or (WndSize.cy <> SkinData.FCacheBmp.Height) and (not (IsIconic(CtrlHandle) and AeroIsEnabled)) then begin
                RgnChanged := True;
                SkinData.BGChanged := True;

                if BorderForm <> nil then begin // Update extended borders
                  if (not sBarVert.fScrollVisible and not sBarHorz.fScrollVisible) then
                    FormState := FormState or FS_SIZING;

                  BorderForm.UpdateExBordersPos;
                  SkinData.FUpdating := True;
                  FormState := FormState and not FS_SIZING;
                  BorderForm.ExBorderShowing := True;
                  // Move ExtBorder on top
                  SetWindowPos(CtrlHandle, BorderForm.AForm.Handle, 0, 0, 0, 0, SWP_NOACTIVATE or {SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOREDRAW or} SWP_NOSIZE or SWP_NOMOVE);
                  BorderForm.ExBorderShowing := False;
                  UpdateRgn(Self, True);
                  SkinData.FUpdating := False;
                end
                else
                  SendMessage(CtrlHandle, WM_NCPAINT, 0, 0); // Update region

                // Repaint Form
                RedrawWindow(CtrlHandle, nil, 0, RDW_NOFRAME or RDW_ERASE or RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
                // Move ExtBorder back
                if (BorderForm <> nil) and (BorderForm.AForm <> nil) then begin
                  SetWindowPos(BorderForm.AForm.Handle, CtrlHandle, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSENDCHANGING or SWP_NOOWNERZORDER or SWP_NOREDRAW or SWP_NOSIZE or SWP_NOMOVE);
                  if (BorderForm <> nil) and (BorderForm.AForm <> nil) then
                    SetWindowRgn(BorderForm.AForm.Handle, BorderForm.MakeRgn, False); // Update borders region

                  BorderForm.ExBorderShowing := False;
                end
                else
                  UpdateRgn(Self, False);

                LastClientRect := MkRect(WidthOf(rClient), HeightOf(rClient));
              end;
            end
            else
              SkinData.BGChanged := True;

          LastClientRect := MkRect(WidthOf(rClient), HeightOf(rClient));
        end
        else
          Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);

        Exit;
      end
      else begin
        SkinData.BGChanged := True;
        RgnChanged := True;
        SkinData.FUpdating := True;
        Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        SkinData.FUpdating := False;
        if not InAnimationProcess and (BorderForm <> nil) and IsWindowVisible(CtrlHandle) then
          BorderForm.UpdateExBordersPos;

        RedrawWindow(CtrlHandle, nil, 0, RDW_ERASE or RDW_UPDATENOW or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
        Exit;
      end;

    WM_SETTEXT:
      if IsWindowVisible(CtrlHandle) then begin
        Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        SkinData.BGChanged := True;
        if (BorderForm <> nil) and IsWindowVisible(CtrlHandle) then
          BorderForm.UpdateExBordersPos(False)
        else
          SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);

        Exit;
      end;

    WM_ENABLE:
      if IsWindowVisible(CtrlHandle) then begin
        Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        SkinData.BGChanged := True;
        SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);
        Exit;
      end;

    WM_NCACTIVATE:
      if IsWindowVisible(CtrlHandle) then begin
        SetRedraw(CtrlHandle);
        Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
        FFormActive := (TWMActivate(Message).Active <> WA_INACTIVE);
        SetRedraw(CtrlHandle, 1);
        Ac_WMNCActivate(Message);
        Exit;
      end;

//    WM_NCCREATE: Exit;

    1324, 1326: begin // Shell ListView changing
      Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      Provider.InitHwndControls(CtrlHandle); // SysListView re-init
      RedrawWindow(CtrlHandle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
      Exit;
    end;
  end;

  inherited;
  case Message.Msg of
{    WM_NOTIFY:
      if TWMNotify(Message).NMHdr.code = CDN_INITDONE then
        Provider.InitHwndControls(CtrlHandle);}

    WM_SYSCOMMAND:
      case Message.WParam of
        SC_DRAGMOVE: begin
          UpdateWindow(CtrlHandle);
          if (BorderForm <> nil) and IsWindowVisible(CtrlHandle) then
            BorderForm.UpdateExBordersPos(False);
        end;

        SC_MAXIMIZE, SC_RESTORE: begin
          if VisibleMax then
            CurrentHT := HTMAXBUTTON;

          SetHotHT(0);
        end;
      end;
  end;
end;


function TacDialogWnd.CaptionHeight(CheckSkin: boolean = True): integer;
begin
  Result := 0;
  if (GetWindowLong(CtrlHandle, GWL_STYLE) and WS_CAPTION = WS_CAPTION) or IsIconic(CtrlHandle) then begin
    if CheckSkin then
      Result := SkinTitleHeight(Self.BorderForm);

    if Result = 0 then
      if BorderStyle in [acbsToolWindow, acbsSizeToolWin] then
        Result := GetSystemMetrics(SM_CYSMCAPTION)
      else
        Result := GetSystemMetrics(SM_CYCAPTION);
  end;
end;



destructor TacDialogWnd.Destroy;
begin
  if Assigned(Adapter) then
    FreeAndNil(Adapter);

  if Assigned(TitleGlyph) then
    FreeAndNil(TitleGlyph);

  if Assigned(TitleBG) then
    FreeAndNil(TitleBG);

  if Assigned(TempBmp) then
    FreeAndnil(TempBmp);

  if Assigned(MoveTimer) then
    FreeAndNil(Movetimer);

  FreeAndNil(SystemMenu);
  if TitleFont <> nil then
    FreeAndnil(TitleFont);

  KillAnimations;
  ClearGlows(True);
  InitExBorders(False);
  inherited;
end;


procedure TacDialogWnd.Ac_WMPaint(var Message: TWMPaint);
var
  DC, SavedDC: hdc;
begin
  if Message.DC = 0 then
    DC := GetDC(CtrlHandle)
  else
    DC := Message.DC;

  SavedDC := SaveDC(DC);
  try
    SkinData.Updating := False;
    ExcludeControls(DC, CtrlHandle, 0, 0);
    if Application.BiDiMode = bdRightToLeft then
      acSetLayout(DC, 0);

    PaintForm(DC);
  finally
    RestoreDC(DC, SavedDC);
    if Message.DC = 0 then
      ReleaseDC(CtrlHandle, DC);
  end;
end;


function TacDialogWnd.EnabledClose: boolean;
begin
  Result := VisibleClose and ((GetClassLong(CtrlHandle, GCL_STYLE) and CS_NOCLOSE) <> CS_NOCLOSE);
end;


function TacDialogWnd.EnabledMax: boolean;
begin
  Result := VisibleMax and not IsZoomed(CtrlHandle) and (BorderStyle in [acbsSingle, acbsSizeable, acbsSizeToolWin]);
end;


function TacDialogWnd.EnabledMin: boolean;
begin
  Result := VisibleMin and not IsIconic(CtrlHandle);
end;


function TacDialogWnd.EnabledRestore: boolean;
begin
  Result := VisibleMax and (IsIconic(CtrlHandle) or IsZoomed(CtrlHandle));
end;


function TacDialogWnd.FormActive: boolean;
begin
  Result := FFormActive;
end;


function TacDialogWnd.HeaderHeight: integer;
begin
  Result := CaptionHeight;
  inc(Result, SysBorderHeight(CtrlHandle, BorderForm, False));
end;


procedure TacDialogWnd.InitParams;
var
  NonClientMetrics: TNonClientMetrics;
  f: HFONT;
begin
  dwStyle := GetWindowLong(CtrlHandle, GWL_STYLE);
  dwExStyle := GetWindowLong(CtrlHandle, GWL_EXSTYLE);
  BorderStyle := acbsSizeable;
  if ((dwStyle and WS_POPUP) = WS_POPUP) and ((dwStyle and WS_CAPTION) <> WS_Caption) then
    BorderStyle := acbsNone
  else
    if ((dwStyle and WS_THICKFRAME) = WS_THICKFRAME) or ((dwStyle and WS_SIZEBOX) = WS_SIZEBOX) then
      BorderStyle := acbsSizeable
    else
      if ((dwStyle and DS_MODALFRAME) = DS_MODALFRAME) then
        BorderStyle := acbsDialog;

  PrepareTitleGlyph;
  UpdateIconsIndexes;
  if TitleFont <> nil then
    FreeAndNil(TitleFont);

  TitleFont := TFont.Create;
  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then begin
    f := CreateFontIndirect(NonClientMetrics.lfCaptionFont);
    if f <> 0 then
      TitleFont.Handle := f
  end;
  SetWindowLong(CtrlHandle, GWL_STYLE, GetWindowLong(CtrlHandle, GWL_STYLE) and not WS_SYSMENU);
end;


procedure TacDialogWnd.MakeTitleBG;
begin
  if TitleBG <> nil then
    FreeAndNil(TitleBG);

  TitleBG := TBitmap.Create;
  TitleBG.Width := SkinData.FCacheBmp.Width;
  TitleBG.Height := CaptionHeight + SysBorderHeight(CtrlHandle, BorderForm);
  TitleBG.PixelFormat := pf32bit;
  BitBlt(TitleBG.Canvas.Handle, 0, 0, TitleBG.Width, TitleBG.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;


function TacDialogWnd.OffsetX: integer;
var
  i: integer;
begin
  Result := (GetWindowWidth(CtrlHandle) - GetClientWidth(CtrlHandle)) div 2;
  if (BorderForm <> nil) then begin
    i := DiffBorder(BorderForm);
    inc(Result, ShadowSize.Left + i)
  end
end;


function TacDialogWnd.OffsetY: integer;
begin
  Result := GetWindowHeight(CtrlHandle) - GetClientHeight(CtrlHandle) - SysBorderWidth(CtrlHandle, BorderForm, False) * integer(CaptionHeight <> 0);
  if (BorderForm <> nil) then
    inc(Result, ShadowSize.Top + DiffTitle(BorderForm));
end;


procedure TacDialogWnd.PaintAll;
var
  x, y, fHeight, fWidth, fCaptHeight, sbw, ChangedIndex: integer;
  i, iTitleIndex, iDrawMode: integer;
  ShadowSize, r, rForm: TRect;
  Iconic, exBorders: boolean;
  ci: TCacheInfo;
  s: acString;
  ts: TSize;

  procedure PaintTitle;
  var
    C: TColor;
    cRect: TRect;
    Flags: Cardinal;
    i, Ndx: integer;
    Style: ACNativeInt;
    GlowBmp, SavedTitle: TBitmap;
  begin
    if (CaptionHeight <> 0) then begin // Paint title
      if not exBorders then
        if SkinData.SkinManager.IsValidSkinIndex(TitleIndex) then
          if Iconic then
            PaintItem(TitleIndex, ci, True, integer(FormActive), Rect(rForm.Left, rForm.Top, rForm.Right, rForm.Bottom), MkPoint, SkinData.FCacheBmp, SkinData.SkinManager)
          else
            PaintItem(TitleIndex, ci, True, integer(FormActive), Rect(rForm.Left, rForm.Top, rForm.Right, fCaptHeight), MkPoint, SkinData.FCacheBmp, SkinData.SkinManager);

      DrawAppIcon(Self); // Draw app icon
    end;
    if (CaptionHeight <> 0) then begin // Out the title text
      SkinData.FCacheBmp.Canvas.Font.Handle := acGetTitleFont;
      SkinData.FCacheBmp.Canvas.Font.Height := GetCaptionFontSize;
      SkinData.FCacheBmp.Canvas.Font.Charset := GetDefFontCharSet;
      Style := GetWindowLong(CtrlHandle, GWL_EXSTYLE);
      R := Rect(SysBorderWidth(CtrlHandle, BorderForm) + integer(TitleIcon <> 0) * WidthOf(IconRect) + 4 + SkinData.SkinManager.CommonSkinData.BILeftMargin + ShadowSize.Left,
                2 + ShadowSize.Top, rForm.Right - TitleBtnsWidth - 6 - ShadowSize.Right, fCaptHeight);

      if ExBorders then
        OffsetRect(R, 0, SkinData.SkinManager.CommonSkinData.ExCenterOffs);

      if not IsRectEmpty(R) then begin
        s := Caption;
        acGetTextExtent(SkinData.FCacheBmp.Canvas.Handle, s, ts);
        R.Top := R.Top + (HeightOf(R) - ts.cy) div 2;
        R.Bottom := R.Top + ts.cy;
        Flags := DT_END_ELLIPSIS or DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
        if (Style and WS_EX_RTLREADING = WS_EX_RTLREADING) or (Style and WS_EX_LAYOUTRTL = WS_EX_LAYOUTRTL) then
          Flags := Flags or DT_RTLREADING or DT_RIGHT;

        if FCaptionSkinIndex > -1 then begin // If Caption panel must be drawn
          cRect := R;
          acDrawText(SkinData.FCacheBmp.Canvas.Handle, s, cRect, Flags or DT_CALCRECT);
          InflateRect(cRect, 4, 2);
          SavedTitle := CreateBmp32(fWidth, fCaptHeight);
          BitBlt(SavedTitle.Canvas.Handle, 0, 0, fWidth, fCaptHeight, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
          CI := MakeCacheInfo(SavedTitle, cRect.Left, cRect.Top);
          PaintItem(FCaptionSkinIndex, CI, True, integer(FormActive), cRect, MkPoint, SkinData.FCacheBmp, SkinData.SkinManager);
          FreeAndNil(SavedTitle);
          Ndx := FCaptionSkinIndex;
        end
        else
          Ndx := TitleIndex;

        if SkinData.SkinManager.IsValidSkinIndex(Ndx) then begin
          // Draw a text glowing
          if not x64woAero then begin
            i := iff(FormActive, SkinData.SkinManager.gd[Ndx].HotGlowSize, SkinData.SkinManager.gd[Ndx].GlowSize);
            if i <> 0 then begin
              C := iff(FormActive, SkinData.SkinManager.gd[Ndx].HotGlowColor, SkinData.SkinManager.gd[Ndx].GlowColor);
              GlowBmp := nil;
              acDrawGlowForText(SkinData.FCacheBmp, PacChar(s), R, Flags, BF_RECT, i, C, GlowBmp);
              if Assigned(GlowBmp) then
                FreeAndNil(GlowBmp);
            end;
          end;
          if (BorderForm = nil) then
            acWriteTextEx(SkinData.FCacheBmp.Canvas, PacChar(s), True, R, Flags, Ndx, FormActive, SkinData.SkinManager)
          else
            WriteText32(SkinData.FCacheBmp, PacChar(s), True, R, Flags, Ndx, FormActive, SkinData.SkinManager);
        end;
      end;
    end;
  end;

begin
  if (FormState and FS_BLENDMOVING <> FS_BLENDMOVING) then begin
    InitCtrlData(CtrlHandle, ParentWnd, WndRect, ParentRect, WndSize, WndPos);
    fHeight := WndSize.cy;
    if BorderForm <> nil then begin
      ShadowSize := BorderForm.ShadowSize;
      i := DiffTitle(BorderForm);
      inc(fHeight, DiffBorder(BorderForm) + i + ShadowSize.Top + ShadowSize.Bottom);
    end
    else
      ShadowSize := MkRect;

    fWidth := WndSize.cx;
    Iconic := IsIconic(CtrlHandle);
    if BorderForm <> nil then
      if not Iconic then
        inc(fWidth, 2 * DiffBorder(Self.BorderForm) + ShadowSize.Left + ShadowSize.Right);

    if SkinData.FCacheBmp = nil then // If first loading
      SkinData.FCacheBmp := CreateBmp32(fWidth, fHeight)
    else begin
      SkinData.FCacheBmp.Width := fWidth;
      SkinData.FCacheBmp.Height := fHeight;
    end;

    fCaptHeight := CaptionHeight + SysBorderHeight(CtrlHandle, BorderForm, False) + ShadowSize.Top;
    if Iconic then
      rForm := Rect(ShadowSize.Left, ShadowSize.Top, fWidth - ShadowSize.Right, fCaptHeight + 1 - ShadowSize.Bottom)
    else
      rForm := Rect(ShadowSize.Left, ShadowSize.Top, fWidth - ShadowSize.Right, fHeight - ShadowSize.Bottom);

    iTitleIndex := -1;
    if SkinData.BGChanged then begin
      RgnChanged := True;
      ci.Ready := False;
      if SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinIndex) then begin
        // Paint body
        exBorders := (BorderForm <> nil) and (SkinData.SkinManager.CommonSkinData.ExDrawMode = 1);
        if exBorders then
          PaintItemBG(SkinData.SkinIndex, EmptyCI, integer(FormActive), rForm, MkPoint, SkinData.FCacheBmp, SkinData.SkinManager)
        else
          PaintItem(SkinData, EmptyCI, False, integer(FormActive), rForm, MkPoint, SkinData.FCacheBmp, False);

        ci := MakeCacheInfo(SkinData.FCacheBmp, OffsetX, OffsetY); // Prepare cache info
        if not exBorders then
          PaintTitle;

        if BorderForm <> nil then begin // Paint shadow of form if required
          if FormActive then
            BorderForm.ShadowTemplate := SkinData.SkinManager.ShdaTemplate
          else
            BorderForm.ShadowTemplate := SkinData.SkinManager.ShdiTemplate;

          if BorderForm.ShadowTemplate <> nil then
            if exBorders then
              with SkinData.SkinManager do begin
                ChangedIndex := ConstData.ExBorder; // Index of extended border in skin
                iDrawMode := ma[ChangedIndex].DrawMode and BDM_STRETCH;
                PaintControlByTemplate(Self.SkinData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                                       MkRect(BorderForm.ShadowTemplate),
                                       Rect(ma[ChangedIndex].WL, ma[ChangedIndex].WT, ma[ChangedIndex].WR, ma[ChangedIndex].WB),
                                       Rect(ShadowSize.Left + SkinBorderWidth(BorderForm),
                                            fCaptHeight,
                                            ShadowSize.Right + SkinBorderWidth(BorderForm),
                                            ShadowSize.Bottom + SkinBorderWidth(BorderForm)),
                                       Rect(iDrawMode, iDrawMode, iDrawMode, iDrawMode), False, False);

                PaintTitle;
              end
            else
              with SkinData.SkinManager do begin
                if ConstData.ExBorder >= 0 then
                  PaintControlByTemplate(Self.SkinData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight),
                                         MkRect(BorderForm.ShadowTemplate),
                                         Rect(ma[ConstData.ExBorder].WL, ma[ConstData.ExBorder].WT, ma[ConstData.ExBorder].WR, ma[ConstData.ExBorder].WB),
                                         Self.ShadowSize, Rect(1, 1, 1, 1), False, False) // For internal shadows - stretch only allowed
                else begin// If internal shadows
                  sbw := (BorderForm.ShadowTemplate.Width - 1) div 2;
                  PaintControlByTemplate(Self.SkinData.FCacheBmp, BorderForm.ShadowTemplate, MkRect(fWidth, fHeight), MkRect(BorderForm.ShadowTemplate),
                                         Rect(sbw, sbw, sbw, sbw), Self.ShadowSize, Rect(1, 1, 1, 1), False, False); // For internal shadows - stretch only allowed
                end;
                if SkinData.BorderIndex >= 0 then begin
                  // Draw shadows in corners
                  if IsValidImgIndex(TitleIndex) then
                    iTitleIndex := gd[TitleIndex].BorderIndex;

                  if IsValidImgIndex(iTitleIndex) then begin // If title mask exists
                    x := MaskWidthRight(iTitleIndex);
                    // LeftTop
                    R := Rect(ShadowSize.Left, ShadowSize.Top, ShadowSize.Left + MaskWidthLeft(iTitleIndex),
                              ShadowSize.Top + MaskWidthTop(iTitleIndex));
                    FillTransPixels32(SkinData.FCacheBmp, BorderForm.ShadowTemplate, R, ShadowSize.TopLeft, iTitleIndex, SkinData.SkinManager, HTTOPLEFT);
                    // RightTop
                    R := Rect(SkinData.FCacheBmp.Width - ShadowSize.Right - x, ShadowSize.Top, SkinData.FCacheBmp.Width - ShadowSize.Right,
                              ShadowSize.Top + MaskWidthTop(iTitleIndex));
                    FillTransPixels32(SkinData.FCacheBmp, BorderForm.ShadowTemplate, R,
                      Point(max(0, BorderForm.ShadowTemplate.Width - ShadowSize.Right - x), ShadowSize.Top), iTitleIndex, SkinData.SkinManager, HTTOPRIGHT);
                  end
                  else begin
                    x := MaskWidthRight(SkinData.BorderIndex);
                    // LeftTop
                    R := Rect(ShadowSize.Left, ShadowSize.Top, ShadowSize.Left + min(MaskWidthLeft(SkinData.BorderIndex), 8), ShadowSize.Top + min(MaskWidthTop(SkinData.BorderIndex), 8));
                    FillTransPixels32(SkinData.FCacheBmp, BorderForm.ShadowTemplate, R, ShadowSize.TopLeft, SkinData.BorderIndex, SkinData.SkinManager, HTTOPLEFT);
                    // RightTop
                    R := Rect(SkinData.FCacheBmp.Width - ShadowSize.Right - x,  ShadowSize.Top, SkinData.FCacheBmp.Width - ShadowSize.Right,
                              ShadowSize.Top + MaskWidthTop(SkinData.BorderIndex));
                    FillTransPixels32(SkinData.FCacheBmp, BorderForm.ShadowTemplate, R, Point(max(0, BorderForm.ShadowTemplate.Width - ShadowSize.Right - x), ShadowSize.Top), SkinData.BorderIndex, SkinData.SkinManager, HTTOPRIGHT);
                  end;
                  y := MaskWidthBottom(SkinData.BorderIndex);
                  x := MaskWidthRight(SkinData.BorderIndex);

                  // LeftBottom
                  R := Rect(ShadowSize.Left, SkinData.FCacheBmp.Height - ShadowSize.Bottom - y, ShadowSize.Left + MaskWidthLeft(SkinData.BorderIndex),
                            SkinData.FCacheBmp.Height - ShadowSize.Bottom);
                  FillTransPixels32(SkinData.FCacheBmp, BorderForm.ShadowTemplate, R, Point(ShadowSize.Left, max(0, BorderForm.ShadowTemplate.Height - ShadowSize.Bottom - y)), SkinData.BorderIndex, SkinData.SkinManager, HTBOTTOMLEFT);
                  // RightBottom
                  R := Rect(SkinData.FCacheBmp.Width - ShadowSize.Right - x, SkinData.FCacheBmp.Height - ShadowSize.Bottom - y,
                            SkinData.FCacheBmp.Width - ShadowSize.Right, SkinData.FCacheBmp.Height - ShadowSize.Bottom);
                  FillTransPixels32(SkinData.FCacheBmp, BorderForm.ShadowTemplate, R,
                    Point(max(0, BorderForm.ShadowTemplate.Width - ShadowSize.Right - x), max(0, BorderForm.ShadowTemplate.Height - ShadowSize.Bottom - y)), SkinData.BorderIndex, SkinData.SkinManager, HTBOTTOMRIGHT);
                end;
              end;
        end;
        // Save caption
        if IsBorderUnchanged(SkinData.BorderIndex, SkinData.SkinManager) and ((TitleBG = nil) or (TitleBG.Width <> fWidth)) then
          MakeTitleBG;
        // Paint buttons
        if (CaptionHeight <> 0) then
          PaintBorderIcons;
      end;
      SkinData.BGChanged := False;
    end;
  end;
end;


procedure TacDialogWnd.PaintBorderIcons;
var
  i, b, Offset, BigButtons: integer;

  procedure PaintButton(var Btn: TsCaptionButton; var Index: integer; SkinIndex: integer; BtnEnabled: boolean);
  var
    w: integer;
  begin
    w := SysButtonWidth(Btn);
    Btn.Rect.Left := Btn.Rect.Right - w;
    with SkinData.SkinManager do begin
      if Btn.HaveAlignment { If not user button and not small } and (CommonSkinData.BIVAlign = 1) {and (Btn.HitCode <> ButtonHelp.HitCode)} { Top } then begin
        if BorderForm <> nil then
          Btn.Rect.Top := ShadowSize.Top + CommonSkinData.BITopMargin
        else
          Btn.Rect.Top := ShadowSize.Top;

        if (BorderForm <> nil) and IsZoomed(CtrlHandle) then
          inc(Btn.Rect.Top, 3 {4 - 1});

        Btn.Rect.Bottom := Btn.Rect.Top + ButtonHeight(Btn.ImageIndex);
      end
      else begin
        Btn.Rect.Top := (CaptionHeight - ButtonHeight(Btn.ImageIndex) + SysBorderHeight(CtrlHandle, BorderForm)) div 2 + ShadowSize.Top;
        if (BorderForm <> nil) and IsZoomed(CtrlHandle) then
          inc(Btn.Rect.Top, SysBorderWidth(CtrlHandle, BorderForm, False) div 2);

        if (BorderForm <> nil) and (CommonSkinData.ExDrawMode = 1) then
          inc(Btn.Rect.Top, CommonSkinData.ExCenterOffs);
          
        Btn.Rect.Bottom := Btn.Rect.Top + ButtonHeight(Btn.ImageIndex);
      end;
      if SkinIndex > -1 then
        DrawSkinGlyph(SkinData.FCacheBmp, Btn.Rect.TopLeft,
                      Btn.State, 1 + integer(not boolean(FormActive) or not BtnEnabled), ma[SkinIndex], MakeCacheInfo(SkinData.FCacheBmp));
    end;
    inc(Index);
  end;
  
begin
  b := 1;
  with SkinData.SkinManager do begin
    BigButtons := integer((BorderStyle in [acbsSingle, acbsSizeable]) or (GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconClose) = ButtonClose.ImageIndex));
    Offset := SkinData.FCacheBmp.Width  - SkinData.SkinManager.CommonSkinData.BIRightMargin - ShadowSize.Right;
    dec(Offset, max(4, SysBorderWidth(CtrlHandle, BorderForm)));

    if BigButtons = 0 then
      inc(Offset, min(0, DiffBorder(BorderForm) - 2));

    if (dwStyle and WS_SYSMENU = WS_SYSMENU) then begin // Accommodation of buttons in a special order...
      if IsValidImgIndex(ButtonClose.ImageIndex) then begin
        ButtonClose.Rect.Right := Offset;
        PaintButton(ButtonClose, b, ButtonClose.ImageIndex, EnabledClose);
        Offset := ButtonClose.Rect.Left - BigButtons * CommonSkinData.BISpacing;
      end;
      if VisibleMax then
        if not IsZoomed(CtrlHandle) then begin
          if IsValidImgIndex(ButtonMax.ImageIndex) then begin
            ButtonMax.Rect.Right := Offset;
            PaintButton(ButtonMax, b, ButtonMax.ImageIndex, EnabledMax);
            Offset := ButtonMax.Rect.Left - BigButtons * CommonSkinData.BISpacing;
          end;
        end
        else begin
          i := GetMaskIndex(ConstData.IndexGLobalInfo, s_BorderIconNormalize);
          if i < 0 then
            i := GetMaskIndex(SkinData.SkinIndex, s_BorderIconNormalize); // For compatibility

          if i > -1 then begin
            ButtonMax.Rect.Right := Offset;
            PaintButton(ButtonMax, b, i, EnabledRestore);
            Offset := ButtonMax.Rect.Left - BigButtons * CommonSkinData.BISpacing;;
          end;
        end;

      if VisibleMin then
        if IsIconic(CtrlHandle) then begin // If form is minimized then changing to Normalize
          i := GetMaskIndex(ConstData.IndexGLobalInfo, s_BorderIconNormalize);
          if i < 0 then
            i := GetMaskIndex(SkinData.SkinIndex, s_BorderIconNormalize);

          if IsValidImgIndex(i) then begin
            ButtonMin.Rect.Right := Offset;
            PaintButton(ButtonMin, b, i, EnabledRestore); // For compatibility
            Offset := ButtonMin.Rect.Left - BigButtons * CommonSkinData.BISpacing;;
          end;
        end
        else
          if IsValidImgIndex(ButtonMin.ImageIndex) then begin
            ButtonMin.Rect.Right := Offset;
            PaintButton(ButtonMin, b, ButtonMin.ImageIndex, EnabledMin);
            Offset := ButtonMin.Rect.Left - BigButtons * CommonSkinData.BISpacing;;
          end;

      if VisibleHelp then
        if IsValidImgIndex(ButtonHelp.ImageIndex) then begin
          ButtonHelp.Rect.Right := Offset;
          PaintButton(ButtonHelp, b, ButtonHelp.Imageindex, True);
        end;
    end;
  end;
end;


procedure TacDialogWnd.PaintForm(var DC: hdc);
begin
  if SkinData.BGChanged then
    PaintAll;

  BitBlt(DC, 0, 0, WndSize.cx, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle,
         SysBorderWidth(CtrlHandle, BorderForm) + ShadowSize.Left, HeaderHeight + ShadowSize.Top, SRCCOPY);

  SetParentUpdated(CtrlHandle);
end;


procedure TacDialogWnd.PrepareTitleGlyph;
var
  SmallIcon: HIcon;
  cx, cy: Integer;
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  cx := GetSystemMetrics(SM_CXSMICON);
  cy := GetSystemMetrics(SM_CYSMICON);
  Bmp.Width := cx;
  Bmp.Height := cy;
  Bmp.Canvas.Brush.Color := clFuchsia;
  TitleIcon := hIcon(SendMessage(CtrlHandle, WM_GETICON, ICON_SMALL, 0));
  if TitleIcon = 0 then
    TitleIcon := hIcon(SendMessage(CtrlHandle, WM_GETICON, ICON_BIG, 0));

  if TitleIcon <> 0 then begin
    SmallIcon := Windows.CopyImage(TitleIcon, IMAGE_ICON, cx, cy, LR_COPYFROMRESOURCE);
    DrawIconEx(Bmp.Canvas.Handle, 0, 0, SmallIcon, cx, cy, 0, 0, DI_NORMAL);
    DestroyIcon(SmallIcon);
    if TitleGlyph = nil then
      TitleGlyph := TBitmap.Create;

    TitleGlyph.Assign(Bmp);
  end;
  FreeAndNil(Bmp);
end;


function TacDialogWnd.SysButtonWidth(const Btn: TsCaptionButton): integer;
begin
  if SkinData.SkinManager.IsValidImgIndex(Btn.ImageIndex) then
    if SkinData.SkinManager.ma[Btn.ImageIndex].Bmp = nil then
      Result := WidthOfImage(SkinData.SkinManager.ma[Btn.ImageIndex])
    else
      Result := SkinData.SkinManager.ma[Btn.ImageIndex].Bmp.Width div SkinData.SkinManager.ma[Btn.ImageIndex].ImageCount
  else
    Result := 21;
end;


function TacDialogWnd.TitleBtnsWidth: integer;
begin
  Result := 0;
  if VisibleClose then begin
    inc(Result, SysButtonWidth(ButtonClose));

    if VisibleMax then
      inc(Result, SysButtonWidth(ButtonMax));

    if VisibleMin then
      inc(Result, SysButtonWidth(ButtonMin));

    if VisibleHelp then
      inc(Result, SysButtonWidth(ButtonHelp));
  end;
end;


function TacDialogWnd.VisibleClose: boolean;
begin
  Result := dwStyle and WS_SYSMENU = WS_SYSMENU
end;


function TacDialogWnd.VisibleHelp: boolean;
begin
  Result := dwExStyle and WS_EX_CONTEXTHELP = WS_EX_CONTEXTHELP
end;


function TacDialogWnd.VisibleMax: boolean;
begin
  Result := dwStyle and WS_MAXIMIZEBOX = WS_MAXIMIZEBOX
end;


function TacDialogWnd.VisibleMin: boolean;
begin
  Result := dwStyle and WS_MINIMIZEBOX = WS_MINIMIZEBOX
end;


procedure TacDialogWnd.Ac_WMNCPaint(var Message: TMessage);
var
  DC, SavedDC: hdc;
begin
  if not RgnChanging and RgnChanged and ((BorderStyle <> acbsNone) or (dwStyle and WS_SIZEBOX = WS_SIZEBOX)) then begin
    FillArOR(Self);
    RgnChanged := False;
    if not RgnChanging then
      UpdateRgn(Self, True);
  end;
  DC := GetWindowDC(CtrlHandle);
  SavedDC := SaveDC(DC);
  try
    if Application.BiDiMode = bdRightToLeft then
      acSetLayout(DC, 0);

    PaintCaption(DC);
  finally
    RestoreDC(DC, SavedDC);
    ReleaseDC(CtrlHandle, DC);
  end;
  SkinData.Updating := False;
  RgnChanging := False;
end;


procedure TacDialogWnd.PaintCaption(const DC: hdc);
var
  h, bw, bh: integer;
  sSize: TRect;
begin
  if BorderForm = nil then begin
    h := SysBorderHeight(CtrlHandle, BorderForm) + CaptionHeight;
    if IsIconic(CtrlHandle) then
      inc(h);

    if SkinData.BGChanged then begin
      PaintAll;
      SkinData.BGChanged := False;
      SkinData.Updating := False;
    end;
    sSize := ShadowSize;
    bw := SysBorderWidth(CtrlHandle, BorderForm);
    bh := SysBorderHeight(CtrlHandle, BorderForm);
    // Title update
    BitBlt(DC, 0, 0, WndSize.cx, HeaderHeight, SkinData.FCacheBmp.Canvas.Handle, sSize.Left, sSize.Top, SRCCOPY);
    // Left border update
    BitBlt(DC, 0, h, bw, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, sSize.Left, h + sSize.Top, SRCCOPY);
    // Bottom border update
    BitBlt(DC, bw, WndSize.cy - bh, WndSize.cx - bw, bh, SkinData.FCacheBmp.Canvas.Handle, SysBorderwidth(CtrlHandle, BorderForm) + sSize.Left, WndSize.cy - SysBorderWidth(CtrlHandle, BorderForm) - sSize.Bottom, SRCCOPY);
    // Right border update
    BitBlt(DC, WndSize.cx - bw, h, bw, WndSize.cy, SkinData.FCacheBmp.Canvas.Handle, SkinData.FCacheBmp.Width - bw, h, SRCCOPY);
  end;
end;


function TacDialogWnd.BorderHeight: integer;
begin
  Result := SysBorderHeight(CtrlHandle, BorderForm)
end;


procedure TacDialogWnd.UpdateIconsIndexes;
begin
  if SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinManager.ConstData.IndexGlobalInfo) then with SkinData.SkinManager do begin
    ButtonMin.HitCode := HTMINBUTTON;
    ButtonMax.HitCode := HTMAXBUTTON;
    ButtonClose.HitCode := HTCLOSE;
    TitleIndex := -1;
    if BorderStyle in [acbsSingle, acbsSizeable] then begin
      if VisibleMax or VisibleMin then
        ButtonClose.ImageIndex  := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconClose)
      else begin
        ButtonClose.ImageIndex := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconCloseAlone);
        if ButtonClose.ImageIndex < 0 then
          ButtonClose.ImageIndex  := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconClose)
      end;
      ButtonMin.ImageIndex    := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconMinimize);
      ButtonMax.ImageIndex    := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconMaximize);
      ButtonHelp.ImageIndex   := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconHelp);
      ButtonMin.HaveAlignment   := True;
      ButtonMax.HaveAlignment   := True;
      ButtonClose.HaveAlignment := True;
      ButtonHelp.HaveAlignment  := True;
    end
    else begin
      ButtonClose.ImageIndex  := GetMaskIndex(ConstData.IndexGlobalInfo, s_SmallIconClose);
      ButtonMin.ImageIndex    := GetMaskIndex(ConstData.IndexGlobalInfo, s_SmallIconMinimize);
      ButtonMax.ImageIndex    := GetMaskIndex(ConstData.IndexGlobalInfo, s_SmallIconMaximize);
      ButtonHelp.ImageIndex   := GetMaskIndex(ConstData.IndexGlobalInfo, s_SmallIconHelp);
      if ButtonHelp.ImageIndex < 0 then
        ButtonHelp.ImageIndex := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconHelp);

      ButtonMin.HaveAlignment   := False;
      ButtonMax.HaveAlignment   := False;
      ButtonClose.HaveAlignment := False;
      ButtonHelp.HaveAlignment  := False;
      if ButtonClose.ImageIndex < 0 then begin // If small buttons are not defined in skin
        if VisibleMax or VisibleMin then
          ButtonClose.ImageIndex  := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconClose)
        else begin
          ButtonClose.ImageIndex := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconCloseAlone);
          if ButtonClose.ImageIndex < 0 then
            ButtonClose.ImageIndex  := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconClose)
        end;
        ButtonMin.ImageIndex    := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconMinimize);
        ButtonMax.ImageIndex    := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconMaximize);
        ButtonHelp.ImageIndex   := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconHelp);
        ButtonMin.HaveAlignment   := True;
        ButtonMax.HaveAlignment   := True;
        ButtonClose.HaveAlignment := True;
        ButtonHelp.HaveAlignment  := True;
      end;
      TitleSection := s_DialogTitle;
      TitleIndex := Self.SkinData.SkinManager.GetSkinIndex(TitleSection);
    end;
    if TitleIndex < 0 then begin
      TitleSection := s_FormTitle;
      TitleIndex := Self.SkinData.SkinManager.GetSkinIndex(TitleSection);
    end;
  end;
end;


function TacDialogWnd.ButtonHeight(Index: integer): integer;
begin
  if SkinData.SkinManager.IsValidImgIndex(Index) then
    Result := HeightOfImage(SkinData.SkinManager.ma[Index])
  else
    Result := 21;
end;


procedure TacDialogWnd.SendToAdapter(Message: TMessage);
begin
  if Assigned(Adapter) then
    Adapter.WndProc(Message)
end;


function TacDialogWnd.VisibleRestore: boolean;
begin
  Result := not (BorderStyle in [acbsDialog, acbsNone, acbsSizeToolWin, acbsToolWindow]) and VisibleClose;
end;


procedure TacDialogWnd.Ac_WMNCHitTest(var Message: TMessage);
begin
  Message.Result := HTProcess(TWMNCHitTest(Message));
  case Message.Result of
    Windows.HTCAPTION, Windows.HTNOWHERE: begin
      Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
      SetHotHT(0);
    end;
  end;
end;


function TacDialogWnd.HTProcess(var Message: TWMNCHitTest): integer;
var
  p: TPoint;
  b: boolean;
  cy1, cy2, SysBtnCount, BtnIndex: integer;

  function GetBtnIndex(x: integer): integer;
  var
    c: integer;
  begin
    Result := 0;
    c := 0;
    if VisibleClose then begin
      inc(c);
      if Between(x, ButtonClose.Rect.Left, ButtonClose.Rect.Right) then begin
        Result := c;
        Exit;
      end;

      if VisibleMax then begin
        inc(c);
        if Between(x, ButtonMax.Rect.Left, ButtonMax.Rect.Right) then begin
          Result := c;
          Exit;
        end;
      end;

      if VisibleMin then begin
        inc(c);
        if Between(x, ButtonMin.Rect.Left, ButtonMin.Rect.Right) then begin
          Result := c;
          Exit;
        end;
      end;

      if VisibleHelp then begin
        inc(c);
        if Between(x, ButtonHelp.Rect.Left, ButtonHelp.Rect.Right) then begin
          Result := c;
          Exit;
        end;
      end;
    end;
  end;
  
begin
  p := CursorToPoint(Message.XPos, Message.YPos);
  cy1 := (CaptionHeight - ButtonHeight(ButtonClose.ImageIndex) + SysBorderHeight(CtrlHandle, BorderForm)) div 2;
  cy2 := cy1 + ButtonHeight(ButtonClose.ImageIndex);

  if Between(p.y, cy1, cy2) then begin // If in buttons
    if Between(p.x, SysBorderWidth(CtrlHandle, BorderForm), SysBorderWidth(CtrlHandle, BorderForm) + GetSystemMetrics(SM_CXSMICON)) then begin // If system menu icon
      SetHotHT(HTSYSMENU);
      Result := HTSYSMENU;
      Exit;
    end;
    // Title button?
    SysBtnCount := 0;
    if VisibleClose then
      inc(SysBtnCount);

    if VisibleMax then
      inc(SysBtnCount);

    if VisibleMin or IsIconic(CtrlHandle) then
      inc(SysBtnCount);

    if VisibleHelp then
      inc(SysBtnCount);

    BtnIndex := GetBtnIndex(p.x);
    if (BtnIndex > 0) and (BtnIndex <= SysBtnCount) then begin // If system button
      case BtnIndex of

        1:
          if VisibleClose then begin
            if EnabledClose then begin
              SetHotHT(HTCLOSE);
              Result := HTCLOSE;
            end
            else
              Result := HTNOWHERE;

            Exit;
          end;

        2:
          if VisibleMax then
            if (EnabledMax or EnabledRestore) then begin
              SetHotHT(HTMAXBUTTON);
              Result := HTMAXBUTTON;
              Exit;
            end
            else begin
              SetHotHT(HTCAPTION);
              Result := HTCAPTION;
              Exit;
            end
          else
            if VisibleMin or IsIconic(CtrlHandle) then
              if EnabledMin then begin
                SetHotHT(HTMINBUTTON);
                Result := HTMINBUTTON;
                Exit;
              end
              else begin
                SetHotHT(HTCAPTION);
                Result := HTCAPTION;
                Exit;
              end
            else
              if VisibleHelp then begin
                SetHotHT(HTHELP);
                Result := HTHELP;
                Exit;
              end;

        3:
          if (VisibleMin) or IsIconic(CtrlHandle) then
            if not IsIconic(CtrlHandle) then
              if EnabledMin then begin
                SetHotHT(HTMINBUTTON);
                Result := HTMINBUTTON;
                Exit;
              end
              else begin
                SetHotHT(HTCAPTION);
                Result := HTCAPTION;
                Exit;
              end
            else begin
              SetHotHT(HTMINBUTTON);
              Result := HTMINBUTTON;
              Exit;
            end
          else
            if VisibleHelp then begin
              SetHotHT(HTHELP);
              Result := HTHELP;
              Exit;
            end;

        4:
          if VisibleHelp and VisibleMax then begin
            SetHotHT(HTHELP);
            Result := HTHELP;
            Exit;
          end;
      end;
    end
    else begin
      Result := HTCAPTION;
      Exit;
    end;
  end;
  b := IsZoomed(CtrlHandle);
  if b and AboveBorder(Message) then
    Result := HTTRANSPARENT
  else
    Result := Message.Result;
end;


procedure TacDialogWnd.SetHotHT(i: integer; Repaint: boolean);
begin
  if (CurrentHT <> i) then begin
    if (CurrentHT <> 0) then begin
      case CurrentHT of
        HTCLOSE:     ButtonClose.State := 0;
        HTMAXBUTTON: ButtonMax  .State := 0;
        HTMINBUTTON: ButtonMin  .State := 0;
        HTHELP:      ButtonHelp .State := 0;
      end;
      if Repaint then
        RepaintButton(CurrentHT);
    end;
    CurrentHT := i;
    case CurrentHT of
      HTCLOSE:     ButtonClose.State := 1;
      HTMAXBUTTON: ButtonMax  .State := 1;
      HTMINBUTTON: ButtonMin  .State := 1;
      HTHELP:      ButtonHelp .State := 1;
    end;
    biClicked := False;
    if Repaint then
      RepaintButton(CurrentHT);
  end;
end;


function TacDialogWnd.CursorToPoint(x, y: integer): TPoint;
begin
  GetWindowRect(CtrlHandle, WndRect);
  Result := WndRect.TopLeft;
  Result.x := x - Result.x;
  Result.y := y - Result.y;
end;


function TacDialogWnd.AboveBorder(Message: TWMNCHitTest): boolean;
var
  p: TPoint;
begin
  p := CursorToPoint(Message.XPos, Message.YPos);
  Result := not PtInRect(Rect(2, 2, WndSize.cx - 4, WndSize.cy - 4), p);
  if Result then
    SetHotHT(0);
end;


procedure TacDialogWnd.RepaintButton(i: integer);
var
  CurButton: PsCaptionButton;
  cx, ind, x, y: integer;
  BtnDisabled: boolean;
  DC, SavedDC: hdc;
  R: TRect;
begin
  x := 0;
  y := 0;
  CurButton := nil;
  case i of
    HTCLOSE:     CurButton := @ButtonClose;
    HTMAXBUTTON: CurButton := @ButtonMax;
    HTMINBUTTON: CurButton := @ButtonMin;
    HTHELP:      CurButton := @ButtonHelp;
  end;
  with SkinData.SkinManager do
    if not Effects.AllowGlowing then begin
      if (CurButton <> nil) and (CurButton^.State <> -1) then begin
        BtnDisabled := False;
        if CurButton^.Rect.Left <= GetSystemMetrics(SM_CXSMICON) + SysBorderWidth(CtrlHandle, BorderForm) then
          Exit;
          
        cx := SkinData.FCacheBmp.Width - CurButton^.Rect.Left;
        BitBlt(SkinData.FCacheBmp.Canvas.Handle, // Restore a button BG
               CurButton^.Rect.Left, CurButton^.Rect.Top, SysButtonwidth(CurButton^), ButtonHeight(CurButton^.ImageIndex),
               TempBmp.Canvas.Handle, TempBmp.Width - cx, CurButton^.Rect.Top, SRCCOPY);
        // if Max btn and form is maximized then Norm btn
        if (i = HTMAXBUTTON) and IsZoomed(CtrlHandle) then
          ind := GetMaskIndex(SkinData.SkinIndex, s_BorderIconNormalize)
        else
          if IsIconic(CtrlHandle) then
            case i of
              HTMINBUTTON: begin
                ind := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconNormalize);
                if ind < 0 then
                  ind := GetMaskIndex(SkinData.SkinIndex, s_BorderIconNormalize); // For compatibility
              end;

              HTMAXBUTTON: begin
                ind := GetMaskIndex(ConstData.IndexGlobalInfo, s_BorderIconMaximize);
                if ind < 0 then
                  ind := GetMaskIndex(SkinData.SkinIndex, s_BorderIconMaximize); // For compatibility

                if not EnabledMax then
                  BtnDisabled := True;
              end

              else
                ind := CurButton^.ImageIndex;
            end
          else
            ind := CurButton^.ImageIndex;

        if IsValidImgIndex(ind) then // Drawing of the button from skin
          if i < HTUDBTN then // if not user defined
            DrawSkinGlyph(SkinData.FCacheBmp, CurButton^.Rect.TopLeft,
                          CurButton^.State, 1 + integer(not boolean(FormActive) or BtnDisabled) * integer(not (CurButton^.State > 0) or BtnDisabled),
                          ma[ind], MakeCacheInfo(SkinData.FCacheBmp));

        if (BorderForm <> nil) then begin
          if BorderForm.AForm <> nil then
            SetFormBlendValue(BorderForm.AForm.Handle, SkinData.FCacheBmp, MaxByte);
        end
        else begin
          // Copying to form
          DC := GetWindowDC(CtrlHandle);
          if Application.BiDiMode = bdRightToLeft then
            acSetLayout(DC, 0);

          SavedDC := SaveDC(DC);
          try
            BitBlt(DC, CurButton^.Rect.Left, CurButton^.Rect.Top, WidthOf(CurButton^.Rect), HeightOf(CurButton^.Rect),
                   SkinData.FCacheBmp.Canvas.Handle, CurButton^.Rect.Left, CurButton^.Rect.Top, SRCCOPY);

            if (CurButton^.State = 1) and (i in [HTCLOSE, HTMAXBUTTON, HTMINBUTTON]) then begin
              case i of
                HTCLOSE:     x := CommonSkinData.BICloseGlow;
                HTMAXBUTTON: x := CommonSkinData.BIMaxGlow;
                HTMINBUTTON: x := CommonSkinData.BIMinGlow;
              end;
              if x > 0 then begin
                case i of
                  HTCLOSE:     y := CommonSkinData.BICloseGlowMargin;
                  HTMAXBUTTON: y := CommonSkinData.BIMaxGlowMargin;
                  HTMINBUTTON: y := CommonSkinData.BIMinGlowMargin;
                end;
                GetWindowRect(CtrlHandle, R);
                OffsetRect(R, CurButton^.Rect.Left, CurButton^.Rect.Top);
                R.Right := R.Left + WidthOf(CurButton^.Rect);
                R.Bottom := R.Top + HeightOf(CurButton^.Rect);
                if Effects.AllowGlowing then
                  CurButton^.GlowID := ShowGlow(R, {R, }s_GlobalInfo, ma[CurButton.ImageIndex].PropertyName + s_Glow, y, MaxByte, CtrlHandle, SkinData);
              end;
            end
            else
              if CurButton^.GlowID <> -1 then begin
                HideGlow(CurButton^.GlowID);
                CurButton^.GlowID := -1;
              end;
          finally
            RestoreDC(DC, SavedDC);
            ReleaseDC(CtrlHandle, DC);
          end;
        end;
      end
      else
        if (CurButton <> nil) and (CurButton^.GlowID <> -1) then begin
          HideGlow(CurButton^.GlowID);
          CurButton^.GlowID := -1;
        end;
    end
  else
    if (CurButton <> nil) and (CurButton^.State <> -1) then
      case CurButton^.State of
        1:   StartSBAnimation(CurButton, CurButton^.State, 10, CurButton^.State <> 0, nil, Self);
        2:   StartSBAnimation(CurButton, CurButton^.State, 1,  CurButton^.State <> 0, nil, Self);
        else StartSBAnimation(CurButton, CurButton^.State, 10, False,                 nil, Self);
      end;
end;


procedure TacDialogWnd.Ac_WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  case TWMNCLButtonDown(Message).HitTest of
    HTCLOSE, HTMAXBUTTON, HTMINBUTTON, HTHELP, HTCHILDCLOSE..HTCHILDMIN:
      SetPressedHT(TWMNCLButtonDown(Message).HitTest);

    HTSYSMENU: begin
      SetHotHT(0);
{$IFNDEF FPC}
      DropSysMenu(WndRect.Left + SysBorderWidth(CtrlHandle, BorderForm), WndRect.Top + BorderHeight + GetSystemMetrics(SM_CYSMICON));
{$ENDIF}
    end

    else
      if IsIconic(CtrlHandle) then
        SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_DRAGMOVE, 0)
      else begin
        SetHotHT(0);
        if not IsZoomed(CtrlHandle) or (CursorToPoint(0, TWMNCLButtonDown(Message).YCursor).y > SysBorderHeight(CtrlHandle, BorderForm) + CaptionHeight) then begin
          if (Message.HitTest = HTCAPTION) and
               (SkinData.SkinManager.AnimEffects.BlendOnMoving.Active and
                 (SkinData.SkinManager.AnimEffects.BlendOnMoving.BlendValue <> MaxByte)) and
                   not IsIconic(CtrlHandle) then begin
            SkinData.BGChanged := True;
            FFormActive := True;
            PaintAll;
            StartBlendOnMovingDlg(Self);
            Exit;
          end;
          Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, TMessage(Message).WParam, TMessage(Message).LParam);
        end
        else
          if not FormActive then
            SetFocus(CtrlHandle);
      end;
  end;
end;


procedure TacDialogWnd.SetPressedHT(i: integer);
begin
  if (CurrentHT <> i) and (CurrentHT <> 0) then begin
    case CurrentHT of
      HTCLOSE:     ButtonClose.State := 0;
      HTMAXBUTTON: ButtonMax.  State := 0;
      HTMINBUTTON: ButtonMin.  State := 0;
      HTHELP:      ButtonHelp. State := 0;
    end;
    RepaintButton(CurrentHT);
  end;
  CurrentHT := i;
  case CurrentHT of
    HTCLOSE:     ButtonClose.State := 2;
    HTMINBUTTON: ButtonMin.  State := 2;
    HTHELP:      ButtonHelp. State := 2;
    HTMAXBUTTON:
      if EnabledMax or (IsZoomed(CtrlHandle) and EnabledRestore) then
        ButtonMax.State := 2;
  end;
  biClicked := True;
  RepaintButton(CurrentHT);
end;


{$IFNDEF FPC}
procedure TacDialogWnd.DropSysMenu(x, y: integer);
begin
  SystemMenu.WindowHandle := CtrlHandle;
  SystemMenu.Popup(x, y);
end;
{$ENDIF}


procedure TacDialogWnd.Ac_WMLButtonUp(var Message: TMessage);
begin
  case TWMNCHitMessage(Message).HitTest of
    HTCLOSE:
      if biClicked then begin
        ButtonClose.State := 0;
        SetHotHT(0);
        SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_CLOSE, 0);
        KillAnimations;
        if IsWindowVisible(CtrlHandle) then
          SetHotHT(0);
      end;

    HTMAXBUTTON:
      if not IsIconic(CtrlHandle) or (IsIconic(CtrlHandle) and EnabledMax) then
        if biClicked then begin
          SetHotHT(0);
          if IsZoomed(CtrlHandle) then
            SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_RESTORE, 0)
          else
            SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);

          SystemMenu.UpdateItems;
        end
        else
          SetHotHT(0);

    HTMINBUTTON:
      if biClicked then begin
        SetHotHT(0);
        if IsIconic(CtrlHandle) then
          SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_RESTORE, 0)
        else
          SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
      end
      else
        SetHotHT(0);

    HTHELP:
      if biClicked then begin
        SendMessage(CtrlHandle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0);
        SetHotHT(0);
        SystemMenu.UpdateItems;
        SendMessage(CtrlHandle, WM_NCPAINT, 0, 0);
      end
      else
        SetHotHT(0)

    else
      Message.Result := CallWindowProc(OldProc, CtrlHandle, Message.Msg, Message.WParam, Message.LParam);
  end;
  TWMNCHitMessage(Message).HitTest := 0;
end;


procedure TacDialogWnd.Ac_WMNCActivate(var Message: TMessage);
begin
  SkinData.BGChanged := True;
  InvalidateRect(CtrlHandle, nil, False);
  RedrawWindow(CtrlHandle, nil, 0, RDW_ALLCHILDREN or RDW_FRAME or RDW_INVALIDATE); // Repaint of child controls
  if (BorderForm <> nil) and IsWindowVisible(CtrlHandle) then
    BorderForm.UpdateExBordersPos;
end;


procedure TacDialogWnd.Ac_DrawStaticItem(var Message: TWMDrawItem);
begin
  SetBkMode(TWMDrawItem(Message).DrawItemStruct.hDC, TRANSPARENT);
end;


procedure TacDialogWnd.InitExBorders(const Active: boolean);
begin
  if Active and not (csDesigning in SkinData.SkinManager.ComponentState) then begin
    if BorderForm = nil then begin
      BorderForm := TacBorderForm.Create(Self);
      BorderForm.SkinData := SkinData;
      SkinData.BGChanged := True;
      if IsWindowVisible(CtrlHandle) then
        BorderForm.UpdateExBordersPos;
    end;
  end
  else
    if BorderForm <> nil then
      FreeAndNil(BorderForm);
end;


function TacDialogWnd.IconRect: TRect;
begin
  with SkinData.SkinManager.CommonSkinData do begin
    Result.Left := SysBorderWidth(CtrlHandle, BorderForm) + BILeftMargin;
    if BorderForm <> nil then
      inc(Result.Left, BorderForm.ShadowSize.Left);

    Result.Right := Result.Left + GetSystemMetrics(SM_CXSMICON);
    Result.Top := (CaptionHeight + SysBorderHeight(CtrlHandle, BorderForm) - GetSystemMetrics(SM_CYSMICON)) div 2;
    if BorderForm <> nil then
      inc(Result.Top, BorderForm.ShadowSize.Top);

    Result.Bottom := Result.Top + GetSystemMetrics(SM_CYSMICON);
    if (BorderForm <> nil) and (ExDrawMode = 1) then
      OffsetRect(Result, 0, ExCenterOffs);
  end;
end;


function TacDialogWnd.ShadowSize: TRect;
begin
  if BorderForm = nil then
    Result := MkRect
  else
    Result := SkinData.SkinManager.FormShadowSize
end;


procedure TacDialogWnd.KillAnimations;
begin
  if ButtonMin.Timer <> nil then
    FreeAndNil(ButtonMin.Timer);

  if ButtonMax.Timer <> nil then
    FreeAndNil(ButtonMax.Timer);

  if ButtonClose.Timer <> nil then
    FreeAndNil(ButtonClose.Timer);

  if ButtonHelp.Timer <> nil then
    FreeAndNil(ButtonHelp.Timer);
end;


procedure TacDialogWnd.AfterCreation;
begin
  inherited;
  Initialized := False;
  RgnChanged := True;
  BorderStyle := acbsSingle;
  TempBmp := TBitmap.Create;
  FFormActive := True;
  FWMPaintForbidden := Win32MajorVersion >= 6;
  FCaptionSkinIndex := -1;
  TitleIndex := -1;
  MoveTimer := nil;
  CoverForm := nil;
  SystemMenu := TacSystemMenu.Create(nil);
  SystemMenu.FOwner := Self;
  SystemMenu.UpdateItems;
  SkinData.Updating := True;
  SetClassLong(CtrlHandle, GCL_STYLE, GetClassLong(CtrlHandle, GCL_STYLE) and not CS_SAVEBITS); // For a repainting under resized dialog
  InitDwm(CtrlHandle, True);
{$IFNDEF FPC}
  if (DefaultManager <> nil) and DefaultManager.SkinnedPopups then
    DefaultManager.SkinableMenus.HookPopupMenu(SystemMenu, True);
{$ENDIF}

  UpdateIconsIndexes;
end;


procedure TacSystemMenu.CloseClick(Sender: TObject);
begin
  Sendmessage(FOwner.CtrlHandle, WM_SYSCOMMAND, SC_CLOSE, 0);
end;


constructor TacSystemMenu.Create(AOwner: TComponent);

  function CreateSystemItem(const Caption, Name: string; EventProc: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    Result.Caption := Caption;
    Result.OnClick := EventProc;
    Result.Name := Name;
  end;

begin
  inherited Create(AOwner);
  ItemRestore  := CreateSystemItem(acs_RestoreStr,  'miRestore',  RestoreClick); Self.Items.Add(ItemRestore);
  ItemMove     := CreateSystemItem(acs_MoveStr,     'miMove',     MoveClick);    Self.Items.Add(ItemMove);
  ItemSize     := CreateSystemItem(acs_SizeStr,     'miSize',     SizeClick);    Self.Items.Add(ItemSize);
  ItemMinimize := CreateSystemItem(acs_MinimizeStr, 'miMinimize', MinClick);     Self.Items.Add(ItemMinimize);
  ItemMaximize := CreateSystemItem(acs_MaximizeStr, 'miMaximize', MaxClick);     Self.Items.Add(ItemMaximize);
  ItemClose    := CreateSystemItem(acs_CloseStr,    'miClose',    CloseClick);   Self.Items.Add(ItemClose);
{$IFNDEF FPC}
  Self.Items.InsertNewLineAfter(ItemMaximize);
{$ENDIF}
  ItemClose.ShortCut := scAlt + VK_F4;
end;


function TacSystemMenu.EnabledMax: boolean;
begin
  Result := FOwner.EnabledMax;
end;


function TacSystemMenu.EnabledMin: boolean;
begin
  Result := FOwner.EnabledMin;
end;


function TacSystemMenu.EnabledMove: boolean;
begin
  Result := not IsZoomed(FOwner.CtrlHandle);
end;


function TacSystemMenu.EnabledRestore: boolean;
begin
  Result := FOwner.EnabledRestore;
end;


function TacSystemMenu.EnabledSize: boolean;
begin
  Result := (FOwner.BorderStyle <> acbsSingle) and not IsIconic(FOwner.CtrlHandle);
end;


procedure TacSystemMenu.MaxClick(Sender: TObject);
begin
  Sendmessage(FOwner.CtrlHandle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
  UpdateItems;
end;


procedure TacSystemMenu.MinClick(Sender: TObject);
begin
  SendMessage(FOwner.CtrlHandle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;


procedure TacSystemMenu.MoveClick(Sender: TObject);
begin
  Sendmessage(FOwner.CtrlHandle, WM_SYSCOMMAND, SC_MOVE, 0);
end;


procedure TacSystemMenu.RestoreClick(Sender: TObject);
begin
  Sendmessage(FOwner.CtrlHandle, WM_SYSCOMMAND, SC_RESTORE, 0);
  UpdateItems;
end;


procedure TacSystemMenu.SizeClick(Sender: TObject);
begin
  Sendmessage(FOwner.CtrlHandle, WM_SYSCOMMAND, SC_SIZE, 0);
end;


procedure TacSystemMenu.UpdateItems;
begin
  ItemRestore.Visible  := FOwner.VisibleRestore;
  ItemMove.Visible     := True;
  ItemSize.Visible     := VisibleSize;
  ItemMinimize.Visible := FOwner.VisibleMin;
  ItemMaximize.Visible := FOwner.VisibleMax;
  ItemClose.Visible    := FOwner.VisibleClose;

  ItemRestore.Enabled  := FOwner.EnabledRestore;
  ItemMove.Enabled     := EnabledMove;
  ItemSize.Enabled     := EnabledSize;
  ItemMinimize.Enabled := FOwner.EnabledMin;
  ItemMaximize.Enabled := FOwner.EnabledMax;
  ItemClose.Enabled    := True;
end;


function TacSystemMenu.VisibleClose: boolean;
begin
  Result := FOwner.dwStyle and WS_SYSMENU = WS_SYSMENU
end;


function TacSystemMenu.VisibleMax: boolean;
begin
  Result := FOwner.VisibleMax;
end;


function TacSystemMenu.VisibleMin: boolean;
begin
  Result := FOwner.VisibleMin;
end;


function TacSystemMenu.VisibleSize: boolean;
begin
  Result := not (FOwner.BorderStyle in [acbsDialog, acbsNone, acbsToolWindow]);
end;


procedure ClearMnuArray;
var
  i: integer;
begin
{$IFNDEF NOMNUHOOK}
  if MnuArray <> nil then
    for i := 0 to Length(MnuArray) - 1 do
      if (MnuArray[i] <> nil) then
        FreeAndNil(MnuArray[i]);

  SetLength(MnuArray, 0);
{$ENDIF}
end;


initialization

finalization
  ClearMnuArray;
  if acSupportedList <> nil then begin
    while acSupportedList.Count > 0 do begin
      TObject(acSupportedList[0]).Free;
      acSupportedList.Delete(0);
    end;
    FreeAndNil(acSupportedList);
  end;

end.
