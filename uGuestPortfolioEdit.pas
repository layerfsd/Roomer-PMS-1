unit uGuestPortfolioEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, uDImages,
  cmpRoomerDataset, ShellAPI, IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, sMaskEdit, sCustomComboEdit, sToolEdit, Vcl.StdCtrls, sComboBox,
  sGroupBox, Vcl.Buttons, sSpeedButton, sEdit, sLabel, Vcl.ComCtrls, sPageControl, sButton, Vcl.ExtCtrls, sPanel,
  sCheckBox, sMemo, sListView, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv,
  dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers, dxSkinsdxBarPainter, dxSkinsdxRibbonPainter, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, dxPSCore,
  dxPScxCommon, dxmdaset, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinDarkRoom,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxPScxPivotGridLnk;

type
  TfrmGuestPortfolio = class(TForm)
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    pgPages: TsPageControl;
    sTabSheet1: TsTabSheet;
    sGroupBox1: TsGroupBox;
    clabInitials: TsLabel;
    sLabel2: TsLabel;
    sLabel1: TsLabel;
    sLabel3: TsLabel;
    sLabel11: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton8: TsSpeedButton;
    cmbGender: TsComboBox;
    edtTitle: TsEdit;
    edtFirstname: TsEdit;
    edtLastname: TsEdit;
    edtProfession: TsEdit;
    edtNationality: TsEdit;
    edtBirthday: TsDateEdit;
    edtPassport: TsEdit;
    edtPassportExpiry: TsDateEdit;
    sGroupBox2: TsGroupBox;
    sLabel8: TsLabel;
    sLabel9: TsLabel;
    edtSpousename: TsEdit;
    edtSpouseBirthdate: TsDateEdit;
    sGroupBox3: TsGroupBox;
    sLabel12: TsLabel;
    sLabel10: TsLabel;
    edtContactname: TsEdit;
    edtLicensePlate: TsEdit;
    sTabSheet7: TsTabSheet;
    sGroupBox4: TsGroupBox;
    sLabel19: TsLabel;
    sLabel21: TsLabel;
    edtEmail: TsEdit;
    edtWebsite: TsEdit;
    sTabSheet2: TsTabSheet;
    sTabSheet4: TsTabSheet;
    tabHistory: TsTabSheet;
    tabInvoices: TsTabSheet;
    sGroupBox5: TsGroupBox;
    sLabel18: TsLabel;
    sLabel20: TsLabel;
    sLabel24: TsLabel;
    sLabel26: TsLabel;
    sLabel27: TsLabel;
    sSpeedButton9: TsSpeedButton;
    sSpeedButton10: TsSpeedButton;
    edtAddress1: TsEdit;
    edtAddress2: TsEdit;
    edtZip: TsEdit;
    edtCity: TsEdit;
    edtState: TsEdit;
    edtCountry: TsEdit;
    sLabel22: TsLabel;
    edtSkype: TsEdit;
    sGroupBox6: TsGroupBox;
    sLabel23: TsLabel;
    sLabel25: TsLabel;
    sLabel28: TsLabel;
    edtLandline: TsEdit;
    edtMobile: TsEdit;
    edtFax: TsEdit;
    sLabel29: TsLabel;
    edtTwitter: TsEdit;
    edtLinkedIn: TsEdit;
    sLabel30: TsLabel;
    btnEmail: TsButton;
    btnWebsite: TsButton;
    sGroupBox7: TsGroupBox;
    sLabel14: TsLabel;
    sLabel15: TsLabel;
    sLabel16: TsLabel;
    edtCustomer: TsEdit;
    edtCompName: TsEdit;
    edtCompAddress1: TsEdit;
    edtCompAddress2: TsEdit;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    edtCompZip: TsEdit;
    edtCompCity: TsEdit;
    edtCompState: TsEdit;
    sLabel13: TsLabel;
    sLabel17: TsLabel;
    sLabel31: TsLabel;
    sLabel32: TsLabel;
    edtCompCountry: TsEdit;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sGroupBox8: TsGroupBox;
    sLabel33: TsLabel;
    sLabel34: TsLabel;
    edtCompTel: TsEdit;
    edtCompEmail: TsEdit;
    btnEmailComp: TsButton;
    sGroupBox11: TsGroupBox;
    sLabel35: TsLabel;
    sLabel36: TsLabel;
    sLabel37: TsLabel;
    sSpeedButton6: TsSpeedButton;
    sSpeedButton7: TsSpeedButton;
    sSpeedButton11: TsSpeedButton;
    sSpeedButton12: TsSpeedButton;
    edtRoom: TsEdit;
    edtRoomType: TsEdit;
    edtInvoiceAddress: TsComboBox;
    cbxEmailSpecials: TsCheckBox;
    cbxEmailNews: TsCheckBox;
    edtPreparationNotes: TsMemo;
    sLabel38: TsLabel;
    btnBack: TsButton;
    btnForward: TsButton;
    grData: TcxGrid;
    tvData: TcxGridDBTableView;
    lvData: TcxGridLevel;
    history_: TdxMemData;
    DS_history: TDataSource;
    grPrinter: TdxComponentPrinter;
    prLink_grData: TdxGridReportLink;
    history_Reservation: TIntegerField;
    history_RoomReservation: TIntegerField;
    history_Nights: TIntegerField;
    history_ResStatus: TWideStringField;
    history_Arrival: TDateField;
    history_Departure: TDateField;
    history_Room: TWideStringField;
    history_RoomType: TWideStringField;
    history_AvgRate: TFloatField;
    history_TotalStay: TFloatField;
    history_TotalInvoice: TFloatField;
    tvDataRecId: TcxGridDBColumn;
    tvDataNights: TcxGridDBColumn;
    tvDataResStatus: TcxGridDBColumn;
    tvDataArrival: TcxGridDBColumn;
    tvDataDeparture: TcxGridDBColumn;
    tvDataRoom: TcxGridDBColumn;
    tvDataRoomType: TcxGridDBColumn;
    tvDataAvgRate: TcxGridDBColumn;
    tvDataTotalStay: TcxGridDBColumn;
    tvDataTotalInvoice: TcxGridDBColumn;
    sPanel1: TsPanel;
    sButton1: TsButton;
    LMDSpeedButton6: TsButton;
    btnLinkedIn: TsButton;
    btnTwitter: TsButton;
    btnSkype: TsButton;
    invoices_: TdxMemData;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    DS_invoices: TDataSource;
    grInvoices: TcxGrid;
    tvInvoices: TcxGridDBTableView;
    lvInvoices: TcxGridLevel;
    invoices_invoiceDate: TDateField;
    invoices_InvoiceNumber: TIntegerField;
    invoices_TotalItems: TFloatField;
    tvInvoicesRecId: TcxGridDBColumn;
    tvInvoicesinvoiceDate: TcxGridDBColumn;
    tvInvoicesInvoiceNumber: TcxGridDBColumn;
    tvInvoicesTotalStay: TcxGridDBColumn;
    tvInvoicesTotalItems: TcxGridDBColumn;
    tvInvoicesTotalInvoice: TcxGridDBColumn;
    sPanel2: TsPanel;
    sButton2: TsButton;
    sButton3: TsButton;
    sLabel39: TsLabel;
    edtGuestNotes: TsMemo;
    btnTabForward: TsButton;
    btnTabBack: TsButton;
    sLabel40: TsLabel;
    edtSSN: TsEdit;
    sLabel41: TsLabel;
    edtFaceBook: TsEdit;
    edtTripadvisor: TsEdit;
    sLabel42: TsLabel;
    sLabel43: TsLabel;
    edtCompFax: TsEdit;
    sLabel44: TsLabel;
    edtVAT: TsEdit;
    pnlChecksPerson: TsPanel;
    xcmbGender: TsCheckBox;
    xedtTitle: TsCheckBox;
    xedtLastname: TsCheckBox;
    xedtFirstName: TsCheckBox;
    xedtBirthDay: TsCheckBox;
    xedtNationality: TsCheckBox;
    xedtProfession: TsCheckBox;
    xedtSSN: TsCheckBox;
    xedtPassportExpiry: TsCheckBox;
    xedtPassport: TsCheckBox;
    xedtSpousename: TsCheckBox;
    xedtSpouseBirthdate: TsCheckBox;
    xedtContactName: TsCheckBox;
    xedtLicensePlate: TsCheckBox;
    pnlChecksContact: TsPanel;
    xedtAddress1: TsCheckBox;
    xedtAddress2: TsCheckBox;
    xedtCity: TsCheckBox;
    xedtZip: TsCheckBox;
    xedtMobile: TsCheckBox;
    xedtLandline: TsCheckBox;
    xedtCountry: TsCheckBox;
    xedtState: TsCheckBox;
    xedtEmail: TsCheckBox;
    xedtFax: TsCheckBox;
    xedtWebsite: TsCheckBox;
    xedtSkype: TsCheckBox;
    xedtFaceBook: TsCheckBox;
    xedtTripadvisor: TsCheckBox;
    xedtLinkedIn: TsCheckBox;
    xedtTwitter: TsCheckBox;
    pnlChecksCompany: TsPanel;
    xedtCustomer: TsCheckBox;
    xedtVAT: TsCheckBox;
    xedtCompAddress1: TsCheckBox;
    xedtCompName: TsCheckBox;
    xedtCompState: TsCheckBox;
    xedtCompCity: TsCheckBox;
    xedtCompZip: TsCheckBox;
    xedtCompAddress2: TsCheckBox;
    xedtCompCountry: TsCheckBox;
    xedtCompTel: TsCheckBox;
    xedtCompFax: TsCheckBox;
    xedtCompEmail: TsCheckBox;
    pnlChecksPreferences: TsPanel;
    xedtRoom: TsCheckBox;
    xedtRoomType: TsCheckBox;
    xcbxEmailSpecials: TsCheckBox;
    xedtInvoiceAddress: TsCheckBox;
    xedtPreparationNotes: TsCheckBox;
    xcbxEmailNews: TsCheckBox;
    xedtGuestNotes: TsCheckBox;
    pnlHolder: TsPanel;
    procedure FormCreate(Sender: TObject);
    procedure cmbGenderChange(Sender: TObject);
    procedure edtBirthdayChange(Sender: TObject);
    procedure cbxEmailSpecialsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton9Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton10Click(Sender: TObject);
    procedure sSpeedButton8Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
    procedure sSpeedButton11Click(Sender: TObject);
    procedure sSpeedButton7Click(Sender: TObject);
    procedure sSpeedButton12Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure pgPagesChange(Sender: TObject);
    procedure LMDSpeedButton6Click(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure tvInvoicesCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure btnTabBackClick(Sender: TObject);
    procedure btnTabForwardClick(Sender: TObject);
    procedure xcmbGenderClick(Sender: TObject);
  private
    procedure DisplayCurrent;
    procedure MarkAllSelected;
    procedure MarkNoneSelected;
    { Private declarations }
  public
    { Public declarations }
    Dataset : TRoomerDataset;
    DataChanged : Boolean;
    ShowBackForthButtons : Boolean;
    Merging : Boolean;
    GuestId : Integer;
    procedure PostCurrentIfNeeded(forced : Boolean = False);
    procedure AccumulateChanges;
    procedure PrepareMerge(Main : Boolean);
  end;

var
  frmGuestPortfolio: TfrmGuestPortfolio;

function OpenGuestPortfolioEdit(rSet : TRoomerDataset; GuestId : Integer = -1; AllowNavigation : Boolean = True) : Boolean;
function CreateNewGuest(rSet : TRoomerDataset; FromPerson : Integer = -1; FromCustomer : String = '') : Integer;
function PrepareMerge(rSet : TRoomerDataset; Main : Boolean; GuestId : Integer = -1) : TfrmGuestPortfolio;
procedure RemoveMerge(PortfolioEdit : TfrmGuestPortfolio);

implementation

{$R *.dfm}

uses uRoomerLanguage,
     PrjConst
     , uUtils,
     hData,
     uAppGlobal,
     uD,
     uG,
     uCountries,
     uRooms3,
     uRoomTypes2,
     uCustomers2,
     _Glob,
     uFileSystemUtils,
     cxGridExportLink,
     uFinishedInvoices2,
     uReservationProfile;


function CreateNewGuest(rSet : TRoomerDataset; FromPerson : Integer = -1; FromCustomer : String = '') : Integer;
var res : Integer;
    s : String;
begin
  if FromPerson = -1 then
  begin
    if FromCustomer='' then
      res := rSet.DoCommand('INSERT INTO personprofiles VALUES()')
    else begin
      s := 'INSERT INTO personprofiles ' +
           '( ' +
           'title, ' +
           'FirstName, ' +
           'LastName, ' +
           'Address1, ' +
           'Address2, ' +
           'Zip, ' +
           'City, ' +
           'Country, ' +
           'TelLandLine, ' +
           'TelMobile, ' +
           'TelFax, ' +
           'Email, ' +
           'Information, ' +
           'Nationality, ' +
           'CustomerCode, ' +
           'CompanyName, ' +
           'CompAddress1, ' +
           'CompAddress2, ' +
           'CompZip, ' +
           'CompCity, ' +
           'CompCountry, ' +
           'CompTel, ' +
           'CompEmail, ' +
           'state ' +
           ') ' +
           'SELECT ' +
           ''''', ' + // title
           'LEFT(Surname, CHAR_LENGTH(Surname) - CHAR_LENGTH(SUBSTRING_INDEX(Surname,'' '',-1))-1), ' +
           'SUBSTRING_INDEX(Surname,'' '',-1), ' +
           'Address1, ' +
           'Address2, ' +
           'Address3, ' +
           'Address4, ' +
           'Country, ' +
           'Tel1, ' +
           'Tel2, ' +
           'Fax, ' +
           'EmailAddress, ' +
           'Notes, ' +
           'Country, ' +
           'Customer, ' +
           'Surname, ' +
           'Address1, ' +
           'Address2, ' +
           'Address3, ' +
           'Address4, ' +
           'Country, ' +
           'Tel1, ' +
           'EmailAddress, ' +
           ''''' ' + // state
           'FROM customers ' +
           'WHERE Customer=''%s''';
      res := rSet.DoCommand(format(s, [FromCustomer]));
    end;
  end else
  begin
    s := 'INSERT INTO personprofiles ' +
         '( ' +
         'title, ' +
         'FirstName, ' +
         'LastName, ' +
         'Address1, ' +
         'Address2, ' +
         'Zip, ' +
         'City, ' +
         'Country, ' +
         'TelLandLine, ' +
         'TelMobile, ' +
         'TelFax, ' +
         'Email, ' +
         'Information, ' +
         'Nationality, ' +
         'CustomerCode, ' +
         'CompanyName, ' +
         'CompAddress1, ' +
         'CompAddress2, ' +
         'CompZip, ' +
         'CompCity, ' +
         'CompCountry, ' +
         'CompTel, ' +
         'CompEmail, ' +
         'state, ' +
         'DateOfBirth ' +
         ') ' +
         'SELECT ' +
         'title, ' +
         'LEFT(Name, CHAR_LENGTH(Name) - CHAR_LENGTH(SUBSTRING_INDEX(Name,'' '',-1))-1), ' +
         'SUBSTRING_INDEX(Name,'' '',-1), ' +
         'Address1, ' +
         'Address2, ' +
         'Address3, ' +
         'Address4, ' +
         'Country, ' +
         'Tel1, ' +
         'Tel2, ' +
         'Fax, ' +
         'Email, ' +
         'Information, ' +
         'Nationality, ' +
         'Customer, ' +
         'Surname, ' +
         'CompAddress1, ' +
         'CompAddress2, ' +
         'CompZip, ' +
         'CompCity, ' +
         'CompCountry, ' +
         'CompTel, ' +
         'CompEmail, ' +
         'state, ' +
         'DateOfBirth ' +
         'FROM persons ' +
         'WHERE Person=%d';
    res := rSet.DoCommand(format(s, [FromPerson]));
  end;
  if res < 1 then
    raise Exception.Create('Unable to create Guest.');
  hData.rSet_bySQL(rSet, 'SELECT * FROM personprofiles');
  result := res;
  if NOT OpenGuestPortfolioEdit(rSet, res) then
  begin
    rSet.DoCommand('DELETE FROM personprofiles WHERE Id=' + inttostr(res));
    result := -1;
  end;
end;

function OpenGuestPortfolioEdit(rSet : TRoomerDataset; GuestId : Integer = -1; AllowNavigation : Boolean = True) : Boolean;
var _frmGuestPortfolio : TfrmGuestPortfolio;
begin
  _frmGuestPortfolio := TfrmGuestPortfolio.Create(nil);
  try
    if GuestId > -1 then
      glb.locateId(rSet, GuestId);
    _frmGuestPortfolio.GuestId := GuestId;
    _frmGuestPortfolio.Dataset := rSet;
    _frmGuestPortfolio.ShowBackForthButtons := AllowNavigation;
    result := _frmGuestPortfolio.ShowModal = mrOk;
  finally
    FreeAndNil(_frmGuestPortfolio);
  end;
end;

function PrepareMerge(rSet : TRoomerDataset; Main : Boolean; GuestId : Integer = -1) : TfrmGuestPortfolio;
begin
  result := TfrmGuestPortfolio.Create(nil);

  if GuestId > -1 then
    glb.locateId(rSet, GuestId);
  result.GuestId := GuestId;
  result.Dataset := rSet;
  result.ShowBackForthButtons := False;
  result.PrepareMerge(Main);
end;

procedure RemoveMerge(PortfolioEdit : TfrmGuestPortfolio);
begin
  FreeAndNil(PortfolioEdit);
end;

procedure TfrmGuestPortfolio.cmbGenderChange(Sender: TObject);
begin
  DataChanged := True;
  if Sender IS TsEdit then
    case (Sender AS TsEdit).Tag of
      11 : btnEmail.Enabled := TRIM((Sender AS TsEdit).Text) <> '';
      12 : btnWebsite.Enabled := TRIM((Sender AS TsEdit).Text) <> '';
      13 : btnSkype.Enabled := TRIM((Sender AS TsEdit).Text) <> '';
      14 : btnTwitter.Enabled := TRIM((Sender AS TsEdit).Text) <> '';
      15 : btnLinkedIn.Enabled := TRIM((Sender AS TsEdit).Text) <> '';
    end;
end;

procedure TfrmGuestPortfolio.DisplayCurrent;
begin
  if (NOT dataset.Eof) then // AND (NOT dataset.Bof) then
  begin
    history_.Close;

    // Persona
    if dataset['MaleFemale'] = 'MALE' then
      cmbGender.ItemIndex := 0
    else
      cmbGender.ItemIndex := 1;
    edtTitle.Text := dataset['Title'];
    edtFirstname.Text := dataset['FirstName'];
    edtLastname.Text := dataset['LastName'];
    edtProfession.Text := dataset['Profession'];
    edtSSN.Text := dataset['SocialSecurityNumber'];
    edtNationality.Text := dataset['Nationality'];
    edtBirthday.Date := dataset['DateOfBirth'];
    edtPassport.Text := dataset['PassportNumber'];
    edtPassportExpiry.Date := dataset['PassportExpiry'];

    // Spouse
    edtSpousename.Text := dataset['SpouseName'];
    edtSpouseBirthdate.Date := dataset['SpouseBirthdate'];

    // Extra
    edtContactname.Text := dataset['ContactPerson'];
    edtLicensePlate.Text := dataset['CarLicensePlate'];


  // Contact
    // Home address
    edtAddress1.Text := dataset['Address1'];
    edtAddress2.Text := dataset['Address2'];
    edtZip.Text := dataset['Zip'];
    edtCity.Text := dataset['City'];
    edtState.Text := dataset['State'];
    edtCountry.Text := dataset['Country'];

    // Telephones
    edtLandline.Text := dataset['TelLandline'];
    edtMobile.Text := dataset['TelMobile'];
    edtFax.Text := dataset['TelFax'];

    // Internet
    edtEmail.Text := dataset['Email'];
    edtWebsite.Text := dataset['Website'];
    edtSkype.Text := dataset['Skype'];
    edtTwitter.Text := dataset['Twitter'];
    edtLinkedIn.Text := dataset['LinkedIn'];
    edtFaceBook.Text := dataset['FacebookLink'];
    edtTripadvisor.Text := dataset['TripadvisorAccount'];

  // Company
    // Company info
    edtCustomer.Text := dataset['CustomerCode'];
    edtCompName.Text := dataset['CompanyName'];
    edtVAT.Text := dataset['CompVATNumber'];
    edtCompAddress1.Text := dataset['CompAddress1'];
    edtCompAddress2.Text := dataset['CompAddress2'];
    edtCompZip.Text := dataset['CompZip'];
    edtCompCity.Text := dataset['CompCity'];
    edtCompState.Text := dataset['CompState'];
    edtCompCountry.Text := dataset['CompCountry'];

    // Telephones
    edtCompTel.Text := dataset['CompTel'];
    edtCompFax.Text := dataset['CompFax'];
    edtCompEmail.Text := dataset['CompEmail'];

  // Notes
    // Guest notes
    edtGuestNotes.Text := dataset['Information'];

    // Family info
//    edtFamilyNotes.Text := dataset['FamilyInfo'];

  // Preferences
    // Guest preferences
    edtRoom.Text := dataset['Room'];
    edtRoomType.Text := dataset['RoomType'];
    if dataset['InvoiceAddress'] = 'HOME_ADDRESS' then
      edtInvoiceAddress.ItemIndex := 0
    else
      edtInvoiceAddress.ItemIndex := 1;
    edtPreparationNotes.Text := dataset['Preparation'];
    cbxEmailSpecials.Checked := dataset['EmailSpecials'];
    cbxEmailNews.Checked := dataset['EmailNews'];

    pgPagesChange(pgPages);
  end;

  DataChanged := False;
end;

procedure TfrmGuestPortfolio.AccumulateChanges;
var s : String;
    id : Integer;
begin
  s := 'UPDATE persons pe, ' +
       'personprofiles pp ' +
       'SET pe.title = pp.title, ' +
       'pe.Name = TRIM(CONCAT(pp.FirstName, '' '', pp.LastName)), ' +
       'pe.SocialSecurityNumber = pp.SocialSecurityNumber, ' +
       'pe.Address1 = pp.Address1, ' +
       'pe.Address2 = pp.Address2, ' +
       'pe.Address3 = pp.Zip, ' +
       'pe.Address4 = pp.City, ' +
       'pe.Country = pp.Country, ' +
       'pe.Tel1 = pp.TelLandLine, ' +
       'pe.Tel2 = pp.TelMobile, ' +
       'pe.Fax = pp.TelFax, ' +
       'pe.Email = pp.Email, ' +
       'pe.Information = pp.Information, ' +
       'pe.Nationality = pp.Nationality, ' +
       'pe.Customer = IF(ISNULL(pp.CustomerCode) OR pp.CustomerCode='''', pe.Customer, pp.CustomerCode), ' +
       'pe.Surname = IF(ISNULL(pp.CompanyName) OR pp.CompanyName='''', pe.Surname, pp.CompanyName), ' +
       'pe.CompanyName = IF(ISNULL(pp.CompanyName) OR pp.CompanyName='''', pe.Surname, pp.CompanyName), ' +
       'pe.CompAddress1 = pp.CompAddress1, ' +
       'pe.CompAddress2 = pp.CompAddress2, ' +
       'pe.CompZip = pp.CompZip, ' +
       'pe.CompCity = pp.CompCity, ' +
       'pe.CompCountry = pp.CompCountry, ' +
       'pe.CompTel = pp.CompTel, ' +
       'pe.CompEmail = pp.CompEmail, ' +
       'pe.CompVATNumber = pp.CompVATNumber, ' +
       'pe.CompFax = pp.CompFax, ' +
       'pe.state = pp.state, ' +
       'pe.DateOfBirth = pp.DateOfBirth ' +
       'WHERE pp.Id=%d ' +
       'AND pe.PersonsProfilesId=pp.Id ' +
       'AND (SELECT ADate FROM roomsdate WHERE RoomReservation=pe.RoomReservation ORDER BY ADate LIMIT 1) >= CURRENT_DATE';
  id := GuestId;
  s := format(s, [id]);
  d.roomerMainDataSet.DoCommand(s);
end;

procedure TfrmGuestPortfolio.PostCurrentIfNeeded(forced : Boolean = False);
begin
  if (Not DataChanged) AND (NOT forced) then exit;

  if GuestId > -1 then
    glb.locateId(dataset, GuestId);
  dataset.Edit;

  // Persona
  if cmbGender.ItemIndex = 0 then
    dataset['MaleFemale'] := 'MALE'
  else
    dataset['MaleFemale'] := 'FEMALE';

  dataset['Title'] := edtTitle.Text;
  dataset['FirstName'] := edtFirstname.Text;
  dataset['SocialSecurityNumber'] := edtSSN.Text;
  dataset['LastName'] := edtLastname.Text;
  dataset['Profession'] := edtProfession.Text;
  dataset['Nationality'] := edtNationality.Text;
  dataset['DateOfBirth'] := edtBirthday.Date;
  dataset['PassportNumber'] := edtPassport.Text;
  dataset['PassportExpiry'] := edtPassportExpiry.Date;

  // Spouse
  dataset['SpouseName'] := edtSpousename.Text;
  dataset['SpouseBirthdate'] := edtSpouseBirthdate.Date;

  // Extra
  dataset['ContactPerson'] := edtContactname.Text;
  dataset['CarLicensePlate'] := edtLicensePlate.Text;


// Contact
  // Home address
  dataset['Address1'] := edtAddress1.Text;
  dataset['Address2'] := edtAddress2.Text;
  dataset['Zip'] := edtZip.Text;
  dataset['City'] := edtCity.Text;
  dataset['State'] := edtState.Text;
  dataset['Country'] := edtCountry.Text;

  // Telephones
  dataset['TelLandline'] := edtLandline.Text;
  dataset['TelMobile'] := edtMobile.Text;
  dataset['TelFax'] := edtFax.Text;

  // Internet
  dataset['Email'] := edtEmail.Text;
  dataset['Website'] := edtWebsite.Text;
  dataset['Skype'] := edtSkype.Text;
  dataset['Twitter'] := edtTwitter.Text;
  dataset['LinkedIn'] := edtLinkedIn.Text;
  dataset['FacebookLink'] := edtFaceBook.Text;
  dataset['TripadvisorAccount'] := edtTripadvisor.Text;

// Company
  // Company info
  dataset['CustomerCode'] := edtCustomer.Text;
  dataset['CompanyName'] := edtCompName.Text;
  dataset['CompVATNumber'] := edtVAT.Text;;
  dataset['CompAddress1'] := edtCompAddress1.Text;
  dataset['CompAddress2'] := edtCompAddress2.Text;
  dataset['CompZip'] := edtCompZip.Text;
  dataset['CompCity'] := edtCompCity.Text;
  dataset['CompState'] := edtCompState.Text;
  dataset['CompCountry'] := edtCompCountry.Text;

  // Telephones
  dataset['CompTel'] := edtCompTel.Text;
  dataset['CompFax'] := edtCompFax.Text;
  dataset['CompEmail'] := edtCompEmail.Text;

// Notes
  // Guest notes
  dataset['Information'] := edtGuestNotes.Text;

  // Family info
//  dataset['FamilyInfo'] := edtFamilyNotes.Text;

// Preferences
  // Guest preferences
  dataset['Room'] := edtRoom.Text;
  dataset['RoomType'] := edtRoomType.Text;
  if edtInvoiceAddress.ItemIndex = 0 then
    dataset['InvoiceAddress'] := 'HOME_ADDRESS'
  else
    dataset['InvoiceAddress'] := 'WORK_ADDRESS';
  dataset['Preparation'] := edtPreparationNotes.Text;
  dataset['EmailSpecials'] := cbxEmailSpecials.Checked;
  dataset['EmailNews'] := cbxEmailNews.Checked;

  dataset.Post;

  AccumulateChanges;
end;

procedure TfrmGuestPortfolio.sButton1Click(Sender: TObject);
begin
  grPrinter.CurrentLink.Component := grData;
  grPrinter.PrintTitle := 'Hitorical Bookings - ' + trim(dataset['firstname'] + ' ' + dataset['lastname']);
  prLink_grData.ReportTitle.Text := grPrinter.PrintTitle;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmGuestPortfolio.sButton2Click(Sender: TObject);
begin
  grPrinter.CurrentLink.Component := grInvoices;
  grPrinter.PrintTitle := 'List of invoices - ' + trim(dataset['firstname'] + ' ' + dataset['lastname']);
  prLink_grData.ReportTitle.Text := grPrinter.PrintTitle;
  grPrinter.Preview(true, prLink_grData);
end;

procedure TfrmGuestPortfolio.sButton3Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := TPath.Combine(GetTempDir, '_Roomer_XSLView');
  ExportGridToExcel(sFilename, grInvoices, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmGuestPortfolio.MarkAllSelected;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] IS TsCheckBox then
      if Copy(TsCheckBox(Components[i]).Name, 1, 1) = 'x' then
      begin
        TsCheckBox(Components[i]).Checked := True;
        xcmbGenderClick(Components[i]);
      end;
end;

procedure TfrmGuestPortfolio.MarkNoneSelected;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] IS TsCheckBox then
      if Copy(TsCheckBox(Components[i]).Name, 1, 1) = 'x' then
      begin
        TsCheckBox(Components[i]).Checked := False;
        xcmbGenderClick(Components[i]);
      end;
end;

procedure TfrmGuestPortfolio.xcmbGenderClick(Sender: TObject);
var objName : String;
    obj : TObject;
    cbx : TSCheckBox;
begin
  cbx := TSCheckBox(Sender);
  objName := Copy(cbx.Name, 2, maxInt);
  obj := FindComponent(objName);
  if obj IS TsEdit then
  begin
    with TsEdit(obj) do
    begin
      SkinData.ColorTone := clNone;
      if cbx.Checked then
        SkinData.ColorTone := $00C6E2FF;
    end;
  end else
  if obj IS TsDateEdit then
  begin
    with TsDateEdit(obj) do
    begin
      SkinData.ColorTone := clNone;
      if cbx.Checked then
        SkinData.ColorTone := $00C6E2FF;
    end;
  end else
  if obj IS TsComboBox then
  begin
    with TsComboBox(obj) do
    begin
      SkinData.ColorTone := clNone;
      if cbx.Checked then
        SkinData.ColorTone := $00C6E2FF;
    end;
  end else
  if obj IS TsCheckBox then
  begin
    with TsCheckBox(obj) do
    begin
      SkinData.ColorTone := clNone;
      if cbx.Checked then
        SkinData.ColorTone := $00C6E2FF;
    end;
  end;
  if obj IS TsMemo then
  begin
    with TsMemo(obj) do
    begin
      SkinData.ColorTone := clNone;
      if cbx.Checked then
        SkinData.ColorTone := $00C6E2FF;
    end;
  end;

end;

procedure TfrmGuestPortfolio.btnTabForwardClick(Sender: TObject);
begin
  if pgPages.ActivePageIndex < pgPages.PageCount - 1 then
    pgPages.ActivePageIndex := pgPages.ActivePageIndex + 1;
  TsButton(Sender).Enabled := pgPages.ActivePageIndex < pgPages.PageCount - 1;
end;

procedure TfrmGuestPortfolio.btnTabBackClick(Sender: TObject);
begin
  if pgPages.ActivePageIndex > 0 then
    pgPages.ActivePageIndex := pgPages.ActivePageIndex - 1;
  TsButton(Sender).Enabled := pgPages.ActivePageIndex > 0;
end;

procedure TfrmGuestPortfolio.sSpeedButton10Click(Sender: TObject);
begin
  edtCountry.Text := ctrlGetString('Country');
end;

procedure TfrmGuestPortfolio.sSpeedButton11Click(Sender: TObject);
var
  theData : recRoomTypeHolder;
begin
  theData.RoomType := edtRoomType.Text;
  if openRoomTypes(actLookup,theData) then
  begin
    edtRoomType.text := theData.RoomType;
//    lbContactCountryName.caption := theData.CountryName;
  end;
end;

procedure TfrmGuestPortfolio.sSpeedButton12Click(Sender: TObject);
begin
  edtRoomType.text := '';
end;

procedure TfrmGuestPortfolio.sSpeedButton1Click(Sender: TObject);
var
  theData : recCountryHolder;
begin
  theData.Country := edtCompCountry.Text;
  if Countries(actLookup,theData) then
  begin
    edtCompCountry.text := theData.Country;
//    lbContactCountryName.caption := theData.CountryName;
  end;
end;

procedure TfrmGuestPortfolio.sSpeedButton2Click(Sender: TObject);
var
  theData : recCountryHolder;
begin
  theData.Country := edtNationality.Text;
  if Countries(actLookup,theData) then
  begin
    edtNationality.text := theData.Country;
//    lbContactCountryName.caption := theData.CountryName;
  end;
end;

procedure TfrmGuestPortfolio.sSpeedButton3Click(Sender: TObject);
begin
  edtCompCountry.Text := ctrlGetString('Country');
end;

procedure TfrmGuestPortfolio.sSpeedButton4Click(Sender: TObject);
var
  theData : recCustomerHolder;
begin
  theData.Customer := edtCustomer.Text;
  if openCustomers(actLookup,true, theData) then
  begin
    edtCustomer.text := theData.Customer;
    edtCompName.text := theData.Surname;
    edtCompAddress1.text := theData.Address1;
    edtCompAddress2.text := theData.Address2;
    edtCompZip.text := theData.Address3;
    edtCompCity.text := theData.Address4;
    edtCompCountry.text := theData.Country;

    edtCompTel.text := theData.Tel1;
    edtCompEmail.text := theData.EmailAddress;
  end;
end;

procedure TfrmGuestPortfolio.sSpeedButton5Click(Sender: TObject);
begin
  edtCustomer.text := ctrlGetString('RackCustomer');
end;

procedure TfrmGuestPortfolio.sSpeedButton6Click(Sender: TObject);
var
  theData : recRoomHolder;
begin
  theData.Room := edtRoom.Text;
  if openRooms(actLookup,theData) then
  begin
    edtRoom.text := theData.Room;
//    lbContactCountryName.caption := theData.CountryName;
  end;
end;

procedure TfrmGuestPortfolio.sSpeedButton7Click(Sender: TObject);
begin
  edtRoom.text := '';
end;

procedure TfrmGuestPortfolio.sSpeedButton8Click(Sender: TObject);
begin
  edtNationality.Text := ctrlGetString('Country');
end;

procedure TfrmGuestPortfolio.sSpeedButton9Click(Sender: TObject);
var
  theData : recCountryHolder;
begin
  theData.Country := edtCountry.Text;
  if Countries(actLookup,theData) then
  begin
    edtCountry.text := theData.Country;
//    lbContactCountryName.caption := theData.CountryName;
  end;
end;

procedure TfrmGuestPortfolio.tvDataCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if EditReservation(History_['Reservation'], History_['RoomReservation']) then
  begin
  end;
end;

procedure TfrmGuestPortfolio.tvInvoicesCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  InvoiceNumber : integer;
begin
  InvoiceNumber := Invoices_.fieldbyname('InvoiceNumber').AsInteger;
  ViewInvoice2(InvoiceNumber, false, false, false, false, '');
end;

procedure TfrmGuestPortfolio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (ModalResult=mrOk) AND (NOT Merging) then
    PostCurrentIfNeeded;
end;

procedure TfrmGuestPortfolio.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  pgPages.ActivePageIndex := 0;
  ShowBackForthButtons := True;

  pnlChecksPerson.Visible := False;
  pnlChecksContact.Visible := False;
  pnlChecksCompany.Visible := False;
  pnlChecksPreferences.Visible := False;
  MarkNoneSelected;

  Merging := False;
end;

procedure TfrmGuestPortfolio.FormShow(Sender: TObject);
begin
  btnBack.Visible := False; // ShowBackForthButtons;
  btnForward.Visible := False; //ShowBackForthButtons;

  btnTabBack.Enabled := False;
  btnTabForward.Enabled := True;
  DisplayCurrent;
end;

procedure TfrmGuestPortfolio.PrepareMerge(Main : Boolean);
begin
  DisplayCurrent;
  pnlChecksPerson.Visible := True;
  pnlChecksContact.Visible := True;
  pnlChecksCompany.Visible := True;
  pnlChecksPreferences.Visible := True;
  if Main then
    MarkAllSelected
  else
    MarkNoneSelected;
end;


procedure TfrmGuestPortfolio.LMDSpeedButton6Click(Sender: TObject);
var
  sFilename : string;
  s : string;
begin
  dateTimeToString(s, 'yyyymmddhhnn', now);
  sFilename := TPath.Combine(GetTempDir, '_Roomer_XSLView');
  ExportGridToExcel(sFilename, grData, true, true, true);
  ShellExecute(Handle, 'OPEN', PChar(sFilename + '.xls'), nil, nil, sw_shownormal);
end;

procedure TfrmGuestPortfolio.pgPagesChange(Sender: TObject);
var rSet : TRoomerDataset;
    s : String;
    id: Integer;

    pgPages : TsPageControl;
begin
  if dataset.Eof then exit;

  pgPages := TsPageControl(Sender);
  id := GuestId;
  rSet := CreateNewDataset;
  try
    if pgPages.ActivePage = tabHistory then
    begin
      s := format('SELECT collect.*, ' +
           'DATEDIFF(collect.Departure, collect.Arrival) AS Nights, ' +
           '(SELECT SUM(Total) FROM invoicelines il WHERE il.RoomReservation=collect.RoomReservation)+collect.TotalStay AS TotalInvoice ' +
           'FROM ' +
           '( ' +
           'SELECT rr.Reservation, rr.RoomReservation, ' +
           '(SELECT ResFlag FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''G'',''D'',''P'') ORDER BY ADate DESC LIMIT 1) AS ResStatus, ' +
           'DATE((SELECT ADate FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''G'',''D'',''P'') ORDER BY ADate LIMIT 1)) AS Arrival, ' +
           'DATE_ADD(DATE((SELECT ADate FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''G'',''D'',''P'') ORDER BY ADate DESC LIMIT 1)), INTERVAL 1 DAY) AS Departure, ' +
           '(SELECT Room FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''G'',''D'',''P'') ORDER BY ADate DESC LIMIT 1) AS Room, ' +
           '(SELECT RoomType FROM roomsdate WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''G'',''D'',''P'') ORDER BY ADate DESC LIMIT 1) AS RoomType, ' +
           '(SELECT AVG(RoomRate-(IF(isPercentage, RoomRate*Discount/100, Discount)))*cu.AValue FROM roomsdate rd INNER JOIN currencies cu ON cu.Currency=rd.Currency WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''G'',''D'',''P'')) AS AvgRate, ' +
           '(SELECT SUM(RoomRate-(IF(isPercentage, RoomRate*Discount/100, Discount)))*cu.AValue FROM roomsdate rd INNER JOIN currencies cu ON cu.Currency=rd.Currency WHERE RoomReservation=rr.RoomReservation AND ResFlag IN (''G'',''D'',''P'')) AS TotalStay ' +
           'FROM roomreservations rr ' +
           'INNER JOIN reservations r ON r.Reservation=rr.Reservation ' +
           'WHERE rr.RoomReservation IN (SELECT DISTINCT RoomReservation FROM persons WHERE PersonsProfilesId=%d) ' +
           ') collect',
           [id]);

      if hdata.rSet_bySQL(rSet, s) then
      begin
        history_.DisableControls;
        try
          if history_.active then history_.Close;
          history_.Open;
          history_.LoadFromDataSet(rSet);
          history_.First;
        finally
          history_.EnableControls;
        end;
      end else
        history_.Close;
    end else
    if pgPages.ActivePage = tabInvoices then
    begin
      s := format('SELECT DATE(ih.invoiceDate) AS invoiceDate, ih.InvoiceNumber, ' +
                  'SUM(IF(il.ItemId = co.RoomRentItem, il.Total, 0) * cu.AValue) AS TotalStay, ' +
                  'SUM(IF(il.ItemId != co.RoomRentItem, il.Total, 0) * cu.AValue) AS TotalItems, ' +
                  'SUM(il.Total) AS TotalInvoice ' +
                  'FROM invoicelines il ' +
                  'INNER JOIN invoiceheads ih ON ih.InvoiceNumber=il.InvoiceNumber ' +
                  'INNER JOIN currencies cu ON cu.Currency=il.Currency, ' +
                  'control co ' +
                  'WHERE ih.InvoiceNumber > 0 ' +
                  'AND il.RoomReservation IN (SELECT DISTINCT RoomReservation rr FROM persons WHERE PersonsProfilesId=%d) ' +
                  'GROUP BY InvoiceNumber',
           [id]);

      if hdata.rSet_bySQL(rSet, s) then
      begin
        invoices_.DisableControls;
        try
          if invoices_.active then invoices_.Close;
          invoices_.Open;
          invoices_.LoadFromDataSet(rSet);
          invoices_.First;
        finally
          invoices_.EnableControls;
        end;
      end else
        invoices_.Close;
    end;
  finally
    FreeAndNil(rSet);

  end;
end;

procedure TfrmGuestPortfolio.btnBackClick(Sender: TObject);
begin
  PostCurrentIfNeeded;
  dataset.Prior;
  if dataset.Bof then
    dataset.First;
  if dataset.Bof then
  begin
    Close;
    exit;
  end;

  GuestId := dataset['id'];
  DisplayCurrent;
end;

procedure TfrmGuestPortfolio.btnEmailClick(Sender: TObject);
var url : String;
begin
// https://www.linkedin.com/profile/view?id=402178492
// https://twitter.com/xamarinhq
  url := '';
  case (Sender AS TsButton).Tag of
    11 : url := 'mailto://' + edtEmail.Text;
    12 : if LowerCase(copy(edtWebsite.Text, 1, 4)) <> 'http' then
           url := 'http://' + edtWebsite.Text
         else
           url := edtWebsite.Text;
    13 : url := 'skype://' + edtSkype.Text;
    14 : if LowerCase(copy(edtTwitter.Text, 1, 4)) <> 'http' then
           url := 'https://twitter.com/' + edtTwitter.Text
         else
           url := edtTwitter.Text;
    15 : if LowerCase(copy(edtLinkedIn.Text, 1, 4)) <> 'http' then
           url := 'https://www.linkedin.com/profile/view?id=' + edtLinkedIn.Text
         else
           url := edtLinkedIn.Text;
  end;
  if url <> '' then
    ShellExecute(Handle, 'OPEN', PChar(url), nil, nil, sw_shownormal);
end;

procedure TfrmGuestPortfolio.btnForwardClick(Sender: TObject);
begin
  PostCurrentIfNeeded;
  dataset.Next;
  if dataset.Eof then
    dataset.Last;
  if dataset.Eof then
  begin
    Close;
    exit;
  end;

  GuestId := dataset['id'];
  DisplayCurrent;
end;

procedure TfrmGuestPortfolio.cbxEmailSpecialsClick(Sender: TObject);
begin
  DataChanged := True;
end;

procedure TfrmGuestPortfolio.edtBirthdayChange(Sender: TObject);
begin
  DataChanged := True;
end;

end.
