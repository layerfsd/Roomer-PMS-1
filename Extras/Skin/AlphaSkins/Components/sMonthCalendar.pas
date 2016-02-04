unit sMonthCalendar;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses Windows, Classes, Controls, SysUtils, Graphics, buttons, grids, messages, StdCtrls, forms, comctrls, Menus,
  {$IFNDEF DELPHI5} types, {$ENDIF}
  {$IFDEF DELPHI_XE2} UItypes, {$ENDIF}
  acntUtils, sPanel, sGraphUtils, sConst, sMessages, sDateUtils, sSpeedButton, sDefaults;


type
{$IFNDEF NOTFORHELP}
  TGetCellParams = procedure(Sender: TObject; Date: TDatetime; AFont: TFont; var Background: TColor) of object;
  TsMonthCalendar = class;


  TsCalendGrid = class(TDrawGrid)
  private
    FOwner: TsMonthCalendar;
    procedure WMSize         (var Message: TWMSize ); message WM_SIZE;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    Clicked: boolean;
    procedure Click; override;
    procedure KeyPress(var Key: Char); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure Paint; override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    constructor Create(AOwner: TComponent); override;
    procedure MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
    property GridLineWidth;
    property DefaultColWidth;
    property DefaultRowHeight;
  end;
{$ENDIF} // NOTFORHELP


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsMonthCalendar = class(TsPanel)
{$IFNDEF NOTFORHELP}
  private
    FReadOnly,
    FUpdating,
    FShowTitle,
    FShowWeeks,
    FShowTodayBtn,
    FShowYearBtns,
    FShowMonthBtns,
    FUseCurrentDate,
    FShowSelectAlways,
    FShowCurrentDate: boolean;

    FDate,
    FMinDate,
    FMaxDate: TDateTime;

    FOnDrawDay,
    FOnGetCellParams: TGetCellParams;

    FWeekendColor: TColor;
    FWeekends:     TDaysOfWeek;
    FOnChange:     TNotifyEvent;
    FStartOfWeek:  TCalDayOfWeek;
    FAnimated: boolean;
    function GetCellText   (ACol, ARow: Integer): string;
    function GetDayNum     (ACol, ARow: Integer): integer;
    function GetCellDate   (ACol, ARow: Integer): TDateTime;
    function GetDateElement(Index: Integer): Integer;

    function IsWeekend(ACol, ARow: Integer): Boolean;
    procedure CalendarUpdate(DayOnly: Boolean);
    function StoreCalendarDate: Boolean;
    function FirstDay: integer;
    procedure TopPanelDblClick(Sender: TObject);
    procedure DoChangeAnimated(ForwDirection: boolean; OldBmp: TBitmap);

    procedure SetWeekendColor  (Value: TColor);
    procedure SetUseCurrentDate(Value: Boolean);
    procedure SetCalendarDate  (Value: TDateTime);
    procedure SetWeekends      (Value: TDaysOfWeek);
    procedure SetStartOfWeek   (Value: TCalDayOfWeek);
    procedure SetDateElement   (Index: Integer; Value: Integer);

    procedure SetShowTitle       (const Value: boolean);
    procedure SetShowCurrentDate (const Value: boolean);
    procedure SetShowWeeks       (const Value: boolean);
    procedure SetShowTodayBtn    (const Value: boolean);
    procedure SetShowSelectAlways(const Value: boolean);
    procedure SetShowMonthBtns   (const Value: boolean);
    procedure SetShowYearBtns    (const Value: boolean);
    procedure SetMaxDate         (const Value: TDateTime);
    procedure SetMinDate         (const Value: TDateTime);
  protected
    PopMenu: TPopupMenu;
    FMonthOffset:  Integer;
    procedure PrevMonthBtnClick(Sender: TObject);
    procedure NextMonthBtnClick(Sender: TObject);
    procedure PrevYearBtnClick (Sender: TObject);
    procedure NextYearBtnClick (Sender: TObject);
    procedure MenuClick        (Sender: TObject);
    procedure TodayClick       (Sender: TObject);
    procedure TitleClick       (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MakePopup;
    procedure UpdateProps;
    procedure UpdateNavBtns;
    procedure Change;
    function DaysThisMonth: Integer;
    function ThisDayNum(ACol, ARow: integer): integer;
    procedure ChangeMonth(Delta: Integer; AllowAnimation: boolean = False);
    procedure ChangeYear(Delta: Integer; AllowAnimation: boolean = False);
  public
    FGrid: TsCalendGrid;
    FDragBar: TsDragBar;
    FTodayBtn: TsSpeedButton;
    FBtns: array [0..3] of TsTimerSpeedButton;
    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    function IsValidDate(Date: TDateTime): boolean;
    procedure NextMonth;
    procedure NextYear;
    procedure PrevMonth;
    procedure PrevYear;
    procedure UpdateCalendar;
    property CellText[ACol, ARow: Integer]: string read GetCellText;
    procedure WndProc(var Message: TMessage); override;
    property OnDrawDay: TGetCellParams read FOnDrawDay write FOnDrawDay;
    property MaxDate: TDateTime read FMaxDate write SetMaxDate;
    property MinDate: TDateTime read FMinDate write SetMinDate;
{$ENDIF} // NOTFORHELP
  published
{$IFNDEF NOTFORHELP}
    property Align;
    property BorderWidth default 0;
    property BevelWidth  default 5;
    property Width  default 178;
    property Height default 139;
{$ENDIF} // NOTFORHELP
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnGetCellParams: TGetCellParams read FOnGetCellParams write FOnGetCellParams;
    property Animated: boolean read FAnimated write FAnimated default True;
    property CalendarDate: TDateTime read FDate write SetCalendarDate stored StoreCalendarDate;
    property Day: Integer index 3 read GetDateElement write SetDateElement stored False;
    property Month: Integer index 2 read GetDateElement write SetDateElement stored False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property StartOfWeek: TCalDayOfWeek read FStartOfWeek write SetStartOfWeek default dowLocaleDefault;
    property ShowCurrentDate: boolean read FShowCurrentDate write SetShowCurrentDate default True;
    property ShowSelectAlways: boolean read FShowSelectAlways write SetShowSelectAlways default True;
    property ShowTitle: boolean read FShowTitle write SetShowTitle default True;
    property ShowTodayBtn: boolean read FShowTodayBtn write SetShowTodayBtn default False;
    property ShowWeeks: boolean read FShowWeeks write SetShowWeeks default False;
    property ShowYearBtns: boolean read FShowYearBtns write SetShowYearBtns default True;
    property ShowMonthBtns: boolean read FShowMonthBtns write SetShowMonthBtns default True;
    property UseCurrentDate: Boolean read FUseCurrentDate write SetUseCurrentDate default True;
    property WeekendColor: TColor read FWeekendColor write SetWeekendColor default clRed;
    property Weekends: TDaysOfWeek read FWeekends write SetWeekends default DefWeekends;
    property Year: Integer index 1  read GetDateElement write SetDateElement stored False;
  end;


var
  s_WeeksTitle: acString = '¹/w';
  s_Today: acString;

implementation

uses
  ExtCtrls,
  {$IFDEF DELPHI6UP} DateUtils, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sSkinProps, sSkinManager, sPopupClndr, sVclUtils, sToolEdit;


function WeekNum(const TDT: TDateTime): Word;
var
  Y, M, D: Word;
  dtTmp: TDateTime;
  A: array [0..1] of char;
begin
  DecodeDate(TDT, Y, M, D);
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTWEEKOFYEAR, A, SizeOf(A));
{$IFDEF DELPHI6UP}
  if Ord(A[0]) - Ord(ZeroChar) = 0 then begin
{$ENDIF}
    dtTmp := EnCodeDate(Y, 1, 1);
    Result := (Trunc(TDT - dtTmp) + (DayOfWeek(dtTmp) - 1)) div 7 + 1;
{$IFDEF DELPHI6UP}
  end
  else
    DecodeDateWeek(TDT, Y, Result, D);
{$ENDIF}
  if Result <> 0 then
    Result := Result - 1;
