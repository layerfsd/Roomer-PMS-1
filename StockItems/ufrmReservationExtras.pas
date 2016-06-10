unit ufrmReservationExtras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  Vcl.StdCtrls, sLabel, sGroupBox, dxmdaset, sButton, sPanel, Vcl.ComCtrls, sStatusBar, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, cxCalc,
  cxCurrencyEdit, cxCalendar, cxButtonEdit, cxTextEdit
  , hData
  ;

type

  recEditReservationExtrasHolder = record
    isCreateRes   : boolean;
    Room          : string;
    RoomType      : string;
    currency      : string;
    currencyRate  : double;
    guests        : integer;
    childrenCount : integer;
    infantCount   : integer;
    ArrivalDate   : TDateTime;
    DepartureDate : TDateTime;
  end;


  TfrmReservationExtras = class(TForm)
    pnlTop: TPanel;
    tvExtras: TcxGridDBTableView;
    grdExtrasLevel1: TcxGridLevel;
    grdExtras: TcxGrid;
    sbMain: TsStatusBar;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    mExtras: TdxMemData;
    mExtrasRoomreservation: TIntegerField;
    mExtrasItemid: TIntegerField;
    mExtrasCount: TIntegerField;
    mExtrasPricePerItemPerDay: TFloatField;
    mExtrasFromdate: TDateTimeField;
    mExtrasToDate: TDateTimeField;
    mExtrasDS: TDataSource;
    sGroupBox1: TsGroupBox;
    clabRoom: TsLabel;
    clabRomType: TsLabel;
    cLabCurrency: TsLabel;
    cLabAdults: TsLabel;
    cLabChildren: TsLabel;
    cLabInfants: TsLabel;
    labRoom: TsLabel;
    labRoomType: TsLabel;
    labCurrency: TsLabel;
    labAdults: TsLabel;
    labChildren: TsLabel;
    labInfants: TsLabel;
    mExtrasDescription: TStringField;
    tvExtrasDescription: TcxGridDBColumn;
    tvExtrasCount: TcxGridDBColumn;
    tvExtrasPricePerItemPerDay: TcxGridDBColumn;
    tvExtrasFromdate: TcxGridDBColumn;
    tvExtrasToDate: TcxGridDBColumn;
    mExtrasItem: TStringField;
    tvExtrasItem: TcxGridDBColumn;
    tvExtrasTotalPrice: TcxGridDBColumn;
    clabArrival: TsLabel;
    clabDeparture: TsLabel;
    labArrival: TsLabel;
    labDeparture: TsLabel;
    clabNights: TsLabel;
    labNights: TsLabel;
    pnlTopButtons: TPanel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    mExtrasTotalprice: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure grdExtrasDBTableView1ItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mExtrasNewRecord(DataSet: TDataSet);
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure mExtrasDSDataChange(Sender: TObject; Field: TField);
    procedure btnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure mExtrasBeforePost(DataSet: TDataSet);
    procedure btnEditClick(Sender: TObject);
    procedure mExtrasCalcFields(DataSet: TDataSet);
  private
    FReservationHolder: recEditReservationExtrasHolder;
    FRoomReservation: integer;
    procedure UpdateTopPanel;
    procedure UpdateButtonsState;
    procedure UpdateDateConstraints;
    function CopyDatasetToRecItem: recItemHolder;
    { Private declarations }
  public
    { Public declarations }
    property theData : recEditReservationExtrasHolder read FReservationHolder write FReservationHolder;
  end;

function editReservationExtras(aRoomreservation: integer; var aResDataHolder: recEditReservationExtrasHolder; var m_ : TdxMemData) : boolean;

implementation

{$R *.dfm}

uses
    uItems2
  , uG
  , uDateUtils
  , DateUtils
  ;

function editReservationExtras(aRoomreservation: integer; var aResDataHolder: recEditReservationExtrasHolder; var m_ : TdxMemData) : boolean;
var
  frm: TfrmReservationExtras;
begin

  frm := TfrmReservationExtras.Create(nil);
  try
    frm.FRoomReservation := aRoomreservation;
    frm.theData := aResDataHolder;
    frm.mExtras.LoadFromDataSet(m_);

    Result := frm.ShowModal = mrOk;
    if Result then
    begin
      aResDataHolder := frm.theData;
      m_.close;
      m_.LoadFromDataSet(frm.mExtras);
    end;
  finally
    frm.Free;
  end;
end;

function TfrmReservationExtras.CopyDatasetToRecItem:recItemHolder;
begin
  Result.ID                    := mExtrasItemid.AsInteger;
  Result.StockItemPriceDate    := mExtrasFromdate.AsDateTime;
end;

procedure TfrmReservationExtras.grdExtrasDBTableView1ItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  lRecItem: recItemHolder;
  lCountColumn: integer;
  dummy: boolean;
