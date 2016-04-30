unit uFrmRBEContainer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, uDImages, hData,
  Vcl.Buttons, sSpeedButton,
  PngImage, dxGDIPlusClasses, Vcl.StdCtrls, sLabel, sButton, Vcl.ComCtrls,
  sPageControl, sComboBox, sTabControl;

type

  TRBEWindowType = (rwRoomTypeGroups = 0,
                    rwRoomTypes = 1,
                    rwCountries = 2,
                    rwCurrencies = 3,
                    rwTaxes = 4,
                    rwEmailResource = 5,
                    rwPreferences = 6,
                    rwAvailabilityAndRate = 7,
                    rwReportReservations = 8);

  TFrmRBEContainer = class(TForm)
    pnlRBEContainer: TsPanel;
    pcPages: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    sButton2: TsButton;
    sLabelFX3: TsLabelFX;
    sLabelFX2: TsLabelFX;
    btnCountries: TsButton;
    sLabelFX4: TsLabelFX;
    btnCurrencies: TsButton;
    sLabelFX5: TsLabelFX;
    sTabSheet4: TsTabSheet;
    btnEmailTemplates: TsButton;
    sLabelFX6: TsLabelFX;
    sLabelFX7: TsLabelFX;
    sLabelFX1: TsLabelFX;
    sButton5: TsButton;
    sLabelFX8: TsLabelFX;
    sPanel1: TsPanel;
    btnAbout: TsButton;
    btnTaxes: TsButton;
    sLabelFX9: TsLabelFX;
    sLabelFX10: TsLabelFX;
    btnAvailabilityAndRates: TsButton;
    sLabelFX11: TsLabelFX;
    sPanel2: TsPanel;
    __lblUsername: TsLabel;
    lblLogout: TsLabel;
    __cbxHotels: TsComboBox;
    Image1: TImage;
    sTabSheet5: TsTabSheet;
    sLabelFX12: TsLabelFX;
    pnlForm: TsPanel;
    btnUserSettings: TsButton;
    sLabelFX13: TsLabelFX;
    lblHeader: TsLabelFX;
    sTabSheet6: TsTabSheet;
    btnReservations: TsButton;
    sLabelFX14: TsLabelFX;
    sLabelFX15: TsLabelFX;
    tabWindows: TsPageControl;
    procedure btnRoomTypesClick(Sender: TObject);
    procedure btnRoomTypeGroupsClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAboutClick(Sender: TObject);
    procedure btnAvailabilityAndRatesClick(Sender: TObject);
    procedure btnCountriesClick(Sender: TObject);
    procedure btnCurrenciesClick(Sender: TObject);
    procedure btnTaxesClick(Sender: TObject);
    procedure btnEmailTemplatesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblLogoutClick(Sender: TObject);
    procedure btnUserSettingsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnReservationsClick(Sender: TObject);
    procedure tabWindowsChange(Sender: TObject);
  private
    procedure BringInToView(newWt: TRBEWindowType);
    procedure CheckforOpenWindow(nextTo: Integer);
    function FindWindowType(Sender: TObject): TRBEWindowType;
    procedure CreateWindowTabs;
    procedure CreateWindowCaptions;
    procedure CreateUserLabelAndHotelList;
    { Private declarations }
  public
    { Public declarations }
    procedure WindowCloseEvent(Sender: TObject);
    procedure TranslateOpenRBEForms;
  end;

var
  FrmRBEContainer: TFrmRBEContainer;
  RBEWindowTypes : Array [rwRoomTypeGroups .. rwReportReservations] of Boolean;
  RBEWindowNames : Array [rwRoomTypeGroups .. rwReportReservations] of String;

implementation

{$R *.dfm}

uses uRoomTypes2, uRoomTypesGroups2, uAboutRoomer, uChannelAvailabilityManager,
  uFrmResources, uCountries, uCurrencies, uTaxes, uTaxCalc, uMain, uG, uD, uUtils,
  uFrmRbePreferences, uRptReservations,
  uRoomerLanguage, uResourceManagement
  ;

procedure TFrmRBEContainer.CheckforOpenWindow(nextTo : Integer);
var i, index : Integer;
begin
  index := -1;
  for i := nextTo + 1 to tabWindows.PageCount - 1 do
    if tabWindows.Pages[i].TabVisible then
    begin
      index := i;
      Break;
    end;
  if index = -1 then
    for i := nextTo - 1 downto 0 do
      if tabWindows.Pages[i].TabVisible then
      begin
        index := i;
        Break;
      end;
  if index > -1 then
  begin
    tabWindows.ActivePageIndex := index;
    BringInToView(TRBEWindowType(index));
  end;
end;


