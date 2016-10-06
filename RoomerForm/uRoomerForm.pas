unit uRoomerForm;

interface

uses
  Vcl.Forms
  , System.Classes
  , cxClasses
  , cxPropertiesStore
  , Winapi.Messages, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, Vcl.Controls,
  dxStatusBar, cxGridTableView, cxStyles, dxPScxCommon, dxPScxGridLnk;

type
  /// <summary>
  ///   Possible Busystates of a Roomerform
  /// </summary>
  TRoomerFormBusyState = (fsIdle, fsLoadingData, fsPrinting);

  /// <summary>
  ///  Basic form to be used for all Roomer windows and dialogs. <br />
  ///  Restores and Stores its dimensional properties in the registry based on the actual form classname <br />
  ///  User can close window with ESC if that option is set (default = true) <br />
  ///  Contains a status panel with a statusindicator. Setting the BusyState property updates the indicator and statusmessage. <br/>
  ///  <br/>
  ///  Forms derived from this base class should override the UpdateControls() ans DoLoadData() methods
  ///  </summary>
  TfrmBaseRoomerForm = class(TForm)
    psRoomerBase: TcxPropertiesStore;
    dxStatusBar: TdxStatusBar;
    cxsrRoomerStyleRepository: TcxStyleRepository;
  private
    FCloseOnEsc: boolean;
    FBusyState: TRoomerFormBusyState;
    procedure KeepOnVisibleMonitor;
    procedure LoadData;
    function GetStateIndicator: TdxStatusBarStateIndicatorItem;
    function GetStateTextPanel: TdxStatusBarpanel;
    function GetBusyState: TRoomerFormBusyState;
    procedure SetBusyState(const Value: TRoomerFormBusyState);
  protected
    const
      WM_REFRESH_DATA = WM_User + 51;
    var
    procedure WndProc(var message: TMessage); override;
    procedure DoShow; override;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    /// <summary>
    ///   Update the contents and/or properties of visual components, like Enabled etc
    /// </summary>
    procedure UpdateControls; virtual;
    /// <summary>
    ///   (Re)load data needed to display in the form
    /// </summary>
    procedure DoLoadData; virtual;
    property StateIndicator: TdxStatusBarStateIndicatorItem read GetStateIndicator;
    property StateTextPanel: TdxStatusBarpanel read GetStateTextPanel;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    ///   Signal form through Windows messaging system to reload data and update controls
    /// </summary>
    procedure RefreshData;
  published
    /// <summary>
    ///  Close the window when ESC is pressed by the user, Default = True
    /// </summary>
    property CloseOnEsc: boolean read FCloseOnEsc write FCloseOnEsc default True;
    /// <summary>
    ///   The state of the form, made visible by the statusindicator and a message in the statuspanel
    /// </summary>
    property BusyState: TRoomerFormBusyState read GetBusyState write SetBusyState;
  end;

implementation

{$R *.dfm}

uses
  uAppGlobal
  , Windows
  , uUtils
  , PrjConst
  , UITypes
  ;

type
  TRoomerFormBusyStateHelper = record helper for TRoomerFormBusyState
  public
    function StatusMessage: String;
    function Indicator: TdxStatusBarStateIndicatorType;
  end;

{ TfrmBaseRoomerForm }

constructor TfrmBaseRoomerForm.Create(AOwner: TComponent);
begin
  inherited;

  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);

  FCloseOnEsc := True;
end;


procedure TfrmBaseRoomerForm.DoLoadData;
begin
  // to be overridden in derived classes
end;

procedure TfrmBaseRoomerForm.DoShow;
begin
  inherited; // Calls ShowForm event handler
  KeepOnVisibleMonitor;
  UpdateControls;
end;

function TfrmBaseRoomerForm.GetBusyState: TRoomerFormBusyState;
begin
  Result := FBusyState;
end;

function TfrmBaseRoomerForm.GetStateIndicator: TdxStatusBarStateIndicatorItem;
begin
  Result := TdxStatusBarStateIndicatorPanelStyle(dxStatusBar.Panels[0].PanelStyle).Indicators[0];
end;

function TfrmBaseRoomerForm.GetStateTextPanel: TdxStatusBarpanel;
begin
  Result := dxStatusBar.Panels[1];
end;

procedure TfrmBaseRoomerForm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited; // Calls FormKeyDown event if present
  if FCloseOnEsc and (Key = VK_ESCAPE) then
    Close;
end;

procedure TfrmBaseRoomerForm.KeepOnVisibleMonitor;
var
  lMonitor: TMonitor;
const
  MoveWinThreshold: Byte = 80;
begin
  // 2. Detect the relevant monitor object
  lMonitor := Screen.MonitorFromWindow(Self.Handle);
  // 3. Now ensure the just positioned window is visible to the user
  // 3.a. Set minimal visible width
  if Left > lMonitor.Left + lMonitor.Width - MoveWinThreshold then
    Left := lMonitor.Left + lMonitor.Width - MoveWinThreshold;
  // 3.b. Set minimal visible height
  if Top > lMonitor.Top + lMonitor.Height - MoveWinThreshold then
    Top := lMonitor.Top + lMonitor.Height - MoveWinThreshold;

end;


procedure TfrmBaseRoomerForm.LoadData;
var
  lCursor: TCursor;
begin
  lCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    BusyState := fsLoadingData;
    DoLoadData;
  finally
    BusyState := fsIdle;
    Screen.Cursor := lCursor;
  end;
end;

procedure TfrmBaseRoomerForm.Loaded;
begin
  psRoomerBase.StorageName := 'Software\Roomer\FormStatus\' + classname;
  psRoomerBase.Components[0].Component := Self;

  inherited;
  BusyState := fsIdle;
end;

procedure TfrmBaseRoomerForm.RefreshData;
begin
  PostMessage(Handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmBaseRoomerForm.SetBusyState(const Value: TRoomerFormBusyState);
begin
  if Value <> FBusyState then
  begin
    FBusyState := Value;
    StateTextPanel.Text := FBusyState.StatusMessage;
    StateIndicator.IndicatorType := FBusyState.Indicator;
    dxStatusBar.Repaint;
  end;
end;

procedure TfrmBaseRoomerForm.UpdateControls;
begin
  // to be overridden in derived classes
end;

procedure TfrmBaseRoomerForm.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
  begin
    LoadData;
    UpdateControls
  end;
  inherited WndProc(message);
end;

{ TRoomerBusyStateHelper }

function TRoomerFormBusyStateHelper.Indicator: TdxStatusBarStateIndicatorType;
begin
  case Self of
    fsIdle:         Result := sitGreen;
    fsLoadingData:  Result := sitYellow;
    fsPrinting:     Result := sitBlue;
  else
    Result := sitOff;
  end;
end;

function TRoomerFormBusyStateHelper.StatusMessage: String;
begin
  case Self of
    fsIdle:         Result := GetTranslatedText('shRoomerFormBusyStateIdle');
    fsLoadingData:  Result := GetTranslatedText('shRoomerFormBusyStateLoadingData');
    fsPrinting:     Result := GetTranslatedText('shRoomerFormBusyStatePrinting');
  else
    Result := '';
  end;

end;

end.
