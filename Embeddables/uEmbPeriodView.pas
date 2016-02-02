unit uEmbPeriodView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Vcl.StdCtrls, sComboBox, sLabel;

type
  TembPeriodView = class(TForm)
    pnlEmbeddable: TsPanel;
    lblLoading: TsLabel;
    lblRoomBeingMoved: TsLabel;
    pnlViewType: TsPanel;
    cbxViewTypes: TsComboBox;
    grPeriodRooms: TAdvStringGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  embPeriodView: TembPeriodView;

implementation

{$R *.dfm}

end.
