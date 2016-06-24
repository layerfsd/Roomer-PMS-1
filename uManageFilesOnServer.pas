unit uManageFilesOnServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB, cmpRoomerDataSet, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus, sDialogs, acPathDialog,
  cxPropertiesStore, uAPIDataHandler, Vcl.ImgList, cxClasses, sPanel;

Const
  USER_EDITLISTVIEW = WM_USER + 666;

type
  TfrmManageFilesOnServer = class(TForm)
    lvfileList: TListView;
    Panel1: TsPanel;
    cbxFileTypes: TComboBox;
    PopupMenu1: TPopupMenu;
    D1: TMenuItem;
    R1: TMenuItem;
    D2: TMenuItem;
    U1: TMenuItem;
    dlgSave: TsSaveDialog;
    dlgPath: TsPathDialog;
    FormStore: TcxPropertiesStore;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxFileTypesChange(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure lvfileListClick(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lvfileListDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    ListViewEditor: TEdit;
    LItem: TListitem;

    CollectionOfOpenedFiles : TStrings;
    procedure ShowSelectedFileGroup;
    procedure ListViewEditorExit(Sender: TObject);
    function GetFilePathForListView(filename: String; stamp : TDateTime): String;
    procedure UploadKnownFilesToStaticResources;
    function DownloadFile(RemoteName, LocalName: String): String;
  protected
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    { Private declarations }
  public
    { Public declarations }
    RoomerDataSet1: TRoomerDataSet;
    procedure UserEditListView( Var Message: TMessage ); message USER_EDITLISTVIEW;
    procedure WMDROPFILES(var msg : TWMDropFiles) ; message WM_DROPFILES;
  end;

var
  frmManageFilesOnServer: TfrmManageFilesOnServer;
  _FileList : TFileList = nil;
  _FileType : TRoomerFileType;
  _RoomerDataSet: TRoomerDataSet;
  _RoomerLocalAppPath : String;
  _RoomerTempPath : String;


procedure ManageFiles(UseRoomerDataSet: TRoomerDataSet);
procedure UploadKnownFilesToStaticResourceBundle(UseRoomerDataSet: TRoomerDataSet);

procedure ReadFileList(RoomerDataSet: TRoomerDataSet; fileType : TRoomerFileType);
function getFilePath(filename : String) : String;
function findFile(filename: String) : TFileEntity;
function GetCurrenctRoomerPath : String;

implementation

{$R *.dfm}

uses ShellApi,
     CommCtrl,
     ioUtils,
     uDateUtils,
     uFileSystemUtils,
     uG
     , uAppGlobal
     , PrjConst
     , uResourceManagement
     , uUtils
     , UITypes
     ;

const
  EDIT_COLUMN = 1; //Index of the column to Edit

procedure ManageFiles(UseRoomerDataSet: TRoomerDataSet);
begin
  Application.CreateForm(TfrmManageFilesOnServer, frmManageFilesOnServer);
  try
    frmManageFilesOnServer.RoomerDataSet1 := UseRoomerDataSet;
    frmManageFilesOnServer.ShowModal;
  finally
    frmManageFilesOnServer.free;
  end;
end;

procedure UploadKnownFilesToStaticResourceBundle(UseRoomerDataSet: TRoomerDataSet);
begin
  Application.CreateForm(TfrmManageFilesOnServer, frmManageFilesOnServer);
  try
    frmManageFilesOnServer.RoomerDataSet1 := UseRoomerDataSet;
    frmManageFilesOnServer.UploadKnownFilesToStaticResources;
  finally
    frmManageFilesOnServer.free;
  end;
end;


procedure TfrmManageFilesOnServer.ShowSelectedFileGroup;
var item : TListItem;
    i: Integer;
    FileList : TFileList;
    description : String;
    localFilename : String;
    Icon : TIcon;
    FileInfo: SHFILEINFO;
begin
  lvfileList.items.BeginUpdate;
  lvfileList.Clear;
  Icon := TIcon.Create;
  try
    FileList := RoomerDataSet1.SystemListFiles(cbxFileTypes.ItemIndex);
    try
      for i := 0 to Pred(FileList.Count) do
      begin
        item := lvfileList.Items.Add;
        localFilename := GetFilePathForListView(FileList.Files[i].name, FileList.Files[i].lastModified);
        description := getSHFileType(localFilename); // Trim(GetFileTypeDescription(FileList.Files[i].name));
        item.SubItems.Add(FileList.Files[i].name);
        item.SubItems.Add(DateTimeToStr(FileList.Files[i].lastModified));
        item.SubItems.Add(description);
        item.SubItems.Add(FormatByteSize(FileList.Files[i].size));
        SHGetFileInfo(PChar(localFilename), 0, FileInfo, SizeOf(FileInfo), SHGFI_ICON);
        Icon.Handle := FileInfo.hIcon;
        item.ImageIndex := ImageList1.AddIcon(Icon);
      end;
    finally
      FileList.Free;
    end;
  finally
    lvfileList.items.EndUpdate;
    Icon.free;
  end;
end;

procedure TfrmManageFilesOnServer.UploadKnownFilesToStaticResources;
var i: Integer;
    FileList : TFileList;

    localFilename : String;
begin
    FileList := RoomerDataSet1.SystemListFiles(cbxFileTypes.ItemIndex);
    try
      for i := 0 to Pred(FileList.Count) do
      begin
        localFilename := GetEnvironmentVariable('TEMP') + '\' + FileList.Files[i].name;
        if FileExists(localFilename) then
          DeleteFile(localFilename);

        DownloadResource(FileList.Files[i].name, localFilename);
        CollectionOfOpenedFiles.Add(localFilename);
        UploadFileToResources(ANY_FILE, ACCESS_RESTRICTED, ExtractFilename(localFilename), localFilename)
      end;
    finally
      FileList.Free;
    end;
end;

function TfrmManageFilesOnServer.GetFilePathForListView(filename : String; stamp : TDateTime) : String;
begin
  result := TPath.Combine(GetCurrenctRoomerPath, filename);
  if NOT FileExists(result) then
  begin
    result := TPath.Combine(_RoomerTempPath, filename);
    if NOT FileExists(result) then
      TouchNewFile(result, stamp);
  end;
end;

procedure TfrmManageFilesOnServer.cbxFileTypesChange(Sender: TObject);
begin
  ShowSelectedFileGroup;
end;

procedure TfrmManageFilesOnServer.D1Click(Sender: TObject);
var
  i: Integer;
begin
  if lvfileList.SelCount = 1 then
  begin
    dlgSave.FileName := lvfileList.Selected.SubItems[0];
    if dlgSave.Execute(self.Handle) then
    begin
      RoomerDataSet1.SystemDownloadFile(cbxFileTypes.ItemIndex,
          lvfileList.Selected.SubItems[0],
          dlgSave.FileName);
    end;
  end else
  begin
    if dlgPath.Execute then
    begin
      for i := 0 to Pred(lvfileList.Items.Count) do
        if lvfileList.Items[i].Selected then
        begin
          RoomerDataSet1.SystemDownloadFile(cbxFileTypes.ItemIndex,
              lvfileList.Items[i].SubItems[0],
              dlgPath.Path + '\' + lvfileList.Items[i].SubItems[0]);
        end;
    end;
  end;
end;

procedure TfrmManageFilesOnServer.D2Click(Sender: TObject);
var i : integer;
    allSelected : Boolean;
    sel : integer;
begin
  allSelected := false;
  sel := 0;
  for i := 0 to Pred(lvfileList.Items.Count) do
    if lvfileList.Items[i].Selected then
    begin
      if NOT allSelected then
      begin
      //   sel := MessageDlg(format('Do you want to delete file "%s"?', [lvfileList.Items[i].SubItems[0]]),
                //  mtConfirmation, [mbYes, mbNo, mbAll, mbCancel], 0);
    		sel := MessageDlg(format(GetTranslatedText('shTx_ManageFiles_Delete'), [lvfileList.Items[i].SubItems[0]]),
               mtConfirmation, [mbYes, mbNo, mbAll, mbCancel], 0);
        if sel = mrAll then
          allSelected := true
        else
          if sel = mrCancel then
            exit;
      end;
      if allSelected OR (sel = mrYes) then
        RoomerDataSet1.SystemDeleteFile(cbxFileTypes.ItemIndex,
            lvfileList.Items[i].SubItems[0]);
    end;

  ShowSelectedFileGroup;
end;

procedure TfrmManageFilesOnServer.FormClose(Sender: TObject; var Action: TCloseAction);
var i : integer;
begin
  for i := 0 to Pred(CollectionOfOpenedFiles.Count) do
    if FileExists(CollectionOfOpenedFiles[i]) then
      if DeleteFile(CollectionOfOpenedFiles[i]) then
      ;
end;

procedure TfrmManageFilesOnServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ReadFileList(RoomerDataSet1, rftTemplates)
end;

procedure TfrmManageFilesOnServer.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
     glb.PerformAuthenticationAssertion(self);
  PlaceFormOnVisibleMonitor(self);
  lvfileList.Clear;

//  DragAcceptFiles( lvfileList.WindowHandle, True ) ;

  //create the TEdit and assign the OnExit event
  ListViewEditor := TEdit.Create(Self);
  ListViewEditor.Parent := lvfileList;
  ListViewEditor.OnExit := ListViewEditorExit;
  ListViewEditor.Visible := False;

  CollectionOfOpenedFiles := TStringList.Create;

end;

procedure TfrmManageFilesOnServer.CreateWnd;
begin
  inherited;
  DragAcceptFiles(Handle, True);
end;

procedure TfrmManageFilesOnServer.DestroyWnd;
begin
  DragAcceptFiles(Handle, False);
  inherited;
end;

procedure TfrmManageFilesOnServer.ListViewEditorExit(Sender: TObject);
begin
  If Assigned(LItem) Then
  Begin
    if LItem.SubItems[ EDIT_COLUMN-1 ] <> ListViewEditor.Text then
    begin
      RoomerDataSet1.SystemRenameFile(cbxFileTypes.ItemIndex,
          LItem.SubItems[ EDIT_COLUMN-1 ],
          ListViewEditor.Text);
      //assign the vslue of the TEdit to the Subitem
      LItem.SubItems[ EDIT_COLUMN-1 ] := ListViewEditor.Text;
    end;
    LItem := nil;
    ListViewEditor.Visible := False;
  End;
end;

procedure TfrmManageFilesOnServer.lvfileListClick(Sender: TObject);
//var
//  LPoint: TPoint;
//  LVHitTestInfo: TLVHitTestInfo;
begin
//  LPoint:= lvfileList.ScreenToClient(Mouse.CursorPos);
//  ZeroMemory( @LVHitTestInfo, SizeOf(LVHitTestInfo));
//  LVHitTestInfo.pt := LPoint;
//  //Check if the click was made in the column to edit
//  If (lvfileList.perform( LVM_SUBITEMHITTEST, 0, LPARAM(@LVHitTestInfo))<>-1) and ( LVHitTestInfo.iSubItem = EDIT_COLUMN ) Then
//    PostMessage( self.Handle, USER_EDITLISTVIEW, LVHitTestInfo.iItem, 0 )
//  else
//    ListViewEditor.Visible:=False; //hide the TEdit
end;

procedure TfrmManageFilesOnServer.lvfileListDblClick(Sender: TObject);
var sTempName : String;
begin
  sTempName := GetEnvironmentVariable('TEMP') + '\' + lvfileList.Selected.SubItems[0];
  DownloadFile(lvfileList.Selected.SubItems[0], sTempName);
  CollectionOfOpenedFiles.Add(sTempName);
  ShellExecute(Handle, 'open', PChar(sTempName), nil, nil, SW_SHOWNORMAL)
end;

function TfrmManageFilesOnServer.DownloadFile(RemoteName, LocalName : String) : String;
begin
  RoomerDataSet1.SystemDownloadFile(0,
      RemoteName,
      LocalName);
  result := LocalName;
end;

procedure TfrmManageFilesOnServer.UserEditListView(var Message: TMessage);
var
  LRect: TRect;
begin
  LRect.Top := EDIT_COLUMN;
  LRect.Left:= LVIR_BOUNDS;
  lvfileList.Perform( LVM_GETSUBITEMRECT, Message.wparam,  LPARAM(@LRect) );
  MapWindowPoints( lvfileList.Handle, ListViewEditor.Parent.Handle, LRect, 2 );
  //get the current Item to edit
  LItem := lvfileList.Items[ Message.wparam ];
  //set the text of the Edit
  ListViewEditor.Text := LItem.Subitems[ EDIT_COLUMN-1];
  //set the bounds of the TEdit
  ListViewEditor.BoundsRect := LRect;
  //Show the TEdit
  ListViewEditor.Visible:=True;
end;

procedure TfrmManageFilesOnServer.FormDestroy(Sender: TObject);
begin
//  DragAcceptFiles(WindowHandle, False);
  try CollectionOfOpenedFiles.Free; except end;
end;

procedure TfrmManageFilesOnServer.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ActiveControl = ListViewEditor then
    if Key=#13 then
      ListViewEditorExit(ListViewEditor);
end;

procedure TfrmManageFilesOnServer.FormShow(Sender: TObject);
begin
  ShowSelectedFileGroup;
end;

procedure TfrmManageFilesOnServer.PopupMenu1Popup(Sender: TObject);
begin
  D1.Enabled := lvfileList.SelCount > 0;
  R1.Enabled := lvfileList.SelCount = 1;
  D2.Enabled := lvfileList.SelCount > 0;
end;

procedure TfrmManageFilesOnServer.R1Click(Sender: TObject);
begin
  PostMessage( self.Handle, USER_EDITLISTVIEW, lvfileList.Selected.Index, 0 )
end;

procedure TfrmManageFilesOnServer.WMDROPFILES(var msg: TWMDropFiles);
const
   MAXFILENAME = 255;
var
  cnt, fileCount : integer;
  fileName : array [0..MAXFILENAME] of char;
begin
  // how many files dropped?
  fileCount := DragQueryFile(msg.Drop, $FFFFFFFF, fileName, MAXFILENAME) ;

  // query for file names
  for cnt := 0 to -1 + fileCount do
  begin
    DragQueryFile(msg.Drop, cnt, fileName, MAXFILENAME) ;
    if NOT RoomerDataSet1.SystemUploadFile(filename, cbxFileTypes.ItemIndex) then
    begin
	    ShowMessage(format(GetTranslatedText('shTx_ManageFiles_UnableToUpload'), [filename]));
      break;
    end;
  end;

  //release memory
  DragFinish(msg.Drop) ;
  ShowSelectedFileGroup;
end;

function GetCurrenctRoomerPath : String;
begin
  result := TPath.Combine(_RoomerLocalAppPath, g.qHotelCode);
  if NOT DirectoryExists(result) then
    ForceDirectories(result);
end;

procedure ReadFileList(RoomerDataSet: TRoomerDataSet; fileType : TRoomerFileType);
begin
  if assigned(_FileList) then
    _FileList.Free;
  _FileList := RoomerDataSet.SystemListFiles(ORD(fileType));
  _FileType := fileType;
  _RoomerDataSet := RoomerDataSet;
end;

function getFilePath(filename : String) : String;
var sFullFilename : String;
    DateOfFile : TDateTime;
    RemoteFile : TFileEntity;
begin
  if _FileList = nil then
    raise Exception.Create(GetTranslatedText('shTx_ManageFiles_RetrieveList'));
  filename := ExtractFileName(filename);
  sFullFilename := TPath.Combine(GetCurrenctRoomerPath, filename);
  DateOfFile := 0;
  if FileExists(sFullFilename) then
    FileAge(sFullFilename, DateOfFile);

  RemoteFile := findFile(filename);
  if RemoteFile = nil then
    result := ''
  else
  begin
    if DateTimeToComparableString(DateOfFile) <> DateTimeToComparableString(RemoteFile.lastModified) then
    begin
      _RoomerDataSet.SystemDownloadFile(ORD(_FileType), filename, sFullFilename);
      TouchFile(sFullFilename, RemoteFile.lastModified);
    end;
    result := sFullFilename;
  end;
end;

function findFile(filename: String) : TFileEntity;
var i : integer;
begin
  result := nil;
  for i := 0 to _FileList.Count - 1 do
    if Lowercase(_FileList.Files[i].name) = Lowercase(filename) then
    begin
      result := _FileList.Files[i];
      Break;
    end;

end;

initialization

  _RoomerLocalAppPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  forceDirectories(_RoomerLocalAppPath);
  _RoomerTempPath := TPath.Combine(GetTempDir, 'Roomer');
  forceDirectories(_RoomerTempPath);


finalization
  _FileList.Free;

end.
