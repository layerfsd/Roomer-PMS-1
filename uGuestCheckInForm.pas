unit uGuestCheckInForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sEdit,
  sLabel, Vcl.ComCtrls, sPageControl, sButton, Vcl.ExtCtrls, sPanel, sComboBox, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sCheckBox, cmpRoomerDataSet,
  hData, uG, frxDesgn, frxClass, frxDBSet, System.Generics.Collections, uRoomerFilterComboBox

    ;

type
  TFrmGuestCheckInForm = class(TForm)
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sPanel1: TsPanel;
    sPageControl2: TsPageControl;
    sTabSheet2: TsTabSheet;
    sLabel6: TsLabel;
    edCardId: TsEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    edLastName: TsEdit;
    edAddress1: TsEdit;
    sLabel3: TsLabel;
    edAddress2: TsEdit;
    edZipcode: TsEdit;
    sLabel4: TsLabel;
    edCountry: TsEdit;
    sLabel5: TsLabel;
    sButton1: TsButton;
    sLabel7: TsLabel;
    sPanel2: TsPanel;
    sLabel8: TsLabel;
    sLabel10: TsLabel;
    cbxGuaranteeTypes: TsComboBox;
    pgGuaranteeTypes: TsPageControl;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    sLabel15: TsLabel;
    edDateOfBirth: TsDateEdit;
    sLabel16: TsLabel;
    edAmount: TsEdit;
    sTabSheet5: TsTabSheet;
    cbCreditCard: TsCheckBox;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    sButton2: TsButton;
    sLabel9: TsLabel;
    edCity: TsEdit;
    sLabel11: TsLabel;
    sLabel12: TsLabel;
    lbCountryName: TsLabel;
    sLabel13: TsLabel;
    edTel1: TsEdit;
    sLabel14: TsLabel;
    edEmail: TsEdit;
    sLabel17: TsLabel;
    edMobile: TsEdit;
    sLabel18: TsLabel;
    edNationality: TsEdit;
    sButton3: TsButton;
    sLabel19: TsLabel;
    sLabel20: TsLabel;
    sLabel21: TsLabel;
    sTabSheet6: TsTabSheet;
    sLabel22: TsLabel;
    sLabel23: TsLabel;
    edCompany: TsEdit;
    sLabel24: TsLabel;
    sLabel25: TsLabel;
    edCompAddress1: TsEdit;
    edCompAddress2: TsEdit;
    edCompZipcode: TsEdit;
    sLabel26: TsLabel;
    sLabel27: TsLabel;
    edCompCity: TsEdit;
    edCompCountry: TsEdit;
    sLabel28: TsLabel;
    sButton4: TsButton;
    sLabel29: TsLabel;
    edCompEmail: TsEdit;
    sLabel30: TsLabel;
    sLabel31: TsLabel;
    edCompTelNumber: TsEdit;
    lbNationality: TsLabel;
    lbCompCountry: TsLabel;
    sButton5: TsButton;
    lbPayment: TsLabel;
    rptForm: TfrxReport;
    dsForm: TfrxDBDataset;
    frxDesigner1: TfrxDesigner;
    sLabel32: TsLabel;
    edTitle: TsEdit;
    sLabel33: TsLabel;
    lbRoomRent: TsLabel;
    sLabel35: TsLabel;
    sLabel36: TsLabel;
    lbSales: TsLabel;
    sLabel38: TsLabel;
    lbSubTotal: TsLabel;
    Shape1: TShape;
    sLabel40: TsLabel;
    lbPAyments: TsLabel;
    Shape2: TShape;
    sLabel42: TsLabel;
    lbBalance: TsLabel;
    sLabel44: TsLabel;
    sButton6: TsButton;
    btnPortfolio: TsButton;
    btNoPortfolio: TsButton;
    shpFirstname: TShape;
    shpLastname: TShape;
    shpCity: TShape;
    shpCountry: TShape;
    shpGuarantee: TShape;
    shpCC: TShape;
    shpCash: TShape;
    edFirstname: TRoomerFilterComboBox;
    edSSN: TsEdit;
    sLabel34: TsLabel;
    sLabel37: TsLabel;
    edFax: TsEdit;
    sLabel39: TsLabel;
    edVAT: TsEdit;
    sTabSheet7: TsTabSheet;
    cbActiveLiveSearch: TsCheckBox;
    sLabel41: TsLabel;
    lbTaxes: TsLabel;
    pnlHidePayment: TsPanel;
    procedure FormCreate(Sender: TObject);
    procedure cbxGuaranteeTypesCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure edLastNameChange(Sender: TObject);
    procedure cbCreditCardClick(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sPanel2DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure btnPortfolioClick(Sender: TObject);
    procedure btNoPortfolioClick(Sender: TObject);
    procedure edFirstnameCloseUp(Sender: TObject);
    procedure edFirstnameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbActiveLiveSearchClick(Sender: TObject);
  private
    FisCheckIn: Boolean;
    procedure Prepare;
    procedure EnableOrDisableOKButton;
    procedure FormDesignMode;
    procedure SetIsCheckIn(const Value: Boolean);
    procedure FillQuickFind;
    { Private declarations }
  public
    { Public declarations }
    Reservation, RoomReservation: Integer;
    RoomReservationList: String;
    PersonId: Integer;
    NativeCurrency, Currency, Customer: String;
    CurrencyRate: Double;
    ResSetGuest: TRoomerDataSet;
    rec: recDownPayment;
    theDownPaymentData: recPaymentHolder;

    CurrentRealBalance: Double;

    procedure WndProc(var message: TMessage); override;
    procedure SaveGuestInfo;

    procedure LoadGuestInfo;
    procedure PrintReport;
    procedure Release;

    property isCheckIn: Boolean read FisCheckIn write SetIsCheckIn;
  end;

function OpenGuestCheckInForm(_RoomReservation: Integer; GuestCheckin: Boolean = True): Boolean;
function PrintRegistrationForm(_RoomReservations: IntegerArray): Boolean;

var
  FrmGuestCheckInForm: TFrmGuestCheckInForm;

const
  GET_RESERVATION_CHECKIN_CHECKOUT = 'SELECT * FROM reservations ' + 'WHERE Reservation=(SELECT Reservation FROM roomreservations WHERE RoomReservation=%d)';

  GET_GUEST_CHECKIN_CHECKOUT = 'SELECT ID, title, ' + 'Reservation, ' + '(SELECT NativeCurrency FROM control LIMIT 1) AS NativeCurrency, ' +
    '(SELECT Customer FROM reservations WHERE Reservation=persons.Reservation) AS Customer, ' +
    '(SELECT Currency FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) AS Currency, ' +
    '(SELECT Avalue FROM currencies WHERE Currency=(SELECT Currency FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) LIMIT 1) AS CurrencyRate, '
    +

    '(SELECT CCMaskedCreditCard FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) AS MaskedCreditCard, ' +
    '(SELECT CCExpiry FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) AS CreditCardExpiry, ' +
    '(SELECT CCNameOnCard FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) AS NameOnCreditCard, ' +
    '(SELECT CCCardType FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) AS CreditCardType, ' +

    '(SELECT PaymentGuaranteeType FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) AS PaymentGuaranteeType, ' +
    '(SELECT Status FROM roomreservations WHERE RoomReservation=persons.RoomReservation LIMIT 1) AS ResStatus, ' +

    '(SELECT AVG(RoomRate - IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X''))) AS AverageRoomRate, '
    + '(SELECT SUM(RoomRate - IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X''))) AS TotalPrice, '
    + 'DATE((SELECT ADate FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X'')) ORDER BY ADate LIMIT 1)) AS Arrival, ' +
    'DATE_ADD(DATE((SELECT ADate FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X'')) ORDER BY ADate DESC LIMIT 1)), INTERVAL 1 DAY) AS Departure, ' +
    'DATEDIFF(DATE_ADD(DATE((SELECT ADate FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X'')) ORDER BY ADate DESC LIMIT 1)), INTERVAL 1 DAY), ' +
    'DATE((SELECT ADate FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X'')) ORDER BY ADate LIMIT 1))) AS Nights, ' +
    '(SELECT COUNT(ID) FROM persons p1 WHERE RoomReservation=persons.RoomReservation) AS NumberOfGuests, ' +
    '(SELECT Room FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X'')) LIMIT 1) AS RoomNumber, ' +

    'IF(ISNULL((SELECT SUM((Price - (Price*IF(Discount_IsPrecent,Discount/100,Discount)))*Number) FROM invoicelines WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)), 0, '
    + '  (SELECT SUM((Price - (Price*IF(Discount_IsPrecent,Discount/100,Discount)))*Number) FROM invoicelines WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)) AS CurrentSales, '
    + 'IF(ISNULL((SELECT SUM(Amount) FROM payments WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)), 0, '
    + '  (SELECT SUM(Amount) FROM payments WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)) AS CurrentPayments, '
    +

    'IF(ISNULL((SELECT SUM(RoomRate - IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X'')))), 0, ' +
    '  (SELECT SUM(RoomRate - IF(isPercentage, RoomRate*Discount/100, Discount)) FROM roomsdate WHERE RoomReservation=persons.RoomReservation AND (NOT ResFlag In (''C'',''X'')))) + ' +
    'IF(ISNULL((SELECT SUM((Price - (Price*IF(Discount_IsPrecent,Discount/100,Discount)))*Number) FROM invoicelines WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)), 0, '
    + '  (SELECT SUM((Price - (Price*IF(Discount_IsPrecent,Discount/100,Discount)))*Number) FROM invoicelines WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)) - '
    + 'IF(ISNULL((SELECT SUM(Amount) FROM payments WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)), 0, '
    + '  (SELECT SUM(Amount) FROM payments WHERE RoomReservation=persons.RoomReservation AND Reservation=persons.Reservation AND InvoiceNumber=-1)) AS CurrentBalance, '
    +

    'Name AS FullName, ' + 'LEFT(Name, CHAR_LENGTH(Name) - CHAR_LENGTH(SUBSTRING_INDEX(Name,'' '',-1))-1) AS FirstName, ' +
    'SUBSTRING_INDEX(Name,'' '',-1) AS LastName, ' + 'Address1, Address2, Address3 AS ZIPCode, Address4 AS City, ' + 'Country, ' +

    'Tel1 AS Telephone, Tel2 AS MobileNumber, Email AS GuestEmail, ' +

    'Nationality, ' +

    'CompanyName, ' + 'CompAddress1, ' + 'CompAddress2, ' + 'CompZip, ' + 'CompCity, ' + 'CompCountry, ' + 'CompTel, ' + 'CompEmail, ' +

    'CompFax, ' + 'CompVATNumber, ' + 'SocialSecurityNumber, ' +
    'PersonsProfilesId, ' +

    '(SELECT CountryName FROM countries WHERE Country=persons.Country) AS CountryName, ' +
    '(SELECT CountryName FROM countries WHERE Country=persons.Nationality) AS NationalityName, ' +
    '(SELECT CountryName FROM countries WHERE Country=persons.CompCountry) AS CompCountryName, ' +


    'PersonalIdentificationId, ' + 'DateOfBirth ' + 'FROM persons ' + 'WHERE RoomReservation IN (%s) ' +
    'AND ID=(SELECT ID FROM persons pe WHERE pe.RoomReservation=persons.RoomReservation ORDER BY MainName DESC, ID LIMIT 1) ' + 'GROUP BY RoomReservation';

  PUT_GUEST_CHECKIN_CHECKOUT = 'UPDATE persons p, roomreservations r ' + 'SET Title=%s, ' + ' p.Name=%s, ' + '	p.Address1=%s, ' + '	p.Address2=%s, ' + '	p.Address3=%s, ' +
    '	p.Address4=%s, ' + '	p.Country=%s, ' +

    '	p.Tel1=%s, ' + '	p.Tel2=%s, ' + '	p.Email=%s, ' +

    ' p.Nationality=%s, ' +

    '	p.CompanyName=%s, ' + '	p.CompAddress1=%s, ' + '	p.CompAddress2=%s, ' + '	p.CompZip=%s, ' + '	p.CompCity=%s, ' + '	p.CompCountry=%s, ' +
    '	p.CompTel=%s, ' + '	p.CompEmail=%s, ' + ' p.PersonsProfilesId=%s, ' +

    ' p.CompFax=%s, ' + ' p.CompVATNumber=%s, ' + ' p.SocialSecurityNumber=%s, ' +

    '	p.PersonalIdentificationId=%s, ' + '	p.DateOfBirth=%s, ' + '	r.PaymentGuaranteeType=%s ' + 'WHERE p.ID=%d ' + 'AND r.RoomReservation=p.RoomReservation';


  UPDATE_PROFILE_FROM_PERSON = 'UPDATE persons pe ' +
                  'JOIN personprofiles pp ON pp.Id = pe.PersonsProfilesId ' +
                  'SET pp.title = pe.title, ' +
                  'pp.Firstname = LEFT(Name, CHAR_LENGTH(Name) - CHAR_LENGTH(SUBSTRING_INDEX(Name,'' '',-1))-1), ' +
                  'pp.Lastname = SUBSTRING_INDEX(Name,'' '',-1), ' +
                  'pp.Address1 = pe.Address1, ' +
                  'pp.Address2 = pe.Address2, ' +
                  'pp.Zip = pe.Address3, ' +
                  'pp.City = pe.Address4, ' +
                  'pp.Country = pe.Country, ' +
                  'pp.TelLandLine = pe.Tel1, ' +
                  'pp.TelMobile = pe.Tel2, ' +
                  'pp.TelFax = pe.Fax, ' +
                  'pp.Email = pe.Email, ' +
                  'pp.Information = pe.Information, ' +
                  'pp.Nationality = pe.Nationality, ' +
                  'pp.CustomerCode = pe.Customer, ' +
                  'pp.CompanyName = pe.CompanyName, ' +
                  'pp.CompAddress1 = pe.CompAddress1, ' +
                  'pp.CompAddress2 = pe.CompAddress2, ' +
                  'pp.CompZip = pe.CompZip, ' +
                  'pp.CompCity = pe.CompCity, ' +
                  'pp.CompCountry = pe.CompCountry, ' +
                  'pp.CompTel = pe.CompTel, ' +
                  'pp.CompEmail = pe.CompEmail, ' +
                  'pp.state = pe.state, ' +
                  'pp.DateOfBirth = pe.DateOfBirth, ' +
                  'pp.CompFax=pe.CompFax, ' +
                  'pp.CompVATNumber=pe.CompVATNumber, ' +
                  'pp.PassportNumber=pe.PersonalIdentificationId, ' +
                  'pp.SocialSecurityNumber=pe.SocialSecurityNumber ' +

                  'WHERE pe.MainName=1 AND pe.RoomReservation=%d';

implementation

{$R *.dfm}

uses uRoomerLanguage,
  uAppGlobal,
  uD,
  uDateUtils,
  uCountries,
  _Glob,
  uUtils,
  PrjConst,
  uFileDependencyManager,
  uGuestProfiles,
  uStringUtils,
  uTaxCalc,
  DateUtils,
  uRoomerDefinitions;

const
  WM_SET_COMBO_TEXT = WM_User + 101;

function OpenGuestCheckInForm(_RoomReservation: Integer; GuestCheckin: Boolean = True): Boolean;
var
  _FrmGuestCheckInForm: TFrmGuestCheckInForm;
begin
  result := false;
  _FrmGuestCheckInForm := TFrmGuestCheckInForm.Create(nil);
  with _FrmGuestCheckInForm do
    try
      _FrmGuestCheckInForm.RoomReservation := _RoomReservation;
      _FrmGuestCheckInForm.isCheckIn := GuestCheckin;
      if NOT GuestCheckin then
        _FrmGuestCheckInForm.Caption := GetTranslatedText('shUI_GuestDetailsDialog');
      ShowModal;
      if modalresult = mrOk then
      begin
        SaveGuestInfo;
        result := True;
      end
      else
      begin

      end;
    finally
      freeandnil(_FrmGuestCheckInForm);
    end;
end;

function PrintRegistrationForm(_RoomReservations: IntegerArray): Boolean;
var
  i: Integer;
  sRoomResList: String;
begin
  result := false;
  FrmGuestCheckInForm := TFrmGuestCheckInForm.Create(FrmGuestCheckInForm);
  with FrmGuestCheckInForm do
    try
      sRoomResList := '';
      for i := Low(_RoomReservations) to High(_RoomReservations) do
        if sRoomResList = '' then
          sRoomResList := inttostr(_RoomReservations[i])
        else
          sRoomResList := sRoomResList + ',' + inttostr(_RoomReservations[i]);
      with FrmGuestCheckInForm do
      begin
        RoomReservationList := sRoomResList;
        LoadGuestInfo;
        PrintReport;
      end;
    finally
      freeandnil(FrmGuestCheckInForm);
    end;
end;

procedure TFrmGuestCheckInForm.cbCreditCardClick(Sender: TObject);
begin
  EnableOrDisableOKButton;
end;

procedure TFrmGuestCheckInForm.cbxGuaranteeTypesCloseUp(Sender: TObject);
begin
  pgGuaranteeTypes.ActivePageIndex := cbxGuaranteeTypes.ItemIndex;
  EnableOrDisableOKButton;
end;

procedure TFrmGuestCheckInForm.FillQuickFind;
var
  rSet: TRoomerDataSet;

  function getFullname: String;
  begin
    result := Trim(rSet['FirstName'] + ' ' + rSet['Lastname']);
  end;

  function getField(fName: String): String;
  var
    s: String;
  begin
    s := rSet[fName];
    if s = '' then
      result := ''
    else
      result := ', ' + s;
  end;

var
  item: TRoomerFilterItem;

begin
  rSet := glb.PersonProfiles;
  edFirstname.StoredItems.Clear;
  rSet.First;
  while NOT rSet.Eof do
  begin
    item := TRoomerFilterItem.Create;
    item.Key := inttostr(rSet['ID']);
    item.Line := format('%s%s%s%s', [getFullname, getField('City'), getField('Country'), getField('Address1')]);
    edFirstname.StoredItems.Add(item);
    rSet.Next;
  end;

  rSet := glb.PreviousGuestsSet;
  rSet.First;
  while NOT rSet.Eof do
  begin
    item := TRoomerFilterItem.Create;
    item.Key := rSet['ID'];
    item.Line := format('%s%s%s%s', [rSet['Name'], getField('Address4'), getField('Country'), getField('Address1')]);
    edFirstname.StoredItems.Add(item);
    rSet.Next;
  end;

  cbActiveLiveSearch.Checked := false;
  cbActiveLiveSearchClick(cbActiveLiveSearch);
  // if edFirstname.StoredItems.Count > 0 then
  // edFirstname.Start;
end;

procedure TFrmGuestCheckInForm.WndProc(var message: TMessage);
var
  s, s1: String;
begin
  inherited;
  if message.Msg = WM_SET_COMBO_TEXT then
  begin
    if message.WParam = 1 then
    begin
      parseFirstAndLastNameFromFullname(glb.PreviousGuestsSet['Name'], s, s1);
      edFirstname.Text := Trim(s);
      edLastName.Text := Trim(s1);
      edTitle.Text := glb.PreviousGuestsSet['title'];
      edSSN.Text := glb.PreviousGuestsSet['SocialSecurityNumber'];
      edVAT.Text := glb.PreviousGuestsSet['CompVATNumber'];
      edFax.Text := glb.PreviousGuestsSet['CompFax'];
      edAddress1.Text := glb.PreviousGuestsSet['Address1'];
      edAddress2.Text := glb.PreviousGuestsSet['Address2'];
      edZipcode.Text := glb.PreviousGuestsSet['Address3'];
      edCity.Text := glb.PreviousGuestsSet['Address4'];
      edCountry.Text := glb.PreviousGuestsSet['Country'];
      edTel1.Text := glb.PreviousGuestsSet['Tel1'];
      edMobile.Text := glb.PreviousGuestsSet['Tel2'];
      edEmail.Text := glb.PreviousGuestsSet['Email'];
      edCardId.Text := ResSetGuest['PassPortNumber'];
    end
    else
    begin
      btnPortfolio.Tag := glb.PersonProfiles['Id'];
      edFirstname.Text := Trim(glb.PersonProfiles['Firstname']);
      edLastName.Text := Trim(glb.PersonProfiles['Lastname']);

      edTitle.Text := glb.PersonProfiles['title'];
      edSSN.Text := glb.PersonProfiles['SocialSecurityNumber'];
      edVAT.Text := glb.PersonProfiles['CompVATNumber'];
      edFax.Text := glb.PersonProfiles['CompFax'];

      edCardId.Text := glb.PersonProfiles['PassportNumber'];

      edAddress1.Text := glb.PersonProfiles['Address1'];
      edAddress2.Text := glb.PersonProfiles['Address2'];
      edZipcode.Text := glb.PersonProfiles['Zip'];
      edCity.Text := glb.PersonProfiles['City'];
      edCountry.Text := glb.PersonProfiles['Country'];
      edTel1.Text := glb.PersonProfiles['TelLandLine'];
      edMobile.Text := glb.PersonProfiles['TelMobile'];
      edEmail.Text := glb.PersonProfiles['Email'];
    end;
  end;
end;

procedure TFrmGuestCheckInForm.edFirstnameCloseUp(Sender: TObject);
var
  Key: String;
begin
  if edFirstname.Items.IndexOf(edFirstname.Text) >= 0 then
  begin
    Key := TRoomerFilterItem(edFirstname.Items.Objects[edFirstname.ItemIndex]).Key; // edContactPerson.FKeys[idx];
    if glb.LocateSpecificRecord(glb.PreviousGuestsSet, 'ID', Key) then
    begin
      postMessage(handle, WM_SET_COMBO_TEXT, 1, 0);
    end
    else if glb.LocateSpecificRecord(glb.PersonProfiles, 'ID', Key) then
    begin
      postMessage(handle, WM_SET_COMBO_TEXT, 2, 0);
    end;
  end;
end;

procedure TFrmGuestCheckInForm.edFirstnameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key IN [VK_RETURN, VK_TAB]) AND (edFirstname.Items.IndexOf(edFirstname.Text) < 0) then
  begin
    ActiveControl := edLastName;
  end;
