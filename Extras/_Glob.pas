unit _Glob;

interface

{$i versions.inc}

uses
  UITypes,
  Windows,
  Registry,
  ShellAPI,
  Messages,
  Classes,
  Graphics,
  SysUtils,
  math,
  DB,
  dbtables,
  BDE,
  ShlObj,
  Forms,
  Controls,
  ADODB,
  ActiveX,
  ComObj,
  AdoInt,
  OleDB,
  dialogs,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
  printers,
  inifiles,
  dateUtils
  ;

var
  TickCountStart, TickCountEnd : longint;

const
   globLoglevel = 100;
//   MainGuestConstant_Version_1 = 'MainGuest';
//   MainGuestConstant_Version_2 = 'Guest Name';

function _IsInteger(S : string) : Boolean;
function _IsFloat(S : string) : Boolean;
function _IsDate(date : string) : Boolean;
function _IsHomeDate(date : string) : Boolean;


function _SqlFloatToStr(f : double; default : string) : string;
function _CommaToDot(S : string) : string;
function _DotToComma(S : string) : string;

function _Bool2Str(const aBool : Boolean; Kind : integer) : string;
function _Bool2String(const aBool : Boolean; Values : string) : string;

function _dateToSqlDate(const dDate : TdateTime) : string;
function _dateToSqlDateMidnight(aDate : TdateTime) : string;

function _dateToDBDate(aDate : TdateTime; quoted : Boolean) : string;
function _DBDateToDate(sDate : string) : TdateTime;

function _dateTimeToDBDate(aDate : TdateTime; quoted : Boolean) : string;
function _DBDateToDateTime(sDate : string) : TdateTime;
function _DBDateToDateTimeNoMs(sDate : string) : TdateTime;

function _TrimLower(const S : string) : string;
function _GetParam(const S, param : string; sep : char) : string;

function _intPadZeroLeft(int : integer; pad : integer) : string;

function _strPadChL(const S : string; C : char; Len : integer) : string;
function _strPadChR(const S : string; C : char; Len : integer) : string;
function _strPadChC(const S : string; C : char; Len : integer) : string;
function _strPadL(const S : string; Len : integer) : string;
function _strPadR(const S : string; Len : integer) : string;
function _strPadC(const S : string; Len : integer) : string;
function _strPadZeroL(const S : string; Len : integer) : string;

function _dbStr(const aString : string; use_N_Prefix : boolean=true) : string;
function _dbInt(const aInt : integer) : string;

function _db(const aString : string)   : string; Overload;
function _db(const aString : char)   : string; Overload;
function _dbNullIfEmpty(const aString : string)   : string; Overload;
function _db(const aInt  : integer)    : string; Overload;
function _db(const aBool : boolean)    : string; Overload;
function _db(const aFloat : Extended)  : string; Overload;
function _db(const aFloat : double)    : string; Overload;
function _db(const aDate  : TdateTime) : string; Overload;
function _dbDT(const aDate : TDateTime)  : string;
function _db(const aDate : TDate)  : string; Overload;
function _db(const aTime: TTime): string; overload;
function _dbDateAndTime(const aDate : TDateTime; qouted : boolean=true)  : string;

function _FloatToStr(fValue : double; w, d : byte) : string;
function _StrToFloat(sValue : string) : double;
function _IsNumber(S : string) : Boolean;

// ***
function _strToken(var S : string; Seperator : char) : string;
function _strTokenGetAtnr(const S, Ts : string; Seperator : char) : integer;
function _strTokenAt(const S : string; Seperator : char; At : integer) : string;
function _strTokenFromStrings(Seperator : char; List : TStrings) : string;
procedure _strTokenToStringsEmptyTo(S : string; Seperator : char; List : TStrings);
procedure _strTokenToStrings(S : string; Seperator : char; List : TStrings);
function _strTokenCount(S : string; Seperator : char) : integer;

function _RoundN(Value : double; Decimals : integer) : double;

function _PriceRound(Floatvalue : double; RoundUpStartAt, roundtoType : integer// 1/1000  - 1/100 - 1/10 - 1 - 10 - 100 - 1000 - 10000
  ) : double;

function _PriceRoundToStr(Floatvalue : double; RoundUpStartAt, roundtoType : integer;
  // 1/1000  - 1/100 - 1/10 - 1 - 10 - 100 - 1000 - 10000
  preStr, postStr : string) : string;

function _strDecrypt(const s : string; Key : Word) : string;
function _strEncrypt(const s : string; Key : Word) : string;

function _lstNumEnCrypt(lstNotCrypt : TstringList; Key : Word) : TstringList;
function _lstNumDeCrypt(lstCrypt : TstringList; Key : Word) : TstringList;

function _strNumDecrypt(inn : string; Key : Word) : string;
function _strNUmEncrypt(inn : string; Key : Word) : string;

function _FindVolumeSerial(const Drive : PChar) : string;
function _getDotNETversion : string;

procedure _ListAvailableSQLServers(Names : TStrings);
procedure _create_UDLfile(Fname, commandText : string);

function _GetNodeByText(ATree : TTreeView; AValue : string; AVisible : Boolean) : TTreeNode;

function _GetNodeInNodeByText(ATree : TTreeView; InNode : TTreeNode; AValue : string; AVisible : Boolean) : TTreeNode;

function _lineDate2Date(linedate : string) : Tdate;

function _text2numText(aText : string) : string;
function _numtext2Text(aText : string) : string;
function _AddSlash(const S : string) : string;

function _islerl(sText : string; erl : Boolean) : string;
function _kMultiplyer(kredit : Boolean) : integer;
function _GetDefaultPrinterName : string;

procedure _RestoreWinPos(vIni, vSection : string; var vForm : TForm);
procedure _SaveWinPos(vIni, vSection : string; vForm : TForm);

function _DaysBetween(Date1, Date2 : TdateTime) : Longint;
function _NightsBetween(Date1, Date2 : TdateTime) : Longint;

// ********
Function _WashInteger(s : string) : string;
function _washPID(S : string; strik : Boolean) : string;
function _washID(S : string) : string;
function _chkPid(pId : string) : Boolean;
function _isPid(pId : string) : Boolean;
Function _WashJustNumbers(s : string) : string;

// **

//procedure create_UDLfile(Fname, commandText : string);
function getDotNETversion : string;
function FindVolumeSerial(const Drive : PChar) : string;

// Font conversion to String and back
function _FontToStr(Font : TFont) : string;
function _StrToFont(S : string) : TFont;

function _GetCurrentTick : string;
function _GetCurrentTick2 : string;

function _GetExeByExtension(sExt : string) : string;
function _calcVAT(with_VAT, VATPrecent : double) : double;
function _calcNetAmount(with_VAT, Percent : double) : double;

function _TinyIntToColor(aInt : integer) : Tcolor;

Function _GetWindowsUser: string;
function _GetComputerNetName: string;

function _justOneSpace(aText : string) : string;
function _justOneChar(aText : string; ch: char) : string;

function _DaysPerMonth(AYear, AMonth: Integer): Integer; deprecated 'Use DateUtils.DaysInAMonth';
function _WeekNum(const TDT:TDateTime) : Word; deprecated 'Use DateUtils.WeekOfTheYear()';


function _StatusToText(status : string) : string; deprecated 'Use TReservationState.AsReadableString';
function _BreakfastToText(included : Boolean) : string; deprecated 'Use TBreakfastState.AsReadableString';
function _AccountTypeToText(isGroupAccount : Boolean) : string; deprecated 'Use TAccountType.AsReadableString';

Function _textAppend(aFileName : string; line : string; addDate : boolean = false) : boolean;

function _TimeStrToSec(TimeStr : string) : integer;

function _appendLine(path : string; line : string) : boolean;

function DebugLogStart(sText1,sText2,path : string; logLevel : integer) : boolean;
function DebugLogEnd(sText,path : string; logLevel : integer) : boolean;

function SystemThousandsSeparator : char;

//added 121208
procedure _RestoreForm(aForm : TForm);

function GetRoomerIniFilename : String;
function GetHotelIniFilename(FullPath : Boolean = false) : String;
function GetGridsIniFilename : String;

implementation

uses uDateUtils, uRegistryServices, uUtils, uG, uStringUtils, uAppGlobal, uRoomerDefinitions, PrjConst, uFloatUtils,
  uReservationStateDefinitions, uBreakfastStateDefinitions, uAccountTypeDefinitions;

function GetRoomerIniFilename : String;
begin
  result := AppIniFile;
end;

function GetHotelIniFilename(FullPath : Boolean = false) : String;
begin
  if FullPath then
    result := '\Software\Roomer\PMS\' + 'RoomerLocalSettings_' + g.qHotelCode + '.ini'
  else
    result := 'RoomerLocalSettings_' + g.qHotelCode + '.ini';
end;

function GetGridsIniFilename : String;
begin
  result := g.qProgramExePath + 'data\grids' + '.ini';
end;


Function _textAppend(aFileName : string; line : string; addDate : boolean = false) : boolean;
var aTextFile : TextFile;
    aText : String;
