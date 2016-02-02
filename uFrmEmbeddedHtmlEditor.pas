unit uFrmEmbeddedHtmlEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  uDImages, msHtml, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls,
  sButton, Vcl.ExtCtrls, sPanel, ActiveX, Vcl.ImgList, Vcl.Menus, Vcl.Buttons, sSpeedButton,
  Vcl.ComCtrls, Vcl.ToolWin, sToolBar;

type
  TFrmEmbeddedHtmlEditor = class(TForm)
    sPanel1: TsPanel;
    btnClose: TsButton;
    sButton1: TsButton;
    ImageList1: TImageList;
    wbEditor: TWebBrowser;
    tbButtons: TsToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mnuSaveAndExit: TMenuItem;
    C1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    mnuEditCut: TMenuItem;
    mnuEditCopy: TMenuItem;
    mnuEditPaste: TMenuItem;
    N7: TMenuItem;
    mnyAlignLeft: TMenuItem;
    mnuAlignCenter: TMenuItem;
    mnuAlignRight: TMenuItem;
    mnuFontBold: TMenuItem;
    mnuFontItalic: TMenuItem;
    mnuFontUnderline: TMenuItem;
    ToolButton9: TToolButton;
    sSpeedButton4: TsSpeedButton;
    N4: TMenuItem;
    mnuFont: TMenuItem;
    mnuFontColor: TMenuItem;
    sSpeedButton5: TsSpeedButton;
    dlgFont: TFontDialog;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wbEditorDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditCutClick(Sender: TObject);
    procedure EditCopyClick(Sender: TObject);
    procedure EditPasteClick(Sender: TObject);
    procedure FontBoldClick(Sender: TObject);
    procedure FontItalicClick(Sender: TObject);
    procedure FontUnderlineClick(Sender: TObject);
    procedure JustifyLeftClick(Sender: TObject);
    procedure JustifyCenterClick(Sender: TObject);
    procedure JustifyRightClick(Sender: TObject);
    procedure CancelAndCloseClick(Sender: TObject);
    procedure mnuFontClick(Sender: TObject);
  private
    procedure saveTo(filename: String);
    function GetSelection: IHTMLDocument2;
    function GetWebBrowserHTML(const WebBrowser: TWebBrowser): String;
    function GetSelectionTextRange: IHTMLTxtRange;
    function GetSelectionElement: IHTMLElement2;
    { Private declarations }
  public
    { Public declarations }
    filename : String;
    SaveFileToRemote : Boolean;
  end;

var
  FrmEmbeddedHtmlEditor: TFrmEmbeddedHtmlEditor;

function EditHtmlFile(filename : String; new : boolean = false) : Boolean;

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

  sPath := getHtmlEditorFilePath(false);
  if sPath <> '' then
     ExecuteFile(frmMain.handle, sPath, '"' + filename + '"', [eoWait]);

  tsNew := uDateUtils.DateTimeToDBString(GetFileTimeStamp(filename));
  result := tsNew <> tsWas;
//  if getHtmlEditorFilePath(false) <> '' then
//     result := EditLocalHtmlFile(filename)
//  else
//  begin
//    _FrmEmbeddedHtmlEditor := TFrmEmbeddedHtmlEditor.Create(nil);
//    try
//      _FrmEmbeddedHtmlEditor.filename := filename;
//      _FrmEmbeddedHtmlEditor.ShowModal;
//      result := _FrmEmbeddedHtmlEditor.SaveFileToRemote;
//    finally
//      FreeAndNil(_FrmEmbeddedHtmlEditor)
//    end;
//  end;
end;

procedure TFrmEmbeddedHtmlEditor.btnOkClick(Sender: TObject);
begin
  SaveTo(filename);

  SaveFileToRemote := True;
  Close;
end;

procedure TFrmEmbeddedHtmlEditor.wbEditorDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
  ((ASender AS TWebBrowser).Document AS IHTMLDocument2).designMode := 'on';
end;

procedure TFrmEmbeddedHtmlEditor.JustifyRightClick(Sender: TObject);
begin
  GetSelection.execCommand('JustifyRight', false, null);
end;

function TFrmEmbeddedHtmlEditor.GetSelectionTextRange : IHTMLTxtRange;
begin
  result := GetSelection.selection.createRange() as IHTMLTxtRange;
end;

