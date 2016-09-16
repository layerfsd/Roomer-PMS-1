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
  private
    function GetContentType: string;
    procedure SetContentType(const Value: string);
    function GetAcceptEncoding: string;
    procedure SetAcceptEncoding(const Value: string);
  protected
  public
    constructor Create(aOwner: TComponent); override;
    procedure AddAuthenticationHeaders(const aHotel, aUser, aPassword, aAppName, aAppVersion, aExtraBuild: String);
    function DeleteWithStatus(const aURL: String; var aResponse: String): THttpResultCode;
    function GetWithStatus(const aUrl: String; var aResponse: String): THttpResultCode;
    function PostWithStatus(const aUrl:String; aPostDataStream: TStream; var aResponse: String): THttpResultCode;
    function PutWithStatus(const aURL: String; aPutDataStream: TStream; var aResponse: String): THttpResultCode;
    procedure Execute(const aRequestDataStream: TStream; aResponseContentStream: TStream; aResponseContentHeader: TALHTTPResponseHeader); override;

    property ContentType: string read GetContentType write SetContentType;
    property AcceptEncoding: string read GetAcceptEncoding write SetAcceptEncoding;
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
    Add(AnsiString(format('%s: %s', ['hotel', ahotel])));
    Add(AnsiString(format('%s: %s', ['Username', aUser])));
    Add(AnsiString(format('%s: %s', ['Password', aPassword])));
    Add(AnsiString(format('%s: %s', ['AppName', aAppName])));
    Add(AnsiString(format('%s: %s', ['AppVersion', aAppVersion])));
    Add(AnsiString(format('%s: %s', ['DatasetType', '0'])));
    Add(AnsiString(format('%s: %s', ['ExtraBuild', aExtraBuild])));
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
    aResponse := String(inherited Delete(AnsiString(aURL)));
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
  lOldCursor := SCreen.cursor;

  if RunningInMainThread then
    Screen.Cursor := crHourGlass;

  try
    inherited;
  finally
    if RunningInMainThread then
      Screen.Cursor := lOldCursor;
  end;
end;

function TRoomerHttpClient.GetAcceptEncoding: string;
begin
  Result := String(RequestHeader.AcceptEncoding);
end;

function TRoomerHttpClient.GetContentType: string;
begin
  Result := string(RequestHeader.ContentType);
end;

function TRoomerHttpClient.GetWithStatus(const aUrl: String; var aResponse: String): THttpResultCode;
begin
  Result := -1;
  try
    aResponse := String(inherited Get(AnsiString(aURL)));
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
    aResponse := String(inherited Post(AnsiString(aURL), aPostDataStream));
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
    aResponse := String(inherited Put(AnsiString(aURL), aPutDataStream));
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

procedure TRoomerHttpClient.SetAcceptEncoding(const Value: string);
begin
  RequestHeader.AcceptEncoding := AnsiString(Value);
end;

procedure TRoomerHttpClient.SetContentType(const Value: string);
begin
  RequestHeader.ContentType := AnsiString(value);
end;

end.
