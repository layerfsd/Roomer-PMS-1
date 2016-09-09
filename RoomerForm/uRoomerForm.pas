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
  ///  Restores and Stores its dimensional properties and WindowState in the registry based on the actual form classname
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
    procedure UpdateControls; virtual;
    procedure RefreshData; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    /// <summary>
    ///  Close the window when ESC is pressed by the user, Default = True
    ///  </summary>
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

destructor TfrmBaseRoomerForm.Destroy;
begin

  inherited;
end;

procedure TfrmBaseRoomerForm.DoShow;
begin
  inherited; // Calls ShowForm event handler
  KeepOnVisibleMonitor;
  postMessage(handle, WM_REFRESH_DATA, 0, 0);
  UpdateControls;
end;

procedure TfrmBaseRoomerForm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited; // Calls FormKeyDown event if present
  if FCloseOnEsc and (Key = VK_ESCAPE) then
    Close;
end;

procedure TfrmBaseRoomerForm.KeepOnVisibleMonitor;
var
  MonitorCount : integer;
  maxLeft : integer;
  i : integer;
  lMonitor: TMonitor;
const
  MoveWinThreshold: Byte = 80;
begin
  MonitorCount := screen.MonitorCount;

  maxLeft := 0;
  for i := 0 to MonitorCount - 1 do
  begin
    maxLeft := maxLeft + screen.Width;
  end;

  maxLeft := maxLeft - 150;
  if Left > maxLeft then
    Left := maxLeft;

  // ...
  // 1. Some code to restore the last GUI position and dimension
  // ...

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


procedure TfrmBaseRoomerForm.Loaded;
begin
  psRoomerBase.StorageName := 'Software\Roomer\FormStatus\' + classname;
  psRoomerBase.Components[0].Component := Self;
  inherited;
end;

procedure TfrmBaseRoomerForm.RefreshData;
begin
//
end;

procedure TfrmBaseRoomerForm.UpdateControls;
begin
//
end;

procedure TfrmBaseRoomerForm.WndProc(var message: TMessage);
begin
  if message.Msg = WM_REFRESH_DATA then
    RefreshData;
  inherited WndProc(message);
end;

end.