end;

procedure TFrmGuestCheckInForm.edLastNameChange(Sender: TObject);
begin
  EnableOrDisableOKButton;
end;

procedure TFrmGuestCheckInForm.EnableOrDisableOKButton;
begin
  BtnOk.Enabled := (Trim(edFirstname.Text) <> '') AND (Trim(edLastName.Text) <> '') AND (Trim(edCity.Text) <> '') AND (Trim(edCountry.Text) <> '') AND

    ((NOT isCheckIn) OR (((cbxGuaranteeTypes.ItemIndex = 0) AND cbCreditCard.Checked) OR ((cbxGuaranteeTypes.ItemIndex = 1) AND
    (StrToFloatDef(edAmount.Text, -99999) <> -99999)) OR ((cbxGuaranteeTypes.ItemIndex = 2))));
  shpFirstname.Visible := Trim(edFirstname.Text) = '';
  shpLastname.Visible := Trim(edLastName.Text) = '';
  shpCity.Visible := Trim(edCity.Text) = '';
  shpCountry.Visible := Trim(edCountry.Text) = '';
  shpGuarantee.Visible := NOT(((cbxGuaranteeTypes.ItemIndex = 0) AND cbCreditCard.Checked) OR
    ((cbxGuaranteeTypes.ItemIndex = 1) AND (StrToFloatDef(edAmount.Text, -99999) <> -99999)) OR ((cbxGuaranteeTypes.ItemIndex = 2)));
  shpCC.Visible := shpGuarantee.Visible;
  shpCash.Visible := shpGuarantee.Visible;

