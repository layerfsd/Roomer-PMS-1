unit sToolEdit;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Classes, sConst, StdCtrls, Controls, Messages, SysUtils, Forms, Graphics, Buttons, Dialogs, Mask, FileCtrl, comctrls,
  {$IFDEF DELPHI6UP} Variants, {$ENDIF}
  sDialogs, sDateUtils, sCustomComboEdit, sPopupClndr, sMonthCalendar, acntUtils, sDefaults;


type
{$IFNDEF NOTFORHELP}
  TExecOpenDialogEvent = procedure(Sender: TObject; var Name: string; var Action: boolean) of object;
  TGetPopupFont = procedure(Sender: TObject; PopupFont: TFont) of object;
{$ENDIF}

  TsFileDirEdit = class(TsCustomComboEdit)
{$IFNDEF NOTFORHELP}
  private
    FOnBeforeDialog,
    FOnAfterDialog: TExecOpenDialogEvent;

    FAcceptFiles: boolean;
    FOnDropFiles: TNotifyEvent;
    procedure SetDragAccept (Value: boolean);
    procedure SetAcceptFiles(Value: boolean);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  protected
    FMultipleDirs: boolean;
    procedure CreateHandle; override;
    procedure DestroyWindowHandle; override;
    function GetLongName:  string; virtual; abstract;
    function GetShortName: string; virtual; abstract;
    procedure DoAfterDialog (var FileName: string; var Action: boolean);
    procedure DoBeforeDialog(var FileName: string; var Action: boolean);
    procedure ReceptFileDir(const AFileName: acString); virtual; abstract;
    procedure ClearFileList; virtual;
    property MaxLength default MaxByte;
  public
    constructor Create(AOwner: TComponent); override;
{$ENDIF} // NOTFORHELP
    property LongName:  string read GetLongName;
    property ShortName: string read GetShortName;
    property AcceptFiles: boolean read FAcceptFiles write SetAcceptFiles default False;
  published
    property OnBeforeDialog: TExecOpenDialogEvent read FOnBeforeDialog write FOnBeforeDialog;
    property OnAfterDialog:  TExecOpenDialogEvent read FOnAfterDialog  write FOnAfterDialog;
    property OnDropFiles: TNotifyEvent read FOnDropFiles write FOnDropFiles;
  end;


  TFileDialogKind = (dkOpen, dkSave, dkOpenPicture, dkSavePicture);

