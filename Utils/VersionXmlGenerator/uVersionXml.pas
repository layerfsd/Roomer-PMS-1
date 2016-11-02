unit uVersionXml;

interface

uses Winapi.Windows, System.Classes, System.Types, System.AnsiStrings, System.SysUtils, System.IOUtils;

procedure GenerateXml(const location : String);
function GetVersion(sFileName:string): string;

implementation

const xml = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>' + #13#10 +
            '<files>' + #13#10 +
            '  %s' +
            '</files>';
const xmlFile = '  <file version="%s" filename="%s" />' + #13#10;

procedure GenerateXml(const location : String);
var list : TStringDynArray;
    i: Integer;
    fileList : TStrings;
begin
  fileList := TStringList.Create;
  try
    list := TDirectory.GetFiles(location);

    for i := LOW(list) to HIGH(list) do
    begin
      if Lowercase(ExtractFileExt(list[i])) = '.exe' then
        if (Copy(Lowercase(ExtractFilename(list[i])), 1, 6) = 'roomer') then
             if GetVersion(list[i]) <> '' then
               fileList.Add(format(xmlFile, [GetVersion(list[i]), ExtractFilename(list[i])]));
    end;
    writeln(format(xml, [fileList.Text]));
  finally
    fileList.Free;
  end;

end;

function GetVersion(sFileName:string): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  result := '';
  try
  VerInfoSize := GetFileVersionInfoSize(PChar(sFileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(sFileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
  Except end;
end;

end.
