unit uFrmMergePortfolios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uGuestPortfolioEdit, cmpRoomerDataset, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel,
  Vcl.ComCtrls, sPageControl, sCheckBox, sComboBox, sEdit, sMemo, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sToolEdit;

type
  TfrmMergePortfolios = class(TForm)
    pnlGuest1: TsPanel;
    pnlGuest2: TsPanel;
    sPanel3: TsPanel;
    panBtn: TsPanel;
    btnCancel: TsButton;
    BtnOk: TsButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    GuestId1,
    GuestId2: Integer;

    GuestPortfolio1,
    GuestPortfolio2 : TfrmGuestPortfolio;
    procedure pgPagesChange(Sender: TObject);
    procedure pgPages2Change(Sender: TObject);
    procedure xcmbGenderClick(Sender: TObject);
    procedure xcmbGender2Click(Sender: TObject);
    procedure SetOnClickHandlers(Portfolio: TfrmGuestPortfolio);
    procedure PerformMerge;
    procedure CorrectPersonsRelations;
  public
    { Public declarations }
    procedure PrepareMerge(Data: TRoomerDataset; id1, id2: Integer);
  end;

var
  frmMergePortfolios: TfrmMergePortfolios;

procedure MergeGuestPortfolios(Data : TRoomerDataset; id1, id2 : Integer);


implementation

{$R *.dfm}

uses uD, uRoomerLanguage, uAppGlobal, uUtils;

procedure MergeGuestPortfolios(Data : TRoomerDataset; id1, id2 : Integer);
var _frmMergePortfolios: TfrmMergePortfolios;
begin
  _frmMergePortfolios := TfrmMergePortfolios.Create(nil);
  try
    _frmMergePortfolios.PrepareMerge(Data, id1, id2);
    _frmMergePortfolios.ShowModal;
  finally
    FreeAndNil(_frmMergePortfolios);
  end;
end;

procedure TfrmMergePortfolios.xcmbGenderClick(Sender: TObject);
var objName : String;
    obj : TObject;
    cbx : TSCheckBox;
begin
  cbx := TSCheckBox(Sender);
  objName := cbx.Name;
  obj := GuestPortfolio2.FindComponent(objName);
  if Assigned(obj) then
  begin
    TSCheckBox(obj).Checked := NOT cbx.Checked;
  end;
  GuestPortfolio1.xcmbGenderClick(Sender);
  GuestPortfolio2.xcmbGenderClick(obj);
end;

procedure TfrmMergePortfolios.xcmbGender2Click(Sender: TObject);
var objName : String;
    obj : TObject;
    cbx : TSCheckBox;
begin
  cbx := TSCheckBox(Sender);
  objName := cbx.Name;
  obj := GuestPortfolio1.FindComponent(objName);
  if Assigned(obj) then
  begin
    TSCheckBox(obj).Checked := NOT cbx.Checked;
  end;
  GuestPortfolio1.xcmbGenderClick(obj);
  GuestPortfolio2.xcmbGenderClick(Sender);
end;

procedure TfrmMergePortfolios.pgPagesChange(Sender: TObject);
var pgPages : TsPageControl;
begin
  pgPages := TsPageControl(Sender);
  GuestPortfolio1.pgPagesChange(Sender);
  GuestPortfolio2.pgPages.ActivePageIndex := pgPages.ActivePageIndex;
  GuestPortfolio2.pgPagesChange(GuestPortfolio2.pgPages);
end;

procedure TfrmMergePortfolios.BtnOkClick(Sender: TObject);
begin
  // Save stuff
  PerformMerge;
  GuestPortfolio1.PostCurrentIfNeeded(true);
  CorrectPersonsRelations;
  GuestPortfolio1.AccumulateChanges;
  Close;
end;

procedure TfrmMergePortfolios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  RemoveMerge(GuestPortfolio1);
  RemoveMerge(GuestPortfolio2);
end;