{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsFilenameEdit = class(TsFileDirEdit)
{$IFNDEF NOTFORHELP}
  private
    FDialog: TOpenDialog;
    FDialogKind: TFileDialogKind;
    procedure CreateEditDialog;
    function GetFileName:    string;
    function GetDefaultExt:  string;
    function GetFilter:      string;
    function GetInitialDir:  string;
    function GetDialogTitle: string;
    function GetFileEditStyle: TFileEditStyle;
    function GetOptions:       TOpenOptions;
    function GetDialogFiles:   TStrings;
    function GetHistoryList:   TStrings;
    function GetFilterIndex:   Integer;

    procedure SetFileName   (const Value: string);
    procedure SetDefaultExt (const Value: string);
    procedure SetFilter     (const Value: string);
    procedure SetInitialDir (const Value: string);
    procedure SetDialogTitle(const Value: string);
    procedure SetFileEditStyle(Value: TFileEditStyle);
    procedure SetDialogKind   (Value: TFileDialogKind);
    procedure SetOptions      (Value: TOpenOptions);
    procedure SetHistoryList  (Value: TStrings);
    procedure SetFilterIndex  (Value: Integer);

    function IsCustomTitle:  boolean;
    function IsCustomFilter: boolean;
  protected
    procedure ReceptFileDir(const AFileName: acString); override;
    procedure ButtonClick; override;
    procedure ClearFileList; override;
    function GetLongName:  string; override;
    function GetShortName: string; override;
    property FileEditStyle: TFileEditStyle read GetFileEditStyle write SetFileEditStyle default fsEdit;
  public
    constructor Create(AOwner: TComponent); override;
    property Dialog: TOpenDialog read FDialog;
{$ENDIF} // NOTFORHELP
    property DialogFiles: TStrings read GetDialogFiles;
    property DialogTitle: string read GetDialogTitle write SetDialogTitle stored IsCustomTitle;
  published
    property AcceptFiles;
{$IFNDEF NOTFORHELP}
    property DefaultExt:  string  read GetDefaultExt  write SetDefaultExt;
    property FilterIndex: Integer read GetFilterIndex write SetFilterIndex default 1;
    property InitialDir:  string  read GetInitialDir  write SetInitialDir;
{$ENDIF} // NOTFORHELP
    property DialogKind: TFileDialogKind read FDialogKind write SetDialogKind default dkOpen;
    property FileName: string read GetFileName write SetFileName stored False;
    property Filter: string read GetFilter write SetFilter stored IsCustomFilter;
    property HistoryList: TStrings read GetHistoryList write SetHistoryList;
    property DialogOptions: TOpenOptions read GetOptions write SetOptions default [ofHideReadOnly, ofEnableSizing];
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsDirectoryEdit = class(TsFileDirEdit)
{$IFNDEF NOTFORHELP}
  private
    FInitialDir,
    FDialogText: string;

    FNoChangeDir,
    FShowRootBtns: boolean;

    FRoot: TacRoot;
    FOptions: TSelectDirOpts;
  protected
    procedure ButtonClick; override;
    procedure ReceptFileDir(const AFileName: acString); override;
    function GetLongName:  string; override;
    function GetShortName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AcceptFiles;
    property InitialDir: string read FInitialDir write FInitialDir;
{$ENDIF} // NOTFORHELP
    property DialogOptions: TSelectDirOpts read FOptions write FOptions default [sdAllowCreate, sdPerformCreate, sdPrompt];
    property DialogText: string read FDialogText write FDialogText;
    property Root: TacRoot read FRoot write FRoot;
    property MultipleDirs: boolean read FMultipleDirs write FMultipleDirs default False;
    property NoChangeDir:  boolean read FNoChangeDir  write FNoChangeDir  default False;
    property ShowRootBtns: boolean read FShowRootBtns write FShowRootBtns default False;
  end;


  TYearDigits = (dyDefault, dyFour, dyTwo);
  TOnAcceptDate = procedure(Sender: TObject; var aDate: TDateTime; var CanAccept: boolean) of object;

  TsCustomDateEdit = class(TsCustomComboEdit)
{$IFNDEF NOTFORHELP}
  private
    FFormatting,
    FShowWeeks,
    FShowTodayBtn,
    FShowCurrentDate,
    FDefaultToday,
    FHooked,
    FCheckOnExit: boolean;

    FMinDate,
    FMaxDate,
    FIntDate: TDateTime;

    FTitle: string;
    FBlanksChar: Char;
    FCalendarHints: TStrings;
    FStartOfWeek: TCalDayOfWeek;
    FWeekends: sConst.TDaysOfWeek;
    FWeekendColor: TColor;
    FYearDigits: TYearDigits;
    FDateFormat: string[10];
    FCloseUp: TNotifyEvent;

    FOnDrawDay:       TGetCellParams;
    FOnGetCellParams: TGetCellParams;
    FOnGetPopupFont:  TGetPopupFont;
    FOnAcceptDate:    TOnAcceptDate;
    FAnimated: boolean;
    function GetDate: TDateTime;
    procedure SetDate(Value: TDateTime);
    procedure SetYearDigits(Value: TYearDigits);
    function GetDialogTitle: string;
    procedure SetDialogTitle(const Value: string);
    function IsCustomTitle: boolean;
    procedure SetCalendarHints(Value: TStrings);
    procedure CalendarHintsChanged(Sender: TObject);
    procedure SetWeekendColor(Value: TColor);
    procedure SetWeekends(Value: sConst.TDaysOfWeek);
    procedure SetStartOfWeek(Value: TCalDayOfWeek);
    procedure SetBlanksChar(Value: Char);
    function TextStored: boolean;
    function FourDigitYear: boolean;
    function FormatSettingsChange(var Message: TMessage): boolean;
    procedure SetMinDate(const Value: TDateTime);
    procedure SetMaxDate(const Value: TDateTime);
    procedure SetShowCurrentDate(const Value: boolean);
    procedure CMExit       (var Message: TCMExit);        message CM_EXIT;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    function GetCheckOnExit: boolean;
  protected
    function CaretPos(X: integer): integer;
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DestroyWindowHandle; override;
    function GetDateFormat: string;
    function DateIsStored: boolean;
    procedure ApplyDate(Value: TDateTime); virtual;
    procedure UpdateFormat;
    procedure UpdatePopup;
    procedure PopupWindowShow; override;
    property Formatting: boolean read FFormatting;
    property EditMask stored False;
    property DialogTitle: string read GetDialogTitle write SetDialogTitle stored IsCustomTitle;
{$ENDIF} // NOTFORHELP
    property BlanksChar: Char read FBlanksChar write SetBlanksChar default s_Space;
    property CalendarHints: TStrings read FCalendarHints write SetCalendarHints;
    property CheckOnExit: boolean read GetCheckOnExit write FCheckOnExit default False;
    property DefaultToday: boolean read FDefaultToday write FDefaultToday default False;
    property MaxLength stored False;
    property StartOfWeek: TCalDayOfWeek read FStartOfWeek write SetStartOfWeek default dowLocaleDefault;
    property Weekends: sConst.TDaysOfWeek read FWeekends write SetWeekends default DefWeekends;
    property WeekendColor: TColor read FWeekendColor write SetWeekendColor default clRed;
    property YearDigits: TYearDigits read FYearDigits write SetYearDigits default dyFour;
    property OnAcceptDate: TOnAcceptDate read FOnAcceptDate write FOnAcceptDate;
{$IFNDEF NOTFORHELP}
  public
    procedure Loaded; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CheckValidDate(CreateRaise: boolean = True): boolean;
    function GetDateMask: string;
    procedure WndProc (var Message: TMessage); override;
    procedure UpdateMask;
{$ENDIF} // NOTFORHELP
    property Date: TDateTime read GetDate write SetDate;
    property Text stored DateIsStored;
  published
    property Animated: boolean read FAnimated write FAnimated default True;
    property MinDate: TDateTime read FMinDate write SetMinDate;
    property MaxDate: TDateTime read FMaxDate write SetMaxDate;
    property ShowCurrentDate: boolean read FShowCurrentDate write SetShowCurrentDate default True;
    property ShowWeeks: boolean read FShowWeeks write FShowWeeks default False;
    property ShowTodayBtn: boolean read FShowTodayBtn write FShowTodayBtn default True;

    property OnGetCellParams: TGetCellParams read FOnGetCellParams write FOnGetCellParams;
    property OnGetPopupFont:  TGetPopupFont  read FOnGetPopupFont  write FOnGetPopupFont;
    property OnCloseUp: TNotifyEvent read FCloseUp write FCloseUp;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsDateEdit = class(TsCustomDateEdit)
{$IFNDEF NOTFORHELP}
  public
    constructor Create(AOwner: TComponent); override;
    property EditMask;
  published
    property BlanksChar;
    property CalendarHints;
    property CheckOnExit;
    property ClickKey;
    property Date;
    property DefaultToday;
    property DialogTitle;
    property MaxDate;
    property MinDate;
    property PopupAlign;
    property PopupHeight;
    property PopupWidth;
    property StartOfWeek;
    property Text;
    property Weekends;
    property WeekendColor;
    property YearDigits;
    property OnAcceptDate;
    property OnButtonClick;
    property OnChange;
    property OnContextPopup;
{$ENDIF} // NOTFORHELP
  end;


{$IFNDEF NOTFORHELP}
procedure DateFormatChanged;
function StrToDateFmt(const DateFormat, S: string): TDateTime;
{$ENDIF} // NOTFORHELP

implementation

uses
  ShellAPI, Consts, ExtDlgs,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sMessages, acPathDialog, acShellCtrls, sSkinManager, sGlyphUtils, sGraphUtils;


procedure TsFileDirEdit.DoBeforeDialog(var FileName: string; var Action: boolean);
begin
  if Assigned(FOnBeforeDialog) then
    FOnBeforeDialog(Self, FileName, Action);
end;


procedure TsFileDirEdit.DoAfterDialog(var FileName: string; var Action: boolean);
begin
  if Assigned(FOnAfterDialog) then
    FOnAfterDialog(Self, FileName, Action);
end;


constructor TsFileDirEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsFileDirEdit;
  MaxLength := MaxByte;
end;


procedure TsFileDirEdit.CreateHandle;
begin
  inherited CreateHandle;
  if FAcceptFiles then
    SetDragAccept(True);
end;


procedure TsFileDirEdit.DestroyWindowHandle;
begin
  SetDragAccept(False);
  inherited DestroyWindowHandle;
end;


procedure TsFileDirEdit.SetDragAccept(Value: boolean);
begin
  if not (csDesigning in ComponentState) and (Handle <> 0) then
    DragAcceptFiles(Handle, Value);
end;


procedure TsFileDirEdit.SetAcceptFiles(Value: boolean);
begin
  if FAcceptFiles <> Value then begin
    SetDragAccept(Value);
    FAcceptFiles := Value;
  end;
end;


procedure TsFileDirEdit.WMDropFiles(var Msg: TWMDropFiles);
const
  maxlen = 254;
var
  i, Num: Cardinal;
  FileName: acString;
  pchr: array [0..maxlen] of acChar;
begin
  Msg.Result := 0;
  Num := DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0);
  if Num > 0 then begin
    ClearFileList;
    for i := 0 to Num - 1 do begin
      {$IFDEF TNTUNICODE}DragQueryFileW{$ELSE}DragQueryFile{$ENDIF}(Msg.Drop, i, pchr, maxlen);
      FileName := acString(pchr);
      ReceptFileDir(FileName);
      if not FMultipleDirs then
        Break;
    end;
    if Assigned(FOnDropFiles) then
      FOnDropFiles(Self);
  end;
  DragFinish(Msg.Drop);
