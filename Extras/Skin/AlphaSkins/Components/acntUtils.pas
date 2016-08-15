unit acntUtils;
{$I sDefs.inc}
//+

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ShellAPI,
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFDEF TNTUNICODE} TntSysUtils, {$IFNDEF D2006} TntWideStrings, {$ELSE} WideStrings, {$ENDIF} TntClasses, {$ENDIF}
  sConst;


{$IFNDEF NOTFORHELP}
type
{$IFDEF TNTUNICODE}
  TacSearchRec  = TSearchRecW;
  TacStrings    = TWideStrings;
  TacStringList = TTntStringList;
  TacWIN32FindData = TWin32FindDataW;
{$else}
  TacSearchRec  = TSearchRec;
  TacStrings    = TStrings;
  TacStringList = TStringList;
  TacWIN32FindData = TWin32FindData;
{$ENDIF}


procedure Alert; overload;
procedure Alert(const s: string); overload;
procedure Alert(const i: integer); overload;
function CustomRequest(const s: string): boolean;
function DeleteRequest: boolean; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
{ Show message with icon mtWarning}
procedure ShowWarning(const S: string);
{ Show message with icon mtError}
procedure ShowError(const s: string);
function IsNTFamily: boolean;
function MakeCacheInfo(const aBmp: TBitmap; const xOffs: integer = 0; const yOffs: integer = 0): TCacheInfo;
function AddChar(const C: AnsiChar; const S: AnsiString; const N: Integer): AnsiString;
function acCharIn(const C: acChar; const SysCharSet: TSysCharSet): Boolean;
{ Returns formated string, represented float value}
function FormatFloatStr(const S: AnsiString; const Thousands: Boolean): string;
function GetCaptionFontSize: integer;
function acGetTitleFont: hFont;
function HexToInt(HexStr: AnsiString): Int64;

procedure GetIniSections(const IniList, SectionsList: TStringList);
function ReadIniString(IniList, SectionsList: TStringList; const Section, Ident, Default: string): string;
function ReadIniInteger(IniList, SectionsList: TStringList; const Section, Ident: string; Default: Longint): Longint;
function ReadRegInt(Key: HKEY; const Section, Named: string): integer;

function MakeMessage(const aMsg: Longint; const aWParam: WPARAM; const aLParam: LPARAM; const aResult: LRESULT): TMessage;
{ Returns percent i2 of i1}
function SumTrans(const i1, i2: integer): integer;
{ Returns max value from i1 and i2}
function Maxi(const i1, i2: integer): integer;
{ Returns min value from i1 and i2}
function Mini(const i1, i2: integer): integer;
{ Set value to Minvalue or Maxvalue if it not placed between them}
function LimitIt(const Value, MinValue, MaxValue: integer): integer;
{ Returns True if Value is valid float}
function IsValidFloat(const Value: AnsiString; var RetValue: Extended): Boolean;
function IsValidIndex(Value, Amount: integer; First: integer = 0): Boolean;

function acGetAnimation: Boolean;
procedure acSetAnimation(const Value: Boolean);
function RectIsVisible(const ParentRect, Rect: TRect): boolean;
function RectInRect(BigRect, SmallRect: TRect): boolean;
function RotateRect(R: TRect): TRect;
function RectsAnd(const R1, R2: TRect): TRect;
function SumRects(const R1, R2: TRect): TRect;

function MkRect(Right: integer = 0; Bottom: integer = 0; Left: integer = 0; Top: integer = 0): TRect; overload;
function MkRect(Bmp: TBitmap): TRect; overload;
function MkRect(Ctrl: TControl): TRect; overload;
function MkRect(Size: TSize): TRect; overload;

function MkSize(Width: integer = 0; Height: integer = 0): TSize; overload;
function MkSize(Bmp: TBitmap): TSize; overload;
function MkSize(R: TRect): TSize; overload;

function MkPoint(const X: integer = 0; const Y: integer = 0): TPoint; overload;
function MkPoint(Control: TControl): TPoint; overload;

function OffsRect(const aRect: TRect; aOffset: integer): TRect; overload;
function OffsRect(const aRect: TRect; aOffsetX, aOffsetY: integer): TRect; overload;
{ Returns width of rectangle}
function WidthOf(const r: TRect; const CheckNegative: boolean = False): integer;
{ Returns height of rectangle}
function HeightOf(const r: TRect; const CheckNegative: boolean = False): integer;
{ Returns string s1 if L, else return s2}
function iff(const L: boolean; const s1, s2: string): string; overload;
function iff(const L: boolean; const o1, o2: TObject): TObject; overload;
function iff(const L: boolean; const i1, i2: integer): integer; overload;
function iff(const L: boolean; const b1, b2: boolean): boolean; overload;
{ Returns position of word number N in string S. WordDelims - chars, word delimiters}
function acWordPosition(const N: Integer; const S: acString; const WordDelims: TSysCharSet): Integer;
function WordPosition(const N: Integer; const S: AnsiString; const WordDelims: TSysCharSet): Integer;
function GetWordNumber(const W, S: string; const WordDelims: TSysCharSet): integer;
{ Returns count of words in string S. WordDelims - chars, word delimiters}
function acWordCount(const S: acString; const WordDelims: TSysCharSet): Integer;
function WordCount(const S: AnsiString; const WordDelims: TSysCharSet): Integer;
{ Returns string with length N, filled by character C}
function MakeStr(C: AnsiChar; N: Integer): AnsiString;
{ Replace substring Srch in string S by substring Replace}
function ReplaceStr(const S, Srch, Replace: string): string;
{ Returns False if S include EmptyChars only}
function IsEmptyStr(const S: AnsiString; const EmptyChars: TSysCharSet): Boolean;
function IsIDERunning: boolean;
function IsWOW64Proc: Windows.bool;
{$ENDIF}