end;


constructor TsMonthCalendar.Create(AOwner: TComponent);
var
  i: integer;
  sp: TsPanel;
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsMonthCalendar;
  SkinData.Updating := False;

  FShowTitle := True;
  FShowTodayBtn := False;
  FShowSelectAlways := True;
  PopMenu := nil;

  FDragBar := TsDragBar.Create(Self);
  FDragBar.SkinData.SkinSection := s_DragBar;
  FDragBar.Color := clActiveCaption;
  FDragBar.OnDblClick := TopPanelDblClick;
  FDragBar.SkinData.Updating := False;
  FDragBar.OnMouseDown := TitleClick;

  FDragBar.Align := alTop;
  FDragBar.Top := -1;
  FAnimated := True;

  sp := TsPanel.Create(Self);
  with sp do begin
    Align := alTop;
    Height := 3;
    sp.Skindata.SkinSection := s_CheckBox;
    Caption := '';
    BevelOuter := bvNone;
    Parent := Self;
  end;

  FGrid := TsCalendGrid.Create(Self);
  FGrid.Parent := Self;
  FGrid.ParentColor := True;
  FGrid.OnDblClick := OnDblClick;
  FGrid.OnClick := OnClick;
  BorderWidth := 3;
  BevelWidth := 1;
  Caption := s_Space;
  FShowCurrentDate := True;

  FShowYearBtns := True;
  FShowMonthBtns := True;

  FUseCurrentDate := True;
  FStartOfWeek := dowLocaleDefault;
  FWeekends := DefWeekends;
  FWeekendColor := clRed;
  FDate := Date;
  Width  := 178;
  Height := 139;

  for i := 0 to 3 do begin
    FBtns[i] := TsTimerSpeedButton.Create(Self);
    FBtns[i].Parent := FDragBar;
    FBtns[i].Flat := True;
    FBtns[i].SkinData.SkinSection := s_ToolButton;
    FBtns[i].Font.Name := 'Webdings';
    FBtns[i].Font.Size := 10;
  end;
  FBtns[0].Align := alLeft;
  FBtns[0].Caption := '7';
  FBtns[0].OnClick := PrevYearBtnClick;
  FBtns[1].Align := alLeft;
  FBtns[1].Caption := '3';
  FBtns[1].OnClick := PrevMonthBtnClick;
  FBtns[2].Align := alRight;
  FBtns[2].Caption := '4';
  FBtns[2].OnClick := NextMonthBtnClick;
  FBtns[3].Align := alRight;
  FBtns[3].Caption := '8';
  FBtns[3].OnClick := NextYearBtnClick;

  FDragBar.Parent := Self;

  FTodayBtn := TsSpeedButton.Create(Self);
  FTodayBtn.Visible := False;
  FTodayBtn.Align := alBottom;
  FTodayBtn.Height := 18;
  FTodayBtn.Flat := True;
  FTodayBtn.SkinData.SkinSection := s_ToolButton;
  FTodayBtn.Caption := s_Today + FormatDateTime(' mmmm d, yyyy', Date);
  FTodayBtn.Font.Style := [fsBold];
  FTodayBtn.OnClick := TodayClick;
  FTodayBtn.Parent := Self;
end;


procedure TsMonthCalendar.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;


function TsMonthCalendar.DaysThisMonth: Integer;
begin
  Result := DaysPerMonth(Year, Month);
end;


function TsMonthCalendar.GetCellDate(ACol, ARow: Integer): TDateTime;
var
  DayNum, Y, M: integer;
begin
  DayNum := ThisDayNum(ACol, ARow);
  Y := Year;
  M := Month;
  if (DayNum < 1) then begin
    if M = 1 then begin // Get previous month
      dec(Y);
      M := 12;
    end
    else
      dec(M);

    Result := EncodeDate(Y, M, DaysPerMonth(Y, M) + DayNum);
  end
  else
    if (DayNum > DaysThisMonth) then begin
      inc(M);
      if M > 12 then begin
        inc(Y);
        M := 1;
      end;
      Result := EncodeDate(Y, M, DayNum - DaysThisMonth);
    end
    else
      Result := EncodeDate(Y, M, DayNum);
end;


function TsMonthCalendar.GetCellText(ACol, ARow: Integer): string;
var
  DayNum: Integer;
  Y, M: Word;
