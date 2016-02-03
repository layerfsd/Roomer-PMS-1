unit uDateUtils;

interface

uses Soap.XSBuiltIns, SysUtils, Windows;

function CreateTSXDate(date : TDateTime) : TXSDateTime;
function dateToJsonString(date : TDateTime) : String;
function dateTimeToXmlString(date : TDateTime) : String;
function dateToSqlString(date : TDateTime) : String;
function JsonStringToDate(dateStr : String) : TDateTime;
function XmlStringToDate(dateStr : String) : TDateTime;
function SqlStringToDate(dateStr : String) : TDateTime;
function WeekNumber(date: TDateTime): integer;
function DateTimeToDBString(date : TDateTime) : String;
function DateTimeToComparableString(date : TDateTime) : String;
function Month(ADate : TDateTime) : Integer;
function Year(ADate : TDateTime) : Integer;
function DayOfMonth(ADate : TDateTime) : Integer;
function CreateDate(aYear, aMonth, aDay : Integer) : TDate;

implementation

function CreateDate(aYear, aMonth, aDay : Integer) : TDate;
begin
  result := encodeDate(aYear, aMonth, aDay);
end;

function Month(ADate : TDateTime) : Integer;
var y, m, d : Word;
begin
  decodeDate(ADate, y, m, d);
  result := m;
end;

function Year(ADate : TDateTime) : Integer;
var y, m, d : Word;
begin
  decodeDate(ADate, y, m, d);
  result := y;
end;

function DayOfMonth(ADate : TDateTime) : Integer;
var y, m, d : Word;
begin
  decodeDate(ADate, y, m, d);
  result := d;
end;

function WeekNumber(date: TDateTime): integer;
var
  YearFirst: TDateTime;
  Year, Month, MonthDay: Word;
  More, Days: integer;
begin
  More := 1;
  DecodeDate(date, Year, Month, MonthDay);
  YearFirst := EncodeDate(Year, 1, 1);
  case DayOfWeek(date) of
    1:
      More := 0;
    2 .. 7:
      More := 1;
  end;
  Days := trunc(date - YearFirst) + 1;
  Result := (Days div 7) + More;
end;

function CreateTSXDate(date : TDateTime) : TXSDateTime;
begin
  result := TXSDateTime.Create;
  result.AsDateTime := date;
end;

function dateToSqlString(date : TDateTime) : String;
begin
  result := FormatDateTime('yyyy-mm-dd', date);
end;

function dateTimeToXmlString(date : TDateTime) : String;
begin
  result := FormatDateTime('yyyy-mm-dd', date) + 'T' +
            FormatDateTime('hh:nn:ss', date);
end;

function dateToJsonString(date : TDateTime) : String;
begin
  result := FormatDateTime('yyyy-mm-dd', date) + 'T' +
            FormatDateTime('hh:nn:ss', date);
end;

function DateTimeToComparableString(date : TDateTime) : String;
begin
  result := FormatDateTime('yyyy-mm-dd', date) +
            FormatDateTime('hh:nn', date);
end;

function DateTimeToDBString(date : TDateTime) : String;
begin
  result := FormatDateTime('yyyy-mm-dd', date) + ' ' +
            FormatDateTime('hh:nn:ss', date);
end;

function JsonStringToDate(dateStr : String) : TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create(GetThreadLocale);// (LOCALE_USER_DEFAULT, FormatSettings);
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-ddThh:nn:ss';
  Result := StrToDateTime(dateStr, FormatSettings);
end;

function XmlStringToDate(dateStr : String) : TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create(GetThreadLocale);// (LOCALE_USER_DEFAULT, FormatSettings);
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-ddThh:nn:ss';
  Result := StrToDateTime(dateStr, FormatSettings);
end;

function SqlStringToDate(dateStr : String) : TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  if datestr = '' then
    result := trunc(now)
  else
  begin
    FormatSettings := TFormatSettings.Create(GetThreadLocale);// (LOCALE_USER_DEFAULT, FormatSettings);
    FormatSettings.DateSeparator := '-';
    FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
    Result := StrToDateTime(dateStr, FormatSettings);
  end;
end;

end.