end;


procedure TsFileDirEdit.ClearFileList;
begin
//
end;


constructor TsFilenameEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsFilenameEdit;
  FDefBmpID := iBTN_OPENFILE;
  CreateEditDialog;
end;


procedure TsFilenameEdit.CreateEditDialog;
var
  NewDialog: TOpenDialog;
begin
  case FDialogKind of
    dkOpen: begin
      NewDialog := TsOpenDialog.Create(Self);
      TsOpenDialog(NewDialog).ZipShowing := zsAsFile;
    end;
    dkOpenPicture: NewDialog := TOpenPictureDialog.Create(Self);
    dkSave:        NewDialog := TsSaveDialog.Create(Self);
    dkSavePicture: NewDialog := TSavePictureDialog.Create(Self)
    else           NewDialog := nil;
  end;
  if FDialog <> nil then begin
    NewDialog.DefaultExt    := FDialog.DefaultExt;
    NewDialog.FileEditStyle := FDialog.FileEditStyle;
    NewDialog.FileName      := FDialog.FileName;
    NewDialog.Filter        := FDialog.Filter;
    NewDialog.FilterIndex   := FDialog.FilterIndex;
    NewDialog.InitialDir    := FDialog.InitialDir;
    NewDialog.HistoryList   := FDialog.HistoryList;
    NewDialog.Options       := FDialog.Options;
    NewDialog.Files.Assign(FDialog.Files);
    FreeAndNil(FDialog);
  end
  else begin
    NewDialog.Filter := SDefaultFilter;
    NewDialog.Options := [ofHideReadOnly, ofEnableSizing];
  end;
  FDialog := NewDialog;
