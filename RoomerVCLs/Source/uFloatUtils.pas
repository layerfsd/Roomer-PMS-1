unit uFloatUtils;

interface


function SystemDecimalSeparator: char;
function SystemThousandsSeparator: char;
function LocalizedFloatToString(number: Double): String;
function LocalizedFloatValue(value: String; save: boolean = true): Double;
function RoundDecimals(value: Double; Decimals: Integer): Double;


implementation

uses
    Math
  , SysUtils
  ;

function RoundDecimals(value: Double; Decimals: Integer): Double;
begin
  result := Power10( Round(Power10(value, Decimals)), -Decimals);
end;

function SystemDecimalSeparator: char;
//var
//  Decimal: PChar;
begin
  Result := TFormatSettings.Create.DecimalSeparator;
//  Decimal := StrAlloc(10);
//  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SDECIMAL, Decimal, 10);
//  result := String(Decimal)[1];
end;

function SystemThousandsSeparator: char;
//var
//  Thousands: PChar;
begin
  Result := TFormatSettings.Create.ThousandSeparator;
//  Thousands := StrAlloc(10);
//  GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_STHOUSAND, Thousands, 10);
//  result := String(Thousands)[1];
end;

function LocalizedFloatToString(number: Double): String;
begin
  result := Trim(StringReplace(StringReplace(FloatToStr(number), '.', SystemDecimalSeparator, [rfReplaceAll]), ',', SystemDecimalSeparator, [rfReplaceAll]));
end;

function LocalizedFloatValue(value: String; save: boolean = true): Double;
var
  S: String;
begin
  if not TryStrToFloat(Value, Result) then
    if not TryStrToFloat(StringReplace(value, '.', ',', [rfReplaceAll]), Result) then
      if not TryStrToFloat(StringReplace(value, '.', '·', [rfReplaceAll]), Result) then
        if not TryStrToFloat(StringReplace(value, '.', '''', [rfReplaceAll]), Result) then
          if not TryStrToFloat(StringReplace(value, ',', '.', [rfReplaceAll]), Result) then
            if not TryStrToFloat(StringReplace(value, ',', '·', [rfReplaceAll]), Result) then
              if not TryStrToFloat(StringReplace(value, ',', '''', [rfReplaceAll]), Result) then
                if not TryStrToFloat(StringReplace(value, '''', '.', [rfReplaceAll]), Result) then
                  if not TryStrToFloat(StringReplace(value, '''', '·', [rfReplaceAll]), Result) then
                    if not TryStrToFloat(StringReplace(value, '''', ',', [rfReplaceAll]), Result) then
                      if not TryStrToFloat(StringReplace(value, '·', '.', [rfReplaceAll]), Result) then
                        if not TryStrToFloat(StringReplace(value, '·', ',', [rfReplaceAll]), Result) then
                          if not TryStrToFloat(StringReplace(value, '·', '''', [rfReplaceAll]), Result) then
                          begin
                            S := Trim(StringReplace(StringReplace(value, '.', SystemDecimalSeparator, [rfReplaceAll]), ',', SystemDecimalSeparator,
                              [rfReplaceAll]));
                            if save then
                              result := StrToFloatDef(StringReplace(S, '.', SystemDecimalSeparator, [rfReplaceAll]), 0)
                            else
                              result := StrToFloat(StringReplace(S, '.', SystemDecimalSeparator, [rfReplaceAll]));
                          end;
end;





end.
