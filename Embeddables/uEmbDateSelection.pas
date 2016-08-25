unit uEmbDateSelection;

interface

uses
  System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseEmbeddableForm, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, sRadioButton, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sToolEdit, sComboBox, sGroupBox;

type
  {$ScopedEnums ON}
  TDateSelPreset = (Today, Tomorrow, Yesterday, ThisWeek, ThisMonth, ThisYear, Manual);
  TDateSelPresetHelper = record helper for TDateSelPreset
  public
    class function FromItemIndex(idx: integer): TDateSelPreset; static;
    procedure SetStrings(aStrings: TStrings);
  end;

  TfrmDateSelection = class(TembeddableForm)
    pnlDateSelection: TsPanel;
    gbxSelectMonths: TsGroupBox;
    cbxMonth: TsComboBox;
    cbxYear: TsComboBox;
    gbxSelectDates: TsGroupBox;
    dtDateFrom: TsDateEdit;
    dtDateTo: TsDateEdit;
    gbxPresets: TsGroupBox;
    cbxPresets: TsComboBox;
    procedure cbxMonthChange(Sender: TObject);
    procedure cbxPresetsChange(Sender: TObject);
  private
    function GetFromDate: TDateTime;
    function GetToDate: TDateTime;
    procedure SetFromDate(const Value: TDateTime);
    procedure SetToDate(const Value: TDateTime);
    { Private declarations }
  protected
    function GetEmbeddableControl: TControl; override;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
    procedure UpdateControls; override;
    property FromDate: TDateTime read GetFromDate write SetFromDate;
    property ToDate: TDateTime read GetToDate write SetToDate;
  end;

implementation

{$R *.dfm}

uses
    SysUtils
  , uDateTimeHelper
  ;


{ TfrmDateSelection }

procedure TfrmDateSelection.cbxMonthChange(Sender: TObject);
begin
  inherited;
  SignalChanges(Sender);
  UpdateControls;
end;

procedure TfrmDateSelection.cbxPresetsChange(Sender: TObject);
begin
  inherited;
  if not UpdatingControls then
  begin
    case TDateSelPreset.FromItemIndex(cbxPresets.itemIndex) of
      TDateSelPreset.Today:
                  begin
                    dtDateFrom.Date := now;
                    dtDateTo.Date := now;
                  end;
      TDateSelPreset.Tomorrow:
                  begin
                    dtDateFrom.Date := now+1;
                    dtDateTo.Date := now+1;
                  end;
      TDateSelPreset.Yesterday:
                  begin
                    dtDateFrom.Date := now-1;
                    dtDateTo.Date := now-1;
                  end;
      TDateSelPreset.ThisWeek:
                  begin
                    dtDateFrom.Date := now.StartOfWeek;
                    dtDateTo.Date := now.EndOfWeek;
                  end;
      TDateSelPreset.ThisMonth:
                  begin
                    dtDateFrom.Date := Now.StartOfMonth;
                    dtDateTo.Date := now.EndOfMonth;
                  end;
      TDateSelPreset.ThisYear:
                  begin
                    dtDateFrom.Date := now.StartOfYear;
                    dtDateTo.Date := now.EndOfYear;
                  end;
      TDateSelPreset.Manual:
                  begin
                  end;
    end;
  end;
end;

constructor TfrmDateSelection.Create(aOwner: TComponent);
begin
  inherited;
  TDateSelPreset.SetStrings(cbxPresets.Items);
end;

function TfrmDateSelection.GetEmbeddableControl: TControl;
begin
  Result := pnlDateSelection;
end;

function TfrmDateSelection.GetFromDate: TDateTime;
begin
  Result := dtDateFrom.Date;
end;

function TfrmDateSelection.GetToDate: TDateTime;
begin
  Result := dtDateTo.Date;
end;

procedure TfrmDateSelection.SetFromDate(const Value: TDateTime);
begin
  dtDateFrom.Date := Value;
end;

procedure TfrmDateSelection.SetToDate(const Value: TDateTime);
begin
  dtDateTo.Date := Value;
end;

procedure TfrmDateSelection.UpdateControls;
begin
  inherited;
  if not UpdatingControls then
  try
    UpdatingControls := True;


  finally
    UpdatingControls := False;
  end;
end;

{ TDateSelPresetHelper }

class function TdateSelPreset.FromItemIndex(idx: integer): TDateSelPreset;
begin
  Result := TDateSelPreset(idx);
end;

procedure TDateSelPresetHelper.SetStrings(aStrings: TStrings);
begin

end;

end.
