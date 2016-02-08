unit uPersons;

interface

uses Generics.Collections,
     Classes,
     SysUtils,
     uDateUtils,
     uStringUtils,
     cmpRoomerDataset,
     Data.DB;

type

  TPerson = class
  private
    FCompVATNumber: String;
    FInformation: String;
    FCarLicensePlate: String;
    FCompCity: String;
    FFacebookLink: String;
    FEmail: String;
    FRoom: String;
    FLastname: String;
    FProfession: String;
    FTelLandLine: String;
    FPassportExpiry: TDate;
    FFamilyInfo: String;
    FPreparation: String;
    FLinkedIn: String;
    FState: String;
    FZip: String;
    FEmailNews: Boolean;
    FCompanyName: String;
    FDateOfBirth: TDate;
    FTitle: String;
    FID: Integer;
    FCompEmail: String;
    FAddress2: String;
    FCompFax: String;
    FCustomerCode: String;
    FSkype: String;
    FTripadvisorAccount: String;
    FCountry: String;
    FAddress1: String;
    FNationality: String;
    FCompState: String;
    FCompZip: String;
    FInvoiceAddress: String;
    FEmailSpecials: Boolean;
    FWebsite: String;
    FTelFax: String;
    FTelMobile: String;
    FPassportNumber: String;
    FContactPerson: String;
    FCity: String;
    FSpouseBirthdate: TDate;
    FTwitter: String;
    FSpouseName: String;
    FFirstName: String;
    FCompTel: String;
    FCompAddress2: String;
    FRoomType: String;
    FSocialSecurityNumber: String;
    FCompCountry: String;
    FCompAddress1: String;
    FMaleFemale: String;
    procedure SetAddress1(const Value: String);
    procedure SetAddress2(const Value: String);
    procedure SetCarLicensePlate(const Value: String);
    procedure SetCity(const Value: String);
    procedure SetCompAddress1(const Value: String);
    procedure SetCompAddress2(const Value: String);
    procedure SetCompanyName(const Value: String);
    procedure SetCompCity(const Value: String);
    procedure SetCompCountry(const Value: String);
    procedure SetCompEmail(const Value: String);
    procedure SetCompFax(const Value: String);
    procedure SetCompState(const Value: String);
    procedure SetCompTel(const Value: String);
    procedure SetCompVATNumber(const Value: String);
    procedure SetCompZip(const Value: String);
    procedure SetContactPerson(const Value: String);
    procedure SetCountry(const Value: String);
    procedure SetCustomerCode(const Value: String);
    procedure SetDateOfBirth(const Value: TDate);
    procedure SetEmail(const Value: String);
    procedure SetEmailNews(const Value: Boolean);
    procedure SetEmailSpecials(const Value: Boolean);
    procedure SetFacebookLink(const Value: String);
    procedure SetFamilyInfo(const Value: String);
    procedure SetFirstName(const Value: String);
    procedure SetInformation(const Value: String);
    procedure SetInvoiceAddress(const Value: String);
    procedure SetLastname(const Value: String);
    procedure SetLinkedIn(const Value: String);
    procedure SetMaleFemale(const Value: String);
    procedure SetNationality(const Value: String);
    procedure SetPassportExpiry(const Value: TDate);
    procedure SetPassportNumber(const Value: String);
    procedure SetPreparation(const Value: String);
    procedure SetProfession(const Value: String);
    procedure SetRoom(const Value: String);
    procedure SetRoomType(const Value: String);
    procedure SetSkype(const Value: String);
    procedure SetSocialSecurityNumber(const Value: String);
    procedure SetSpouseBirthdate(const Value: TDate);
    procedure SetSpouseName(const Value: String);
    procedure SetState(const Value: String);
    procedure SetTelFax(const Value: String);
    procedure SetTelLandLine(const Value: String);
    procedure SetTelMobile(const Value: String);
    procedure SetTitle(const Value: String);
    procedure SetTripadvisorAccount(const Value: String);
    procedure SetTwitter(const Value: String);
    procedure SetWebsite(const Value: String);
    procedure SetZip(const Value: String);
  private
    FEdited : Boolean;
    FNew: Boolean;
    function GetFullName: String;
  public
    constructor Create(); overload;
    constructor Create(_ID : Integer); overload;
    constructor Create(_ID : Integer;
                        _MaleFemale,
                        _Title,
                        _FirstName,
                        _Lastname,
                        _Nationality : String;
                        _DateOfBirth : TDate;
                        _SocialSecurityNumber,
                        _PassportNumber : String;
                        _PassportExpiry : TDate;
                        _SpouseName : String;
                        _SpouseBirthdate : TDate;
                        _CarLicensePlate,
                        _ContactPerson,
                        _Profession,
                        _Room,
                        _RoomType : String;
                        _EmailSpecials,
                        _EmailNews : Boolean;
                        _Preparation,
                        _InvoiceAddress,
                        _Address1,
                        _Address2,
                        _Zip,
                        _City,
                        _State,
                        _Country,
                        _TelLandLine,
                        _TelMobile,
                        _TelFax,
                        _Email,
                        _Website,
                        _Skype,
                        _Twitter,
                        _LinkedIn,
                        _FacebookLink,
                        _TripadvisorAccount,
                        _Information,
                        _FamilyInfo,
                        _CustomerCode,
                        _CompanyName,
                        _CompVATNumber,
                        _CompAddress1,
                        _CompAddress2,
                        _CompZip,
                        _CompCity,
                        _CompState,
                        _CompCountry,
                        _CompTel,
                        _CompFax,
                        _CompEmail : String); overload;

    procedure PostChanges(CustomerDepartmentId : Integer);
    procedure Delete;

    property ID : Integer read FID;
    property MaleFemale : String read FMaleFemale write SetMaleFemale;
    property Title : String read FTitle write SetTitle;
    property FirstName : String read FFirstName write SetFirstName;
    property Lastname : String read FLastname write SetLastname;

    property FullName : String read GetFullName;

    property Nationality : String read FNationality write SetNationality;
    property DateOfBirth : TDate read FDateOfBirth write SetDateOfBirth;
    property SocialSecurityNumber : String read FSocialSecurityNumber write SetSocialSecurityNumber;
    property PassportNumber : String read FPassportNumber write SetPassportNumber;
    property PassportExpiry : TDate read FPassportExpiry write SetPassportExpiry;
    property SpouseName : String read FSpouseName write SetSpouseName;
    property SpouseBirthdate : TDate read FSpouseBirthdate write SetSpouseBirthdate;
    property CarLicensePlate : String read FCarLicensePlate write SetCarLicensePlate;
    property ContactPerson : String read FContactPerson write SetContactPerson;
    property Profession : String read FProfession write SetProfession;
    property Room : String read FRoom write SetRoom;
    property RoomType : String read FRoomType write SetRoomType;
    property EmailSpecials : Boolean read FEmailSpecials write SetEmailSpecials;
    property EmailNews : Boolean read FEmailNews write SetEmailNews;
    property Preparation : String read FPreparation write SetPreparation;
    property InvoiceAddress : String read FInvoiceAddress write SetInvoiceAddress;
    property Address1 : String read FAddress1 write SetAddress1;
    property Address2 : String read FAddress2 write SetAddress2;
    property Zip : String read FZip write SetZip;
    property City : String read FCity write SetCity;
    property State : String read FState write SetState;
    property Country : String read FCountry write SetCountry;
    property TelLandLine : String read FTelLandLine write SetTelLandLine;
    property TelMobile : String read FTelMobile write SetTelMobile;
    property TelFax : String read FTelFax write SetTelFax;
    property Email : String read FEmail write SetEmail;
    property Website : String read FWebsite write SetWebsite;
    property Skype : String read FSkype write SetSkype;
    property Twitter : String read FTwitter write SetTwitter;
    property LinkedIn : String read FLinkedIn write SetLinkedIn;
    property FacebookLink : String read FFacebookLink write SetFacebookLink;
    property TripadvisorAccount : String read FTripadvisorAccount write SetTripadvisorAccount;
    property Information : String read FInformation write SetInformation;
    property FamilyInfo : String read FFamilyInfo write SetFamilyInfo;
    property CustomerCode : String read FCustomerCode write SetCustomerCode;
    property CompanyName : String read FCompanyName write SetCompanyName;
    property CompVATNumber : String read FCompVATNumber write SetCompVATNumber;
    property CompAddress1 : String read FCompAddress1 write SetCompAddress1;
    property CompAddress2 : String read FCompAddress2 write SetCompAddress2;
    property CompZip : String read FCompZip write SetCompZip;
    property CompCity : String read FCompCity write SetCompCity;
    property CompState : String read FCompState write SetCompState;
    property CompCountry : String read FCompCountry write SetCompCountry;
    property CompTel : String read FCompTel write SetCompTel;
    property CompFax : String read FCompFax write SetCompFax;
    property CompEmail : String read FCompEmail write SetCompEmail;

    property New : Boolean read FNew write FNew;
  end;

  TPersonList = TObjectList<TPerson>;