end;


function TsFilenameEdit.IsCustomTitle: boolean;
begin
  Result := CompareStr(acs_FileOpen, FDialog.Title) <> 0;
end;


function TsFilenameEdit.IsCustomFilter: boolean;
begin
  Result := CompareStr(sDefaultFilter, FDialog.Filter) <> 0;
end;


procedure TsFilenameEdit.ButtonClick;
var
  Temp: string;
  Flag: boolean;
begin
  inherited;
  Temp := inherited Text;
  Flag := True;
  DoBeforeDialog(Temp, Flag);
  if Flag then begin
    if ValidFileName(Temp) then begin
      if acDirExists(ExtractFilePath(Temp)) then
        SetInitialDir(ExtractFilePath(Temp));

      if (ExtractFileName(Temp) = '') or not ValidFileName(ExtractFileName(Temp)) then
        Temp := '';

      FDialog.FileName := Temp;
    end;
    FDialog.HelpContext := Self.HelpContext;
    Flag := FDialog.Execute;
    if Flag then
      Temp := FDialog.FileName;

    if CanFocus then
      SetFocus;

    DoAfterDialog(Temp, Flag);
    if Flag then begin
      inherited Text := Temp;
      SetInitialDir(ExtractFilePath(FDialog.FileName));
    end;
  end;
end;


function TsFilenameEdit.GetFileName: string;
begin
  Result := inherited Text;
end;


procedure TsFilenameEdit.SetFileName(const Value: string);
begin
  if (Value = '') or ValidFileName(Value) then begin
    inherited Text := Value;
    ClearFileList;
  end
  else
    raise Exception.CreateFmt('Invalid file name', [Value]);
end;


function TsFilenameEdit.GetLongName: string;
begin
  Result := FileName;
end;


function TsFilenameEdit.GetShortName: string;
begin
  Result := FileName;
end;


procedure TsFilenameEdit.ClearFileList;
begin
  FDialog.Files.Clear;
end;


procedure TsFilenameEdit.ReceptFileDir(const AFileName: acString);
begin
  if FMultipleDirs then begin
    if FDialog.Files.Count = 0 then
      SetFileName(AFileName);

    FDialog.Files.Add(AFileName);
  end
  else
    SetFileName(AFileName);
end;


function TsFilenameEdit.GetDialogFiles: TStrings;
begin
  Result := FDialog.Files;
end;


function TsFilenameEdit.GetDefaultExt: string;
begin
  Result := FDialog.DefaultExt;
end;


function TsFilenameEdit.GetFileEditStyle: TFileEditStyle;
begin
  Result := FDialog.FileEditStyle;
end;


function TsFilenameEdit.GetFilter: string;
begin
  Result := FDialog.Filter;
end;


function TsFilenameEdit.GetFilterIndex: Integer;
begin
  Result := FDialog.FilterIndex;
end;


function TsFilenameEdit.GetInitialDir: string;
begin
  Result := FDialog.InitialDir;
end;


function TsFilenameEdit.GetHistoryList: TStrings;
begin
  Result := FDialog.HistoryList;
end;


function TsFilenameEdit.GetOptions: TOpenOptions;
begin
  Result := FDialog.Options;
end;


function TsFilenameEdit.GetDialogTitle: string;
begin
  Result := FDialog.Title;
end;


procedure TsFilenameEdit.SetDialogKind(Value: TFileDialogKind);
begin
  if FDialogKind <> Value then begin
    FDialogKind := Value;
    CreateEditDialog;
  end;
end;


procedure TsFilenameEdit.SetDefaultExt(const Value: string);
begin
  FDialog.DefaultExt := Value;
end;


procedure TsFilenameEdit.SetFileEditStyle(Value: TFileEditStyle);
begin
  FDialog.FileEditStyle := Value;
end;


procedure TsFilenameEdit.SetFilter(const Value: string);
begin
  FDialog.Filter := Value;
end;


procedure TsFilenameEdit.SetFilterIndex(Value: Integer);
begin
  FDialog.FilterIndex := Value;
end;


procedure TsFilenameEdit.SetInitialDir(const Value: string);
begin
  FDialog.InitialDir := Value;
end;


procedure TsFilenameEdit.SetHistoryList(Value: TStrings);
begin
  FDialog.HistoryList := Value;
end;


procedure TsFilenameEdit.SetOptions(Value: TOpenOptions);
begin
  if Value <> FDialog.Options then begin
    FMultipleDirs := ofAllowMultiSelect in Value;
    FDialog.Options := Value;
    if not FMultipleDirs then
      ClearFileList;
  end;
end;


procedure TsFilenameEdit.SetDialogTitle(const Value: string);
begin
  FDialog.Title := Value;
end;


constructor TsDirectoryEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsDirectoryEdit;
  FDefBmpID := iBTN_OPENFOLDER;
  FOptions := [sdAllowCreate, sdPerformCreate, sdPrompt];
  FRoot := SRFDesktop;
  FShowRootBtns := False;
end;


procedure TsDirectoryEdit.ButtonClick;
var
  s: string;
  Flag: boolean;
  bw: integer;
