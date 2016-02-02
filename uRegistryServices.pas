unit uRegistryServices;

interface
uses Registry, Windows, AnsiStrings;

type
  TRoomerRegistryIniFile = class(TRegistryIniFile)
  private
  public
    constructor Create(Location : String);
    destructor Destroy; override;
  end;


implementation

{ TRoomerRegistryIniFile }


constructor TRoomerRegistryIniFile.Create(Location: String);
begin
  inherited Create('Software\Roomer\PMS\' + String(ExtractFilename(AnsiString(Location))));
end;

destructor TRoomerRegistryIniFile.Destroy;
begin
  inherited;
end;

end.