end;

procedure TFrmGuestCheckInForm.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);

  RoomReservationList := '';
  Prepare;
end;

procedure TFrmGuestCheckInForm.FormDestroy(Sender: TObject);
begin
  Release;
end;

procedure TFrmGuestCheckInForm.Release;
begin
  freeandnil(ResSetGuest);
end;

procedure TFrmGuestCheckInForm.LoadGuestInfo;
var
  param: String;
  taxes: TList<TInvoiceTaxEntity>;
  RoomTaxEntities: TList<TInvoiceRoomEntity>;
  ItemTaxEntities: TList<TInvoiceItemEntity>;

  ExtraTaxes: Double;
  ItemTypeInfo: TItemTypeInfo;

  tempRSet: TRoomerDataSet;
  s: String;
  i: Integer;
begin
  if RoomReservationList = '' then
    param := inttostr(RoomReservation)
  else
    param := RoomReservationList;
  if rSet_bySQL(ResSetGuest, format(GET_GUEST_CHECKIN_CHECKOUT, [param])) then
  begin
    Reservation := ResSetGuest['Reservation'];
    PersonId := ResSetGuest['ID'];
    Customer := ResSetGuest['Customer'];
    NativeCurrency := ResSetGuest['NativeCurrency'];
    Currency := ResSetGuest['Currency'];
    CurrencyRate := ResSetGuest['CurrencyRate'];
    sTabSheet1.Caption := GetTranslatedText('shTx_RoomEdit_Room') + ResSetGuest['RoomNumber'];

    ExtraTaxes := 0.00;

    if NOT ctrlGetBoolean('StayTaxIncluted') then
    begin
      tempRSet := CreateNewDataset;
      try
        s := format('SELECT (SELECT RoomRentItem FROM control LIMIT 1) AS RoomRentItem, ' +
          '(SELECT COUNT(id) FROM persons WHERE RoomReservation IN (%s) LIMIT 1) AS Guests, ' +
          '(SELECT COUNT(id) FROM roomsdate WHERE RoomReservation IN (%s) AND (NOT ResFlag IN (''X'',''C'',''O'',''N'')) LIMIT 1) AS Nights, ' +
          '%s/1.00 AS Price, ' +
          '%s - %s/(1 + (SELECT VATPercentage FROM vatcodes WHERE VATCode = (SELECT VATCode FROM itemtypes WHERE ItemType=(SELECT ItemType FROM items WHERE Item=(SELECT RoomRentItem FROM control LIMIT 1))))/100) AS VAT ',
          [param, param, uStringUtils.FloatToDBString(ResSetGuest['TotalPrice']), uStringUtils.FloatToDBString(ResSetGuest['TotalPrice']),
          uStringUtils.FloatToDBString(ResSetGuest['TotalPrice'])]);

        if rSet_bySQL(tempRSet, s) then
        begin
          RoomTaxEntities := TList<TInvoiceRoomEntity>.Create;
          RoomTaxEntities.Add(TInvoiceRoomEntity.Create(tempRSet['RoomRentItem'], tempRSet['Guests'], tempRSet['Nights'],
            tempRSet['Price'] / tempRSet['Nights'], tempRSet['VAT'] / tempRSet['Nights']));
          ItemTaxEntities := TList<TInvoiceItemEntity>.Create;

          ItemTypeInfo := d.Item_Get_ItemTypeInfo(trim(g.qRoomRentItem));
          taxes := GetTaxesForInvoice(RoomTaxEntities, ItemTaxEntities, ItemTypeInfo, ctrlGetBoolean('StayTaxIncluted'));
          try
            for i := 0 to taxes.Count - 1 do
              ExtraTaxes := ExtraTaxes + taxes[i].total;
          finally
            RoomTaxEntities.Free;
            ItemTaxEntities.Free;
            taxes.Free;
          end;
        end;
      finally
        tempRSet.Free;
      end;
    end;
    lbRoomRent.Caption := Trim(_floatToStr(ResSetGuest['TotalPrice'], 12, 2));
    lbSales.Caption := Trim(_floatToStr(ResSetGuest['CurrentSales'], 12, 2));
    lbSubTotal.Caption := Trim(_floatToStr(ResSetGuest['TotalPrice'] + ResSetGuest['CurrentSales'], 12, 2));
    lbPAyments.Caption := Trim(_floatToStr(ResSetGuest['CurrentPayments'], 12, 2));
    lbTaxes.Caption := Trim(_floatToStr(ExtraTaxes, 12, 2));
    CurrentRealBalance := ExtraTaxes + ResSetGuest['CurrentBalance'];
    lbBalance.Caption := Trim(_floatToStr(CurrentRealBalance, 12, 2));

    edFax.Text := ResSetGuest['CompFax'];
    edVAT.Text := ResSetGuest['CompVATNumber'];
    edSSN.Text := ResSetGuest['SocialSecurityNumber'];

    edCardId.Text := ResSetGuest['PersonalIdentificationId'];
    btnPortfolio.Tag := ResSetGuest['PersonsProfilesId'];
    edTitle.Text := ResSetGuest['title'];
    edFirstname.Text := ResSetGuest['FirstName'];
    edLastName.Text := ResSetGuest['LastName'];
    edAddress1.Text := ResSetGuest['Address1'];
    edAddress2.Text := ResSetGuest['Address2'];
    edZipcode.Text := ResSetGuest['ZIPCode'];
    edCity.Text := ResSetGuest['City'];
    if ResSetGuest['Country'] <> '00' then
      edCountry.Text := ResSetGuest['Country']
    else
      edCountry.Text := '';

    edTel1.Text := ResSetGuest['Telephone'];
    edMobile.Text := ResSetGuest['MobileNumber'];
    edEmail.Text := ResSetGuest['GuestEmail'];

    edNationality.Text := ResSetGuest['Nationality'];

    edCompany.Text := ResSetGuest['CompanyName'];
    edCompAddress1.Text := ResSetGuest['CompAddress1'];
    edCompAddress2.Text := ResSetGuest['CompAddress2'];
    edCompZipcode.Text := ResSetGuest['CompZip'];
    edCompCity.Text := ResSetGuest['CompCity'];
    if ResSetGuest['CompCountry'] <> '00' then
      edCompCountry.Text := ResSetGuest['CompCountry'];
    edCompTelNumber.Text := ResSetGuest['CompTel'];
    edCompEmail.Text := ResSetGuest['CompEmail'];

    edDateOfBirth.Date := ResSetGuest['DateOfBirth'];

    lbNationality.Caption := ResSetGuest['NationalityName'];
    lbCountryName.Caption := ResSetGuest['CountryName'];
    lbCompCountry.Caption := ResSetGuest['CompCountryName'];

    // cbxGuaranteeTypes.ItemIndex := 3;
    // if PAYMENT_GUARANTEE_TYPE.IndexOf(ResSetGuest['PaymentGuaranteeType'] then

    cbxGuaranteeTypes.ItemIndex := IndexOfArray(PAYMENT_GUARANTEE_TYPE, ResSetGuest['PaymentGuaranteeType'], 3);
    cbxGuaranteeTypesCloseUp(cbxGuaranteeTypes);
    case cbxGuaranteeTypes.ItemIndex of
      0:
        cbCreditCard.Checked := (ResSetGuest['ResStatus'] = 'G') OR (ResSetGuest['ResStatus'] = 'D');
      1:
        begin
          pnlHidePayment.Visible := (ResSetGuest['ResStatus'] = 'G') OR (ResSetGuest['ResStatus'] = 'D');
          if pnlHidePayment.Visible then
            pnlHidePayment.Align := alClient;
        end;
      2:
        ;
    end;
  end;

  EnableOrDisableOKButton;
