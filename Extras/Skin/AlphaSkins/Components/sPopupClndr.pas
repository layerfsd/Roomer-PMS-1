unit sPopupClndr;
{$I sDefs.inc}
//{$DEFINE LOGGED}
//+
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  {$IFDEF DELPHI6UP}Variants, {$ENDIF}
  sMonthCalendar, sConst, sPanel, acntUtils, sCustomComboEdit, ExtCtrls;


const
  FormHeight = 144;


type
  TsPopupCalendar = class(TForm)
    sMonthCalendar1: TsMonthCalendar;
    PopupMenu1: TPopupMenu;
    N1, N2, OK1, Cancel1: TMenuItem;
    procedure sToolButton3Click(Sender: TObject);
    procedure sToolButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CalendarClick;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  protected
    FCloseUp: TNotifyEvent;
    procedure KeyPress(var Key: Char); override;
    function GetValue: Variant;
    procedure SetValue(const Value: Variant);
  public
    FEditor: TsCustomComboEdit;
    function IsValidDate(ADate: TDateTime): boolean;
    procedure CloseUp;
    procedure WndProc(var Message: TMessage); override;
    property FCalendar: TsMonthCalendar read sMonthCalendar1 write sMonthCalendar1;
    property OnCloseUp: TNotifyEvent read FCloseUp write FCloseUp;
  end;


implementation

{$R *.dfm}

uses
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sToolEdit, sSkinManager, sGraphUtils;


function TsPopupCalendar.GetValue: Variant;
begin
  if csDesigning in ComponentState then
    Result := VarFromDateTime(SysUtils.Date)
  else
    Result := VarFromDateTime(FCalendar.CalendarDate);
end;


procedure TsPopupCalendar.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (FCalendar <> nil) and (Key <> #0) then
    FCalendar.FGrid.KeyPress(Key);
end;


procedure TsPopupCalendar.SetValue(const Value: Variant);
begin
  if not (csDesigning in ComponentState) then
    try
      if (Trim(ReplaceStr(VarToStr(Value), {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DateSeparator, '')) = '') or VarIsNull(Value) or VarIsEmpty(Value) then
        FCalendar.CalendarDate := VarToDateTime(SysUtils.Date)
      else
        FCalendar.CalendarDate := VarToDateTime(Value);
    except
      FCalendar.CalendarDate := VarToDateTime(SysUtils.Date);
    end;
end;


procedure TsPopupCalendar.sToolButton3Click(Sender: TObject);
begin
  Application.Minimize;
end;


procedure TsPopupCalendar.sToolButton1Click(Sender: TObject);
begin
  Close;
end;


procedure TsPopupCalendar.CloseUp;
begin
  if Assigned(FCloseUp) then
    FCloseUp(FEditor);
end;


procedure TsPopupCalendar.FormShow(Sender: TObject);
begin
  sMonthCalendar1.FDragBar.Cursor := crDefault;
  if (DefaultManager <> nil) and DefaultManager.Active then
    Color := DefaultManager.GetGlobalColor
  else
    Color := clBtnFace;

  if Assigned(FEditor) then
    sMonthCalendar1.ShowCurrentDate := TsDateEdit(FEditor).ShowCurrentDate;
end;


procedure TsPopupCalendar.CalendarClick;
var
  CanAccept: boolean;
  d: TDateTime;
begin
  CanAccept := True;
  if FEditor <> nil then begin
    d := sMonthCalendar1.CalendarDate;
    if not IsValidDate(d) then
      Exit;

    if Assigned(TsDateEdit(FEditor).OnAcceptDate) then
      TsDateEdit(FEditor).OnAcceptDate(FEditor, d, CanAccept);

    if CanAccept then begin
      TsCustomDateEdit(FEditor).Date := d;
      if Assigned(TsCustomDateEdit(FEditor).OnChange) then
        TsCustomDateEdit(FEditor).OnChange(TsCustomDateEdit(FEditor));

      Close;
      if sPopupCalendar = Self then
        sPopupCalendar := nil;

      if Assigned(FEditor) and FEditor.Visible and FEditor.Enabled then begin
        if FEditor.CanFocus and IsWindowVisible(FEditor.Handle) then
          FEditor.SetFocus;

        CloseUp;
        if FEditor.Focused and FEditor.AutoSelect then
          FEditor.SelectAll;

        Exit; // Closed already
      end;
    end;
  end;
  if CanAccept then
    Close;
end;


procedure TsPopupCalendar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  sMonthCalendar1.FGrid.Clicked := False;
  if sPopupCalendar = Self then
    sPopupCalendar := nil;

  inherited;
end;


type
  TAccessCalendar = class(TsMonthCalendar);

procedure TsPopupCalendar.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  with TAccessCalendar(sMonthCalendar1) do
    CanClose := (PopMenu = nil) or (PopMenu.PopupComponent = nil);
end;


procedure TsPopupCalendar.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_ERASEBKGND:
      if Assigned(DefaultManager) and DefaultManager.Active then
        Exit;
  end;
  inherited;
end;


function TsPopupCalendar.IsValidDate(ADate: TDateTime): boolean;
begin
  with TsCustomDateEdit(FEditor) do
    if (MinDate <> 0) and (ADate < MinDate) then
      Result := False
    else
      if (MaxDate <> 0) and (ADate > MaxDate) then
        Result := False
      else
        Result := True;
end;

end.
