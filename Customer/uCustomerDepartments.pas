unit uCustomerDepartments;

interface

uses Generics.Collections,
     Classes,
     SysUtils,
     uDateUtils,
     uStringUtils,
     cmpRoomerDataset,
     uPersons;

type

  TCustomerDepartment = class
  private
    FDepartmentName: String;
    FNotes: String;
    FZip: String;
    FFaxNo: String;
    FTelNo2: String;
    FAddress2: String;
    FTelNo1: String;
    FCountry: String;
    FAddress1: String;
    FCity: String;
    FEmailAddress: String;

    FEdited : Boolean;
    FID: Integer;
    FCustomerId: Integer;

    procedure SetAddress1(const Value: String);
    procedure SetAddress2(const Value: String);
    procedure SetCity(const Value: String);
    procedure SetCountry(const Value: String);
    procedure SetDepartmentName(const Value: String);
    procedure SetEmailAddress(const Value: String);
    procedure SetFaxNo(const Value: String);
    procedure SetNotes(const Value: String);
    procedure SetTelNo1(const Value: String);
    procedure SetTelNo2(const Value: String);
    procedure SetZip(const Value: String);
    procedure SetCustomerId(const Value: Integer);
    procedure SetId(const Value: Integer);
  public
    Contacts : TPersonList;
    constructor Create; overload;
    constructor Create(_ID : Integer;
                       _CustomerId : Integer;
                       _DepartmentName: String;
                       _Address1: String;
                       _Address2: String;
                       _Zip: String;
                       _City: String;
                       _Country: String;
                       _TelNo1: String;
                       _TelNo2: String;
                       _FaxNo: String;
                       _EmailAddress: String;
                       _Notes: String;
                       _RetrieveContacts : Boolean = True); overload;

    destructor Destroy; override;
    procedure PostChanges;
    procedure Delete;

    procedure RetrieveContacts;
    procedure AddContact(ID: Integer);

    property ID : Integer read FID write SetId;
    property CustomerId : Integer read FCustomerId write SetCustomerId;
    property DepartmentName : String read FDepartmentName write SetDepartmentName;
    property Address1 : String read FAddress1 write SetAddress1;
    property Address2 : String read FAddress2 write SetAddress2;
    property Zip : String read FZip write SetZip;
    property City : String read FCity write SetCity;
    property Country : String read FCountry write SetCountry;
    property TelNo1 : String read FTelNo1 write SetTelNo1;
    property TelNo2 : String read FTelNo2 write SetTelNo2;
    property FaxNo : String read FFaxNo write SetFaxNo;
    property EmailAddress : String read FEmailAddress write SetEmailAddress;
    property Notes : String read FNotes write SetNotes;
  end;

   TCustomerDepartments = class
     CustomerDepartments : TList<TCustomerDepartment>;
  private
    FCustomerId: Integer;
    function GetCount: Integer;
    function GetITems(Index: Integer): TCustomerDepartment;
    procedure SetCustomerId(const Value: Integer);
   public
     constructor Create(_CustomerId : Integer);
     destructor Destroy; override;

     function Add(Item : TCustomerDepartment) : Integer;
     procedure Remove(Item : TCustomerDepartment);
     procedure PostChanges;

     property Items[Index : Integer] : TCustomerDepartment read GetITems; default;
     property Count : Integer read GetCount;
     property CustomerId : Integer read FCustomerId write SetCustomerId;
   end;

var
   CustomerDepartments : TCustomerDepartments;

procedure GetCustomerDepartments(CustomerId : Integer; IncludeContacts : Boolean = True);

implementation

uses uD, hData, _Glob;

