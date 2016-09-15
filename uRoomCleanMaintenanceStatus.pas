unit uRoomCleanMaintenanceStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cmpRoomerDataSet, Vcl.StdCtrls, sEdit, sRadioButton, sLabel, Vcl.ExtCtrls, sPanel, sButton, sMemo;

type
  TfrmRoomCleanMaintenanceStatus = class(TForm)
    Label1: TsLabel;
    cbxC: TsRadioButton;
    cbxU: TsRadioButton;
    cbxO: TsRadioButton;
    edtC: TsEdit;
    edtU: TsEdit;
    edtO: TsEdit;
    cbxS: TsRadioButton;
    cbxF: TsRadioButton;
    cbxW: TsRadioButton;
    edtS: TsEdit;
    edtF: TsEdit;
    edtW: TsEdit;
    cbxR: TsRadioButton;
    cbxL: TsRadioButton;
    edtR: TsEdit;
    edtL: TsEdit;
    cbxD: TsRadioButton;
    cbxM: TsRadioButton;
    edtD: TsEdit;
    edtM: TsEdit;
    sButton1: TsButton;
    pnlCleaningNotes: TsPanel;
    lblCleaningNotes: TsLabelFX;
    shpCleaningNotes: TShape;
    mmoCleaningNotes: TsMemo;
    pnlCleaningNotes_Button: TsPanel;
    sButton2: TsButton;
    pnlLostAndFound: TsPanel;
    lblLostAndFound: TsLabelFX;
    shpLostAndFound: TShape;
    mmoLostAndFound: TsMemo;
    pnlLostAndFound_Button: TsPanel;
    sButton3: TsButton;
    pnlMaintenanceNotes: TsPanel;
    lblMaintenanceNotes: TsLabelFX;
    shpMaintenanceNotes: TShape;
    mmoMaintenanceNotes: TsMemo;
    pnlMaintenanceNotes_Button: TsPanel;
    sButton4: TsButton;
    btnAllClean: TsButton;
    btnAllUnClean: TsButton;
    procedure cbxCClick(Sender: TObject);
    procedure lblCleaningNotesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAllCleanClick(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
  private
    procedure HideOtherPanels(pnl: TsPanel);
    procedure HideShowPanel(show: Boolean; pnl: TsPanel);
    { Private declarations }
  public
    { Public declarations }
    FormPosition : TPoint;
  end;

var
  frmRoomCleanMaintenanceStatus: TfrmRoomCleanMaintenanceStatus;

function SetRoomCleanAndMaintenanceStatus(sRoom : string; x, y : integer) : boolean;

implementation

uses
  uAppGlobal,
  Db,
  ADODB,
  DbTables,
  uD,
  hData,
  uG,
  _Glob,
  CompProd
  , uUtils
  ;

{$R *.dfm}

function SetRoomCleanAndMaintenanceStatus(sRoom : string; x, y : integer) : boolean;
var
  s : string;
  dsRoom, dsCodes, dsNotes : TRoomerDataSet;
  status : String;
  obj : TObject;
  currStatus : STring;
  idx : Integer;
begin
  // --
  result := false;
  dsRoom := nil;
  dsCodes := nil;
  dsNotes := nil;
  Application.CreateForm(TfrmRoomCleanMaintenanceStatus, frmRoomCleanMaintenanceStatus);
  try
    dsRoom := createNewDataSet;
    hData.rSet_bySQL(dsRoom,
       format('SELECT status, rooms.ID, ' +
//		          '  maintenanceroomnotes.DateAndTime, ' +
//		          '  maintenanceroomnotes.Active, ' +
		          '  maintenanceroomnotes.CleaningNotes, ' +
		          '  maintenanceroomnotes.MaintenanceNotes, ' +
		          '  maintenanceroomnotes.LostAndFound, ' +
		          '  maintenanceroomnotes.staffIdReported, ' +
		          '  maintenanceroomnotes.staffIdFixed, ' +
		          '  smreport.initials AS reportUser, ' +
		          '  smreport.Name AS reportUserName, ' +
		          '  smfix.initials AS fixUser, ' +
		          '  smfix.Name AS fixUserName ' +
		          'FROM rooms ' +
		          '     LEFT JOIN maintenanceroomnotes ON maintenanceroomnotes.Room=rooms.Room ' +
		          '     LEFT JOIN staffmembers smreport ON smreport.id=maintenanceroomnotes.staffIdReported ' +
		          '     LEFT JOIN staffmembers smfix ON smfix.id=maintenanceroomnotes.staffIdFixed ' +
		          'WHERE rooms.Room=''%s''', [sRoom])
              );
    dsRoom.First;
    currStatus := dsRoom['status'];
    frmRoomCleanMaintenanceStatus.mmoCleaningNotes.Text := dsRoom['CleaningNotes'];
    if Trim(frmRoomCleanMaintenanceStatus.mmoCleaningNotes.Text) = '' then
      frmRoomCleanMaintenanceStatus.shpCleaningNotes.Brush.Color := clGray
    else
      frmRoomCleanMaintenanceStatus.shpCleaningNotes.Brush.Color := clRed;

    frmRoomCleanMaintenanceStatus.mmoMaintenanceNotes.Text := dsRoom['MaintenanceNotes'];
    if Trim(frmRoomCleanMaintenanceStatus.mmoMaintenanceNotes.Text) = '' then
      frmRoomCleanMaintenanceStatus.shpMaintenanceNotes.Brush.Color := clGray
    else
      frmRoomCleanMaintenanceStatus.shpMaintenanceNotes.Brush.Color := clRed;

    frmRoomCleanMaintenanceStatus.mmoLostAndFound.Text := dsRoom['LostAndFound'];
    if Trim(frmRoomCleanMaintenanceStatus.mmoLostAndFound.Text) = '' then
      frmRoomCleanMaintenanceStatus.shpLostAndFound.Brush.Color := clGray
    else
      frmRoomCleanMaintenanceStatus.shpLostAndFound.Brush.Color := clRed;

    dsCodes := createNewDataSet;
    hData.rSet_bySQL(dsCodes,
       'SELECT name, code, color, id FROM maintenancecodes');

    dsCodes.first;
    while not dsCodes.Eof do
    begin
      obj := frmRoomCleanMaintenanceStatus.findComponent('cbx' + dsCodes['code']);
      if assigned(obj) then
      begin
        TRadioButton(obj).Caption := dsCodes['name'];
        if dsCodes['code'] = currStatus then
          TRadioButton(obj).Checked := true;
      end;
      obj := frmRoomCleanMaintenanceStatus.findComponent('edt' + dsCodes['code']);
      if assigned(obj) then
      begin
        TEdit(obj).Color := HtmlToColor(dsCodes['color'], clWhite);
      end;

      dsCodes.Next;
    end;

    frmRoomCleanMaintenanceStatus.FormPosition.X := x;
    frmRoomCleanMaintenanceStatus.FormPosition.Y := y;


    if frmRoomCleanMaintenanceStatus.FormPosition.Y + frmRoomCleanMaintenanceStatus.Height > Screen.Height then
      frmRoomCleanMaintenanceStatus.FormPosition.Y := Screen.Height - frmRoomCleanMaintenanceStatus.Height - 20;

    frmRoomCleanMaintenanceStatus.Caption := frmRoomCleanMaintenanceStatus.Caption + format(' [%s]', [sRoom]);
    frmRoomCleanMaintenanceStatus.ShowModal;

    if (dsRoom['CleaningNotes'] <> frmRoomCleanMaintenanceStatus.mmoCleaningNotes.Text) OR
       (dsRoom['MaintenanceNotes'] <> frmRoomCleanMaintenanceStatus.mmoMaintenanceNotes.Text) OR
       (dsRoom['LostAndFound'] <> frmRoomCleanMaintenanceStatus.mmoLostAndFound.Text) then
    begin
      s := 'UPDATE maintenanceroomnotes SET CleaningNotes=%s, MaintenanceNotes=%s, LostAndFound=%s WHERE Room=%s';
      s := format(s, [_db(frmRoomCleanMaintenanceStatus.mmoCleaningNotes.Text),
          _db(frmRoomCleanMaintenanceStatus.mmoMaintenanceNotes.Text),
          _db(frmRoomCleanMaintenanceStatus.mmoLostAndFound.Text),
          _db(sRoom)]);
      d.roomerMainDataSet.DoCommand(s);
    end;

    dsCodes.first;
    while not dsCodes.Eof do
    begin
      obj := frmRoomCleanMaintenanceStatus.findComponent('cbx' + dsCodes['code']);
      if assigned(obj) then
      begin
        if TRadioButton(obj).Checked then
        begin
          if dsRoom['status'] <> dsCodes['code'] then
          begin
            if dsRoom.State <> dsEdit then
              dsRoom.Edit;
            dsRoom['status'] := dsCodes['code'];
          end;
          Break;
        end;
      end;
      dsCodes.Next;
    end;
    if dsRoom.State = dsEdit then
    begin
      dsRoom.Post;
      idx := g.oRooms.FindRoomFromRoomNumber(sRoom);
      g.oRooms.RoomItemsList.Items[idx].Status := dsRoom['status'];
    end;


    glb.RefreshTableByName('rooms');


  finally
    dsRoom.Free;
    dsCodes.Free;
    dsNotes.Free;
    frmRoomCleanMaintenanceStatus.free;
  end;
end;


procedure TfrmRoomCleanMaintenanceStatus.cbxCClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRoomCleanMaintenanceStatus.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  pnlCleaningNotes.Height := 29;
  pnlMaintenanceNotes.Height := 29;
  pnlLostAndFound.Height := 29;
end;

procedure TfrmRoomCleanMaintenanceStatus.FormShow(Sender: TObject);
begin
  frmRoomCleanMaintenanceStatus.Left := FormPosition.x;
  frmRoomCleanMaintenanceStatus.Top := FormPosition.y;
end;

procedure TfrmRoomCleanMaintenanceStatus.HideOtherPanels(pnl : TsPanel);
begin
  if pnl <> lblCleaningNotes.Parent then
    HideShowPanel(false, TsPanel(lblCleaningNotes.Parent));
  if pnl <> lblMaintenanceNotes.Parent then
    HideShowPanel(false, TsPanel(lblMaintenanceNotes.Parent));
  if pnl <> lblLostAndFound.Parent then
    HideShowPanel(false, TsPanel(lblLostAndFound.Parent));
end;

procedure TfrmRoomCleanMaintenanceStatus.HideShowPanel(show : Boolean; pnl : TsPanel);
begin
  if show then
  begin
    TsPanel(findComponent(pnl.Name + '_Button')).Show;
    pnl.Align := alClient;
    pnl.Tag := 1;
  end else
  begin
    TsPanel(findComponent(pnl.Name + '_Button')).Hide;
    pnl.Align := alTop;
    pnl.Tag := 0;
    pnl.height :=29;
  end;
end;

procedure TfrmRoomCleanMaintenanceStatus.lblCleaningNotesClick(Sender: TObject);
var pnl : TsPanel;
begin
  pnl := TsPanel(TsLabel(Sender).Parent);
  if assigned(pnl) then
  begin
    if pnl.Tag = 0 then
    begin
      HideShowPanel(true, pnl);
      HideOtherPanels(pnl);
    end else
    begin
      HideShowPanel(false, pnl);
    end;
  end;
end;

procedure TfrmRoomCleanMaintenanceStatus.sButton2Click(Sender: TObject);
begin
  HideShowPanel(false, TsPanel(TsButton(Sender).Parent.Parent));
end;

procedure TfrmRoomCleanMaintenanceStatus.btnAllCleanClick(Sender: TObject);
begin
  d.SetAllClean;
end;

procedure TfrmRoomCleanMaintenanceStatus.sButton6Click(Sender: TObject);
begin
  d.SetAllunClean;
end;

end.
