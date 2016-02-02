unit uAlertEditPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, uAlerts, Vcl.ComCtrls, sListView, Vcl.StdCtrls, sButton, uFrmAlertEdit;

type
  TFrmAlertPanel = class(TForm)
    pnlAlertsHolder: TsPanel;
    sPanel8: TsPanel;
    btnInsert: TsButton;
    btnEdit: TsButton;
    btnDelete: TsButton;
    lvAlerts: TsListView;

    procedure btnEditClick(Sender: TObject);
    procedure ListAlerts(AlertList : TAlertList; lv : TsListView);
    procedure btnInsertClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvAlertsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    AlertList : TAlertList;
  public
    { Public declarations }
    procedure PlaceEditPanel(_Control : TWinControl; _AlertList : TAlertList);
  end;

var
  FrmAlertPanel: TFrmAlertPanel;

implementation

{$R *.dfm}

uses uRoomerLanguage, uAppGlobal;

procedure TFrmAlertPanel.btnDeleteClick(Sender: TObject);
var Alert : TAlert;
begin
  Alert := AlertList.Alerts[Integer(lvAlerts.Selected.Data)];
  Alert.Delete;
  AlertList.Alerts.Remove(Alert);
  Alert.Free;

  ListAlerts(AlertList, lvAlerts);
end;

procedure TFrmAlertPanel.btnEditClick(Sender: TObject);
var Alert : TAlert;
begin
  if lvAlerts.Selected = nil then exit;

  Alert := AlertList.Alerts[Integer(lvAlerts.Selected.Data)];
  if EditAlert(Alert) then
  begin
    ListAlerts(AlertList, lvAlerts);
  end else
    Alert.Free;
end;

procedure TFrmAlertPanel.ListAlerts(AlertList : TAlertList; lv : TsListView);
var i, index: Integer;
    lvi : TListItem;
begin
  index := 0;
  if lv.Selected <> nil then
    index := lv.Items.IndexOf(lv.Selected);
  lv.Items.Clear;
  for i := 0 to AlertList.Count - 1 do
  begin
    lvi := lv.Items.Add;
    lvi.Caption := AlertTypeToDescriptiveString(AlertList.Alerts[i].AlertMomentType);
    lvi.SubItems.Add(AlertList.Alerts[i].AlertText);
    lvi.Data := Pointer(i);
  end;

  if (index < lv.Items.Count) AND (index >= 0) then
    lv.Selected := lv.Items[index];
end;

procedure TFrmAlertPanel.lvAlertsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnEdit.Enabled := Assigned(lvAlerts.Selected);
  btnDelete.Enabled := Assigned(lvAlerts.Selected);
end;

procedure TFrmAlertPanel.PlaceEditPanel(_Control: TWinControl; _AlertList: TAlertList);
begin
  AlertList := _AlertList;
  pnlAlertsHolder.Parent := _Control;
  ListAlerts(AlertList, lvAlerts);
end;

procedure TFrmAlertPanel.btnInsertClick(Sender: TObject);
var Alert : TAlert;
begin
  Alert := AlertList.CreateEmptyAlert;
  if AddAlert(Alert) then
  begin
    AlertList.Add(Alert);
    ListAlerts(AlertList, lvAlerts);
  end else
    Alert.Free;
end;


procedure TFrmAlertPanel.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
end;

end.
