unit uRoomerHttpClient;

interface

uses
    Classes
  , ALWininetHttpClient
  , AlHttpCommon
  , ALHttpClient
    ;

type
  THttpResultCode = integer;

  TRoomerHttpClient = class(TALWinInetHTTPClient)
  protected
  public
    constructor Create(aOwner: TComponent); override;
    procedure AddAuthenticationHeaders(const aHotel, aUser, aPassword, aAppName, aAppVersion, aExtraBuild: String);
    function DeleteWithStatus(const aURL: String; var aResponse: String): THttpResultCode;
    function GetWithStatus(const aUrl: String; var aResponse: String): THttpResultCode;
    function PostWithStatus(const aUrl:String; aPostDataStream: TStream; var aResponse: String): THttpResultCode;
    function PutWithStatus(const aURL: String; aPutDataStream: TStream; var aResponse: String): THttpResultCode;
    procedure Execute(const aRequestDataStream: TStream; aResponseContentStream: TStream; aResponseContentHeader: TALHTTPResponseHeader); override;
  end;

implementation

uses
  SysUtils
  , Windows
  , VCL.Forms
  , VCL.Controls
  ;

{ TRoomerHttpClient }
function RunningInMainThread: boolean;
begin
  Result := (GetCurrentThreadId() = MainThreadID);
end;


procedure TRoomerHttpClient.AddAuthenticationHeaders(const aHotel, aUser, aPassword, aAppName, aAppVersion, aExtraBuild: String);
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

function TRoomerHttpClient.DeleteWithStatus(const aURL: String; var aResponse: String): THttpResultCode;
begin
  Result := -1;
  try
    aResponse := inherited Delete(aURL);
    Result := 200;
  except
    on E: EALHTTPClientException do
    begin
      if E.StatusCode > 0 then
        Result := E.StatusCode
    end
    else
      raise;
  end;
end;

procedure TRoomerHttpClient.Execute(const aRequestDataStream: TStream; aResponseContentStream: TStream;
  aResponseContentHeader: TALHTTPResponseHeader);
var
  lOldCursor: TCursor;
begin
  if RunningInMainThread then
  begin
    lOldCursor := SCreen.cursor;
    Screen.Cursor := crHourGlass;
  end;
  try
    inherited;
  finally
    if RunningInMainThread then
      Screen.Cursor := lOldCursor;
  end;
end;

function TRoomerHttpClient.GetWithStatus(const aUrl: String; var aResponse: String): THttpResultCode;
begin
  Result := -1;
  try
    aResponse := inherited Get(aURL);
    Result := 200;
  except
    on E: EALHTTPClientException do
    begin
      if E.StatusCode > 0 then
        Result := E.StatusCode
    end
    else
      raise;
  end;
end;

function TRoomerHttpClient.PostWithStatus(const aUrl: String; aPostDataStream: TStream;
  var aResponse: String): THttpResultCode;
begin
  Result := -1;
  try
    aResponse := inherited Post(aURL, aPostDataStream);
    Result := 200;
  except
    on E: EALHTTPClientException do
    begin
      if E.StatusCode > 0 then
        Result := E.StatusCode
    end
    else
      raise;
  end;
end;

function TRoomerHttpClient.PutWithStatus(const aURL: string; aPutDataStream: TStream;
  var aResponse: String): THttpResultCode;
begin
  Result := -1;
  try
    aResponse := inherited Put(aURL, aPutDataStream);
    Result := 200;
  except
    on E: EALHTTPClientException do
    begin
      if E.StatusCode > 0 then
        Result := E.StatusCode
    end
    else
      raise;
  end;
end;

end.
