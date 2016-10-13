unit uMandatoryFieldDefinitions;

interface

uses Classes
     ;

type

  /// <summary>
  ///   Fields on the checking form that can be set as Mandatory in the global settings
  /// </summary>
  TMandatoryCheckinField = (
    mfCity,
    mfCountry,
    mfFirstName,
    mfSurname,
    mfMarket,
    mfNationality,
    mfGuarantee
  );

  TMandatoryCheckInFieldet = set of TMandatoryCheckinField;

  TMandatoryFieldHelper = record helper for TMandatoryCheckinField
  private
    function PMSSettingName: String;
      /// <summary>
      ///   Create a TManadatoryCheckinField from a PMSSettingName
      /// </summary>
      class function FromPMSSettingName(const aName: string): TMandatoryCheckinField; static;

      /// <summary>
      ///   Return a TManadatoryCheckinField based in index
      /// </summary>
      class function FromItemIndex(aIndex: integer) : TMandatoryCheckinField; static;

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
      class function FromTagId(aTag: integer) : TMandatoryCheckinField; static;

    end;


implementation

{ TManadatoryFieldsHelper }

uses PrjConst, SysUtils, uUtils, uAppGlobal
     ;

const MF_PMSSETTING_NAMES : Array[low(TMandatoryCheckinField)..high(TMandatoryCheckinField)] of String =
     ('CITY_MANDATORY',
      'COUNTRY_MANDATORY',
      'FIRST_NAME_MANDATORY',
      'LAST_NAME_MANDATORY',
      'MARKET_MANDATORY',
      'NATIONALITY_MANDATORY',
      'PAYMENT_GUARANTEE_MANDATORY');
      MF_KEY_GROUP = 'MANDATORY_CHECK_IN_FIELDS';

     /// <summary>
     ///   Offset used to map a TMandatoryField to a integer used as Tag of a component. This is the
     ///  MinimumTagid
     /// </summary>
     cAsTagOffset = 100;

function TMandatoryFieldHelper.AsReadableString: string;
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

class procedure TMandatoryFieldHelper.AsStrings(aItemList: TStrings);
var
  s: TMandatoryCheckinField;
begin
  aItemList.Clear;
  for s := low(TMandatoryCheckinField) to high(s) do
    aItemList.AddObject(s.AsReadableString, TObject(ord(s)));
end;

function TMandatoryFieldHelper.AsTagid: integer;
begin
  Result := ord(Self) + cAsTagOffset;
end;

class function TMandatoryFieldHelper.FromItemIndex(aIndex: integer): TMandatoryCheckinField;
begin
    Result := TMandatoryCheckinField(aIndex);
end;

class function TMandatoryFieldHelper.FromTagId(aTag: integer): TMandatoryCheckinField;
begin
  result :=  FromItemIndex(aTag - cAsTagOffset);
end;

function TMandatoryFieldHelper.isCurrentlyOn: Boolean;
begin
  result := glb.GetPmsSettingsAsBoolean(MF_KEY_GROUP, PMSSettingName, False, True)
end;

class function TMandatoryFieldHelper.MinimumTagid: integer;
begin
  Result := cAsTagOffset;
end;

procedure TMandatoryFieldHelper.SetOnOrOff(TRUE_OR_FALSE: Boolean);
begin
  glb.SetPmsSettingsAsBoolean(MF_KEY_GROUP, PMSSettingName, TRUE_OR_FALSE);
end;

function TMandatoryFieldHelper.PMSSettingName: String;
begin
  result := MF_PMSSETTING_NAMES[self];
end;

class function TMandatoryFieldHelper.FromPMSSettingName(const aName: string): TMandatoryCheckinField;
begin
  result := TMandatoryCheckinField(StringIndexInSet(UpperCase(aName), MF_PMSSETTING_NAMES));
end;

function TMandatoryFieldHelper.ToItemIndex: integer;
begin
  Result := ord(Self);
end;

end.
