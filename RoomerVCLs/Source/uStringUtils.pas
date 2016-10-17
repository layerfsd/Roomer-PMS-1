unit uStringUtils;

interface

uses SysUtils,
  strUtils,
{$IFNDEF CONSOLE}
  Dialogs,
{$ENDIF}
  System.Generics.Collections,
  System.Classes,
  Winapi.ShlObj,
  Winapi.Windows;

type
  TArrayOfString = array of String;

function GetMIMEtype(FileName: String): String;
function EncodeURIComponent(const ASrc: string): UTF8String;
function FillPreTextWithChar(text: String; ch: char; len: Integer): String;
function FillPostTextWithChar(text: String; ch: char; len: Integer): String;
function GenerateRandomString(SLen: Integer): string;
function StringListAsCdl(list: TList<String>; delimiter: char = ';'): String;
function IntegerListAsCdl(list: TList<Integer>; delimiter: char = ';'): String;
procedure ClipboardCopy(const Str: string; iDelayMs: Integer = 500);
procedure CopyToClipboard(const Str: string; iDelayMs: Integer = 500);
procedure DebugMessage(const Str: string);
function ParameterByName(name: String): String;
function XMLEncode(const AChaine: String): String;
function XmlEncode_ex(Str: String; def: String): String;
function BoolToString(value: boolean): string;
function BoolToString_0_1(value: boolean): string;
function BoolToInteger(value: boolean): Integer;

function FloatToDBString(number: Double): String;
function FloatStringToDBString(value: String): String;
function AddLeadingZeroes(const aNumber, Length: Integer): string;
function findObject(owner: TComponent; PreName: String; index: Integer): TObject;
function KeyValueFromString(source, key: String): String;
function SplitString(const aSeparator, aString: String; aMax: Integer = 0): TArrayOfString;
procedure SplitStringToTStrings(const aSeparator, aString: String; aList: TStrings; aMax: Integer = 0); overload;
function SplitStringToTStrings(const aSeparator, aString: String; aMax: Integer = 0): TStrings; overload;
function DelChars(const S: string; Chr: char): string;
function FormattedStringToFloat(value: String): Double;
function GetWindowClassName(Window: HWND): string;
function _dbString(const aString: string): string; Overload;
function EncodeBase64(S: string): string;
function DecodeBase64(S: string): string;

implementation

uses registry
{$IFNDEF CONSOLE}
    , clipbrd
{$ENDIF}
    , uFloatUtils;

function GetMIMEtype(FileName: String): String;
var
  reg: TRegistry;
  ans: String;
  ext: string;
