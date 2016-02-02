unit uEditGuest;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.Mask
  , Vcl.StdCtrls
  , Vcl.ComCtrls
  , Vcl.ExtCtrls

  , System.Generics.Collections

  , hData
  , uUtils
  , ug
  , uAppGlobal

  , sMaskEdit
  , sCustomComboEdit
  , sToolEdit
  , sEdit
  , sComboBox
  , uRoomerFilterComboBox
  , sLabel
  , sGroupBox
  , sPageControl
  , sButton
  , sPanel
  , PrjConst, cxClasses, cxPropertiesStore



  ;

type
  TfrmEditGuest = class(TForm)
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    pageMain: TsPageControl;
    tabGuest: TsTabSheet;
    tabCompany: TsTabSheet;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    edFirstname: TRoomerFilterComboBox;
    sLabel2: TsLabel;
    edLastName: TsEdit;
    sLabel6: TsLabel;
    edCardId: TsEdit;
    edTitle: TsEdit;
    sLabel34: TsLabel;
    edSSN: TsEdit;
    clabNationality: TsLabel;
    edNationality: TsEdit;
    sLabel15: TsLabel;
    edDateOfBirth: TsDateEdit;
    sLabel32: TsLabel;
    btnGetNationality: TsButton;
    sGroupBox2: TsGroupBox;
    sLabel13: TsLabel;
    edTel1: TsEdit;
    sLabel17: TsLabel;
    edMobile: TsEdit;
    sLabel14: TsLabel;
    edEmail: TsEdit;
    sGroupBox3: TsGroupBox;
    sLabel3: TsLabel;
    edAddress1: TsEdit;
    edAddress2: TsEdit;
    edZipcode: TsEdit;
    edCity: TsEdit;
    edCountry: TsEdit;
    btnGetCountry: TsButton;
    sLabel4: TsLabel;
    sLabel9: TsLabel;
    clabCountry: TsLabel;
    sGroupBox4: TsGroupBox;
    sLabel23: TsLabel;
    edCompany: TsEdit;
    sLabel39: TsLabel;
    edVAT: TsEdit;
    sGroupBox5: TsGroupBox;
    sLabel31: TsLabel;
    edCompTelNumber: TsEdit;
    sLabel37: TsLabel;
    edFax: TsEdit;
    sLabel29: TsLabel;
    edCompEmail: TsEdit;
    sGroupBox6: TsGroupBox;
    sLabel25: TsLabel;
    edCompAddress1: TsEdit;
    edCompAddress2: TsEdit;
    edCompZipcode: TsEdit;
    sLabel26: TsLabel;
    sLabel27: TsLabel;
    edCompCity: TsEdit;
    clabCompCountry: TsLabel;
    edCompCountry: TsEdit;
    sButton4: TsButton;
    sButton2: TsButton;
    labCountry: TsLabel;
    labNationality: TsLabel;
    labCompCountry: TsLabel;
    StoreMain: TcxPropertiesStore;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure btnGetNationalityClick(Sender: TObject);
    procedure btnGetCountryClick(Sender: TObject);
    procedure edCountryChange(Sender: TObject);
    function CountryValidate(ed : TsEdit; labCaption,labCountryName : Tslabel) : boolean;
    procedure edCountryExit(Sender: TObject);
    procedure edCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edNationalityExit(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
  private
    { Private declarations }
    zPersonData : recPersonHolder;



  public
    { Public declarations }
  end;

function OpenEditPerson(var personData : recPersonHolder) : boolean;

var
  frmEditGuest: TfrmEditGuest;

implementation

{$R *.dfm}

uses uCountries;



function OpenEditPerson(var personData : recPersonHolder) : boolean;
begin
  result := false;
  frmEditGuest := TfrmEditGuest.Create(frmEditGuest);
  try
    frmEditGuest.zPersonData := PersonData;
    frmEditGuest.ShowModal;
    if frmEditGuest.modalresult = mrOk then
    begin
      persondata := frmEditGuest.zPersonData;
      result := true;
    end
  finally
    freeandnil(frmEditGuest);
  end;
end;



function TfrmEditGuest.CountryValidate(ed : TsEdit; labCaption,labCountryName : Tslabel) : boolean;
var
  sValue : string;
begin
  result := true;
  sValue := trim(ed.Text);
  if not hdata.CountryExists(svalue) then
  begin
    ed.SetFocus;
//    labCaption.Color := clRed;
    labCountryName.Caption := GetTranslatedText('shNotF_star');
    result := false;
    exit;
  end else
  begin
//    labCaption.Color := clBtnFace;
    if glb.LocateCountry(sValue) then
      labCountryName.caption  := glb.Countries['CountryName']; // GET_CountryName(sValue);
  end;
end;



procedure TfrmEditGuest.BtnOkClick(Sender: TObject);
begin
  zPersonData.name         := trim(trim(edFirstname.text)+' '+trim(edLastname.text));
  zPersonData.title        := trim(edTitle.Text);
  zPersonData.Nationality  := trim(edNationality.Text);
  zPersonData.DateOfBirth  := edDateOfBirth.Date;

  zPersondata.Address1     := trim(edAddress1.Text);
  zPersondata.Address2     := trim(edAddress2.Text);
  zPersondata.Address3     := trim(edZipcode.Text);
  zPersondata.Address4     := trim(edCity.Text);

  zPersondata.PersonalIdentificationId := trim(edCardId.Text);
  zPersondata.SocialSecurityNumber     := trim(edSSN.Text);
  zPersondata.Country                  := trim(edCountry.Text);
  zPersondata.Tel1                     := trim(edTel1.Text);
  zPersondata.Tel2                     := trim(edMobile.Text);
  zPersondata.Email                    := trim(edEmail.Text);

  zPersondata.CompanyName    := trim(edCompany.text)         ;
  zPersondata.CompVATNumber  := trim(edVAT.text)             ;
  zPersondata.CompTel        := trim(edCompTelNumber.text)   ;
  zPersondata.CompFax        := trim(edFax.text)             ;
  zPersondata.CompEmail      := trim(edCompEmail.text)       ;
  zPersondata.CompAddress1   := trim(edCompAddress1.text)    ;
  zPersondata.CompAddress2   := trim(edCompAddress2.text)    ;
  zPersondata.CompZip        := trim(edCompZipcode.text)     ;
  zPersondata.CompCity       := trim(edCompCity.text)        ;
  zPersondata.CompCountry    := trim(edCompCountry.text)     ;
end;

procedure TfrmEditGuest.edCountryChange(Sender: TObject);
begin
  if glb.LocateCountry(edCountry.text) then
    labCountry.caption  := glb.Countries['CountryName'] // GET_CountryName(sValue);
      else labCountry.caption  := GetTranslatedText('shNotF_star');
end;

procedure TfrmEditGuest.edCountryExit(Sender: TObject);
begin
  if CountryValidate(edCountry,clabCountry,labCountry) then
  begin
    //
  end;
end;

procedure TfrmEditGuest.edCountryKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key =vk_f2 then
  begin
    btnGetCountryClick(self);
  end;
end;

procedure TfrmEditGuest.edNationalityExit(Sender: TObject);
begin
  if CountryValidate(edNationality,clabNationality,labNationality) then
  begin
    //
  end;
end;

procedure TfrmEditGuest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**
end;

procedure TfrmEditGuest.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //**
end;

procedure TfrmEditGuest.FormCreate(Sender: TObject);
begin
  //**
end;

procedure TfrmEditGuest.FormShow(Sender: TObject);
var
  sFirstname : string;
  sLastName  : string;
begin
  //**

  parseFirstAndLastNameFromFullname(zPersonData.name, sFirstName, sLastName);
  edLastName.text := sLastName;
  edFirstName.text := sFirstName;
  edCardID.Text := zPersonData.PersonalIdentificationId;

  edTitle.Text       := zPersonData.title;
  edSSN.Text         := zPersonData.SocialSecurityNumber;
  edNationality.Text := zPersonData.Nationality;
  edDateOfBirth.Date := zPersonData.DateOfBirth;

  edAddress1.Text  := zPersondata.Address1;
  edAddress2.Text  := zPersondata.Address2;
  edZipcode.Text   := zPersondata.Address3;
  edCity.Text      := zPersondata.Address4;
  edCountry.Text   := zPersondata.Country;

  edTel1.Text    := zPersondata.Tel1;
  edMobile.Text  := zPersondata.Tel2;
  edEmail.Text   := zPersondata.Email;

 edCompany.text        :=   zPersondata.CompanyName    ;
 edVAT.text            :=   zPersondata.CompVATNumber  ;
 edCompTelNumber.text  :=   zPersondata.CompTel        ;
 edFax.text            :=   zPersondata.CompFax        ;
 edCompEmail.text      :=   zPersondata.CompEmail      ;
 edCompAddress1.text   :=   zPersondata.CompAddress1   ;
 edCompAddress2.text   :=   zPersondata.CompAddress2   ;
 edCompZipcode.text    :=   zPersondata.CompZip        ;
 edCompCity.text       :=   zPersondata.CompCity       ;
 edCompCountry.text    :=   zPersondata.CompCountry    ;

end;

procedure TfrmEditGuest.sButton4Click(Sender: TObject);
var
  theData : recCountryHolder;
begin
  theData.Country := edCompCountry.text;
  Countries(actlookup,theData);
  if theData.country <> '' then
  begin
    edCompCountry.text := theData.Country;
    labCompCountry.caption  := theData.IslCountryName;
  end;
end;

procedure TfrmEditGuest.btnGetCountryClick(Sender: TObject);
var
  theData : recCountryHolder;
begin
  theData.Country := edCountry.text;
  Countries(actlookup,theData);
  if theData.country <> '' then
  begin
    edCountry.text := theData.Country;
    labCountry.caption  := theData.IslCountryName;
  end;
end;

procedure TfrmEditGuest.btnGetNationalityClick(Sender: TObject);
var
  theData : recCountryHolder;
begin
  theData.Country := edNationality.text;
  Countries(actlookup,theData);
  if theData.country <> '' then
  begin
    edNationality.text := theData.Country;
    labNationality.caption  := theData.IslCountryName;
  end;
end;

end.
