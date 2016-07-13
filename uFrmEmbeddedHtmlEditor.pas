unit uFrmEmbeddedHtmlEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  uDImages, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, Vcl.StdCtrls,
  sButton, Vcl.ExtCtrls, sPanel, ActiveX, Vcl.ImgList, Vcl.Menus, Vcl.Buttons, sSpeedButton,
  Vcl.ComCtrls, Vcl.ToolWin, sToolBar, sPageControl, AdvMemo, AdvmWS, cxClasses, cxPropertiesStore;

type
  TFrmEmbeddedHtmlEditor = class(TForm)
    sPanel1: TsPanel;
    btnClose: TsButton;
    sButton1: TsButton;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mnuSaveAndExit: TMenuItem;
    C1: TMenuItem;
    N3: TMenuItem;
    mnuEditCut: TMenuItem;
    mnuEditCopy: TMenuItem;
    mnuEditPaste: TMenuItem;
    dlgFont: TFontDialog;
    pgPages: TsPageControl;
    sTabSheet1: TsTabSheet;
    mmoSource: TAdvMemo;
    AdvMemoSource1: TAdvMemoSource;
    AdvHTMLMemoStyler1: TAdvHTMLMemoStyler;
    FormStore: TcxPropertiesStore;
    O1: TMenuItem;
    mnuWordWrap: TMenuItem;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditCutClick(Sender: TObject);
    procedure EditCopyClick(Sender: TObject);
    procedure EditPasteClick(Sender: TObject);
    procedure CancelAndCloseClick(Sender: TObject);
    procedure mnuWordWrapClick(Sender: TObject);
  private
//    styler : TAdvHtmlMemoStyler;
    procedure saveTo(filename: String);
    { Private declarations }
  public
    { Public declarations }
    filename : String;
    SaveFileToRemote : Boolean;
  end;

var
  FrmEmbeddedHtmlEditor: TFrmEmbeddedHtmlEditor;

function EditHtmlFile(filename : String; new : boolean = false) : Boolean;
function EditHtmlSource(filename : String; new : boolean = false) : Boolean;

implementation

{$R *.dfm}

uses  uFileDependencyManager
    , uDateUtils
    , uUtils
    , uRunWithElevatedOption
    , uMain
    ;

function EditHtmlFile(filename : String; new : boolean = false) : Boolean;
var
  tsWas, tsNew : String;
  sPath : String;
begin
  tsWas := uDateUtils.DateTimeToDBString(GetFileTimeStamp(filename));

  sPath := FileDependencymanager.getHtmlEditorFilePath(false);
  if sPath <> '' then
     ExecuteFile(frmMain.handle, sPath, '"' + filename + '"', [eoWait]);

  tsNew := uDateUtils.DateTimeToDBString(GetFileTimeStamp(filename));
  result := tsNew <> tsWas;
end;

function EditHtmlSource(filename : String; new : boolean = false) : Boolean;
var
  tsWas, tsNew : String;
  sPath : String;
  _FrmEmbeddedHtmlEditor : TFrmEmbeddedHtmlEditor;
begin
  tsWas := uDateUtils.DateTimeToDBString(GetFileTimeStamp(filename));

  sPath := FileDependencyManager.getHtmlEditorFilePath(false);
  if sPath <> '' then
  begin
    _FrmEmbeddedHtmlEditor := TFrmEmbeddedHtmlEditor.Create(nil);
    try
      _FrmEmbeddedHtmlEditor.filename := filename;
      _FrmEmbeddedHtmlEditor.ShowModal;
//      result := _FrmEmbeddedHtmlEditor.SaveFileToRemote;
    finally
      FreeAndNil(_FrmEmbeddedHtmlEditor)
    end;
  end;
  tsNew := uDateUtils.DateTimeToDBString(GetFileTimeStamp(filename));
  result := tsNew <> tsWas;
end;

procedure TFrmEmbeddedHtmlEditor.btnOkClick(Sender: TObject);
begin
  SaveTo(filename);

  SaveFileToRemote := True;
  Close;
end;

procedure TFrmEmbeddedHtmlEditor.EditCutClick(Sender: TObject);
begin
  mmoSource.CutToClipBoard;
end;

procedure TFrmEmbeddedHtmlEditor.CancelAndCloseClick(Sender: TObject);
begin
  SaveFileToRemote := False;
  Close;
end;

procedure TFrmEmbeddedHtmlEditor.EditCopyClick(Sender: TObject);
begin
  mmoSource.CopyToClipBoard;
end;

procedure TFrmEmbeddedHtmlEditor.EditPasteClick(Sender: TObject);
begin
  mmoSource.PasteFromClipBoard;
end;

procedure TFrmEmbeddedHtmlEditor.FormCreate(Sender: TObject);
begin
  SaveFileToRemote := False;
end;

procedure TFrmEmbeddedHtmlEditor.FormShow(Sender: TObject);
begin
  mmoSource.MemoSource.Lines.LoadFromFile(filename);
end;

procedure TFrmEmbeddedHtmlEditor.saveTo(filename : String);
var list : TStringList;
begin
  list := TStringList.Create;
  TRY
    list.Assign(mmoSource.MemoSource.Lines);
    list.SaveToFile(filename);
  FINALLY
    list.Free;
  END;
end;

procedure TFrmEmbeddedHtmlEditor.mnuWordWrapClick(Sender: TObject);
begin
  mnuWordWrap.Checked := NOT mnuWordWrap.Checked;
  if mnuWordWrap.Checked then
    mmoSource.WordWrap := wwClientWidth
  else
    mmoSource.WordWrap := wwNone;
end;

end.
