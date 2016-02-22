unit uResMemos;

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
  Menus,
  StdCtrls,
  DB,
  ADODB,
  _glob,
  ug,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxDBData,
  dxmdaset,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxClasses,
  cxGridCustomView,
  cxGrid,
  cxSplitter,
  cxTextEdit,
  cxMemo,
  cxDBEdit,
  cxButtons,
  cxPC,
  cxLabel,
  ExtCtrls,
  cxPCdxBarPopupMenu,
  cxNavigator
  , uUtils
  , cmpRoomerDataSet
  , cmpRoomerConnection, dxSkinsCore, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinMcSkin, dxSkinOffice2013White,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPropertiesStore, sButton, sLabel, sPanel, Vcl.DBCtrls, Vcl.ComCtrls, sPageControl
  ;

type
  TfrmResMemos = class(TForm)
    Panel1: TsPanel;
    cxPageControl1: TsPageControl;
    tabReservation: TsTabSheet;
    tabRooms: TsTabSheet;
    Panel4: TsPanel;
    Panel5: TsPanel;
    Panel2: TsPanel;
    Panel3: TsPanel;
    cxSplitter1 : TcxSplitter;
    resDS : TDataSource;
    res_ : TRoomerDataSet;
    Panel6: TsPanel;
    cxButton1: TsButton;
    cxButton2: TsButton;
    cxButton3: TsButton;
    memPMInfo: TDBMemo;
    cxLabel1: TsLabel;
    cxLabel2: TsLabel;
    cxLabel4: TsLabel;
    cxLabel5: TsLabel;
    labArrival: TsLabel;
    labDeparture: TsLabel;
    labCustomer: TsLabel;
    labReservation: TsLabel;
    Panel7: TsPanel;
    cxSplitter2 : TcxSplitter;
    Panel8: TsPanel;
    Panel9: TsPanel;
    cxDBMemo1: TDBMemo;
    cxGrid1DBTableView1 : TcxGridDBTableView;
    cxGrid1Level1 : TcxGridLevel;
    cxGrid1 : TcxGrid;
    RrDS : TDataSource;
    RR_ : TRoomerDataSet;
    mRR : TdxMemData;
    mRRRoom : TStringField;
    mRRArrival : TDateField;
    mRRDeparture : TDateField;
    mRRGuestName : TStringField;
    mRRRoomReservation : TIntegerField;
    mRRDS : TDataSource;
    cxGrid1DBTableView1RecId : TcxGridDBColumn;
    cxGrid1DBTableView1Room : TcxGridDBColumn;
    cxGrid1DBTableView1Arrival : TcxGridDBColumn;
    cxGrid1DBTableView1Departure : TcxGridDBColumn;
    cxGrid1DBTableView1GuestName : TcxGridDBColumn;
    cxGrid1DBTableView1RoomReservation : TcxGridDBColumn;
    mRRmem : TMemoField;
    cxGrid1DBTableView1mem : TcxGridDBColumn;
    mRRRoomType : TStringField;
    cxGrid1DBTableView1RoomType : TcxGridDBColumn;
    cxLabel3: TsLabel;
    cxLabel6: TsLabel;
    cxLabel7: TsLabel;
    cxButton4: TsButton;
    cxButton5: TsButton;
    memInformation: TDBMemo;
    cxButton6: TsButton;
    cxButton7: TsButton;
    FormStore: TcxPropertiesStore;
    btnShowHidden: TsButton;
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure cxButton1Click(Sender : TObject);
    procedure cxButton2Click(Sender : TObject);
    procedure btnShowHiddenClick(Sender : TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
    zTnformationText : string;
    zPMinfoText : string;

  public
    { Public declarations }
    zReservation : integer;
  end;

var
  frmResMemos : TfrmResMemos;

implementation

uses
   uD
  ,uSqlDefinitions
  , uAppGlobal
  , hdata
  , PrjConst
  , uDImages;

{$R *.dfm}


procedure TfrmResMemos.cxButton1Click(Sender : TObject);
var
  reservation : integer;
  memTXT : string;

begin
  if (zTnformationText <> memInformation.Text) or (zPMinfoText <> memPMInfo.Text) then
  begin
    res_.Post;
  end;

  if (mRR.State = dsEdit) or (mRR.State = dsInsert) then
  begin
    mRR.Post;
  end;

  RR_.First;
  while not RR_.eof do
  begin
    reservation := RR_.FieldByName('roomreservation').AsInteger;
    if mRR.locate('roomreservation', reservation, []) then
    begin
      memTXT := mRR.FieldByName('mem').asstring;
      if memTXT <> RR_.FieldByName('HiddenInfo').asstring then
      begin
        RR_.Edit;
        RR_.FieldByName('HiddenInfo').asstring := memTXT;
        RR_.Post;
      end;
    end;
    RR_.Next;
  end;

end;

procedure TfrmResMemos.cxButton2Click(Sender : TObject);
begin
  res_.Cancel;
end;


procedure TfrmResMemos.cxButton3Click(Sender: TObject);
var
  s : string;
  selection : string;

  id : integer;
  newText : string;
begin
  selection := memInformation.SelText;
  if selection = '' then exit;
//  s := 'Move to hidden :'+#10#10+selection;
  s := GetTranslatedText('shTx_uResMemos_MoveToHidden')+#10#10+selection;
  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    memInformation.CutToClipboard;
    id := d.hiddenInfo_Exists(zReservation, 1);
    newText := ClipBoardText;
    d.hiddenInfo_Append(id,newText,zreservation);
    if (zTnformationText <> memInformation.Text) then
    begin
      res_.Post;
      zTnformationText := res_.FieldByName('information').AsString;
      res_.Edit;
    end;
  end;
end;

procedure TfrmResMemos.cxButton4Click(Sender: TObject);
var
  s : string;
  selection : string;
  id : integer;
  newText : string;
begin
  selection := memPMInfo.SelText;
  if selection = '' then exit;
 // s := 'Move to hidden :'+#10#10+selection;
   s := GetTranslatedText('shTx_uResMemos_MoveToHidden')+#10#10+selection;
  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    memPMInfo.CutToClipboard;
    id := d.hiddenInfo_Exists(zReservation, 1);
    newText := ClipBoardText;
    d.hiddenInfo_Append(id,newText,zreservation);
    if (zPMInfoText <> memPMInfo.Text) then
    begin
      res_.Post;
      zPMInfoText := res_.FieldByName('PMInfo').AsString;
      res_.Edit;
    end;
  end;
end;

procedure TfrmResMemos.cxButton6Click(Sender: TObject);
var
  s : string;
  selection : string;
  id : integer;
begin
  selection := clipBoardText;
  if selection = '' then exit;
 // s := 'Copy to hidden :'+#10#10+selection;
  s := GetTranslatedText('shTx_uResMemos_CopyToHidden')+#10#10+selection;
  if MessageDlg(s, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    id := d.hiddenInfo_Exists(zReservation, 1);
    d.hiddenInfo_Append(id,Selection,zreservation);
  end;
end;

procedure TfrmResMemos.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  // **
end;

procedure TfrmResMemos.FormCreate(Sender : TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  // **
  memInformation.DataField := 'Information';
  memPMInfo.DataField := 'PMInfo';




  zReservation := 0;
  zTnformationText := '';
  zPMinfoText := '';
end;

procedure TfrmResMemos.FormDestroy(Sender : TObject);
begin
  // **
end;

procedure TfrmResMemos.FormShow(Sender : TObject);
var
  s : string;

  sArrival : string;
  sDeparture : string;
  sCustomer : string;
  sReservarionName : string;

  dtArrival : Tdate;
  dtDeparture : Tdate;

begin
  // **
//  s := '';
//  s := s + ' Select * From Reservations ';
//  s := s + ' WHERE ';
//  s := s + ' Reservation = ' + inttostr(zReservation);

  s := format(select_ResMemos_FormShow , [zReservation]);
  // CopyToClipboard(s);
  // DebugMessage(''#10#10+s);
  hData.rSet_bySQL(res_,s);

  if not res_.eof then
  begin
    zTnformationText := res_.FieldByName('Information').asstring; ;
    zPMinfoText := res_.FieldByName('PMInfo').asstring; ;

    dtArrival := _DBDateToDate(res_.FieldByName('arrival').asstring);
    dtDeparture := _DBDateToDate(res_.FieldByName('departure').asstring);

    dateTimeToString(sArrival, 'dd.mm.yyyy - ddd', dtArrival);
    dateTimeToString(sDeparture, 'dd.mm.yyyy - ddd', dtDeparture);
    sCustomer := res_.FieldByName('customer').asstring;
    sReservarionName := res_.FieldByName('Name').asstring;

    labArrival.Caption := sArrival;
    labDeparture.Caption := sDeparture;
    labCustomer.Caption := sCustomer;
    labReservation.Caption := sReservarionName;
  end;

  res_.Edit;

//  s := '';
//  s := s + '  SELECT ';
//  s := s + '      RoomReservation ';
//  s := s + '    , Room ';
//  s := s + '    , RoomType ';
//  s := s + '    , Status ';
//  s := s + '    , Reservation ';
//  s := s + '    , rrArrival ';
//  s := s + '    , rrDeparture ';
//  s := s + '    , HiddenInfo ';
//  s := s + ' FROM ';
//  s := s + '  RoomReservations ';
//  s := s + ' WHERE (Reservation = ' + inttostr(zReservation) + ') ';
//  s := s + ' ORDER BY RoomReservation ';

  s := format(select_ResMemos_FormShow2 , [zReservation]);
  // CopyToClipboard(s);
  // DebugMessage(''#10#10+s);
  hData.rSet_bySQL(rr_,s);

  if mRR.active then mRR.Close;
  mRR.Open;

  while not RR_.eof do
  begin
    mRR.Append;
    mRR.FieldByName('Room').asstring := RR_.FieldByName('Room').asstring;
    mRR.FieldByName('RoomType').asstring := RR_.FieldByName('RoomType').asstring;
    mRR.FieldByName('Arrival').AsDateTime := RR_.FieldByName('rrArrival').AsDateTime;
    mRR.FieldByName('Departure').AsDateTime := RR_.FieldByName('rrDeparture').AsDateTime;
    mRR.FieldByName('RoomReservation').AsInteger := RR_.FieldByName('RoomReservation').AsInteger;
    mRR.FieldByName('mem').asstring := RR_.FieldByName('HiddenInfo').asstring;
    mRR.FieldByName('GuestName').asstring := d.RR_GetFirstGuestName(RR_.FieldByName('RoomReservation').AsInteger);
    mRR.Post;
    RR_.Next;
  end;
end;



procedure TfrmResMemos.btnShowHiddenClick(Sender : TObject);
begin
  g.openHiddenInfo(zReservation,1);
end;

end.