end;

procedure TFrmGuestCheckInForm.SaveGuestInfo;
var
  s: String;
  NewId: Integer;
begin
  s := format(PUT_GUEST_CHECKIN_CHECKOUT, [_DB(edTitle.Text), _DB(Trim(edFirstname.Text + ' ' + edLastName.Text)), _DB(edAddress1.Text), _DB(edAddress2.Text),
    _DB(edZipcode.Text), _DB(edCity.Text), _DB(edCountry.Text),

    _DB(edTel1.Text), _DB(edMobile.Text), _DB(edEmail.Text),

    _DB(edNationality.Text),

    _DB(edCompany.Text), _DB(edCompAddress1.Text), _DB(edCompAddress2.Text), _DB(edCompZipcode.Text), _DB(edCompCity.Text), _DB(edCompCountry.Text),
    _DB(edCompTelNumber.Text), _DB(edCompEmail.Text), _DB(inttostr(btnPortfolio.Tag)),

    _DB(edFax.Text), _DB(edVAT.Text), _DB(edSSN.Text),

    _DB(edCardId.Text), _DB(uDateUtils.dateToSqlString(edDateOfBirth.Date)),

    _DB(PAYMENT_GUARANTEE_TYPE[cbxGuaranteeTypes.ItemIndex]), PersonId]);
  CopyToClipboard(s);
  if NOT cmd_bySQL(s, false) then
    raise Exception.Create('Unable to save changes.');

  s := format(UPDATE_PROFILE_FROM_PERSON, [RoomReservation]);
  CopyToClipboard(s);
  if NOT cmd_bySQL(s, false) then
    raise Exception.Create('Unable to save changes to guest''s profile.');

  if (cbxGuaranteeTypes.ItemIndex = 1) AND (StrToFloatDef(edAmount.Text, -99999) <> -99999) then
  begin
    NewId := 0;
    if NOT INS_Payment(theDownPaymentData, NewId) then
      raise Exception.Create('Unable to save down-payment.');
  end;
