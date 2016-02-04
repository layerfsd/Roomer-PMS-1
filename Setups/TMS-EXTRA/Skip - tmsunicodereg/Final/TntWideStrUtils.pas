{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 - 2008 by TMS software                                   }
{ Email : info@tmssoftware.com                                              }
{ Web : http://www.tmssoftware.com                                          }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}   

unit TntWideStrUtils;

{$INCLUDE TntCompilers.inc}

interface

uses
    Controls;

{ Wide string manipulation functions }

{$IFNDEF COMPILER_9_UP}
function WStrAlloc(Size: Cardinal): PWideChar;
function WStrBufSize(const Str: PWideChar): Cardinal;
{$ENDIF}
{$IFNDEF COMPILER_10_UP}
function WStrMove(Dest: PWideChar; const Source: PWideChar; Count: Cardinal): PWideChar;
{$ENDIF}
{$IFNDEF COMPILER_9_UP}
function WStrNew(const Str: PWideChar): PWideChar;
procedure WStrDispose(Str: PWideChar);
{$ENDIF}
//---------------------------------------------------------------------------------------------
{$IFNDEF COMPILER_9_UP}
function WStrLen(Str: PWideChar): Cardinal;
function WStrEnd(Str: PWideChar): PWideChar;
{$ENDIF}
{$IFNDEF COMPILER_10_UP}
function WStrCat(Dest: PWideChar; const Source: PWideChar): PWideChar;
{$ENDIF}
{$IFNDEF COMPILER_9_UP}
function WStrCopy(Dest, Source: PWideChar): PWideChar;
function WStrLCopy(Dest, Source: PWideChar; MaxLen: Cardinal): PWideChar;
function WStrPCopy(Dest: PWideChar; const Source: WideString): PWideChar;
function WStrPLCopy(Dest: PWideChar; const Source: WideString; MaxLen: Cardinal): PWideChar;
{$ENDIF}
{$IFNDEF COMPILER_10_UP}
function WStrScan(const Str: PWideChar; Chr: WideChar): PWideChar;
// WStrComp and WStrPos were introduced as broken in Delphi 2006, but fixed in Delphi 2006 Update 2
function WStrComp(Str1, Str2: PWideChar): Integer;
function WStrPos(Str, SubStr: PWideChar): PWideChar;
{$ENDIF}
function Tnt_WStrComp(Str1, Str2: PWideChar): Integer; deprecated;
function Tnt_WStrPos(Str, SubStr: PWideChar): PWideChar; deprecated;

{ ------------ introduced --------------- }
function WStrECopy(Dest, Source: PWideChar): PWideChar;
function WStrLComp(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
function WStrLIComp(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
function WStrIComp(Str1, Str2: PWideChar): Integer;
function WStrLower(Str: PWideChar): PWideChar;
function WStrUpper(Str: PWideChar): PWideChar;
function WStrRScan(const Str: PWideChar; Chr: WideChar): PWideChar;
function WStrLCat(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar;
function WStrPas(const Str: PWideChar): WideString;

type
  TStringSeachOption = (soDown, soMatchCase, soWholeWord);
  TStringSearchOptions = set of TStringSeachOption;

function SearchBuf(Buf: PWideChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: WideString; Options: TStringSearchOptions = [soDown]): PWideChar;

procedure Tnt_ReplaceSelection(Control: TWinControl; Value: WideString);

{ SysUtils.pas } //-------------------------------------------------------------------------

{$IFNDEF COMPILER_10_UP}
function WideLastChar(const S: WideString): PWideChar;
function WideQuotedStr(const S: WideString; Quote: WideChar): WideString;
{$ENDIF}
{$IFNDEF COMPILER_9_UP}
function WideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): Widestring;
{$ENDIF}
{$IFNDEF COMPILER_10_UP}
function WideDequotedStr(const S: WideString; AQuote: WideChar): WideString;
{$ENDIF}

implementation

uses
  {$IFDEF COMPILER_9_UP} WideStrUtils, {$ENDIF} Math, Windows, TntWindows,
  SysUtils, Messages;

{$IFNDEF COMPILER_9_UP}
function WStrAlloc(Size: Cardinal): PWideChar;
begin
  Size := SizeOf(Cardinal) + (Size * SizeOf(WideChar));
  GetMem(Result, Size);
  PCardinal(Result)^ := Size;
  Inc(PAnsiChar(Result), SizeOf(Cardinal));
end;

function WStrBufSize(const Str: PWideChar): Cardinal;
var
  P: PWideChar;
begin
  P := Str;
  Dec(PAnsiChar(P), SizeOf(Cardinal));
  Result := PCardinal(P)^ - SizeOf(Cardinal);
  Result := Result div SizeOf(WideChar);
end;
{$ENDIF}

{$IFNDEF COMPILER_10_UP}
function WStrMove(Dest: PWideChar; const Source: PWideChar; Count: Cardinal): PWideChar;
var
  Length: Integer;
begin
  Result := Dest;
  Length := Count * SizeOf(WideChar);
  Move(Source^, Dest^, Length);
end;
{$ENDIF}

{$IFNDEF COMPILER_9_UP}
function WStrNew(const Str: PWideChar): PWideChar;
var
  Size: Cardinal;
begin
  if Str = nil then Result := nil else
  begin
    Size := WStrLen(Str) + 1;
    Result := WStrMove(WStrAlloc(Size), Str, Size);
  end;
end;

procedure WStrDispose(Str: PWideChar);
begin
  if Str <> nil then
  begin
    Dec(PAnsiChar(Str), SizeOf(Cardinal));
    FreeMem(Str, Cardinal(Pointer(Str)^));
  end;
end;
{$ENDIF}

//---------------------------------------------------------------------------------------------

{$IFNDEF COMPILER_9_UP}
function WStrLen(Str: PWideChar): Cardinal;
begin
  Result := WStrEnd(Str) - Str;
end;

function WStrEnd(Str: PWideChar): PWideChar;
begin
  // returns a pointer to the end of a null terminated string
  Result := Str;
  While Result^ <> #0 do
    Inc(Result);
end;
{$ENDIF}

{$IFNDEF COMPILER_10_UP}
function WStrCat(Dest: PWideChar; const Source: PWideChar): PWideChar;
begin
  Result := Dest;
  WStrCopy(WStrEnd(Dest), Source);
end;
{$ENDIF}

{$IFNDEF COMPILER_9_UP}
function WStrCopy(Dest, Source: PWideChar): PWideChar;
begin
  Result := WStrLCopy(Dest, Source, MaxInt);
end;

function WStrLCopy(Dest, Source: PWideChar; MaxLen: Cardinal): PWideChar;
var
  Count: Cardinal;
begin
  // copies a specified maximum number of characters from Source to Dest
  Result := Dest;
  Count := 0;
  While (Count < MaxLen) and (Source^ <> #0) do begin
    Dest^ := Source^;
    Inc(Source);
    Inc(Dest);
    Inc(Count);
  end;
  Dest^ := #0;
end;

function WStrPCopy(Dest: PWideChar; const Source: WideString): PWideChar;
begin
  Result := WStrLCopy(Dest, PWideChar(Source), Length(Source));
end;

function WStrPLCopy(Dest: PWideChar; const Source: WideString; MaxLen: Cardinal): PWideChar;
begin
  Result := WStrLCopy(Dest, PWideChar(Source), MaxLen);
end;
{$ENDIF}

{$IFNDEF COMPILER_10_UP}
function WStrScan(const Str: PWideChar; Chr: WideChar): PWideChar;
begin
  Result := Str;
  while Result^ <> Chr do
  begin
    if Result^ = #0 then
    begin
      Result := nil;
      Exit;
    end;
    Inc(Result);
  end;
end;

function WStrComp(Str1, Str2: PWideChar): Integer;
begin
  Result := WStrLComp(Str1, Str2, MaxInt);
end;

function WStrPos(Str, SubStr: PWideChar): PWideChar;
var
  PSave: PWideChar;
  P: PWideChar;
  PSub: PWideChar;
begin
  // returns a pointer to the first occurance of SubStr in Str
  Result := nil;
  if (Str <> nil) and (Str^ <> #0) and (SubStr <> nil) and (SubStr^ <> #0) then begin
    P := Str;
    While P^ <> #0 do begin
      if P^ = SubStr^ then begin
        // investigate possibility here
        PSave := P;
        PSub := SubStr;
        While (P^ = PSub^) do begin
          Inc(P);
          Inc(PSub);
          if (PSub^ = #0) then begin
            Result := PSave;
            exit; // found a match
          end;
          if (P^ = #0) then
            exit; // no match, hit end of string
        end;
        P := PSave;
      end;
      Inc(P);
    end;
  end;
end;
{$ENDIF}

function Tnt_WStrComp(Str1, Str2: PWideChar): Integer; deprecated;
begin
  Result := WStrComp(Str1, Str2);
end;

function Tnt_WStrPos(Str, SubStr: PWideChar): PWideChar; deprecated;
begin
  Result := WStrPos(Str, SubStr);
end;

//------------------------------------------------------------------------------

function WStrECopy(Dest, Source: PWideChar): PWideChar;
begin
  Result := WStrEnd(WStrCopy(Dest, Source));
end;

function WStrComp_EX(Str1, Str2: PWideChar; MaxLen: Cardinal; dwCmpFlags: Cardinal): Integer;
var
  Len1, Len2: Integer;
begin
  if MaxLen = Cardinal(MaxInt) then begin
    Len1 := -1;
    Len2 := -1;
  end else begin
    Len1 := Min(WStrLen(Str1), MaxLen);
    Len2 := Min(WStrLen(Str2), MaxLen);
  end;
  Result := Tnt_CompareStringW(GetThreadLocale, dwCmpFlags, Str1, Len1, Str2, Len2) - 2;
end;

function WStrLComp(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
begin
  Result := WStrComp_EX(Str1, Str2, MaxLen, 0);
end;

function WStrLIComp(Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
begin
  Result := WStrComp_EX(Str1, Str2, MaxLen, NORM_IGNORECASE);
end;

function WStrIComp(Str1, Str2: PWideChar): Integer;
begin
  Result := WStrLIComp(Str1, Str2, MaxInt);
end;

function WStrLower(Str: PWideChar): PWideChar;
begin
  Result := Str;
  Tnt_CharLowerBuffW(Str, WStrLen(Str))
end;

function WStrUpper(Str: PWideChar): PWideChar;
begin
  Result := Str;
  Tnt_CharUpperBuffW(Str, WStrLen(Str))
end;

function WStrRScan(const Str: PWideChar; Chr: WideChar): PWideChar;
var
  MostRecentFound: PWideChar;
begin
  if Chr = #0 then
    Result := WStrEnd(Str)
  else
  begin
    Result := nil;
    MostRecentFound := Str;
    while True do
    begin
      while MostRecentFound^ <> Chr do
      begin
        if MostRecentFound^ = #0 then
          Exit;
        Inc(MostRecentFound);
      end;
      Result := MostRecentFound;
      Inc(MostRecentFound);
    end;
  end;
end;

function WStrLCat(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar;
begin
  Result := Dest;
  WStrLCopy(WStrEnd(Dest), Source, MaxLen - WStrLen(Dest));
end;

function WStrPas(const Str: PWideChar): WideString;
begin
  Result := Str;
end;

procedure Tnt_ReplaceSelection(Control: TWinControl; Value: WideString);
begin
  Control.Perform(EM_REPLACESEL, 0, Longint(PWideChar(Value)));
end;

function IsWordDelimiter(const AValue: WideChar): Boolean;
begin
  Result := (AValue >= #0) and (AValue <= #255)
    and not ((AValue >= 'a') and (AValue <= 'z'))
    and not ((AValue >= 'A') and (AValue <= 'Z'))
    and not ((AValue >= '0') and (AValue <= '9'));
end;


function SearchBuf(Buf: PWideChar; BufLen: Integer; SelStart, SelLength: Integer;
  SearchString: WideString; Options: TStringSearchOptions): PWideChar;
var
  SearchCount, I: Integer;
  //C: WChar;
  Direction: Shortint;
  ShadowMap: array[0..256] of WChar;
  //CharMap: array [WChar] of WChar absolute ShadowMap;
  //Res: WideString;

  function FindNextWordStart(var BufPtr: PWideChar): Boolean;
  begin                   { (True XOR N) is equivalent to (not N) }
                          { (False XOR N) is equivalent to (N)    }
     { When Direction is forward (1), skip non delimiters, then skip delimiters. }
     { When Direction is backward (-1), skip delims, then skip non delims }
    while (SearchCount > 0) and
          ((Direction = 1) xor IsWordDelimiter(BufPtr^)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    while (SearchCount > 0) and
          ((Direction = -1) xor IsWordDelimiter(BufPtr^)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SearchCount);
    end;
    Result := SearchCount > 0;
    if Direction = -1 then
    begin   { back up one char, to leave ptr on first non delim }
      Dec(BufPtr, Direction);
      Inc(SearchCount);
    end;
  end;

begin
  Result := nil;
  if BufLen <= 0 then Exit;
  if soDown in Options then
  begin
    Direction := 1;
    Inc(SelStart, SelLength);  { start search past end of selection }
    SearchCount := BufLen - SelStart - Length(SearchString) + 1;
    if SearchCount < 0 then Exit;
    if Longint(SelStart) + SearchCount > BufLen then Exit;
  end
  else
  begin
    Direction := -1;
    Dec(SelStart, Length(SearchString));
    SearchCount := SelStart + 1;
  end;
  if (SelStart < 0) or (SelStart > BufLen) then Exit;
  
  CharUpperBuffW(PWideChar(@Buf[1]), Length(Buf));
  Result := PWideChar(@Buf[SelStart]);
  //Res := Buf; //WideString(Copy(Buf, SelStart+1, Length(Buf)));

  { Using a Char map array is faster than calling AnsiUpper on every character }
  {for C := Low(Char) to High(Char) do
    CharMap[C] := C;}
  { Since CharMap is overlayed onto the ShadowMap and ShadowMap is 1 byte longer,
    we can use that extra byte as a guard NULL }
  ShadowMap[256] := #0;

  if not (soMatchCase in Options) then
  begin
{$IFDEF MSWINDOWS}
    //AnsiUpperBuff(PChar(@CharMap), sizeof(CharMap));
    //CharUpperBuffW(PWideChar(@CharMap), 256);
    //AnsiUpperBuff(@SearchString[1], Length(SearchString));
    CharUpperBuffW(@SearchString[1], Length(SearchString));
    //CharUpperBuffW(@Res[1], Length(Res));
    //Result := @Res[SelStart];
{$ENDIF}
{$IFDEF LINUX}
    //AnsiStrUpper(@CharMap[#1]);
    WStrUpper(@CharMap[#1]);
    //SearchString := AnsiUpperCase(SearchString);
    SearchString := Tnt_WideUpperCase(SearchString);
{$ENDIF}
  end;

  while SearchCount > 0 do
  begin
    if (soWholeWord in Options) and (Result <> PWideChar(@Buf[SelStart])) then
      if not FindNextWordStart(Result) then Break;
    I := 0;
    while (Result[I] = SearchString[I+1]) do
    begin
      Inc(I);
      if I >= Length(SearchString) then
      begin
        if (not (soWholeWord in Options)) or
           (SearchCount = 0) or
           IsWordDelimiter(Result[I]) then
           //Dec(Result, Direction);
          Exit;
        Break;
      end;
    end;
    Inc(Result, Direction);
    //Res := WideString(Copy(Res, 2, Length(Res)));
    Dec(SearchCount);
  end;
  Result := nil;
end;

//---------------------------------------------------------------------------------------------

{$IFNDEF COMPILER_10_UP}
function WideLastChar(const S: WideString): PWideChar;
begin
  if S = '' then
    Result := nil
  else
    Result := @S[Length(S)];
end;

function WideQuotedStr(const S: WideString; Quote: WideChar): WideString;
var
  P, Src,
  Dest: PWideChar;
  AddCount: Integer;
begin
  AddCount := 0;
  P := WStrScan(PWideChar(S), Quote);
  while (P <> nil) do
  begin
    Inc(P);
    Inc(AddCount);
    P := WStrScan(P, Quote);
  end;

  if AddCount = 0 then
    Result := Quote + S + Quote
  else
  begin
    SetLength(Result, Length(S) + AddCount + 2);
    Dest := PWideChar(Result);
    Dest^ := Quote;
    Inc(Dest);
    Src := PWideChar(S);
    P := WStrScan(Src, Quote);
    repeat
      Inc(P);
      Move(Src^, Dest^, 2 * (P - Src));
      Inc(Dest, P - Src);
      Dest^ := Quote;
      Inc(Dest);
      Src := P;
      P := WStrScan(Src, Quote);
    until P = nil;
    P := WStrEnd(Src);
    Move(Src^, Dest^, 2 * (P - Src));
    Inc(Dest, P - Src);
    Dest^ := Quote;
  end;
end;
{$ENDIF}

{$IFNDEF COMPILER_9_UP}
function WideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): Widestring;
var
  P, Dest: PWideChar;
  DropCount: Integer;
begin
  Result := '';
  if (Src = nil) or (Src^ <> Quote) then Exit;
  Inc(Src);
  DropCount := 1;
  P := Src;
  Src := WStrScan(Src, Quote);
  while Src <> nil do   // count adjacent pairs of quote chars
  begin
    Inc(Src);
    if Src^ <> Quote then Break;
    Inc(Src);
    Inc(DropCount);
    Src := WStrScan(Src, Quote);
  end;
  if Src = nil then Src := WStrEnd(P);
  if ((Src - P) <= 1) then Exit;
  if DropCount = 1 then
    SetString(Result, P, Src - P - 1)
  else
  begin
    SetLength(Result, Src - P - DropCount);
    Dest := PWideChar(Result);
    Src := WStrScan(P, Quote);
    while Src <> nil do
    begin
      Inc(Src);
      if Src^ <> Quote then Break;
      Move(P^, Dest^, (Src - P) * SizeOf(WideChar));
      Inc(Dest, Src - P);
      Inc(Src);
      P := Src;
      Src := WStrScan(Src, Quote);
    end;
    if Src = nil then Src := WStrEnd(P);
    Move(P^, Dest^, (Src - P - 1) * SizeOf(WideChar));
  end;
end;
{$ENDIF}

{$IFNDEF COMPILER_10_UP}
function WideDequotedStr(const S: WideString; AQuote: WideChar): WideString;
var
  LText : PWideChar;
begin
  LText := PWideChar(S);
  Result := WideExtractQuotedStr(LText, AQuote);
  if Result = '' then
    Result := S;
end;
{$ENDIF}


end.
