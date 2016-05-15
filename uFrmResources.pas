unit uFrmResources;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, uDImages, Vcl.StdCtrls, sButton,
  cmpRoomerDataSet, hData, Vcl.ComCtrls, sListView, Vcl.ExtDlgs, sDialogs, cxClasses, cxPropertiesStore,
  System.IOUtils, Vcl.Menus, uMailDrop, uAppGlobal
  , ComObj
  , MSXML
  , ActiveX
  , clipbrd
  , uResourceManagement
  , Soap.EncdDecd, DragDrop, DropTarget, DropComboTarget, DropSource, DragDropFile, sLabel
;

type

  TFrmResources = class(TForm)
    sPanel1: TsPanel;
    btnInsert: TsButton;
    btnDelete: TsButton;
    btnClose: TsButton;
    lvResources: TListView;
    FormStore: TcxPropertiesStore;
    btnView: TsButton;
    PopupMenu1: TPopupMenu;
    D1: TMenuItem;
    D2: TMenuItem;
    U1: TMenuItem;
    V1: TMenuItem;
    dlgSaveFile: TsSaveDialog;
    dlgOpenFile: TsOpenDialog;
    pnlHolder: TsPanel;
    btnEdit: TsButton;
    sPanel2: TsPanel;
    sButton1: TsButton;
    sButton2: TsButton;
    btnRename: TsButton;
    N1: TMenuItem;
    C1: TMenuItem;
    btnSource: TsButton;
    DropComboTarget1: TDropComboTarget;
    P1: TMenuItem;
    C2: TMenuItem;
    N2: TMenuItem;
    DropFileSource1: TDropFileSource;
    sPanel3: TsPanel;
    sLabel1: TsLabel;
    edtFilter: TButtonedEdit;
    timFilter: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure lvResourcesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure lvResourcesDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lvResourcesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lvResourcesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnCloseClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure lvResourcesEdited(Sender: TObject; Item: TListItem; var S: string);
    procedure btnRenameClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure btnSourceClick(Sender: TObject);
    procedure DropComboTarget1Drop(Sender: TObject; ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
    procedure P1Click(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure lvResourcesColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvResourcesCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure edtFilterChange(Sender: TObject);
    procedure timFilterTimer(Sender: TObject);
    procedure edtFilterRightButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    Descending: Boolean;
    SortedColumn: Integer;
    CollectionOfOpenedFiles : TStringList;
    olmdd : TOlMailDragDrop;
    ResourceManagement : TRoomerResourceManagement;
//    procedure WMDROPFILES(var msg : TWMDropFiles) ; message WM_DROPFILES;

    procedure GetResources;
    procedure DisplayResources;
    procedure DownloadAndOpenSelectedResource;
    function DownloadSelectedFile(destFilename: String): Boolean;
    function getPrivateUriAdditionIfApplicable(slashBefore : Boolean): String;
    function getDirectUriAdditionIfApplicable(slashBefore: Boolean): String;
    function CreateFilePath(includePreface : Boolean = True): String;
    function getNewFilenameIfNeeded(filename : String; ResourceParameters: TResourceParameters): String;
    function Download: String;
    procedure DeleteCurrent;
    function FilenameInList(filename: String): Boolean;
    function GetUri: String;
    function GetTableInfo(KeyString: String): TRoomerDataSet;
  protected
//    procedure CreateWnd; override;
//    procedure DestroyWnd; override;
  public
    { Public declarations }
    keyString, access : String;
    ResourceParameters : TResourceParameters;

    embedded : Boolean;
    EmbedWindowCloseEvent : TNotifyEvent;

    procedure PrepareUserInterface;
    procedure BringWindowToFront;

    procedure RemoveFileForUpload(filename: String);

  end;


var
  FrmResources: TFrmResources;
  FrmResourcesX: TFrmResources;

procedure StaticResources(sCaption, keyString, access : String;
              _ResourceParameters : TResourceParameters = nil;
              embedPanel : TsPanel = nil;
              WindowCloseEvent : TNotifyEvent = nil);

implementation

{$R *.dfm}

uses  uD
    , uG
    , PrjConst
    , uFileSystemUtils
    , uRunWithElevatedOption
    , ShellApi
    , uRoomerLanguage
    , uFileDependencyManager
    , uUtils
    , Jpeg
    , pngimage
    , GIFImg
    , uFrmEmbeddedHtmlEditor
    , uDateUtils
    , uFrmNotepad
    , uFrmEditEmailProperties
    ;

procedure StaticResources(sCaption, keyString, access : String;
                _ResourceParameters : TResourceParameters = nil;
                embedPanel : TsPanel = nil;
                WindowCloseEvent : TNotifyEvent = nil);
var _FrmResources: TFrmResources;
begin
  _FrmResources := TFrmResources.Create(nil);
  try
    _FrmResources.Caption := sCaption;
    _FrmResources.keyString := keyString;
    _FrmResources.access := access;
    _FrmResources.ResourceParameters := _ResourceParameters;
    _FrmResources.embedded := (embedPanel <> nil);
    _FrmResources.EmbedWindowCloseEvent := WindowCloseEvent;
    _FrmResources.PrepareUserInterface;
    if _FrmResources.embedded then
    begin
      _FrmResources.pnlHolder.parent := embedPanel;
      embedPanel.Update;
      FrmResourcesX := _FrmResources;
    end
    else
    begin
      _FrmResources.ShowModal;
    end;
    ResetDependencyFileList;
  finally
    if (embedPanel = nil) then
      FreeAndNil(_FrmResources);
  end;
end;

function Download(url, filename : String) : String;
begin
  result := '';
  if d.roomerMainDataSet.DownloadFileResourceOpenAPI(url, filename) then
    result := filename;
end;

procedure TFrmResources.FormClose(Sender: TObject; var Action: TCloseAction);
var i : integer;
begin
  for i := 0 to Pred(CollectionOfOpenedFiles.Count) do
    if FileExists(CollectionOfOpenedFiles[i]) then
      if DeleteFile(CollectionOfOpenedFiles[i]) then
      ;

  Action := caFree;
  if embedded then
  begin
    pnlHolder.Parent := self;
    update;
    if Assigned(EmbedWindowCloseEvent) then
      EmbedWindowCloseEvent(self);
  end;
end;

procedure TFrmResources.FormCreate(Sender: TObject);
begin
  RoomerLanguage.TranslateThisForm(self);
  glb.PerformAuthenticationAssertion(self); PlaceFormOnVisibleMonitor(self);
  embedded := False;
  CollectionOfOpenedFiles := TStringList.Create;
end;

procedure TFrmResources.FormDestroy(Sender: TObject);
begin
  CollectionOfOpenedFiles.Free;
  ResourceManagement.Free;
end;

procedure TFrmResources.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    sButton1.Click;

end;

//procedure TFrmResources.CreateWnd;
//begin
//  inherited;
//  DragAcceptFiles(Handle, True);
//  olmdd := TOlMailDragDrop.Create(sPanel1);
//end;

procedure TFrmResources.D1Click(Sender: TObject);
var filename : String;
begin
  if NOT Assigned(lvResources.Selected) then
    exit;

  if Assigned(ResourceParameters) then
    dlgSaveFile.Filter := ResourceParameters.DefaultFileFilter;

  dlgSaveFile.FileName := lvResources.Selected.Caption;
  if dlgSaveFile.Execute then
  begin
    filename := ExtractFilename(dlgSaveFile.FileName);
    if NOT DownloadSelectedFile(filename) then
      raise Exception.Create('Unable to download file.');
  end;
end;

//procedure TFrmResources.DestroyWnd;
//begin
//  olmdd.Free;
//  DragAcceptFiles(Handle, False);
//  inherited;
//end;


procedure TFrmResources.BringWindowToFront;
begin
  pnlHolder.BringToFront;
end;

procedure TFrmResources.btnCloseClick(Sender: TObject);
begin
  if embedded then
    Close;
end;

procedure TFrmResources.btnDeleteClick(Sender: TObject);
begin
  DeleteCurrent;
end;

procedure TFrmResources.DeleteCurrent;
var i : Integer;
    item : TListItem;
begin
  for i := lvResources.Items.Count - 1 downto 0 do
  begin
    item := lvResources.Items[i];
    if item.Selected then
    begin
      d.roomerMainDataSet.DeleteFileResourceOpenAPI(item.SubItems[item.SubItems.Count - 1]);
      d.roomerMainDataSet.SystemDeleteStaticResource(Integer(item.Data));
      lvResources.Items.Delete(i);
    end;
  end;
end;

procedure ReCodeFile(filename : String);
var Strings : TStringList;
begin
  Strings := TStringList.Create;;
  try
    Strings.LoadFromFile(filename, TEncoding.UTF8);
    Strings.Text := ConvertToEncion(Strings.Text);
    Strings.SaveToFile(filename, TEncoding.UTF8);
  finally
    Strings.Free;
  end;
end;


procedure TFrmResources.btnEditClick(Sender: TObject);
var filename : String;
    Strings : TStrings;
    cmd,
    OrigName,
    Subject,
    path : String;
begin
  fileName := Download;
  if filename <> '' then
  begin
    if (ResourceParameters IS THtmlResourceParameters) then
    begin
      Subject := lvResources.Selected.SubItems[2];
      OrigName := lvResources.Selected.Caption;
      if EditHtmlFile(filename) then
      begin
        DeleteCurrent;
        ReCodeFile(filename);
        path := UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);

        cmd := format('UPDATE home100.HOTEL_RESOURCES SET ORIGINAL_NAME=''%s'', EXTRA_INFO=''%s'' WHERE HOTEL_ID=''%s'' AND ORIGINAL_NAME=''%s'' AND URI=''%s'' AND KEY_STRING=''%s''',
                   [ OrigName,
                     Subject,
                     d.roomerMainDataSet.HotelId,
                     OrigName,
                     path,
                     KeyString
                   ]);
        d.roomerMainDataSet.DoCommand(cmd);

        GetResources;
        DisplayResources;
      end;
    end else
    if (ResourceParameters IS TSqlResourceParameters) then
    begin
      Strings := TStringList.Create;
      Strings.LoadFromFile(filename);
      Strings.Text := EditText('SQL Query ' + ExtractFilename(filename), Strings.Text);
      Strings.SaveToFile(filename);

      DeleteCurrent;
      UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);
      GetResources;
      DisplayResources;
    end else
    if (ResourceParameters IS TTextResourceParameters) then
    begin
      Strings := TStringList.Create;
      Strings.LoadFromFile(filename);
      Strings.Text := EditText('Text template ' + ExtractFilename(filename), Strings.Text);
      Strings.SaveToFile(filename);

      DeleteCurrent;
      UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);
      GetResources;
      DisplayResources;
    end;
  end;
