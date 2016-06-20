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
  , hData, kbmMemTable
  ;

type

  recEditReservationExtrasHolder = record
    Reservation   : integer;
    RoomReservation: integer;
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
    mExtras: TkbmMemTable;
    mExtrasItem: TStringField;
    mExtrasRoomreservation: TIntegerField;
    mExtrasItemid: TIntegerField;
    mExtrasCount: TIntegerField;
    mExtrasPricePerItemPerDay: TFloatField;
    mExtrasFromdate: TDateTimeField;
    mExtrasToDate: TDateTimeField;
    mExtrasDescription: TStringField;
    mExtrasTotalprice: TFloatField;
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
    tvExtrasDescription: TcxGridDBColumn;
    tvExtrasCount: TcxGridDBColumn;
    tvExtrasPricePerItemPerDay: TcxGridDBColumn;
    tvExtrasFromdate: TcxGridDBColumn;
    tvExtrasToDate: TcxGridDBColumn;
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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FReservationHolder: recEditReservationExtrasHolder;
    FRoomReservation: integer;
    procedure UpdateTopPanel;
    procedure UpdateButtonsState;
    procedure UpdateDateConstraints;
    function CopyDatasetToRecItem: recItemHolder;
    function CheckAllAvailability(aUnavailableList: TStringlist): boolean;
    { Private declarations }
  public
    { Public declarations }
    property theData : recEditReservationExtrasHolder read FReservationHolder write FReservationHolder;
    /// <summary> populate the local mExtras dataset with data from the database </summary>
    procedure LoadDataFromDatabase;
  end;

///<summary>
/// Create and show Reservations extras form for editing extras in a reservationroom. <br />
///  aResDataholder contains roomreservation properties <br />
///  am_Extras is an optional dataset for exchanging selected extras for this reservation. When provided the data from
///  this dataset is used to fill the initial grid and data is copied back into this dataset on succesfull closing. <br />
///  When no dataset is provided the grid is filled with the extras defined
///  in the databse for this roomreservation. On closing the form the modified data is written directly to the database.
///</summary>
function editReservationExtras(var aResDataHolder: recEditReservationExtrasHolder; am_Extras : TdxMemData) : boolean;

implementation

{$R *.dfm}

uses
    uItems2
  , uG
  , cmpRoomerDataset
  , uDateUtils
  , DateUtils
  , uD
  , objNewReservation
  , PrjConst
  , UITypes
  ;

function editReservationExtras(var aResDataHolder: recEditReservationExtrasHolder; am_Extras : TdxMemData) : boolean;
var
  frm: TfrmReservationExtras;
  lRoomres: TnewRoomReservationItem;
  lExtrasList: TReservationExtrasList;
begin

  frm := TfrmReservationExtras.Create(nil);
  try
    frm.FRoomReservation := aResDataHolder.RoomReservation;
    frm.theData := aResDataHolder;

    if (am_Extras = nil) then
      // Load data from db
      frm.LoadDataFromDatabase
    else
      frm.mExtras.LoadFromDataSet(am_Extras, []);

    Result := frm.ShowModal = mrOk;
    if Result then
    begin
      aResDataHolder := frm.theData;


      if (am_Extras = nil) then
      begin
        with aResDataHolder do
          lRoomRes := TnewRoomReservationItem.Create(RoomReservation, Room, RoomType, '', ArrivalDate, DepartureDate, guests, 0, 0, false, 0, childrenCount, infantCount, '', '', '');
        lRoomRes.Reservation := aResDataHolder.Reservation;
        lExtrasList := TReservationExtrasList.Create(lRoomres);
        try
          lExtrasList.LoadFromDataset(frm.mExtras);
          lExtrasList.DeleteAllFromDatabase;
          lExtrasList.Post;
        finally
          lExtrasList.Free;
          lRoomRes.Free;
        end;
      end
      else
      begin
        frm.mExtras.Filtered := false;
        am_Extras.close;
        am_Extras.LoadFromDataSet(frm.mExtras);
      end;
    end;
  finally
    frm.Free;
  end;
end;

