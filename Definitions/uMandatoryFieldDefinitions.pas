unit uMandatoryFieldDefinitions;

interface

uses Classes
     ;

type

  /// <summary>
  ///   Fields on the checking form that can be set as Mandatory in the global settings
  /// </summary>
  TManadatoryCheckinField = (
    mfCity,
    mfCountry,
    mfFirstName,
    mfSurname,
    mfMarket,
    mfNationality,
    mfGuarantee
  );

  TManadatoryCheckInFieldet = set of TManadatoryCheckinField;

  TManadatoryFieldHelper = record helper for TManadatoryCheckinField
  private
    function PMSSettingName: String;
      /// <summary>
      ///   Create a TManadatoryCheckinField from a PMSSettingName
      /// </summary>
      class function FromPMSSettingName(const aName: string): TManadatoryCheckinField; static;

      /// <summary>
      ///   Return a TManadatoryCheckinField based in index
      /// </summary>
      class function FromItemIndex(aIndex: integer) : TManadatoryCheckinField; static;

      /// <summary>
      ///   Return the translated displaystring for a TManadatoryFieldsSet
      /// </summary>
      function AsReadableString : string;


  public
      /// <summary>
      ///   Fill a TStrings with translated descriptions in order of enumeration. Can by used to populate a TCombobox.<br />
      ///  The objects list of aItemList will contain the ord() of the TManadatoryFieldsSet cast to an TObject
      /// </summary>
      class procedure AsStrings(aItemList: TStrings); static;
      /// <summary>
      ///   Return the itemindex of TManadatoryFieldsSet as it would have in the itemlist created by AsStrings
      /// </summary>
      function ToItemIndex: integer;

      /// <summary>
      ///   Returns true if Self is currently set as mandatory in the global settings
      /// </summary>
      function IsCurrentlyOn : Boolean;
      /// <summary>
      ///   Set Self  as manditory in the global settings
      /// </summary>
      procedure SetOnOrOff(TRUE_OR_FALSE : Boolean);

      /// <summary>
      ///   Return a tagid larger than MinimumTagId to link a control to a certain mandatoryField setting.
      /// </summary>
      function AsTagid: integer;
      class function MinimumTagid: integer; static; inline;
      class function FromTagId(aTag: integer) : TManadatoryCheckinField; static;

    end;


implementation

{ TManadatoryFieldsHelper }

uses PrjConst, SysUtils, uUtils, uAppGlobal
     ;

const MF_PMSSETTING_NAMES : Array[low(TManadatoryCheckinField)..high(TManadatoryCheckinField)] of String =
     ('CITY_MANDATORY',
      'COUNTRY_MANDATORY',
      'FIRST_NAME_MANDATORY',
      'LAST_NAME_MANDATORY',
      'MARKET_MANDATORY',
      'NATIONALITY_MANDATORY',
      'PAYMENT_GUARANTEE_MANDATORY');

     /// <summary>
     ///   Offset used to map a TMandatoryField to a integer used as Tag of a component. This is the
     ///  MinimumTagid
     /// </summary>
     cAsTagOffset = 100;

function TManadatoryFieldHelper.AsReadableString: string;
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

class procedure TManadatoryFieldHelper.AsStrings(aItemList: TStrings);
var
  s: TManadatoryCheckinField;
begin
  aItemList.Clear;
  for s := low(TManadatoryCheckinField) to high(s) do
    aItemList.AddObject(s.AsReadableString, TObject(ord(s)));
end;

function TManadatoryFieldHelper.AsTagid: integer;
begin
  Result := ord(Self) + cAsTagOffset;
end;

class function TManadatoryFieldHelper.FromItemIndex(aIndex: integer): TManadatoryCheckinField;
begin
    Result := TManadatoryCheckinField(aIndex);
end;

class function TManadatoryFieldHelper.FromTagId(aTag: integer): TManadatoryCheckinField;
begin
  result :=  FromItemIndex(aTag - cAsTagOffset);
end;

function TManadatoryFieldHelper.isCurrentlyOn: Boolean;
begin
  result := glb.GetPmsSettingsAsBoolean(PMSSettingName, False, True)
end;

class function TManadatoryFieldHelper.MinimumTagid: integer;
begin
  Result := cAsTagOffset;
end;

procedure TManadatoryFieldHelper.SetOnOrOff(TRUE_OR_FALSE: Boolean);
begin
  glb.SetPmsSettingsAsBoolean(PMSSettingName, TRUE_OR_FALSE);
end;

function TManadatoryFieldHelper.PMSSettingName: String;
begin
  result := MF_PMSSETTING_NAMES[self];
end;

class function TManadatoryFieldHelper.FromPMSSettingName(const aName: string): TManadatoryCheckinField;
begin
  result := TManadatoryCheckinField(StringIndexInSet(UpperCase(aName), MF_PMSSETTING_NAMES));
end;

function TManadatoryFieldHelper.ToItemIndex: integer;
begin
  Result := ord(Self);
end;

end.