end;

function TFrmResources.FilenameInList(filename : String) : Boolean;
var
  i: Integer;
begin
  result := False;
  for i := 0 to lvResources.Items.Count - 1 do
    if Lowercase(lvResources.Items[i].Caption) = LowerCase(filename) then
    begin
      result := True;
      Break;
    end;
end;

const NEW_RESERVATION_SOURCE = '<P style="TEXT-ALIGN: right" align=right><FONT face=Verdana><STRONG><FONT color=maroon><FONT size=5>Test Hotel Roomer</FONT><BR></FONT></STRONG> ' +
                                  '<FONT size=1>Bosscheweg 107&nbsp;12-14<BR>5282 WV Boxtel<BR>Netherlands<BR>Tel: +31 85 27 36 150<BR>date/time: ${currentDatetime}<BR>---<BR></FONT><FONT size=2>Booking date: ${bookingDatetime}<BR>Hotel Booking id: ${bookingRoomerId}</FONT></FONT></P> ' +
                                  '<P><FONT face=Verdana>Dear ${bookingGuestName},</FONT></P> ' +
                                  '<P><FONT face=Verdana>Thank you for choosing Test Hotel&nbsp;Roomer as a destination during your stay in the Netherlands. We hope that your stay will be a pleasant one.</FONT></P> ' +
                                  '<P><FONT face=Verdana>Below you can find the details of your booking and&nbsp;some&nbsp;information about our hotel.</FONT></P> ' +
                                  '<P><FONT face=Verdana>You will be arriving on the ${bookingArrival} and departing on ${bookingDeparture}.<BR>Your booking ID: ${bookingRoomerId}</FONT></P> ' +
                                  '<P><FONT face=Verdana>Booking details:<BR>${bookingGuestsRoomsPrices}</FONT></P> ' +
                                  '<P><FONT face=Verdana>Price and payment details:</FONT></P><BR> ' +
                                  '<P><FONT face=Verdana>Total price: ${bookingTotalPrice}<BR>Booking payment type: ${bookingPaymentType}<BR>Payment status: ${bookingPaymentStatus}<BR>Amount paid: ${bookingPaymentAmount}<BR>Credit card: ${bookingPaymentCreditCard}</FONT></P> ' +
                                  '<P><FONT face=Verdana>We would like to use the opportunity to send you some information about the hotel and help you arrange for you transfers, tours and dinner reservations.</FONT></P> ' +
                                  '<P><FONT face=Verdana>The Hotels restaurant is open daily from 18.00 - 22.00. Our renowned chef, Tom Dans, was one of the winners of the TopChef TV series. He will make sure that your stay at our hotel is an unforgettable one.  ' +
                                  'We highly reccommend reserving a table in advance as capacity is limited.</FONT></P> ' +
                                  '<P><FONT face=Verdana>Included in hotel prices is one way to- or from the airport taxi ride. If you would like to use this service on arrival at the&nbsp;Einhoven airport,  ' +
                                  'please take the nearest taxi and we will pay for it on your arrival to Test Hotel Roomer. Should you want to arrange your own personal limo please contact us.</FONT></P> ' +
                                  '<P><FONT face=Verdana>We have a fitness center with a sauna and solarium which guests are free to use during their stay at no extra charge.</FONT></P> ' +
                                  '<P><FONT face=Verdana>If you would like to arrange a dinner at our restaurant, tours or private pickup please contact us by replying to this e-mail.</FONT></P> ' +
                                  '<P><FONT face=Verdana>Best regards,</FONT></P> ' +
                                  '<P><FONT face=Verdana>Your concierge at Test Hotel Roomer</FONT></P> ' +
                                  '<P><FONT face=Verdana>T. 085 27 36 150</FONT></P></DIV>';

