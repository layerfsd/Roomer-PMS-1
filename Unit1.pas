unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids;

type

  TFieldInfoRecord = Record // as far as sometimes parametertypes can not be detected by
    DataType: TFieldType; // Ado on his own, provide all needed informations
    Name: String;
    Size: Integer;
    Value: Variant;
  End;

  TFieldInfoArray = Array of TFieldInfoRecord;

  TDBThread = Class(TThread)
    Constructor Create(Const SQL: String;
      FDArray: TFieldInfoArray);
  private
    FSQL: String;
    FFDArray: TFieldInfoArray;
    FRecordSet: _RecordSet;
  Protected
    Procedure Execute; override;
  public
    Property RecordSet: _RecordSet read FRecordSet;
  End;

  TGetThreadedData = class
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
  private
    procedure ThreadTerminate(Sender: TObject);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create;
    destructor Destroy;
  end;

implementation

uses ActiveX;
{$R *.dfm}

procedure TGetThreadedData.Button1Click(Sender: TObject);
var
  FDArray: TFieldInfoArray;
  I: Integer;
begin
  // prepare parameterinformations
  SetLength(FDArray, 1);
  FDArray[0].Name := 'cn';
  FDArray[0].DataType := ftString;
  FDArray[0].Size := 20;
  FDArray[0].Value := '%ue%';

  for I := 0 to 10 do // testrun with 11 threads

    With TDBThread.Create(ADOConnection1.ConnectionString,
      'select * from Composition where Componame like :cn', FDArray) do
    begin
      FreeOnTerminate := true;
      // assign the wished procedure to ba called on terminate
      OnTerminate := ThreadTerminate;
    end;

end;

procedure TGetThreadedData.ThreadTerminate(Sender: TObject);
begin
  // example of assigning the recordset of the thread for displaying and editing
  // NOTE for editing the connection of ADODataSet1 has to be fitting to the threadcall
  ADODataSet1.RecordSet := TDBThread(Sender).RecordSet;
end;

procedure TGetThreadedData.Create;
begin
  ReportMemoryLeaksOnShutDown := true;
end;


destructor TGetThreadedData.Destroy;
begin
  //
end;

{ TDBThread }

constructor TDBThread.Create(const SQL: String;
  FDArray: TFieldInfoArray);
var
  I: Integer;
begin
  inherited Create(false);
  FSQL := SQL;
//  SetLength(FFDArray, Length(FDArray));
//  for I := 0 to High(FDArray) do
//  begin
//    FFDArray[I].DataType := FDArray[I].DataType;
//    FFDArray[I].Size := FDArray[I].Size;
//    FFDArray[I].Name := FDArray[I].Name;
//    FFDArray[I].Value := FDArray[I].Value;
//  end;
end;

procedure TDBThread.Execute;
var
  I: Integer;
begin
  inherited;
  CoInitialize(nil);
  try
    With TADODataSet.Create(nil) do
      try
        CommandTimeOut := 600;
        ConnectionString := FConnectionString;
        // use own connection for the dataset
        // will requite a conncetionsstring including all
        // information for loggon
        Commandtext := FSQL;
        Parameters.ParseSQL(FSQL, true); // extract parameters
        for I := Low(FFDArray) to High(FFDArray) do // set parametervalues
        begin
          Parameters.ParamByName(FFDArray[I].Name).DataType := FFDArray[I]
            .DataType;
          Parameters.ParamByName(FFDArray[I].Name).Size := FFDArray[I].Size;
          Parameters.ParamByName(FFDArray[I].Name).Value := FFDArray[I].Value;
        end;
        Open;
        FRecordSet := RecordSet; // keep recordset
      finally
        Free;
      end;
  finally
    CoUnInitialize;
  end;
end;

end.
