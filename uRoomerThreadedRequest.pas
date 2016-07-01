unit uRoomerThreadedRequest;

interface

{$INCLUDE roomer.inc}

uses
  Classes,
  DB,
  cmpRoomerDataSet,
  ADODB
  ;

type

  TOperationType = (OT_EXECUTE, OT_PUT, OT_POST);

  TFieldInfoRecord = Record
    // as far as sometimes parametertypes can not be detected by
    DataType: TFieldType; // Ado on his own, provide all needed informations
    Name: String;
    Size: Integer;
    Value: Variant;
  End;

  TFieldInfoArray = Array of TFieldInfoRecord;

type
  TBaseDBThread = class abstract(TThread)
  private
    FRecordSet: _RecordSet;
    FRoomerDataSet: TRoomerDataSet;
  protected
    Procedure Execute; override;
    procedure InternalExecute; virtual; abstract;
    procedure ExecuteSQL(const aCommand: string);
    procedure ExecutePUT(const aCommand, aData : string);
    procedure ExecutePOST(const aCommand, aData: string);
  public
    Property RecordSet: _RecordSet read FRecordSet;
    property Dataset: TRoomerDataset read FRoomerDataSet;
  end;

  TDBThread = Class(TBaseDBThread)
  private
    FSQL: String;
    FData: String;
    FOperationType: TOperationType;
    FFDArray: TFieldInfoArray;
  protected
    procedure InternalExecute; override;
  public
    constructor Create(Const aSQL: String; aFDArray: TFieldInfoArray); overload;
    constructor Create(Const sql, data: String; OperationType: TOperationType); overload;
  end;

  // Execute a sql statement or REST call in a separate thread, on termination of that thread the
  // supplied TNotifyEvent is called.
  TGetThreadedData = class(TObject)
  private
    FRoomerDataSet: TRoomerDataSet;
    FEventHandler: TNotifyEvent;
    procedure ThreadTerminate(Sender: TObject);
  protected

  public
    constructor Create;
    destructor Destroy; override;

    // Execute SQL statement, on completion the result is in Dataset
    procedure Execute(const sql: String; aOnCompletionHandler: TNotifyEvent);
    procedure Put(const url, data: String; aOnCompletionHandler: TNotifyEvent);
    procedure Post(const url, data: String; aOnCompletionHandler: TNotifyEvent);

    property RoomerDataSet: TRoomerDataSet read FRoomerDataSet;
  end;

implementation

uses
  Windows,
  ActiveX,
  uD,
  SysUtils;


procedure TGetThreadedData.Execute(const sql: String; aOnCompletionHandler: TNotifyEvent);
begin
  FEventHandler := aOnCompletionHandler;
  With TDBThread.Create(sql, nil) do
  begin
    FOperationType := OT_EXECUTE;
    FreeOnTerminate := true;
    OnTerminate := ThreadTerminate;
    Start;
  end;
end;

procedure TGetThreadedData.Post(const url, data: String; aOnCompletionHandler: TNotifyEvent);
begin
  FEventHandler := aOnCompletionHandler;
  with TDBThread.Create(url, data, OT_POST) do
  begin
    FreeOnTerminate := false;
    OnTerminate := ThreadTerminate;
    Start;
  end;
end;

procedure TGetThreadedData.Put(const url, data: String; aOnCompletionHandler: TNotifyEvent);
begin
  FEventHandler := aOnCompletionHandler;
  With TDBThread.Create(url, data, OT_PUT) do
  begin
    FreeOnTerminate := true;
    OnTerminate := ThreadTerminate;
    Start;
  end;
end;

procedure TGetThreadedData.ThreadTerminate(Sender: TObject);
begin
  FRoomerDataSet.RecordSet := TDBThread(Sender).RecordSet;
//  if Assigned(FRoomerDataSet) then
//    try FRoomerDataSet.LogoutUnaffected; except end;
  if assigned(FEventHandler) then
    FEventHandler(self);
end;

constructor TGetThreadedData.Create;
begin
  inherited;
{$IFDEF rmMONITOR_LEAKAGE}
  ReportMemoryLeaksOnShutDown := IsDebuggerPresent();
{$ENDIF}
  FRoomerDataSet := CreateNewDataSet;
  FRoomerDataSet.RoomerDataSet := nil;
end;

destructor TGetThreadedData.Destroy;
begin
  FRoomerDataSet.Free;
  inherited;
end;

{ TDBThread }

constructor TDBThread.Create(const aSQL: String; aFDArray: TFieldInfoArray);
begin
  inherited Create(True);
  FSQL := aSQL;
  FFDArray := aFDArray;
end;

constructor TDBThread.Create(const sql, data: String; OperationType: TOperationType);
begin
  inherited Create(True);
  FSQL := sql;
  FOperationType := OperationType;
  FData := data;
end;

procedure TBaseDBThread.Execute;
begin
  inherited;
  CoInitialize(nil);
  try
    NameThreadForDebugging(Classname);
    FRoomerDataSet := CreateNewDataSet;
    try
      FRoomerDataSet.RoomerDataSet := nil;

      InternalExecute;

    finally
      FRoomerDataSet.Free;
    end;
  finally
    CoUnInitialize;
  end;
end;


procedure TDBThread.InternalExecute;
begin
  inherited;
  try
    case FOperationType of
      OT_EXECUTE:  ExecuteSQL(FSQL);
      OT_PUT:      ExecutePut(FSQL, FData);
      OT_POST:     ExecutePost(FSQL, FData);
    end;
  except
    // what to do here ...
  end;
end;

procedure TBaseDBThread.ExecutePOST(const aCommand, aData: string);
begin
  FRoomerDataSet.PostData(aCommand, aData);
end;

procedure TBaseDBThread.ExecutePUT(const aCommand, aData: string);
begin
  FRoomerDataSet.PutData(aCommand, aData);
end;

procedure TBaseDBThread.ExecuteSQL(const aCommand: string);
begin
  FreeAndNil(FRecordSet);
  FRoomerDataSet.CommandType := cmdText;
  FRoomerDataSet.CommandText := aCommand;
  FRoomerDataSet.Open(false, false, true);
  FRecordSet := FRoomerDataSet.RecordSet; // keep recordset
end;

end.