const CANCEL_RESERVATION_SOURCE = '<DIV class=WordSection1> ' +
                                  '<P style="TEXT-ALIGN: right" align=right><STRONG><FONT color=maroon size=5 face=Verdana>Test Hotel Roomer</FONT></STRONG><BR>' +
                                  '<FONT size=1 face=Verdana>Bosscheweg 107&nbsp;12-14<BR>5282 WV Boxtel<BR>Netherlands<BR>Tel: +31 85 27 36 150<BR> ' +
                                  'date/time: ${currentDatetime}<BR>---<BR></FONT><FONT face=Verdana><FONT size=2>Booking date: ${bookingDatetime}<BR>Hotel Booking id: ${bookingRoomerId}<?xml:namespace prefix = "o" /><o:p></o:p></FONT></FONT></P> ' +
                                  '<P><FONT face=Verdana>Dear ${bookingGuestName},<o:p></o:p></FONT></P> ' +
                                  '<P><FONT face=Verdana>We are sorry to hear that you will not be staying with us at Test Hotel Roomer. <BR>Please find the details of your cancelled booking listed below.</FONT></P> ' +
                                  '<P><FONT face=Verdana>Booking details:<BR></FONT></P> ' +
                                  '<P><FONT face=Verdana>Arrival:&nbsp;${bookingArrival}<BR>Departure: </FONT><FONT face=Verdana>${bookingDeparture}<BR>Booking ID: ${bookingRoomerId}<o:p></o:p></FONT></P> ' +
                                  '<P><FONT face=Verdana>${bookingGuestsRoomsPrices}<o:p></o:p></FONT></P> ' +
                                  '<P><FONT face=Verdana>Price and payment details:<o:p></o:p></FONT></P> ' +
                                  '<P><FONT face=Verdana>Total price: ${bookingTotalPrice}<BR>Booking payment type: ${bookingPaymentType}<BR>Payment status: ${bookingPaymentStatus}<BR>Amount paid: ${bookingPaymentAmount}<BR>Credit card: ${bookingPaymentCreditCard}<o:p></o:p></FONT></P> ' +
                                  '<P><FONT face=Verdana>At your service,</FONT></P> ' +
                                  '<P><FONT face=Verdana>Test Hotel Roomer</FONT></P> ' +
                                  '<P><FONT face=Verdana>T. 085 27 36 150</FONT></P>';


