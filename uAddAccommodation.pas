unit uAddAccommodation;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  Menus,
  StdCtrls,
  Vcl.Mask,

  _Glob,
  uAppGlobal,

  sMaskEdit,
  sCustomComboEdit,
  sCurrEdit,
  sPanel,
  sLabel,
  sEdit,
  sSpinEdit,
  sButton,

  cxClasses,
  cxPropertiesStore
  ;

type
  TfrmAddAccommodation = class(TForm)
    edPersons: TsSpinEdit;
    cxLabel1: TsLabel;
    cxLabel2: TsLabel;
    edNights: TsSpinEdit;
    cxLabel3: TsLabel;
    edRooms: TsSpinEdit;
    cxLabel4: TsLabel;
    FormStore: TcxPropertiesStore;
    sPanel1: TsPanel;
    edRoomPrice: TsCalcEdit;
    BtnOk: TsButton;
    btnCancel: TsButton;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure btnOKClick(Sender : TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    zPersons : integer;
    zNights : integer;
    zRooms : integer;
    zRoomPrice : double;

  end;

var
  frmAddAccommodation : TfrmAddAccommodation;

implementation

{$R *.dfm}

uses
    uRoomerLanguage
  , uDImages
  , uMain;

procedure TfrmAddAccommodation.btnOKClick(Sender : TObject);
begin
  zPersons := edPersons.Value;
  zNights := edNights.Value;
  zRooms := edRooms.Value;
  zRoomPrice := edRoomPrice.value;
end;

procedure TfrmAddAccommodation.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);

  // **
  zPersons := 1;
  zNights := 1;
  zRooms := 1;
  zRoomPrice := 0.00;
end;

procedure TfrmAddAccommodation.FormShow(Sender : TObject);
begin
//  _restoreForm(frmAddAccommodation);
  edPersons.Value := zPersons;
  edNights.Value := zNights;
  edRooms.Value := zRooms;
  edRoomPrice.value := zRoomPrice;
  edRoomprice.SetFocus;
end;

end.
