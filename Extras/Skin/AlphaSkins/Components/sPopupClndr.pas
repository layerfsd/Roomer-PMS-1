unit sPopupClndr;
{$I sDefs.inc}
//{$DEFINE LOGGED}

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
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
    FCloseUp: TNotifyEvent;
    procedure KeyPress(var Key: Char); override;
    function GetValue: Variant;
    procedure SetValue(const Value: Variant);
    procedure FillArOR;
    function GetRgnFromArOR: hrgn;
  public
    FEditor: TsCustomComboEdit;
    function IsValidDate(Date: TDateTime): boolean;
    procedure CloseUp;
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc (var Message: TMessage); override;
    property FCalendar: TsMonthCalendar read sMonthCalendar1 write sMonthCalendar1;
    property OnCloseUp: TNotifyEvent read FCloseUp write FCloseUp;
  end;


implementation

{$R *.dfm}

uses
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sToolEdit, sSkinManager, sGraphUtils;


var
  ArOR: sConst.TAOR;


function TsPopupCalendar.GetValue: Variant;
begin
  if (csDesigning in ComponentState) then
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
var
  rgn: hrgn;
begin
  sMonthCalendar1.FDragBar.Cursor := crDefault;
  if (FEditor.SkinData.SkinManager <> nil) and FEditor.SkinData.SkinManager.Active then begin
    FillArOR;
    rgn := GetRgnFromArOR;
    SetWindowRgn(Handle, rgn, True);
  end;

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

      Visible := False;
      if sPopupCalendar = Self then
        sPopupCalendar := nil;

      if Assigned(FEditor) and FEditor.Visible and FEditor.Enabled then begin
        if FEditor.CanFocus then
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


procedure TsPopupCalendar.FormDeactivate(Sender: TObject);
begin
  Close;
end;


procedure TsPopupCalendar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  sMonthCalendar1.FGrid.Clicked := False;
  if sPopupCalendar = Self then
    sPopupCalendar := nil;

  Inherited;
end;


procedure TsPopupCalendar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPSIBLINGS or WS_POPUP;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;
end;


procedure TsPopupCalendar.CreateWnd;
begin
  inherited;
  SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) or $20000);
end;


procedure TsPopupCalendar.FillArOR;
begin
  SetLength(ArOR, 0);
  if FEditor.SkinData.SkinManager.IsValidImgIndex(sMonthCalendar1.SkinData.BorderIndex) then begin
    AddRgn(ArOR, Width, FEditor.SkinData.SkinManager.ma[sMonthCalendar1.SkinData.BorderIndex], 0, False);
    AddRgn(ArOR, Width, FEditor.SkinData.SkinManager.ma[sMonthCalendar1.SkinData.BorderIndex], Height - FEditor.SkinData.SkinManager.ma[sMonthCalendar1.SkinData.BorderIndex].WB, True);
  end;
end;


function TsPopupCalendar.GetRgnFromArOR: hrgn;
var
  l, i: integer;
  subrgn: HRGN;
begin
  l := Length(ArOR);
  Result := CreateRectRgn(0, 0, Width, Height);
  if l > 0 then
    for i := 0 to l - 1 do begin
      subrgn := CreateRectRgn(ArOR[i].Left, ArOR[i].Top, ArOR[i].Right, ArOR[i].Bottom);
      CombineRgn(Result, Result, subrgn, RGN_DIFF);
      DeleteObject(subrgn);
    end;
end;


procedure TsPopupCalendar.WndProc(var Message: TMessage);
var
  rgn: hrgn;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    WM_ERASEBKGND:
      if Assigned(DefaultManager) and DefaultManager.Active then
        Exit;

    WM_NCPAINT:
      if (FEditor <> nil) and
           (TsCustomDateEdit(FEditor).SkinData.SkinManager <> nil) and
              TsCustomDateEdit(FEditor).SkinData.SkinManager.Active then begin
        FillArOR;
        rgn := GetRgnFromArOR;
        SetWindowRgn(Handle, rgn, False);
      end;
  end;
  inherited;
end;


function TsPopupCalendar.IsValidDate(Date: TDateTime): boolean;
begin
  Result := True;
  if (TsCustomDateEdit(FEditor).MinDate <> 0) and (Date < TsCustomDateEdit(FEditor).MinDate) then
    Result := False;

  if (TsCustomDateEdit(FEditor).MaxDate <> 0) and (Date > TsCustomDateEdit(FEditor).MaxDate) then
    Result := False;
end;


procedure TsPopupCalendar.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

end.