begin
  result := true;
  try
    AssignFile(aTextFile, aFileName);
    try
      if not fileExists(aFileName) then
        rewrite(aTextFile)
      else
        append(aTextFile);
      aText := line;
      if addDate then
        aText := format('%s %s | %s', [FormatDateTime('yyyy-mm-dd', now),
                                       FormatDateTime('hh:nn:ss', now),
                                       aText]);
      writeln(aTextFile, aText);
    finally
      CloseFile(aTextfile);
    end;
  Except
    result := false;
  end;
end;

procedure _RestoreWinPos(vIni, vSection : string; var vForm : TForm);
var
  Ini : TRoomerRegistryIniFile;
begin
  Ini := TRoomerRegistryIniFile.Create(vIni);
  try
    if Ini.Readstring(vSection, '_WindowTop', '') <> '' then
      vForm.Top := Ini.ReadInteger(vSection, '_WindowTop', 0);

    if Ini.Readstring(vSection, '_WindowLeft', '') <> '' then
      vForm.Left := Ini.ReadInteger(vSection, '_WindowLeft', 0);

    if Ini.Readstring(vSection, '_WindowWidth', '') <> '' then
      vForm.Width := Ini.ReadInteger(vSection, '_WindowWidth', 0);

    if Ini.Readstring(vSection, '_WindowHeight', '') <> '' then
      vForm.Height := Ini.ReadInteger(vSection, '_WindowHeight', 0);

    case Ini.ReadInteger(vSection, '_WindowState', 2) of
      1 :
        Application.Minimize;
      2 :
        Application.Restore;
      3 :
        vForm.WindowState := wsMaximized;
    end;
  finally
    Ini.free;
  end;
end;

procedure _SaveWinPos(vIni, vSection : string; vForm : TForm);
var
  Ini : TRoomerRegistryIniFile;
begin
  Ini := TRoomerRegistryIniFile.Create(vIni);
  try
    case vForm.WindowState of
      wsMinimized :
        Ini.WriteInteger(vSection, '_WindowState', 1);
      wsNormal :
        Ini.WriteInteger(vSection, '_WindowState', 2);
      wsMaximized :
        Ini.WriteInteger(vSection, '_WindowState', 3);
    end;

    if vForm.WindowState = wsNormal then
    begin
      Ini.WriteInteger(vSection, '_WindowTop', vForm.Top);
      Ini.WriteInteger(vSection, '_WindowLeft', vForm.Left);
      Ini.WriteInteger(vSection, '_WindowWidth', vForm.Width);
      Ini.WriteInteger(vSection, '_WindowHeight', vForm.Height);
    end;
  finally
    Ini.free;
  end;
end;

function _AddSlash(const S : string) : string;
begin
  Result := IncludeTrailingPathDelimiter(s);
end;

function _text2numText(aText : string) : string;
var
  i : integer;
  S : string;
  ch : char;
  o : integer;
begin
  S := '';
  for i := 0 to Length(aText) do
  begin
    ch := aText[i];
    o := ord(ch);
    S := S + _intPadZeroLeft(o, 3);
  end;
  Result := S;
end;

function _numtext2Text(aText : string) : string;
var
  S : string;
  sChNum : string;
  chnum : integer;
begin
  S := '';
  if Length(aText) > 3 then
  begin
    delete(aText, 1, 3);
    S := '';
    repeat
      sChNum := copy(aText, 1, 3);
      chnum := strToInt(sChNum);
      S := S + char(chnum);
      delete(aText, 1, 3);
    until Length(aText) < 3;
  end;
  Result := S;
end;

function _IsNumber(S : string) : Boolean;
begin
  result := _IsInteger(S) OR _IsFloat(S);
end;

function _IsInteger(S : string) : Boolean;
var
  i : integer;
begin
  Result := TryStrToInt(S, i);
end;

function _IsFloat(S : string) : Boolean;
begin
  try
    Result := True;
    LocalizedFloatValue(S, false);
  except
    on E : EConvertError do
      Result := False;
  end;
end;

function _IsDate(date : string) : Boolean;
begin
  try
    StrToDateTime(date);
    Result := True;
  except
    Result := False;
  end;
end;

function _IsHomeDate(date : string) : Boolean;
begin
  try
    StrToDateTime(date);
    Result := True;
  except
    Result := False;
  end;
end;


function _Bool2Str(const aBool : Boolean; Kind : integer) : string;
// Tegund 0=0/1  1=False/True  2=No/Yes  3=J�/Nei
begin
  Result := '';
  case Kind of
    0 :
      begin
        if aBool then
          Result := '1'
        else
          Result := '0';
      end;
    1 :
      begin
        if aBool then
          Result := 'True'
        else
          Result := 'False';
      end;
    2 :
      begin
        if aBool then
          Result := 'Yes'
        else
          Result := 'No';
      end;
    3 :
      begin
        if aBool then
          Result := 'J�'
        else
          Result := 'Nei';
      end;
    4 :
      begin
        if aBool then
          Result := 'ON'
        else
          Result := 'OFF';
      end;
    5 :
      begin
        if aBool then
          Result := 'T'
        else
          Result := 'F';
      end;
  end;
end;

function _Bool2String(const aBool : Boolean; Values : string) : string;
begin
  if aBool then
    Result := copy(Values, 1, pos('/', Values) - 1)
  else
    Result := copy(Values, pos('/', Values) + 1, maxint)
end;

function _dateToSqlDate(const dDate : TdateTime) : string;
begin
  Result := quotedstr(uDateUtils.dateToSqlString(dDate)); // FormatDateTime('mm"/"dd"/"yyyy', dDate));
end;

function _dateToSqlDateMidnight(aDate : TdateTime) : string;
var
  S : string;
begin
  datetimetostring(S, 'yyyy-mm-dd 00:00:00', aDate);
  Result := quotedstr(S);
end;

function _dateToDBDate(aDate : TdateTime; quoted : Boolean) : string;
var
  S : string;
begin
  datetimetostring(S, 'yyyy-mm-dd', aDate);
  Result := S;
  if quoted then
    Result := quotedstr(S);
end;

function _dateTimeToDBDate(aDate : TdateTime; quoted : Boolean) : string;
var
  S : string;
begin
  datetimetostring(S, 'yyyy-mm-dd hh:nn:ss.zzz', aDate);
  Result := S;
  if quoted then
    Result := quotedstr(S);
end;


(*
function MyDBStrToDate(sDate : string) : TdateTime;
var
  y, m, d : Word;
  sy, sm, sd : string;
begin
  try
    sy := copy(sDate, 1, 4);
    sm := copy(sDate, 6, 2);
    sd := copy(sDate, 9, 2);
    y := strToInt(sy);
    m := strToInt(sm);
    d := strToInt(sd);
    Result := MyEncodeDate(y, m, d);
  except
    Result := trunc(now);
  end;
end;
*)


function _DBDateToDate(sDate : string) : TdateTime;
var
  d, m, y : Word;
  sd, sm, sy : string;
begin
  sDate := trim(sDate);
  sy := copy(sDate, 1, 4);
  sm := copy(sDate, 6, 2);
  sd := copy(sDate, 9, 2);

  try
    d := strToInt(sd);
  except
    d := 1;
  end;

  try
    m := strToInt(sm);
  except
    m := 1;
  end;

  try
    y := strToInt(sy);
  except
    y := 1900;
  end;

  Result := encodeDate(y, m, d);
end;


function _DBDateToDateTime(sDate : string) : TdateTime;
var
  d, m, y : Word;
  h,n,s,z : word;

  sd, sm, sy : string;

  sH, sN,sS, sZ : string;


begin
  sDate := trim(sDate);
  sy := copy(sDate, 1, 4);
  sm := copy(sDate, 6, 2);
  sd := copy(sDate, 9, 2);
  //12345678901234567890123
  //2012-03-16 00:00:00.000

  sH := copy(sDate, 12, 2);
  sN := copy(sDate, 15, 2);
  sS := copy(sDate, 18, 2);
  sZ := copy(sDate, 21, 3);


  try
    d := strToInt(sd);
  except
    d := 1;
  end;

  try
    m := strToInt(sm);
  except
    m := 1;
  end;

  try
    y := strToInt(sy);
  except
    y := 1900;
  end;

  try
    h := strToInt(sh);
  except
    h := 0;
  end;

  try
    n := strToInt(sn);
  except
    n := 0;
  end;

  try
    s := strToInt(ss);
  except
    s := 0;
  end;

  try
    z := strToInt(sz);
  except
    z := 0;
  end;

  Result := encodeDateTime(y,m,d,h,n,s,z);
end;



function _DBDateToDateTimeNoMs(sDate : string) : TdateTime;
var
  d, m, y : Word;
  h,n,s : word;

  sd, sm, sy : string;

  sH, sN,sS : string;


