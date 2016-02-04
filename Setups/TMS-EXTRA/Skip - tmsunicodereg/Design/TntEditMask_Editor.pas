unit TntEditMask_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, TntStdCtrls, StdCtrls;

{$INCLUDE ..\Source\TntCompilers.inc}

const
  TntMaskEditFile = 'TntMaskEdit.dem';
type
  TTntDemReader = class;

  TEditMaskForm = class(TForm)
    LB_Masks: TListBox;
    Edt_InputMask: TEdit;
    Edt_Blank: TEdit;
    chk_SaveLiteral: TCheckBox;
    GroupBox1: TGroupBox;
    TntMEdit_TestInput: TTntMaskEdit;
    Btn_Masks: TButton;
    Btn_ok: TButton;
    Btn_Cancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Dlg_OpenFile: TOpenDialog;
    procedure LB_MasksDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SyncMaskListBox;
    procedure LB_MasksClick(Sender: TObject);
    procedure chk_SaveLiteralClick(Sender: TObject);
    procedure Edt_BlankChange(Sender: TObject);
    procedure Btn_MasksClick(Sender: TObject);
  private
    FDemReader: TTntDemReader;
    FSampleMargin: Integer;
    { Private declarations }
  protected
    procedure Loaded; override;
    procedure InputTextChanged;
  public
    { Public declarations }
    procedure SetInputMask(Value: string);
    property DemReader: TTntDemReader read FDemReader;
  end;

  TTntMask = class(TObject)
  private
    FSample: string;
    FMaskName: string;
    FInputMask: string;
  public
    constructor create;
    property MaskName: string read FMaskName write FMaskName;
    property Sample: string read FSample write FSample;
    property InputMask: string read FInputMask write FInputMask;
  end;

  TTntDemReader = class(TObject)
  private
    FMaskList: TList;
    function GetMasks(index: integer): TTntMask;
    function GetMaskCount: Integer;
  protected
    procedure LoadDefault;
  public
    constructor create;
    destructor Destroy; override;
    procedure ClearMask;
    function LoadFromFile(FileName: TFileName; Persist: Boolean): Boolean;
    function IndexOfInputMask(InputMask: string): Integer;
    property Masks[index: integer]: TTntMask read GetMasks;
    property MaskCount: Integer read GetMaskCount;
  end;

var
  EditMaskForm: TEditMaskForm;

implementation

{$R *.dfm}

uses
  ShlObj, ActiveX;

function DirectoryExists(const Name: string): Boolean;
var
  Code: DWORD;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> $FFFFFFFF) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function ForceDirectories(Dir: string): Boolean;
begin
  Result := True;
  if Length(Dir) = 0 then
    Exit;