end;

var
  theData: recCountryHolder;

procedure TFrmGuestCheckInForm.sButton1Click(Sender: TObject);
begin
  theData.Country := edCountry.Text;
  if Countries(actLookup, theData) then
  begin
    edCountry.Text := theData.Country;
    lbCountryName.Caption := theData.CountryName;
  end;
end;

procedure TFrmGuestCheckInForm.sButton2Click(Sender: TObject);
begin
  PrintReport;
end;

procedure TFrmGuestCheckInForm.PrintReport;
begin
  dsForm.DataSet := ResSetGuest;
  dsForm.Open;
  rptForm.DataSets.Add(dsForm);
  try
    rptForm.LoadFromFile(getRegistrationFormFilePath);
    rptForm.PrepareReport(True);
    rptForm.Print;
  finally
    rptForm.DataSets.Clear;
  end;
  // rptForm.ShowReport(false);
end;

procedure TFrmGuestCheckInForm.sButton3Click(Sender: TObject);
begin
  theData.Country := edNationality.Text;
  if Countries(actLookup, theData) then
  begin
    edNationality.Text := theData.Country;
    lbNationality.Caption := theData.CountryName;
  end;
end;

procedure TFrmGuestCheckInForm.sButton4Click(Sender: TObject);
begin
  theData.Country := edCompCountry.Text;
  if Countries(actLookup, theData) then
  begin
    edCompCountry.Text := theData.Country;
    lbCompCountry.Caption := theData.CountryName;
  end;
