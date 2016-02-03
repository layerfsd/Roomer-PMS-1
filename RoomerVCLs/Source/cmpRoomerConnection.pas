unit cmpRoomerConnection;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Data.Win.ADODB
  , cmpRoomerDataSet
  ;

type
  TRoomerConnection = class(TADOConnection)
  private
    FRoomerDataSet: TRoomerDataSet;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure DoRollbackTrans;
    procedure DoCommitTrans;
    function DoBeginTrans: Integer;

    function CreateNewConnection : TRoomerConnection;

  published
    { Published declarations }
    property RoomerDataSet : TRoomerDataSet read FRoomerDataSet write FRoomerDataSet;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerConnection]);
end;

{ TRoomerConnection }

function TRoomerConnection.CreateNewConnection: TRoomerConnection;
begin
  result := TRoomerConnection.Create(Owner);
  result.RoomerDataSet := RoomerDataSet;
end;

function TRoomerConnection.DoBeginTrans: Integer;
begin
  if Assigned(FRoomerDataSet) then
    FRoomerDataSet.SystemStartTransaction;
  result := 0;
end;

procedure TRoomerConnection.DoCommitTrans;
begin
  if Assigned(FRoomerDataSet) then
    FRoomerDataSet.SystemCommitTransaction;
end;

procedure TRoomerConnection.DoRollbackTrans;
begin
  if Assigned(FRoomerDataSet) then
    FRoomerDataSet.SystemRollbackTransaction;
end;

end.