begin
  if ARow = 0 then
    if ShowWeeks and (ACol = 0) then
      Result := s_WeeksTitle
    else
      Result := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ShortDayNames[(FirstDay + ACol - Integer(ShowWeeks) + 1) mod 7 + 1]
  else
    if ShowWeeks and (ACol = 0) then begin
      if ARow <= FGrid.RowCount - 1 then begin
        Y := Year;
        M := Month;
        if ARow = 1 then
          DayNum := FMonthOffset + 7 - Integer(ShowWeeks)
        else
          DayNum := FMonthOffset + 1 - Integer(ShowWeeks) + (ARow - 1) * 7 + 1;

        if FirstDay = 0 then
          dec(DayNum); // If Monday - first

        if DayNum <= 0 then begin
          if M = 1 then begin // Previous year
            M := 12;
            dec(Y);
          end
          else
            dec(M);

          DayNum := DaysPerMonth(Y, M);
        end
        else
          if DayNum > DaysThisMonth then begin
            DayNum := DayNum - DaysThisMonth;
            inc(M);
            if M > 12 then begin
              inc(Y);
              M := 1;
            end;
          end;

        Result := IntToStr(WeekNum(EncodeDate(Y, M, DayNum)) + 1);
      end;
    end
    else
      Result := IntToStr(GetDayNum(ACol, ARow));
end;


procedure TsMonthCalendar.SetCalendarDate(Value: TDateTime);
{$IFDEF DELPHI7UP}
var
  Y, M, D: Word;
{$ENDIF}
begin
  if (FDate <> Value) and IsValidDate(Value) then begin
{$IFDEF DELPHI7UP}
    DecodeDate(Value, Y, M, D);
    if not TryEncodeDate(Y, M, D, FDate) then
      Exit;
{$ENDIF}
    FDate := Value;
    UpdateCalendar;
    Change;
  end;
end;


function TsMonthCalendar.StoreCalendarDate: Boolean;
begin
  Result := not FUseCurrentDate;
end;


function TsMonthCalendar.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    1:   Result := AYear;
    2:   Result := AMonth;
    3:   Result := ADay;
    else Result := -1;
  end;
end;


function TsMonthCalendar.GetDayNum(ACol, ARow: Integer): integer;
var
  DayNum, Y, M: integer;
begin
  DayNum := ThisDayNum(ACol, ARow);
  if (DayNum < 1) then begin
    Y := Year;
    M := Month;
    if ARow <= 2 then begin
      if M = 1 then begin // Get previous month
        dec(Y);
        M := 12;
      end
      else
        dec(M);

      Result := DaysPerMonth(Y, M) + DayNum;
    end
    else begin
      if M = 12 then begin // Get previous month
        inc(Y);
        M := 1;
      end
      else
        inc(M);

      Result := DaysPerMonth(Y, M) + DayNum;
    end;
  end
  else
    if (DayNum > DaysThisMonth) then
      Result := DayNum - DaysThisMonth
    else
      Result := DayNum;
end;


procedure TsMonthCalendar.SetDateElement(Index: Integer; Value: Integer);
var
  AYear, AMonth, ADay: Word;
begin
  if Value > 0 then begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      1:
        if AYear <> Value then
          AYear := Value
        else
          Exit;

      2:
        if (Value <= 12) and (Value <> AMonth) then begin
          AMonth := Value;
          if ADay > DaysPerMonth(Year, Value) then
            ADay := DaysPerMonth(Year, Value);
        end
        else
          Exit;

      3:
        if (Value <= DaysThisMonth) and (Value <> ADay) then
          ADay := Value
        else
          Exit

      else
        Exit;
    end;
{$IFDEF DELPHI7UP}
    if not TryEncodeDate(AYear, AMonth, ADay, FDate) then
      Exit;
{$ELSE}
    FDate := EncodeDate(AYear, AMonth, ADay);
{$ENDIF}
    FUseCurrentDate := False;
    CalendarUpdate(Index = 3);
    Change;
  end;
end;


procedure TsMonthCalendar.SetWeekendColor(Value: TColor);
begin
  if Value <> FWeekendColor then begin
    FWeekendColor := Value;
    SkinData.Invalidate;
  end;
end;


procedure TsMonthCalendar.SetWeekends(Value: sConst.TDaysOfWeek);
begin
  if Value <> FWeekends then begin
    FWeekends := Value;
    UpdateCalendar;
  end;
end;


function TsMonthCalendar.IsWeekend(ACol, ARow: Integer): Boolean;
begin
  Result := TCalDayOfWeek((FirstDay + ACol - Integer(ShowWeeks)) mod 7) in FWeekends;
end;


procedure TsMonthCalendar.SetStartOfWeek(Value: TCalDayOfWeek);
begin
  if Value <> FStartOfWeek then begin
    FStartOfWeek := Value;
    UpdateCalendar;
  end;
end;


procedure TsMonthCalendar.SetUseCurrentDate(Value: Boolean);
begin
  if Value <> FUseCurrentDate then begin
    FUseCurrentDate := Value;
    if Value then begin
      FDate := Date;
      UpdateCalendar;
    end;
  end;
end;


procedure TsMonthCalendar.ChangeMonth(Delta: Integer; AllowAnimation: boolean = False);
var
  AYear, AMonth, ADay: Word;
  NewDate: TDateTime;
  CurDay: Integer;
{$IFDEF DELPHI6UP}
  OldBmp: TBitmap;
{$ENDIF}
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  CurDay := ADay;
  if Delta > 0 then
    ADay := DaysPerMonth(AYear, AMonth)
  else
    ADay := 1;

  NewDate := EncodeDate(AYear, AMonth, ADay);
  NewDate := NewDate + Delta;
  DecodeDate(NewDate, AYear, AMonth, ADay);

  if DaysPerMonth(AYear, AMonth) > CurDay then
    ADay := CurDay
  else
    ADay := DaysPerMonth(AYear, AMonth);
{$IFDEF DELPHI7UP}
  if TryEncodeDate(AYear, AMonth, ADay, NewDate) then
{$ENDIF}
  begin
{$IFDEF DELPHI6UP}
    if FAnimated and AllowAnimation and ((SkinData.SkinManager = nil) or SkinData.SkinManager.Effects.AllowAnimation) then begin
      OldBmp := CreateBmp32(FGrid);
      FGrid.PaintTo(OldBmp.Canvas, 0, 0);

      SendMessage(FGrid.Handle, WM_SETREDRAW, 0, 0);
      CalendarDate := EncodeDate(AYear, AMonth, ADay);
      SendMessage(FGrid.Handle, WM_SETREDRAW, 1, 0);

      DoChangeAnimated(Delta > 0, OldBmp);
    end
    else
{$ENDIF} // DELPHI6UP
      CalendarDate := EncodeDate(AYear, AMonth, ADay);
  end;