procedure ReadCustomerDepartments(CustomerId : Integer; List : TCustomerDepartments; IncludeContacts : Boolean = True);
var sql : String;
    rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
    sql := format('SELECT * FROM customerdepartments WHERE CustomerId = %s', [_db(CustomerId)]);
    if rSet_bySQL(rSet, sql, False) then
    begin
      rSet.First;
      while NOT rSet.Eof do
      begin
        List.Add(TCustomerDepartment.Create(rSet['ID'],
                                            rSet['CustomerId'],
                                            rSet['DepartmentName'],
                                            rSet['Address1'],
                                            rSet['Address2'],
                                            rSet['Zip'],
                                            rSet['City'],
                                            rSet['Country'],
                                            rSet['TelNo1'],
                                            rSet['TelNo2'],
                                            rSet['FaxNo'],
                                            rSet['EmailAddress'],
                                            rSet['Notes'],

                                            IncludeContacts));
        rSet.Next;
      end;
    end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure GetCustomerDepartments(CustomerId : Integer; IncludeContacts : Boolean = True);
begin
  if Assigned(CustomerDepartments) then
    CustomerDepartments.Free;
  CustomerDepartments := TCustomerDepartments.Create(CustomerId);
  CustomerDepartments.CustomerId := CustomerId;
  ReadCustomerDepartments(CustomerId, CustomerDepartments, IncludeContacts);
end;

procedure SetCustomerDepartmentsCustomerId(List : TCustomerDepartments; CustomerId : Integer);
begin
end;


{ TCustomerDepartment }

constructor TCustomerDepartment.Create;
begin
  FID := 0;
  FDepartmentName := '';
  FNotes := '';
  FZip := '';
  FFaxNo := '';
  FTelNo2 := '';
  FAddress2 := '';
  FTelNo1 := '';
  FCountry := '';
  FAddress1 := '';
  FCity := '';
  FEmailAddress := '';

  Contacts := TPersonList.Create(True);

  FEdited := False;
end;

constructor TCustomerDepartment.Create(_ID : Integer;
                                       _CustomerId : Integer;
                                       _DepartmentName: String;
                                       _Address1: String;
                                       _Address2: String;
                                       _Zip: String;
                                       _City: String;
                                       _Country: String;
                                       _TelNo1: String;
                                       _TelNo2: String;
                                       _FaxNo: String;
                                       _EmailAddress: String;
                                       _Notes: String;
                                       _RetrieveContacts : Boolean = True);
begin
  Create;

  FID := _ID;
  FCustomerId := _CustomerId;
  FDepartmentName := _DepartmentName;
  FNotes := _Notes;
  FZip := _Zip;
  FFaxNo := _FaxNo;
  FTelNo2 := _TelNo2;
  FAddress2 := _Address2;
  FTelNo1 := _TelNo1;
  FCountry := _Country;
  FAddress1 := _Address1;
  FCity := _City;
  FEmailAddress := _EmailAddress;

  if _RetrieveContacts then
    RetrieveContacts
end;

procedure TCustomerDepartment.Delete;
begin
  d.roomerMainDataSet.DoCommand(format('DELETE FROM customerdepartments WHERE ID=%d', [FID]));
  d.roomerMainDataSet.DoCommand(format('DELETE FROM customerdepartments_persons_links WHERE CustomerDepartmentsId=%d', [FID]));
end;

destructor TCustomerDepartment.Destroy;
begin
  Contacts.Free;
end;

procedure TCustomerDepartment.PostChanges;
var sql : String;
    ExecResult : Integer;
