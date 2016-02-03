unit cmpRoomerDataSource;

interface

uses
  System.SysUtils, System.Classes, Data.DB;

type
  TRoomerDataSource = class(TDataSource)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerDataSource]);
end;

end.