end;


procedure TsMonthCalendar.PrevMonth;
begin
  ChangeMonth(-1);
end;


procedure TsMonthCalendar.NextMonth;
begin
  ChangeMonth(1);
end;


procedure TsMonthCalendar.NextYear;
begin
  ChangeYear(1);
end;


procedure TsMonthCalendar.PrevYear;
begin
  ChangeYear(-1);
end;


procedure TsMonthCalendar.CalendarUpdate(DayOnly: Boolean);
var
  AYear, AMonth, ADay: Word;
  FirstDate: TDateTime;
  d1, d2: integer;
begin
  FUpdating := True;
  try
    DecodeDate(FDate, AYear, AMonth, ADay);
{$IFDEF DELPHI7UP}
    if not TryEncodeDate(AYear, AMonth, 1, FirstDate) then
      Exit;
{$ELSE}
    FirstDate := EncodeDate(AYear, AMonth, 1);
{$ENDIF}
    FMonthOffset := 2 - ((DayOfWeek(FirstDate) - (FirstDay + 1) + 7) mod 7);
    if FMonthOffset in [1, 2] then
      FMonthOffset := FMonthOffset - 7;

    d1 := (ADay - FMonthOffset) mod 7 + Integer(ShowWeeks);
    d2 := (ADay - FMonthOffset) div 7 + 1;
    FGrid.MoveColRow(d1, d2, False, False);

    if not DayOnly then begin
      FDragBar.Caption := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}LongMonthNames[AMonth] + s_Space + IntToStr(AYear);
      FGrid.Invalidate;
    end;
  finally
    FUpdating := False;
  end;
end;


procedure TsMonthCalendar.UpdateCalendar;
begin
  CalendarUpdate(False);
end;


function TsMonthCalendar.FirstDay: integer;
var
  A: array [0..1] of char;
begin
  if FStartOfWeek = dowLocaleDefault then begin
    GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, A, SizeOf(A));
    Result := Ord(A[0]) - Ord(ZeroChar);
  end
  else
    Result := Ord(FStartOfWeek);
end;


procedure TsMonthCalendar.PrevYearBtnClick(Sender: TObject);
begin
  ChangeYear(-1, True);
end;


procedure TsMonthCalendar.NextYearBtnClick(Sender: TObject);
begin
  ChangeYear(1, True);
end;


procedure TsMonthCalendar.PrevMonthBtnClick(Sender: TObject);
begin
  ChangeMonth(-1, True);
end;


procedure TsMonthCalendar.NextMonthBtnClick(Sender: TObject);
begin
  ChangeMonth(1, True);
end;


procedure TsMonthCalendar.TopPanelDblClick(Sender: TObject);
begin
  CalendarDate := Date;
end;


procedure TsMonthCalendar.WndProc(var Message: TMessage);
var
  i: integer;
  Size: TSize;
begin
  inherited;
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN, AC_REFRESH:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            if (PopMenu <> nil) and SkinData.SkinManager.SkinnedPopups then
              Skindata.SkinManager.SkinableMenus.HookPopupMenu(PopMenu, Message.WParamHi = AC_REFRESH);

            UpdateCalendar;
            FGrid.Repaint;
            if ShowTitle then
              SendMessage(FDragBar.Handle, Message.Msg, Message.WParam, Message.LParam);
          end;
      end;

    CM_FONTCHANGED: begin
      FTodayBtn.ParentFont := True;
      FTodayBtn.Font.Style := [fsBold];
      Size := GetStringSize(FTodayBtn.Font.Handle, 'W');
      FTodayBtn.Height := Size.cy + 4;
      FDragBar.ParentFont := True;
      FDragBar.Font.Color := clCaptionText;
      FDragBar.Font.Style := [fsBold];
      FDragBar.Height := Size.cy + 4;
      for i := 0 to 3 do
        FBtns[i].Width := Size.cx + 10;
    end;
  end;
end;


procedure TsMonthCalendar.SetShowTitle(const Value: boolean);
begin
  if FShowTitle <> Value then begin
    FShowTitle := Value;
    FDragBar.Visible := Value;
    if Value then
      FDragBar.Parent := Self
    else
      FDragBar.Parent := nil;
  end;
end;


procedure TsMonthCalendar.Loaded;
var
  i: integer;
begin
  inherited;
  if Assigned(FDragBar) and FDragBar.Visible then begin
    FDragBar.SkinData.FSkinManager := SkinData.FSkinManager;
    for i := 0 to 3 do
      FBtns[i].SkinData.FSkinManager := SkinData.FSkinManager;
  end;
end;


procedure TsMonthCalendar.SetShowCurrentDate(const Value: boolean);
begin
  if FShowCurrentDate <> Value then begin
    FShowCurrentDate := Value;
    Invalidate;
  end;
end;


procedure TsMonthCalendar.SetShowWeeks(const Value: boolean);
begin
  if FShowWeeks <> Value then begin
    FShowWeeks := Value;
    FGrid.DefaultColWidth := FGrid.Width div (7 + integer(ShowWeeks));
    UpdateProps;
    Invalidate;
  end;
end;


procedure TsMonthCalendar.CreateWnd;
begin
  inherited;
  if FShowtodayBtn then
    FTodayBtn.Visible := True;

  UpdateProps;
  UpdateNavBtns;
end;


