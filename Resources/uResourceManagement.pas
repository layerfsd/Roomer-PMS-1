unit uResourceManagement;

interface

uses Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Types, SysUtils, System.IOUtils,
     System.Generics.Collections, DragDropFile, DropComboTarget, cmpRoomerDataSet
     ;

const
  ROOM_IMAGES_STATIC_RESOURCE_PATTERN = 'ROOMIMAGE_%s';
  ROOM_CLASS_IMAGES_STATIC_RESOURCE_PATTERN = 'ROOMCLASSIMAGE_%s';
  CUSTOMER_DOCUMENTS_STATIC_RESOURCE_PATTERN = 'CUSTOMERRESOURCES_%s';
  BOOKING_STATIC_RESOURCES = 'BOOKING_RESOURCE_%s';
  ROOM_BOOKING_STATIC_RESOURCES = 'ROOM_BOOKING_RESOURCE_%s';
  GUEST_STATIC_RESOURCES = 'GUEST_RESOURCE_%s';
  ANY_FILE = 'ANY_FILE';
  GUEST_EMAIL_TEMPLATE = 'GUEST_EMAIL_TEMPLATE';
  CANCEL_EMAIL_TEMPLATE = 'CANCEL_EMAIL_TEMPLATE';
  HOTEL_SQL_RESOURCE = 'HOTEL_SQL_RESOURCE';
  TEXT_BASED_TEMPLATES = 'TEXT_BASED_TEMPLATES';

  ACCESS_OPEN = 'OPEN';
  ACCESS_RESTRICTED = 'RESTRICTED';

type

  TResourceParameters = class
    FPerformTransformation : Boolean;
    FDefaultFileFilter : String;
  private
    constructor Create(_PerformTransformation : Boolean; _FileFilter : String);
  public
    property PerformTransformation : Boolean read FPerformTransformation;
    property DefaultFileFilter : String read FDefaultFileFilter;
  end;

  TImageResourceParameters = class(TResourceParameters)
    MaxWidth, MaxHeight : Integer;
    BackColor : TColor;
  private
  public
    constructor Create(_MaxWidth, _MaxHeight : Integer; _BackColor : TColor);
  end;

  THtmlResourceParameters = class(TResourceParameters)
  private
  public
    constructor Create;
  end;

  TSqlResourceParameters = class(TResourceParameters)
  private
  public
    constructor Create;
  end;

  TTextResourceParameters = class(TResourceParameters)
  private
  public
    constructor Create;
  end;

  TResource = class
      FKEY_STRING : String;
      FORIGINAL_NAME : String;
      FID : Integer;
      FEXTRA_INFO : String;
      FURI : String;
      FUSER_ID : Integer;
      FLAST_MODIFIED : TDateTime;
  public
      Constructor Create(_KEY_STRING : String;
                         _ORIGINAL_NAME : String;
                         _ID : Integer;
                         _EXTRA_INFO : String;
                         _URI : String;
                         _USER_ID : Integer;
                         _LAST_MODIFIED : TDateTime);

      property KEY_STRING : String read FKEY_STRING write FKEY_STRING;
      property ORIGINAL_NAME : String read FORIGINAL_NAME write FORIGINAL_NAME;
      property ID : Integer read FID write FID;
      property EXTRA_INFO : String read FEXTRA_INFO write FEXTRA_INFO;
      property URI : String read FURI write FURI;
      property USER_ID : Integer read FUSER_ID write FUSER_ID;
      property LAST_MODIFIED : TDateTime read FLAST_MODIFIED write FLAST_MODIFIED;
  end;

  TRoomerResourceManagement = class
    KeyString,
    Access : String;
    ResourceParameters : TResourceParameters;

    Resources : TObjectList<TResource>;
  private
    procedure GetResources;
    function GetTableInfo: TRoomerDataSet;
    function GetTableInfoOpen: TRoomerDataSet;
    function GetCount: Integer;
    function GetResource(index: Integer): TResource;
  public
    constructor Create(_KeyString, _Access : String; _ResourceParameters : TResourceParameters = nil);
    destructor Destroy;

    procedure Refresh;

    procedure RemoveFileForUpload(filename: String);
    function UploadFile(onlyFilename, filename: String): String;
    function DownloadResourceByName(name: String; var Subject: String): String;
    function StaticResourceListAsStrings: TStrings;

    property Count : Integer read GetCount;
    property Resource[index : Integer] : TResource read GetResource;
  end;