begin
  sDate := trim(sDate);
  sy := copy(sDate, 1, 4);
  sm := copy(sDate, 6, 2);
  sd := copy(sDate, 9, 2);
  //12345678901234567890123
  //2012-03-16 00:00:00.000

  sH := copy(sDate, 12, 2);
  sN := copy(sDate, 15, 2);
  sS := copy(sDate, 18, 2);


  try
    d := strToInt(sd);
  except
    d := 1;
  end;

  try
    m := strToInt(sm);
  except
    m := 1;
  end;

  try
    y := strToInt(sy);
  except
    y := 1900;
  end;

  try
    h := strToInt(sh);
  except
    h := 0;
  end;

  try
    n := strToInt(sn);
  except
    n := 0;
  end;

  try
    s := strToInt(ss);
  except
    s := 0;
  end;


  Result := encodeDateTime(y,m,d,h,n,s,0);
end;


function _TrimLower(const S : string) : string;
begin
  Result := trim(S);
  if Length(Result) > 0 then
    Result := ansilowercase(Result);
end;

function _GetParam(const S, param : string; sep : char) : string;
var
  p : integer;
  line : string;
begin
  Result := '';
  line := _TrimLower(S);
  p := pos(_TrimLower(param) + '=', line);
  if p > 0 then
  begin
    line := copy(S, p, maxint);
    p := pos(sep, line);
    if p > 0 then
    begin
      delete(line, p, maxint)
    end;
    p := pos('=', line);
    if p > 0 then
    begin
      Result := copy(line, p + 1, maxint);
    end;
  end;
end;

function _intPadZeroLeft(int : integer; pad : integer) : string;
var
  intstr : string;
  l, i : integer;
begin
  intstr := inttostr(int);
  l := Length(intstr);
  if pad > l then
    for i := 1 to pad - l do
      intstr := '0' + intstr;
  Result := intstr;
end;




// *****************************************************************************
//
// ******************************************************************************

function _strToken(var S : string; Seperator : char) : string;
var
  i : Word;
begin
  i := pos(Seperator, S);
  if i <> 0 then
  begin
    Result := System.copy(S, 1, i - 1);
    System.delete(S, 1, i);
  end
  else
  begin
    Result := S;
    S := '';
  end;
end;

function _strTokenCount(S : string; Seperator : char) : integer;
begin
  Result := 0;
  while S <> '' do
  begin { 29.10.96 sb }
    _strToken(S, Seperator);
    Inc(Result);
  end;
end;

function _strTokenAt(const S : string; Seperator : char; At : integer) : string;
var
  j, i : integer;
begin
  Result := '';
  j := 1;
  i := 0;
  while (i <= At) and (j <= Length(S)) do
  begin
    if S[j] = Seperator then
      Inc(i)
    else if i = At then
      Result := Result + S[j];
    Inc(j);
  end;
end;

procedure _strTokenToStrings(S : string; Seperator : char; List : TStrings);
var
  Token : string;
begin
  List.Clear;
  Token := _strToken(S, Seperator);
  while Token <> '' do
  begin
    List.Add(Token);
    Token := _strToken(S, Seperator);
  end;
end;

procedure _strTokenToStringsEmptyTo(S : string; Seperator : char; List : TStrings);
var
  count : integer;
  i : integer;
begin
  List.Clear;
  count := _strTokenCount(S, Seperator);
  for i := 0 to count - 1 do
  begin
    List.Add(_strTokenAt(S, Seperator, i));
  end;
end;

function _strTokenFromStrings(Seperator : char; List : TStrings) : string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to List.count - 1 do
    if Result <> '' then
      Result := Result + Seperator + List[i]
    else
      Result := List[i];
end;

function _strChangeTokenAt(const S, Ts : string; Seperator : char; At : integer) : string;
var
  temp : string;
  i : integer;
  fj : integer;
begin
  temp := '';
  fj := _strTokenCount(S, Seperator) - 1;
  for i := 0 to fj do
  begin
    if i = At then
      temp := temp + Ts
    else
      temp := temp + _strTokenAt(S, Seperator, i);
    if i < fj then
      temp := temp + Seperator;
  end;
  Result := temp;
end;

function _strTokenGetAtnr(const S, Ts : string; Seperator : char) : integer;
var
  temp, temp2 : string;
  i : integer;
  fj : integer;
begin
  Result := - 1;
  temp2 := trim(AnsiUpperCase(Ts));
  fj := _strTokenCount(S, Seperator) - 1;
  for i := 0 to fj do
  begin
    temp := AnsiUpperCase(_strTokenAt(S, Seperator, i));
    if temp = temp2 then
    begin
      Result := i;
      exit;
    end;
  end;
end;

// *****************************************************************************+

function _strPadChL(const S : string; C : char; Len : integer) : string;
begin
  Result := S;
  while Length(Result) < Len do
    Result := C + Result;
end;

function _strPadChR(const S : string; C : char; Len : integer) : string;
begin
  Result := S;
  while Length(Result) < Len do
    Result := Result + C;
end;

function _strPadChC(const S : string; C : char; Len : integer) : string;
begin
  Result := S;
  while Length(Result) < Len do
  begin
    Result := Result + C;
    if Length(Result) < Len then
      Result := C + Result;
  end;
end;

function _strPadL(const S : string; Len : integer) : string;
begin
  Result := _strPadChL(S, ' ', Len);
end;

function _strPadC(const S : string; Len : integer) : string;
begin
  Result := _strPadChC(S, ' ', Len);
end;

function _strPadR(const S : string; Len : integer) : string;
begin
  Result := _strPadChR(S, ' ', Len);
end;

function _strPadZeroL(const S : string; Len : integer) : string;
begin
  Result := _strPadChL(trim(S), '0', Len);
end;

// +----------------------------------------------------------------------------+
// |                                                                            |
// +----------------------------------------------------------------------------+

function _RoundN(Value : double; Decimals : integer) : double;
var
  Mult : double;
  i : integer;
begin
  Mult := 1.0;
  for i := 1 to Decimals do
    Mult := Mult * 10.0;
  Result := Round(Value * Mult) / Mult;
end;

function _PriceRound(Floatvalue : double; RoundUpStartAt, roundtoType : integer// 1/1000  - 1/100 - 1/10 - 1 - 10 - 100 - 1000 - 10000
  ) : double;

var
  iInt : integer;
  iFrac : Longint;

  sValue : string;
  sInt : string;
  sFrac : string;
  p : integer;
  ddTmp : double;
  dFrac : double;
  Buffer : double;
  RndTemp : integer;

begin
  if Floatvalue <= 0 then
  begin
    Result := 0;
    exit; // ====>
  end;

  if RoundUpStartAt = 0 then // ekki r�na�
  begin
    Result := Floatvalue;
    exit; // ====>
  end;

  if roundtoType IN [0,1,2] then
  begin
    Result := _RoundN(Floatvalue, 3 - roundtoType);
    exit; // ====>
  end;

  sValue := floattostr(Floatvalue);
  p := pos(',', sValue);
  if p = 0 then
     p := pos('.', sValue);


  sInt := sValue;
  sFrac := '0';
  if p > 0 then
  begin
    sInt := copy(sValue, 1, p - 1);
    sFrac := copy(sValue, p + 1, 9);
  end;
  iInt := strToInt(sInt);
  iFrac := strToInt(sFrac);

  case roundtoType of
    3 : // 1
      begin
        sFrac := _strPadChR(sFrac, '0', 4);
        sFrac := copy(sFrac, 1, 4);
        iFrac := strToInt(sFrac);

        dFrac := int(iFrac);
        dFrac := roundTo(dFrac, 2);

        iFrac := trunc(dFrac) div 100;

        ddTmp := iFrac;
        iFrac := 0;

        if iInt < 1 then
        begin
          iInt := 1;
        end
        else
        begin
          Buffer := 100 * RoundUpStartAt / 100;
          if ddTmp >= Buffer then
            iInt := iInt + 1;
        end;
      end;

    4..7 : // 10..10000
      begin
        RndTemp := Round(Power(10, roundtoType - 3));
        ddTmp := Floatvalue - ((iInt div RndTemp) * RndTemp);
        iFrac := 0;

        if iInt <= RndTemp then
        begin
          iInt := RndTemp;
        end
        else
        begin
          iInt := iInt div RndTemp * RndTemp;
          Buffer := RndTemp * RoundUpStartAt / RndTemp;
          if ddTmp >= Buffer then
            iInt := iInt + RndTemp;
        end;
      end;