function TFrmRBEContainer.FindWindowType(Sender : TObject) : TRBEWindowType;
begin
  if Sender IS TfrmRoomTypesGroups2 then
    result := rwRoomTypeGroups
  else
  if Sender IS TfrmRoomTypes2 then
    result := rwRoomTypes
  else
  if Sender IS TfrmCountries then
    result := rwCountries
  else
  if Sender IS TfrmCurrencies then
    result := rwCurrencies
  else
  if Sender IS TfrmTaxes then
    result := rwTaxes
  else
  if Sender IS TFrmResources then
    result := rwEmailResource
  else
  if Sender IS TfrmRbePreferences then
    result := rwPreferences
  else
  if Sender IS TfrmChannelAvailabilityManager then
    result := rwAvailabilityAndRate
  else
//  if Sender IS TfrmRptReservations then
    result := rwReportReservations
end;

procedure TFrmRBEContainer.WindowCloseEvent(Sender: TObject);
var wt : TRBEWindowType;
begin
  pcPages.Enabled := True;
  wt := FindWindowType(Sender);
  case wt of
    rwRoomTypeGroups: frmRoomTypesGroups2X := nil;
    rwRoomTypes: frmRoomTypes2X := nil;
    rwCountries: frmCountriesX := nil;
    rwCurrencies: frmCurrenciesX := nil;
    rwTaxes: frmTaxesX := nil;
    rwEmailResource: FrmResourcesX := nil;
    rwPreferences: frmRbePreferencesX := nil;
    rwAvailabilityAndRate: frmChannelAvailabilityManagerX := nil;
    rwReportReservations: frmRptReservationsX := nil;
  end;

  RBEWindowTypes[wt] := False;
  tabWindows.Pages[ORD(wt)].TabVisible := False;
  CheckforOpenWindow(ORD(wt));

  if wt = rwTaxes then
    initializeTaxes;

  lblHeader.Caption := '';
end;

procedure TFrmRBEContainer.BringInToView(newWt : TRBEWindowType);
var
  theRoomTypeGroupHolder: recRoomTypeGroupHolder;
  theRoomTypesHolder: recRoomTypeHolder;
  theTaxesHolder: recTaxesHolder;
  theCountriesHolder: recCountryHolder;
  theCurrencyHolder: recCurrencyHolder;

  ResourceParameters: THtmlResourceParameters;
begin
  if RBEWindowTypes[rwPreferences] then
    frmRbePreferencesX.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwAvailabilityAndRate] then
    frmChannelAvailabilityManagerX.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwReportReservations] then
    frmRptReservationsX.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwEmailResource] then
    FrmResourcesX.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwRoomTypes] then
    frmRoomTypes2X.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwTaxes] then
    frmTaxesX.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwCurrencies] then
    frmCurrenciesX.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwCountries] then
    frmCountriesX.pnlHolder.Parent := nil;
  if RBEWindowTypes[rwRoomTypeGroups] then
    frmRoomTypesGroups2X.pnlHolder.Parent := nil;


  case newWt of
    rwRoomTypeGroups: if RBEWindowTypes[rwRoomTypeGroups] then
                        frmRoomTypesGroups2X.pnlHolder.Parent := pnlForm
                      else
                        openRoomTypeGroups(actNone, theRoomTypeGroupHolder, pnlForm, WindowCloseEvent);
    rwRoomTypes:      if RBEWindowTypes[rwRoomTypes] then
                        frmRoomTypes2X.pnlHolder.Parent := pnlForm
                      else
                        openRoomTypes(actNone, theRoomTypesHolder, pnlForm, WindowCloseEvent);
    rwCountries:      if RBEWindowTypes[rwCountries] then
                        frmCountriesX.pnlHolder.Parent := pnlForm
                      else
                        Countries(actNone, theCountriesHolder, pnlForm, WindowCloseEvent);
    rwCurrencies:     if RBEWindowTypes[rwCurrencies] then
                        frmCurrenciesX.pnlHolder.Parent := pnlForm
                      else
                        Currencies(actNone, theCurrencyHolder, pnlForm, WindowCloseEvent);
    rwTaxes:          if RBEWindowTypes[rwTaxes] then
                        frmTaxesX.pnlHolder.Parent := pnlForm
                      else
                        Taxes(actNone, theTaxesHolder, pnlForm, WindowCloseEvent);
    rwEmailResource:  if RBEWindowTypes[rwEmailResource] then
                        FrmResourcesX.pnlHolder.Parent := pnlForm
                      else
                      begin
                        ResourceParameters := THtmlResourceParameters.Create;
                        StaticResources('Confirmation Email Templates', GUEST_EMAIL_TEMPLATE,
                          ACCESS_OPEN, ResourceParameters, pnlForm, WindowCloseEvent);
                      end;
    rwPreferences:    if RBEWindowTypes[rwPreferences] then
                        frmRbePreferencesX.pnlHolder.Parent := pnlForm
                      else
                        OpenRbePREferences(pnlForm, WindowCloseEvent);

    rwAvailabilityAndRate: if RBEWindowTypes[rwAvailabilityAndRate] then
                             frmChannelAvailabilityManagerX.pnlHolder.Parent := pnlForm
                           else
                             ShowChannelAvailabilityManager(pnlForm, WindowCloseEvent);
    rwReportReservations: if RBEWindowTypes[rwReportReservations] then
                             frmRptReservationsX.pnlHolder.Parent := pnlForm
                           else
                             OpenReportReservations(pnlForm, WindowCloseEvent);
  end;
  pnlForm.Update;
  RBEWindowTypes[newWt] := True;