function GetPersonsListForCustomerDepartment(CustomerDepartmentId : Integer) : TPersonList;
function CreatePersonFromRecord(rSet : TDataSet) : TPerson;
procedure PostPersons(CustomerDepartmentId : Integer; List : TPersonList);
function GetPersonsFromID(ID: Integer) : TPerson;
procedure UpdatePersonsFromID(Person : TPerson; ID: Integer);

implementation

uses uD, hData, _Glob;

function CreatePersonFromRecord(rSet : TDataSet) : TPerson;
begin
  result := TPerson.Create(
                        rSet['ID'],
                        rSet['MaleFemale'],
                        rSet['Title'],
                        rSet['FirstName'],
                        rSet['Lastname'],
                        rSet['Nationality'],
                        rSet['DateOfBirth'],
                        rSet['SocialSecurityNumber'],
                        rSet['PassportNumber'],
                        rSet['PassportExpiry'],
                        rSet['SpouseName'],
                        rSet['SpouseBirthdate'],
                        rSet['CarLicensePlate'],
                        rSet['ContactPerson'],
                        rSet['Profession'],
                        rSet['Room'],
                        rSet['RoomType'],
                        rSet['EmailSpecials'],
                        rSet['EmailNews'],
                        rSet['Preparation'],
                        rSet['InvoiceAddress'],
                        rSet['Address1'],
                        rSet['Address2'],
                        rSet['Zip'],
                        rSet['City'],
                        rSet['State'],
                        rSet['Country'],
                        rSet['TelLandLine'],
                        rSet['TelMobile'],
                        rSet['TelFax'],
                        rSet['Email'],
                        rSet['Website'],
                        rSet['Skype'],
                        rSet['Twitter'],
                        rSet['LinkedIn'],
                        rSet['FacebookLink'],
                        rSet['TripadvisorAccount'],
                        rSet['Information'],
                        rSet['FamilyInfo'],
                        rSet['CustomerCode'],
                        rSet['CompanyName'],
                        rSet['CompVATNumber'],
                        rSet['CompAddress1'],
                        rSet['CompAddress2'],
                        rSet['CompZip'],
                        rSet['CompCity'],
                        rSet['CompState'],
                        rSet['CompCountry'],
                        rSet['CompTel'],
                        rSet['CompFax'],
                        rSet['CompEmail']);