//    5 : // 100
//      begin
//        ddTmp := Floatvalue - ((iInt div 100) * 100);
//        iFrac := 0;
//
//        if iInt <= 100 then
//        begin
//          iInt := 100;
//        end
//        else
//        begin
//          iInt := iInt div 100 * 100;
//          Buffer := 100 * RoundUpStartAt / 100;
//          if ddTmp >= Buffer then
//            iInt := iInt + 100;
//        end;
//      end;
//
//    6 : // 1000
//      begin
//        ddTmp := Floatvalue - ((iInt div 1000) * 1000);
//        iFrac := 0;
//
//        if iInt <= 1000 then
//        begin
//          iInt := 1000;
//        end
//        else
//        begin
//          iInt := iInt div 1000 * 1000;
//          Buffer := 1000 * RoundUpStartAt / 100;
//          if ddTmp >= Buffer then
//            iInt := iInt + 1000;
//        end;
//      end;
//
//    7 : // 10000
//      begin
//        ddTmp := Floatvalue - ((iInt div 10000) * 10000);
//        iFrac := 0;
//
//        if iInt <= 10000 then
//        begin
//          iInt := 10000;
//        end
//        else
//        begin
//          iInt := iInt div 10000 * 10000;
//          Buffer := 10000 * RoundUpStartAt / 100;
//          if ddTmp >= Buffer then
//            iInt := iInt + 10000;
//        end;
//      end;
  end;

  Result := StrToFloat(inttostr(iInt) + SystemDecimalSeparator + inttostr(iFrac));
end;

function _Price2Str(Value : double; RoundType : integer; preStr, postStr : string) : string;
var
  Mask : string;
  fs : TFormatSettings;
begin
  //
  Mask := '###,##0';
  fs := TFormatSettings.Create;
//  fs.ThousandSeparator := SystemThousandsSeparator;
//  fs.DecimalSeparator := SystemDecimalSeparator;
  // fs.CurrencyString := ' ISK';

  case RoundType of
    0 :
      Mask := '###,##0.##0';
    1 :
      Mask := '###,##0.#0';
    2 :
      Mask := '###,##0.0';
  end;

  Result := FormatFloat(Mask, Value, fs);

  Result := preStr + trim(Result) + postStr;
end;

function _PriceRoundToStr(Floatvalue : double; RoundUpStartAt, roundtoType : integer;
  // 1/1000  - 1/100 - 1/10 - 1 - 10 - 100 - 1000 - 10000
  preStr, postStr : string) : string;

var
  dTmp : double;
begin
  Result := '0';
  try
    dTmp := _PriceRound(Floatvalue, RoundUpStartAt, roundtoType)
  except
    dTmp := 0;
  end;
  Result := _Price2Str(dTmp{Floatvalue}, roundtoType, preStr, postStr);
end;

const
  C1 = 52845; // USED in Cript
  C2 = 22719;

function _strDecrypt(const S : string; Key : Word) : string;
var
  i : integer;
begin
  SetLength(Result, Length(S));
  for i := 1 to Length(S) do
  begin
    Result[i] := char(ord(S[i]) xor (Key shr 8));
    Key := (ord(S[i]) + Key) * C1 + C2;
  end;
end;

function _strEncrypt(const S : string; Key : Word) : string;
var
  i : integer;
begin
  SetLength(Result, Length(S));
  for i := 1 to Length(S) do
  begin
    Result[i] := char(ord(S[i]) xor (Key shr 8));
    Key := (ord(Result[i]) + Key) * C1 + C2;
  end;
end;

// *****************************************************************************9

function _FindVolumeSerial(const Drive : PChar) : string;
var
  VolumeSerialNumber : DWORD;
  MaximumComponentLength : DWORD;
  FileSystemFlags : DWORD;
  SerialNumber : string;
begin
  Result := '';

  GetVolumeInformation(Drive, nil, 0, @VolumeSerialNumber, MaximumComponentLength, FileSystemFlags, nil, 0);
  SerialNumber := IntToHex(HiWord(VolumeSerialNumber), 4) + '-' + IntToHex(LoWord(VolumeSerialNumber), 4);
  Result := SerialNumber;
end;

function _getDotNETversion : string;
var
  reg : TRegistry;
  sTmp : string;
  S : string;
begin
  Result := '';
  reg := TRegistry.Create;
  try
    S := '';
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\.NETFramework\policy\v2.0', False);
    sTmp := reg.Readstring('50727');
    reg.CloseKey;
    if sTmp = '50727-50727' then
    begin
      S := '2.0';
    end;

    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\.NETFramework\policy\v1.1', False);
    sTmp := reg.Readstring('4322');
    reg.CloseKey;
    if sTmp = '3706-4322' then
    begin
      if S > '' then
        S := S + ' & ' + '1.1'
      else
        S := '1.1';
    end;

    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\.NETFramework\policy\v1.1', False);
    sTmp := reg.Readstring('3705');
    reg.CloseKey;
    if sTmp = '3321-3705' then
    begin
      if S > '' then
        S := S + ' & ' + '1.0'
      else
        S := '1.0';
    end;

    if S <> '' then
      Result := S;

  finally
    reg.free;
  end;
end;

procedure _ListAvailableSQLServers(Names : TStrings);
var
  RSCon : ADORecordsetConstruction;
  Rowset : IRowset;
  SourcesRowset : ISourcesRowset;
  SourcesRecordset : _Recordset;
  SourcesName, SourcesType : TField;

  function PtCreateADOObject(const ClassID : TGUID) : IUnknown;
  var
    Status : HResult;
    FPUControlWord : Word;
  begin
      asm
        FNSTCW FPUControlWord
      end
    ;
    Status := CoCreateInstance(CLASS_Recordset, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, IUnknown, Result);
      asm
        FNCLEX
        FLDCW FPUControlWord
      end
    ;
    OleCheck(Status);
  end;

begin
  SourcesRecordset := PtCreateADOObject(CLASS_Recordset) as _Recordset;
  RSCon := SourcesRecordset as ADORecordsetConstruction;
  SourcesRowset := CreateComObject(ProgIDToClassID('SQLOLEDB Enumerator')) as ISourcesRowset;
  OleCheck(SourcesRowset.GetSourcesRowset(nil, IRowset, 0, nil, IUnknown(Rowset)));
  RSCon.Rowset := Rowset;

  with TADODataSet.Create(nil) do
    try
      Recordset := SourcesRecordset;
      SourcesName := FieldByName('SOURCES_NAME'); { do not localize }
      SourcesType := FieldByName('SOURCES_TYPE'); { do not localize }
      Names.BeginUpdate;
      try
        while not EOF do
        begin
          if (SourcesType.AsInteger = DBSOURCETYPE_DATASOURCE) and (SourcesName.AsString <> '') then
            Names.Add(SourcesName.AsString);
          Next;
        end;
      finally
        Names.EndUpdate;
      end;
    finally
      free;
    end;

end;

procedure _create_UDLfile(Fname, commandText : string);
var
  hUDL : integer;
  i : integer;
  S : string;
  C : char;