procedure TsMonthCalendar.MakePopup;
var
  i: integer;
  miRoot: TMenuItem;

  procedure MakeMenusForYear(aYear: integer; Items: TMenuItem);
  var
    i, j: integer;
    mi, si: TMenuItem;
  begin
    for i := aYear to aYear + 9 do begin
      mi := TMenuItem.Create(Self);
      mi.Tag := i;
      mi.Caption := IntToStr(i);
      if Items = PopMenu.Items then
        mi.Caption := '  ' + mi.Caption;

      if i = Year then begin
        mi.Default := True;
        mi.Checked := True;
      end;
      for j := 1 to 12 do begin
        si := TMenuItem.Create(Self);
        si.Caption := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}LongMonthNames[j];
        if mi.Default and (j = Month) then begin
          si.Default := True;
          si.Checked := True;
        end;
        si.OnClick := MenuClick;
        mi.Add(si);
      end;
      Items.Add(mi);
    end;
  end;

begin
  if PopMenu = nil then begin
    if PopMenu <> nil then
      PopMenu.Free;

    PopMenu := TPopupMenu.Create(Self);
    i := (Year - 4) - 10 * 5;
    while i < (Year - 4) do begin
      miRoot := TMenuItem.Create(Self);
      miRoot.Caption := IntToStr(i) + '..' + IntToStr(i + 9);
      MakeMenusForYear(i, miRoot);
      PopMenu.Items.Add(miRoot);
      inc(i, 10);
    end;
    MakeMenusForYear(Year - 4, PopMenu.Items);
    i := Year + 6;
    while i < (Year - 4) + 50 do begin
      miRoot := TMenuItem.Create(Self);
      miRoot.Caption := IntToStr(i) + '..' + IntToStr(i + 9);
      MakeMenusForYear(i, miRoot);
      PopMenu.Items.Add(miRoot);
      inc(i, 10);
    end;
  end;
  if SkinData.Skinned and SkinData.SkinManager.SkinnedPopups then
    Skindata.SkinManager.SkinableMenus.HookPopupMenu(PopMenu, True);
end;


procedure TsMonthCalendar.MenuClick(Sender: TObject);
var
  mi: TMenuItem;
begin
  mi := TMenuItem(Sender);
  Year := mi.Parent.Tag;
  Month := mi.MenuIndex + 1;
end;


function TsMonthCalendar.ThisDayNum(ACol, ARow: integer): integer;
begin
  Result := FMonthOffset + ACol - Integer(ShowWeeks) + (ARow - 1) * 7;
end;

procedure TsMonthCalendar.TitleClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  MakePopup;
  P := acMousePos;
  PopMenu.PopupComponent := Self;
  PopMenu.Popup(P.X, P.Y);
end;


procedure TsMonthCalendar.TodayClick(Sender: TObject);
begin
  CalendarDate := Date;
  if Parent is TsPopupCalendar then
    TsPopupCalendar(Parent).CalendarClick;
end;


procedure TsMonthCalendar.SetShowTodayBtn(const Value: boolean);
begin
  if FShowTodayBtn <> Value then begin
    FShowTodayBtn := Value;
    if Value then
      FTodayBtn.Parent := Self
    else
      FTodayBtn.Parent := nil;

    CalendarUpdate(False);
  end;
end;


procedure TsMonthCalendar.UpdateProps;
begin
  if FShowTodayBtn then
    FTodayBtn.Parent := Self
  else
    FTodayBtn.Parent := nil;

  if FGrid <> nil then begin
    FGrid.ColCount := 7 + integer(ShowWeeks);
    FGrid.FixedCols := integer(ShowWeeks);
    UpdateCalendar;
  end;
end;


procedure TsMonthCalendar.SetShowSelectAlways(const Value: boolean);
begin
  if FShowSelectAlways <> Value then begin
    FShowSelectAlways := Value;
    CalendarUpdate(False);
  end;
end;


procedure TsMonthCalendar.SetShowMonthBtns(const Value: boolean);
begin
  if FShowMonthBtns <> Value then begin
    FShowMonthBtns := Value;
    UpdateNavBtns;
  end;
end;


procedure TsMonthCalendar.SetShowYearBtns(const Value: boolean);
begin
  if FShowYearBtns <> Value then begin
    FShowYearBtns := Value;
    UpdateNavBtns;
  end;
end;


procedure TsMonthCalendar.UpdateNavBtns;
begin
  FBtns[0].Visible := ShowYearBtns;
  FBtns[1].Visible := ShowMonthBtns;
  FBtns[2].Visible := ShowMonthBtns;
  FBtns[3].Visible := ShowYearBtns;
end;


procedure TsMonthCalendar.SetMaxDate(const Value: TDateTime);
begin
  if FMaxDate <> Value then begin
    FMaxDate := Value;
    if Value <> 0 then
      if not (csLoading in ComponentState) and (CalendarDate > Value) then
        CalendarDate := Value;

    UpdateCalendar;
  end;
end;


procedure TsMonthCalendar.SetMinDate(const Value: TDateTime);
begin
  if FMinDate <> Value then begin
    FMinDate := Value;
    if Value <> 0 then
      if not (csLoading in ComponentState) and (CalendarDate < Value) then
        CalendarDate := Value;

    UpdateCalendar;
  end;
end;


function TsMonthCalendar.IsValidDate(Date: TDateTime): boolean;
begin
  Result := True;
  if (MinDate <> 0) and (Date < MinDate) then
    Result := False;

  if (MaxDate <> 0) and (Date > MaxDate) then
    Result := False;
end;


procedure TsCalendGrid.Click;
var
  DayNum: integer;
  TheCellText: string;
begin
  if not FOwner.FUpdating then begin
    inherited Click;
    if not FOwner.ShowWeeks or (Col > 0) then begin
      TheCellText := FOwner.CellText[Col, Row];
      if TheCellText <> '' then begin
        DayNum := FOwner.ThisDayNum(Col, Row);
        if DayNum < 1 then
          FOwner.PrevMonth
        else
          if DayNum > FOwner.DaysThisMonth then
            FOwner.NextMonth;

        FOwner.Day := StrToInt(TheCellText);
      end;
    end;
    if Assigned(FOwner.OnClick) then
      FOwner.OnClick(FOwner);
  end;
end;


constructor TsCalendGrid.Create(AOwner: TComponent);
begin
  inherited;
  FOwner := TsMonthCalendar(AOwner);
  Ctl3D := False;
  BorderStyle := bsNone;
  FixedCols := 0;
  FixedRows := 1;
  ColCount := 7;
  RowCount := 8;
  ScrollBars := ssNone;
  Options := [];
  Align := alClient;
  Tag := ExceptTag;
