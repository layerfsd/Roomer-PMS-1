unit uFinanceForcastLayout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sMemo,
  Vcl.ExtCtrls, sPanel, sLabel, sEdit;

type
  TfrmFinanceForcast = class(TForm)
    sPanel1: TsPanel;
    memText: TsMemo;
    sButton2: TsButton;
    sButton1: TsButton;
    edDescription: TsEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edDescriptionChange(Sender: TObject);
    procedure memTextChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    zDescription : string;
    zText : string;
  end;

var
  frmFinanceForcast: TfrmFinanceForcast;

function openFinanceForcastLayout(var description,aText : string) : boolean;

implementation

{$R *.dfm}


function openFinanceForcastLayout(var description,aText : string) : boolean;
begin
  result := true;
  result := false;
  frmFinanceForcast := TfrmFinanceForcast.Create(frmFinanceForcast);
  try
    frmFinanceForcast.zDescription := description;
    frmFinanceForcast.zText := aText;
    frmFinanceForcast.ShowModal;
    if frmFinanceForcast.modalresult = mrOk then
    begin
      result := true;
      description := frmFinanceForcast.zDescription;
      aText       := frmFinanceForcast.zText;
    end else
    begin

    end;
  finally
    freeandnil(frmFinanceForcast);
  end;
end;


procedure TfrmFinanceForcast.edDescriptionChange(Sender: TObject);
begin
  zDescription := edDescription.Text;
end;

procedure TfrmFinanceForcast.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //**

end;

procedure TfrmFinanceForcast.FormCreate(Sender: TObject);
begin
   //**
   zDescription := '';
   zText := '';
end;

procedure TfrmFinanceForcast.FormShow(Sender: TObject);
begin
  //**
  edDescription.Text := zDescription;
  memText.Text := zText;

end;

procedure TfrmFinanceForcast.memTextChange(Sender: TObject);
begin
  zText := memText.Text;
end;

end.