{ Returns True if value placed berween i1 and i2}
function Between(const Value, i1, i2: integer; Abs: boolean = False): boolean;
{ Change values of i1 and i2}
procedure Changei(var i1, i2: integer);
{ Delay in milliseconds}
procedure Delay(const MSecs: Integer);
{ Returns string with deleted spaces}
function DelRSpace(const S: string): string;
{ Returns string with deleted leading spaces}
function DelBSpace(const S: string): string;
{ Returns string with deleted last spaces}
function DelESpace(const S: string): string;
{ Returns string with deleted chars Chr}
function DelChars(const S: string; Chr: Char): string;
{ Returns substring from position Pos}
function ExtractSubStr(const S: AnsiString; var Pos: Integer; const Delims: TSysCharSet): string;
{ Returns word number N from string S. WordDelims - chars, word delimiters}
function ExtractWord(const N: Integer; const S: AnsiString; const WordDelims: TSysCharSet): AnsiString;
function acExtractWord(const N: Integer; const S: acString; const WordDelims: TSysCharSet): acString;
// Properties
function  HasProperty    (const Component: TObject; const PropName: String): Boolean;
function  GetIntProp     (const Component: TObject; const PropName: String): Integer;
procedure SetIntProp     (const Component: TObject; const PropName: String; const Value: Integer);
function  GetObjProp     (const Component: TObject; const PropName: String): TObject;
{$IFNDEF FPC}
function  CheckSetProp   (const Component: TObject; const PropName, Value: String): Boolean;
function  SetSetPropValue(const Component: TObject; const PropName, ValueName: String; const Value: boolean): Boolean;
{$ENDIF}

{ ************************************** }
{ String-handling procedures and function }

function acSameText(const S1, S2: ACString): Boolean;
procedure acFillString(var S: acString; const nCount: Integer; const C: acChar);

{ File-handling procedures and functions }
function GetAppPath: ACString;
function NormalDir(const DirName: ACString): ACString;
function ClearDir(const Path: ACString; Delete: Boolean): Boolean;

function acCreateDir(const DirName: acString): Boolean;
function acRemoveDir(const DirName: acString): Boolean;
function acSetCurrentDir(const DirName: ACString): Boolean;
function acDirExists(const Name: ACString): Boolean;
function acDeleteFile(const FileName: ACString): Boolean;
function acCopyFile(const ExistingFileName, NewFileName: ACString; bFailIfExists: Boolean): Boolean;
function acFileSetAttr(const FileName: ACString; Attr: Cardinal): Integer;
function acFindFirst(const Path: ACString; Attr: Integer; var F: TacSearchRec): Integer;
function acFindNext(var F: TacSearchRec): Integer;
procedure acFindClose(var F: TacSearchRec);

function acFindNextFile(hFindFile: THandle; var lpFindFileData: TacWIN32FindData): BOOL;
function acFindFirstFile(lpFileName: PacChar; var lpFindFileData: TacWIN32FindData): THandle;

{ Returns True if FileName is valid}
function ValidFileName(const FileName: ACString): Boolean;
{ Returns long file name from short}
function ShortToLongFileName(const ShortName: ACString): ACString;
{ Returns long path from short}
function ShortToLongPath(const ShortName: ACString): ACString;
{ Returns short file name from long}
function LongToShortFileName(const LongName: ACString): ACString;
{ Returns short path from long}
function LongToShortPath(const LongName: ACString): ACString;
function GetIconForFile(const FullFileName: ACString; Flag: integer): TIcon;
{$IFNDEF D2009}
function CharInSet(const C: AnsiChar; const CharSet: TSysCharSet): Boolean;
{$ENDIF}
{$IFNDEF NOTFORHELP}
procedure InitSysProc;
{$ENDIF}

var
//{$IFDEF DELPHI_XE3}
//  acSHGetFileInfo: function (pszPath: LPCWSTR; dwFileAttributes: DWORD; var psfi: TSHFileInfo; cbFileInfo, uFlags: UINT): DWORD_PTR; stdcall;
//{$ELSE}
  acSHGetFileInfo: function (pszPath: PacChar; dwFileAttributes: DWORD; var psfi: TSHFileInfo; cbFileInfo, uFlags: UINT): LongWord; stdcall;
//{$ENDIF}


implementation

uses
  Dialogs, Math, TypInfo, Registry,
  {$IFDEF TNTUNICODE} TntSystem, TntWindows, TntWideStrUtils,{$ENDIF}
  {$IFNDEF ALITE}sDialogs, {$ENDIF}
  sSkinProvider, acntTypes;


var
  IsDebuggerPresent: function: Boolean; stdcall;
  IsWow64Process: function (hProc: THandle; out Is64: Windows.bool): Windows.Bool; stdcall;


function GetCaptionFontSize: integer;
var
  NonClientMetrics: {$IFDEF TNTUNICODE}TNonClientMetricsW{$ELSE}TNonClientMetrics{$ENDIF};