//  DebugMessage(inttostr(ORD(newWt)) +  ' / ' + inttostr(tabWindows.PageCount));
  tabWindows.Pages[ORD(newWt)].TabVisible := True;
  tabWindows.ActivePAgeIndex := ORD(newWt);
  lblHeader.Caption := RBEWindowNames[newWt];
end;

procedure TFrmRBEContainer.btnAvailabilityAndRatesClick(Sender: TObject);
begin
  BringInToView(rwAvailabilityAndRate);
end;

procedure TFrmRBEContainer.btnCountriesClick(Sender: TObject);
begin
  BringInToView(rwCountries);
end;

procedure TFrmRBEContainer.btnCurrenciesClick(Sender: TObject);
begin
  BringInToView(rwCurrencies);
end;

procedure TFrmRBEContainer.btnEmailTemplatesClick(Sender: TObject);
begin
  BringInToView(rwEmailResource);
end;

procedure TFrmRBEContainer.btnReservationsClick(Sender: TObject);
begin
  BringInToView(rwReportReservations);
end;

procedure TFrmRBEContainer.btnRoomTypeGroupsClick(Sender: TObject);
begin
  BringInToView(rwRoomTypeGroups);
end;

procedure TFrmRBEContainer.btnRoomTypesClick(Sender: TObject);
begin
  BringInToView(rwRoomTypes);
end;

procedure TFrmRBEContainer.btnTaxesClick(Sender: TObject);
begin
  BringInToView(rwTaxes);
end;

procedure TFrmRBEContainer.btnUserSettingsClick(Sender: TObject);
begin
  BringInToView(rwPreferences);
end;

procedure TFrmRBEContainer.CreateWindowTabs;
var
  wt: TRBEWindowType;
  sheet : TsTabSheet;
begin
  for wt := rwRoomTypeGroups to rwReportReservations do
  begin
    RBEWindowTypes[wt] := False;
    sheet:=TsTabSheet.Create(tabWindows);
    sheet.PageControl := tabWindows;
    sheet.TabVisible := False;
    sheet.Name:='ActiveFormSheet'+IntToStr(tabWindows.PageCount);
    sheet.Caption:=RBEWindowNames[wt];
  end;
  tabWindows.OnChange := tabWindowsChange;
end;

procedure TFrmRBEContainer.CreateWindowCaptions;
begin
  RBEWindowNames[rwRoomTypeGroups] := 'Rate Codes';
  RBEWindowNames[rwRoomTypes] := 'Room Types';
  RBEWindowNames[rwCountries] := 'Countries';
  RBEWindowNames[rwCurrencies] := 'Currencies';
  RBEWindowNames[rwTaxes] := 'Taxes';
  RBEWindowNames[rwEmailResource] := 'Email Templates';
  RBEWindowNames[rwPreferences] := 'User Settings';
  RBEWindowNames[rwAvailabilityAndRate] := 'Availability && Rates';
  RBEWindowNames[rwReportReservations] := 'Reservation Report';
end;

procedure TFrmRBEContainer.CreateUserLabelAndHotelList;
var
  i, iActiveHotel: Integer;
begin
  __lblUsername.Caption := frmMain.__lblUsername.Caption;

  try
    iActiveHotel := 0;
    __cbxHotels.Items.BeginUpdate;
    __cbxHotels.Items.Clear;
    if d.roomerMainDataSet.hotels.Count = 0 then
    begin
      __cbxHotels.Items.AddObject(format('%s - %s',
        [UpperCase(d.roomerMainDataSet.hotelId), g.qHotelName]), nil);
    end
    else
    begin
      for i := 0 to d.roomerMainDataSet.hotels.Count - 1 do
      begin
        __cbxHotels.Items.AddObject
          (format('%s - %s',
          [UpperCase(d.roomerMainDataSet.hotels[i].hotelCode),
          d.roomerMainDataSet.hotels[i].hotelName]),
          d.roomerMainDataSet.hotels[i]);
        if LowerCase(d.roomerMainDataSet.hotels[i].hotelCode)
          = LowerCase(d.roomerMainDataSet.hotelId) then
          iActiveHotel := i;
      end;
    end;
    __cbxHotels.ItemIndex := iActiveHotel;
  finally
    __cbxHotels.Items.endUpdate;
  end;
  __cbxHotels.OnCloseUp := frmMain.__cbxHotelsCloseUp;