begin
  inherited;
  s := Text;
  Flag := True;
  DoBeforeDialog(s, Flag);
  if Flag then begin
    if (s = '') and (InitialDir <> '') then
      s := InitialDir;

    if acDirExists(s) then begin
      if not NoChangeDir then
        ChDir(s);
    end
    else
      s := '';

    PathDialogForm := TPathDialogForm.Create(Application);
    PathDialogForm.InitLngCaptions;
    PathDialogForm.sBitBtn3.Visible := sdAllowCreate in DialogOptions;
    if ShowRootBtns then begin
      PathDialogForm.sScrollBox1.Visible := True;
      PathDialogForm.sLabel1.Visible := True;
      bw := GetSystemMetrics(SM_CXSIZEFRAME);
      PathDialogForm.sShellTreeView1.Left := PathDialogForm.sShellTreeView1.Left + PathDialogForm.sScrollBox1.Width + 4;
      PathDialogForm.sBitBtn1.Left := PathDialogForm.sBitBtn1.Left + PathDialogForm.sScrollBox1.Width + 4;
      PathDialogForm.sBitBtn2.Left := PathDialogForm.sBitBtn2.Left + PathDialogForm.sScrollBox1.Width + 4;
      PathDialogForm.Width := PathDialogForm.Width + PathDialogForm.sScrollBox1.Width + 4 + bw;
      PathDialogForm.GenerateButtons;
    end
    else
      PathDialogForm.sLabel1.Visible := False;

    PathDialogForm.UpdateAnchors;
    try
      PathDialogForm.sShellTreeView1.BoundLabel.Caption := DialogText;
      PathDialogForm.sShellTreeView1.Root := FRoot;
      if (s <> '') and acDirExists(s) then
        PathDialogForm.sShellTreeView1.Path := s;

      if PathDialogForm.ShowModal = mrOk then begin
        s := PathDialogForm.sShellTreeView1.Path;
        if (s <> '') and acDirExists(s) then
          InitialDir := s;
      end
      else begin
        s := Text;
        Flag := False;
      end;

    finally
      FreeAndNil(PathDialogForm);
    end;
    DoAfterDialog(s, Flag);
    if Flag then
      Text := s;
  end;
end;


procedure TsDirectoryEdit.ReceptFileDir(const AFileName: acString);
var
  s: string;
begin
  if FileExists(AFileName) then
    s := ExtractFilePath(AFileName)
  else
    s := AFileName;

  if (Text = '') or not MultipleDirs then
    Text := s
  else
    Text := Text + ';' + s;
end;


function TsDirectoryEdit.GetLongName: string;
var
  s: string;
  Pos: Integer;
begin
  if not MultipleDirs then
    Result := ShortToLongPath(Text)
  else begin
    Result := '';
    Pos := 1;
    while Pos <= Length(Text) do begin
      s := ShortToLongPath(ExtractSubstr(Text, Pos, [';']));
      if (Result <> '') and (s <> '') then
        Result := Result + ';';

      Result := Result + s;
    end;
  end;
end;


function TsDirectoryEdit.GetShortName: string;
var
  s: string;
  Pos: Integer;
begin
  if not MultipleDirs then
    Result := LongToShortPath(Text)
  else begin
    Result := '';
    Pos := 1;
    while Pos <= Length(Text) do begin
      s := LongToShortPath(ExtractSubstr(Text, Pos, [';']));
      if (Result <> '') and (s <> '') then
        Result := Result + ';';

      Result := Result + s;
    end;
  end;
end;


function NvlDate(DateValue, DefaultValue: TDateTime): TDateTime;
begin
  if DateValue = NullDate then
    Result := DefaultValue
  else
    Result := DateValue;
end;


constructor TsCustomDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsCustomDateEdit;

  FBlanksChar := s_Space;
  FTitle := 'Date select';
  FStartOfWeek := dowLocaleDefault;
  FWeekends := DefWeekends;
  FWeekendColor := clRed;
  FYearDigits := dyFour;
  FCalendarHints := TStringList.Create;
  TStringList(FCalendarHints).OnChange := CalendarHintsChanged;
  FDefBmpID := iBTN_DATE;
  FShowCurrentDate := True;
  FShowWeeks := False;
  FShowTodayBtn := True;
  FDefaultToday := False;
  FAnimated := True;

  ControlState := ControlState + [csCreating];
  Width := 86;
  try
    UpdateFormat;
  finally
    ControlState := ControlState - [csCreating];
  end;
end;


destructor TsCustomDateEdit.Destroy;
begin
  if FHooked then begin
    Application.UnhookMainWindow(FormatSettingsChange);
    FHooked := False;
  end;
  if Assigned(FPopupwindow) then
    FreeAndNil(FPopupWindow);

  TStringList(FCalendarHints).OnChange := nil;
  if Assigned(FCalendarHints) then
    FreeAndNil(FCalendarHints);

  inherited Destroy;
end;


procedure TsCustomDateEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  if Handle <> 0 then begin
    UpdateMask;
    if not (csDesigning in ComponentState) and not (IsLibrary or FHooked) then begin
      Application.HookMainWindow(FormatSettingsChange);
      FHooked := True;
    end;
  end;
end;