function TfrmReservationExtras.CopyDatasetToRecItem:recItemHolder;
begin
  Result.ID                    := mExtrasItemid.AsInteger;
  Result.StockItemPriceDate    := mExtrasFromdate.AsDateTime;
  Result.AvailabilityFrom      := mExtrasFromdate.AsDateTIme;
  Result.AvailabilityTo        := mExtrasToDate.AsDateTIme;
  Result.RoomReservation       := mExtrasRoomreservation.AsInteger;
end;

procedure TfrmReservationExtras.grdExtrasDBTableView1ItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  lRecItem: recItemHolder;
  lCountColumn: integer;
  dummy: boolean;
begin

  lRecItem := CopyDatasetToRecItem;

  if openItems(actLookup, true, lrecItem, [TShowItemOfType.StockItems, TShowItemOfType.ShowAvailability]) then
  begin
    if not (mExtras.State = dsInsert) then
      mExtras.Edit;
    try
      mExtrasItemid.Asinteger := lRecItem.id;
      mExtrasItem.AsString := lrecItem.Item;
      mExtrasDescription.AsString := lRecItem.Description;
      mExtrasPricePerItemPerDay.AsFloat := lRecItem.Price;
      if mExtrasCount.AsInteger = 0 then
        mExtrasCount.AsInteger := 1 ;
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
    end;

  end
  else
    if not (mExtras.State = dsInsert) then
      mExtras.Cancel;

end;

function TfrmReservationExtras.CheckAllAvailability(aUnavailableList: TStringlist): boolean;
var
  bm: TBookMark;
  lRoomRes: TnewRoomReservationItem;
  lExtras: TReservationExtrasList;
begin
  bm := mExtras.Bookmark;
  mExtras.DisableControls;
  try
    with theData do
      lRoomRes := TnewRoomReservationItem.Create(RoomReservation, Room, RoomType, '', ArrivalDate, DepartureDate, guests, 0, 0, false, 0, childrenCount, infantCount, '', '', '');
    try
      lExtras := TReservationExtrasList.Create(lRoomRes);
      try
        lExtras.LoadFromDataset(mExtras);
        Result := lExtras.IsAvailable(aUnavailableList);
      finally
        lExtras.Free;
      end;
    finally
      lRoomRes.Free;
    end;
  finally
    mExtras.Bookmark := bm;
    mExtras.EnableControls;
  end;
end;

procedure TfrmReservationExtras.LoadDataFromDatabase;
const
  cSQL =  'select  '#10 +
          '   rrs.id,  ' +
          '   rrs.stockitem as ItemID, '#10 +
          '   i.Item,  '#10 +
          '   max(rrs.Description) as description,  '#10 +
          '   rrs.Count, '#10 +
          '   max(rrs.price) as PricePerItemPerDay, '#10 +
          '   min(rrs.usedate) as Fromdate, '#10 +
          '   max(adddate(rrs.usedate, INTERVAL 1 DAY)) as ToDate'#10 +
          'from roomreservationstockitems rrs '#10 +
          'join items i on rrs.stockitem=i.id '#10 +
          'where RoomReservation = %d '#10 +
          'group by item, count ';


var
  rSet: TRoomerDataset;
begin

  rSet := CreateNewDataSet;
  try
    rSet_bySQL(rSet, Format(cSQL, [theData.RoomReservation]));
    mExtras.LoadFromDataSet(rSet, []);
  finally
    rSet.Free;
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


procedure TfrmReservationExtras.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  lUnavailList: TStringlist;
begin
  lUnavailList := TStringList.Create;
  try
    CanClose := CheckAllAvailability(lUnavailList) or
                (MessageDlg(Format(GetTranslatedText('shTx_frmReservationExtras_AddedMoreThenAvailableInPeriod'), [lUnavailList.CommaText]), mtConfirmation, mbOKCancel, 0) = mrOK);
  finally
    lUnavailList.Free;
  end;
end;

procedure TfrmReservationExtras.FormShow(Sender: TObject);
begin
  UpdateTopPanel;

  UpdateDateConstraints;

  mExtras.Open;
  mExtras.Filter := format('roomreservation=%d', [FRoomreservation]);
  mExtras.Filtered := true;
end;

end.
