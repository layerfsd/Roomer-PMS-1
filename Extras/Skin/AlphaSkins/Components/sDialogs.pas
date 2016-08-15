unit sDialogs;
{$I sDefs.inc}

interface

uses
  Windows, Dialogs, Forms, Classes, SysUtils, Graphics, ExtDlgs, Controls,
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFDEF TNTUNICODE} TntDialogs, TntExtDlgs, TntFileCtrl, MultiMon, {$ENDIF}
  sConst;


type
{$IFNDEF NOTFORHELP}
  TsZipShowing = (zsAsFolder, zsAsFile);
{$ENDIF} // NOTFORHELP


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsOpenDialog = class(TTntOpenDialog)
{$ELSE}
  TsOpenDialog = class(TOpenDialog)
{$ENDIF}
  private
    FZipShowing: TsZipShowing;
{$IFNDEF NOTFORHELP}
  public
    constructor Create(AOwner: TComponent); override;
{$ENDIF} // NOTFORHELP
  published
    property ZipShowing: TsZipShowing read FZipShowing write FZipShowing default zsAsFolder;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsOpenPictureDialog = class(TTntOpenPictureDialog)
{$ELSE}
  TsOpenPictureDialog = class(TOpenPictureDialog)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FPicture: TPicture;
    function IsFilterStored: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoSelectionChange; override;
    procedure DoShow; override;
  published
    property Filter stored IsFilterStored;
{$ENDIF} // NOTFORHELP
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsSaveDialog = class(TTntSaveDialog)
{$ELSE}
  TsSaveDialog = class(TSaveDialog)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  public
{$ENDIF} // NOTFORHELP
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsSavePictureDialog = class(TTntSavePictureDialog)
{$ELSE}
  TsSavePictureDialog = class(TSavePictureDialog)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FPicture: TPicture;
    function IsFilterStored: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Filter stored IsFilterStored;
{$ENDIF} // NOTFORHELP
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsColorDialog = class(TColorDialog)
{$IFNDEF NOTFORHELP}
  private
    FMainColors: TStrings;
    FStandardDlg: boolean;
    procedure SetMainColors(const Value: TStrings);
  public
    function Execute: Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoShow; override;
    procedure DoClose; override;
  published
    property Options default [cdFullOpen];
{$ENDIF} // NOTFORHELP
    property MainColors: TStrings read FMainColors write SetMainColors;
    property StandardDlg: boolean read FStandardDlg write FStandardDlg default False;
  end;


