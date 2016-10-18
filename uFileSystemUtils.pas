unit uFileSystemUtils;
interface

uses Types, System.SysUtils, Registry, Winapi.Windows, System.IOUtils, Controls, ShellAPI;

function LocalAppDataPath : string;
Function GetTempFileName(const ext: string): string;
function GetTempDir: string;
function GetTempPath: string;
function GetWindowsPath: string;
function GetSystemPath: string;
function GetWindowsSystemDir: String;
function GetFilesInSpecifiedDirectory(const Path, Masks: string): TStringDynArray;
procedure TouchFile(FileName: string; Date: TDateTime; createIfNotExists : Boolean = False);
procedure TouchNewFile(FileName: string; Date: TDateTime);
function FormatByteSize(const bytes: Longword): string;
function getSHFileType(Filename : String) : String;
function GetFileTypeDescription(Filename: String): String;
function GetFileTypeRegKey(FileName: String; out Key: HKEY): Integer;
function GetSystemLargeFileIcons : TImageList;
function GetSystemSmallFileIcons : TImageList;
function DeleteAllFiles(FilesOrDir: string): boolean;
function GetFileSize(FilePathAndName: string): LongInt;
function CreateNewFileName(BaseFileName: String; Ext: String; AlwaysUseNumber: Boolean = True): String;
function IsFileInUse(fName : string) : boolean;

procedure SaveToTextFile(const FileName, data: String);
procedure AddToTextFile(const FileName, data: String);
function ReadFromTextFile(const FileName: String): String;


implementation

uses
  ShlObj
  , Masks
  , StrUtils
  , Classes
  ;

const
  _K  = 1024; //byte
  _B  = 1; //byte
  _KB = _K * _B; //kilobyte
  _MB = _K * _KB; //megabyte
  _GB = _K * _MB; //gigabyte

var
  SystemSmallImageList : TImageList;
  SystemLargeImageList : TImageList;


function CreateNewFileName(BaseFileName: String; Ext: String;
  AlwaysUseNumber: Boolean = True): String;
var
  DocIndex: Integer;
  FileName: String;
  FileNameFound: Boolean;
begin
  DocIndex := 1;
  Filenamefound := False;
  {if number not required and basefilename doesn't exist, use that.}
  if not(AlwaysUseNumber) and (not(fileexists(BaseFilename + ext))) then
  begin
    Filename := BaseFilename + ext;
    FilenameFound := true;
  end;
  while not (FileNameFound) do
  begin
    filename := BaseFilename + inttostr(DocIndex) + Ext;
    if fileexists(filename) then
      inc(DocIndex)
    else
      FileNameFound := true;
  end;
  Result := filename;
end;

function GetFileSize(FilePathAndName: string): LongInt;
var f : File;
begin
  result := 0;
  if FileExists(FilePathAndName) then
  begin
    AssignFile(f, FilePathAndName);
    Reset(f);
    try
      result := FileSize(f);
    finally
      CloseFile(f);
    end;
  end;
end;

function GetFileInfo(AExt : string; var AInfo : TSHFileInfo; ALargeIcon : boolean = false) : boolean;
var uFlags : integer;
begin
  FillMemory(@AInfo,SizeOf(TSHFileInfo),0);
  uFlags := SHGFI_ICON+SHGFI_TYPENAME+SHGFI_USEFILEATTRIBUTES;
  if ALargeIcon then
     uFlags := uFlags + SHGFI_LARGEICON
  else
     uFlags := uFlags + SHGFI_SMALLICON;
  result := (SHGetFileInfo(PChar(AExt),FILE_ATTRIBUTE_NORMAL,AInfo,SizeOf(TSHFileInfo),uFlags) <> 0);
end;

procedure TouchFile(FileName: string; Date: TDateTime; createIfNotExists : Boolean = False);
var
  f : THandle;
  age : Integer;
  LocalFileTime, FileTime : TFileTime;
begin
  if createIfNotExists AND (NOT FileExists(Filename)) then
    f := FileOpen(FileName, fmOpenWrite)
  else
    f := FileOpen(FileName, fmOpenReadWrite);
  try
    age := DateTimeToFileDate(Date);
    if DosDateTimeToFileTime(LongRec(Age).Hi, LongRec(Age).Lo, LocalFileTime) and
      LocalFileTimeToFileTime(LocalFileTime, FileTime) and
    SetFileTime(f, nil, nil, @FileTime) then Exit;
  finally
    FileClose(f);
  end;
//  AssignFile(TheFile, FileName);
//  if createIfNotExists AND (NOT FileExists(Filename)) then
//    Rewrite(TheFile)
//  else
//    Reset(TheFile);
//  try
//    FileSetDate( TFileRec(TheFile).Handle,
//                 DateTimeToFileDate(Date));
//  finally
//    CloseFile(TheFile);
//  end;
end;

procedure TouchNewFile(FileName: string; Date: TDateTime);
begin
  TouchFile(FileName, Date, True);
end;

function LocalAppDataPath : string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..4012] of char;
begin
  SHGetFolderPath(0,CSIDL_LOCAL_APPDATA,0,SHGFP_TYPE_CURRENT,@path[0]);
  Result := StrPas(path);
