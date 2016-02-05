unit uRoomerThreadedRequest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, cmpRoomerDataSet;

type

  TOperationType = (OT_EXECUTE, OT_PUT, OT_POST);

  TFieldInfoRecord = Record // as far as sometimes parametertypes can not be detected by
    DataType: TFieldType; // Ado on his own, provide all needed informations
    Name: String;
    Size: Integer;
    Value: Variant;
  End;

  TFieldInfoArray = Array of TFieldInfoRecord;

  TDBThread = Class(TThread)
    Constructor Create(Const SQL: String; FDArray: TFieldInfoArray); overload;
    Constructor Create(Const SQL, Data: String; OperationType : TOperationType); overload;
  private
    FSQL: String;
    FData: String;
    FOperationType : TOperationType;
    FFDArray: TFieldInfoArray;
    FRecordSet: _RecordSet;
  Protected
    Procedure Execute; override;
  public
    Property RecordSet: _RecordSet read FRecordSet;
  End;

  TGetThreadedData = class
    FDataSet : TRoomerDataSet;
    FEventHandler : TNotifyEvent;
    procedure Execute(const sql : String; handler : TNotifyEvent);
    procedure Put(const url, data : String; handler : TNotifyEvent);
    procedure Post(const url, data : String; handler : TNotifyEvent);
  private
    procedure ThreadTerminate(Sender: TObject);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create; overload;
    constructor Create(OperationType : TOperationType); overload;
    destructor Destroy;
    property DataSet : TRoomerDataSet read FDataSet;
  end;

implementation

uses ActiveX, uD;

procedure TGetThreadedData.Execute(const sql : String; handler : TNotifyEvent);
begin
  FEventHandler := handler;
  With TDBThread.Create(sql, nil) do
  begin
    FOperationType := OT_EXECUTE;
    FreeOnTerminate := true;
    // assign the procedure to be called on terminate
    OnTerminate := ThreadTerminate;
  end;
end;

procedure TGetThreadedData.Post(const url, data: String; handler: TNotifyEvent);
begin
  FEventHandler := handler;
  With TDBThread.Create(url, data, OT_POST) do
  begin
    FreeOnTerminate := true;
    // assign the procedure to be called on terminate
    OnTerminate := ThreadTerminate;
  end;
end;

procedure TGetThreadedData.Put(const url, data: String; handler: TNotifyEvent);
begin
  FEventHandler := handler;
  With TDBThread.Create(url, data, OT_PUT) do
  begin
    FreeOnTerminate := true;
    // assign the procedure to be called on terminate
    OnTerminate := ThreadTerminate;
  end;
end;

procedure TGetThreadedData.ThreadTerminate(Sender: TObject);
begin
  FDataSet.RecordSet := TDBThread(Sender).RecordSet;
  if assigned(FEventHandler) then
    FEventHandler(self);
end;

constructor TGetThreadedData.Create;
begin
  inherited;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutDown := IsDebuggerPresent();
{$ENDIF}
  FDataSet := CreateNewDataSet;
  FDataSet.RoomerDataSet := nil;
end;

constructor TGetThreadedData.Create(OperationType: TOperationType);
begin
  inherited Create;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutDown := IsDebuggerPresent();
{$ENDIF}
  FDataSet := CreateNewDataSet;
  FDataSet.RoomerDataSet := nil;
end;

destructor TGetThreadedData.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

{ TDBThread }

constructor TDBThread.Create(const SQL: String;
  FDArray: TFieldInfoArray);
var
  I: Integer;
begin
  inherited Create(false);
  FSQL := SQL;
end;

constructor TDBThread.Create(const SQL, Data: String; OperationType: TOperationType);
begin
  inherited Create(false);
  FSQL := SQL;
  FOperationType := OperationType;
  FData := data;
end;

procedure TDBThread.Execute;
var
  I: Integer;
  DataSet : TRoomerDataset;
begin
  inherited;
  CoInitialize(nil);
  try
    DataSet := CreateNewDataSet;
    DataSet.RoomerDataSet := nil;
    With DataSet do
      case FOperationType of
        OT_EXECUTE : begin
          try
            DataSet.CommandType := cmdText;
            DataSet.CommandText := FSQL;
            try
              DataSet.open(false);
            except
              on e: exception do
              begin
                raise;
              end;
            end;

            FRecordSet := RecordSet; // keep recordset
          finally
            Free;
          end;
        end;
        OT_PUT : DataSet.PutData(FSql, FData);
        OT_POST : DataSet.PostData(FSql, FData);
      end;
  finally
    CoUnInitialize;
  end;
end;

end.
