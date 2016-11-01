unit uStandaloneRoomerVersionInfo;

interface

type
  TRoomerVersionInfo = class
  private
    type
      TEXEVersionData = record
        CompanyName: string;
        FileDescription: string;
        FileMajor: integer;
        FileMinor: integer;
        FileRelease: integer;
        FileBuild: integer;
        FileVersion: string;
        InternalName: string;
        LegalCopyright: string;
        LegalTrademarks: string;
        OriginalFileName: string;
        ProductName: string;
        ProductMajor: integer;
        ProductMinor: integer;
        ProductRelease: integer;
        ProductBuild: integer;
        ProductVersion: string;
        Comments: string;
        PrivateBuild: boolean;
        PreRelease: boolean;
        IsDebug: boolean;
        SpecialBuild: string;
        DBversion: string;
        ExtraBuild : string;
      end;

    class var FVersionData: TExeVersionData;
    class var FIsInitialized: boolean;

    class function GetEXEVersionData: TExeVersionData; static;
    class function GetPreRelease: boolean; static; {$ifndef DEBUG} inline; {$endif}
    class function GetDebug: boolean; static;  {$ifndef DEBUG} inline; {$endif}
    class function GetFileVersion: string; static; {$ifndef DEBUG} inline; {$endif}
    class function GetExtraBuild: string; static;  {$ifndef DEBUG} inline; {$endif}

    class procedure RetrieveVersionInfo;
    class property VersionData: TExeVersionData read GetEXEVersionData;
  public
    class property FileVersion: string read GetFileVersion;
    class property ExtraBuild: string read GetExtraBuild;
    class property IsPreRelease: boolean read GetPreRelease;
    class property IsDebug: boolean read GetDebug;

    /// <summary>
    ///   Returns version string containing 'Version ' + fileversion appended with ExtraBuild, and IsPreRelease or IsDebug options
    /// </summary>
    class function LongVersionString: string; static;
    /// <summary>
    ///   Returns version string containing 'Ver.:' + fileversion
    /// </summary>
    class function ShortVersionString: string; static;
  end;


implementation

uses
  Windows
  , Classes
  , SysUtils
  , IOUtils
  ;

{ TRoomerVersionInfo }

class function TRoomerVersionInfo.GetDebug: boolean;
begin
  Result := VersionData.IsDebug;
end;

class function TRoomerVersionInfo.GetEXEVersionData: TExeVersionData;
begin
  if not FIsInitialized then
    RetrieveVersionInfo;
  Result := FVersionData;
end;

class function TRoomerVersionInfo.GetExtraBuild: string;
begin
  Result := VersionData.ExtraBuild;
end;

class function TRoomerVersionInfo.GetFileVersion: string;
begin
  Result := VersionData.FileVersion;
end;


class function TRoomerVersionInfo.GetPreRelease: boolean;
begin
  Result := VersionData.PreRelease;
end;

class procedure TRoomerVersionInfo.RetrieveVersionInfo;
type
  TLandCodepage = record
    wLanguage, wCodePage : word;
  end;
  PLandCodepage = ^TLandCodepage;

var
    fileInformation: PVSFIXEDFILEINFO;
    len: Cardinal;
    rs: TResourceStream;
    m: TMemoryStream;
    pntr: Pointer;
    lang: string;
begin
  // Load resource info from memory in stead of from EXE file, as the EXE file could be renamed or unreachable after loading
  //Workaround bug in Delphi if resource doesn't exist
  if FindResource(HInstance, '#1', RT_VERSION) = 0 then
     RaiseLastOSError;

  m := TMemoryStream.Create;
  try
    rs := TResourceStream.CreateFromID(HInstance, 1, RT_VERSION);
    try
      m.CopyFrom(rs, rs.Size);
    finally
      rs.Free;
    end;

    m.Position:=0;
    if VerQueryValue(m.Memory, '\', Pointer(fileInformation), len) then
      with FVersionData do
      begin
        FileMajor := fileInformation.dwFileVersionMS shr 16;
        FileMinor := fileInformation.dwFileVersionMS and $FFFF;
        FileRelease := fileInformation.dwFileVersionLS shr 16;
        FileBuild := fileInformation.dwFileVersionLS and $FFFF;

        ProductMajor := fileInformation.dwProductVersionMS shr 16;
        ProductMinor := fileInformation.dwProductVersionMS and $FFFF;
        ProductRelease := fileInformation.dwProductVersionLS shr 16;
        ProductBuild := fileInformation.dwProductVersionLS and $FFFF;

        PrivateBuild := fileInformation.dwFileFlags and VS_FF_PRIVATEBUILD <> 0;
        PreRelease :=  fileInformation.dwFileFlags and VS_FF_PRERELEASE <> 0;
        IsDebug := fileInformation.dwFileFlags and VS_FF_DEBUG <> 0;
      end;

    if not VerQueryValue(m.memory, '\VarFileInfo\Translation\', pntr, len) then
      RaiseLastOSError;

    lang := Format('%.4x%.4x', [PLandCodepage(pntr)^.wLanguage, PLandCodepage(pntr)^.wCodePage]);

    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\CompanyName'), pntr, len) then
      FVersionData.CompanyName := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\FileDescription'), pntr, len) { and (@len <> nil) } then
      FVersionData.FileDescription := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\FileVersion'), pntr, len) { and (@len <> nil) } then
      FVersionData.FileVersion := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\InternalName'), pntr, len) { and (@len <> nil) } then
      FVersionData.InternalName := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\LegalCopyright'), pntr, len) { and (@len <> nil) } then
      FVersionData.LegalCopyright := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\LegalTrademarks'), pntr, len) { and (@len <> nil) } then
      FVersionData.LegalTrademarks := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\OriginalFileName'), pntr, len) { and (@len <> nil) } then
      FVersionData.OriginalFileName := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\ProductName'), pntr, len) { and (@len <> nil) } then
      FVersionData.ProductName := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\ProductVersion'), pntr, len) { and (@len <> nil) } then
      FVersionData.ProductVersion := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\Comments'), pntr, len) { and (@len <> nil) } then
      FVersionData.Comments := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\SpecialBuild'), pntr, len) { and (@len <> nil) } then
      FVersionData.SpecialBuild := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\DBversion'), pntr, len) { and (@len <> nil) } then
      FVersionData.DBversion := PChar(pntr);
    if VerQueryValue(m.Memory, PChar('\StringFileInfo\' + lang + '\ExtraBuild'), pntr, len) { and (@len <> nil) } then
      FVersionData.ExtraBuild := PChar(pntr);


  finally
    m.Free;
  end;

  FIsInitialized := True;
end;

class function TRoomerVersionInfo.ShortVersionString: string;
begin
  Result := 'Version' + FileVersion; // GetTranslatedText('sh0070') + FileVersion;
end;

class function TRoomerVersionInfo.LongVersionString: string;
begin
  Result := Format('Ver %s [%s]', [FileVersion, ExtraBuild]);
  if IsPreRelease then
    Result := Result + ' [pre-release]';
  if IsDebug then
    Result := Result + ' [debug]';
end;

end.
