unit acPopupController;
{$I sDefs.inc}
//{$DEFINE LOGGED}

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
    Form: TForm;
    Ctrl: TWinControl;
    FormWndProc: TWndMethod;
    CtrlWndProc: TWndMethod;
    CheckTimer: TacThreadedTimer;
    Controller: TsPopupController;
    constructor Create(AForm: TForm; ACtrl: TWinControl);
    procedure CloseForm(CallProc: boolean = True);
    procedure DoTimer(Sender: TObject);
    procedure DoWndProc (var Message: TMessage);
    procedure DoCtrlProc(var Message: TMessage);
  public
    destructor Destroy; override;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsPopupController = class(TComponent)
  protected
    FormHandlers: array of TacFormHandler;
    function InitFormHandler(Form: TForm; Ctrl: TWinControl): integer;
    function GetFormIndex(Form: TForm): integer;
    procedure DoDeactivate(Sender: TObject);
    procedure DoClose(Sender: TObject; var Action: TCloseAction);
  public
    SkipOpen: boolean;
    constructor Create(AOwner: TComponent); override;
    procedure ShowForm(AForm: TForm; AOwnerControl: TWinControl);
  end;


procedure ShowPopupForm(AForm: TForm; AOwnerControl: TWinControl);


implementation

uses
  acntUtils, sVclUtils, StdCtrls, sComboBox;

var
  IntController: TsPopupController = nil;


procedure ShowPopupForm(AForm: TForm; AOwnerControl: TWinControl);
begin
  if IntController = nil then
    IntController := TsPopupController.Create(nil);

  IntController.ShowForm(AForm, AOwnerControl);
end;


function TsPopupController.InitFormHandler(Form: TForm; Ctrl: TWinControl): integer;
begin
  Result := GetFormIndex(Form);
  if Result < 0 then begin
    Result := Length(FormHandlers);
    SetLength(FormHandlers, Result + 1);
    FormHandlers[Result] := TacFormHandler.Create(Form, Ctrl);
    FormHandlers[Result].Controller := Self;
  end;
end;


function TsPopupController.GetFormIndex(Form: TForm): integer;
var
  i, l: integer;
begin
  Result := -1;
  l := Length(FormHandlers);
  for i := 0 to l - 1 do
    if FormHandlers[i].Form = Form then begin
      Result := i;
      Exit;
    end;
end;


constructor TsPopupController.Create(AOwner: TComponent);
begin
  inherited;
  SkipOpen := False;
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
  TForm(Sender).Close
end;


procedure TsPopupController.ShowForm(AForm: TForm; AOwnerControl: TWinControl);
var
  ctrlRect, formRect, workRect: TRect;
  ParentForm: TCustomForm;
  Flags: Cardinal;
begin
  if (AForm <> nil) and (AOwnerControl <> nil) and not SkipOpen then begin
    if AOwnerControl.CanFocus then
      AOwnerControl.SetFocus;

    AForm.Visible := False;
    AForm.AlphaBlend := True;
    AForm.BorderStyle := bsNone;
    AForm.OnDeactivate := DoDeactivate;
    AForm.OnClose := DoClose;
    InitFormHandler(AForm, AOwnerControl);

    SetWindowLong(AForm.Handle, GWL_STYLE, GetWindowLong(AForm.Handle, GWL_STYLE) or WS_CLIPSIBLINGS or NativeInt(WS_POPUP));
    SetWindowLong(AForm.Handle, GWL_EXSTYLE, GetWindowLong(AForm.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
    DoLayered(AForm.Handle, True);

    ctrlRect.TopLeft := AOwnerControl.ClientToScreen(MkPoint);
    ctrlRect.BottomRight := Point(ctrlRect.Left + AOwnerControl.Width, ctrlRect.Top + AOwnerControl.Height);

    workRect := acWorkRect(ctrlRect.TopLeft);

    formRect.TopLeft := Point(ctrlRect.Left, ctrlRect.Bottom + 1);
    formRect.BottomRight := Point(formRect.Left + AForm.Width, formRect.Top + AForm.Height);
    AForm.SetBounds(formRect.Left, formRect.Top, AForm.Width, AForm.Height);

    if formRect.Bottom > workRect.Bottom then begin
      formRect.Bottom := ctrlRect.Top - 1;
      formRect.Top := formRect.Bottom - AForm.ClientHeight;
      if formRect.Top < workRect.Top then begin
        formRect.Top := workRect.Top;
        formRect.Bottom := formRect.Top + AForm.Height;
      end;
      AForm.SetBounds(formRect.Left, formRect.Top, AForm.Width, AForm.Height);
    end;

    ParentForm := GetParentForm(AOwnerControl);
    if (ParentForm is TForm) and (TForm(ParentForm).FormStyle = fsStayOnTop) then
      AForm.FormStyle := fsStayOnTop;

    SetClassLong(AForm.Handle, GCL_STYLE, GetClassLong(AForm.Handle, GCL_STYLE) or $20000);

    Flags := SWP_NOMOVE or SWP_NOSIZE or SWP_NOCOPYBITS or SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOOWNERZORDER;
    SetWindowPos(AForm.Handle, HWND_TOPMOST, 0, 0, AForm.Width, AForm.Height, Flags);

    AForm.Visible := True;
    DoLayered(AForm.Handle, True, MaxByte);
  end;
  SkipOpen := False;
end;


type
  TAccessComboBox = class(TsCustomComboBox);

procedure TacFormHandler.CloseForm(CallProc: boolean = True);
var
  aForm: TForm;
begin
  CheckTimer.Enabled := False;
  if (Form <> nil) and Form.CloseQuery then begin
    if (Ctrl is TsCustomComboBox) then
      with TAccessComboBox(Ctrl) do begin
        FDropDown := False;
        SkinData.Invalidate;
      end;

    Form.WindowProc := FormWndProc;
    Ctrl.WindowProc := CtrlWndProc;
    aForm := Form;
    Form := nil;
    Ctrl := nil;
    if CallProc then
      aForm.Close;
  end;
end;


constructor TacFormHandler.Create(AForm: TForm; ACtrl: TWinControl);
begin
  inherited Create;
  Form := AForm;
  Ctrl := ACtrl;
  FormWndProc := AForm.WindowProc;
  CtrlWndProc := ACtrl.WindowProc;
  Form.WindowProc := DoWndProc;
  Ctrl.WindowProc := DoCtrlProc;
  CheckTimer := TacThreadedTimer.Create(ACtrl);
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
    CM_FOCUSCHANGED, CM_CANCELMODE, WM_RBUTTONDOWN, WM_LBUTTONDOWN: begin
      if not (Ctrl is TCustomComboBox) then
        Controller.SkipOpen := Message.Msg = WM_LBUTTONDOWN;

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
  if Form <> nil then
    if not Application.Active then
      Closeform
    else begin
      CaptHandle := GetCapture;
      if (CaptHandle <> 0) then
        if not ContainsWnd(CaptHandle, Form.Handle) and not ContainsWnd(CaptHandle, Ctrl.Handle) then
          Closeform;
    end;
end;


procedure TacFormHandler.DoWndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_MOUSEACTIVATE:
      Message.Result := MA_NOACTIVATE

    else
      FormWndProc(Message);
  end;
end;


initialization

finalization
  FreeAndNil(IntController);

end.