end;

procedure UpdatePersonFromRecord(Person : TPerson; rSet : TDataSet);
begin
  Person.MaleFemale := rSet['MaleFemale'];
  Person.Title := rSet['Title'];
  Person.FirstName := rSet['FirstName'];
  Person.Lastname := rSet['Lastname'];
  Person.Nationality := rSet['Nationality'];
  Person.DateOfBirth := rSet['DateOfBirth'];
  Person.SocialSecurityNumber := rSet['SocialSecurityNumber'];
  Person.PassportNumber := rSet['PassportNumber'];
  Person.PassportExpiry := rSet['PassportExpiry'];
  Person.SpouseName := rSet['SpouseName'];
  Person.SpouseBirthdate := rSet['SpouseBirthdate'];
  Person.CarLicensePlate := rSet['CarLicensePlate'];
  Person.ContactPerson := rSet['ContactPerson'];
  Person.Profession := rSet['Profession'];
  Person.Room := rSet['Room'];
  Person.RoomType := rSet['RoomType'];
  Person.EmailSpecials := rSet['EmailSpecials'];
  Person.EmailNews := rSet['EmailNews'];
  Person.Preparation := rSet['Preparation'];
  Person.InvoiceAddress := rSet['InvoiceAddress'];
  Person.Address1 := rSet['Address1'];
  Person.Address2 := rSet['Address2'];
  Person.Zip := rSet['Zip'];
  Person.City := rSet['City'];
  Person.State := rSet['State'];
  Person.Country := rSet['Country'];
  Person.TelLandLine := rSet['TelLandLine'];
  Person.TelMobile := rSet['TelMobile'];
  Person.TelFax := rSet['TelFax'];
  Person.Email := rSet['Email'];
  Person.Website := rSet['Website'];
  Person.Skype := rSet['Skype'];
  Person.Twitter := rSet['Twitter'];
  Person.LinkedIn := rSet['LinkedIn'];
  Person.FacebookLink := rSet['FacebookLink'];
  Person.TripadvisorAccount := rSet['TripadvisorAccount'];
  Person.Information := rSet['Information'];
  Person.FamilyInfo := rSet['FamilyInfo'];
  Person.CustomerCode := rSet['CustomerCode'];
  Person.CompanyName := rSet['CompanyName'];
  Person.CompVATNumber := rSet['CompVATNumber'];
  Person.CompAddress1 := rSet['CompAddress1'];
  Person.CompAddress2 := rSet['CompAddress2'];
  Person.CompZip := rSet['CompZip'];
  Person.CompCity := rSet['CompCity'];
  Person.CompState := rSet['CompState'];
  Person.CompCountry := rSet['CompCountry'];
  Person.CompTel := rSet['CompTel'];
  Person.CompFax := rSet['CompFax'];
  Person.CompEmail := rSet['CompEmail'];