end;

procedure TFrmGuestCheckInForm.sButton5Click(Sender: TObject);
begin
  g.initRecDownPayment(rec);

  rec.Reservation := Reservation;
  rec.RoomReservation := RoomReservation;
  rec.Description := GetTranslatedText('shTx_CheckIn_PaymentGuarantee_Downpayment');
  rec.Invoice := -1;
  rec.Amount := 0;

  rec.InvoiceBalance := CurrentRealBalance; // ResSetGuest['CurrentBalance'];
  rec.NotInvoice := True;

  if g.OpenDownPayment(actInsert, rec) then
  begin
    lbPayment.Caption := rec.PaymentType;
    edAmount.Text := FloatToStr(rec.Amount);

    theDownPaymentData.Reservation := Reservation;
    theDownPaymentData.RoomReservation := RoomReservation;
    theDownPaymentData.Person := 0;
    theDownPaymentData.TypeIndex := ORD(ptDownPayment);
    theDownPaymentData.invoiceNumber := -1;
    theDownPaymentData.Customer := Customer;
    theDownPaymentData.PayDate := _DateToDbDate(now, false);
    theDownPaymentData.Amount := rec.Amount;
    theDownPaymentData.Description := rec.Description;
    theDownPaymentData.CurrencyRate := 1.00; // ATH
    theDownPaymentData.Currency := NativeCurrency;
    theDownPaymentData.confirmDate := 2; // _db('1900-01-01 00:00:00');
    theDownPaymentData.Notes := rec.Notes;
    theDownPaymentData.PayType := rec.PaymentType;
    theDownPaymentData.staff := d.roomerMainDataSet.username;
    theDownPaymentData.AutoGen := CreateAGUID;
    theDownPaymentData.Ayear := YearOf(now);
    theDownPaymentData.Amon := MonthOf(now);
    theDownPaymentData.Aday := DayOf(now);
  end;