begin
  if LowerCase(ExtractFileExt(FileName)) = '.pdf' then
  begin
    result := 'application/pdf';
    exit;
  end;
  ans := '';
  reg := TRegistry.Create;
  try
    ext := ExtractFileExt(FileName);
    if ext <> '' then
    begin
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKeyReadOnly('\SOFTWARE\Classes\' + ext + '\') then
        ans := reg.ReadString('Content Type');
    end;
  finally
    reg.Free;
  end;

  if ans = '' then
    ans := 'application/octet-stream';
  result := ans;
end;

function FillPreTextWithChar(text: String; ch: char; len: Integer): String;
begin
  result := StringOfChar(ch, len - Length(text)) + text;
end;

function FillPostTextWithChar(text: String; ch: char; len: Integer): String;
begin
  result := text + StringOfChar(ch, len - Length(text));
end;

function EncodeURIComponent(const ASrc: string): UTF8String;
const
  HexMap: UTF8String = '0123456789ABCDEF';
  function IsSafeChar(ch: Integer): boolean;
  begin
    // if (ch >= 48) and (ch <= 57) then Result := True    // 0-9
    // else if (ch >= 65) and (ch <= 90) then Result := True  // A-Z
    // else if (ch >= 97) and (ch <= 122) then Result := True  // a-z
    // else if (ch = 33) then Result := True // !
    // else if (ch >= 39) and (ch <= 42) then Result := True // '()*
    // else if (ch >= 45) and (ch <= 46) then Result := True // -.
    // else if (ch = 95) then Result := True // _
    // else if (ch = 126) then Result := True // ~

    if ((ch >= 48) and (ch <= 57)) OR // 0-9
      ((ch >= 65) and (ch <= 90)) OR // A-Z
      ((ch >= 97) and (ch <= 122)) OR // a-z
      ((ch = 33)) OR // !
      ((ch >= 39) and (ch <= 42)) OR // '()*
      ((ch >= 45) and (ch <= 46)) OR // -.
      ((ch = 95)) OR // _
      ((ch = 126)) then
      result := true // ~
    else
      result := False;
  end;

var
  i, J: Integer;
  ASrcUTF8: UTF8String;
begin
  result := ''; { Do not Localize }

  ASrcUTF8 := UTF8Encode(ASrc);
  // UTF8Encode call not strictly necessary but
  // prevents implicit conversion warning

  i := 1;
  J := 1;
  SetLength(result, Length(ASrcUTF8) * 3); // space to %xx encode every byte
  while i <= Length(ASrcUTF8) do
  begin
    if IsSafeChar(Ord(ASrcUTF8[i])) then
    begin
      result[J] := ASrcUTF8[i];
      Inc(J);
    end
    // else if ASrcUTF8[I] = ' ' then
    // begin
    // Result[J] := '+';
    // Inc(J);
    // end
    else
    begin
      result[J] := '%';
      result[J + 1] := HexMap[(Ord(ASrcUTF8[i]) shr 4) + 1];
      result[J + 2] := HexMap[(Ord(ASrcUTF8[i]) and 15) + 1];
      Inc(J, 3);
    end;
    Inc(i);
  end;

  SetLength(result, J - 1);
end;

function StringListAsCdl(list: TList<String>; delimiter: char = ';'): String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to list.Count - 1 do
    if result = '' then
      result := list[i]
    else
      result := result + delimiter + list[i];
end;

function IntegerListAsCdl(list: TList<Integer>; delimiter: char = ';'): String;
var
  i: Integer;
begin
  result := '';
  for i := 0 to list.Count - 1 do
    if result = '' then
      result := inttostr(list[i])
    else
      result := result + delimiter + inttostr(list[i]);
end;

procedure ClipboardCopy(const Str: string; iDelayMs: Integer = 500);
const
  MaxRetries = 5;
var
  RetryCount: Integer;
begin
  for RetryCount := 1 to MaxRetries do
    try
{$IFNDEF CONSOLE}
      Clipboard.AsText := Str;
{$ENDIF}
      Break;
    except
      on Exception do
      begin
        if RetryCount = MaxRetries then
          // raise Exception.Create('Cannot set clipboard')
          raise Exception.Create('Unable to copy to clipboard')
        else
          Sleep(iDelayMs)
      end;
    end;
end;

procedure DebugMessage(const Str: string);
begin
{$IFDEF DEBUG}
{$IFNDEF CONSOLE}
  ShowMessage(Str);
{$ENDIF}
{$ENDIF}
end;

procedure CopyToClipboard(const Str: string; iDelayMs: Integer = 500);
{$IFDEF DEBUG}
const
  MaxRetries = 5;
var
  RetryCount: Integer;
{$ENDIF}
begin
{$IFDEF DEBUG}
  for RetryCount := 1 to MaxRetries do
    try
{$IFNDEF CONSOLE}
      Clipboard.AsText := Str;
{$ENDIF}
      Break;
    except
      on Exception do
      begin
        if RetryCount = MaxRetries then
          // raise Exception.Create('Cannot set clipboard')
          // raise Exception.Create('Unable to copy to clipboard')
        else
          Sleep(iDelayMs)
      end;
    end;
{$ENDIF}
end;

function ParameterByName(name: String): String;
var
  i, iNameLength: Integer;
  param: String;
begin
  result := '';
  for i := 1 to ParamCount do
  begin
    // example=value
    // 1234567890123
    // ==> Name length = 7 + 1 = 8
    // Value location = Name length + 1 = 9
    iNameLength := Length(name) + 1;
    param := ParamStr(i);
    if Lowercase(copy(param, 1, iNameLength)) = Lowercase(name) + '=' then
    begin
      result := copy(param, iNameLength + 1, Length(param));
    end;
  end;
end;

function DelChars(const S: string; Chr: char): string;
var
  i: Integer;
begin
  result := S;
  for i := Length(result) downto 1 do
  begin
    if result[i] = Chr then
      Delete(result, i, 1);
  end;
end;

function BoolToString(value: boolean): string;
begin
  if value then
    result := 'true'
  else
    result := 'false';
end;

function BoolToString_0_1(value: boolean): string;
begin
  if value then
    result := '1'
  else
    result := '0';
end;

function BoolToInteger(value: boolean): Integer;
begin
  if value then
    result := 1
  else
    result := 0;
end;

function FloatToDBString(number: Double): String;
begin
  result := FloatStringToDBString(FloatToStr(number));
end;

function _CommaToDot(S : string) : string;
begin
  Result := S;
  if pos(',', S) = 0 then
    exit;
  while pos(',', S) > 0 do
    S[pos(',', S)] := '.';
  if copy(S, 1, 1) = '.' then
    S := '0' + S;
  Result := S;
end;

function FloatStringToDBString(value: String): String;
begin
  result := _CommaToDot(value);
//  result := Trim(StringReplace(value, SystemDecimalSeparator, '.', [rfReplaceAll]));
end;

function XMLEncode(const AChaine: String): String;
var
  tempResult: String;
begin
  tempResult := AChaine;
  if posEx(tempResult, '&') >= 0 then
    tempResult := StringReplace(tempResult, '&', '&amp;', [rfReplaceAll, rfIgnoreCase]);

  if posEx(tempResult, '<') >= 0 then
    tempResult := StringReplace(tempResult, '<', '&lt;', [rfReplaceAll, rfIgnoreCase]);

  if posEx(tempResult, '>') >= 0 then
    tempResult := StringReplace(tempResult, '>', '&gt;', [rfReplaceAll, rfIgnoreCase]);

  if posEx(tempResult, '"') >= 0 then
    tempResult := StringReplace(tempResult, '"', '&quot;', [rfReplaceAll, rfIgnoreCase]);

  result := tempResult;
end;

function XmlEncode_ex(Str: String; def: String): String;
var
  len, cnt: Integer;
  outString: String;
  c: char;
begin
  if (Str = '') then
    Str := def;

  len := Length(Str); // str.Length;
  SetLength(outString, trunc(len * 1.5));
  outString := '';


  // Allow: a-z A-Z 0-9 SPACE , .
  // Allow (dec): 97-122 65-90 48-57 32 44 46

  for cnt := 1 to len do
  begin
    c := Str[cnt];
    if ((c >= #97) AND (c <= #122)) OR ((c >= #65) AND (c <= #90)) OR ((c >= #48) AND (c <= #57)) OR (c = #32) OR (c = #44) OR (c = #46) then
      // outString.Append(c)
      outString := outString + c
    else
      outString := outString + '&#' + inttostr(Ord(c)) + ';';
  end;
  result := outString;
end;

function findObject(owner: TComponent; PreName: String; index: Integer): TObject;
begin
  result := owner.FindComponent(PreName + AddLeadingZeroes(index, 2));
end;

function AddLeadingZeroes(const aNumber, Length: Integer): string;
begin
  result := SysUtils.Format('%.*d', [Length, aNumber]);
end;

function KeyValueFromString(source, key: String): String;
var
  valueData, list: TArrayOfString;
  i: Integer;
begin
  result := '';
  list := SplitString(';', source);
  for i := Low(list) to High(list) do
  begin
    valueData := SplitString('=', list[i]);
    if Lowercase(valueData[Low(valueData)]) = Lowercase(key) then
    begin
      result := valueData[Low(valueData) + 1];
      Break;
    end;
  end;
end;

function SplitString(const aSeparator, aString: String; aMax: Integer = 0): TArrayOfString;
var
  i, strt, cnt: Integer;
  sepLen: Integer;

  procedure AddString(aEnd: Integer = -1);
  var
    endPos: Integer;
  begin
    if (aEnd = -1) then
      endPos := i
    else
      endPos := aEnd + 1;

    if (strt < endPos) then
      result[cnt] := copy(aString, strt, endPos - strt)
    else
      result[cnt] := '';

    Inc(cnt);
  end;

begin
  if (aString = '') or (aMax < 0) then
  begin
    SetLength(result, 0);
    EXIT;
  end;

  if (aSeparator = '') then
  begin
    SetLength(result, 1);
    result[0] := aString;
    EXIT;
  end;

  sepLen := Length(aSeparator);
  SetLength(result, (Length(aString) div sepLen) + 1);

  i := 1;
  strt := i;
  cnt := 0;
  while (i <= (Length(aString) - sepLen + 1)) do
  begin
    if (aString[i] = aSeparator[1]) then
      if (copy(aString, i, sepLen) = aSeparator) then
      begin
        AddString;

        if (cnt = aMax) then
        begin
          SetLength(result, cnt);
          EXIT;
        end;

        Inc(i, sepLen - 1);
        strt := i + 1;
      end;

    Inc(i);
  end;

  AddString(Length(aString));

  SetLength(result, cnt);
end;


function SplitStringToTStrings(const aSeparator, aString: String; aMax: Integer = 0): TStrings;
begin
  result := TStringList.Create;
  SplitStringToTStrings(aSeparator, aString, Result, aMax);
end;

procedure SplitStringToTStrings(const aSeparator, aString: String; aList: TStrings; aMax: Integer = 0);
var
  strt: Integer;
  S, sTemp: String;
begin
  Assert(assigned(aList), 'SplitStringToTStrings must called with assigned aList');

  aList.Clear;
  S := aString;
  if S <> '' then
  begin
    if pos(aSeparator, S) = 0 then
      aList.Add(S)
    else
    begin
      S := S + aSeparator;
      strt := pos(aSeparator, S);
      while strt > 0 do
      begin
        sTemp := copy(S, 1, strt - 1);
        aList.Add(sTemp);
        S := copy(S, strt + Length(aSeparator), Length(S));
        strt := pos(aSeparator, S);
      end;
    end;
  end;
end;

function FormattedStringToFloat(value: String): Double;
begin
  value := StringReplace(value, SystemThousandsSeparator, '', [rfReplaceAll]);
  result := LocalizedFloatValue(value);
end;

// function LocalizedFloatValue(value : String; save : boolean = true): Double;
// var s : String;
// begin
// s := Trim(
// StringReplace(
// StringReplace(value, '.', SystemDecimalSeparator, [rfReplaceAll])
// , ',', SystemDecimalSeparator, [rfReplaceAll])
// );
// if save then
// result := StrToFloatDef(StringReplace(s,
// '.',
// SystemDecimalSeparator,
// [rfReplaceAll]),
// 0)
// else
// result := StrToFloat(StringReplace(s,
// '.',
// SystemDecimalSeparator,
// [rfReplaceAll])
// );
// end;

function GetWindowClassName(Window: HWND): string;
const
  MaxClassNameLength = 257; // 256 plus null terminator
var
  Buffer: array [0 .. MaxClassNameLength - 1] of char;
  len: Integer;
begin
  len := GetClassName(Window, Buffer, Length(Buffer));
  if len = 0 then
    RaiseLastOSError;
  SetString(result, Buffer, len);
end;

function RoomerQuotedString(S: String): String;
begin
  if S = '' then
    S := ''''''
  else
  begin
    if copy(S, 1, 1) <> #39 then
      S := #39 + S;
    if copy(S, Length(S), 1) <> #39 then
      S := S + #39;
  end;
  result := S;
end;

function _dbString(const aString: string): string; Overload;
begin
  result := RoomerQuotedString(StringReplace(aString, #39, '\' + #39, [rfReplaceAll]));
end;

function GenerateRandomString(SLen: Integer): string;
var
  Str: string;
begin
  Randomize;
  // string with all possible chars
  Str := 'abcdefghijklmnopqrstuvwxyz01234567890+-ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  result := '';
  repeat
    result := result + Str[Random(Length(Str)) + 1];
  until (Length(result) = SLen) end;

  const
    Cod = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

  function EncodeBase64(S: string): string;
  var
    i, a, b, x: Integer;
  begin
    a := 0;
    b := 0;
    for i := 1 to Length(S) do
    begin
      x := Ord(S[i]);
      b := b * 256 + x;
      Inc(a, 8);
      while a >= 6 do
      begin
        dec(a, 6);
        x := b div (1 shl a);
        b := b mod (1 shl a);
        result := result + Cod[x + 1];
      end;
    end;
    if a > 0 then
    begin
      x := b shl (6 - a);
      result := result + Cod[x + 1];
    end;
  end;

  function DecodeBase64(S: string): string;
  var
    i, a, b, x: Integer;
  begin
    a := 0;
    b := 0;
    for i := 1 to Length(S) do
    begin
      x := pos(S[i], Cod) - 1;
      if x >= 0 then
      begin
        b := b * 64 + x;
        Inc(a, 6);
        if a >= 8 then
        begin
          dec(a, 8);
          x := b shr a;
          b := b mod (1 shl a);
          x := x mod 256;
          result := result + Chr(x);
        end;
      end
      else
        EXIT;
    end;
  end;


end.