procedure TFrmResources.btnInsertClick(Sender: TObject);
var i : Integer;
    ext, tempDir, filename, Subject : String;
    Strings : TStrings;
    _FrmEditEmailProperties : TFrmEditEmailProperties;
    cmd, uri : String;
begin
  if Assigned(ResourceParameters) AND
     (ResourceParameters IS THtmlResourceParameters) then
  begin
    i := 0;
    ext := '.html';
    tempDir := GetTempDir;
    Subject := '';
    if KeyString=GUEST_EMAIL_TEMPLATE then
    begin
      filename := 'Booking_Confirmation_' + dateToSqlString(now) + ext;
      Subject := 'Thank you for your booking';
    end else
    if KeyString=CANCEL_EMAIL_TEMPLATE then
    begin
      filename := 'Cancel_Confirmation_' + dateToSqlString(now) + ext;
      Subject := 'We are sorry you are not staying with us';
    end;
    while FilenameInList(filename) do
    begin
      inc(i);
      if KeyString=GUEST_EMAIL_TEMPLATE then
        filename := 'Booking_Confirmation_' + dateToSqlString(now) + '(' + inttostr(i) + ')' + ext
      else
      if KeyString=CANCEL_EMAIL_TEMPLATE then
        filename := 'Cancel_Confirmation_' + dateToSqlString(now) + '(' + inttostr(i) + ')' + ext
      else
        filename := 'eml_' + dateToSqlString(now) + '(' + inttostr(i) + ')' + ext;
    end;

    _FrmEditEmailProperties := TFrmEditEmailProperties.Create(nil);
    try
      if ResourceParameters IS THtmlResourceParameters then
      begin
        _FrmEditEmailProperties.edtName.Text := filename;
        _FrmEditEmailProperties.edtSubject.Text := Subject;
        if _FrmEditEmailProperties.ShowModal = mrOk then
        begin
          if _FrmEditEmailProperties.edtName.Text = '' then
            raise Exception.Create(GetTranslatedText('shUI_NameCannotBeEmpty'));

          filename := TPath.Combine(tempDir, _FrmEditEmailProperties.edtName.Text);
          Strings := TStringList.Create;
          try
            if KeyString=GUEST_EMAIL_TEMPLATE then
              Strings.Text := NEW_RESERVATION_SOURCE
            else
            if KeyString=CANCEL_EMAIL_TEMPLATE then
              Strings.Text := CANCEL_RESERVATION_SOURCE;
            Strings.SaveToFile(filename);
          finally
            Strings.Free;
          end;
          if EditHtmlFile(filename, true) then
          begin
            ReCodeFile(filename);
            uri := UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);

            cmd := format('UPDATE home100.HOTEL_RESOURCES SET EXTRA_INFO=''%s'' WHERE HOTEL_ID=''%s'' AND ORIGINAL_NAME=''%s'' AND URI=''%s'' AND KEY_STRING=''%s''',
                     [ _FrmEditEmailProperties.edtSubject.Text,
                       d.roomerMainDataSet.HotelId,
                       _FrmEditEmailProperties.edtName.Text,
                       uri, KeyString
                     ]);
            d.roomerMainDataSet.DoCommand(cmd);

            GetResources;
            DisplayResources;
          end;
        end;
      end else
        lvResources.Selected.EditCaption;
    finally
      FreeAndNil(_FrmEditEmailProperties);
    end;


  end else
  if Assigned(ResourceParameters) AND
     (ResourceParameters IS TSqlResourceParameters) then
  begin
    i := 0;
    ext := '.sql';
    tempDir := GetTempDir;
    filename := 'sql_' + dateToSqlString(now) + ext;
    while FilenameInList(filename) do
    begin
      inc(i);
      filename := 'sql_' + dateToSqlString(now) + '(' + inttostr(i) + ')' + ext;
    end;
    fileName := InputBox('New SQL file', 'Please enter a name for the new file', filename);
    if filename <> '' then
    begin
      filename := TPath.Combine(tempDir, filename);
      Strings := TStringList.Create;
      Strings.Text := EditText('SQL Query ' + ExtractFilename(filename), Strings.Text);
      Strings.SaveToFile(filename);

      DeleteCurrent;
      UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);
      GetResources;
      DisplayResources;
    end;
  end else
  if Assigned(ResourceParameters) AND
     (ResourceParameters IS TTextResourceParameters) then
  begin
    i := 0;
    ext := '.txt';
    tempDir := GetTempDir;
    filename := 'text_' + dateToSqlString(now) + ext;
    while FilenameInList(filename) do
    begin
      inc(i);
      filename := 'text_' + dateToSqlString(now) + '(' + inttostr(i) + ')' + ext;
    end;
    fileName := InputBox('New text file', 'Please enter a name for the new file', filename);
    if filename <> '' then
    begin
      filename := TPath.Combine(tempDir, filename);
      Strings := TStringList.Create;
      Strings.Text := EditText('Text template ' + ExtractFilename(filename), Strings.Text);
      Strings.SaveToFile(filename);

      DeleteCurrent;
      UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);
      GetResources;
      DisplayResources;
    end;
  end else
  begin
    if Assigned(ResourceParameters) then
      dlgSaveFile.Filter := ResourceParameters.DefaultFileFilter;

    if dlgOpenFile.Execute then
    begin
      for i := 0 to dlgOpenFile.Files.Count - 1 do
      begin
        filename := dlgOpenFile.Files[i];
        UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);
        GetResources;
        DisplayResources;
      end;
    end;
  end;