end;


procedure TsCalendGrid.CreateWnd;
begin
  inherited;
  DefaultDrawing := False;
  Clicked := False;
end;


procedure TsCalendGrid.DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState);
var
  R: TRect;
  c: TColor;
  d: TDateTime;
  TheText: string;
  BGInfo: TacBGInfo;
  RealNum, DayNum: integer;

  function IsToday: boolean;
  begin
    if (ARow > 2) and (RealNum < 10) or (ARow < 3) and (RealNum > 20) or FOwner.ShowWeeks and (ACol < 1) then
      Result := False
    else
      Result := (ARow <> 0) and (TheText <> '') and (EncodeDate(FOwner.Year, FOwner.Month, StrToInt(TheText)) = Date)
  end;

begin
  if ARow < RowCount - 1 then begin
    TheText := FOwner.CellText[ACol, ARow];
    RealNum := FOwner.GetDayNum(ACol, ARow);
    R := ARect;
    if ACol = 6 + Integer(FOwner.ShowWeeks) then
      R.Right := Width;

    if ARow = 6 then
      R.Bottom := Height;

    BGInfo.PleaseDraw := False;
    BGInfo.Offset := MkPoint;
    GetBGInfo(@BGInfo, FOwner);
    if (BGInfo.BgType = btCache) and not BGInfo.Bmp.Empty then
      BitBlt(Canvas.Handle, R.Left, R.Top, WidthOf(R), HeightOf(R), BGInfo.Bmp.Canvas.Handle, Left + R.Left + BGInfo.Offset.X, Top + R.Top + BGInfo.Offset.Y, SRCCOPY)
    else
      FillDC(Canvas.Handle, R, BGInfo.Color);

    R := ARect;
    Canvas.Font.Assign(Font);
    Canvas.Brush.Color := Color;
    if not FOwner.ShowSelectAlways and (gdSelected in AState) and not Focused then
      AState := AState - [gdSelected];

    if FOwner.ShowCurrentDate and (gdSelected in AState) then begin
      Canvas.Font.Style := [fsBold];
      Canvas.Font.Color := clBlack;
    end
    else
      Canvas.Font.Style := [];

    Canvas.Brush.Style := bsClear;
    Canvas.Font.Style := [];
    if not (FOwner.ShowWeeks and (ACol = 0)) and FOwner.ShowCurrentDate and IsToday and (ACol <> 7 + Integer(FOwner.ShowWeeks)) then begin
      inc(R.Left);
      inc(R.Bottom);
      Canvas.Brush.Style := bsSolid;
      Canvas.Pen.Style := psClear;
      if FOwner.SkinData.Skinned then
        Canvas.Brush.Color := MixColors(FOwner.WeekendColor, FOwner.SkinData.SkinManager.GetGlobalColor, 0.3)
      else
        Canvas.Brush.Color := MixColors(FOwner.WeekendColor, ColortoRGB(clBtnFace), 0.3);

      Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 8, 8);
      Canvas.Font.Color := clWhite;
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Style := [fsBold];
    end
    else begin
      if FOwner.IsWeekend(ACol, ARow) then
        Canvas.Font.Color := FOwner.WeekendColor
      else
        with FOwner.SkinData do
          if FOwner.ShowWeeks and (ACol = 0) then begin
            if ARow = 0 then begin
              Canvas.Font.Name := 'Small Fonts';
              Canvas.Font.Size := 6;
            end
            else
              Canvas.Font.Style := [fsBold];

            if Skinned and Assigned(SkinManager) then
              Canvas.Font.Color := MixColors(SkinManager.GetGlobalFontColor, SkinManager.GetGlobalColor, 0.3)
            else
              Canvas.Font.Color := clGrayText;

            Canvas.Pen.Style := psSolid;
            Canvas.Pen.Color := Canvas.Font.Color;
            Canvas.MoveTo(ARect.Right - 1, ARect.Top);
            Canvas.LineTo(ARect.Right - 1, ARect.Bottom);
            dec(ARect.Right, 3)
          end
          else
            if Skinned and Assigned(SkinManager) and (SkinManager.GetGlobalFontColor <> clFuchsia) then
              with SkinManager do
                if SkinIndex >= 0 then
                  if (BorderIndex < 0) and (gd[SkinIndex].Props[0].Transparency = 100) then
                    Canvas.Font.Color := GetControlColor(Parent.Parent.Parent)
                  else
                    Canvas.Font.Color := gd[SkinIndex].Props[0].FontColor.Color
                else
                  Canvas.Font.Color := GetGlobalFontColor
            else
              Canvas.Font.Color := clWindowText;

      if ARow <> 0 then begin
        DayNum := FOwner.ThisDayNum(ACol, ARow);
        if (DayNum <= 0) or (DayNum > FOwner.DaysThisMonth) then
          if FOwner.SkinData.Skinned then
            Canvas.Font.Color := MixColors(Canvas.Font.Color, FOwner.SkinData.SkinManager.GetGlobalColor, 0.5)
          else
            Canvas.Font.Color := MixColors(ColorToRGB(Canvas.Font.Color), ColorToRGB(FOwner.Color), 0.5);
      end;
    end;
    if (gdSelected in AState) then begin
      if TheText = '' then
        Exit;

      Canvas.Font.Style := [fsBold];
      InflateRect(R, -2, -2);
      dec(R.Top, 1);
      inc(R.Left);
      if not IsToday then
        if FOwner.SkinData.Skinned then begin
          FillDC(Canvas.Handle, R, FOwner.SkinData.SkinManager.GetHighLightColor);
          Canvas.Font.Color := FOwner.SkinData.SkinManager.GetHighLightFontColor;
        end
        else begin
          FillDC(Canvas.Handle, R, clHighlight);
          Canvas.Font.Color := clHighlightText;
        end;

      Canvas.Brush.Color := Color;
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Style := psClear;
    end;
    if (ARow > 0) and (TheText <> '') and not (FOwner.ShowWeeks and (ACol = 0)) then begin
      d := FOwner.GetCellDate(ACol, ARow);
      if Assigned(FOwner.FOnDrawDay) or Assigned(FOwner.FOnGetCellParams) then begin
        c := clFuchsia;
        if Assigned(FOwner.FOnDrawDay) then
          FOwner.FOnDrawDay(TsPopupCalendar(FOwner.Parent).FEditor, d, Canvas.Font, c)
        else
          FOwner.FOnGetCellParams(Self, d, Canvas.Font, c);

        if c <> clFuchsia then begin
          Canvas.Brush.Color := c;
          Canvas.Brush.Style := bsSolid
        end;
      end;
      if not FOwner.IsValidDate(d) then
        Canvas.Font.Color := MixColors(ColorToRGB(Canvas.Font.Color), ColorToRGB(Canvas.Brush.Color), 0.3);
    end;
    Canvas.TextRect(ARect, ARect.Left + (ARect.Right - ARect.Left - Canvas.TextWidth(TheText)) div 2,
                    ARect.Top + (ARect.Bottom - ARect.Top - Canvas.TextHeight(TheText)) div 2, TheText);

    if (gdSelected in AState) and (Canvas.Brush.Style <> bsSolid) and Focused then begin
      InflateRect(R, 1, 1);
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Style := psClear;
      DrawFocusRect(Canvas.Handle, R);
    end;
  end;