end;

function GetPersonsListForCustomerDepartment(CustomerDepartmentId : Integer) : TPersonList;
var rSet : TRoomerDataSet;
    Person : TPerson;
begin
  result := TPersonList.Create(True);
  rSet := CreateNewDataSet;
  try
  if rSet_bySQL(rSet, format('SELECT * FROM personprofiles WHERE ID IN (SELECT PersonsId FROM customerdepartments_persons_links WHERE CustomerDepartmentsId=%d)', [CustomerDepartmentId])) then
  begin
    rSet.First;
    while NOT rSet.Eof do
    begin
      Person := CreatePersonFromRecord(rSet);
      result.Add(Person);
      rSet.Next;
    end;
  end;
  finally
    FreeAndNil(rSet);
  end;
end;

function GetPersonsFromID(ID: Integer) : TPerson;
var rSet : TRoomerDataSet;
begin
  result := nil;
  rSet := CreateNewDataSet;
  try
  if rSet_bySQL(rSet, format('SELECT * FROM personprofiles WHERE ID=%d', [ID])) then
  begin
    rSet.First;
    result := CreatePersonFromRecord(rSet);
  end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure UpdatePersonsFromID(Person : TPerson; ID: Integer);
var rSet : TRoomerDataSet;
begin
  rSet := CreateNewDataSet;
  try
  if rSet_bySQL(rSet, format('SELECT * FROM personprofiles WHERE ID=%d', [ID])) then
  begin
    rSet.First;
    UpdatePersonFromRecord(Person, rSet);
  end;
  finally
    FreeAndNil(rSet);
  end;
end;

procedure PostPersons(CustomerDepartmentId : Integer; List : TPersonList);
var i: Integer;
begin
  for i := 0 to List.Count - 1 do
    List[i].PostChanges(CustomerDepartmentId);
end;

{ TPerson }

constructor TPerson.Create(_ID: Integer);
begin
  FCompVATNumber := '';
  FInformation := '';
  FCarLicensePlate := '';
  FCompCity := '';
  FFacebookLink := '';
  FEmail := '';
  FRoom := '';
  FLastname := '';
  FProfession := '';
  FTelLandLine := '';
  FPassportExpiry := 0;
  FFamilyInfo := '';
  FPreparation := '';
  FLinkedIn := '';
  FState := '';
  FZip := '';
  FEmailNews := False;
  FCompanyName := '';
  FDateOfBirth := 0;
  FTitle := '';
  FID := 0;
  FCompEmail := '';
  FAddress2 := '';
  FCompFax := '';
  FCustomerCode := '';
  FSkype := '';
  FTripadvisorAccount := '';
  FCountry := '';
  FAddress1 := '';
  FNationality := '';
  FCompState := '';
  FCompZip := '';
  FInvoiceAddress := '';
  FEmailSpecials := False;
  FWebsite := '';
  FTelFax := '';
  FTelMobile := '';
  FPassportNumber := '';
  FContactPerson := '';
  FCity := '';
  FSpouseBirthdate := 0;
  FTwitter := '';
  FSpouseName := '';
  FFirstName := '';
  FCompTel := '';
  FCompAddress2 := '';
  FRoomType := '';
  FSocialSecurityNumber := '';
  FCompCountry := '';
  FCompAddress1 := '';
  FMaleFemale := '';

  FEdited := False;
  FNew := False;
end;

constructor TPerson.Create(_ID: Integer; _MaleFemale, _Title, _FirstName, _Lastname, _Nationality : String; _DateOfBirth: TDate; _SocialSecurityNumber,
  _PassportNumber: String; _PassportExpiry: TDate; _SpouseName: String; _SpouseBirthdate: TDate; _CarLicensePlate, _ContactPerson, _Profession, _Room,
  _RoomType: String; _EmailSpecials, _EmailNews: Boolean; _Preparation, _InvoiceAddress, _Address1, _Address2, _Zip, _City, _State, _Country, _TelLandLine,
  _TelMobile, _TelFax, _Email, _Website, _Skype, _Twitter, _LinkedIn, _FacebookLink, _TripadvisorAccount, _Information, _FamilyInfo, _CustomerCode,
  _CompanyName, _CompVATNumber, _CompAddress1, _CompAddress2, _CompZip, _CompCity, _CompState, _CompCountry, _CompTel, _CompFax, _CompEmail: String);
