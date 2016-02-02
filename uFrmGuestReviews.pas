unit uFrmGuestReviews;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, Vcl.ComCtrls, sListView;

type
  TForm6 = class(TForm)
    sPanel1: TsPanel;
    btnDelete: TsButton;
    btnClose: TsButton;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnRefresh: TsButton;
    sListView1: TsListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

end.