end;


procedure TsCalendGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  d: TDateTime;
  CanAccept: boolean;
begin
  case Key of
    VK_UP, VK_DOWN: begin
      Shift := Shift - [ssCtrl];
      if VK_UP = Key then begin
        if FOwner.IsValidDate(FOwner.CalendarDate - 7) then
          FOwner.CalendarDate := FOwner.CalendarDate - 7;
      end
      else
        if FOwner.IsValidDate(FOwner.CalendarDate + 7) then
          FOwner.CalendarDate := FOwner.CalendarDate + 7;

      Exit;
    end;

    VK_LEFT, VK_SUBTRACT:
      if Shift = [] then begin
        if FOwner.IsValidDate(FOwner.CalendarDate - 1) then
          FOwner.CalendarDate := FOwner.CalendarDate - 1;

        Exit;
      end;

    VK_RIGHT, VK_ADD:
      if Shift = [] then begin
        if FOwner.IsValidDate(FOwner.CalendarDate + 1) then
          FOwner.CalendarDate := FOwner.CalendarDate + 1;

        Exit;
      end;

    VK_NEXT: begin
      if ssCtrl in Shift then
        FOwner.NextYear
      else
        FOwner.NextMonth;

      Exit;
    end;

    VK_PRIOR: begin
      if ssCtrl in Shift then
        FOwner.PrevYear
      else
        FOwner.PrevMonth;

      Exit;
    end;

    VK_RETURN:
      if FOwner.Parent is TsPopupCalendar then
        with TsPopupCalendar(FOwner.Parent) do begin
          if FEditor <> nil then begin
            d := sMonthCalendar1.CalendarDate;
            if not TsPopupCalendar(FOwner.Parent).IsValidDate(d) then
              Exit;

            CanAccept := True;
            if Assigned(TsDateEdit(FEditor).OnAcceptDate) then
              TsDateEdit(FEditor).OnAcceptDate(FEditor, d, CanAccept);

            if CanAccept then begin
              TsCustomDateEdit(FEditor).Date := d;
              if Assigned(TsCustomDateEdit(FEditor).OnChange) then
                TsCustomDateEdit(FEditor).OnChange(TsCustomDateEdit(FEditor));
            end;
            FEditor.SetFocus;
            if FEditor.AutoSelect then
              FEditor.SelectAll;
          end;
          Close;
          CloseUp;
        end;

    VK_ESCAPE:
      if FOwner.Parent is TsPopupCalendar then
        with TsPopupCalendar(FOwner.Parent) do begin
          if FEditor.Visible then
            FEditor.SetFocus;

          Close;
          CloseUp;
        end;
  end;
  inherited KeyDown(Key, Shift);
end;


procedure TsCalendGrid.KeyPress(var Key: Char);
begin
  if CharInSet(AnsiChar(Key), ['T', 't']) then begin
    FOwner.CalendarDate := Trunc(Now);
    Key := #0;
  end;
  inherited KeyPress(Key);
end;


procedure TsCalendGrid.Loaded;
begin
  inherited;
end;


procedure TsCalendGrid.MouseToCell(X, Y: Integer; var ACol, ARow: Integer);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;


procedure TsCalendGrid.Paint;
begin
  if not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
    inherited;
end;


function TsCalendGrid.SelectCell(ACol, ARow: Integer): Boolean;
begin
  if ((not FOwner.FUpdating) and FOwner.FReadOnly) or (FOwner.CellText[ACol, ARow] = '') then
    Result := False
  else
    Result := inherited SelectCell(ACol, ARow);
end;


procedure TsCalendGrid.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;


procedure TsCalendGrid.WMSize(var Message: TWMSize);
begin
  DefaultColWidth  := Message.Width  div (7 + integer(FOwner.ShowWeeks));
  DefaultRowHeight := Message.Height div 7;
end;

{$IFNDEF DELPHI6UP}
{$HINTS OFF}
type
  TAccessStdGrid = class(TCustomControl)
    private
      FAnchor:        TGridCoord;
      FBorderStyle:   TBorderStyle;
      FCanEditModify: Boolean;
      FColCount:      Longint;
      FColWidths,
      FTabStops:      Pointer;
      FCurrent:       TGridCoord;
  end;
{$ENDIF}


procedure TsCalendGrid.WndProc(var Message: TMessage);
var
  DC: HDC;
  R: TRect;
  BGInfo: TacBGInfo;
  SaveIndex, X, Y: integer;
