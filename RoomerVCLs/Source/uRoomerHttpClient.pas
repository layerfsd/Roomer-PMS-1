unit uRoomerHttpClient;

interface

uses
    Classes
  , ALWininetHttpClient
  ;

type

  TRoomerHttpClient = class(TALWinInetHTTPClient)
  public
    constructor Create(aOwner: TComponent); override;
    procedure AddAuthenticatioHeaders(const aHotel, aUser, aPassword, aAppName, aAppVersion, aExtraBuild: String);
    procedure Execute(const aRequestDataStream: TStream; aResponseContentStream: TStream; aResponseContentHeader: TALHTTPResponseHeader); override;
  end;

implementation

uses
  SysUtils
  ;

{ TRoomerHttpClient }

procedure TRoomerHttpClient.AddAuthenticatioHeaders(const aHotel, aUser, aPassword, aAppName, aAppVersion, aExtraBuild: String);
begin
  with RequestHeader.CustomHeaders do
  begin
    Clear;
    Add(format('%s: %s', ['hotel', ahotel]));
    Add(format('%s: %s', ['Username', aUser]));
    Add(format('%s: %s', ['Password', aPassword]));
    Add(format('%s: %s', ['AppName', aAppName]));
    Add(format('%s: %s', ['AppVersion', aAppVersion]));
    Add(format('%s: %s', ['DatasetType', '0']));
    Add(format('%s: %s', ['ExtraBuild', aExtraBuild]));
  end;

end;

constructor TRoomerHttpClient.Create(aOwner: TComponent);
begin
  inherited;
  SendTimeout := 900000;
  ReceiveTimeout := 900000;
  ConnectTimeout := 10000;
  AccessType := wHttpAt_Direct;
  InternetOptions := [whttpIo_IGNORE_CERT_CN_INVALID,
    whttpIo_IGNORE_CERT_DATE_INVALID, whttpIo_KEEP_CONNECTION,
    whttpIo_NO_CACHE_WRITE, whttpIo_NO_UI, whttpIo_PRAGMA_NOCACHE,
    whttpIo_RELOAD, whttpIo_RESYNCHRONIZE];
end;

procedure TRoomerHttpClient.Execute(const aRequestDataStream: TStream; aResponseContentStream: TStream;
  aResponseContentHeader: TALHTTPResponseHeader);
begin
  try
    inherited;
  except
    on E: Exception do
    begin

    end
    else
      raise

  end;

end;

end.