begin
  FCompVATNumber := _CompVATNumber;
  FInformation := _Information;
  FCarLicensePlate := _CarLicensePlate;
  FCompCity := _CompCity;
  FFacebookLink := _FacebookLink;
  FEmail := _Email;
  FRoom := _Room;
  FLastname := _Lastname;
  FProfession := _Profession;
  FTelLandLine := _TelLandLine;
  FPassportExpiry := _PassportExpiry;
  FFamilyInfo := _FamilyInfo;
  FPreparation := _Preparation;
  FLinkedIn := _LinkedIn;
  FState := _State;
  FZip := _Zip;
  FEmailNews := _EmailNews;
  FCompanyName := _CompanyName;
  FDateOfBirth := _DateOfBirth;
  FTitle := _Title;
  FID := _ID;
  FCompEmail := _CompEmail;
  FAddress2 := _Address2;
  FCompFax := _CompFax;
  FCustomerCode := _CustomerCode;
  FSkype := _Skype;
  FTripadvisorAccount := _TripadvisorAccount;
  FCountry := _Country;
  FAddress1 := _Address1;
  FNationality := _Nationality;
  FCompState := _CompState;
  FCompZip := _CompZip;
  FInvoiceAddress := _InvoiceAddress;
  FEmailSpecials := _EmailSpecials;
  FWebsite := _Website;
  FTelFax := _TelFax;
  FTelMobile := _TelMobile;
  FPassportNumber := _PassportNumber;
  FContactPerson := _ContactPerson;
  FCity := _City;
  FSpouseBirthdate := _SpouseBirthdate;
  FTwitter := _Twitter;
  FSpouseName := _SpouseName;
  FFirstName := _FirstName;
  FCompTel := _CompTel;
  FCompAddress2 := _CompAddress2;
  FRoomType := _RoomType;
  FSocialSecurityNumber := _SocialSecurityNumber;
  FCompCountry := _CompCountry;
  FCompAddress1 := _CompAddress1;
  FMaleFemale := _MaleFemale;

  FEdited := False;
  FNew := False;
end;

procedure TPerson.Delete;
begin
  d.roomerMainDataSet.DoCommand(format('DELETE FROM personprofiles WHERE ID=%d', [FID]));
  d.roomerMainDataSet.DoCommand(format('DELETE FROM customerdepartments_persons_links WHERE PersonsId=%d', [FID]));
end;

function TPerson.GetFullName: String;
begin
  result := Trim(format('%s %s', [FFirstname, FLastname]));
end;

procedure TPerson.PostChanges(CustomerDepartmentId : Integer);
var sql : String;
    ExecResult : Integer;