end;

// Creates a name for a temporary file.
Function GetTempFileName(const ext: string): string;
begin
  result := tPath.GetTempFileName;
  try  TFile.Delete(result); except end; // delete created file
  Result := ChangeFileExt(result, ext);
end;
function GetTempDir: string;
begin
  Result := TPath.GetTempPath;
  if Result[Length(Result)] = '\' then
    Result := Copy(Result, 1, Length(Result) - 1);
end;

function GetTempPath: string;
begin
  Result := GetTempDir;
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
end;

{ Getting the Windows Directory }

function GetWindowsPath: string;
var
  WinDir: PChar;
begin
  WinDir := StrAlloc(MAX_PATH);
  GetWindowsDirectory(WinDir, MAX_PATH);
  Result := string(WinDir);
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
  StrDispose(WinDir);
end;

function GetFilesInSpecifiedDirectory(const Path, Masks: string): TStringDynArray;
var
  MaskArray: TStringDynArray;
  Predicate: TDirectory.TFilterPredicate;
begin
  MaskArray := SplitString(Masks, ';');
  Predicate :=
    function(const Path: string; const SearchRec: TSearchRec): Boolean
    var
      Mask: string;
    begin
      for Mask in MaskArray do
        if MatchesMask(SearchRec.Name, Mask) then
          exit(True);
      exit(False);
    end;
  Result := TDirectory.GetFiles(Path, Predicate);
end;

{ Getting the System Directory }

function GetSystemPath: string;
var
  SysDir: PChar;
begin
  SysDir := StrAlloc(MAX_PATH);
  GetSystemDirectory(SysDir, MAX_PATH);
  Result := string(SysDir);
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
  StrDispose(SysDir);
end;

function GetWindowsSystemDir: String;
var
  vlBuff: Array[0..MAX_PATH-1] of Char;
begin
  getSystemDirectory(vlBuff, MAX_PATH);
  Result := vlBuff;
end;

function FormatByteSize(const bytes: Longword): string;
begin

  if bytes > _GB then
    result := FormatFloat('#.## GB', bytes / _GB)
  else
    if bytes > _MB then
      result := FormatFloat('#.## MB', bytes / _MB)
    else
      if bytes > _KB then
        result := FormatFloat('#.## KB', bytes / _KB)
      else
        result := FormatFloat('#.## Bytes', bytes) ;
end;

function getSHFileType(Filename : String) : String;
var FileInfo: SHFILEINFO;
begin
  try
    SHGetFileInfo(PChar(Filename), 0, FileInfo, SizeOf(FileInfo), SHGFI_TYPENAME);
    result := FileInfo.szTypeName;
  except
    try
      result := GetFileTypeDescription(Filename);
    except
      result := copy(UpperCase(ExtractFileExt(Filename)), 2, maxint) + ' File';
    end;
  end;
end;

function GetFileTypeDescription(Filename: String): String;
var hkExtType: HKEY;
     lpszDesc: Array [0..1024] of Char;
     dwSize: DWORD;
begin
  // Attempt to get the registry key for the extension type
  if (GetFileTypeRegKey(FileName, hkExtType) = ERROR_SUCCESS) then
  begin
     // Resource protection
     try
        // Set size of buffer
        dwSize:=SizeOf(lpszDesc);
        // Get the description for the file extension
        if (RegQueryValueEx(hkExtType, nil, nil, nil, @lpszDesc, @dwSize) = ERROR_SUCCESS) then
           // Return the description
           SetString(result, PChar(@lpszDesc), dwSize)
        else
           // Failed to get result
           SetLength(result, 0);
     finally
        // Close the registry key
        RegCloseKey(hkExtType);
     end;
  end
  else
     // Failed to get result
     SetLength(result, 0);