procedure TsCustomDateEdit.DestroyWindowHandle;
begin
  if FHooked then begin
    Application.UnhookMainWindow(FormatSettingsChange);
    FHooked := False;
  end;
  inherited DestroyWindowHandle;
end;


procedure TsCustomDateEdit.UpdateFormat;
begin
  FDateFormat := DefDateFormat(FourDigitYear);
end;


function TsCustomDateEdit.GetDateFormat: string; // Unused
begin
  Result := FDateFormat;
end;


function TsCustomDateEdit.TextStored: boolean;
begin
  Result := not IsEmptyStr(Text, [#0, s_Space, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DateSeparator, FBlanksChar]);
end;


function TsCustomDateEdit.CheckValidDate(CreateRaise: boolean = True): boolean;
var
  i, l: integer;
  s, sub: string;
{$IFDEF DELPHI7UP}
  D: TDateTime;
{$ENDIF}
begin
  Result := False;
  if TextStored then
    try
      FFormatting := True;
      try
        i := iff(FourDigitYear, 4, 2);
        l := Length(Text) - i + 1;
        if (Copy(Text, l, 1) = s_Space) or (Copy(Text, l + 1, 1) = s_Space) then begin
          s := Text;
          Delete(s, l, i);
          l := ExtractYear(SysUtils.Date);
          Text := s + IntToStr(l);
        end
        else
          if FourDigitYear then
            if (Copy(Text, l + 2, 1) = s_Space) or (Copy(Text, l + 3, 1) = s_Space) then begin
              s := Text;
              sub := Copy(IntToStr(ExtractYear(SysUtils.Date)), 1, 2) + Copy(Text, l, 2);
              Delete(s, l, i);
              Text := s + sub;
            end;

{$IFDEF DELPHI7UP}
        Result := TryStrToDate(Text, D);
        if Result then
          SetDate(D)
        else begin
          s := acs_InvalidDate + ': ' + Text;
          if Assigned(OnValidateError) then
            OnValidateError(Self, s)
          else
            if CreateRaise then
              Raise EConvertError.CreateFmt(acs_InvalidDate, [Text]);
        end;
{$ELSE}
        SetDate(StrToDateFmt(FDateFormat, Text));
        Result := True;
{$ENDIF}
      finally
        FFormatting := False;
      end;
    except
      if CanFocus then
        SetFocus;

      raise;
    end;
end;


procedure TsCustomDateEdit.Change;
begin
  if not FFormatting then
    inherited Change;
end;


function StrToDateFmtDef(const DateFormat, S: string; Default: TDateTime): TDateTime;
begin
  if not InternalStrToDate(DateFormat, S, Result) then
    Result := Trunc(Default);
end;


procedure TsCustomDateEdit.CMExit(var Message: TCMExit);
begin
  if not (csDesigning in ComponentState) and CheckOnExit and CheckValidDate then
    if (FMaxDate <> 0) and (Date > FMaxDate) then
      Date := FMaxDate
    else
      if (FMinDate <> 0) and (Date < FMinDate) then
        Date := FMinDate
      else
        Date := StrToDateFmtDef(FDateFormat, Text, Date);

  inherited;
end;


procedure TsCustomDateEdit.SetBlanksChar(Value: Char);
begin
  if Value <> FBlanksChar then begin
    if (Value < s_Space) then
      Value := s_Space;

    FBlanksChar := Value;
    UpdateMask;
  end;
end;


procedure TsCustomDateEdit.UpdateMask;
var
  DateValue: TDateTime;
  OldFormat: string[10];
begin
  DateValue := GetDate;
  OldFormat := FDateFormat;
  UpdateFormat;
  if (GetDateMask <> EditMask) or (OldFormat <> FDateFormat) then begin { force update }
    EditMask := '';
    EditMask := GetDateMask;
  end;
  UpdatePopup;
  SetDate(DateValue);
end;


function TsCustomDateEdit.FormatSettingsChange(var Message: TMessage): boolean;
begin
  Result := False;
  if (Message.Msg = WM_WININICHANGE) and Application.UpdateFormatSettings then
    UpdateMask;
end;


function TsCustomDateEdit.FourDigitYear: boolean;
begin
  Result := (FYearDigits = dyFour);
  Result := Result or ((FYearDigits = dyDefault) and sDateUtils.NormalYears);
end;


function TsCustomDateEdit.GetDateMask: string;
begin
  Result := DefDateMask(FBlanksChar, FourDigitYear);
end;


function TsCustomDateEdit.GetDate: TDateTime;
begin
  if (Pos(s_Space, Text) > 0) or (NullDate = FIntDate) then
    if DefaultToday and not (csDesigning in ComponentState) then
      Result := SysUtils.Date
    else
      Result := NullDate
  else
    Result := FIntDate;
end;


var
  acTextChanging: boolean = False;


procedure TsCustomDateEdit.SetDate(Value: TDateTime);
var
  D: TDateTime;
begin
  if not ValidDate(Value) or (Value = NullDate) then
    if DefaultToday and not (csDesigning in ComponentState) then
      FIntDate := SysUtils.Date
    else
      FIntDate := NullDate
  else
    FIntDate := Value;

  D := Self.Date;
  if not acTextChanging then begin
    acTextChanging := True;
    if FIntDate = NullDate then
      Text := ''
    else
      TEdit(Self).Text := FormatDateTime(FDateFormat, FIntDate);

    acTextChanging := False;
  end;

  Modified := D <> Date;
  SkinData.BGChanged := SkinData.BGChanged or Modified;
end;


procedure TsCustomDateEdit.ApplyDate(Value: TDateTime);
begin
  SetDate(Value);
  SelectAll;
end;


function TsCustomDateEdit.GetDialogTitle: string;
begin
  Result := FTitle;
end;


procedure TsCustomDateEdit.SetDialogTitle(const Value: string);
begin
  FTitle := Value;
end;


function TsCustomDateEdit.IsCustomTitle: boolean;
begin
  Result := (CompareStr('Date select', DialogTitle) <> 0) and (FTitle <> '');
end;


procedure TsCustomDateEdit.UpdatePopup;
var
  i: integer;
begin
  if (FPopupWindow <> nil) and (TsPopupCalendar(FPopupWindow).FCalendar <> nil) then
    with TsPopupCalendar(FPopupWindow) do begin
      FCalendar.StartOfWeek := FStartOfWeek;
      FCalendar.Weekends := FWeekends;
      FCalendar.WeekendColor := FWeekendColor;
      sMonthCalendar1.ShowWeeks := FShowWeeks;
      sMonthCalendar1.ShowTodayBtn := FShowTodayBtn;
      FPopupWindow.Height := FormHeight + Integer(FShowTodayBtn) * 16;

      if Assigned(FOnGetCellParams) then
        sMonthCalendar1.OnGetCellParams := FOnGetCellParams
      else
        sMonthCalendar1.OnGetCellParams := nil;

      if Assigned(FOnDrawDay) then
        sMonthCalendar1.OnDrawDay := FOnDrawDay
      else
        sMonthCalendar1.OnDrawDay := nil;

      if Assigned(FCloseUp) then
        TsPopupCalendar(FPopupWindow).OnCloseUp := FCloseUp
      else
        TsPopupCalendar(FPopupWindow).OnCloseUp := nil;

      if SkinData.Skinned and (DefaultManager <> nil) then
        Color := DefaultManager.GetGlobalColor
      else
        Color := clBtnFace;

      for i := 0 to CalendarHints.Count -1 do begin
        FCalendar.FBtns[i].Hint := CalendarHints[i];
        FCalendar.FBtns[i].ShowHint := ShowHint;
        if i = 3 then
          break;
      end;
    end;
end;


procedure TsCustomDateEdit.SetYearDigits(Value: TYearDigits);
begin
  if FYearDigits <> Value then begin
    FYearDigits := Value;
    UpdateMask;
  end;
end;


procedure TsCustomDateEdit.SetCalendarHints(Value: TStrings);
begin
  FCalendarHints.Assign(Value);
end;


procedure TsCustomDateEdit.CalendarHintsChanged(Sender: TObject);
begin
  TStringList(FCalendarHints).OnChange := nil;
  try
    while (FCalendarHints.Count > 4) do
      FCalendarHints.Delete(FCalendarHints.Count - 1);
  finally
    TStringList(FCalendarHints).OnChange := CalendarHintsChanged;
  end;
  if not (csDesigning in ComponentState) then
    UpdatePopup;
end;


procedure TsCustomDateEdit.SetWeekendColor(Value: TColor);
begin
  if Value <> FWeekendColor then begin
    FWeekendColor := Value;
    UpdatePopup;
  end;
end;


procedure TsCustomDateEdit.SetWeekends(Value: sConst.TDaysOfWeek);
begin
  if Value <> FWeekends then begin
    FWeekends := Value;
    UpdatePopup;
  end;
end;


procedure TsCustomDateEdit.SetStartOfWeek(Value: TCalDayOfWeek);
begin
  if Value <> FStartOfWeek then begin
    FStartOfWeek := Value;
    UpdatePopup;
  end;
end;


procedure TsCustomDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key in [VK_PRIOR, VK_NEXT, VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_ADD, VK_SUBTRACT, VK_RETURN, VK_ESCAPE]) and DroppedDown then begin
    TsPopupCalendar(FPopupWindow).FCalendar.FGrid.KeyDown(Key, Shift);
    Key := 0;
  end
  else
    if (Shift = []) and DirectInput and not ReadOnly then
      case Key of
        VK_UP, VK_ADD: begin
          ApplyDate(NvlDate(Date, Now) + 1);
          Key := 0;
        end;

        VK_DOWN, VK_SUBTRACT: begin
          ApplyDate(NvlDate(Date, Now) - 1);
          Key := 0;
        end;
      end;

  inherited KeyDown(Key, Shift);
end;


procedure TsCustomDateEdit.KeyPress(var Key: Char);
begin
  if CharInSet(Key, ['T', 't', CharPlus, CharMinus]) and DroppedDown then begin
    TsPopupCalendar(FPopupWindow).FCalendar.FGrid.KeyPress(Key);
    Key := #0;
  end
  else
    if DirectInput and not ReadOnly then
      case Key of
        'T', 't': begin
          ApplyDate(Trunc(Now));
          Key := #0;
        end;

        CharPlus, CharMinus:
          Key := #0;
      end;

  inherited KeyPress(Key);
end;


procedure TsCustomDateEdit.PopupWindowShow;
begin
  if FPopupWindow = nil then begin
    if sPopupCalendar <> nil then
      sPopupCalendar.Close;

    FPopupWindow := TsPopupCalendar.Create(Self);
  end
  else
    if (sPopupCalendar <> nil) and (sPopupCalendar <> FPopupWindow) then
      sPopupCalendar.Close;

  sPopupCalendar := TForm(FPopupWindow);
  TsPopupCalendar(FPopupWindow).Font.Assign(Font);
  if Assigned(OnGetPopupFont) then
    OnGetPopupFont(Self, TsPopupCalendar(FPopupWindow).Font);

  TsPopupCalendar(FPopupWindow).FCalendar.MaxDate := MaxDate;
  TsPopupCalendar(FPopupWindow).FCalendar.MinDate := MinDate;
  TsPopupCalendar(FPopupWindow).FCalendar.Animated := FAnimated; 
  if Self.Date <> NullDate then
    TsPopupCalendar(FPopupWindow).FCalendar.CalendarDate := Self.Date
  else
    TsPopupCalendar(FPopupWindow).FCalendar.CalendarDate := SysUtils.Date;

  TsPopupCalendar(FPopupWindow).FCalendar.ControlStyle := TsPopupCalendar(FPopupWindow).FCalendar.ControlStyle - [csDoubleClicks];
  TsPopupCalendar(FPopupWindow).FEditor := Self;
  UpdatePopup;
  inherited;
end;


procedure TsCustomDateEdit.Loaded;
begin
  inherited;
  UpdateMask;
end;


procedure TsCustomDateEdit.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            if Assigned (FPopupWindow) then
              FPopupWindow.BroadCast(Message);

            UpdateFormat;
            UpdateMask;
          end;

        AC_SETNEWSKIN, AC_REFRESH:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
            if Assigned (FPopupWindow) then
              FPopupWindow.BroadCast(Message);

            UpdateFormat;
            UpdateMask;
          end;
      end;
  end;
  inherited;
  case Message.Msg of
    CM_CHANGED, CM_TEXTCHANGED:
      if not (csLoading in ComponentState) and not acTextChanging then begin
        acTextChanging := True;
        if (Text = '') or (Pos(s_Space, Text) > 0) or not TextStored then
          Date := 0
        else
          SetDate(StrToDateFmtDef(FDateFormat, Text, Date));

        acTextChanging := False;
     end;
  end;
end;


procedure TsCustomDateEdit.SetMinDate(const Value: TDateTime);
begin
  if (FMaxDate = NullDate) or (Value <= FMaxDate) then
    if (FMinDate <> Value) then begin
      FMinDate := Value;
      if Date < FMinDate then
        Date := FMinDate;
    end;
end;


procedure TsCustomDateEdit.SetMaxDate(const Value: TDateTime);
begin
  if (FMaxDate <> Value) and (Value >= FMinDate) then begin
    FMaxDate := Value;
    if Date > FMaxDate then
      Date := FMaxDate;
  end;
end;


function TsCustomDateEdit.DateIsStored: boolean;
begin
  Result := not DefaultToday
end;


procedure TsCustomDateEdit.SetShowCurrentDate(const Value: boolean);
begin
  if FShowCurrentDate <> Value then
    FShowCurrentDate := Value;
end;


procedure TsCustomDateEdit.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  if not AutoSelect or (CaretPos(Message.XPos) < Length(Text)) then
    case CaretPos(Message.XPos) of
      1..3: begin
        SelStart  := 0;
        SelLength := 2;
      end;

      4..7: begin
        SelStart  := 3;
        SelLength := 2;
      end

      else begin
        SelStart  := 6;
        SelLength := 4;
      end;
    end;
end;


function TsCustomDateEdit.CaretPos(X: integer): integer;
var
  i, l, pos, w: integer;
begin
  Result := 0;
  pos := 0;
  l := iff(FourDigitYear, 10, 8);
  for i := 1 to l do begin
    case i of
      3, 6: w := GetStringSize(Font.Handle, s_Comma).cx
      else  w := GetStringSize(Font.Handle, ZeroChar).cx;
    end;

    if X < pos + w then begin
      Result := i;
      Exit;
    end
    else
      inc(pos, w);
  end;
end;


constructor TsDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SkinData.COC := COC_TsDateEdit;
  EditMask := '!90/90/0000;1; ';
  UpdateMask;
end;


procedure DateFormatChanged;

  procedure IterateControls(AControl: TWinControl);
  var
    I: Integer;
  begin
    with AControl do
      for I := 0 to ControlCount - 1 do
        if Controls[I] is TsCustomDateEdit then
          TsCustomDateEdit(Controls[I]).UpdateMask
        else
          if Controls[I] is TWinControl then
            IterateControls(TWinControl(Controls[I]));
  end;

var
  I: Integer;
begin
  if Screen <> nil then
    for I := 0 to Screen.FormCount - 1 do
      IterateControls(Screen.Forms[I]);
end;


function StrToDateFmt(const DateFormat, S: string): TDateTime;
begin
  if not InternalStrToDate(DateFormat, S, Result) then
    Raise EConvertError.CreateFmt(acs_InvalidDate, [S]);
end;


function TsCustomDateEdit.GetCheckOnExit: boolean;
begin
  Result := True;
end;

end.