end;

procedure TFrmResources.GetResources;
begin
  ResourceManagement.Refresh;
end;

function TFrmResources.GetTableInfo(KeyString: String): TRoomerDataSet;
begin

end;

function TFrmResources.GetUri : String;
begin
  result := '';
  if lvResources.Selected <> nil then
    result := lvResources.Selected.SubItems[lvResources.Selected.SubItems.Count-1];

end;

procedure TFrmResources.btnRenameClick(Sender: TObject);
var
  _FrmEditEmailProperties: TFrmEditEmailProperties;
  cmd : String;
begin
  if lvResources.Selected <> nil then
  begin
    _FrmEditEmailProperties := TFrmEditEmailProperties.Create(nil);
    try
      if ResourceParameters IS THtmlResourceParameters then
      begin
        _FrmEditEmailProperties.edtName.Text := lvResources.Selected.Caption;
        _FrmEditEmailProperties.edtSubject.Text := lvResources.Selected.SubItems[2];
        if _FrmEditEmailProperties.ShowModal = mrOk then
        begin
          if _FrmEditEmailProperties.edtName.Text = '' then
            raise Exception.Create(GetTranslatedText('shUI_NameCannotBeEmpty'));

          cmd := format('UPDATE hotelconfigurations SET DefaultChannelConfirmationEmail=''%s'' WHERE DefaultChannelConfirmationEmail=''%s''',
                     [_FrmEditEmailProperties.edtName.Text, lvResources.Selected.Caption]);
          d.roomerMainDataSet.DoCommand(cmd);

          cmd := format('UPDATE home100.HOTEL_RESOURCES SET ORIGINAL_NAME=''%s'', EXTRA_INFO=''%s'' WHERE HOTEL_ID=''%s'' AND ORIGINAL_NAME=''%s'' AND URI=''%s'' AND KEY_STRING=''%s''',
                     [ _FrmEditEmailProperties.edtName.Text,
                       _FrmEditEmailProperties.edtSubject.Text,
                       d.roomerMainDataSet.HotelId,
                       lvResources.Selected.Caption,
                       lvResources.Selected.SubItems[lvResources.Selected.SubItems.Count - 1], KeyString
                     ]);
          d.roomerMainDataSet.DoCommand(cmd);
          lvResources.Selected.Caption := _FrmEditEmailProperties.edtName.Text;
          lvResources.Selected.SubItems[2] := _FrmEditEmailProperties.edtSubject.Text;
        end;
      end else
        lvResources.Selected.EditCaption;
    finally
      FreeAndNil(_FrmEditEmailProperties);
    end;
  end;