{$IFNDEF NOTFORHELP}
function sCreateMessageDialog(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TForm;
{$ENDIF} // NOTFORHELP

function sMessageDlg(const        Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt): Integer; overload;
function sMessageDlg(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt): Integer; overload;
function sMessageDlgPos(const        Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt; X, Y: Integer): Integer; overload;
function sMessageDlgPos(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt; X, Y: Integer): Integer; overload;

function sMessageDlgPosHelp(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
                            HelpCtx: LongInt; X, Y: Integer; const HelpFileName: acString): Integer;

procedure sShowMessage(const        Msg: acString); overload;
procedure sShowMessage(const Title, Msg: acString); overload;
procedure sShowMessageFmt(const        Msg: acString; const Params: array of const); overload;
procedure sShowMessageFmt(const Title, Msg: acString; const Params: array of const); overload;
procedure sShowMessagePos(const        Msg: acString; X, Y: Integer); overload;
procedure sShowMessagePos(const Title, Msg: acString; X, Y: Integer); overload;

{ Input dialog }
function sInputBox  (const ACaption, APrompt, ADefault: acString): acString;
function sInputQuery(const ACaption, APrompt: acString; var Value: acString): Boolean;

{$IFDEF TNTUNICODE}
function Application_MessageBoxW(const Text, Caption: PWideChar; Flags: Longint): Integer;
{$ENDIF}


implementation

uses
  sColorDialog, sSkinManager, acDials, acntUtils;


var
  Captions: array[TMsgDlgType] of acString = ('Warning', 'Error', 'Information', 'Confirm', '');


function sCreateMessageDialog(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TForm;
begin
{$IFDEF TNTUNICODE}
  Result := WideCreateMessageDialog(Msg, DlgType, Buttons);
{$else}
  Result := CreateMessageDialog(Msg, DlgType, Buttons);
{$ENDIF}
end;


function sMessageDlg(const Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt): Integer;
begin
  Result := sMessageDlgPosHelp('', Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;


function sMessageDlg(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt): Integer;
begin
  Result := sMessageDlgPosHelp(Title, Msg, DlgType, Buttons, HelpCtx, -1, -1, '');
end;


function sMessageDlgPos(const Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt; X, Y: Integer): Integer;
begin
  Result := sMessageDlgPosHelp('', Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;


function sMessageDlgPos(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt; X, Y: Integer): Integer;
begin
  Result := sMessageDlgPosHelp(Title, Msg, DlgType, Buttons, HelpCtx, X, Y, '');
end;


{$IFDEF TNTUNICODE}
function Application_MessageBoxW(const Text, Caption: PWideChar; Flags: Longint): Integer;
var
  ActiveWindow, TaskActiveWindow: HWnd;
  MBMonitor, AppMonitor: HMonitor;
  FocusState: TFocusState;
  MonInfo: TMonitorInfo;
  WindowList: Pointer;
  Rect: TRect;
begin
  with Application do begin
  {$IFDEF D2006}
    ActiveWindow := ActiveFormHandle;
  {$ELSE}
    ActiveWindow := GetActiveWindow;
  {$ENDIF}
    if ActiveWindow = 0 then
      TaskActiveWindow := Handle
    else
      TaskActiveWindow := ActiveWindow;

    MBMonitor := MonitorFromWindow(ActiveWindow, MONITOR_DEFAULTTONEAREST);
    AppMonitor := MonitorFromWindow(Handle, MONITOR_DEFAULTTONEAREST);
    if MBMonitor <> AppMonitor then begin
      MonInfo.cbSize := Sizeof(TMonitorInfo);
      GetMonitorInfo(MBMonitor, @MonInfo);
      GetWindowRect(Handle, Rect);
      with MonInfo.rcMonitor do
        SetWindowPos(Handle, 0, Left + (Right - Left) div 2, Top + (Bottom - Top) div 2, 0, 0, SWP_NOACTIVATE or SWP_NOREDRAW or SWP_NOSIZE or SWP_NOZORDER);
    end;
    WindowList := DisableTaskWindows(ActiveWindow);
    FocusState := SaveFocusState;
    if UseRightToLeftReading then
      Flags := Flags or MB_RTLREADING;

    try
{$IFDEF DELPHI7UP}
      Application.ModalStarted;
{$ENDIF}
      Result := MessageBoxW(TaskActiveWindow, Text, Caption, Flags);
{$IFDEF DELPHI7UP}
      Application.ModalFinished;
{$ENDIF}
    finally
      if MBMonitor <> AppMonitor then
        SetWindowPos(Handle, 0,
                     Rect.Left + (WidthOf(Rect)  div 2),
                     Rect.Top  + (HeightOf(Rect) div 2),
                     0, 0, SWP_NOACTIVATE or SWP_NOREDRAW or SWP_NOSIZE or SWP_NOZORDER);
      EnableTaskWindows(WindowList);
      SetActiveWindow(ActiveWindow);
      RestoreFocusState(FocusState);
    end;
  end;
end;
{$ENDIF}


procedure MsgBoxCallback(var lpHelpInfo: THelpInfo); stdcall;
begin
  if lpHelpInfo.dwContextId <> 0 then
    Application.HelpContext(lpHelpInfo.dwContextId);
end;


function sMessageDlgPosHelp(const Title, Msg: acString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: LongInt; X, Y: Integer; const HelpFileName: acString): Integer;
const
  MB_HELP = $4000;
  MB_YESTOALL = $A000;
var
  Flags: DWORD;
  Caption: acString;
  ActiveWnd: hwnd;
{$IFDEF TNTUNICODE}
  mParams: TMsgBoxParamsW;
{$ELSE}
  mParams: TMsgBoxParams;
{$ENDIF}
  WindowList: Pointer;
begin
  case DlgType of
    mtWarning:      Flags := MB_ICONWARNING;
    mtError:        Flags := MB_ICONERROR;
    mtInformation:  Flags := MB_ICONINFORMATION;
    mtConfirmation: Flags := MB_ICONQUESTION
    else            Flags := 0;
  end;
  Caption := iff(Title = '', Captions[DlgType], Title);

  if mbOk in Buttons then
    Flags := Flags or DWord(iff(mbCancel in Buttons, MB_OKCANCEL, MB_OK))
  else
    if (mbAbort in Buttons) or (mbIgnore in Buttons) then
      Flags := Flags or MB_ABORTRETRYIGNORE
    else
      if (mbYes in Buttons) or (mbNo in Buttons) then
        Flags := Flags or DWord(iff(mbCancel in Buttons, MB_YESNOCANCEL, MB_YESNO))
      else
        if mbRetry in Buttons then
          Flags := Flags or MB_RETRYCANCEL;

  if mbHelp in Buttons then
    Flags := Flags or MB_HELP;

  DlgLeft := X; DlgTop := Y;
{$IFDEF DELPHI7UP}
  Application.ModalStarted;
{$ENDIF}
  FillChar(mParams, SizeOf(mParams), 0);
  mParams.cbSize := SizeOf(mParams);
  mParams.dwContextHelpId := HelpCtx;
  mParams.dwStyle := Flags;
  mParams.lpszCaption := PacChar(Caption);
  mParams.lpszText := PacChar(Msg);
{$IFDEF D2005}
  mParams.hwndOwner := Application.ActiveFormHandle;
{$ELSE}
  mParams.hwndOwner := Application.Handle;
{$ENDIF}
{$T-}
  mParams.lpfnMsgBoxCallback := @MsgBoxCallback;
{$T+}
  ActiveWnd := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
{$IFDEF TNTUNICODE}
  Result := integer(MessageBoxIndirectW(mParams));
{$ELSE}
  Result := integer(MessageBoxIndirect(mParams));
{$ENDIF}
  EnableTaskWindows(WindowList);
  if ActiveWnd <> 0 then begin
    SetFocus(0);
    SetFocus(ActiveWnd);
  end;
{$IFDEF DELPHI7UP}
  Application.ModalFinished;
{$ENDIF}
  DlgLeft := -1;
  DlgTop := -1;
end;


procedure sShowMessage(const Msg: acString);
begin
  sShowMessagePos(Msg, -1, -1);
end;


procedure sShowMessage(const Title, Msg: acString);
begin
  sShowMessagePos(Title, Msg, -1, -1);
end;


procedure sShowMessageFmt(const Msg: acString; const Params: array of const);
begin
  sShowMessage(Format(Msg, Params));
end;


procedure sShowMessageFmt(const Title, Msg: acString; const Params: array of const);
begin
  sShowMessage(Title, Format(Msg, Params));
end;


procedure sShowMessagePos(const Msg: acString; X, Y: Integer);
begin
  sMessageDlgPos(Msg, mtCustom, [mbOK], 0, X, Y);
end;


procedure sShowMessagePos(const Title, Msg: acString; X, Y: Integer);
begin
  sMessageDlgPos(Title, Msg, mtCustom, [mbOK], 0, X, Y);
end;


function sInputQuery(const ACaption, APrompt: acString; var Value: acString): Boolean;
begin
{$IFDEF TNTUNICODE}
  Result := WideInputQuery(ACaption, APrompt, Value);
{$ELSE}
  Result := InputQuery(ACaption, APrompt, Value);
{$ENDIF}
end;


function sInputBox(const ACaption, APrompt, ADefault: acString): acString;
begin
  Result := ADefault;
  sInputQuery(ACaption, APrompt, Result);
end;


constructor TsOpenDialog.Create(AOwner: TComponent);
begin
  inherited;
  FZipShowing := zsAsFolder;
end;


constructor TsOpenPictureDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Filter := GraphicFilter(TGraphic);
end;


destructor TsOpenPictureDialog.Destroy;
begin
  if Assigned(FPicture) then
    FreeAndNil(FPicture);

  inherited;
end;


procedure TsOpenPictureDialog.DoSelectionChange;
begin
  if not (csDestroying in ComponentState) then
    inherited DoSelectionChange;
end;


procedure TsOpenPictureDialog.DoShow;
begin
  inherited DoShow;
end;


function TsOpenPictureDialog.IsFilterStored: Boolean;
begin
  Result := Filter <> GraphicFilter(TGraphic);
end;


constructor TsSavePictureDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Filter := GraphicFilter(TGraphic);
end;


destructor TsSavePictureDialog.Destroy;
begin
  if Assigned(FPicture) then
    FreeAndNil(FPicture);

  inherited;
end;


function TsSavePictureDialog.IsFilterStored: Boolean;
begin
  Result := Filter <> GraphicFilter(TGraphic);
end;


constructor TsColorDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMainColors := TStringList.Create;
  FStandardDlg := False;
  Options := [cdFullOpen];
end;


destructor TsColorDialog.Destroy;
begin
  FreeAndNil(FMainColors);
  inherited Destroy;
end;


procedure TsColorDialog.DoClose;
begin
  inherited;
end;


procedure TsColorDialog.DoShow;
begin
  inherited;
end;


function TsColorDialog.Execute: Boolean;
begin
  if not FStandardDlg and Assigned(DefaultManager) then begin
    sColorDialogForm := TsColorDialogForm.Create(Application);
    with sColorDialogForm do begin
//      InitLngCaptions;
      Owner := Self;

      if CustomColors.Count > 0 then
        AddPal.Colors.Assign(CustomColors)
      else
        AddPal.Colors.Assign(acCustomColors);

      AddPal.GenerateColors;

      if MainColors.Count > 0 then begin
        MainPal.Colors.Assign(MainColors);
        MainPal.GenerateColors;
      end;

      ModalResult := mrCancel;
      BorderStyle := bsSingle;

      InitControls(cdFullOpen in Options, cdShowHelp in Options, Self.Color, bsSingle);

      ShowModal;
      Result := ModalResult = mrOk;
      CustomColors.Assign(AddPal.Colors);
      DoClose;
      if Result then
        Self.Color := SelectedPanel.Brush.Color;

      if sColorDialogForm <> nil then
        FreeAndNil(sColorDialogForm);
    end;
  end
  else
    Result := inherited Execute;
end;


procedure TsColorDialog.SetMainColors(const Value: TStrings);
begin
  FMainColors.Assign(Value);
end;

end.