begin
  S := '[oledb]' + #13 + #10 + '; Everything after this line is an OLE DB initstring' + #13 + #10 + commandText + #13 + #10;

  hUDL := 0;

  try
    hUDL := FileCreate(Fname);
  except
    on E : exception do
      ShowMessage(E.message);
  end;

  try
    if hUDL > 0 then
    begin
      C := #255;
      FileWrite(hUDL, C, 1);
      C := #254;
      FileWrite(hUDL, C, 1);
      C := #0;
      for i := 1 to Length(S) do
      begin
        FileWrite(hUDL, S[i], 1);
        FileWrite(hUDL, C, 1);
      end;
      FileClose(hUDL);
    end
    else
    begin
      ShowMessage('An error occurred while trying to save' + #13 + Fname + ':' + #13 + #13 + #34 + SysErrorMessage(GetLastError)
          + #34 + #13 + #13 + 'Please contact your system administrator.');
    end;
  except
    on E : exception do
      MessageDlg(E.message, mtError, [mbOK], 0);
  end;

end;

function _GetNodeInNodeByText(ATree : TTreeView; InNode : TTreeNode; AValue : string; AVisible : Boolean) : TTreeNode;
var
  NodeText : string;
  NextNode : TTreeNode;
begin
  NextNode := InNode.GetFirstChild;
  while NextNode <> nil do
  begin
    NodeText := NextNode.Text;
    if UpperCase(NodeText) = UpperCase(AValue) then
    begin
      NextNode.Selected := AVisible;
      Break;
    end
    else
      NextNode := NextNode.getNextSibling;
  end; // while
  Result := NextNode;
end;

function _GetNodeByText(ATree : TTreeView; AValue : string; AVisible : Boolean) : TTreeNode;
var
  Node : TTreeNode;
begin
  Result := nil;
  if ATree.Items.count = 0 then
    exit;
  Node := ATree.Items[0];
  while Node <> nil do
  begin
    if UpperCase(Node.Text) = UpperCase(AValue) then
    begin
      Result := Node;
      if AVisible then
        Result.MakeVisible;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

function _lineDate2Date(linedate : string) : Tdate;
var
  sy : string;
  sm : string;
  sd : string;

  y, m, d : integer;
begin
  Result := encodeDate(2050, 1, 1);
  linedate := trim(linedate);

  if (Length(linedate) <> 8) then
    exit;

  sy := copy(linedate, 1, 4);
  try
    y := strToInt(sy);
  except
    exit;
  end;

  sm := copy(linedate, 5, 2);
  try
    m := strToInt(sm);
  except
    exit;
  end;

  sd := copy(linedate, 7, 2);
  try
    d := strToInt(sd);
  except
    exit;
  end;

  try
    Result := encodeDate(y, m, d);
  except
    // do nothing
  end;
end;

function _islerl(sText : string; erl : Boolean) : string;
var
  islTxt : string;
  erlTxt : string;
begin
  Result := sText;
  if pos('|', sText) > 1 then
  begin
    islTxt := _strTokenAt(sText, '|', 0);
    erlTxt := _strTokenAt(sText, '|', 1);
    if erl then
      Result := erlTxt
    else
      Result := islTxt;
  end;
end;

function _kMultiplyer(kredit : Boolean) : integer;
begin
  Result := 1;
  if kredit then
    Result := - 1
end;

function _GetDefaultPrinterName : string;
begin
  if (Printer.PrinterIndex > 0) then
  begin
    Result := Printer.printers[Printer.PrinterIndex];
  end
  else
  begin
    Result := '';
  end;
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

function _DotToComma(S : string) : string;
begin
  Result := S;
  if pos('.', S) = 0 then
    exit;
  while pos('.', S) > 0 do
    S[pos('.', S)] := ',';
  if copy(S, 1, 1) = ',' then
    S := '0' + S;
  Result := S;
end;

function _SqlFloatToStr(f : double; default : string) : string;
var
  sTmp : string;
begin
  sTmp := default;
  try
    sTmp := floattostr(f);
    sTmp := _CommaToDot(sTmp);
  except
  end;
  Result := sTmp;
end;


// **********************************************************

function _DaysBetween(Date1, Date2 : TdateTime) : Longint;
begin
  Result := trunc(Date2) - trunc(Date1) + 1;
end;

function _NightsBetween(Date1, Date2 : TdateTime) : Longint;
begin
  Result := trunc(Date2) - trunc(Date1);
end;


// **********************************************************
//
//
// **********************************************************

function _washID(S : string) : string;
const
  c_Numbers = ['0' .. '9'];
var
  temp : string;
  i : integer;
  C : char;
begin
  S := trim(S);
  temp := '';
  for i := 1 to Length(S) do
  begin
    C := S[i];
    if CharInSet(C, c_Numbers) then
    begin
      temp := temp + C;
    end;
  end;
  if Length(temp) <> 7 then
    temp := '';
  S := temp;
  Result := S;
end;

function _washPID(S : string; strik : Boolean) : string;
const
  c_Numbers = ['0' .. '9'];
var
  temp : string;
  i : integer;
  C : char;
begin
  S := trim(S);
  temp := '';
  for i := 1 to Length(S) do
  begin
    C := S[i];
    if CharInSet(C, c_Numbers) then
    begin
      temp := temp + C;
    end;
  end;
  if Length(temp) <> 10 then
    temp := '';

  if strik then
    if temp <> '' then
    begin
      temp := copy(temp, 1, 6) + '-' + copy(temp, 7, maxint);
    end;

  S := temp;

  Result := S;
end;

function _chkPid(pId : string) : Boolean;
var
  i : integer;
  ic : integer;
  iCalc : integer;
  iSum : integer;
  iMod : integer;
  iLeif : integer;
  iOk : integer;
  S : string;
begin
  Result := False;

  pId := _washPID(pId, True);
  if pId = '' then
    exit;

  delete(pId, 7, 1);

  pId := copy(pId, 1, 9);
  S := pId[9];
  iOk := strToInt(S);

  iSum := 0;
  iCalc := 0;
  for i := 1 to 8 do
  begin
    S := pId[i];
    ic := strToInt(S);
    case i of
      1 :
        iCalc := ic * 3;
      2 :
        iCalc := ic * 2;
      3 :
        iCalc := ic * 7;
      4 :
        iCalc := ic * 6;
      5 :
        iCalc := ic * 5;
      6 :
        iCalc := ic * 4;
      7 :
        iCalc := ic * 3;
      8 :
        iCalc := ic * 2;
    end;
    iSum := iSum + iCalc;
  end;

//  iDel := iSum div 11;
  iMod := iSum mod 11;
  iLeif := 11 - iMod;

  if iLeif = 11 then
    iLeif := 0;
  Result := iLeif = iOk;
end;

function _isPid(pId : string) : Boolean;
begin
  Result := False;
  pId := _washPID(pId, True);
  if pId = '' then
    exit;
  Result := True;
end;

// *******************************************************************************

function getDotNETversion : string;
var
  reg : TRegistry;
  sTmp : string;
  S : string;
begin
  Result := '';
  reg := TRegistry.Create;
  try
    S := '';
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\.NETFramework\policy\v2.0', False);
    sTmp := reg.Readstring('50727');
    reg.CloseKey;
    if sTmp = '50727-50727' then
    begin
      S := '2.0';
    end;

    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\.NETFramework\policy\v1.1', False);
    sTmp := reg.Readstring('4322');
    reg.CloseKey;
    if sTmp = '3706-4322' then
    begin
      if S > '' then
        S := S + ' & ' + '1.1'
      else
        S := '1.1';
    end;

    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\.NETFramework\policy\v1.1', False);
    sTmp := reg.Readstring('3705');
    reg.CloseKey;
    if sTmp = '3321-3705' then
    begin
      if S > '' then
        S := S + ' & ' + '1.0'
      else
        S := '1.0';
    end;

    if S <> '' then
      Result := S;

  finally
    reg.free;
  end;
end;


function FindVolumeSerial(const Drive : PChar) : string;
var
  VolumeSerialNumber : DWORD;
  MaximumComponentLength : DWORD;
  FileSystemFlags : DWORD;
  SerialNumber : string;
begin
  Result := '';

  GetVolumeInformation(Drive, nil, 0, @VolumeSerialNumber, MaximumComponentLength, FileSystemFlags, nil, 0);
  SerialNumber := IntToHex(HiWord(VolumeSerialNumber), 4) + '-' + IntToHex(LoWord(VolumeSerialNumber), 4);
  Result := SerialNumber;
end;

// Font conversion to String
function _FontToStr(Font : TFont) : string;
const
  cnsSubSeparator = '~';
var
  sTmp : string;
begin
  Result := '';
  if not (Font = nil) then
  begin
    sTmp := inttostr(Font.CharSet);
    sTmp := sTmp + cnsSubSeparator + inttostr(Font.Color);
    sTmp := sTmp + cnsSubSeparator + inttostr(Font.Height);
    sTmp := sTmp + cnsSubSeparator + Font.name;
    sTmp := sTmp + cnsSubSeparator + inttostr(Font.Size);

    case Font.Pitch of
      fpDefault :
        sTmp := sTmp + cnsSubSeparator + 'D';
      fpVariable :
        sTmp := sTmp + cnsSubSeparator + 'V';
      fpFixed :
        sTmp := sTmp + cnsSubSeparator + 'F';
    end;
    sTmp := sTmp + cnsSubSeparator;
    sTmp := sTmp + IIF(fsBold in Font.Style, 'B', 'N');
    sTmp := sTmp + IIF(fsItalic in Font.Style, 'I', 'N');
    sTmp := sTmp + IIF(fsUnderLine in Font.Style, 'U', 'N');
    sTmp := sTmp + IIF(fsStrikeOut in Font.Style, 'S', 'N');
    Result := sTmp;
  end;
end;



// String conversion to Font
function _StrToFont(S : string) : TFont;
const
  cnsDefFont = '0/0/-11/MS Sans Serif/8/D/NNNN';
  cnsSubSeparator = '~';
var
  sTmp : string;
  iPos : integer;
begin
  if S = '' then
    S := cnsDefFont; // �res a font
  Result := TFont.Create;
  iPos := pos(cnsSubSeparator, S);
  sTmp := copy(S, 1, iPos - 1);
  Result.CharSet := strToInt(sTmp);
  delete(S, 1, iPos);

  iPos := pos(cnsSubSeparator, S);
  sTmp := copy(S, 1, iPos - 1);
  Result.Color := strToInt(sTmp);
  delete(S, 1, iPos);

  iPos := pos(cnsSubSeparator, S);
  sTmp := copy(S, 1, iPos - 1);
  Result.Height := strToInt(sTmp);
  delete(S, 1, iPos);

  iPos := pos(cnsSubSeparator, S);
  sTmp := copy(S, 1, iPos - 1);
  Result.name := sTmp;
  delete(S, 1, iPos);

  iPos := pos(cnsSubSeparator, S);
  sTmp := copy(S, 1, iPos - 1);
  Result.Size := strToInt(sTmp);
  delete(S, 1, iPos);

  iPos := pos(cnsSubSeparator, S);
  sTmp := copy(S, 1, iPos - 1);
  case sTmp[1] of
    'D' :
      Result.Pitch := fpDefault;
    'V' :
      Result.Pitch := fpVariable;
    'F' :
      Result.Pitch := fpFixed;
  end;
  delete(S, 1, iPos);

  Result.Style := [];
  sTmp := S;
  if sTmp[1] = 'B' then
    Result.Style := Result.Style + [fsBold];
  if sTmp[2] = 'I' then
    Result.Style := Result.Style + [fsItalic];
  if sTmp[3] = 'U' then
    Result.Style := Result.Style + [fsUnderLine];
  if sTmp[4] = 'S' then
    Result.Style := Result.Style + [fsStrikeOut];
end;

function RightAligned(str:string; size: integer; padded: Char): string;
var s: string;
begin
	s := stringofchar(padded, size);
	s := s + str;
	delete(s, 1, length(s)- size);
	result := s;
end;


function DateTimeToISOStr(DateTime: TDateTime): string;
var Hour, Min, Sec, MSec: Word;
begin
	DecodeTime(DateTime, Hour, Min, Sec, MSec);
	result := formatdatetime('YYYY-MM-DD-HH.NN.SS',datetime) + '.' + RightAligned(IntToStr(MSec*1000),6,'0');
end;

function ISOStrToDateTime(ISOStr: String): TDateTime;
var Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
	// ISO DateTime stamp 'YYYY-MM-DD-HH.MM.SS.NNNNNN'
	//					e.g:	 '1234-67-90-23.56.89.123456' <- position
	try // Moved 'try' to the beginning .., ISOStr can be anything (v1.0.1.21)
		Year 	:= StrToInt(copy(ISOStr,1,4));
		Month := StrToInt(copy(ISOStr,6,2));
		Day 	:= StrToInt(copy(ISOStr,9,2));
		Hour	:= StrToInt(copy(ISOStr,12,2));
		Min 	:= StrToInt(copy(ISOStr,15,2));
		Sec 	:= StrToInt(copy(ISOStr,18,2));
		MSec 	:= StrToInt(copy(ISOStr,21,6)) div 1000;

		result := EncodeDate( Year, Month, Day) + encodeTime(Hour, Min, Sec, MSec);
	except
    on e: exception do
		result := 0;
	end;
end;


var
  sLastTick : string = '';

function _GetCurrentTick : string;
var
  s : string;
  aDate : TdateTime;
begin
  // --
  repeat
    aDate := now;
    s := '1' + '-' + DateTimeToISOStr(aDate);

    if sLastTick <> s then
    begin
      sLastTick := s;
      break;
    end;
    sleep(10);
  until false;
  // --
  result := s;
end;


function _GetCurrentTick2 : string;
var
  s : string;
  aDate : TdateTime;
begin
  // --
  repeat
    aDate := now;
    s := '2' + '-' + DateTimeToISOStr(aDate);

    if sLastTick <> s then
    begin
      sLastTick := s;
      break;
    end;
    sleep(10);
  until false;
  // --
  result := s;
end;

function _StrToFloat(sValue : string) : double;
var
  i : integer;
  charDecimalSeparator : char;
begin
  charDecimalSeparator := SystemDecimalSeparator;

  result := 0.00;
  sValue := trim(sValue);
  if sValue ='' then exit;

  for i := 1 to length(sValue) do
  begin
    if not CharInSet(sValue[i], [' ', '0' .. '9', '-', '+',',','.']) then exit;
  end;

  for i := 1 to length(sValue) do
    if not CharInSet(sValue[i], [' ', '0' .. '9', '-', '+']) then
       sValue[i] := charDecimalSeparator;

  result := LocalizedFloatValue(sValue);
end;

function _FloatToStr(fValue : double; w, d : byte) : string;
var
  s : string;
  i : integer;
  charDecimalSeparator : char;
begin
  charDecimalSeparator := SystemDecimalSeparator;
  // --
  str(roundDecimals(fValue, d) : w : d, s);
  for i := 1 to length(s) do
    if not CharInSet(s[i], [' ', '0' .. '9', '-', '+']) then
      s[i] := charDecimalSeparator;
  result := s;
end;


function _dbStr(const aString : string; use_N_Prefix : boolean=true) : string;
var
  s : string;
begin
  s := aString;
  s := quotedStr(s);
  if use_N_Prefix then s := 'N'+s;
  result := s;
end;

function _dbInt(const aInt : integer) : string;
begin
  result := inttostr(aInt);
end;


function _GetExeByExtension(sExt : string) : string;
var
   sExtDesc:string;
begin
   with TRegistry.Create do
   begin
     try
       RootKey:=HKEY_CLASSES_ROOT;
       if OpenKeyReadOnly(sExt) then
       begin
         sExtDesc:=ReadString('') ;
         CloseKey;
       end;
       if sExtDesc <>'' then
       begin
         if OpenKeyReadOnly(sExtDesc + '\Shell\Open\Command') then
         begin
           Result:= ReadString('') ;
         end
       end;
     finally
       Free;
     end;
   end;

   if Result <> '' then
   begin
     if Result[1] = '"' then
     begin
       Result:=Copy(Result,2,-1 + Pos('"',Copy(Result,2,MaxINt))) ;
     end
   end;
end;


function RoomerQuotedString(s : String) : String;
begin
  if s = '' then
    s := ''''''
  else
  begin
    if copy(s, 1, 1) <> #39 then
       s := #39 + s;
    if (copy(s, length(s), 1) <> #39) OR (copy(s, length(s) - 1, 2) = '\'+#39) then
       s := s + #39;
  end;
  result := s;
end;

function _db(const aString : string)   : string; Overload;
begin
  result := RoomerQuotedString(StringReplace(aString, #39, '\' + #39, [rfReplaceAll]));
end;

function _db(const aString : char)   : string; Overload;
var s : String;
begin
  s := aString;
  result := RoomerQuotedString(StringReplace(s, #39, '\' + #39, [rfReplaceAll]));
end;


function _dbNullIfEmpty(const aString : string)   : string; Overload;
var value : String;
begin
  if aString='' then
    result := 'null'
  else
  begin
    value := StringReplace(aString, '''', '\''', [rfReplaceAll]);
    result := quotedstr(value);
  end;
end;


function _db(const aInt  : integer)    : string; Overload;
begin
  result := inttostr(aInt);
end;

function _db(const aBool : boolean)    : string; Overload;
begin
  result := BoolToString_0_1(aBool);
  if result = '-1' then result := '1';
end;

function _db(const aFloat : Extended)  : string; Overload;
var
  s : string;
begin
  s:=floatToStr(aFloat);
  result := _CommaToDot(S);
end;

function _db(const aFloat : double)  : string; Overload;
var
  s : string;
begin
  s:=floatToStr(aFloat);
  result := _CommaToDot(S);
end;

function _db(const aDate : TDateTime)  : string; Overload;
var
  S : string;
begin
  datetimetostring(S, 'yyyy-mm-dd', aDate);
  Result := quotedstr(S);
end;

function _db(const aTime: TTime): string; overload;
var
  S : string;
begin
  datetimetostring(S, 'hh:MM', aTime);
  if s = '00:00' then s := '';
  Result := quotedstr(S);
end;

function _dbDT(const aDate : TDateTime)  : string;
var
  S : string;
begin
  datetimetostring(S, 'yyyy-mm-dd hh:MM:ss', aDate);
  Result := quotedstr(S);
end;


function _db(const aDate : TDate)  : string; Overload;
var
  S : string;
begin
  datetimetostring(S, 'yyyy-mm-dd', aDate);
  Result := quotedstr(S);
end;

function _dbDateAndTime(const aDate : TDateTime; qouted : boolean=true)  : string;
var
  S : string;
begin
  datetimetostring(S, 'yyyy-mm-dd hh:nn:ss', aDate);
  if qouted then Result := quotedstr(S) else Result := S
end;


function _calcVAT(with_VAT, VATPrecent : double) : double;
var
  divBy : double;
begin
  result := 0;
  if with_VAT = 0 then
    exit;
  if VatPrecent = 0 then
    exit;

  divBy := (VatPrecent / 100) + 1;
  if divBy <> 0.00 then
    result := with_VAT - (with_VAT / divBy)
  else
    result := 0.00;
end;

function _calcNetAmount(with_VAT, Percent : double) : double;
var
  divBy : double;
begin
  result := 0;
  if with_VAT = 0 then
    exit;
  if Percent = 0 then
    exit;

  divBy := (Percent / 100) + 1;
  if divBy <> 0.00 then
    result := with_VAT / divBy
  else
    result := 0.00;
end;

function _lstNumEnCrypt(lstNotCrypt : TstringList; Key : Word) : TstringList;
var
  s : string;
  ss : string;
  i : integer;
  ii : integer;
  o : integer;
  ch : char;
  line : string;
begin
  result := TstringList.Create;

  for i := 0 to lstNotCrypt.Count - 1 do
  begin
    line := lstNotCrypt[i];
    if line = '' then
    begin
      ss := line;
    end else
    begin
      s := _strEncrypt(line,key);
      ss := '';
      for ii := 0 to length(s) do
      begin
        ch := s[ii];
        o := ord(ch);
        ss := ss+_intPadZeroLeft(o,3);
      end;
    end;
    result.Add(ss)
  end;
end;


function _lstNumDeCrypt(lstCrypt : TstringList; Key : Word) : TstringList;
var
  s    : string;
  ss   : string;
  sss  : string;
  i    : integer;
  cInt : integer;
  line : string;
begin
  result := TstringList.Create;
  for i := 0 to lstCrypt.Count-1 do
  begin
    line := lstCrypt[i];
    if length(line) > 3 then
    begin
      delete(line,1,3);
      ss := '';
      repeat
        s    := copy(line,1,3);
        cInt := strToInt(s);
        ss   := ss+char(cInt);
        delete(line,1,3);
      until length(line) < 3;
      sss := _strDeCrypt(ss,key);
      result.add(sss);
    end else
    begin
      result.add('');
    end;
  end;
end;

function _strNumDeCrypt(inn : string; Key : Word) : string;
var
  lstInn, lstOut : TstringList;
begin
  lstInn := TStringList.Create;
  try
    lstInn.Text := inn;
    lstOut := _lstNumDeCrypt(lstInn,key);
    try
      result := lstOut.Text;
    finally
      freeandNil(lstOut);
    end;
  finally
    freeandNil(lstInn);
  end;
end;

function _strNumEnCrypt(inn : string; Key : Word) : string;
var
  lstInn, lstOut : TstringList;
begin
  lstInn := TStringList.Create;
  try
    lstInn.Text := inn;
    lstOut := _lstNumEnCrypt(lstInn,key);
    try
      result := lstOut.Text;
    finally
      freeandNil(lstOut);
    end;
  finally
    freeandNil(lstInn);
  end;
end;


Function _WashInteger(s : string) : string;
const
  c_Numbers = ['0'..'9','-'];
var
  temp : string;
  i    : integer;
  c    : char;
begin
  s := trim(s);
  temp := '';

  for i := 1 to length(s) do
  begin
    c := s[i];
    if CharInSet(c, c_numbers) then
    begin
      temp := temp+c;
    end;
  end;

  s := temp;

  if length(s) > 1 then
  begin
    temp := s[1];
    for i := 2 to length(s) do
    begin
      c := s[i];
      if c <> '-' then
      begin
        temp := temp+c;
      end;
    end;
  end;

  s := temp;
  if s='-' then s := '';
  result := s;
end;


Function _WashJustNumbers(s : string) : string;
const
  c_Numbers = ['0'..'9'];
var
  temp : string;
  i    : integer;
  c    : char;
begin
  s := trim(s);
  temp := '';

  for i := 1 to length(s) do
  begin
    c := s[i];
    if CharInSet(c, c_numbers) then
    begin
      temp := temp+c;
    end;
  end;

  result := temp;
end;


function _TinyIntToColor(aInt : integer) : Tcolor;
var
  sHEX : string;
begin
  sHEX := 'clBlack';
  case aInt of
    0 :
      sHEX := 'clBlack'; // Black
    1 :
      sHEX := 'clMaroon'; // Maroon
    2 :
      sHEX := 'clGreen'; // Green
    3 :
      sHEX := 'clOlive'; // Olive
    4 :
      sHEX := 'clNavy'; // Navy
    5 :
      sHEX := 'clPurple'; // Purple
    6 :
      sHEX := 'clTeal'; // Teal
    7 :
      sHEX := 'clGray'; // Gray
    8 :
      sHEX := 'clSilver'; // Silver
    9 :
      sHEX := 'clRed'; // Red
    10 :
      sHEX := 'clLime'; // Lime
    11 :
      sHEX := 'clYellow'; // Yellow
    12 :
      sHEX := 'clBlue'; // Blue
    13 :
      sHEX := 'clFuchsia'; // Fuchsia
    14 :
      sHEX := 'clAqua'; // Aqua
    16 :
      sHEX := 'clWhite'; // White
    15 :
      sHEX := '$00FAFFFF'; // Aquamarine
    17 :
      sHEX := '$009F5F9F'; // BlueViolet
    18 :
      sHEX := '$0019D9D9'; // BrightGold
    19 :
      sHEX := '$002A2AA6'; // Brown
    20 :
      sHEX := '$003D7DA6'; // BronzeII
    21 :
      sHEX := '$009F9F5F'; // CadetBlue
    22 :
      sHEX := '$001987D9'; // CoolCopper
    23 :
      sHEX := '$003373B8'; // Copper
    24 :
      sHEX := '$00007FFF'; // Coral
    25 :
      sHEX := '$006F4242'; // CornFlowerBlue
    26 :
      sHEX := '$0033405C'; // DarkBrown
    27 :
      sHEX := '$0017335C'; // Baker'sChocolate
    28 :
      sHEX := '$002F4F2F'; // DarkGreen
    29 :
      sHEX := '$006E764A'; // DarkGreenCopper
    30 :
      sHEX := '$002F4F4F'; // DarkOliveGreen
    31 :
      sHEX := '$00CD3299'; // DarkOrchid
    32 :
      sHEX := '$00781F87'; // DarkPurple
    33 :
      sHEX := '$008E236B'; // DarkSlateBlue
    34 :
      sHEX := '$004F4F2F'; // DarkSlateGrey
    35 :
      sHEX := '$004F6997'; // DarkTan
    36 :
      sHEX := '$00DB9370'; // DarkTurquoise
    37 :
      sHEX := '$00545454'; // DimGrey
    38 :
      sHEX := '$00238E23'; // ForestGreen
    39 :
      sHEX := '$00327FCD'; // Gold
    40 :
      sHEX := '$0070DBDB'; // Goldenrod
    41 :
      sHEX := '$00767F52'; // GreenCopper
    42 :
      sHEX := '$0070DB93'; // GreenYellow
    43 :
      sHEX := '$00215E21'; // HunterGreen
    44 :
      sHEX := '$002F3F4E'; // IndianRed
    45 :
      sHEX := '$00D9D9C0'; // LightBlue
    46 :
      sHEX := '$00A8A8A8'; // LightGrey
    47 :
      sHEX := '$00BD8F8F'; // LightSteelBlue
    48 :
      sHEX := '$0032CD32'; // LimeGreen
    49 :
      sHEX := '$0042426F'; // Salmon
    50 :
      sHEX := '$00425E85'; // DarkWood
    51 :
      sHEX := '$00636385'; // DustyRose
    52 :
      sHEX := '$0053788C'; // Bronze
    53 :
      sHEX := '$0023238E'; // Firebrick
    54 :
      sHEX := '$0099CD32'; // MediumAquamarine
    55 :
      sHEX := '$00CD3232'; // MediumBlue
    56 :
      sHEX := '$00238E6B'; // MediumForestGreen
    57 :
      sHEX := '$00AEEAEA'; // MediumGoldenrod
    58 :
      sHEX := '$00DB7093'; // MediumOrchid
    59 :
      sHEX := '$00426F42'; // MediumSeaGreen
    60 :
      sHEX := '$00FF007F'; // MediumSlateBlue
    61 :
      sHEX := '$0000FF7F'; // MediumSpringGreen
    62 :
      sHEX := '$00DBDB70'; // MediumTurquoise
    63 :
      sHEX := '$009370DB'; // MediumVioletRed
    64 :
      sHEX := '$006480A6'; // MediumWood
    65 :
      sHEX := '$004F2F2F'; // MidnightBlue
    66 :
      sHEX := '$008E2323'; // NavyBlue
    67 :
      sHEX := '$00FF4D4D'; // NeonBlue
    68 :
      sHEX := '$00C76EFF'; // NeonPink
    69 :
      sHEX := '$009C0000'; // NewMidnightBlue
    70 :
      sHEX := '$003378E4'; // MandarianOrange
    71 :
      sHEX := '$007592D1'; // Feldspar
    72 :
      sHEX := '$007093DB'; // Tan
    73 :
      sHEX := '$00A6C2E9'; // LightWood
    74 :
      sHEX := '$009EC7EB'; // NewTan
    75 :
      sHEX := '$00B0CCF5'; // FadedBrown
    76 :
      sHEX := '$0042A6B5'; // Brass
    77 :
      sHEX := '$003BB5CF'; // OldGold
    78 :
      sHEX := '$005F9F9F'; // Khaki
    79 :
      sHEX := '$000024FF'; // OrangeRed
    80 :
      sHEX := '$00DB70DB'; // Orchid
    81 :
      sHEX := '$008FBC8F'; // PaleGreen
    82 :
      sHEX := '$008F8FBC'; // Pink
    83 :
      sHEX := '$00EAADEA'; // Plum
    84 :
      sHEX := '$00F3D9D9'; // Quartz
    85 :
      sHEX := '$00AB5959'; // RichBlue
    86 :
      sHEX := '$00688E23'; // SeaGreen
    87 :
      sHEX := '$0026426B'; // Semi-SweetChocolate
    88 :
      sHEX := '$00236B8E'; // Sienna
    89 :
      sHEX := '$00CC9932'; // SkyBlue
    90 :
      sHEX := '$00FF7F00'; // SlateBlue
    91 :
      sHEX := '$00AE1CFF'; // SpicyPink
    92 :
      sHEX := '$007FFF00'; // SpringGreen
    93 :
      sHEX := '$008E6B23'; // SteelBlue
    94 :
      sHEX := '$00DEB038'; // SummerSky
    95 :
      sHEX := '$00EAEAAD'; // Turquoise
    96 :
      sHEX := '$004F2F4F'; // Violet
    97 :
      sHEX := '$009932CC'; // VioletRed
    98 :
      sHEX := '$00BFD8D8'; // Wheat
    99 :
      sHEX := '$0032CC99'; // YellowGreen
  end;
  result := StringToColor(sHEX);
end;



function _GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;


Function _GetWindowsUser : string;
Var
   UserName : string;
   UserNameLen : Dword;
Begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   If GetUserName(PChar(UserName), UserNameLen) Then
     Result := Copy(UserName,1,UserNameLen - 1)
   Else
     Result := 'Unknown';
End;


function _justOneSpace(aText : string) : string;
begin
  aText := trim(aText);
  while pos('  ', aText) > 0 do
  begin
    delete(aText, pos('  ', aText) + 1, 1);
  end;
  result := aText;
end;

function _justOneChar(aText : string; ch : char) : string;
var
  s : string;
begin
  s := ch+ch;
  aText := trim(aText);
  while pos(s, aText) > 0 do
  begin
    delete(aText, pos(s, aText) + 1, 1);
  end;
  result := aText;
end;



function _DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer =
    (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result); { leap-year Feb is special }
end;

function _WeekNum(const TDT:TDateTime) : Word;
 var
   Y,M,D:Word;
   dtTmp:TDateTime;
 begin
   DecodeDate(TDT,Y,M,D) ;
   dtTmp := EnCodeDate(Y,1,1) ;
   Result :=
     (Trunc(TDT-dtTmp)+(DayOfWeek(dtTmp)-1)) DIV 7;
   if Result <> 0 then Result := Result - 1;
 end;

function _StatusToText(status : string) : string;
//var
//  ch : Char;
begin
  Result := TReservationState.FromResStatus(status).asReadableString;

//  result := 'unknown';
//  if trim(status) = '' then
//    exit;
//  status := UpperCase(status);
//  ch := status[1];
//  case ch of
//    STATUS_NOT_ARRIVED :
//      result := GetTranslatedText('shTx_G_NotArrived'); // 'Not arrived';
//    STATUS_ARRIVED :
//      result := GetTranslatedText('shTx_G_CheckedIn'); // 'Checked in';
//    STATUS_CHECKED_OUT :
//      result := GetTranslatedText('shTx_G_CheckedOut'); // 'Departed';
//    STATUS_WAITING_LIST :
//      result := GetTranslatedText('shTx_G_WaitingList'); // 'Optional booking';
//    STATUS_ALLOTMENT :
//      result := GetTranslatedText('shTx_G_Alotment'); // 'Alotment';
//    STATUS_NO_SHOW :
//      result := GetTranslatedText('shTx_G_NoShow'); // 'No-show';
//    STATUS_BLOCKED :
//      result := GetTranslatedText('shTx_G_Blocked'); // 'Blocked';
//    STATUS_Canceled :
//      result := GetTranslatedText('shTx_G_Cancelled'); // 'Cancelled';
//    STATUS_Tmp1 :
//      result := '[N/A]';
//    STATUS_AWAITING_PAYMENT :
//      result := 'Awaiting payment';
//
//  end;
end;

//  constants.Add('shTx_G_DueToArrive', 'Due to arrive');
//  constants.Add('shTx_G_NotArrived', 'Not Arrived');
//  constants.Add('shTx_G_CheckedIn', 'Checked In');
//  constants.Add('shTx_G_CheckedOut', 'Checked Out');
//  constants.Add('shTx_G_WaitingList', 'Waiting List');
//  constants.Add('shTx_G_Alotment', 'Allotment');
//  constants.Add('shTx_G_NoShow', 'No show');
//  constants.Add('shTx_G_Blocked', 'Blocked');
//  constants.Add('shTx_G_DepartingToday', 'Due to check out');
//  constants.Add('shTx_G_Cancelled', 'Cancelled');

//  constants.Add('shTx_G_DueToArrive', 'Due to arrive');
//  constants.Add('shTx_G_NotArrived', 'Not Arrived');
//  constants.Add('shTx_G_CheckedIn', 'Checked In');
//  constants.Add('shTx_G_CheckedOut', 'Checked Out');
//  constants.Add('shTx_G_WaitingList', 'Waiting List');
//  constants.Add('shTx_G_Alotment', 'Allotment');
//  constants.Add('shTx_G_NoShow', 'No show');
//  constants.Add('shTx_G_Blocked', 'Blocked');
//  constants.Add('shTx_G_DepartingToday', 'Due to check out');
//  constants.Add('shTx_G_Cancelled', 'Cancelled');


function _BreakfastToText(included : Boolean) : string;
begin
  Result := TBreakfastState.FromBool(included).AsReadableString;
end;

function _AccountTypeToText(isGroupAccount : Boolean) : string;
begin
  Result := TAccountType.FromBool(IsGroupAccount).AsReadableString;
end;

function _TimeStrToSec(TimeStr : string) : integer;
var
  h : integer;
  m : integer;
  s : integer;

  sh : string;
  sm : string;
  ss : string;

  p : integer;

begin
  result := 0;
  TimeStr := trim(TimeStr);
  if length(TimeStr) < 8 then exit;

  p := pos(':',TimeStr);

  sh := copy(Timestr,1,p-1);
  sm := copy(TimeStr,p+1,2);
  ss := copy(TimeStr,p+4,2);

  s := strToInt(ss);
  m := strToInt(sm);
  h := strToInt(sh);

  result := s;
  result := result+m*60;
  result := result+((h*60)*60)
end;

function _appendLine(path : string; line : string) : boolean;
var
  logFile : TextFile;

  FileName : string;
  sDate : string;

begin
  result := True;
  dateTimeTostring(sDate,'yyyymmdd',now);
  FileName := _addslash(path)+sDate+'Log.txt';

  if not fileExists(FileName) then
  begin
    try
      AssignFile(logFile,FileName);
      Rewrite(logFile);
      WriteLn(logFile, line);
      CloseFile(logFile);
    Except
      on E : Exception do
      begin
      end;
    end;
  end else
  begin
    try
      AssignFile(logFile, FileName);
      Reset(logFile);
      Append(logFile);
      WriteLn(logFile, line);
      CloseFile(logFile);
    Except
      on E : Exception do
      begin
      end;
    end;
  end;
end;


function DebugLogStart(sText1,sText2,path : string; logLevel : integer) : boolean;
begin
  result := true;
  if (loglevel=100) then
  begin
    tickcountStart := getTickCount;
    _appendLine(Path,sText2);
    _appendLine(Path,sText1);
  end;
end;

function DebugLogEnd(sText,path : string; logLevel : integer) : boolean;
begin
  result := true;
  if loglevel=100 then
  begin
    tickcountEnd := getTickCount;
    _appendLine(Path,'--- Time : '+inttostr(tickcountEnd-tickcountStart));
    _appendLine(Path,sText);

  end;
end;


procedure _RestoreForm(aForm : TForm);
var
  MonitorCount : integer;
  maxLeft : integer;
  i : integer;
begin
  MonitorCount := screen.MonitorCount;

  maxLeft := 0;
  for i := 0 to MonitorCount - 1 do
  begin
    maxLeft := maxLeft + screen.Width;
  end;

  maxLeft := maxLeft - 150;
  if aForm.left > maxLeft then
    aForm.left := maxLeft;
end;

function SystemThousandsSeparator : char;
var Thousands : PChar;
begin
  Thousands := StrAlloc(10);
  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_STHOUSAND, Thousands, 10);
  result := String(Thousands)[1];
end;



(*
CREATE  TABLE `home100_kef`.`dictionary` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `Code` VARCHAR(45) NULL ,
  `Result` VARCHAR(45) NULL ,
  `LangId` INT NULL DEFAULT 0 ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) );


INSERT INTO `home100_kef`.`dictionary` (`Code`, `Result`, `LangId`) VALUES ('P', 'Not arrived', '0');
INSERT INTO `home100_kef`.`dictionary` (`Code`, `Result`, `LangId`) VALUES ('G', 'Checked in', '0');
INSERT INTO `home100_kef`.`dictionary` (`Code`, `Result`, `LangId`) VALUES ('D', 'Departed', '0');
INSERT INTO `home100_kef`.`dictionary` (`Code`, `Result`, `LangId`) VALUES ('O', 'Waitinglist', '0');
INSERT INTO `home100_kef`.`dictionary` (`Code`, `Result`, `LangId`) VALUES ('A', 'Alotment', '0');
INSERT INTO `home100_kef`.`dictionary` (`Code`, `Result`, `LangId`) VALUES ('N', 'No-show', '0');
INSERT INTO `home100_kef`.`dictionary` (`Code`, `Result`, `LangId`) VALUES ('B', 'Blocked', '0');
*)

end.