function UploadFileToResources(KeyString, Access : String; onlyFilename, filename : String; ResourceParameters : TResourceParameters = nil) : String;
procedure DropComboTargetDrop(KeyString, Access : String; Sender: TDropComboTarget; ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
procedure parseResourceXml(xmlStr : String; var path, filename, error : String; var success : boolean);
function getNewFilenameIfNeeded(filename : String; ResourceParameters : TResourceParameters) : String;
function DownloadResource(sourceFilename, destFilename: String): Boolean;

implementation

uses uD, ActiveX, ComObj, uUtils, Winapi.msxml, Dialogs, hData, PrjConst;


// ------------------ Free-Fall implementations ----------------------

procedure parseResourceXml(xmlStr : String; var path, filename, error : String; var success : boolean);
var
  xml: OLEVariant; // IXMLDOMDocument;
  node, node1: OLEVariant; // IXMLDomNode;
  nodeName : String;
  nodes_row, nodes_se: OLEVariant; // IXMLDomNodeList;
  i, l : Integer;
begin
  path := ''; filename := ''; success := False;
  Coinitialize(nil);
  xml := CreateOleObject('Microsoft.XMLDOM') as IXMLDOMDocument;
  xml.async := False;
  xml.loadXML(xmlStr);
  xml.SetProperty('SelectionNamespaces', 'xmlns:a="http://www.promoir.nl/roomer/static/resources/2014/04"');
  nodes_row := xml.selectNodes('/a:AddStaticResourceResponse/a:staticResource');
  for i := 0 to nodes_row.length - 1 do
  begin
    node := nodes_row.item(i);
    for l := 0 to node.childNodes.length - 1 do
    begin
      node1 := node.childNodes(l);
      nodeName := node1.nodeName;
      // ns3:key
      // 1234567                                       // 12345678
      if (copy(nodeName, length(nodeName) - 7, 8)      = 'filename') then
        filename := node1.text
      else if (copy(nodeName, length(nodeName) - 3, 4) = 'path') then
        path := node1.text
      else if (copy(nodeName, length(nodeName) - 4, 5) = 'error') then
        error := node1.text
      else if (copy(nodeName, length(nodeName) - 6, 7) = 'success') then
        success := node1.text = 'true';
    end;
  end;
end;

function getNewFilenameIfNeeded(filename : String; ResourceParameters : TResourceParameters) : String;
begin
  result := filename;
  if Assigned(ResourceParameters) AND (ResourceParameters IS TImageResourceParameters) then
  begin
    with ResourceParameters AS TImageResourceParameters do
      result := ResizeImageToNewTempFile(filename, MaxWidth, MaxHeight, BackColor);
  end;
end;

procedure DropComboTargetDrop(KeyString, Access : String; Sender: TDropComboTarget; ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  Stream: TStream;
  i: integer;
  filename, Name: string;
begin
  // Extract and display dropped data.
  if (Sender.Files.Count > 0) AND (Sender.Data.Count = 0) then
  begin
    for i := 0 to Sender.Files.Count-1 do
    begin
      filename := Sender.Files[i];
      if UploadFileToResources(KeyString, Access, ExtractFilename(filename), filename) = '' then
      begin
        ShowMessage(format(GetTranslatedText('shTx_ManageFiles_UnableToUpload'), [filename]));
        break;
      end;
    end;
  end else
  begin
    for i := 0 to Sender.Data.Count-1 do
    begin
      Name := Sender.Data.Names[i];
      if (Name = '') then
        Name := intToStr(i)+'.dat';
      filename := Name;
      if NOT fileExists(Name) then
      begin
        filename := TPath.Combine(TPath.GetTempPath, Name);
        if fileExists(filename) then
          DeleteFile(filename);
      end;
      Sender.Data[i].Position := 0;
      Stream := TFileStream.Create(filename, fmCreate);
      try
        // Copy dropped data to stream (in this case a file stream).
        Stream.CopyFrom(Sender.Data[i], Sender.Data[i].Size);
      finally
        Stream.Free;
      end;
      if UploadFileToResources(KeyString, Access, ExtractFilename(filename), filename) = '' then
      begin
        ShowMessage(format(GetTranslatedText('shTx_ManageFiles_UnableToUpload'), [filename]));
        break;
      end;
    end;
  end;
end;

function UploadFileToResources(KeyString, Access : String; onlyFilename, filename : String; ResourceParameters : TResourceParameters = nil) : String;
var resultURI : String;
    path, resFilename, error : String;
    success : Boolean;
begin
  result := '';
  try
//    onlyFilename := ExtractFilename(filename);
    filename := getNewFilenameIfNeeded(filename, ResourceParameters);
    resultURI := d.roomerMainDataSet.PostFileOpenApi('staticresources',
          filename,
          KeyString,
          '',  // content type: 'image/' + ExtractFileExt(filename),
          ACCESS_RESTRICTED = Access);
    parseResourceXml(resultURI, path, resFilename, error, success);
    if success then
      d.roomerMainDataSet.SystemAddStaticResource(KeyString,
          onlyFilename,
          path,
          Access)
    else
      raise Exception.Create('Unable to upload file: ' + error);
    result := path;
  except
    result := '';
  end;
end;

function DownloadResource(sourceFilename, destFilename : String) : Boolean;
begin
  result := d.roomerMainDataSet.DownloadFileResourceOpenAPI(sourceFilename, destFilename);
end;


// ------------------ TRoomerResourceManagement ----------------------

constructor TRoomerResourceManagement.Create(_KeyString, _Access : String; _ResourceParameters : TResourceParameters = nil);
begin
  Resources := TObjectList<TResource>.Create(true);
  Access := _Access;
  KeyString := _KeyString;
  ResourceParameters := _ResourceParameters;
  Refresh;
end;

destructor TRoomerResourceManagement.Destroy;
begin
 // --
  Resources.Free;
end;

function TRoomerResourceManagement.GetTableInfoOpen: TRoomerDataSet;
var sql : String;
begin
  result := CreateNewDataSet;
  sql := format('SELECT * FROM home100.HOTEL_RESOURCES WHERE HOTEL_ID=''%s'' AND KEY_STRING=''%s''',
                            [d.roomerMainDataset.hotelId, KeyString]);
  rSet_bySQL(result, sql, false);

  result.OpenDataset(result.SystemGetStaticResourcesFiltered(KeyString));
end;

function TRoomerResourceManagement.DownloadResourceByName(name : String;
  var Subject : String): String;
var
  TempFilename: string;
  i: Integer;
begin
  result := '';
  for i := 0 to Resources.Count - 1 do
  begin
    if (Resources[i].ORIGINAL_NAME = name) then
    begin
      Subject := Resources[i].EXTRA_INFO;
      TempFilename := TPath.Combine(TPath.GetTempPath, name);
      if DownloadResource(Resources[i].URI, TempFilename) then
        result := TempFilename;
      Break;
    end;
  end;
end;

function TRoomerResourceManagement.StaticResourceListAsStrings : TStrings;
var i : Integer;
begin
  result := TStringlist.Create;
  for i := 0 to Resources.Count - 1 do
  begin
    result.Add(Resources[i].ORIGINAL_NAME);
  end;
end;

function TRoomerResourceManagement.GetCount: Integer;
begin
  result :=  Resources.Count;
end;

function TRoomerResourceManagement.GetTableInfo: TRoomerDataSet;
var sql : String;
begin
  result := CreateNewDataSet;
  sql := format('SELECT * FROM home100.HOTEL_RESOURCES WHERE HOTEL_ID=''%s'' AND KEY_STRING=''%s''',
                            [d.roomerMainDataset.hotelId, KeyString]);
  rSet_bySQL(result, sql, false);
  result.OpenDataset(result.SystemGetStaticResourcesFiltered(KeyString));
end;

function TRoomerResourceManagement.GetResource(index: Integer): TResource;
begin
  result := Resources[index];
end;

procedure TRoomerResourceManagement.GetResources;
var ResourceSet : TRoomerDataSet;
begin
  Resources.Clear;
  ResourceSet := GetTableInfo;
  try
    ResourceSet.First;
    while NOT ResourceSet.Eof do
    begin
      Resources.Add(TResource.Create(ResourceSet['KEY_STRING'],
                                     ResourceSet['ORIGINAL_NAME'],
                                     ResourceSet['ID'],
                                     ResourceSet['EXTRA_INFO'],
                                     ResourceSet['URI'],
                                     ResourceSet['USER_ID'],
                                     ResourceSet['LAST_MODIFIED']));
      ResourceSet.Next;
    end;
  finally
    FreeAndNil(ResourceSet);
  end;
end;


procedure TRoomerResourceManagement.RemoveFileForUpload(filename : String);
var
  i: Integer;
begin
  for i := 0 to Resources.Count - 1 do
  begin
    if Lowercase(ExtractFilename(filename)) = Lowercase(Resources[i].ORIGINAL_NAME) then
    begin
      d.roomerMainDataSet.DeleteFileResourceOpenAPI(Resources[i].URI);
      d.roomerMainDataSet.SystemDeleteStaticResource(Resources[i].ID);
      Break;
    end;
  end;
end;


procedure TRoomerResourceManagement.Refresh;
begin
  GetResources;
end;

function TRoomerResourceManagement.UploadFile(onlyFilename, filename : String) : String;
var resultURI : String;
    path, resFilename, error : String;
    success : Boolean;
begin
  result := '';
  try
    onlyFilename := ExtractFilename(filename);
    filename := getNewFilenameIfNeeded(filename, ResourceParameters);
    resultURI := d.roomerMainDataSet.PostFileOpenApi('staticresources',
          filename,
          KeyString,
          '',  // content type: 'image/' + ExtractFileExt(filename),
          ACCESS_RESTRICTED = Access);
    parseResourceXml(resultURI, path, resFilename, error, success);
    if success then
      d.roomerMainDataSet.SystemAddStaticResource(KeyString,
          onlyFilename,
          path,
          Access)
    else
      raise Exception.Create('Unable to upload file: ' + error);
    result := path;
  except
    result := '';
  end;
end;

{ TResourceParameters }

constructor TResourceParameters.Create(_PerformTransformation: Boolean; _FileFilter : String);
begin
  FPerformTransformation := _PerformTransformation;
  FDefaultFileFilter := _FileFilter;
end;

{ TImageResourceParameters }

constructor TImageResourceParameters.Create(_MaxWidth, _MaxHeight: Integer; _BackColor : TColor);
begin
  inherited Create(true, 'Images (*.jpg;*.png;*.bmp;*.gif)|*.jpg;*.png;*.bmp;*.gif|Videos (*.wmv;*.avi;*.mp4)|*.wmv;*.avi;*.mp4|Sound (*.mp3)|*.mp3|Any file (*.*)|*.*');
  MaxWidth := _MaxWidth;
  MaxHeight := _MaxHeight;
  BackColor := _BackColor;
end;

{ THtmlResourceParameters }

constructor THtmlResourceParameters.Create;
begin
  inherited Create(true, 'Html files (*.htm;*.html)|*.htm;*.html|Text files (*.txt)|*.txt|Any file (*.*)|*.*');
end;

{ TSqlResourceParameters }

constructor TSqlResourceParameters.Create;
begin
  inherited Create(true, 'Sql files (*.sql)|*.sql|Text files (*.txt)|*.txt|Any file (*.*)|*.*');
end;

{ TTextResourceParameters }

constructor TTextResourceParameters.Create;
begin
  inherited Create(true, 'Text files (*.txt)|*.txt|Any file (*.*)|*.*');
end;


{ TResource }

constructor TResource.Create(_KEY_STRING, _ORIGINAL_NAME: String; _ID: Integer; _EXTRA_INFO, _URI: String;
                         _USER_ID : Integer;
                         _LAST_MODIFIED : TDateTime);
begin
  KEY_STRING := _KEY_STRING;
  ORIGINAL_NAME := _ORIGINAL_NAME;
  ID := _ID;
  EXTRA_INFO := _EXTRA_INFO;
  URI := _URI;
  USER_ID := _USER_ID;
  LAST_MODIFIED := _LAST_MODIFIED;
end;

end.
