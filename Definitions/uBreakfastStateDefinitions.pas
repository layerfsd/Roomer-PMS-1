unit uBreakfastStateDefinitions;

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
  TBreakfastState= (
    bsIncluded,
    bsNotIncluded
  );

    TBreakfastStateHelper = record helper for TBreakfastState
    public
      class function implicit(const aBreakfast: boolean): TBreakfastState; overload; static;

      /// <summary>
      ///   Return a TBreakfastState based in index.
      /// </summary>
      class function Implicit(aIndex: integer) : TBreakfastState; overload; static;

      /// <summary>
      ///   Fill a TStrings with translated descriptions in order of enumeration. Can by used to populate a TCombobox
      /// </summary>
      class procedure AsStrings(aItemList: TStrings); static;
      /// <summary>
      ///   Return the itemindex of TReservationState as it would have in the itemlist created by AsStrings
      /// </summary>
      function ToItemIndex: integer;

      /// <summary>
      ///   Return a single character statusstring
      /// </summary>
      function AsBoolean: boolean;
      /// <summary>
      ///   Return the translated displaystring for a TBreakfastState
      /// </summary>
      function AsReadableString : string;

    end;


implementation

uses
    PrjConst
  , SysUtils
  , uUtils;


class procedure TBreakfastStateHelper.AsStrings(aItemList: TStrings);
var
  s: TBreakfastState;
begin
  aItemList.Clear;
  for s := low(s) to high(s) do
    aItemList.Add(s.AsReadableString);
end;

class function TBreakfastStateHelper.Implicit(aIndex: integer): TBreakfastState;
begin
  Result := TBreakfastState(aIndex);
end;

class function TBreakfastStateHelper.implicit(const aBreakfast: boolean): TBreakfastState;
begin
  if aBreakfast then
    Result := bsIncluded
  else
    Result := bsNotIncluded;
end;

function TBreakfastStateHelper.AsBoolean: boolean;
begin
  Result := Self = bsIncluded;
end;

function TBreakfastStateHelper.AsReadableString : string;
begin
  case Self of
    bsIncluded:     Result := GetTranslatedText('shTx_ReservationProfile_Included');
    bsnotIncluded:  Result := GetTranslatedText('shTx_ReservationProfile_NotIncluded');
  else
    Result := '';
  end;
end;


function TBreakfastStateHelper.ToItemIndex: integer;
begin
  Result := ord(Self);
end;

end.
