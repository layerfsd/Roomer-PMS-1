unit uDateUtils;

interface

uses Soap.XSBuiltIns, SysUtils, Windows;

function CreateTSXDate(date : TDateTime) : TXSDateTime;
function dateToJsonString(date : TDateTime) : String;
function dateTimeToXmlString(date : TDateTime) : String;
function dateToSqlString(date : TDateTime) : String;
function JsonStringToDate(dateStr : String) : TDateTime;
function XmlStringToDate(dateStr : String) : TDateTime;
function SqlStringToDateTime(dateStr : String) : TDateTime;
function SqlStringToDate(dateStr : String) : TDateTime;
function WeekNumber(date: TDateTime): integer;
function DateTimeToDBString(date : TDateTime) : String;
function DateTimeToComparableString(date : TDateTime; withSeconds : Boolean = False) : String;
function Month(ADate : TDateTime) : Integer;
function Year(ADate : TDateTime) : Integer;
function DayOfMonth(ADate : TDateTime) : Integer;
function CreateDate(aYear, aMonth, aDay : Integer) : TDate;

function DateTimeFromYYMMDD(const aYYMMDD: string): TDateTime;

function RoomerDateTimeToString(date : TDateTime) : String;
function RoomerDateToString(date : TDateTime) : String;
function RoomerStringToDateTime(dateStr : String) : TDateTime;


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

function DateTimeToComparableString(date : TDateTime; withSeconds : Boolean = False) : String;
var timeFormat : String;
begin
  timeFormat := 'hh:nn';
  if withSeconds then
    timeFormat := 'hh:nn:ss';

  result := FormatDateTime('yyyy-mm-dd', date) +
            FormatDateTime(timeFormat, date);
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

function RoomerDateTimeToString(date : TDateTime) : String;
begin
  result := FormatDateTime('dd-mm-yyyy', date) + ' ' +
            FormatDateTime('hh:nn:ss', date);
end;

function RoomerDateToString(date : TDateTime) : String;
begin
  result := FormatDateTime('dd-mm-yyyy', date);
end;

function RoomerStringToDateTime(dateStr : String) : TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create(GetThreadLocale);// (LOCALE_USER_DEFAULT, FormatSettings);
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'dd-mm-yyyy hh:nn:ss';
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

function SqlStringToDateTime(dateStr : String) : TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create(GetThreadLocale);// (LOCALE_USER_DEFAULT, FormatSettings);
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd hh:nn:ss';
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

function DateTimeFromYYMMDD(const aYYMMDD: string): TDateTime;
var
  y,m,d,h,n: integer;
begin
  if length(aYYMMDD) > 0 then
    y := StrToIntDef(Copy(aYYMMDD, 1, 4), 0)
  else
    y := 0;

  if length(aYYMMDD) > 4 then
    m := StrToIntDef(Copy(aYYMMDD, 5, 2), 0)
  else
    m := 0;
  if length(aYYMMDD) > 6 then
    d := StrToIntDef(Copy(aYYMMDD, 7, 2), 0)
  else
    d := 0;
  if length(aYYMMDD) > 8 then
    h := StrToIntDef(Copy(aYYMMDD, 9, 2), 0)
  else
    h := 0;
  if length(aYYMMDD) > 10 then
    n := StrToIntDef(Copy(aYYMMDD, 11, 2), 0)
  else
    n := 0;


  Result := EncodeDate(y, m, d) + EncodeTime(h, n, 0, 0);
end;


end.