//    raise Exception.Create('Cannot create directory');

  if Dir[length(Dir)] = '\' then
    Delete(Dir,length(Dir),1);

  if (Length(Dir) < 3) or DirectoryExists(Dir)
    or (ExtractFilePath(Dir) = Dir) then Exit; // avoid 'xyz:\' problem.
  Result := ForceDirectories(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

function AddBackslash(const s: string): string;
begin
  if (Length(s) >= 1) and (s[Length(s)]<>'\') then
    Result := s + '\'
  else
    Result := s;
end;

function WinTempDir: string;
var
  buf: array[0..MAX_PATH] of Char;
begin
  GetTempPath(sizeof(buf),buf);
  Result := AddBackslash(StrPas(buf));
end;

{ get Application data folder }

{$IFDEF COMPILER_6_UP}
procedure FreePidl( pidl: PItemIDList );
var
  allocator: IMalloc;
begin
  if Succeeded(SHGetMalloc(allocator)) then
    allocator.Free(pidl);
end;

function GetAppData: string;
var
  pidl: PItemIDList;
  Path: array [0..MAX_PATH-1] of char;
begin
  Result := '';

  if Succeeded(
       SHGetSpecialFolderLocation(0, CSIDL_APPDATA, pidl)
     ) then
  begin
    if SHGetPathFromIDList(pidl, Path) then
      Result := AddBackSlash(StrPas(Path));
    FreePidl(pidl);
    ForceDirectories(Result + 'tmssoftware');
  end;
end;
{$ENDIF}

{$IFNDEF COMPILER_6_UP}
function GetAppData: string;
begin
  result := WinTempDir;
end;
{$ENDIF}

{ TTntMasks }

constructor TTntMask.create;
begin
  inherited;
  FSample := '';
  FMaskName := '';
  FInputMask := '';
end;

{ TTntDemReader }

constructor TTntDemReader.create;
begin
  inherited;
  FMaskList := TList.Create;
end;

destructor TTntDemReader.destroy;
begin
  ClearMask;
  FMaskList.Free;
  inherited;
end;

function TTntDemReader.GetMaskCount: Integer;
begin
  Result := FMaskList.Count;
end;

function TTntDemReader.GetMasks(index: integer): TTntMask;
begin
  Result := nil;
  if (Index >= 0) and (Index < MaskCount) then
    Result := TTntMask(FMaskList[Index]);
end;

function TTntDemReader.IndexOfInputMask(InputMask: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to MaskCount - 1 do
  begin
    if (UpperCase(Masks[i].InputMask) = UpperCase(InputMask)) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TTntDemReader.ClearMask;
var
  i: Integer;
begin
  for i := 0 to FMaskList.Count - 1 do
    TTntMask(FMaskList[i]).Free;
  FMaskList.Clear;  
end;

procedure TTntDemReader.LoadDefault;
var
  aMask: TTntMask;
begin
  ClearMask;
  aMask := TTntMask.create;
  aMask.MaskName := 'Phone';
  aMask.Sample := '1714561234';
  aMask.InputMask := '!\00009 0000099;1;_';
  FMaskList.Add(aMask);

  aMask := TTntMask.create;
  aMask.MaskName := 'Extension';
  aMask.Sample := '15450';
  aMask.InputMask := '!99999;1;_';
  FMaskList.Add(aMask);

  aMask := TTntMask.create;
  aMask.MaskName := 'Postcode';
  aMask.Sample := 'WT3114TA';
  aMask.InputMask := '>AAAa aaaa;1;_';
  FMaskList.Add(aMask);

  aMask := TTntMask.create;
  aMask.MaskName := 'Short Postcode';
  aMask.Sample := 'EC12';
  aMask.InputMask := '>AAAa;1;_';
  FMaskList.Add(aMask);

  aMask := TTntMask.create;
  aMask.MaskName := 'National Insurance';
  aMask.Sample := 'GM134152A';
  aMask.InputMask := '!>AA000000A;1;_';
  FMaskList.Add(aMask);

  aMask := TTntMask.create;
  aMask.MaskName := 'Date';
  aMask.Sample := '270195';
  aMask.InputMask := '!90/90/00;1;_';
  FMaskList.Add(aMask);

  aMask := TTntMask.create;
  aMask.MaskName := 'Long Time';
  aMask.Sample := '090515PM';
  aMask.InputMask := '!90:00:00>LL;1;_';
  FMaskList.Add(aMask);

  aMask := TTntMask.create;
  aMask.MaskName := 'Short Time';
  aMask.Sample := '1345';
  aMask.InputMask := '!90:00;1;_';
  FMaskList.Add(aMask);
end;

function TTntDemReader.LoadFromFile(FileName: TFileName; Persist: Boolean): Boolean;
  function GetMask(s: string): TTntMask;
  var
    i: Integer;
    s1: string;
  begin
    Result := nil;
    if (s <> '') then
    begin
      i := Pos('|', s);
      if (i > 0) then
      begin
        Result := TTntMask.create;
        s1 := Trim(Copy(s, 1, i - 1));
        Result.MaskName := s1;
        s := Copy(s, i + 1, Length(s));
      end
      else
        Exit;

      i := Pos('|', s);
      if (s <> '') and (i > 0) and (Result <> nil) then
      begin
        s1 := Trim(Copy(s, 1, i - 1));
        Result.Sample := s1;
        s := Copy(s, i + 1, Length(s));
      end;

      if (s <> '') and (Result <> nil) then
      begin
        s1 := Trim(s);
        Result.InputMask := s1;
      end;
    end;
  end;
var
  f, f2: TextFile;
  s: string;
  aMask: TTntMask;
begin
  Result := False;
  if FileExists(FileName) then
  begin
    AssignFile(f, FileName);
    Reset(f);
    if IOResult <> 0 then
      raise Exception.Create('Cannot open file ' + FileName);

    if Persist then
      Persist := UpperCase(TntMaskEditFile) <> UpperCase(FileName);
        
    if Persist then
    begin
      {$IFDEF DELPHI6_LVL}
      s := GetAppData + 'tmssoftware\'+ TntMaskEditFile;
      {$ELSE}
      s := '.\' + TntMaskEditFile;
      {$ENDIF}

      AssignFile(f2, s);
      {$i-}
      Rewrite(f2);
      {$i+}
      if IOResult <> 0 then
        raise Exception.Create('Cannot Create ' + s);
    end;

    Readln(f, s);
    aMask := GetMask(s);
    if (aMask <> nil) then
    begin
      if Persist then
        Writeln(f2,s);

      ClearMask;
      FMaskList.Add(aMask);

      while not EOF(f) do
      begin
        Readln(f, s);
        if Persist then
          Writeln(f2,s);
        
        aMask := GetMask(s);
        if (aMask <> nil) then
          FMaskList.Add(aMask);
      end;
    end;
    CloseFile(f);
    if Persist then
      CloseFile(f2);
  end;
end;

procedure TEditMaskForm.FormCreate(Sender: TObject);
var
  s: string;
begin
  FDemReader := TTntDemReader.create;
  if FileExists(GetAppData + 'tmssoftware\'+ TntMaskEditFile) then
  begin
    {$IFDEF DELPHI6_LVL}
    s := GetAppData + 'tmssoftware\'+ TntMaskEditFile;
    {$ELSE}
    s := '.\' + TntMaskEditFile;
    {$ENDIF}
    FDemReader.LoadFromFile(s, False);
  end
  else
    FDemReader.LoadDefault;
  FSampleMargin := LB_Masks.Width div 2;
  SyncMaskListBox;
  // TODO: set initial dir of Dlg_OpenFile here 
end;

procedure TEditMaskForm.FormDestroy(Sender: TObject);
begin
  FDemReader.Free;
end;

procedure TEditMaskForm.SyncMaskListBox;
var
  i: Integer;
begin
  LB_Masks.Clear;
  for i := 0 to FDemReader.MaskCount - 1 do
  begin
    LB_masks.AddItem('', nil);

  end;
end;

procedure TEditMaskForm.LB_MasksDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  OffSet: Integer;
begin
  OffSet := 1;
 with (Control as TListBox).Canvas do
  begin
    FillRect(Rect);
    if (Index < FDemReader.MaskCount) then
    begin
      TextOut(Rect.Left + Offset, Rect.Top{+(((Control as TListBox).ItemHeight-TextHeight('X')) div 2)}, FDemReader.Masks[Index].MaskName);
      TextOut(Rect.Left + FSampleMargin + Offset * 2, Rect.Top{+(((Control as TListBox).ItemHeight-TextHeight('X')) div 2)}, FDemReader.Masks[Index].Sample);
      Pen.Color := clBlack;
      MoveTo(Rect.Left + FSampleMargin, Rect.Top);
      LineTo(Rect.Left + FSampleMargin, Rect.Bottom);
    end;
  end;
end;


procedure TEditMaskForm.Loaded;
begin
  inherited;
end;

procedure TEditMaskForm.InputTextChanged;
begin
  if (Edt_InputMask.Text <> '') then
  begin
    Edt_Blank.Text := Edt_InputMask.Text[Length(Edt_InputMask.Text)];
    chk_SaveLiteral.Checked := (Edt_InputMask.Text[Length(Edt_InputMask.Text)-2]) = '1';
    TntMEdit_TestInput.EditMask := Edt_InputMask.Text;
  end;
end;

procedure TEditMaskForm.SetInputMask(Value: string);
begin
  Edt_InputMask.Text := Value;
  InputTextChanged;
end;

procedure TEditMaskForm.LB_MasksClick(Sender: TObject);
begin
  if (LB_Masks.ItemIndex >= 0) and (FDemReader.MaskCount > 0) then
  begin
    TntMEdit_TestInput.Text := '';
    SetInputMask(FDemReader.Masks[LB_Masks.ItemIndex].InputMask);
  end;
end;

procedure TEditMaskForm.chk_SaveLiteralClick(Sender: TObject);
var
  s: string;
begin
  if ((Edt_InputMask.Text[Length(Edt_InputMask.Text)-2]) = '1') then
  begin
    s := Edt_InputMask.Text;
    s[Length(s)-2] := '0';
    Edt_InputMask.Text := s;
  end
  else
  begin
    s := Edt_InputMask.Text;
    s[Length(s)-2] := '1';
    Edt_InputMask.Text := s;
  end;
  TntMEdit_TestInput.EditMask := Edt_InputMask.Text;
end;

procedure TEditMaskForm.Edt_BlankChange(Sender: TObject);
var
  s: string;
begin
  if (Edt_Blank.Text <> '') then
  begin
    s := Edt_InputMask.Text;
    s[Length(s)] := Edt_Blank.Text[1];
    Edt_InputMask.Text := s;
    TntMEdit_TestInput.EditMask := Edt_InputMask.Text;
  end;
end;

procedure TEditMaskForm.Btn_MasksClick(Sender: TObject);
begin
  if Dlg_OpenFile.Execute then
  begin
    FDemReader.LoadFromFile(Dlg_OpenFile.FileName, True);
    SyncMaskListBox;
  end;
end;

end.
