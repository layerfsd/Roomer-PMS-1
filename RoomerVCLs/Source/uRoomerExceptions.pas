unit uRoomerExceptions;

interface

uses SysUtils;

type
  ERoomerOfflineAssertionException = class(Exception)
  private
    FErrorCode: integer;
  public
    constructor CreateErrCode(const Msg: string; const ErrCode: integer);
    property ErrorCode: integer read FErrorCode write FErrorCode;
  end;

implementation

{ ERoomerOfflineAssertionException }

constructor ERoomerOfflineAssertionException.CreateErrCode(const Msg: string; const ErrCode: integer);
begin
  inherited Create(Msg);
  FErrorCode := ErrCode;
end;

end.
