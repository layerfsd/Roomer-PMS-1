unit cmpRoomerLingo;

interface

uses
  System.SysUtils, System.Classes;

type
  TRoomerLingo = class(TComponent)
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
  RegisterComponents('Roomer', [TRoomerLingo]);
end;

end.