begin
  sql := '';
  if FID = 0 then
  begin
    sql := 'INSERT INTO personprofiles ' +
           '(MaleFemale, ' +
           'Title, ' +
           'FirstName, ' +
           'Lastname, ' +
           'Nationality, ' +
           'DateOfBirth, ' +
           'SocialSecurityNumber, ' +
           'PassportNumber, ' +
           'PassportExpiry, ' +
           'SpouseName, ' +
           'SpouseBirthdate, ' +
           'CarLicensePlate, ' +
           'ContactPerson, ' +
           'Profession, ' +
           'Room, ' +
           'RoomType, ' +
           'EmailSpecials, ' +
           'EmailNews, ' +
           'Preparation, ' +
           'InvoiceAddress, ' +
           'Address1, ' +
           'Address2, ' +
           'Zip, ' +
           'City, ' +
           'State, ' +
           'Country, ' +
           'TelLandLine, ' +
           'TelMobile, ' +
           'TelFax, ' +
           'Email, ' +
           'Website, ' +
           'Skype, ' +
           'Twitter, ' +
           'LinkedIn, ' +
           'FacebookLink, ' +
           'TripadvisorAccount, ' +
           'Information, ' +
           'FamilyInfo, ' +
           'CustomerCode, ' +
           'CompanyName, ' +
           'CompVATNumber, ' +
           'CompAddress1, ' +
           'CompAddress2, ' +
           'CompZip, ' +
           'CompCity, ' +
           'CompState, ' +
           'CompCountry, ' +
           'CompTel, ' +
           'CompFax, ' +
           'CompEmail) ' +
           'VALUES ' +
           '(%s, ' +
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
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s, ' +
           '%s ';
    sql := format(sql,
                  [
                  _db(FMaleFemale),
                  _db(FTitle),
                  _db(FFirstName),
                  _db(FLastname),
                  _db(FNationality),
                  _db(FDateOfBirth),
                  _db(FSocialSecurityNumber),
                  _db(FPassportNumber),
                  _db(FPassportExpiry),
                  _db(FSpouseName),
                  _db(FSpouseBirthdate),
                  _db(FCarLicensePlate),
                  _db(FContactPerson),
                  _db(FProfession),
                  _db(FRoom),
                  _db(FRoomType),
                  _db(FEmailSpecials),
                  _db(FEmailNews),
                  _db(FPreparation),
                  _db(FInvoiceAddress),
                  _db(FAddress1),
                  _db(FAddress2),
                  _db(FZip),
                  _db(FCity),
                  _db(FState),
                  _db(FCountry),
                  _db(FTelLandLine),
                  _db(FTelMobile),
                  _db(FTelFax),
                  _db(FEmail),
                  _db(FWebsite),
                  _db(FSkype),
                  _db(FTwitter),
                  _db(FLinkedIn),
                  _db(FFacebookLink),
                  _db(FTripadvisorAccount),
                  _db(FInformation),
                  _db(FFamilyInfo),
                  _db(FCustomerCode),
                  _db(FCompanyName),
                  _db(FCompVATNumber),
                  _db(FCompAddress1),
                  _db(FCompAddress2),
                  _db(FCompZip),
                  _db(FCompCity),
                  _db(FCompState),
                  _db(FCompCountry),
                  _db(FCompTel),
                  _db(FCompFax),
                  _db(FCompEmail)
                  ]);
  end else
  if FEdited then
  begin
    sql := 'UPDATE personprofiles ' +
           ' SET MaleFemale=%s, ' +
           'Title=%s, ' +
           'FirstName=%s, ' +
           'Lastname=%s, ' +
           'Nationality=%s, ' +
           'DateOfBirth=%s, ' +
           'SocialSecurityNumber=%s, ' +
           'PassportNumber=%s, ' +
           'PassportExpiry=%s, ' +
           'SpouseName=%s, ' +
           'SpouseBirthdate=%s, ' +
           'CarLicensePlate=%s, ' +
           'ContactPerson=%s, ' +
           'Profession=%s, ' +
           'Room=%s, ' +
           'RoomType=%s, ' +
           'EmailSpecials=%s, ' +
           'EmailNews=%s, ' +
           'Preparation=%s, ' +
           'InvoiceAddress=%s, ' +
           'Address1=%s, ' +
           'Address2=%s, ' +
           'Zip=%s, ' +
           'City=%s, ' +
           'State=%s, ' +
           'Country=%s, ' +
           'TelLandLine=%s, ' +
           'TelMobile=%s, ' +
           'TelFax=%s, ' +
           'Email=%s, ' +
           'Website=%s, ' +
           'Skype=%s, ' +
           'Twitter=%s, ' +
           'LinkedIn=%s, ' +
           'FacebookLink=%s, ' +
           'TripadvisorAccount=%s, ' +
           'Information=%s, ' +
           'FamilyInfo=%s, ' +
           'CustomerCode=%s, ' +
           'CompanyName=%s, ' +
           'CompVATNumber=%s, ' +
           'CompAddress1=%s, ' +
           'CompAddress2=%s, ' +
           'CompZip=%s, ' +
           'CompCity=%s, ' +
           'CompState=%s, ' +
           'CompCountry=%s, ' +
           'CompTel=%s, ' +
           'CompFax=%s, ' +
           'CompEmail=%s ' +
           'WHERE ID=%s';
    sql := format(sql,
                  [
                  _db(FMaleFemale),
                  _db(FTitle),
                  _db(FFirstName),
                  _db(FLastname),
                  _db(FNationality),
                  _db(FDateOfBirth),
                  _db(FSocialSecurityNumber),
                  _db(FPassportNumber),
                  _db(FPassportExpiry),
                  _db(FSpouseName),
                  _db(FSpouseBirthdate),
                  _db(FCarLicensePlate),
                  _db(FContactPerson),
                  _db(FProfession),
                  _db(FRoom),
                  _db(FRoomType),
                  _db(FEmailSpecials),
                  _db(FEmailNews),
                  _db(FPreparation),
                  _db(FInvoiceAddress),
                  _db(FAddress1),
                  _db(FAddress2),
                  _db(FZip),
                  _db(FCity),
                  _db(FState),
                  _db(FCountry),
                  _db(FTelLandLine),
                  _db(FTelMobile),
                  _db(FTelFax),
                  _db(FEmail),
                  _db(FWebsite),
                  _db(FSkype),
                  _db(FTwitter),
                  _db(FLinkedIn),
                  _db(FFacebookLink),
                  _db(FTripadvisorAccount),
                  _db(FInformation),
                  _db(FFamilyInfo),
                  _db(FCustomerCode),
                  _db(FCompanyName),
                  _db(FCompVATNumber),
                  _db(FCompAddress1),
                  _db(FCompAddress2),
                  _db(FCompZip),
                  _db(FCompCity),
                  _db(FCompState),
                  _db(FCompCountry),
                  _db(FCompTel),
                  _db(FCompFax),
                  _db(FCompEmail),

                  _db(FID)
                  ]);
  end;

  if sql <> '' then
  begin
    ExecResult := d.roomerMainDataSet.DoCommand(sql);
    if FID = 0 then
      FID := ExecResult;
  end;

  if FNew then
    d.roomerMainDataSet.DoCommand(format('INSERT INTO customerdepartments_persons_links (CustomerDepartmentsId, PersonsId) ' +
                 'VALUES (%d, %d)', [CustomerDepartmentId, id]));

  FEdited := False;
  FNew := False;
