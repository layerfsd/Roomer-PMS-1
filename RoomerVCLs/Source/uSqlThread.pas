unit uSqlThread;

interface

uses System.Classes
     , Windows
     , SysUtils
     , cmpRoomerDataSet
     , AdoDB
     , Forms
     ;

type

  TRoomerSqlThread = class(TThread)
  private
    FDataSet: TRoomerDataSet;  // Internal query
    FSQL: string;      // SQL To execute
    FID: integer;
    FExecResult: integer;      // Internal ID

    CriticalSection: TRTLCriticalSection;
    FExec: Boolean;
  public
    constructor Create(CreateSuspended:Boolean;
                       dataSet: TRoomerDataSet;
                       Sql : String;
                       exec : Boolean; // if yes then update, insert, delete, etc...
                       IDThread:integer);
    destructor Destroy; override;
    procedure Execute(); override;

    property ID:integer read FID write FID;
    property ExecResult:integer read FExecResult write FExecResult;
    property Exec : Boolean read FExec;
    property SQL:string read FSQL write FSQL;
    property DataSet : TRoomerDataSet read FDataSet write FDataSet;
  end;

implementation

{ TRoomerSqlThread }

(*
Usage:

var rSet : TRoomerDataSet;
    sql : String;
begin
  rSet := CreateNewDataSet;
  sql := 'SELECT * FROM languages'
  th := TRoomerSqlThread.Create(True, rSet, sql, false, 0);
  th.OnTerminate := nil;
  th.Resume;


*)

constructor TRoomerSqlThread.Create(CreateSuspended: Boolean;
                                 dataSet: TRoomerDataSet;
                                 Sql : String;
                                 exec : Boolean; // if yes then update, insert, delete, etc...
                                 IDThread: integer);
begin
  inherited Create(CreateSuspended);

  Self.FreeOnTerminate := False;
  FExec := exec;

  FDataSet := dataSet;

  FSQL := sql;
  Self.FID := IDThread;
  InitializeCriticalSection(CriticalSection);
end;

destructor TRoomerSqlThread.Destroy;
begin

  inherited;
end;

procedure TRoomerSqlThread.Execute;
begin
  inherited;

  EnterCriticalSection(CriticalSection);
  FDataSet.CommandType := cmdText;
  FDataSet.CommandText := FSql;
  try
    if FExec then
      FDataSet.DoCommand(sql)
    else
      FDataSet.open;
  except
    on e : Exception do
    begin
//      result := false;
//      errMsg := e.message;
      raise;
    end;
  end;

  LeaveCriticalSection(CriticalSection);
end;

procedure WaitForThread(thrd : TRoomerSqlThread);
begin
  //If the work is not over yet, we display message informing the user we're still working
  while (thrd<>nil) and (WaitForSingleObject(thrd.Handle, 0)<>WAIT_OBJECT_0) do
  begin
    Application.ProcessMessages;
    sleep(100);
  end;
end;

end.