function TFrmEmbeddedHtmlEditor.GetSelectionElement : IHTMLElement2;
begin
  result := GetSelectionTextRange.parentElement() as mshtml.IHTMLElement2;
end;


procedure TFrmEmbeddedHtmlEditor.mnuFontClick(Sender: TObject);
var
  FontSize: System.OleVariant;
  FontName: System.OleVariant;
  FontStyle: System.OleVariant;
begin
  FontName := GetSelectionElement.currentStyle.fontFamily;
  FontSize := StringReplace(
                  StringReplace(GetSelectionElement.currentStyle.fontSize, 'pt', '', [rfReplaceAll, rfIgnoreCase]),
                   'px', '', [rfReplaceAll, rfIgnoreCase]);
  FontStyle := GetSelectionElement.currentStyle.fontStyle;
  dlgFont.Font.Name := FontName;
  dlgFont.Font.Size := StrToInt(FontSize);
  if dlgFont.Execute then
  begin
    GetSelection.execCommand('FontName', false, dlgFont.Font.Name);
    GetSelection.execCommand('FontSize', false, dlgFont.Font.Size);
  end;
end;

procedure TFrmEmbeddedHtmlEditor.EditCutClick(Sender: TObject);
begin
  GetSelection.execCommand('cut', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.CancelAndCloseClick(Sender: TObject);
begin
  SaveFileToRemote := False;
  Close;
end;

procedure TFrmEmbeddedHtmlEditor.EditCopyClick(Sender: TObject);
begin
  GetSelection.execCommand('copy', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.EditPasteClick(Sender: TObject);
begin
  GetSelection.execCommand('paste', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.FontBoldClick(Sender: TObject);
begin
  GetSelection.execCommand('Bold', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.FontItalicClick(Sender: TObject);
begin
  GetSelection.execCommand('Italic', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.FontUnderlineClick(Sender: TObject);
begin
  GetSelection.execCommand('Underline', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.JustifyLeftClick(Sender: TObject);
begin
  GetSelection.execCommand('JustifyLeft', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.JustifyCenterClick(Sender: TObject);
begin
  GetSelection.execCommand('JustifyCenter', false, null);
end;

procedure TFrmEmbeddedHtmlEditor.FormCreate(Sender: TObject);
begin
  SaveFileToRemote := False;
  OleInitialize(nil);
end;

procedure TFrmEmbeddedHtmlEditor.FormDestroy(Sender: TObject);
begin
  OleUninitialize;
end;

procedure TFrmEmbeddedHtmlEditor.FormShow(Sender: TObject);
begin
  wbEditor.Navigate(filename);
end;

//function TFrmEmbeddedHtmlEditor.GetSelection: IHTMLTxtRange;
//var doc : IHTMLDocument2;
//begin
//  Doc := wbEditor.Document as IHTMLDocument2;
//  if Doc = nil then
//    exit;
//  result := Doc.Selection.createRange AS IHTMLTxtRange;
//end;

function TFrmEmbeddedHtmlEditor.GetSelection: IHTMLDocument2;
begin
  result := wbEditor.Document as IHTMLDocument2;
end;

procedure TFrmEmbeddedHtmlEditor.saveTo(filename : String);
var AFileName: PWideChar;
begin
  if Assigned(wbEditor.Document) then
  begin
    AFileName := AllocMem(MAX_PATH * 2 + 2);
    try
        // Convert string to PWideChar
        StringToWideChar(fileName+'.tmp', AFileName, MAX_PATH);
        (wbEditor.Document as IPersistFile).Save(AFilename, True);
        if FileExists(filename) then
          DeleteFile(filename);
        RenameFile(filename+'.tmp', filename);
    finally
      FreeMem(AFileName);
    end;
  end;
end;

function TFrmEmbeddedHtmlEditor.GetWebBrowserHTML(const WebBrowser: TWebBrowser): String;
var
  LStream: TStringStream;
  Stream : IStream;
  LPersistStreamInit : IPersistStreamInit;
begin
  if not Assigned(WebBrowser.Document) then exit;
  LStream := TStringStream.Create('');
  try
    LPersistStreamInit := WebBrowser.Document as IPersistStreamInit;
    Stream := TStreamAdapter.Create(LStream,soReference);
    LPersistStreamInit.Save(Stream,true);
    result := LStream.DataString;
  finally
    LStream.Free();
  end;
end;

end.
