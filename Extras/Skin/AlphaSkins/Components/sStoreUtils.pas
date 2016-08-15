unit sStoreUtils;
{$I sDefs.inc}
//+
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, registry, inifiles,
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFDEF USEDB} db, dbgrids, {$ENDIF}
  acntUtils;

  
// Work with Windows registry and ini
function  ReadRegString (Key: HKEY; const Section, Named: string): string;
procedure WriteRegString(Key: HKEY; const Section, Named, Value: string);
procedure DeleteRegParam(Key: HKEY; const Section, Named: string);
procedure WriteRegInteger(const Section, Named: string; Value: integer);
function ReadIniInteger  (const Section, Named: string; Value: integer; const FileName: string): integer; overload;
function ReadIniInteger  (const Section, Named: string; Value: integer; r: TMemIniFile): integer; overload;
function ReadIniString   (const Section, Named: string; r: TMemIniFile): string; overload;
function ReadIniString   (const Section, Named, FileName: string): string; overload;
procedure ReadIniStrings(Value: TStrings; const Section, Named, FileName: string); overload;
procedure ReadIniStrings(Value: TStrings; const Section, Named: string; r: TMemIniFile); overload;

procedure WriteIniStr(const Section, Named, Value, FileName:string); overload;
procedure WriteIniStr(const Section, Named, Value: string; IniFile: TMemIniFile); overload;
procedure WriteIniStrings(const Section, Named, FileName: string; Value: TStrings); overload;
procedure WriteIniStrings(const Section, Named: string; Value: TStrings; IniFile: TMemIniFile); overload;
procedure WriteIniFont(const Section, Named: string; Value: TFont; IniFile: TMemIniFile); overload;
procedure ReadIniFont (const Section, Named: string; Value: TFont; IniFile: TMemIniFile); overload;

procedure ReadSection(Src, Dest: TStringList; const Name: string);
function ReadValue(Src: TStringList; const Section, ValueName: string): string;

implementation

uses
  sConst;


function ReadIniString(const Section, Named, FileName: string): string;
var
  r: TIniFile;
  s: string;
begin
  r := TIniFile.Create(FileName);
  try
    s := r.ReadString(Section,Named,'');
  finally
    r.Free;
  end;
  Result := s;
end;


function ReadIniString(const Section, Named: string; r: TMemIniFile): string;
var
  s: string;
begin
  try
    s := r.ReadString(Section, Named, '');
  finally
    Result := s;
  end;
end;


function ReadIniInteger(const Section, Named: string; Value: integer; r: TMemIniFile): integer; overload;
var
  s: string;
begin
  Result := 0;
  if Assigned(r) then begin
    s := r.ReadString(Section,Named, '');
    try
      if s = '' then
        Result := Value
      else
        Result := StrToInt(s);
    except
      Result := -1;
    end;
  end;
end;


procedure ReadIniStrings(Value: TStrings; const Section, Named: string; r: TMemIniFile); overload;
var
  i, c: integer;
begin
  c := ReadIniInteger(Section, Named + 'Count', 0, r);
  if c > 0 then begin
    Value.Clear;
    for i := 0 to c - 1 do
      Value.Add(ReadIniString(Section, Named + 'Item' + IntToStr(i), r));
  end;
end;


procedure ReadIniStrings(Value: TStrings; const Section, Named, FileName: string); overload;
var
  r: TMemIniFile;
begin
  r := TMemIniFile.Create(FileName);
  try
    ReadIniStrings(Value, Section, Named, r);
  finally
    r.Free;
  end;
end;


function ReadIniInteger(const Section, Named: string; Value: integer; const FileName: string): integer;
var
  r: TIniFile;
  s: string;
begin
  r := TIniFile.Create(FileName);
  try
    s := r.ReadString(Section,Named, '');
  finally
    r.Free;
  end;
  try
    if s = '' then
      Result := Value
    else
      Result := StrToInt(s);
  except
    Result := -1;
  end;
end;


function ReadRegString(Key: HKEY; const Section, Named: string): string;
var
  r: TRegIniFile;
begin
  Result := '';
  r := TRegIniFile.Create('');
  r.RootKey := Key;
  try
    Result := r.ReadString(Section, Named, '');
  finally
    r.Free;
  end;
end;


procedure WriteRegString(Key: HKEY; const Section, Named, Value: string);
var
  r: TRegIniFile;
begin
  r := TRegIniFile.Create('');
  r.RootKey := Key;
  try
    r.CreateKey(Section);
    r.WriteString(Section, Named, Value);
  finally
    r.Free;
  end;
end;


procedure DeleteRegParam(Key: HKEY; const Section, Named: string);
var
  r: TRegIniFile;