begin
  case Message.Msg of
    WM_ERASEBKGND, CM_MOUSEENTER, CM_MOUSELEAVE, WM_MOUSEMOVE:
      ;

    WM_LBUTTONDBLCLK: begin
      inherited;
      if Assigned(FOwner.OnDblClick) and (csDoubleClicks in FOwner.ControlStyle) then
        if FOwner.Parent is TsPopupCalendar then begin
          if (TsPopupCalendar(FOwner.Parent).FEditor = nil) then
            FOwner.OnDblClick(FOwner)
        end
        else
          FOwner.OnDblClick(FOwner);
    end;

    WM_PAINT: begin
      inherited;
      // Filling the right line
      if TWMPAINT(Message).DC = 0 then
        DC := GetDC(Handle)
      else
        DC := TWMPAINT(Message).DC;

      SaveIndex := SaveDC(DC);
      try
        BGInfo.PleaseDraw := False;
        GetBGInfo(@BGInfo, FOwner);
        R := Rect((ColCount) * DefaultColWidth, 0, Width, Height);

        if BGInfo.BgType = btCache then
          BitBlt(DC, R.Left, R.Top, WidthOf(R), HeightOf(R), BGInfo.Bmp.Canvas.Handle, Left + R.Left + BGInfo.Offset.X, Top + R.Top + BGInfo.Offset.Y, SRCCOPY)
        else
          FillDC(DC, R, BGInfo.Color);
      finally
        RestoreDC(DC, SaveIndex);
        if TWMPAINT(Message).DC = 0 then
          ReleaseDC(Handle, DC);
      end;
    end;

    WM_LBUTTONDOWN:
//      if FOwner.Parent is TsPopupCalendar then begin
        if FOwner.Parent.Visible then
          if not Clicked then begin
            Clicked := True;
            MouseToCell(TWMMouse(Message).XPos, TWMMouse(Message).YPos, X, Y);
            if not FOwner.ShowWeeks or (X > 0) then
              if (Y > 0) and FOwner.IsValidDate(FOwner.GetCellDate(X, Y)) then begin // If not a day name
{$IFDEF DELPHI6UP}
                FocusCell(X, Y, False);
{$ELSE}
                TAccessStdGrid(Self).FCurrent.X := X;
                TAccessStdGrid(Self).FCurrent.Y := Y;
                Click;
{$ENDIF}
                Invalidate;
              end;

            Clicked := False;
          end;
{      end
      else
        inherited;}

    WM_LBUTTONUP: begin
      inherited;
      if (FOwner.Parent is TsPopupCalendar) then
        if FOwner.Parent.Visible and not Clicked then begin
          Clicked := True;
          TsPopupCalendar(FOwner.Parent).CalendarClick;
          Clicked := False;
        end;
    end;

    else
      inherited;
  end;
end;


procedure TsMonthCalendar.DoChangeAnimated(ForwDirection: boolean; OldBmp: TBitmap);
var
  Position: Integer;
  FPos: real;
  CacheBmp, NewBmp: TBitmap;
  lTicks: DWord;
  DC: hdc;
begin
  NewBmp := CreateBmp32(FGrid);
{$IFDEF DELPHI6UP}
  FGrid.PaintTo(NewBmp.Canvas, 0, 0);
{$ELSE}
  FGrid.PaintTo(NewBmp.Canvas.Handle, 0, 0);
{$ENDIF}
  CacheBmp := CreateBmp32(FGrid);
  FPos := 0;
  while Round(FPos) < FGrid.Width do begin
    lTicks := GetTickCount;
    FPos := FPos + (FGrid.Width - FPos) / 5;
    Position := Round(FPos);
    if ForwDirection then begin
      BitBlt(CacheBmp.Canvas.Handle, -Position, 0, CacheBmp.Width, CacheBmp.Height, OldBmp.Canvas.Handle, 0, 0, SRCCOPY);
      BitBlt(CacheBmp.Canvas.Handle, FGrid.Width - Position, 0, CacheBmp.Width, CacheBmp.Height, NewBmp.Canvas.Handle, 0, 0, SRCCOPY);
    end
    else begin
      BitBlt(CacheBmp.Canvas.Handle,  Position, 0, CacheBmp.Width, CacheBmp.Height, OldBmp.Canvas.Handle, 0, 0, SRCCOPY);
      BitBlt(CacheBmp.Canvas.Handle, -FGrid.Width + Position, 0, CacheBmp.Width, CacheBmp.Height, NewBmp.Canvas.Handle, 0, 0, SRCCOPY);
    end;
    DC := GetDC(FGrid.Handle);
    try
      BitBlt(DC, 0, 0, CacheBmp.Width, CacheBmp.Height, CacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      ReleaseDC(FGrid.Handle, DC);
    end;
    while lTicks + acTimerInterval > GetTickCount do
      ; // wait here
  end;
  OldBmp.Free;
  NewBmp.Free;
  CacheBmp.Free;
end;


procedure TsMonthCalendar.ChangeYear(Delta: Integer; AllowAnimation: boolean = False);
var
  OldBmp: TBitmap;
{$IFDEF DELPHI7UP}
  NewDate: TDateTime;
{$ENDIF}
begin
  if IsLeapYear(Year) and (Month = 2) and (Day = 29) then
    Day := 28;

{$IFDEF DELPHI7UP}
  if TryEncodeDate(Year + Delta, Month, Day, NewDate) then
{$ENDIF}
{$IFDEF DELPHI6UP}
    if FAnimated and AllowAnimation and ((SkinData.SkinManager = nil) or SkinData.SkinManager.Effects.AllowAnimation) then begin
      OldBmp := CreateBmp32(FGrid);
      FGrid.PaintTo(OldBmp.Canvas, 0, 0);

      SendMessage(FGrid.Handle, WM_SETREDRAW, 0, 0);
      Year := Year + Delta;
      SendMessage(FGrid.Handle, WM_SETREDRAW, 1, 0);

      DoChangeAnimated(Delta > 0, OldBmp);
    end
    else
{$ENDIF} // DELPHI6UP
      Year := Year + Delta;
end;


{$IFNDEF WIN64}
var
  Lib: HModule = 0;
  ResStringRec: TResStringRec;


initialization
  Lib := LoadLibrary(comctl32);
  if Lib <> 0 then begin
{$IFDEF DELPHI5}
    ResStringRec.Module := @Longint(Lib);
{$ELSE}
    ResStringRec.Module := @Lib;
{$ENDIF}
    // Search a localization of "Today:"
    ResStringRec.Identifier := {$IFDEF DELPHI_XE2} 4432 {$ELSE} 4163 {$ENDIF};
    s_Today := LoadResString(@ResStringRec);
    FreeLibrary(Lib);
    if s_Today = '' then
      s_Today := 'Today: ';
  end;

finalization
{$ENDIF} // WIN64

end.
