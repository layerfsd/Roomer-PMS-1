unit uDReportData;

interface

uses
  System.SysUtils, System.Classes, Dialogs, Data.DB, kbmMemTable;

type
  TDReportData = class(TDataModule)
    kbmUnconfirmedInvoicelines_: TkbmMemTable;
    UnconfirmedInvoicelinesDS: TDataSource;
    procedure kbmUnconfirmedInvoicelines_AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DReportData: TDReportData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDReportData.kbmUnconfirmedInvoicelines_AfterOpen(DataSet: TDataSet);
begin
//  ShowMessage('xxx');
end;

end.