begin
  r := TRegIniFile.Create('');
  r.RootKey := Key;
  try
    r.DeleteKey(Section, Named);
  finally
    r.Free;
  end;
end;


procedure WriteRegInteger(const Section, Named: string; Value: integer);
var
  r: TRegIniFile;
begin
  r := TRegIniFile.Create('');
  r.RootKey := HKEY_CURRENT_USER;
  try
    r.CreateKey(Section);
    r.WriteInteger(Section, Named, Value);
  finally
    r.Free;
  end;
end;


procedure WriteIniStr(const Section, Named, Value, FileName: string); overload;
var
  r: TIniFile;
begin
  r := TIniFile.Create(FileName);
  try
    if r <> nil then
      r.WriteString(Section, Named, Value);
  finally
    r.Free;
  end;
end;


procedure WriteIniStr(const Section, Named, Value: string; IniFile: TMemIniFile);
begin
  IniFile.WriteString(Section, Named, Value);
end;


procedure WriteIniStrings(const Section, Named: string; Value: TStrings; IniFile: TMemIniFile); overload;
var
  i: integer;
begin
  WriteIniStr(Section, Named + 'Count', IntToStr(Value.Count), IniFile);
  for i := 0 to Value.Count - 1 do
    WriteIniStr(Section, Named + 'Item' + IntToStr(i), Value[i], IniFile);
end;


procedure WriteIniStrings(const Section, Named, FileName: string; Value: TStrings); overload;
var
  r: TMemIniFile;
begin
  r := TMemIniFile.Create(FileName);
  try
    if r <> nil then
      WriteIniStrings(Section, Named, Value, r);
  finally
    r.UpdateFile;
    r.Free;
  end;
end;


procedure WriteIniFont(const Section, Named: string; Value: TFont; IniFile: TMemIniFile); overload;
begin
  WriteIniStr(Section, Named + '_Name',      Value.Name, IniFile);
  WriteIniStr(Section, Named + '_Color',     IntToStr(Value.Color),                         IniFile);
  WriteIniStr(Section, Named + '_Size',      IntToStr(Value.Size),                          IniFile);
  WriteIniStr(Section, Named + '_Bold',      IntToStr(integer(fsBold      in Value.Style)), IniFile);
  WriteIniStr(Section, Named + '_Italic',    IntToStr(integer(fsItalic    in Value.Style)), IniFile);
  WriteIniStr(Section, Named + '_Underline', IntToStr(integer(fsUnderline in Value.Style)), IniFile);
  WriteIniStr(Section, Named + '_StrikeOut', IntToStr(integer(fsStrikeOut in Value.Style)), IniFile);
end;


procedure ReadIniFont(const Section, Named: string; Value: TFont; IniFile: TMemIniFile); overload;
begin
  Value.Color := ReadIniInteger(Section, Named + '_Color', 0, IniFile);
  Value.Name := ReadIniString(Section, Named + '_Name', IniFile);
  Value.Size := ReadIniInteger(Section, Named + '_Size', 8, IniFile);
  if ReadIniInteger(Section, Named + '_Bold', 0, IniFile) = 1 then
    Value.Style := Value.Style + [fsBold];

  if ReadIniInteger(Section, Named + '_Italic', 0, IniFile) = 1 then
    Value.Style := Value.Style + [fsItalic];

  if ReadIniInteger(Section, Named + '_Underline', 0, IniFile) = 1 then
    Value.Style := Value.Style + [fsUnderline];

  if ReadIniInteger(Section, Named + '_StrikeOut', 0, IniFile) = 1 then
    Value.Style := Value.Style + [fsStrikeOut];
end;


procedure ReadSection(Src, Dest: TStringList; const Name: string);
var
  i, j: Integer;
  sName: string;
begin
  Dest.BeginUpdate;
  try
    Dest.Clear;
    sName := '[' + Name + ']';
    for i := 0 to Src.Count - 1 do if Src[i] = sName then
      for j := i + 1 to Src.Count - 1 do
        if (Length(Src[j]) > 0) and (Src[j][1] <> '[') then
          Dest.Add(Src[j])
        else
          Exit;
  finally
    Dest.EndUpdate;
  end;
end;


function ReadValue(Src: TStringList; const Section, ValueName: string): string;
var
  i, j: Integer;
  sName: string;
begin
  sName := UpperCase('[' + Section + ']');
  for i := 0 to Src.Count - 1 do if Src[i] = sName then begin
    for j := i + 1 to Src.Count - 1 do
      if (Length(Src[j]) > 0) and (ExtractWord(1, Src[j], [s_Space, '=']) = ValueName) then begin
        Result := ExtractWord(2, Src[j], ['=']);
        Exit;
      end;

    Exit;
  end;
end;

end.