end;

procedure TFrmResources.btnSourceClick(Sender: TObject);
var filename : String;
    Strings : TStrings;
    cmd,
    OrigName,
    Subject,
    path : String;
begin
  fileName := Download;
  if filename <> '' then
  begin
    if (ResourceParameters IS THtmlResourceParameters) then
    begin
      Subject := lvResources.Selected.SubItems[2];
      OrigName := lvResources.Selected.Caption;
      if EditHtmlSource(filename) then
      begin
        DeleteCurrent;
        ReCodeFile(filename);
        path := UploadFileToResources(keyString, access, ExtractFilename(filename), filename, ResourceParameters);

        cmd := format('UPDATE home100.HOTEL_RESOURCES SET ORIGINAL_NAME=''%s'', EXTRA_INFO=''%s'' WHERE HOTEL_ID=''%s'' AND ORIGINAL_NAME=''%s'' AND URI=''%s'' AND KEY_STRING=''%s''',
                   [ OrigName,
                     Subject,
                     d.roomerMainDataSet.HotelId,
                     OrigName,
                     path,
                     KeyString
                   ]);
        d.roomerMainDataSet.DoCommand(cmd);

        GetResources;
        DisplayResources;
      end;
    end;
  end;
end;

procedure TFrmResources.edtFilterChange(Sender: TObject);
begin
  timFilter.Enabled := False;
  timFilter.Interval := 500;
  timFilter.Enabled := True;
end;

procedure TFrmResources.edtFilterRightButtonClick(Sender: TObject);
begin
  edtFilter.Text := '';
end;

function TFrmResources.getPrivateUriAdditionIfApplicable(slashBefore : Boolean) : String;
begin
  if ACCESS_RESTRICTED = access then
  begin
     if slashBefore then
     result := '/private'
  else
     result := 'private/';
  end
  else
     result := '';
end;

function TFrmResources.getDirectUriAdditionIfApplicable(slashBefore : Boolean) : String;
begin
  if ACCESS_RESTRICTED <> access then
  begin
     if slashBefore then
       result := '/direct'
     else
       result := 'direct/';
  end else
  begin
     if slashBefore then
       result := '/private'
     else
       result := 'private/';
  end;
end;

function TFrmResources.getNewFilenameIfNeeded(filename: String; ResourceParameters: TResourceParameters): String;
begin

end;

procedure TFrmResources.DisplayResources;
var i : Integer;
    item : TListItem;
    srch : String;
    date, user : String;
    filter : String;
begin
  lvResources.Items.Clear;
  lvResources.Items.BeginUpdate;
  filter := UpperCase(edtFilter.Text);
  try
    for i := 0 to ResourceManagement.Count - 1 do

    begin
      if access = 'OPEN' then
        srch := '/direct/'
      else
        srch := '/private/';
      if (LowerCase(ResourceManagement.Resources[i].KEY_STRING) = LowerCase(KeyString)) AND (POS(srch, ResourceManagement.Resources[i].URI) > 0) then
      begin
        user := '';
        glb.LocateSpecificRecordAndGetValue('staffmembers', 'id', ResourceManagement.Resources[i].USER_ID, 'Initials', user);
        date := uDateUtils.RoomerDateTimeToString(ResourceManagement.Resources[i].LAST_MODIFIED);
        if (filter = '') OR
           (
            (POS(filter, UpperCase(ResourceManagement.Resources[i].ORIGINAL_NAME)) > 0) OR
            (POS(filter, UpperCase(ResourceManagement.Resources[i].FEXTRA_INFO)) > 0) OR
            (POS(filter, UpperCase(ResourceManagement.Resources[i].FURI)) > 0) OR
            (POS(filter, UpperCase(user)) > 0) OR
            (POS(filter, UpperCase(date)) > 0)
           ) then
        begin
          item := lvResources.Items.Add;
          item.Caption := ResourceManagement.Resources[i].ORIGINAL_NAME;
          item.Data := Pointer(ResourceManagement.Resources[i].ID);
          item.SubItems.Add(user);
          item.SubItems.Add(date);
          if (ResourceParameters IS THtmlResourceParameters) then
            item.SubItems.Add(TRIM(ResourceManagement.Resources[i].EXTRA_INFO));
          item.SubItems.Add(TRIM(ResourceManagement.Resources[i].URI));
        end;
      end;
    end;
  finally
    lvResources.Items.EndUpdate;
  end;
end;

procedure TFrmResources.lvResourcesColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := False;
  end
  else
    Descending := not Descending;
  TListView(Sender).SortType := stText;
end;