end;


procedure TFrmRBEContainer.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  pcPages.ActivePageIndex := 0;

  CreateWindowCaptions;
  CreateWindowTabs;
  CreateUserLabelAndHotelList;
end;

procedure TFrmRBEContainer.TranslateOpenRBEForms;
begin
  RoomerLanguage.TranslateThisForm(self);
  if RBEWindowTypes[rwPreferences] then
  begin
    RoomerLanguage.TranslateThisForm(frmRbePreferencesX);
  end;
  if RBEWindowTypes[rwAvailabilityAndRate] then
  begin
    RoomerLanguage.TranslateThisForm(frmChannelAvailabilityManagerX);
  end;
  if RBEWindowTypes[rwReportReservations] then
  begin
    RoomerLanguage.TranslateThisForm(frmRptReservationsX);
  end;
  if RBEWindowTypes[rwEmailResource] then
  begin
    RoomerLanguage.TranslateThisForm(FrmResourcesX);
  end;
  if RBEWindowTypes[rwRoomTypes] then
  begin
    RoomerLanguage.TranslateThisForm(frmRoomTypes2X);
  end;
  if RBEWindowTypes[rwTaxes] then
  begin
    RoomerLanguage.TranslateThisForm(frmTaxesX);
  end;
  if RBEWindowTypes[rwCurrencies] then
  begin
    RoomerLanguage.TranslateThisForm(frmCurrenciesX);
  end;
  if RBEWindowTypes[rwCountries] then
  begin
    RoomerLanguage.TranslateThisForm(frmCountriesX);
  end;
  if RBEWindowTypes[rwRoomTypeGroups] then
  begin
    RoomerLanguage.TranslateThisForm(frmRoomTypesGroups2X);
  end;
end;

procedure TFrmRBEContainer.FormDestroy(Sender: TObject);
begin
  if RBEWindowTypes[rwPreferences] then
  begin
    frmRbePreferencesX.btnClose.Click;
    FreeAndNil(frmRbePreferencesX);
  end;
  if RBEWindowTypes[rwAvailabilityAndRate] then
  begin
    frmChannelAvailabilityManagerX.btnClose.Click;
    FreeAndNil(frmChannelAvailabilityManagerX);
  end;
  if RBEWindowTypes[rwReportReservations] then
  begin
    frmRptReservationsX.btnCloseClick(nil);
    FreeAndNil(frmRptReservationsX);
  end;
  if RBEWindowTypes[rwEmailResource] then
  begin
    FrmResourcesX.btnCloseClick(nil);
    FreeAndNil(FrmResourcesX);
  end;
  if RBEWindowTypes[rwRoomTypes] then
  begin
    frmRoomTypes2X.btnClose.Click;
    FreeAndNil(frmRoomTypes2X);
  end;
  if RBEWindowTypes[rwTaxes] then
  begin
    frmTaxesX.btnClose.Click;
    FreeAndNil(frmTaxesX);
  end;
  if RBEWindowTypes[rwCurrencies] then
  begin
    frmCurrenciesX.btnClose.Click;
    FreeAndNil(frmCurrenciesX);
  end;
  if RBEWindowTypes[rwCountries] then
  begin
    frmCountriesX.btnClose.Click;
    FreeAndNil(frmCountriesX);
  end;
  if RBEWindowTypes[rwRoomTypeGroups] then
  begin
    frmRoomTypesGroups2X.btnClose.Click;
    FreeAndNil(frmRoomTypesGroups2X);
  end;
end;

procedure TFrmRBEContainer.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TImage(Sender).Stretch := True;
end;

procedure TFrmRBEContainer.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TImage(Sender).Stretch := False;
end;

procedure TFrmRBEContainer.lblLogoutClick(Sender: TObject);
begin
  frmMain.btnLogOutClick(nil);
end;

procedure TFrmRBEContainer.btnAboutClick(Sender: TObject);
begin
  ShowRoomerAboutBox;
end;

procedure TFrmRBEContainer.tabWindowsChange(Sender: TObject);
begin
  BringInToView(TRBEWindowType(tabWindows.ActivePageIndex));
end;

end.
