unit uCreditPrompt;

(*

 121207 - checked for ww - OK

*)


interface

uses
    Windows
  , Messages
  , SysUtils
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , StdCtrls
  , ExtCtrls

  , dxSkinsCore
  , dxSkinDarkSide
  , dxSkinDevExpressDarkStyle
  , dxSkinMcSkin
  , dxSkinOffice2013White
  , dxSkinsDefaultPainters

  , sEdit
  , sLabel
  , sButton
  , sPanel

  ;

type
  TfrmCreditPrompt = class(TForm)
    Panel1: TsPanel;
    lblRefNumber: TLabel;
    btnOk: TsButton;
    cxLabel1: TsLabel;
    edRefNumber: TsEdit;
    btnCancel: TsButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCreditPrompt: TfrmCreditPrompt;

implementation

{$R *.DFM}

uses
    uAppGlobal
  , uDImages
  , uUtils;

procedure TfrmCreditPrompt.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
   glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);

end;

end.