procedure TFrmResources.lvResourcesCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then
     Compare := CompareText(Item1.Caption, Item2.Caption)
  else
  if SortedColumn <> 0 then
  begin
    if SortedColumn = 2 then
      Compare := CompareText(uDateUtils.DateTimeToDBString(uDateUtils.RoomerStringToDateTime(Item1.SubItems[SortedColumn-1])),
                             uDateUtils.DateTimeToDBString(uDateUtils.RoomerStringToDateTime(Item2.SubItems[SortedColumn-1])))
    else
      Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
  end;
  if Descending then Compare := -Compare;
end;

procedure TFrmResources.lvResourcesDblClick(Sender: TObject);
begin
  DownloadAndOpenSelectedResource;
end;

procedure TFrmResources.lvResourcesDragDrop(Sender, Source: TObject; X, Y: Integer);
var maildrop : TOlMailDrop;
    i : Integer;
begin
  if (Source is TOlMailDrop) then
  begin
     maildrop:=TOlMailDrop(Source);
     for i:=0 to maildrop.ItemCount-1 do
     begin
        with lvResources.Items.Add do
        begin
           Caption:=maildrop.Items[i].From;
           SubItems.Add(d.roomerMainDataSet.username);
           SubItems.Add(uDateUtils.RoomerDateTimeToString(now));
           SubItems.Add(maildrop.Items[i].Subject);
//           SubItems.Add(maildrop.Items[i].Received);
//           SubItems.Add(maildrop.Items[i].Size);
           // Body is also available
           // maildrop.Items[i].Body
        end;
     end;
  end;
end;

procedure TFrmResources.lvResourcesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True; // (Source is TOlMailDrop);
end;

procedure TFrmResources.lvResourcesEdited(Sender: TObject; Item: TListItem; var S: string);
var cmd : String;
begin
  if S = '' then
    raise Exception.Create(GetTranslatedText('shUI_NameCannotBeEmpty'));

  cmd := format('UPDATE hotelconfigurations SET DefaultChannelConfirmationEmail=''%s'' WHERE DefaultChannelConfirmationEmail=''%s''',
             [S, item.Caption]);
  d.roomerMainDataSet.DoCommand(cmd);

  cmd := format('UPDATE home100.HOTEL_RESOURCES SET ORIGINAL_NAME=''%s'' WHERE HOTEL_ID=''%s'' AND ORIGINAL_NAME=''%s'' AND URI=''%s'' AND KEY_STRING=''%s''',
             [S, d.roomerMainDataSet.HotelId, item.Caption, item.SubItems[item.SubItems.Count - 1], KeyString]);
  d.roomerMainDataSet.DoCommand(cmd);

end;

procedure TFrmResources.DownloadAndOpenSelectedResource;
var filename, tmpFile : String;
begin
  Screen.Cursor := crHourglass;
  fileName := Download;
  if filename <> '' then
  begin
    tmpFile := filename;
    if (ResourceParameters IS THtmlResourceParameters) then
    begin
      tmpFile := TPath.Combine(GetTempDir, changeFileExt(filename, '.html'));
      if UpperCase(tmpFile) <> UpperCase(filename) then
      begin
        if FileExists(tmpFile) then DeleteFile(tmpFile);
        TFile.Move(filename, tmpFile);
      end;
    end else
    if (ResourceParameters IS TTextResourceParameters) then
    begin
      tmpFile := TPath.Combine(GetTempDir, changeFileExt(filename, '.txt'));
      if UpperCase(tmpFile) <> UpperCase(filename) then
      begin
        if FileExists(tmpFile) then DeleteFile(tmpFile);
        TFile.Move(filename, tmpFile);
      end;
    end;

    if NOT (ResourceParameters IS TSqlResourceParameters) then
      ShellExecute(Self.WindowHandle, 'open', PChar(tmpFile), nil, nil, SW_SHOWNORMAL);
    CollectionOfOpenedFiles.Add(tmpFile);
  end;
end;

function TFrmResources.Download : String;
var filename : String;
    item : TListItem;
begin
  result := '';
  Screen.Cursor := crHourglass;
  try
    if lvResources.Selected <> nil then
    begin
      item := lvResources.Selected;
      fileName := TPath.Combine(GetTempDir, lvResources.Selected.Caption);
      if DownloadSelectedFile(filename) then
        result := filename;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmResources.C1Click(Sender: TObject);
var item : TListItem;
begin
  if lvResources.Selected <> nil then
  begin
    item := lvResources.Selected;
    Clipboard.AsText := item.SubItems[item.SubItems.Count - 1];
  end;
end;

procedure TFrmResources.C2Click(Sender: TObject);
var filename : String;
begin
  fileName := Download;
  DropFileSource1.Files.Clear;
  DropFileSource1.Files.Add(filename);
  DropFileSource1.CopyToClipboard;
end;

function TFrmResources.CreateFilePath(includePreface: Boolean): String;
begin

end;

