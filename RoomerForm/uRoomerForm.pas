unit uRoomerForm;

interface

uses
  Vcl.Forms
  , System.Classes
  , cxClasses
  , cxPropertiesStore
  , Winapi.Messages, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkSide, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter, Vcl.Controls,
  dxStatusBar;

type
  /// <summary>
  ///  Basic form used by all Roomer windows and dialogs. <br />
  ///  Restores and Stores its dimensional properties and WindowState in the registry based on the actual form classname <br />
  ///  User can close window with ESC if that option is set (default = true)
  ///  </summary>
  TfrmBaseRoomerForm = class(TForm)
    psRoomerBase: TcxPropertiesStore;
    dxStatusBar: TdxStatusBar;
  private
    FCloseOnEsc: boolean;
    procedure KeepOnVisibleMonitor;
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
    procedure LoadData; virtual;
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
    property CloseOnEsc: boolean read FCloseOnEsc write FCloseOnEsc;
  end;

implementation

{$R *.dfm}

uses
  uAppGlobal
  , Windows
  , uUtils
  ;


{ TfrmBaseRoomerForm }

constructor TfrmBaseRoomerForm.Create(AOwner: TComponent);
begin
  inherited;

  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self);

  FCloseOnEsc := True;
end;


procedure TfrmBaseRoomerForm.DoShow;
begin
  inherited; // Calls ShowForm event handler
  KeepOnVisibleMonitor;
  Refreshdata;
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
begin
  //
end;

procedure TfrmBaseRoomerForm.Loaded;
begin
  psRoomerBase.StorageName := 'Software\Roomer\FormStatus\' + classname;
  psRoomerBase.Components[0].Component := Self;
  inherited;
end;

procedure TfrmBaseRoomerForm.RefreshData;
begin
  PostMessage(Handle, WM_REFRESH_DATA, 0, 0);
end;

procedure TfrmBaseRoomerForm.UpdateControls;
begin
//
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

end.
