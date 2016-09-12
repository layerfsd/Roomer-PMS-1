unit uAccountTypeDefinitions;

interface

uses
  Graphics
  , CLasses
  , uRoomerDefinitions
  ;

type
  ///	<summary>
  ///	  Possible states of a breakfast as part of a reservation
  ///	</summary>
  TAccountType= (
    atRoomAccount,
    atGroupAccount
  );

    TAccountTypeHelper = record helper for TAccountType
    public
      // constructor
      /// <summary>
      ///   Create a TAccountType from a boolean
      /// </summary>
      class function FromBool(const aIsGroupAccount: boolean) : TAccountType; static;
      /// <summary>
      ///   Return a TAccountType based in index.
      /// </summary>
      class function FromItemIndex(aIndex: integer) : TAccountType; static;

      /// <summary>
      ///   Fill a TStrings with translated descriptions in order of enumeration. Can by used to populate a TCombobox
      /// </summary>
      class procedure AsStrings(aItemList: TStrings); static;
      /// <summary>
      ///   Return the itemindex of TReservationState as it would have in the itemlist created by AsStrings
      /// </summary>
      function ToItemIndex: integer;

      /// <summary>
      ///   Return as a boolean
      /// </summary>
      function AsBoolean: boolean;
      /// <summary>
      ///   Return the translated displaystring for a TAccountType
      /// </summary>
      function AsReadableString : string;

    end;


implementation

uses
    PrjConst
  , SysUtils
  , uUtils;


class procedure TAccountTypeHelper.AsStrings(aItemList: TStrings);
var
  s: TAccountType;
begin
  aItemList.Clear;
  for s := low(s) to high(s) do
    aItemList.Add(s.AsReadableString);
end;

class function TAccountTypeHelper.FromBool(const aIsGroupAccount: boolean): TAccountType;
begin
  if aIsGroupAccount then
    Result := atGroupAccount
  else
    Result := atRoomAccount;
end;

class function TAccountTypeHelper.FromItemIndex(aIndex: integer): TAccountType;
begin
  Result := TAccountType(aIndex);
end;

function TAccountTypeHelper.AsBoolean: boolean;
begin
  Result := Self = atGroupAccount;
end;

function TAccountTypeHelper.AsReadableString : string;
begin
  case Self of
    atRoomAccount:     Result := GetTranslatedText('shTx_ReservationProfile_RoomAccount');
    atGroupAccount:  Result := GetTranslatedText('shTx_ReservationProfile_GroupAccount');
  else
    Result := '';
  end;
end;


function TAccountTypeHelper.ToItemIndex: integer;
begin
  Result := ord(Self);
end;

end.