begin

  lRecItem := CopyDatasetToRecItem;

  if openItems(actLookup, true, lrecItem, [TShowItemOfType.StockItems]) then
  begin
    if not (mExtras.State = dsInsert) then
      mExtras.Edit;
    try
      mExtrasItemid.Asinteger := lRecItem.id;
      mExtrasItem.AsString := lrecItem.Item;
      mExtrasDescription.AsString := lRecItem.Description;
      mExtrasPricePerItemPerDay.AsFloat := lRecItem.Price;
      mExtras.Post;
    except
      mExtras.Cancel;
      raise;
    end;

    // move focus to count column
    with tvExtras do
    begin
      lCountColumn := getcolumnbyfieldname('Count').index;
      datacontroller.focuscontrol(lCountColumn, dummy);
      mExtras.Edit;
    end;

  end;
end;

procedure TfrmReservationExtras.mExtrasBeforePost(DataSet: TDataSet);
begin
  if mExtrasToDate.AsDateTime < mExtrasFromdate.AsDateTime then
    mExtrasToDate.AsDateTime := mExtrasFromdate.AsDateTime + 1;
end;

procedure TfrmReservationExtras.mExtrasCalcFields(DataSet: TDataSet);
begin
  mExtrasTotalprice.AsFloat := mExtrasPricePerItemPerDay.AsFloat * mExtrasCount.AsInteger * DaysBetween(mExtrasFromDate.AsDateTime, mExtrasToDate.AsDateTime);
end;

procedure TfrmReservationExtras.mExtrasDSDataChange(Sender: TObject; Field: TField);
begin
  UpdateButtonsState;
end;

procedure TfrmReservationExtras.UpdateButtonsState;
begin
  btnInsert.Enabled := mExtras.Active;
  btnDelete.Enabled := mExtras.Active and (mExtras.RecordCount > 0);
  btnEdit.Enabled := mExtras.Active and (mExtras.RecordCount > 0);
end;

procedure TfrmReservationExtras.mExtrasNewRecord(DataSet: TDataSet);
begin
  mExtrasRoomreservation.AsInteger := FRoomReservation;
  mExtrasFromdate.AsDateTime := FReservationHolder.ArrivalDate;
  mExtrasToDate.AsDateTime := FReservationHolder.DepartureDate;
end;

procedure TfrmReservationExtras.UpdateTopPanel;
begin
  labRoom.Caption := FReservationHolder.Room;
  labRoomType.Caption := FReservationHolder.RoomType;
  labCurrency.Caption := FReservationHolder.currency;

  labArrival.Caption := RoomerDateToString(FReservationHolder.ArrivalDate);
  labDeparture.Caption := RoomerDateToString(FReservationHolder.DepartureDate);
  labNights.Caption := IntToStr(DaysBetween(FReservationHolder.ArrivalDate, FReservationHolder.DepartureDate));

  labAdults.Caption := IntToStr(FReservationHolder.guests);
  labChildren.Caption := IntToStr(FReservationHolder.childrenCount);
  labInfants.Caption := IntToStr(FReservationHolder.infantCount);
end;

procedure TfrmReservationExtras.btAddClick(Sender: TObject);
begin
  if mExtras.State in [dsEdit, dsInsert] then
    mExtras.post;
  mExtras.Insert;

  grdExtrasDBTableView1ItemPropertiesButtonClick(nil, 0);
end;

procedure TfrmReservationExtras.btDeleteClick(Sender: TObject);
begin
  if mExtras.State in [dsEdit, dsInsert] then
    mExtras.Cancel
  else
    mExtras.Delete;
end;

procedure TfrmReservationExtras.btnOKClick(Sender: TObject);
begin
  if mExtras.State in [dsEdit, dsInsert] then
    mExtras.Post;
end;

procedure TfrmReservationExtras.btnCancelClick(Sender: TObject);
begin
  if mExtras.State in [dsEdit, dsInsert] then
    mExtras.Cancel;
end;

procedure TfrmReservationExtras.btnEditClick(Sender: TObject);
begin
  mExtras.Edit;
end;

procedure TfrmReservationExtras.UpdateDateConstraints;
begin
  TcxDateEditProperties(tvExtrasFromdate.properties).MinDate := FReservationHolder.ArrivalDate;
  TcxDateEditProperties(tvExtrasFromdate.properties).MaxDate := FReservationHolder.DepartureDate - 1;
  TcxDateEditProperties(tvExtrasToDate.properties).MinDate := FReservationHolder.ArrivalDate + 1;
  TcxDateEditProperties(tvExtrasToDate.properties).MaxDate := FReservationHolder.DepartureDate;
end;


procedure TfrmReservationExtras.FormShow(Sender: TObject);
begin
  UpdateTopPanel;

  UpdateDateConstraints;
  mExtras.Open;
end;

end.
