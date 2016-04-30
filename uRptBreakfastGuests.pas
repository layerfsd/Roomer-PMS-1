unit uRptBreakfastGuests;

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
  , Vcl.ExtCtrls
  , Vcl.StdCtrls


  , Data.DB
  , _glob
  , ug
  , hData
  , uUtils
  , uappGlobal


  , kbmMemTable
  , sButton
  , sLabel
  , sPanel

  , dxStatusBar
  , cxGraphics
  , cxControls
  , cxLookAndFeels
  , cxLookAndFeelPainters
  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters
  , dxSkinsdxStatusBarPainter
  , cxStyles
  , dxSkinscxPCPainter
  , cxCustomData
  , cxFilter
  , cxData
  , cxDataStorage
  , cxEdit
  , cxNavigator
  , cxDBData
  , cxGridCustomView
  , cxGridCustomTableView
  , cxGridTableView
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxClasses
  , cxGridLevel
  , cxGrid, dxSkinCaramel, dxSkinCoffee, dxSkinTheAsphaltWorld

  ;

type
  TfrmRptBreakfastGuests = class(TForm)
    Panel3: TsPanel;
    __labLocationsList: TsLabel;
    labLocations: TsLabel;
    btnRefresh: TsButton;
    dxStatusBar1: TdxStatusBar;
    Panel5: TsPanel;
    btnExcel: TsButton;
    btnReport: TsButton;
    kbmBreakfastGuests: TkbmMemTable;
    BreakfastGuestsDS: TDataSource;
    lvBreakfastGuests: TcxGridLevel;
    grBreakfastGuests: TcxGrid;
    tvBreakfastGuests: TcxGridDBBandedTableView;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    zDate : Tdate;
    zLocationInString : string;

    procedure showData;


  public
    { Public declarations }
  end;

  function RptBreakfastGuests : boolean;

var
  frmRptBreakfastGuests: TfrmRptBreakfastGuests;

implementation

{$R *.dfm}

uses
    uD
  , uRoomerLanguage
  , uDImages
  , uMain


  ;

function RptBreakfastGuests : boolean;
begin
  result := false;
  frmRptBreakfastGuests := TfrmRptBreakfastGuests.Create(frmRptBreakfastGuests);
  try
    frmRptBreakfastGuests.ShowModal;
    if frmRptBreakfastGuests.modalresult = mrOk then
    begin
      result := true;
    end
  finally
    freeandnil(frmRptBreakfastGuests);
  end;
end;

procedure TfrmRptBreakfastGuests.showData;
begin
  //**
end;



procedure TfrmRptBreakfastGuests.FormCreate(Sender: TObject);
begin
  zDate := date;

  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmRptBreakfastGuests.FormShow(Sender: TObject);
begin
  _restoreForm(frmRptBreakfastGuests);
  zLocationInString := glb.LocationSQLInString(frmmain.FilteredLocations);

  if zLocationInString = '' then
  begin
    __labLocationsList.caption := 'All Locations';
  end else
  begin
    __labLocationsList.caption := zLocationInString;
  end;

  showdata;
end;

end.
