unit RoomerPeriodGrid;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.Graphics,
  RoomerReservationDefinitions, RoomerTableDefinitions
  ;

type
  TGetColorsEvent = procedure(Sender: TObject; ColorArray : ArrayRoomerResStatusTypeOfColorSettings) of object;
  TGetReservationsEvent = procedure(Sender: TObject; FromDate, ToDate : TDate) of object;

  TRoomerPeriodGrid = class(TAdvStringGrid)
  private
    FNumberOfDays: Integer;
    FResColors : ArrayRoomerResStatusTypeOfColorSettings;
    FOnGetColors: TGetColorsEvent;
    FOnReservationsNeeded: TGetReservationsEvent;

    procedure SetNumberOfDays(const Value: Integer);
    function GetResColor(RoomerResStatusType: TRoomerResStatusType): TRoomerColorSettings;
    procedure SetResColor(RoomerResStatusType: TRoomerResStatusType; const Value: TRoomerColorSettings);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure FullRedraw;

    procedure AddReservation(Reservation : TReservation);

    property ResColors[RoomerResStatusType : TRoomerResStatusType] : TRoomerColorSettings read GetResColor write SetResColor;
  published
    { Published declarations }
    property NumberOfDays : Integer read FNumberOfDays write SetNumberOfDays;

    // Events
    property OnGetColors : TGetColorsEvent read FOnGetColors write FOnGetColors;
    property OnReservationsNeeded : TGetReservationsEvent read FOnReservationsNeeded write FOnReservationsNeeded;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Roomer Visual', [TRoomerPeriodGrid]);
end;

{ TRoomerPeriodGrid }

procedure TRoomerPeriodGrid.AddReservation(Reservation: TReservation);
begin

end;

procedure TRoomerPeriodGrid.FullRedraw;
begin

end;

function TRoomerPeriodGrid.GetResColor(RoomerResStatusType: TRoomerResStatusType): TRoomerColorSettings;
begin
  result := FResColors[RoomerResStatusType];
end;

procedure TRoomerPeriodGrid.SetNumberOfDays(const Value: Integer);
begin
  FNumberOfDays := Value;
end;

procedure TRoomerPeriodGrid.SetResColor(RoomerResStatusType: TRoomerResStatusType; const Value: TRoomerColorSettings);
begin
  FResColors[RoomerResStatusType] := Value;
end;

end.