procedure TfrmMergePortfolios.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
end;

procedure TfrmMergePortfolios.pgPages2Change(Sender: TObject);
var pgPages : TsPageControl;
begin
  pgPages := TsPageControl(Sender);
  GuestPortfolio2.pgPagesChange(Sender);
  GuestPortfolio1.pgPages.ActivePageIndex := pgPages.ActivePageIndex;
  GuestPortfolio1.pgPagesChange(GuestPortfolio1.pgPages);
end;

procedure TfrmMergePortfolios.SetOnClickHandlers(Portfolio: TfrmGuestPortfolio);
var i: Integer;
begin
  for i := 0 to Portfolio.ComponentCount - 1 do
    if Portfolio.Components[i] IS TsCheckBox then
      if Copy(Portfolio.Components[i].Name, 1, 1) = 'x' then
        if Portfolio = GuestPortfolio1 then
          (Portfolio.Components[i] AS TsCheckBox).OnClick := xcmbGenderClick
        else
          (Portfolio.Components[i] AS TsCheckBox).OnClick := xcmbGender2Click;
end;

procedure TfrmMergePortfolios.PerformMerge;
var i: Integer;
    CurrComp : TComponent;
    cbx : TsCheckBox;
    objName : String;
    obj1 : TObject;
    obj2 : TObject;
begin
  for i := 0 to GuestPortfolio2.ComponentCount - 1 do
  begin
    CurrComp := GuestPortfolio2.Components[i];
    if CurrComp IS TsCheckBox then
    begin
      cbx := (CurrComp AS TsCheckBox);
      if Copy(cbx.Name, 1, 1) = 'x' then
        if cbx.Checked then
        begin
          objName := copy(cbx.Name, 2, maxInt);
          obj1 := GuestPortfolio1.FindComponent(objName);
          obj2 := GuestPortfolio2.FindComponent(objName);

          if obj2 IS TsEdit then
            TsEdit(obj1).Text := TsEdit(obj2).Text
          else
          if obj2 IS TsDateEdit then
            TsDateEdit(obj1).Date := TsDateEdit(obj2).Date
          else
          if obj2 IS TsComboBox then
          begin
            TsComboBox(obj1).ItemIndex := TsComboBox(obj2).ItemIndex;
            TsComboBox(obj1).Text := TsComboBox(obj2).Text;
          end else
          if obj2 IS TsCheckBox then
            TsCheckBox(obj1).Checked := TsCheckBox(obj2).Checked
          else
          if obj2 IS TsMemo then
            TsMemo(obj1).Text := TsMemo(obj2).Text;
        end;
    end;
  end;
end;

procedure TfrmMergePortfolios.CorrectPersonsRelations;
var sql : String;
begin
  sql := format('UPDATE persons SET PersonsProfilesId=%d WHERE PersonsProfilesId=%d', [GuestId1, GuestId2]);
  d.roomerMainDataSet.DoCommand(sql);
  sql := format('DELETE FROM personprofiles WHERE ID=%d', [GuestId2]);
  d.roomerMainDataSet.DoCommand(sql);
end;


procedure TfrmMergePortfolios.PrepareMerge(Data : TRoomerDataset; id1, id2 : Integer);
begin
  GuestId1 := id1;
  GuestPortfolio1 := uGuestPortfolioEdit.PrepareMerge(Data, True, id1);
  GuestPortfolio1.pnlHolder.Parent := pnlGuest1;
  GuestPortfolio1.pgPages.OnChange := pgPagesChange;
  SetOnClickHandlers(GuestPortfolio1);

  GuestId2 := id2;
  GuestPortfolio2 := uGuestPortfolioEdit.PrepareMerge(Data, False, id2);
  GuestPortfolio2.pnlHolder.Parent := pnlGuest2;
  GuestPortfolio2.pgPages.OnChange := pgPages2Change;
  SetOnClickHandlers(GuestPortfolio2);
end;

end.