end;

function GetFileTypeRegKey(FileName: String; out Key: HKEY): Integer;
var hkExt: HKEY;
     lpszTypeKey: Array [0..1024] of Char;
     dwSize: DWORD;
     szExt: String;
begin
  // Get the file extension
  szExt:=ExtractFileExt(FileName);

  // Attempt to open the registry key
  result:=RegOpenKeyEx(HKEY_CLASSES_ROOT, PChar(szExt), 0, KEY_READ, hkExt);

  // Check result of open
  if (result = ERROR_SUCCESS) then
  begin
     // Resource protection
     try
        // Set size of buffer
        dwSize:=SizeOf(lpszTypeKey);
        // Query for the default value which is the redirect to the extension type key
        result:=RegQueryValueEx(hkExt, nil, nil, nil, @lpszTypeKey, @dwSize);
        // Check result
        if (result = ERROR_SUCCESS) then
        begin
           // Open the redirect to the extension type key
           result:=RegOpenKeyEx(HKEY_CLASSES_ROOT, @lpszTypeKey, 0, KEY_READ, Key);
        end
     finally
        // Close the opened key
        RegCloseKey(hkExt);
     end;
  end;

end;

function GetSystemSmallFileIcons : TImageList;
begin
  result := SystemSmallImageList;
end;

function GetSystemLargeFileIcons : TImageList;
begin
  result := SystemLargeImageList;
end;

function DeleteAllFiles(FilesOrDir: string): boolean;
{ Sends files or directory to the recycle bin. }
var F: TSHFileOpStruct;
    From: string;
    Resultval: integer;
begin
  FillChar(F, SizeOf(F), #0);
  From := FilesOrDir + #0;
  F.wnd := 0;
  F.wFunc := FO_DELETE;
  F.pFrom := PChar(From);
  F.pTo := nil;

  F.fFlags := FOF_ALLOWUNDO or
              FOF_NOCONFIRMATION or
              FOF_SILENT or //  SIMPLEPROGRESS or
              FOF_FILESONLY;

  F.fAnyOperationsAborted := False;
  F.hNameMappings := nil;
  Resultval := ShFileOperation(F);
  Result := (ResultVal = 0);
end;

function IsFileInUse(fName : string) : boolean;
var
  HFileRes : HFILE;
begin
  Result := false;
  if not FileExists(fName) then exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0) ;
  Result := (HFileRes = INVALID_HANDLE_VALUE) ;
  if not Result then CloseHandle(HFileRes) ;
end;

procedure SaveToTextFile(const FileName, data: String);
var
  stl: TStringList;
begin
  stl := TStringList.Create;
  try
    stl.text := data;
    stl.SaveToFile(FileName);
  finally
    stl.Free;
  end;
end;

procedure AddToTextFile(const FileName, data: String);
var
  stl: TStringList;
begin
  stl := TStringList.Create;
  try
    if fileExists(FileName) then
      stl.LoadFromFile(FileName);
    stl.Add(data);
    stl.SaveToFile(FileName);
  finally
    stl.Free;
  end;
end;

function ReadFromTextFile(const FileName: String): String;
var
  stl: TStringList;
begin
  result := '';
  if fileExists(FileName) then
  begin
    stl := TStringList.Create;
    try
      stl.LoadFromFile(FileName);
      result := stl.text;
    finally
      stl.Free;
    end;
  end;
end;

// ====================================================================================

var FileInfo : TSHFileInfo;

initialization

  SystemSmallImageList := TImageList.Create(nil);
  SystemSmallImageList.Handle := SHGetFileInfo('',
                          0,
                          FileInfo,
                          SizeOf(FileInfo),
                          SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  SystemLargeImageList := TImageList.Create(nil);
  SystemLargeImageList.Handle := SHGetFileInfo('',
                          0,
                          FileInfo,
                          SizeOf(FileInfo),
                          SHGFI_SYSICONINDEX or SHGFI_LARGEICON);

finalization
  SystemSmallImageList.Free;
  SystemLargeImageList.Free;
end.
