unit uFrmCustomerDepartmentEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, sMemo, sEdit, sLabel,
  uCustomerDepartments;


type
  TFrmCustomerDepartmentEdit = class(TForm)
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    sLabel1: TsLabel;
    edtDepartmentName: TsEdit;
    sLabel2: TsLabel;
    edtAddress1: TsEdit;
    edtAddress2: TsEdit;
    sLabel4: TsLabel;
    edtZip: TsEdit;
    sLabel5: TsLabel;
    edtCity: TsEdit;
    sLabel6: TsLabel;
    edtCountry: TsEdit;
    sLabel7: TsLabel;
    edtTelNo1: TsEdit;
    sLabel8: TsLabel;
    edtTelNo2: TsEdit;
    sLabel9: TsLabel;
    edtFax: TsEdit;
    sLabel10: TsLabel;
    edtEmailAddress: TsEdit;
    sLabel11: TsLabel;
    edtNotes: TsMemo;
    procedure FormCreate(Sender: TObject);
  private
    FCustomerDepartment: TCustomerDepartment;
    procedure SetCustomerDepartment(const Value: TCustomerDepartment);
    { Private declarations }
  public
    { Public declarations }
    procedure GetCustomerDepartment;
    property CustomerDepartment : TCustomerDepartment read FCustomerDepartment write SetCustomerDepartment;
  end;

var
  FrmCustomerDepartmentEdit: TFrmCustomerDepartmentEdit;

function EditCustomerDepartment(CustomerDepartment : TCustomerDepartment) : Boolean;


implementation

{$R *.dfm}

uses uRoomerLanguage, uAppGlobal, uUtils;

function EditCustomerDepartment(CustomerDepartment : TCustomerDepartment) : Boolean;
var _FrmCustomerDepartmentEdit: TFrmCustomerDepartmentEdit;
begin
  result := False;
  _FrmCustomerDepartmentEdit := TFrmCustomerDepartmentEdit.Create(NIL);
  try
    _FrmCustomerDepartmentEdit.CustomerDepartment := CustomerDepartment;
    if _FrmCustomerDepartmentEdit.ShowModal = mrOk then
    begin
      _FrmCustomerDepartmentEdit.GetCustomerDepartment;
      result := True;
    end;
  finally
    FreeAndNil(_FrmCustomerDepartmentEdit);
  end;
end;


{ TFrmCustomerDepartmentEdit }

procedure TFrmCustomerDepartmentEdit.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TFrmCustomerDepartmentEdit.GetCustomerDepartment;
begin
  FCustomerDepartment.DepartmentName := edtDepartmentName.Text;
  FCustomerDepartment.Address1 := edtAddress1.Text;
  FCustomerDepartment.Address2 := edtAddress2.Text;
  FCustomerDepartment.Zip := edtZip.Text;
  FCustomerDepartment.City := edtCity.Text;
  FCustomerDepartment.Country := edtCountry.Text;
  FCustomerDepartment.TelNo1 := edtTelNo1.Text;
  FCustomerDepartment.TelNo2 := edtTelNo2.Text;
  FCustomerDepartment.FaxNo := edtFax.Text;
  FCustomerDepartment.EmailAddress := edtEmailAddress.Text;
  FCustomerDepartment.Notes := edtNotes.Text;
end;

procedure TFrmCustomerDepartmentEdit.SetCustomerDepartment(const Value: TCustomerDepartment);
begin
  FCustomerDepartment := Value;

  edtDepartmentName.Text := FCustomerDepartment.DepartmentName;
  edtAddress1.Text := FCustomerDepartment.Address1;
  edtAddress2.Text := FCustomerDepartment.Address2;
  edtZip.Text := FCustomerDepartment.Zip;
  edtCity.Text := FCustomerDepartment.City;
  edtCountry.Text := FCustomerDepartment.Country;
  edtTelNo1.Text := FCustomerDepartment.TelNo1;
  edtTelNo2.Text := FCustomerDepartment.TelNo2;
  edtFax.Text := FCustomerDepartment.FaxNo;
  edtEmailAddress.Text := FCustomerDepartment.EmailAddress;
  edtNotes.Text := FCustomerDepartment.Notes;
end;

end.