end;

constructor TPerson.Create;
begin
  FCompVATNumber := '';
  FInformation := '';
  FCarLicensePlate := '';
  FCompCity := '';
  FFacebookLink := '';
  FEmail := '';
  FRoom := '';
  FLastname := '';
  FProfession := '';
  FTelLandLine := '';
  FPassportExpiry := 0;
  FFamilyInfo := '';
  FPreparation := '';
  FLinkedIn := '';
  FState := '';
  FZip := '';
  FEmailNews := False;
  FCompanyName := '';
  FDateOfBirth := 0;
  FTitle := '';
  FID := 0;
  FCompEmail := '';
  FAddress2 := '';
  FCompFax := '';
  FCustomerCode := '';
  FSkype := '';
  FTripadvisorAccount := '';
  FCountry := '';
  FAddress1 := '';
  FNationality := '';
  FCompState := '';
  FCompZip := '';
  FInvoiceAddress := '';
  FEmailSpecials := False;
  FWebsite := '';
  FTelFax := '';
  FTelMobile := '';
  FPassportNumber := '';
  FContactPerson := '';
  FCity := '';
  FSpouseBirthdate := 0;
  FTwitter := '';
  FSpouseName := '';
  FFirstName := '';
  FCompTel := '';
  FCompAddress2 := '';
  FRoomType := '';
  FSocialSecurityNumber := '';
  FCompCountry := '';
  FCompAddress1 := '';
  FMaleFemale := '';

  FEdited := False;
  FNew := False;
end;

procedure TPerson.SetAddress1(const Value: String);
begin
  FAddress1 := Value;
  FEdited := True;
end;

procedure TPerson.SetAddress2(const Value: String);
begin
  FAddress2 := Value;
  FEdited := True;
end;

procedure TPerson.SetCarLicensePlate(const Value: String);
begin
  FCarLicensePlate := Value;
  FEdited := True;
end;

procedure TPerson.SetCity(const Value: String);
begin
  FCity := Value;
  FEdited := True;
end;

procedure TPerson.SetCompAddress1(const Value: String);
begin
  FCompAddress1 := Value;
  FEdited := True;
end;

procedure TPerson.SetCompAddress2(const Value: String);
begin
  FCompAddress2 := Value;
  FEdited := True;
end;

procedure TPerson.SetCompanyName(const Value: String);
begin
  FCompanyName := Value;
  FEdited := True;
end;

procedure TPerson.SetCompCity(const Value: String);
begin
  FCompCity := Value;
  FEdited := True;
end;

procedure TPerson.SetCompCountry(const Value: String);
begin
  FCompCountry := Value;
  FEdited := True;
end;

procedure TPerson.SetCompEmail(const Value: String);
begin
  FCompEmail := Value;
  FEdited := True;
end;

procedure TPerson.SetCompFax(const Value: String);
begin
  FCompFax := Value;
  FEdited := True;
end;

procedure TPerson.SetCompState(const Value: String);
begin
  FCompState := Value;
  FEdited := True;
end;

procedure TPerson.SetCompTel(const Value: String);
begin
  FCompTel := Value;
  FEdited := True;
end;

procedure TPerson.SetCompVATNumber(const Value: String);
begin
  FCompVATNumber := Value;
  FEdited := True;
