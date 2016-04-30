unit uInvoiceLineEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Mask, sMaskEdit,
  sCustomComboEdit, sCurrEdit, Vcl.StdCtrls, sEdit, sLabel, sButton, sPanel,
  uInvoiceContainer, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxButtonEdit;

type

  TEditAction = (eaUpdate, eaNew);

  TFrmInvoiceLineEdit = class(TForm)
    sPanel1: TsPanel;
    BtnOk: TsButton;
    btnCancel: TsButton;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    edtText: TsEdit;
    sLabel3: TsLabel;
    edtNumItems: TsCalcEdit;
    sLabel4: TsLabel;
    edtPrice: TsCalcEdit;
    sPanel2: TsPanel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    edtTotal: TsCalcEdit;
    Shape1: TShape;
    edtItem: TcxButtonEdit;
    procedure edtPriceChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    InvoiceLine : TInvoiceLine;
    EditAction : TEditAction;
    InvoiceLineType : TInvoiceLineType;
    procedure AddInvoiceLine(_InvoiceLineType : TInvoiceLineType);
  public
    { Public declarations }
    procedure UpdateInvoiceLine(_InvoiceLine : TInvoiceLine);
    function GetResult : TInvoiceLine;
  end;

var
  FrmInvoiceLineEdit: TFrmInvoiceLineEdit;

function EditInvoiceItem(_InvoiceLine : TInvoiceLine) : Boolean;
function AddInvoiceItem(InvoiceLineType : TInvoiceLineType) : TInvoiceLine;


implementation

{$R *.dfm}

uses uItems2, hData, uG, uD, uRoomerLanguage, uAppGlobal, uUtils;

function EditInvoiceItem(_InvoiceLine : TInvoiceLine) : Boolean;
var _FrmInvoiceLineEdit: TFrmInvoiceLineEdit;
begin
  _FrmInvoiceLineEdit := TFrmInvoiceLineEdit.Create(nil);
  try
    _FrmInvoiceLineEdit.UpdateInvoiceLine(_InvoiceLine);
    result := _FrmInvoiceLineEdit.ShowModal = mrOk;
    if result then
    begin
      _InvoiceLine.Assign(_FrmInvoiceLineEdit.GetResult);
    end;
  finally
    FreeAndNil(_FrmInvoiceLineEdit)
  end;
end;

function AddInvoiceItem(InvoiceLineType : TInvoiceLineType) : TInvoiceLine;
var _FrmInvoiceLineEdit: TFrmInvoiceLineEdit;
begin
  _FrmInvoiceLineEdit := TFrmInvoiceLineEdit.Create(nil);
  try
    _FrmInvoiceLineEdit.AddInvoiceLine(InvoiceLineType);
    if _FrmInvoiceLineEdit.ShowModal = mrOk then
    begin
      result := TInvoiceLine.Create;
      result.Assign(_FrmInvoiceLineEdit.GetResult);
    end else
      result := nil;
  finally
    FreeAndNil(_FrmInvoiceLineEdit)
  end;
end;

{ TFrmInvoiceLineEdit }

procedure TFrmInvoiceLineEdit.edtItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var theData : recItemHolder;
begin
  if openItems(actLookup, true, theData) then
  begin
    if theData.Item <> edtItem.Text then
    begin
      edtItem.Text := theData.Item;
      edtText.Text := theData.Description;
      edtNumItems.Value := 1.00;
      edtPrice.Value := theData.Price;
    end;
  end;
end;

procedure TFrmInvoiceLineEdit.edtPriceChange(Sender: TObject);
begin
  edtTotal.Value := edtNumItems.Value * edtPrice.Value;
end;

procedure TFrmInvoiceLineEdit.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  InvoiceLine := TInvoiceLine.Create;
end;

function TFrmInvoiceLineEdit.GetResult: TInvoiceLine;
begin
  InvoiceLine.ItemCode := edtItem.Text;
  InvoiceLine.Description := edtText.Text;
  InvoiceLine.NumItems := edtNumItems.Value;
  InvoiceLine.PriceGross := edtPrice.Value;

  InvoiceLine.PriceNet := InvoiceLine.PriceGross / (1 + InvoiceLine.VatPercentage / 100);
  InvoiceLine.InvoiceLineType := InvoiceLineType;
  InvoiceLine.Dirty := True;
  InvoiceLine.isNew := EditAction = eaNew;
  result := InvoiceLine;
end;

procedure TFrmInvoiceLineEdit.UpdateInvoiceLine(_InvoiceLine: TInvoiceLine);
begin
  EditAction := eaUpdate;
  InvoiceLine.Assign(_InvoiceLine);
  InvoiceLineType := _InvoiceLine.InvoiceLineType;
  edtItem.Text := InvoiceLine.ItemCode;
  edtText.Text := InvoiceLine.Description;
  edtNumItems.Value := InvoiceLine.NumItems;
  edtPrice.Value := InvoiceLine.PriceGross;
end;

procedure TFrmInvoiceLineEdit.AddInvoiceLine(_InvoiceLineType : TInvoiceLineType);
begin
  EditAction := eaNew;
  InvoiceLineType := _InvoiceLineType;
  edtItem.Text := InvoiceLine.ItemCode;
  edtText.Text := InvoiceLine.Description;
  edtNumItems.Value := InvoiceLine.NumItems;
  edtPrice.Value := InvoiceLine.PriceGross;
end;

end.