begin
  NonClientMetrics.cbSize := {$IFDEF D2010}TNonClientMetrics.SizeOf{$ELSE}SizeOf(NonClientMetrics){$ENDIF};
  if {$IFDEF TNTUNICODE}SystemParametersInfoW{$ELSE}SystemParametersInfo{$ENDIF}(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Result := NonClientMetrics.lfCaptionFont.lfHeight
  else
    Result := 0;
end;


function acGetTitleFont: hFont;
var
  NonClientMetrics: {$IFDEF TNTUNICODE}TNonClientMetricsW{$ELSE}TNonClientMetrics{$ENDIF};
begin
  NonClientMetrics.cbSize := {$IFDEF D2010}TNonClientMetrics.SizeOf{$ELSE}SizeOf(NonClientMetrics){$ENDIF};
{$IFDEF TNTUNICODE}
  if SystemParametersInfoW(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Result := CreateFontIndirectW(NonClientMetrics.lfCaptionFont)
{$ELSE}
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Result := CreateFontIndirect(NonClientMetrics.lfCaptionFont)
{$ENDIF}
  else
    Result := 0;
end;


function HexToInt(HexStr: AnsiString): Int64;
var
  i: byte;
begin
  if HexStr <> '' then begin
    HexStr := UpperCase(HexStr);
    if HexStr[length(HexStr)] = 'H' then
      Delete(HexStr,length(HexStr),1);

    Result := 0;
    for i := 1 to length(HexStr) do begin
      Result := Result shl 4;
      if CharInSet(HexStr[i], [ZeroChar..'9']) then
        Result := Result + (byte(HexStr[i]) - 48)
      else
        if CharInSet(HexStr[i], ['A'..'F']) then
          Result := Result + (byte(HexStr[i]) - 55)
        else begin
          Result := 0;
          break;
        end;
    end;
  end
  else
    Result := 0;
end;


procedure GetIniSections(const IniList, SectionsList: TStringList);
var
  S: string;
  I: Integer;
  Strings: TStrings;
begin
  SectionsList.Clear;
  Strings := nil;
  for I := 0 to IniList.Count - 1 do begin
    S := IniList[I];
    if (S <> '') and (S[1] <> ';') then
      if (S[1] = '[') and (S[Length(S)] = ']') then begin
        Strings := TStringList.Create;
        try
          SectionsList.AddObject(Copy(S, 2, Length(S) - 2), Strings);
        except
          FreeAndNil(Strings);
        end;
      end
      else
        if Strings <> nil then
          Strings.Add(S);
  end;
end;


function ReadIniString(IniList, SectionsList: TStringList; const Section, Ident, Default: string): string;
var
  I: Integer;
  Strings: TStrings;
begin
  I := SectionsList.IndexOf(Section);
  if I >= 0 then begin
    Strings := TStrings(SectionsList.Objects[I]);
    I := Strings.IndexOfName(Ident);
    if I >= 0 then begin
      Result := Copy(Strings[I], Length(Ident) + 2, Maxint);
      Exit;
    end;
  end;
  Result := Default;
end;


function ReadIniInteger(IniList, SectionsList: TStringList; const Section, Ident: string; Default: Longint): Longint;
var
  IntStr: string;
begin
  IntStr := ReadIniString(IniList, SectionsList, Section, Ident, '');
  if (Length(IntStr) > 2) and (IntStr[1] = ZeroChar) and ((IntStr[2] = 'X') or (IntStr[2] = 'x')) then
    IntStr := '$' + Copy(IntStr, 3, Maxint);

  Result := StrToIntDef(IntStr, Default);
end;


function ReadRegInt(Key: HKEY; const Section, Named: string): integer;
var
  r: TRegistry;
begin
  Result := 0;
  r := TRegistry.Create;
  r.RootKey := Key;
  try
    if r.KeyExists(Section) then begin
      r.OpenKey(Section, False);
      if r.ValueExists(Named) then
        Result := r.ReadInteger(Named)
    end;
  finally
    r.Free;
  end;
end;


procedure Alert;
begin
  ShowWarning('Alert');
end;


procedure Alert(const s: string); overload;
begin
  ShowWarning(s);
end;


procedure Alert(const i: integer); overload;
begin
  ShowWarning(IntToStr(i));
end;


function MakeMessage(const aMsg: Longint; const aWParam: WPARAM; const aLParam: LPARAM; const aResult: LRESULT): TMessage;
begin
  with Result do begin
    Msg := aMsg;
    WParam := aWParam;
    LParam := aLParam;
    Result := aResult;
  end;
end;


function iff(const L: boolean; const s1, s2: string): string; overload;
begin
  if l then
    Result := s1
  else
    Result := s2;
end;


function iff(const L: boolean; const o1, o2: TObject): TObject; overload;
begin
  if l then
    Result := o1
  else
    Result := o2;
end;


function iff(const L: boolean; const i1, i2: integer): integer; overload;
begin
  if l then
    Result := i1
  else
    Result := i2;
end;


function iff(const L: boolean; const b1, b2: boolean): boolean; overload;
begin
  if l then
    Result := b1
  else
    Result := b2;
end;


function Between(const Value, i1, i2: integer; Abs: boolean = False): boolean;
begin
  if not Abs or (i1 < i2) then
    Result := (Value >= i1) and (Value <= i2)
  else
    Result := (Value <= i1) and (Value >= i2);
end;


function SumTrans(const i1, i2: integer): integer;
begin
  Result := Round(i2 + (100 - i2) * (i1 / 100));
end;


function Maxi(const i1, i2: integer): integer;
begin
  if i1 > i2 then
    Result := i1
  else
    Result := i2;
end;


function Mini(const i1, i2: integer): integer;
begin
  if i1 > i2 then
    Result := i2
  else
    Result := i1;
end;


function LimitIt(const Value, MinValue, MaxValue: integer): integer;
begin
  if Value < MinValue then
    Result := MinValue
  else
    if Value > MaxValue then
      Result := MaxValue
    else
      Result := Value;
end;


procedure Changei(var i1, i2: integer);
var
  i: integer;
begin
  i := i2;
  i2 := i1;
  i1 := i;
end;


function IsValidFloat(const Value: AnsiString; var RetValue: Extended): Boolean;
var
  I: Integer;
  Buffer: array[0..63] of Char;
begin
  Result := False;
  for I := 1 to Length(Value) do
    if not CharInSet(Value[I], [{$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator, CharMinus, CharPlus, ZeroChar..'9', 'e', 'E']) then
      Exit;

  Result := TextToFloat(StrPLCopy(Buffer, Value, SizeOf(Buffer) - 1), RetValue {$IFDEF WIN32}, fvExtended{$ELSE}, fvExtended {$ENDIF});
end;


function IsValidIndex(Value, Amount: integer; First: integer = 0): Boolean;
begin
  Result := (Value >= First) and (Value < Amount);
end;

function FormatFloatStr(const S: AnsiString; const Thousands: Boolean): string;
var
  I, MaxSym, MinSym, Group: Integer;
  IsSign: Boolean;
begin
  Result := '';
  MaxSym := Length(S);
  IsSign := (MaxSym > 0) and CharInSet(S[1], [CharMinus, CharPlus]);
  if IsSign then
    MinSym := 2
  else
    MinSym := 1;

  I := Pos({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DecimalSeparator, S);
  if I > 0 then
    MaxSym := I - 1;

  I := Pos('E', AnsiUpperCase(S));
  if I > 0 then
    MaxSym := Mini(I - 1, MaxSym);

  Result := Copy(S, MaxSym + 1, MaxInt);
  Group := 0;
  for I := MaxSym downto MinSym do begin
    Result := S[I] + Result;
    Inc(Group);
    if (Group = 3) and Thousands and (I > MinSym) then begin
      Group := 0;
      Result := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ThousandSeparator + Result;
    end;
  end;
  if IsSign then
    Result := S[1] + Result;
end;


function acGetAnimation: Boolean;
var
  Info: TAnimationInfo;
begin
  Info.cbSize := SizeOf(TAnimationInfo);
  if SystemParametersInfo(SPI_GETANIMATION, SizeOf(Info), @Info, 0) then
    Result := Info.iMinAnimate <> 0
  else
    Result := False;
end;


procedure acSetAnimation(const Value: Boolean);
var
  Info: TAnimationInfo;
begin
  Info.cbSize := SizeOf(TAnimationInfo);
  BOOL(Info.iMinAnimate) := Value;
  SystemParametersInfo(SPI_SETANIMATION, SizeOf(Info), @Info, 0);
end;


function RectIsVisible(const ParentRect, Rect: TRect): boolean;
begin
  with TSrcRect(ParentRect), TDstRect(Rect) do
    Result := (DBottom > STop) and (DRight > SLeft) and (DLeft < SRight) and (DTop < SBottom) and not IsRectEmpty(Rect);
end;


function RectInRect(BigRect, SmallRect: TRect): boolean;
begin
  inc(BigRect.Bottom);
  inc(BigRect.Right);
  Result := PtInRect(BigRect, SmallRect.TopLeft) and PtInRect(BigRect, SmallRect.BottomRight);
end;


function RotateRect(R: TRect): TRect;
var
  i: integer;
begin
  with R do begin
    i := left;
    left := top;
    top := i;
    i := right;
    right := bottom;
    bottom := i;
  end;
  Result := R;
end;


function RectsAnd(const R1, R2: TRect): TRect;
begin
  Result.Left   := max(R1.Left,   R2.Left);
  Result.Top    := max(R1.Top,    R2.Top);
  Result.Right  := min(R1.Right,  R2.Right);
  Result.Bottom := min(R1.Bottom, R2.Bottom);
end;


function SumRects(const R1, R2: TRect): TRect;
begin
  Result.Left   := min(R1.Left,   R2.Left);
  Result.Top    := min(R1.Top,    R2.Top);
  Result.Right  := max(R1.Right,  R2.Right);
  Result.Bottom := max(R1.Bottom, R2.Bottom);
end;


function MkRect(Right: integer = 0; Bottom: integer = 0; Left: integer = 0; Top: integer = 0): TRect; overload;
begin
  Result := Rect(Left, Top, Right, Bottom);
end;


function MkRect(Bmp: TBitmap): TRect; overload;
begin
  Result := Rect(0, 0, Bmp.Width, Bmp.Height);
end;


function MkRect(Ctrl: TControl): TRect; overload;
begin
  Result := Rect(0, 0, Ctrl.Width, Ctrl.Height);
end;


function MkRect(Size: TSize): TRect; overload;
begin
  Result := Rect(0, 0, Size.cx, Size.cy);
end;


function MkSize(Bmp: TBitmap): TSize; overload;
begin
  Result.cx := Bmp.Width;
  Result.cy := Bmp.Height;
end;


function MkSize(R: TRect): TSize; overload;
begin
  Result.cx := WidthOf(R, True);
  Result.cy := HeightOf(R, True);
end;


function MkPoint(const X: integer = 0; const Y: integer = 0): TPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;


function MkPoint(Control: TControl): TPoint; overload;
begin
  Result.X := Control.Left;
  Result.Y := Control.Top;
end;


function MkSize(Width: integer = 0; Height: integer = 0): TSize; overload;
begin
  Result.cx := Width;
  Result.cy := Height;
end;


function OffsRect(const aRect: TRect; aOffset: integer): TRect;
begin
  Result.Left   := aRect.Left   + aOffset;
  Result.Top    := aRect.Top    + aOffset;
  Result.Right  := aRect.Right  + aOffset;
  Result.Bottom := aRect.Bottom + aOffset;
end;


function OffsRect(const aRect: TRect; aOffsetX, aOffsetY: integer): TRect; overload;
begin
  Result.Left   := aRect.Left   + aOffsetX;
  Result.Top    := aRect.Top    + aOffsetY;
  Result.Right  := aRect.Right  + aOffsetX;
  Result.Bottom := aRect.Bottom + aOffsetY;
end;


{$Q-}
function WidthOf(const r: TRect; const CheckNegative: boolean = False): integer;
begin
  Result := integer(r.Right - r.Left);
  if CheckNegative and (Result < 0) then
    Result := 0;
end;


function HeightOf(const r: TRect; const CheckNegative: boolean = False): integer;
begin
  Result := integer(r.Bottom - r.Top);
  if CheckNegative and (Result < 0) then
    Result := 0;
end;
{$Q+}


function acCharIn(const C: acChar; const SysCharSet: TSysCharSet): Boolean;
begin
{$WARNINGS OFF}
  Result := (ord(C) <= ord(High(AnsiChar))) and (AnsiChar(C) in SysCharSet);
end;
                                     

function acWordPosition(const N: Integer; const S: acString; const WordDelims: TSysCharSet): Integer;
var
  Count, I: Integer;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do begin
    while (I <= Length(S)) and acCharIn(S[I], WordDelims) do
      Inc(I);

    if I <= Length(S) then
      Inc(Count);

    if Count <> N then
      while (I <= Length(S)) and not acCharIn(S[I], WordDelims) do
        Inc(I)
    else
      Result := I;
  end;
end;


function GetWordNumber(const W, S: string; const WordDelims: TSysCharSet): integer;
var
  Count, i: Integer;
begin
  Result := -1;
  Count := WordCount(S, WordDelims);
  for i := 1 to Count do
    if ExtractWord(i, S, WordDelims) = W then begin
      Result := i;
      Exit;
    end;
end;


function WordPosition(const N: Integer; const S: AnsiString; const WordDelims: TSysCharSet): Integer;
var
  Count, I: Integer;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do begin
    while (I <= Length(S)) and CharInSet(S[I], WordDelims) do
      Inc(I);

    if I <= Length(S) then
      Inc(Count);

    if Count <> N then
      while (I <= Length(S)) and not CharInSet(S[I], WordDelims) do
        Inc(I)
    else
      Result := I;
  end;
end;


function ExtractWord(const N: Integer; const S: AnsiString; const WordDelims: TSysCharSet): AnsiString;
var
  I: Integer;
  Len: Integer;
begin
  Len := 0;
  I := WordPosition(N, S, WordDelims);
  if I <> 0 then
    while (I <= Length(S)) and not CharInSet(S[I], WordDelims) do begin
      Inc(Len);
      SetLength(Result, Len);
      Result[Len] := S[I];
      Inc(I);
    end;

  SetLength(Result, Len);
end;


function acExtractWord(const N: Integer; const S: acString; const WordDelims: TSysCharSet): acString;
var
  I: Integer;
  Len: Integer;
begin
  Len := 0;
  I := acWordPosition(N, S, WordDelims);
  if I <> 0 then
    while (I <= Length(S)) and not CharInSet(Char(S[I]), WordDelims) do begin
      Inc(Len);
      SetLength(Result, Len);
      Result[Len] := S[I];
      Inc(I);
    end;

  SetLength(Result, Len);
end;


function acWordCount(const S: acString; const WordDelims: TSysCharSet): Integer;
var
  SLen, I: Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do begin
    while (I <= SLen) and acCharIn(S[I], WordDelims) do
      Inc(I);

    if I <= SLen then
      Inc(Result);

    while (I <= SLen) and not acCharIn(S[I], WordDelims) do
      Inc(I);
  end;
end;


function WordCount(const S: AnsiString; const WordDelims: TSysCharSet): Integer;
var
  SLen, I: Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do begin
    while (I <= SLen) and CharInSet(S[I], WordDelims) do
      Inc(I);

    if I <= SLen then
      Inc(Result);

    while (I <= SLen) and not CharInSet(S[I], WordDelims) do
      Inc(I);
  end;
end;


function MakeStr(C: AnsiChar; N: Integer): AnsiString;
begin
  if N <= 0 then
    Result := ''
  else begin
    SetLength(Result, N);
    FillChar(Result[1], Length(Result), C);
  end;
end;


function DelRSpace(const S: string): string;
begin
  Result := DelBSpace(DelESpace(S));
end;


function DelESpace(const S: string): string;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] = s_Space) do
    Dec(I);

  Result := Copy(S, 1, I);
end;


function DelBSpace(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] = s_Space) do
    Inc(I);

  Result := Copy(S, I, MaxInt);
end;


function DelChars(const S: string; Chr: Char): string;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = Chr then
      Delete(Result, I, 1);
end;


function ReplaceStr(const S, Srch, Replace: string): string;
var
  I: Integer;
  Source: string;
begin
  Source := S;
  repeat
    I := Pos(Srch, Source);
    if I > 0 then begin
      Result := Result + Copy(Source, 1, I - 1) + Replace;
      Source := Copy(Source, I + Length(Srch), MaxInt);
    end
    else
      Result := Result + Source;
  until I <= 0;
end;


function ExtractSubStr(const S: AnsiString; var Pos: Integer; const Delims: TSysCharSet): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(S)) and not CharInSet(S[I], Delims) do
    Inc(I);

  Result := Copy(S, Pos, I - Pos);
  if (I <= Length(S)) and CharInSet(S[I], Delims) then
    Inc(I);

  Pos := I;
