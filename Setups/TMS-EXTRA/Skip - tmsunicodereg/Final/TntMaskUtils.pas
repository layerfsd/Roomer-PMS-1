unit TntMaskUtils;

{$INCLUDE TntCompilers.inc}

interface

uses
  TntSysUtils, MaskUtils, SysUtils;

function MaskIntlLiteralToWChar(IChar: WideChar): WideChar;
function MaskDoFormatTextW(const EditMask: string; const Value: Widestring; Blank: Char): WideString;
function PadInputLiteralsW(const EditMask: String; const Value: WideString; Blank: Char): WideString;

implementation

function MaskIntlLiteralToWChar(IChar: WideChar): WideChar;
begin
  Result := IChar;
  case IChar of

    {$IFNDEF DELPHI_XE3}
    mMskTimeSeparator: Result := WideChar(TimeSeparator);
    mMskDateSeparator: Result := WideChar(DateSeparator);
    {$ENDIF}
    {$IFDEF DELPHI_XE3}
    mMskTimeSeparator: Result := WideChar(FormatSettings.TimeSeparator);
    mMskDateSeparator: Result := WideChar(FormatSettings.DateSeparator);
    {$ENDIF}
  end;
end;

function MaskDoFormatTextW(const EditMask: string; const Value: Widestring;
  Blank: Char): Widestring;
var
  I: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  Dir: TMaskDirectives;
begin
  Result := Value;
  Dir := MaskGetCurrentDirectives(EditMask, 1);

  if not (mdReverseDir in Dir) then
  begin
      { starting at the beginning, insert literal chars in the string
        and add spaces on the end }
    Offset := 1;
    for MaskOffset := 1 to Length(EditMask) do
    begin
      CType := MaskGetCharType(EditMask, MaskOffset);

      if CType in [mcLiteral, mcIntlLiteral] then
      begin
        Result := Copy(Result, 1, Offset - 1) +
          MaskIntlLiteralToChar(EditMask[MaskOffset]) +
          Copy(Result, Offset, Length(Result) - Offset + 1);
        Inc(Offset);
      end
      else if CType in [mcMask, mcMaskOpt] then
      begin
        if Offset > Length(Result) then
          Result := Result + Blank;
        Inc(Offset);
      end;
    end;
  end
  else
  begin
      { starting at the end, insert literal chars in the string
        and add spaces at the beginning }
    Offset := Length(Result);
    for I := 0 to(Length(EditMask) - 1) do
    begin
      MaskOffset := Length(EditMask) - I;
      CType := MaskGetCharType(EditMask, MaskOffset);
      if CType in [mcLiteral, mcIntlLiteral] then
      begin
        Result := Copy(Result, 1, Offset) +
               MaskIntlLiteralToChar(EditMask[MaskOffset]) +  
               Copy(Result, Offset + 1, Length(Result) - Offset);
      end
      else if CType in [mcMask, mcMaskOpt] then
      begin
        if Offset < 1 then
          Result := Blank + Result
        else
          Dec(Offset);
      end;
    end;
  end;
end;

function PadSubFieldW(const EditMask: String; const Value: WideString;
  StartFld, StopFld, Len: Integer; Blank: Char): WideString;
var
  Dir: TMaskDirectives;
  StartPad: Integer;
  K: Integer;
begin
  if (StopFld - StartFld) < Len then
  begin
     { found literal at position J, now pad it }
    Dir := MaskGetCurrentDirectives(EditMask, 1);
    StartPad := StopFld - 1;
    if mdReverseDir in Dir then
      StartPad := StartFld - 1;
    Result := Copy(Value, 1, StartPad);
    for K := 1 to (Len - (StopFld - StartFld)) do
      Result := Result + Blank;
    Result := Result + Copy(Value, StartPad + 1, Length(Value));
  end
  else if (StopFld - StartFld) > Len then
  begin
    Dir := MaskGetCurrentDirectives(EditMask, 1);
    if mdReverseDir in Dir then
      Result := Copy(Value, 1, StartFld - 1) +
        Copy(Value, StopFld - Len, Length(Value))
    else
      Result := Copy(Value, 1, StartFld + Len - 1) +
        Copy(Value, StopFld, Length(Value));
  end
  else
    Result := Value;
end;

{$WARNINGS OFF}
function PadInputLiteralsW(const EditMask: String; const Value: WideString;
  Blank: Char): WideString;
var
  J: Integer;
  LastLiteral, EndSubFld: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  MaxChars: Integer;
begin
  LastLiteral := 0;

  Result := Value;
  for MaskOffset := 1 to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral] then
    begin
      Offset := MaskOffsetToOffset(EditMask, MaskOffset);
      EndSubFld := Length(Result) + 1;
      for J := LastLiteral + 1 to Length(Result) do
      begin
        if Result[J] = WideChar(MaskIntlLiteralToChar(EditMask[MaskOffset])) then
        begin
          EndSubFld := J;
          Break;
        end;
      end;
       { we have found a subfield, ensure that it complies }
      if EndSubFld > Length(Result) then
        Result := Result + MaskIntlLiteralToChar(EditMask[MaskOffset]);
      Result := PadSubFieldW(EditMask, Result, LastLiteral + 1, EndSubFld,
        Offset - (LastLiteral + 1), Blank);
      LastLiteral := Offset;
    end;
  end;

    {ensure that the remainder complies, too }
  MaxChars  := MaskOffsetToOffset(EditMask, Length(EditMask));
  if Length (Result) <> MaxChars then
    Result := PadSubFieldW(EditMask, Result, LastLiteral + 1, Length (Result) + 1,
      MaxChars - LastLiteral, Blank);

    { replace non-literal blanks with blank char }
  for Offset := 1 to Length (Result) do
  begin
    if Result[Offset] = ' ' then
    begin
      if not IsLiteralChar(EditMask, Offset - 1) then
        Result[Offset] := WideChar(Blank);
    end;
  end;
end;
{$WARNINGS ON}
end.
