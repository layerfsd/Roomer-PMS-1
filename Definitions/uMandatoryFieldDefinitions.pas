unit uMandatoryFieldDefinitions;

interface

uses Classes
     ;

type

  TManadatoryFields = (
    mfCity,
    mfCountry,
    mfFirstName,
    mfSurname,
    mfMarket,
    mfNationality,
    mfGuarantee
  );

  TManadatoryFieldsSet = set of TManadatoryFields;

  TManadatoryFieldsHelper = record helper for TManadatoryFields
  public
      // constructor
      /// <summary>
      ///   Create a TReservationState from a single character or status string
      /// </summary>
      class function FromFieldName(const statusStr : string) : TManadatoryFields; overload; static;
      /// <summary>
      ///   Return a TReservationState based in index. Note that this does now work with the itemlist returned by AsStrings as this
      ///  list only contains UserSelectable TReservationStates
      /// </summary>
      class function FromItemIndex(aIndex: integer) : TManadatoryFields; static;

      /// <summary>
      ///   Fill a TStrings with translated descriptions in order of enumeration. Can by used to populate a TCombobox.<br />
      ///  The objects list of aItemList will contain the ord() of the state cast to an TObject
      /// </summary>
      class procedure AsStrings(aItemList: TStrings); static;
      /// <summary>
      ///   Return the itemindex of TReservationState as it would have in the itemlist created by AsStrings
      /// </summary>
      function ToItemIndex: integer;

      function IsCurrenclyOn : Boolean;
      procedure SetOnOrOff(TRUE_OR_FALSE : Boolean);
      class function FromTagId(aTag: integer) : TManadatoryFields; static;

      function FieldName : String;

      /// <summary>
      ///   Return the translated displaystring for a ReservationState
      /// </summary>
      function AsReadableString : string;

    end;


implementation

{ TManadatoryFieldsHelper }

uses PrjConst, SysUtils, uUtils, uAppGlobal
     ;

const MF_FIELD_NAMES : Array[low(TManadatoryFields)..high(TManadatoryFields)] of String =
     ('CITY_MANDATORY',
      'COUNTRY_MANDATORY',
      'FIRST_NAME_MANDATORY',
      'LAST_NAME_MANDATORY',
      'MARKET_MANDATORY',
      'NATIONALITY_MANDATORY',
      'PAYMENT_GUARANTEE_MANDATORY');

function TManadatoryFieldsHelper.AsReadableString: string;
begin
  case Self of
    mfCity          : result := GetTranslatedText('shTx_MandatoryFields_City');
    mfCountry       : result := GetTranslatedText('shTx_MandatoryFields_Country');
    mfFirstName     : result := GetTranslatedText('shTx_MandatoryFields_FirstName');
    mfSurname       : result := GetTranslatedText('shTx_MandatoryFields_Surname');
    mfMarket        : result := GetTranslatedText('shTx_MandatoryFields_Market');
    mfNationality   : result := GetTranslatedText('shTx_MandatoryFields_Nationality');
    mfGuarantee     : result := GetTranslatedText('shTx_MandatoryFields_Guarantee');
  else
    Result := '';
  end;
end;

class procedure TManadatoryFieldsHelper.AsStrings(aItemList: TStrings);
var
  s: TManadatoryFields;
begin
  aItemList.Clear;
  for s := low(TManadatoryFields) to high(s) do
    aItemList.AddObject(s.AsReadableString, TObject(ord(s)));
end;

class function TManadatoryFieldsHelper.FromItemIndex(aIndex: integer): TManadatoryFields;
begin
    Result := TManadatoryFields(aIndex);
end;

class function TManadatoryFieldsHelper.FromTagId(aTag: integer): TManadatoryFields;
begin
  result :=  FromItemIndex(aTag - 10);
end;

function TManadatoryFieldsHelper.isCurrenclyOn: Boolean;
begin
  result := glb.GetPmsSettingsAsBoolean(FieldName, False, True)
end;

procedure TManadatoryFieldsHelper.SetOnOrOff(TRUE_OR_FALSE: Boolean);
begin
  glb.SetPmsSettingsAsBoolean(FieldName, TRUE_OR_FALSE);
end;

function TManadatoryFieldsHelper.FieldName: String;
begin
  result := MF_FIELD_NAMES[self];
end;

class function TManadatoryFieldsHelper.FromFieldName(const statusStr: string): TManadatoryFields;
begin
  result := TManadatoryFields(StringIndexInSet(UpperCase(statusStr), MF_FIELD_NAMES));
end;

function TManadatoryFieldsHelper.ToItemIndex: integer;
begin
  Result := ord(Self);
end;

end.