end;

procedure TFrmGuestCheckInForm.sButton6Click(Sender: TObject);
begin
  FormDesignMode;
end;

procedure TFrmGuestCheckInForm.cbActiveLiveSearchClick(Sender: TObject);
begin
  if TsCheckBox(Sender).Checked AND (edFirstname.StoredItems.Count > 0) then
    edFirstname.Start
  else
    edFirstname.Stop;
end;

procedure TFrmGuestCheckInForm.SetIsCheckIn(const Value: Boolean);
begin
  FisCheckIn := Value;
  if NOT Value then
  begin
    shpGuarantee.Brush.Color := clBlue;
    shpCC.Brush.Color := clBlue;
    shpCash.Brush.Color := clBlue;
    shpGuarantee.Pen.Color := clBlue;
    shpCC.Pen.Color := clBlue;
    shpCash.Pen.Color := clBlue;
  end;
end;

procedure TFrmGuestCheckInForm.btNoPortfolioClick(Sender: TObject);
begin
  btnPortfolio.Tag := 0;

  btNoPortfolio.Visible := false;
  edCardId.Text := ''; // glb.PersonProfiles['PassportNumber'];

  edTitle.Text := '';
  edFirstname.Text := '';
  edLastName.Text := '';

  edNationality.Text := '';
  lbNationality.Caption := '';

  edDateOfBirth.Date := 0;
  edTel1.Text := '';
  edMobile.Text := '';
  edEmail.Text := '';

  edAddress1.Text := '';
  edAddress2.Text := '';
  edZipcode.Text := '';
  edCity.Text := '';
  edCountry.Text := '';
  lbCountryName.Caption := '';

  edCompany.Text := '';
  edCompTelNumber.Text := '';
  edCompEmail.Text := '';

  edCompAddress1.Text := '';
  edCompAddress2.Text := '';
  edCompZipcode.Text := '';
  edCompCity.Text := '';
  edCompCountry.Text := '';
  lbCompCountry.Caption := '';

  LoadGuestInfo;