end;

procedure TPerson.SetCompZip(const Value: String);
begin
  FCompZip := Value;
  FEdited := True;
end;

procedure TPerson.SetContactPerson(const Value: String);
begin
  FContactPerson := Value;
  FEdited := True;
end;

procedure TPerson.SetCountry(const Value: String);
begin
  FCountry := Value;
  FEdited := True;
end;

procedure TPerson.SetCustomerCode(const Value: String);
begin
  FCustomerCode := Value;
  FEdited := True;
end;

procedure TPerson.SetDateOfBirth(const Value: TDate);
begin
  FDateOfBirth := Value;
  FEdited := True;
end;

procedure TPerson.SetEmail(const Value: String);
begin
  FEmail := Value;
  FEdited := True;
end;

procedure TPerson.SetEmailNews(const Value: Boolean);
begin
  FEmailNews := Value;
  FEdited := True;
end;

procedure TPerson.SetEmailSpecials(const Value: Boolean);
begin
  FEmailSpecials := Value;
  FEdited := True;
end;

procedure TPerson.SetFacebookLink(const Value: String);
begin
  FFacebookLink := Value;
  FEdited := True;
end;

procedure TPerson.SetFamilyInfo(const Value: String);
begin
  FFamilyInfo := Value;
  FEdited := True;
end;

procedure TPerson.SetFirstName(const Value: String);
begin
  FFirstName := Value;
  FEdited := True;
end;

procedure TPerson.SetInformation(const Value: String);
begin
  FInformation := Value;
  FEdited := True;
end;

procedure TPerson.SetInvoiceAddress(const Value: String);
begin
  FInvoiceAddress := Value;
  FEdited := True;
end;

procedure TPerson.SetLastname(const Value: String);
begin
  FLastname := Value;
  FEdited := True;
end;

procedure TPerson.SetLinkedIn(const Value: String);
begin
  FLinkedIn := Value;
  FEdited := True;
end;

procedure TPerson.SetMaleFemale(const Value: String);
begin
  FMaleFemale := Value;
  FEdited := True;
end;

procedure TPerson.SetNationality(const Value: String);
begin
  FNationality := Value;
  FEdited := True;
end;

procedure TPerson.SetPassportExpiry(const Value: TDate);
begin
  FPassportExpiry := Value;
  FEdited := True;
end;

procedure TPerson.SetPassportNumber(const Value: String);
begin
  FPassportNumber := Value;
  FEdited := True;
end;

procedure TPerson.SetPreparation(const Value: String);
begin
  FPreparation := Value;
  FEdited := True;
end;

procedure TPerson.SetProfession(const Value: String);
begin
  FProfession := Value;
  FEdited := True;
end;

procedure TPerson.SetRoom(const Value: String);
begin
  FRoom := Value;
  FEdited := True;
end;

procedure TPerson.SetRoomType(const Value: String);
begin
  FRoomType := Value;
  FEdited := True;
end;

procedure TPerson.SetSkype(const Value: String);
begin
  FSkype := Value;
  FEdited := True;
end;

procedure TPerson.SetSocialSecurityNumber(const Value: String);
begin
  FSocialSecurityNumber := Value;
  FEdited := True;
end;

procedure TPerson.SetSpouseBirthdate(const Value: TDate);
begin
  FSpouseBirthdate := Value;
  FEdited := True;
end;

procedure TPerson.SetSpouseName(const Value: String);
begin
  FSpouseName := Value;
  FEdited := True;
end;

procedure TPerson.SetState(const Value: String);
begin
  FState := Value;
  FEdited := True;
end;

procedure TPerson.SetTelFax(const Value: String);
begin
  FTelFax := Value;
  FEdited := True;
end;

procedure TPerson.SetTelLandLine(const Value: String);
begin
  FTelLandLine := Value;
  FEdited := True;
end;

procedure TPerson.SetTelMobile(const Value: String);
begin
  FTelMobile := Value;
  FEdited := True;
end;

procedure TPerson.SetTitle(const Value: String);
begin
  FTitle := Value;
  FEdited := True;
end;

procedure TPerson.SetTripadvisorAccount(const Value: String);
begin
  FTripadvisorAccount := Value;
  FEdited := True;
end;

procedure TPerson.SetTwitter(const Value: String);
begin
  FTwitter := Value;
  FEdited := True;
end;

procedure TPerson.SetWebsite(const Value: String);
begin
  FWebsite := Value;
  FEdited := True;
end;

procedure TPerson.SetZip(const Value: String);
begin
  FZip := Value;
  FEdited := True;
end;

end.
