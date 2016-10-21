unit uCleaningNotesDefinitions;

interface

uses
  Graphics
  , CLasses
  , uRoomerDefinitions
  ;

type
  ///	<summary>
  ///	  Possible type of a cleaningnote
  ///	</summary>
  TCleaningNoteServiceType = (
    ctInterval,
    ctOnce
  );

  ///	<summary>
  ///	  Possible intervals of cleaningnotes of type ctInterval
  ///	</summary>
  TCleaningNoteOnceType = (
    coCheck_In_Day,
    coDay_Before_Check_Out,
    coCheck_Out_Day,
    coXth_Day,
    coX_Days_After_Check_Out
  );

  TCleaningNoteServiceTypeHelper = record helper for TCleaningNoteServiceType
  private
  const
    /// <summary>
    ///   Strings used in the database to store TCleaningNoteServicetype
    /// </summary>
    cCleaningNoteServiceTypeStrings: array[TCleaningNoteServiceType] of string =
      ('INTERVAL', 'ONCE');

  public
    // constructor
    /// <summary>
    ///   Create a TCleaningNoteServiceType from a string
    /// </summary>
    class function FromString(const aType: string) : TCleaningNoteServiceType; static;
    /// <summary>
    ///   Return a TCleaningNoteServiceType based in index.
    /// </summary>
    class function FromItemIndex(aIndex: integer) : TCleaningNoteServiceType; static;

    /// <summary>
    ///   Fill a TStrings with translated descriptions in order of enumeration. Can by used to populate a TCombobox
    /// </summary>
    class procedure AsStrings(aItemList: TStrings); static;
    /// <summary>
    ///   Return the itemindex of TCleaningNoteServiceType as it would have in the itemlist created by AsStrings
    /// </summary>
    function ToItemIndex: integer;

    /// <summary>
    ///   Return the string as this TCleaningNoteServiceType is stored in the database
    /// </summary>
    function ToDB: string;

    /// <summary>
    ///   Return the translated displaystring for a TCleaningNoteServiceType
    /// </summary>
    function AsReadableString : string;

  end;

  TCleaningNoteOnceTypeHelper = record helper for TCleaningNoteOnceType
  private
  const
    /// <summary>
    ///   Strings used in the database to store TCleaningNotesOnceType
    /// </summary>
    cCleaningNoteOnceTypeStrings: array[TCleaningNoteOnceType] of string =
      ('CHECK_IN_DAY', 'DAY_BEFORE_CHECK_OUT', 'CHECK_OUT_DAY', 'XTH_DAY', 'X_DAYS_AFTER_CHECK_OUT');


  public
    // constructor
    /// <summary>
    ///   Create a TCleaningNotesOnceType from a string
    /// </summary>
    class function FromString(const aType: string) : TCleaningNoteOnceType; static;
    /// <summary>
    ///   Return a TCleaningNoteOnceType based in index.
    /// </summary>
    class function FromItemIndex(aIndex: integer) : TCleaningNoteOnceType; static;

    /// <summary>
    ///   Fill a TStrings with translated descriptions in order of enumeration. Can by used to populate a TCombobox
    /// </summary>
    class procedure AsStrings(aItemList: TStrings); static;
    /// <summary>
    ///   Return the itemindex of TCleaningNoteOnceType as it would have in the itemlist created by AsStrings
    /// </summary>
    function ToItemIndex: integer;
    /// <summary>
    ///   Return the string as this TCleaningNoteOnceType is stored in the database
    /// </summary>
    function ToDB: string;
    /// <summary>
    ///   Return the translated displaystring for a TCleaningNoteOnceType
    /// </summary>
    function AsReadableString : string;

  end;

implementation

uses
    PrjConst
  , SysUtils
  , uUtils;


class procedure TCleaningNoteServiceTypeHelper.AsStrings(aItemList: TStrings);
var
  s: TCleaningNoteServiceType;
begin
  aItemList.Clear;
  for s := low(s) to high(s) do
    aItemList.Add(s.AsReadableString);
end;

class function TCleaningNoteServiceTypeHelper.FromString(const aType: string) : TCleaningNoteServiceType;
begin
  for Result := low(result) to high(result) do
    if cCleaningNoteServiceTypeStrings[Result].Equals(aType.ToUpper) then
      Break;
end;

class function TCleaningNoteServiceTypeHelper.FromItemIndex(aIndex: integer):  TCleaningNoteServiceType;
begin
  Result := TCleaningNoteServiceType(aIndex);
end;

function TCleaningNoteServiceTypeHelper.AsReadableString : string;
begin
  case Self of
    ctInterval:     Result := GetTranslatedText('shTx_CleaningNoteServiceType_Interval');
    ctOnce:         Result := GetTranslatedText('shTx_CleaningNoteServiceType_Once');
  else
    Result := '';
  end;
end;

function TCleaningNoteServiceTypeHelper.ToDB: string;
begin
  Result := cCleaningNoteServiceTypeStrings[Self];
end;

function TCleaningNoteServiceTypeHelper.ToItemIndex: integer;
begin
  Result := ord(Self);
end;


function TCleaningNoteOnceTypeHelper.AsReadableString: string;
begin
  case Self of
    coCheck_In_Day:           Result := GetTranslatedText('shTx_CleaningNoteintervalType_Checkin');
    coDay_Before_Check_Out:   Result := GetTranslatedText('shTx_CleaningNoteintervalType_BeforeCheckout');
    coCheck_Out_Day:          Result := GetTranslatedText('shTx_CleaningNoteintervalType_CheckOut');
    coXth_Day:                Result := GetTranslatedText('shTx_CleaningNoteintervalType_XthDay');
    coX_Days_After_Check_Out: Result := GetTranslatedText('shTx_CleaningNoteintervalType_XdaysAfterCheckout');
  else
    Result := '';
  end;
end;

class procedure TCleaningNoteOnceTypeHelper.AsStrings(aItemList: TStrings);
var
  s: TCleaningNoteOnceType;
begin
  aItemList.Clear;
  for s := low(s) to high(s) do
    aItemList.Add(s.AsReadableString);
end;

class function TCleaningNoteOnceTypeHelper.FromItemIndex(aIndex: integer): TCleaningNoteOnceType;
begin
  Result := TCleaningNoteOnceType(aIndex);
end;

class function TCleaningNoteOnceTypeHelper.FromString(const aType: string): TCleaningNoteOnceType;
begin
  for Result := low(result) to high(result) do
    if cCleaningNoteOnceTypeStrings[Result].Equals(aType.ToUpper) then
      Break;
end;

function TCleaningNoteOnceTypeHelper.ToItemIndex: integer;
begin
  Result := ord(Self);
end;

function TCleaningNoteOnceTypeHelper.ToDB: string;
begin
  Result := cCleaningNoteOnceTypeStrings[Self];
end;

end.
