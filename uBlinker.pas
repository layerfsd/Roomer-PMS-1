unit uBlinker;

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
  ,  ExtCtrls, acPNG

  ;

type
  TfrmBlinker = class(TForm)
    arrowImage: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBlinker: TfrmBlinker;

implementation

{$R *.DFM}

end.