begin
  sql := '';
  if FID = 0 then
  begin
    sql := format('INSERT INTO customerdepartments ' +
           '(CustomerId, ' +
           'DepartmentName, ' +
           'Address1, ' +
           'Address2, ' +
           'Zip, ' +
           'City, ' +
           'Country, ' +
           'TelNo1, ' +
           'TelNo2, ' +
           'FaxNo, ' +
           'EmailAddress, ' +
           'Notes) ' +
           'VALUES (' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s)',
           [ _db(FCustomerId),
             _db(FDepartmentName),
             _db(FAddress1),
             _db(FAddress2),
             _db(FZip),
             _db(FCity),
             _db(Country),
             _db(TelNo1),
             _db(TelNo2),
             _db(FaxNo),
             _db(FEmailAddress),
             _db(FNotes)
           ]);
  end else
  if FEdited then
  begin
    sql := format('UPDATE customerdepartments ' +
           'SET CustomerId=%s, ' +
           'DepartmentName=%s, ' +
           'Address1=%s, ' +
           'Address2=%s, ' +
           'Zip=%s, ' +
           'City=%s, ' +
           'Country=%s, ' +
           'TelNo1=%s, ' +
           'TelNo2=%s, ' +
           'FaxNo=%s, ' +
           'EmailAddress=%s, ' +
           'Notes=%s ' +
           'WHERE ID=%d',
           [ _db(FCustomerId),
             _db(FDepartmentName),
             _db(FAddress1),
             _db(FAddress2),
             _db(FZip),
             _db(FCity),
             _db(Country),
             _db(TelNo1),
             _db(TelNo2),
             _db(FaxNo),
             _db(FEmailAddress),
             _db(FNotes),
             FID
           ]);
  end;

  if sql <> '' then
  begin
    ExecResult := d.roomerMainDataSet.DoCommand(sql);
    if FID = 0 then
      FID := ExecResult;
  end;

  FEdited := False;

  PostPersons(FID, Contacts);
end;

procedure TCustomerDepartment.RetrieveContacts;
begin
  Contacts.Free;
  Contacts := GetPersonsListForCustomerDepartment(FID);
end;

procedure TCustomerDepartment.AddContact(ID : Integer);
var index : Integer;
begin
  index := Contacts.Add(GetPersonsFromID(ID));
  Contacts[index].New := True;
end;


procedure TCustomerDepartment.SetAddress1(const Value: String);
begin
  FAddress1 := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetAddress2(const Value: String);
begin
  FAddress2 := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetCity(const Value: String);
begin
  FCity := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetCountry(const Value: String);
begin
  FCountry := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetCustomerId(const Value: Integer);
begin
  FCustomerId := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetDepartmentName(const Value: String);
begin
  FDepartmentName := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetEmailAddress(const Value: String);
begin
  FEmailAddress := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetFaxNo(const Value: String);
begin
  FFaxNo := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetId(const Value: Integer);
begin
  FID := Value;
end;

procedure TCustomerDepartment.SetNotes(const Value: String);
begin
  FNotes := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetTelNo1(const Value: String);
begin
  FTelNo1 := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetTelNo2(const Value: String);
begin
  FTelNo2 := Value;
  FEdited := True;
end;

procedure TCustomerDepartment.SetZip(const Value: String);
begin
  FZip := Value;
  FEdited := True;
end;

{ TCustomerDepartments }

function TCustomerDepartments.Add(Item: TCustomerDepartment): Integer;
begin
  Item.CustomerId := FCustomerId;
  result := CustomerDepartments.Add(Item)
end;

constructor TCustomerDepartments.Create(_CustomerId: Integer);
begin
  FCustomerId := _CustomerId;
  CustomerDepartments := TList<TCustomerDepartment>.Create;
end;

destructor TCustomerDepartments.Destroy;
begin
  CustomerDepartments.Free;
end;

function TCustomerDepartments.GetCount: Integer;
begin
  result := CustomerDepartments.Count;
end;

function TCustomerDepartments.GetITems(Index: Integer): TCustomerDepartment;
begin
  result := CustomerDepartments[Index];
end;

procedure TCustomerDepartments.PostChanges;
var i: Integer;
begin
  for i := 0 to Count - 1 do
    CustomerDepartments[i].PostChanges;
end;

procedure TCustomerDepartments.Remove(Item: TCustomerDepartment);
begin
  CustomerDepartments.Remove(Item);
end;

procedure TCustomerDepartments.SetCustomerId(const Value: Integer);
var i : Integer;
begin
  FCustomerId := Value;
  for i := 0 to Count - 1 do
    CustomerDepartments[i].CustomerId := CustomerId;
end;

initialization

  CustomerDepartments := nil;

finalization

  if Assigned(CustomerDepartments) then
    CustomerDepartments.Free;


end.