end;

procedure TFrmGuestCheckInForm.btnPortfolioClick(Sender: TObject);
var
  sName: String;
  iId: Integer;
begin
  iId := GuestProfiles(actLookup, btnPortfolio.Tag);
  if iId > 0 then
  begin
    if glb.LocateSpecificRecord('personprofiles', 'ID', inttostr(iId)) then
    begin
      btnPortfolio.Tag := iId;

      edCardId.Text := glb.PersonProfiles['PassportNumber'];

      edTitle.Text := glb.PersonProfiles['title'];
      edSSN.Text := glb.PersonProfiles['SocialSecurityNumber'];
      edFirstname.Text := glb.PersonProfiles['Firstname'];
      edLastName.Text := glb.PersonProfiles['LastName'];

      edNationality.Text := glb.PersonProfiles['Nationality'];
      if glb.LocateSpecificRecordAndGetValue('countries', 'Country', edNationality.Text, 'CountryName', sName) then
        lbNationality.Caption := sName;

      edDateOfBirth.Date := glb.PersonProfiles['DateOfBirth'];
      edTel1.Text := glb.PersonProfiles['TelLandLine'];
      edMobile.Text := glb.PersonProfiles['TelMobile'];
      edEmail.Text := glb.PersonProfiles['Email'];

      edAddress1.Text := glb.PersonProfiles['Address1'];
      edAddress2.Text := glb.PersonProfiles['Address2'];
      edZipcode.Text := glb.PersonProfiles['Zip'];
      edCity.Text := glb.PersonProfiles['City'];
      edCountry.Text := glb.PersonProfiles['Country'];
      if glb.LocateSpecificRecordAndGetValue('countries', 'Country', edCountry.Text, 'CountryName', sName) then
        lbCountryName.Caption := sName;

      edCompany.Text := glb.PersonProfiles['CompanyName'];
      edVAT.Text := glb.PersonProfiles['CompVATNumber'];
      edCompTelNumber.Text := glb.PersonProfiles['CompTel'];
      edFax.Text := glb.PersonProfiles['CompFax'];
      edCompEmail.Text := glb.PersonProfiles['CompEmail'];

      edCompAddress1.Text := glb.PersonProfiles['CompAddress1'];
      edCompAddress2.Text := glb.PersonProfiles['CompAddress2'];
      edCompZipcode.Text := glb.PersonProfiles['CompZip'];
      edCompCity.Text := glb.PersonProfiles['CompCity'];
      edCompCountry.Text := glb.PersonProfiles['CompCountry'];

      if glb.LocateSpecificRecordAndGetValue('countries', 'Country', edCompCountry.Text, 'CountryName', sName) then
        lbCompCountry.Caption := sName;

    end;
  end;

  btNoPortfolio.Visible := btnPortfolio.Tag > 0;
end;

procedure TFrmGuestCheckInForm.sPanel2DblClick(Sender: TObject);
begin
  if IsControlKeyPressed then
    FormDesignMode;
end;

procedure TFrmGuestCheckInForm.FormDesignMode;
var
  filename: String;
begin
  filename := getRegistrationFormFilePath;
  dsForm.DataSet := ResSetGuest;
  dsForm.Open;
  rptForm.DataSets.Add(dsForm);
  try
    rptForm.LoadFromFile(filename);
    rptForm.DesignReport(True);
    sendChangedFile(filename);
  finally
    rptForm.DataSets.Clear;
  end;
end;

procedure TFrmGuestCheckInForm.FormShow(Sender: TObject);
begin
  sPageControl2.ActivePageIndex := 0;
  cbxGuaranteeTypes.ItemIndex := 3;
  pgGuaranteeTypes.ActivePageIndex := cbxGuaranteeTypes.ItemIndex;
  LoadGuestInfo;

  FillQuickFind;
end;

procedure TFrmGuestCheckInForm.Prepare;
var
  page: Integer;
begin
  for page := 0 to pgGuaranteeTypes.PageCount - 1 do
    pgGuaranteeTypes.Pages[page].TabVisible := false;
  cbxGuaranteeTypes.ItemIndex := 3;
  pgGuaranteeTypes.ActivePageIndex := cbxGuaranteeTypes.ItemIndex;
  ResSetGuest := CreateNewDataset;
end;

end.