//function TFrmResources.CreateFilePath(includePreface : Boolean = True) : String;
//var preface : String;
//begin
//  preface := '';
//  if includePreface then
//    preface := getDirectUriAdditionIfApplicable(false);
//  result := format('staticresources/%sresourcebundles/%s/%s%s/%s',
//                     [preface,
//                      UpperCase(d.roomerMainDataSet.hotelId),
//                      g.qApplicationID, getPrivateUriAdditionIfApplicable(true), keyString]);
//end;

function TFrmResources.DownloadSelectedFile(destFilename : String) : Boolean;
var item : TListItem;
begin
  Result := false;
  if lvResources.Selected <> nil then
  begin
    item := lvResources.Selected;
    if FileExists(destFilename) then
      DeleteFile(destFilename);

    result := DownloadResource(item.SubItems[item.SubItems.Count - 1], destFilename);
  end;
end;

procedure TFrmResources.DropComboTarget1Drop(Sender: TObject; ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
begin
  DropComboTargetDrop(keyString, access, Sender AS TDropComboTarget, ShiftState, APoint, Effect);
  GetResources;
  DisplayResources;
end;

procedure TFrmResources.lvResourcesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnDelete.Enabled := lvResources.Selected <> nil;
  btnRename.Enabled := lvResources.Selected <> nil;
  btnView.Enabled := (lvResources.Selected <> nil) AND
                      (NOT (ResourceParameters IS TSqlResourceParameters));
  btnEdit.Enabled := (lvResources.Selected <> nil) AND
                     Assigned(ResourceParameters) AND
                     (
                       (ResourceParameters IS THtmlResourceParameters) OR
                       (ResourceParameters IS TSqlResourceParameters) OR
                       (ResourceParameters IS TTextResourceParameters)
                     );
  btnEdit.Visible := btnEdit.Enabled;

  btnSource.Enabled := (lvResources.Selected <> nil) AND
                        Assigned(ResourceParameters) AND
                       (ResourceParameters IS THtmlResourceParameters);
  btnSource.Visible := btnSource.Enabled;

  v1.Enabled := lvResources.Selected <> nil;
  d1.Enabled := lvResources.Selected <> nil;
  d2.Enabled := lvResources.Selected <> nil;
  c2.Enabled := lvResources.Selected <> nil;

  btnSource.Left := 4000;
end;

procedure TFrmResources.P1Click(Sender: TObject);
begin
  if DropComboTarget1.CanPasteFromClipboard then
    DropComboTarget1.PasteFromClipboard;
end;

procedure TFrmResources.PopupMenu1Popup(Sender: TObject);
begin
  P1.Enabled := DropComboTarget1.CanPasteFromClipboard;
end;

procedure TFrmResources.PrepareUserInterface;
var col : TListColumn;
begin
  ResourceManagement := TRoomerResourceManagement.Create(KeyString, Access, ResourceParameters);

  if NOT (ResourceParameters IS THtmlResourceParameters) then
  begin
    lvResources.Columns.Clear;
    col := lvResources.Columns.Add;
    col.Width := 250;
    col.Caption := '';

    col := lvResources.Columns.Add;
    col.Width := 50;
    col.Caption := '';

    col := lvResources.Columns.Add;
    col.Width := 130;
    col.Caption := '';

    col := lvResources.Columns.Add;
    col.Width := 450;
    col.Caption := 'URI';

    btnRename.Caption := GetTranslatedText('shUI_RenameFile');
  end else
    lvResources.Columns[3].Caption := GetTranslatedText('shUI_Subject');

  lvResources.Columns[0].Caption := GetTranslatedText('shUI_Filename');
  lvResources.Columns[1].Caption := GetTranslatedText('shUI_User');
  lvResources.Columns[2].Caption := GetTranslatedText('shUI_DateTime');

  GetResources;
  DisplayResources;
end;

procedure TFrmResources.RemoveFileForUpload(filename: String);
begin
  ResourceManagement.RemoveFileForUpload(filename);
end;

procedure TFrmResources.timFilterTimer(Sender: TObject);
begin
  timFilter.Enabled := false;
  DisplayResources;
end;

//procedure TFrmResources.WMDROPFILES(var msg: TWMDropFiles);
//const
//   MAXFILENAME = 255;
//var
//  cnt, fileCount : integer;
//  fileName : array [0..MAXFILENAME] of char;
//begin
//  // how many files dropped?
//  fileCount := DragQueryFile(msg.Drop, $FFFFFFFF, fileName, MAXFILENAME) ;
//
//  // query for file names
//  for cnt := 0 to -1 + fileCount do
//  begin
//    DragQueryFile(msg.Drop, cnt, fileName, MAXFILENAME) ;
//    if UploadFile(keyString, access, filename) = '' then
//    begin
//	    ShowMessage(format(GetTranslatedText('shTx_ManageFiles_UnableToUpload'), [filename]));
//      break;
//    end;
//  end;
//  GetResources;
//  DisplayResources;
//
//  //release memory
//  DragFinish(msg.Drop) ;
//end;


end.