end;


function IsEmptyStr(const S: AnsiString; const EmptyChars: TSysCharSet): Boolean;
var
  I, SLen: Integer;
begin
  SLen := Length(S);
  I := 1;
  while I <= SLen do
    if not CharInSet(S[I], EmptyChars) then begin
      Result := False;
      Exit;
    end
    else
      Inc(I);

  Result := True;
end;


function IsNTFamily: boolean;
begin
  Result := (Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1));
end;


function MakeCacheInfo(const aBmp: TBitmap; const xOffs: integer = 0; const yOffs: integer = 0): TCacheInfo;
begin
  with Result do begin
    Bmp := aBmp;
    FillColor := clFuchsia;
    FillRect := MkRect;
    X := xOffs;
    Y := yOffs;
    Ready := True;
  end;
end;


function AddChar(const C: AnsiChar; const S: AnsiString; const N: Integer): AnsiString;
begin
  if Length(S) < N then
    Result := MakeStr(C, N - Length(S)) + S
  else
    Result := S;
end;


function DeleteRequest: boolean;
begin
  Result := {$IFNDEF ALITE}sMessageDlg{$ELSE}MessageDlg{$ENDIF}('Delete this item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;


function CustomRequest(const s: string): boolean;
begin
  Result := {$IFNDEF ALITE}sMessageDlg{$ELSE}MessageDlg{$ENDIF}(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;


procedure ShowWarning(const s: string);
begin
  {$IFNDEF ALITE}sMessageDlg{$ELSE}MessageDlg{$ENDIF}(s, mtWarning, [mbOk], 0);
end;


procedure ShowError(const s: string);
begin
  {$IFNDEF ALITE}sMessageDlg{$ELSE}MessageDlg{$ENDIF}(s, mtError, [mbOk], 0);
end;


procedure Delay(const MSecs: Integer);
var
  FirstTickCount: DWord;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages
  until GetTickCount - FirstTickCount >= DWord(MSecs);
end;


var
  hKern32:  HMODULE = 0;
  hShell32: HMODULE = 0;

function IsIDERunning: boolean;
begin
  if Assigned(acntUtils.IsDebuggerPresent) then
    Result := acntUtils.IsDebuggerPresent
  else
    Result := True;
end;


function IsWOW64Proc: Windows.bool;
begin
  if Assigned(IsWow64Process) then begin
    if not IsWow64Process(GetCurrentProcess, Result) then
      Result := False;
  end
  else
    Result := False;
end;


// Prop Info
function HasProperty(const Component: TObject; const PropName: String): Boolean;
begin
  Result := GetPropInfo(Component.ClassInfo, PropName) <> nil;
end;


function GetObjProp(const Component: TObject; const PropName: String): TObject;
var
  ptrPropInfo: PPropInfo;
begin
  ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if ptrPropInfo = nil then
    Result := nil
  else
    Result := TObject(GetObjectProp(Component, ptrPropInfo, TObject));
end;


{$IFNDEF FPC}
function CheckSetProp(const Component: TObject; const PropName, Value: String): Boolean;
var
  PropInfo: PPropInfo;
  TypeInfo: PTypeInfo;
  S: TIntegerSet;
  i: integer;
begin
  Result := False;
  PropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if PropInfo <> nil then begin
    Integer(S) := GetOrdProp(Component, PropInfo);
    TypeInfo := GetTypeData(PropInfo^.PropType^)^.CompType^;
    for I := 0 to SizeOf(Integer) * 8 - 1 do
      if I in S then
        if GetEnumName(TypeInfo, I) = Value then begin
          Result := True;
          Break
        end;
  end;
end;


{$IFNDEF DELPHI6UP}
function SetToString(const PropInfo: PPropInfo; const Value: Integer): string;
var
  S: TIntegerSet;
  TypeInfo: PTypeInfo;
  I: Integer;
begin
  Result := '';
  Integer(S) := Value;
  TypeInfo := GetTypeData(PropInfo^.PropType^)^.CompType^;
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if I in S then begin
      if Result <> '' then
        Result := Result + s_Comma;

      Result := Result + GetEnumName(TypeInfo, I);
    end;
end;
{$ENDIF}
{$ENDIF}


function SetSetPropValue(const Component: TObject; const PropName, ValueName: String; const Value: boolean): Boolean;
var
  PropInfo: PPropInfo;
  i: integer;
  s: string;
begin
  Result := False;
  PropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if PropInfo <> nil then begin
    I := Integer(GetOrdProp(Component, PropInfo));
    s := SetToString(PropInfo, I);
    if Value then begin
      if pos(s, ValueName) <= 0 then begin
        s := s + s_Comma + ValueName;
        SetSetProp(Component, PropInfo, s);
      end;
    end
    else begin
      i := pos(s_Comma + ValueName, s);
      if i > 0 then
        Delete(s, i, Length(s_Comma + ValueName))
      else begin
        i := pos(ValueName + s_Comma, s);
        if i > 0 then
          Delete(s, i, Length(s_Comma + ValueName))
        else begin
          i := pos(ValueName, s);
          if i > 0 then
            Delete(s, i, Length(ValueName))
          else
            Exit;
        end;
      end;
      SetSetProp(Component, PropInfo, s);
    end;
  end;
end;


function GetIntProp(const Component: TObject; const PropName: String): Integer;
var
  ptrPropInfo: PPropInfo;
begin
  ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if ptrPropInfo = nil then
    Result := -1
  else
    Result := Integer(GetOrdProp(Component, ptrPropInfo));
end;


procedure SetIntProp(const Component: TObject; const PropName: String; const Value: Integer);
var
  ptrPropInfo: PPropInfo;
begin
  ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
  if ptrPropInfo <> nil then
    SetOrdProp(Component, ptrPropInfo, Value);
end;


function NormalDir(const DirName: ACString): ACString;
begin
  Result := DirName;
  if (Result <> '') and not (Result[Length(Result)] = s_Slash) then
    if Result[Length(Result)] = '/' then
      Result[Length(Result)] := s_Slash
    else
      if Length(Result) = 1 then
        Result := Result + ':\'
      else
        Result := Result + s_Slash;
end;


function acFindNextFile(hFindFile: THandle; var lpFindFileData: TacWIN32FindData): BOOL;
begin
  Result := {$IFDEF TNTUNICODE}Tnt_FindNextFileW{$ELSE}FindNextFile{$ENDIF}(hFindFile, lpFindFileData);
end;


function acFindFirstFile(lpFileName: PacChar; var lpFindFileData: TacWIN32FindData): THandle;
begin
  Result := {$IFDEF TNTUNICODE}Tnt_FindFirstFileW{$ELSE}FindFirstFile{$ENDIF}(lpFileName, lpFindFileData);
end;


function ValidFileName(const FileName: ACString): Boolean;

  function HasAny(const Str, Substr: ACString): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 1 to Length(Substr) do
      if Pos(Substr[I], Str) > 0 then begin
        Result := True;
        Break;
      end;
  end;

begin
  Result := (FileName <> '') and not HasAny(FileName, '<>"|*?/');
  if Result then
    Result := Pos(s_Slash, {$IFDEF TNTUNICODE}WideExtractFileName{$else}ExtractFileName{$ENDIF}(FileName)) = 0;
end;


{$IFDEF DELPHI_XE}
function FixedDirectoryExists(const Directory: string; FollowLink: Boolean = True): Boolean;
var
  Code: Cardinal;
  Handle: THandle;
  LastError: Cardinal;
begin
  Result := False;
  Code := GetFileAttributes(PChar(Directory));
  if Code <> INVALID_FILE_ATTRIBUTES then
    if faSymLink and Code = 0 then
      Result := faDirectory and Code <> 0
    else
      if FollowLink then begin
        Handle := CreateFile(PChar(Directory), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
        if Handle <> INVALID_HANDLE_VALUE then begin
          CloseHandle(Handle);
          Result := faDirectory and Code <> 0;
        end;
      end
      else
        if faDirectory and Code <> 0 then
          Result := True
        else begin
          Handle := CreateFile(PChar(Directory), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
          if Handle <> INVALID_HANDLE_VALUE then begin
            CloseHandle(Handle);
            Result := False;
          end
          else
            Result := True;
        end
  else begin
    LastError := GetLastError;
    Result := not (LastError in [ERROR_FILE_NOT_FOUND, ERROR_PATH_NOT_FOUND, ERROR_INVALID_NAME, ERROR_BAD_NETPATH, ERROR_NOT_READY]);
  end;
end;
{$ENDIF}


function acDirExists(const Name: ACString): Boolean;
{$IFDEF TNTUNICODE}
var
  Code: Integer;
{$ELSE}
  {$IFNDEF DELPHI7UP}
var
  Code: Integer;
  {$ENDIF}
{$ENDIF}
begin
{$R-}
{$IFDEF TNTUNICODE}
  Code := Tnt_GetFileAttributesW(PACChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
{$ELSE}
  {$IFDEF DELPHI7UP}
    Result := {$IFDEF DELPHI_XE}FixedDirectoryExists{$ELSE}DirectoryExists{$ENDIF}(Name);
  {$ELSE}
    Code := GetFileAttributes(PACChar(Name));
    Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
  {$ENDIF}
{$ENDIF}
{$R+}
end;


function ShortToLongFileName(const ShortName: ACString): ACString;
var
  Temp: {$IFDEF TNTUNICODE}TWin32FindDataW{$ELSE}TWin32FindDataA{$ENDIF};
  SearchHandle: THandle;
begin
{$IFDEF TNTUNICODE}
  SearchHandle := Tnt_FindFirstFileW(PACChar(ShortName), Temp);
{$ELSE}
  SearchHandle := FindFirstFileA(POldChar(ShortName), Temp);
{$ENDIF}
  if SearchHandle <> INVALID_HANDLE_VALUE then begin
    Result := ACString(Temp.cFileName);
    if Result = '' then
      Result := ACString(Temp.cAlternateFileName);
  end
  else
    Result := '';

  Windows.FindClose(SearchHandle);
end;


function LongToShortFileName(const LongName: ACstring): ACString;
var
  Temp: {$IFDEF TNTUNICODE}TWin32FindDataW{$ELSE}TWin32FindDataA{$ENDIF};
  SearchHandle: THandle;
begin
{$IFDEF TNTUNICODE}
  SearchHandle := Tnt_FindFirstFileW(PACChar(LongName), Temp);
{$ELSE}
  SearchHandle := FindFirstFileA(POldChar(LongName), Temp);
{$ENDIF}
  if SearchHandle <> INVALID_HANDLE_VALUE then begin
    Result := ACString(Temp.cAlternateFileName);
    if Result = '' then
      Result := ACString(Temp.cFileName);
  end
  else
    Result := '';

  Windows.FindClose(SearchHandle);
end;


function ShortToLongPath(const ShortName: ACString): ACString;
var
  TempPathPtr, LastSlash: PACChar;
  s: acString;
begin
  Result := '';
  s := ShortName;
  UniqueString(s);
  TempPathPtr := PACChar(s);
  LastSlash := {$IFDEF TNTUNICODE}WStrRScan{$ELSE}StrRScan{$ENDIF}(TempPathPtr, s_Slash);
  while LastSlash <> nil do begin
    Result := s_Slash + ShortToLongFileName(TempPathPtr) + Result;
    if LastSlash <> nil then begin
      LastSlash^ := #0;
      LastSlash := {$IFDEF TNTUNICODE}WStrRScan{$ELSE}StrRScan{$ENDIF}(TempPathPtr, s_Slash);
    end;
  end;
  Result := TempPathPtr + Result;
end;


function LongToShortPath(const LongName: ACString): ACString;
var
  TempPathPtr, LastSlash: PACChar;
  s: acString;
begin
  Result := '';
  s := LongName;
  UniqueString(s);
  TempPathPtr := PACChar(s);
{$IFDEF TNTUNICODE}
  LastSlash := WStrRScan(TempPathPtr, s_Slash);
{$ELSE}
  LastSlash := StrRScan(TempPathPtr, s_Slash);
{$ENDIF}
  while LastSlash <> nil do begin
    Result := s_Slash + LongToShortFileName(TempPathPtr) + Result;
    if LastSlash <> nil then begin
      LastSlash^ := #0;
{$IFDEF TNTUNICODE}
      LastSlash := WStrRScan(TempPathPtr, s_Slash);
{$ELSE}
      LastSlash := StrRScan(TempPathPtr, s_Slash);
{$ENDIF}
    end;
  end;
  Result := TempPathPtr + Result;
end;


function acCreateDir(const DirName: acString): Boolean;
begin
{$IFDEF TNTUNICODE}
  Result := Tnt_CreateDirectoryW(PacChar(DirName), nil);
{$else}
  Result := CreateDirectory(PacChar(DirName), nil);
{$ENDIF}
end;


function acRemoveDir(const DirName: acString): Boolean;
begin
{$IFDEF TNTUNICODE}
  Result := Tnt_RemoveDirectoryW(PacChar(DirName));
{$else}
  Result := RemoveDirectory(PacChar(DirName));
{$ENDIF}
end;


function acSetCurrentDir(const DirName: ACString): Boolean;
begin
{$IFDEF TNTUNICODE}
  Result := Tnt_SetCurrentDirectoryW(PACChar(DirName));
{$else}
  Result := SetCurrentDirectory(PacChar(DirName));
{$ENDIF}
end;


function acDeleteFile(const FileName: ACString): Boolean;
begin
{$IFDEF TNTUNICODE}
  Result := Tnt_DeleteFileW(PACChar(FileName));
{$else}
  Result := DeleteFile(PACChar(FileName));
{$ENDIF}
end;


function acCopyFile(const ExistingFileName, NewFileName: ACString; bFailIfExists: Boolean): Boolean;
begin
{$IFDEF TNTUNICODE}
  Result := Tnt_CopyFileW(PACChar(ExistingFileName), PACChar(NewFileName), bFailIfExists);
{$else}
  Result := CopyFile(PACChar(ExistingFileName), PACChar(NewFileName), bFailIfExists);
{$ENDIF}
end;


function acFileSetAttr(const FileName: ACString; Attr: Cardinal): Integer;
begin
  Result := 0;
{$IFDEF TNTUNICODE}
  if not Tnt_SetFileAttributesW(PACChar(FileName), Attr) then
{$ELSE}
  if not SetFileAttributes(PACChar(FileName), Attr) then
{$ENDIF}
    Result := Integer(GetLastError);
end;


function acFindFirst(const Path: ACString; Attr: Integer; var F: TacSearchRec): Integer;
begin
{$IFDEF TNTUNICODE}
  Result := WideFindFirst(Path, Attr, F);
{$ELSE}
  Result := FindFirst(Path, Attr, F);
{$ENDIF}
end;


function acFindNext(var F: TacSearchRec): Integer;
begin
{$IFDEF TNTUNICODE}
  Result := WideFindNext(F);
{$ELSE}
  Result := FindNext(F);
{$ENDIF}
end;


procedure acFindClose(var F: TacSearchRec);
begin
{$IFDEF TNTUNICODE}
  WideFindClose(F);
{$ELSE}
  FindClose(F);
{$ENDIF}
end;


function ClearDir(const Path: ACString; Delete: Boolean): Boolean;
const
  FileNotFound = 18;
var
  FileInfo: TacSearchRec;
  DosCode: Integer;
begin
  Result := acDirExists(Path);
  if Result then begin
    DosCode := acFindFirst(NormalDir(Path) + '*.*', faAnyFile, FileInfo);
    try
      while DosCode = 0 do begin
        if FileInfo.Name[1] <> s_Dot then begin
          if FileInfo.Attr and faDirectory <> 0 then
            Result := ClearDir(NormalDir(Path) + FileInfo.Name, Delete) and Result
          else
            if FileInfo.Attr and faReadOnly <> 0 then
              acFileSetAttr(NormalDir(Path) + FileInfo.Name, faArchive);

            Result := acDeleteFile(NormalDir(Path) + FileInfo.Name) and Result;
        end;
        DosCode := acFindNext(FileInfo);
      end;
    finally
      acFindClose(FileInfo);
    end;
    if Delete and Result and (DosCode = FileNotFound) and not ((Length(Path) = 2) and (Path[2] = ':')) then
      Result := acRemoveDir(Path);
  end;
end;


function GetAppPath: ACString;
begin
{$IFDEF TNTUNICODE}
  Result := WideExtractFilePath(WideParamStr(0));
{$ELSE}
  Result := ExtractFilePath(ParamStr(0));
{$ENDIF}
end;


function GetIconForFile(const FullFileName: ACString; Flag: integer): TIcon;
{$IFDEF TNTUNICODE}
var
  SH: TSHFileInfoW;
begin
  Result := nil;
  if WideFileExists(FullFileName) then begin
    FillChar(SH, SizeOf(SH), 0);
    if Tnt_SHGetFileInfoW(PACChar(FullFileName), 0, SH, SizeOf(SH), SHGFI_ICON or Flag) <> 0 then begin
      Result := TIcon.Create;
      Result.Handle := SH.hIcon;
      if Result.Empty then
        FreeAndNil(Result);
    end;
  end;
end;
{$ELSE}
var
  SH: TSHFileInfo;
begin
  Result := nil;
  if FileExists(FullFileName) then begin
    FillChar(SH, SizeOf(SH), 0);
    if Assigned(acSHGetFileInfo) and (acSHGetFileInfo(PACChar(FullFileName), 0, SH, SizeOf(SH), SHGFI_ICON or Flag) <> 0) then begin
      Result := TIcon.Create;
      Result.Handle := SH.hIcon;
      if Result.Empty then
        FreeAndNil(Result);
    end;
  end;
end;
{$ENDIF}


function acSameText(const S1, S2: ACString): Boolean;
begin
{$IFDEF TNTUNICODE}
  Result := WideSameText(S1, S2);
{$ELSE}
  Result := SameText(S1, S2);
{$ENDIF}
end;


procedure acFillString(var S: acString; const nCount: Integer; const C: acChar);
{$IFDEF WIDETEXT}
var
  i: Integer;
begin
  if nCount <= 0 then
    S := ''
  else begin
    if Length(S) <> nCount then
      SetLength(S, nCount);

    for i := 1 to nCount do
      S[i] := C;
  end;
end;
{$ELSE}
begin
  if nCount <= 0 then
    S := ''
  else begin
    if Length(S) <> nCount then
      SetLength(S, nCount);

    FillChar(S[1], nCount, C);
  end;
end;
{$ENDIF}


{$IFNDEF D2009}
function CharInSet(const C: AnsiChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;
{$ENDIF}


procedure InitSysProc;
begin
  if hShell32 = 0 then
    hShell32 := LoadLibrary(shell32);

  if hShell32 <> 0 then
    if not Assigned(acSHGetFileInfo) then
      acSHGetFileInfo := GetProcAddress(hShell32, {$IFDEF DELPHI_XE}'SHGetFileInfoW'{$ELSE}'SHGetFileInfo'{$ENDIF});
end;


initialization
  if hKern32 = 0 then
    hKern32 := LoadLibrary(kernel32);

  if hKern32 <> 0 then begin
    if not Assigned(IsDebuggerPresent) then
      IsDebuggerPresent := GetProcAddress(hKern32, 'IsDebuggerPresent');

    IsWow64Process := GetProcAddress(hKern32, 'IsWow64Process');
    if IsWOW64Proc and not AeroIsEnabled then
      x64woAero := True;
  end;
  InitSysProc;


finalization
  if hKern32 <> 0 then
    FreeLibrary(hKern32);

  if hShell32 <> 0 then
    FreeLibrary(hShell32);

end.
