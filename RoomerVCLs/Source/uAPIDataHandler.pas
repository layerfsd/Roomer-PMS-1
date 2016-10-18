unit uAPIDataHandler;

interface

uses MSXML2_TLB, Data.Win.ADODB, Data.DB, RoomerCloudEntities, System.Generics.Collections;

type

  TRoomerFileType = (rftTemplates, rftImages, rftContracts, rftRoomer);


  TFieldsAndValues = record
    field: string;
    dataType : string;
    Value: variant;
  end;
  array_of_TFieldsAndValues = array of TFieldsAndValues;

  TFileEntity = class
  private
    FName: String;
    FLastModified: TDateTime;
    FFileType: Char;
    FSize: integer;
  public
    constructor Create(filename : String;
                       size : integer;
                       lastModified : TDateTime;
                       fileType : char {'D'/'F' = Dir/File}
                       );
    destructor Destroy; override;

    property name : String read FName;
    property size : integer read FSize;
    property lastModified : TDateTime read FLastModified;
    property fileType : Char read FFileType;
  end;

  TFileList = class
  private
    FList : TObjectList<TFileEntity>;
    function GetCount: integer;
    function GetFiles(_index: integer): TFileEntity;
  public
    constructor Create(xmlList : String);
    destructor Destroy; override;

    function add(fileEntity : TFileEntity) : Integer;
    property Count : integer read GetCount;
    property Files[_index : integer] : TFileEntity read GetFiles;
  end;

function getXmlFromJavaEntity(recordSet: string): string;
function getXmlFromRecordSet(rs: _Recordset): string;
//function getXmlFromRecord(rec: _RecordSet): string;
function XMLToRecordset(const someXML: string): _Recordset;
function generateRecordXml(data : array of TFieldsAndValues) : string;
function SQLToXML(const aConnection: TAdoConnection;
  const aSQLCommand: string): string;

//  TDictionary<string, TStringlist>

implementation

uses ComObj, ActiveX, ADOInt, uStringUtils, uDateUtils, SysUtils, ExtCtrls,
     StdCtrls, Controls, Classes
     , XMLUtils;

const
  RECORDSET_SCHEMA_HEADER
    : string = '<xml xmlns:s="uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882"' +
    '   xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"' +
    '   xmlns:rs="urn:schemas-microsoft-com:rowset"' +
    '   xmlns:z="#RowsetSchema">' + '<s:Schema id="RowsetSchema">' +
    '<s:ElementType name="row" content="eltOnly" rs:updatable="true">';

const
  RECORDSET_SCHEMA_FOOTER: string = '</s:ElementType>' + '</s:Schema>' +
    '<rs:data>';

const
  RECORDSET_SCHEMA_COLUMN: string = '<s:AttributeType name="%s"' +
    ' rs:number="%d"' // field index
    + ' rs:nullable="%s"' // true/false
    + ' rs:writeunknown="%s"' // true/false
    + ' rs:basecatalog="%s"' // catalog (DB name) i.e. 'homeData'
    + ' rs:basetable="%s"' // table name
    + ' rs:basecolumn="%s">' // column name
    + '<s:datatype dt:type="%s"' // datatype, i.e. 'string'
    + ' dt:maxLength="%s"/>' // Maxlength of field
    + '</s:AttributeType>';

const
  RECORDSET_DATA_FOOTER: string = '</rs:data>' + '</xml>';

const
  RECORDSET_DATA_ROW: string = '<z:row %s />';

const
  RECORDSET_DATA_VALUE: string = '%s="%s" ';

function getXmlFromRecordSet(rs: _Recordset): string;
var
  xml: IXMLDOMDocument2;
begin
  // Streams _Recordset into XML
  xml := CreateXmlDocument; // CoDOMDocument40.Create;
  rs.Save(xml, adPersistXML);
  rs.Close;
  result := xml.xml;
end;

function SQLToXML(const aConnection: TAdoConnection;
  const aSQLCommand: string): string;
var
  rs: _Recordset;
begin
  // Creates a disconnected recordset that will be streamed into XML
  rs := CoRecordset.Create;
  rs.CursorLocation := adUseClient;
  rs.Open(aSQLCommand, aConnection.ConnectionObject, adOpenForwardOnly,
    adLockBatchOptimistic, 0);
  result := getXmlFromRecordSet(rs);
end;

function XMLToRecordset(const someXML: string): _Recordset;
var
  xml: IXMLDOMDocument2;
  rs: OleVariant;
  temp : string;
begin
  xml := CreateXmlDocument; // CoDOMDocument40.Create;
  temp := someXML;
  CopyToClipboard(temp);
//  temp := StringReplace(someXML, 'dt:type=''tinyint''', 'dt:type=''boolean''',
//                          [rfReplaceAll, rfIgnoreCase]);
  try
    xml.LoadXML(temp);
  except
    raise Exception.Create('Roomer PMS got a incorrect result from server.');
  end;
  rs := CoRecordset.Create;
  rs.Open(xml);

  result := IUnknown(rs) as _Recordset;
end;

// ************************************************************************

function getXmlFromJavaEntity(recordSet: string): string;
var
  col: integer;
  row: string;
  lbl: String;
  dataAsString: string;

  XML : IXMLDOMDocument2;

  nlistData,
  nlist               : IXMLDOMNodelist;

  i : Integer;

  entity : ShortString;
  strTemp : ShortString;

BEGIN
  XML := CreateXmlDocument; //CreateOleObject('MSXML2.DOMDocument.6.0') as IXMLDOMDocument2;
  XML.async := false;
  XML.SetProperty('SelectionLanguage','XPath');
  XML.loadXml(recordSet);

  nlist := XML.getElementsByTagName('column');

  result := RECORDSET_SCHEMA_HEADER;

  for i:=0 to nlist.Get_length-1 do
  begin
    result := result + format(RECORDSET_SCHEMA_COLUMN,
      [nlist.Get_item(i).attributes.getNamedItem('name').text,
      i + 1,
      'true',
      'false',
      'roomer', 'roomer',
      nlist.Get_item(i).attributes.getNamedItem('name').text,
      nlist.Get_item(i).attributes.getNamedItem('type').text,
      nlist.Get_item(i).attributes.getNamedItem('length').text]);
      if entity = '' then
      begin
        entity := ShortString(nlist.Get_item(i).attributes.getNamedItem(WideString('entity')).text);
        strTemp := ShortString(entity[1] + ShortString(' '));
        strTemp := ShortString(LowerCase(String(strTemp)));
        entity[1] := (strTemp[1]);
      end;

  end;
  result := result + RECORDSET_SCHEMA_FOOTER;



  nlist := XML.getElementsByTagName(WideString(entity));

  for i:=0 to nlist.Get_length-1 do
  begin
    row := '';
    nlistData := nlist.Get_item(i).childNodes;
    for col := 0 to nlistData.Get_length-1 do
    begin
      lbl := nlistData.Get_item(col).nodeName;
      dataAsString := nlistData.Get_item(col).text;
      dataAsString := XMLEncode_ex(dataAsString, dataAsString);
      row := row + format(RECORDSET_DATA_VALUE, [lbl, dataAsString]);
    end;
    result := result + format(RECORDSET_DATA_ROW, [row]);
  end;

  result := result + RECORDSET_DATA_FOOTER;


//
//  columns := recordSet.columns;
//  for col := Low(columns) to High(columns) do
//  begin
//    result := result + format(RECORDSET_SCHEMA_COLUMN,
//      [columns[col].name_, columns[col].index_,
//      boolToString(columns[col].nullable),
//      boolToString(columns[col].writeunknown),
//      columns[col].basecatalog, columns[col].basetable,
//      columns[col].basecolumn, columns[col].datatype,
//      columns[col].maxLength]);
//  end;
//  result := result + RECORDSET_SCHEMA_FOOTER;
//
//  recordCounter := 0;
//  dataClusters := recordSet.values;
//  records := Low(dataClusters);
//  while records <= High(dataClusters) - High(columns) do
//  begin
//    row := '';
//    for col := Low(columns) to High(columns) do
//    begin
//      lbl := columns[col].name_;
//      dataAsString := findValue(lbl + '.' + inttostr(recordCounter), records,
//        dataClusters);
//      row := row + format(RECORDSET_DATA_VALUE, [lbl, dataAsString]);
//
//    end;
//    result := result + format(RECORDSET_DATA_ROW, [row]);
//
//    records := records + (High(columns) - Low(columns));
//    recordCounter := recordCounter + 1;
//  end;
//
//  result := result + RECORDSET_DATA_FOOTER;

end;

//function getXmlFromRecord(rec: _RecordSet): string;
//var
//  col: integer;
//  records: integer;
//  row: string;
//  lbl: String;
//  dataAsString: string;
//
//  dataClusters: Array_Of_string;
//  columns: Fields;
//  recordCounter: integer;
//
//begin
//  result := RECORDSET_SCHEMA_HEADER;
//
//  columns := rec.Fields;
//  for col := 0 to columns.Count - 1 do
//  begin
//    result := result + format(RECORDSET_SCHEMA_COLUMN,
//      [columns[col].Name, col + 1,
//      boolToString(true),
//      boolToString(true),
//      columns[col].Properties., columns[col].basetable,
//      columns[col].basecolumn, columns[col].datatype,
//      columns[col].maxLength]);
//  end;
//  result := result + RECORDSET_SCHEMA_FOOTER;
//
//  recordCounter := 0;
//  dataClusters := recordSet.values;
//  records := Low(dataClusters);
//  while records <= High(dataClusters) - High(columns) do
//  begin
//    row := '';
//    for col := Low(columns) to High(columns) do
//    begin
//      lbl := recordSet.columns[col].name_;
//      dataAsString := findValue(lbl + '.' + inttostr(recordCounter), records,
//        dataClusters);
//      row := row + format(RECORDSET_DATA_VALUE, [lbl, dataAsString]);
//
//    end;
//    result := result + format(RECORDSET_DATA_ROW, [row]);
//
//    records := records + (High(columns) - Low(columns));
//    recordCounter := recordCounter + 1;
//  end;
//
//  result := result + RECORDSET_DATA_FOOTER;
//
//end;

//function findValue(key: String; const startAt: integer;
//  valueList: Array_Of_string): String;
//var
//  counter: integer;
//  txt: string;
//begin
//  key := key + '=';
//  result := '';
//  for counter := startAt to High(valueList) do
//    if key = Copy(valueList[counter], 1, length(key)) then
//    begin
//      txt := Copy(valueList[counter], length(key) + 1);
//      result := txt;
//    end;
//
//end;

function generateRecordXml(data : array of TFieldsAndValues) : string;
var
  col: integer;
  counter : integer;

  row: string;
  dataAsString: string;
begin
  result := RECORDSET_SCHEMA_HEADER;

  counter := 0;
  row := '';
  for col := Low(data) to High(data) do
  begin
    inc(counter);
    result := result + format(RECORDSET_SCHEMA_COLUMN,
      [data[col].field, counter,
      'true', 'true', '', '',
      data[col].field, data[col].dataType,
      0]);

    dataAsString := data[col].Value;
    row := row + format(RECORDSET_DATA_VALUE, [data[col].field, dataAsString]);

  end;
  result := result +  RECORDSET_SCHEMA_FOOTER +
                      format(RECORDSET_DATA_ROW, [row]) +
                      RECORDSET_DATA_FOOTER;
end;

// ************************************************************************

procedure getFileListFromXml(fileList : TFileList; recordSet: string);
var
  XML : IXMLDOMDocument2;
  nlist               : IXMLDOMNodelist;
  i : Integer;
  _type : char;
BEGIN
  XML := CreateXmlDocument; // CreateOleObject('MSXML2.DOMDocument.6.0') as IXMLDOMDocument2;
  XML.async := false;
  XML.SetProperty('SelectionLanguage','XPath');
  XML.loadXml(recordSet);

  nlist := XML.getElementsByTagName('file');

  for i:=0 to nlist.Get_length-1 do
  begin
    _type := 'F';
    if nlist.Get_item(i).attributes.getNamedItem('name').text = 'dir' then
      _type := 'D';
    fileList.Add(TFileEntity.Create(
        nlist.Get_item(i).attributes.getNamedItem('name').text,
        strtoint(nlist.Get_item(i).attributes.getNamedItem('size').text),
        XmlStringToDate(nlist.Get_item(i).attributes.getNamedItem('lastModified').text),
        _type
        )
    );
  end;

end;


{ TFileEntity }

constructor TFileEntity.Create(filename: String; size: integer; lastModified: TDateTime; fileType: char);
begin
  inherited Create;
  FName := filename;
  FSize := size;
  FLastModified := lastModified;
  FFileType := fileType;
end;

destructor TFileEntity.Destroy;
begin
  inherited;
end;

{ TFileList }

function TFileList.add(fileEntity: TFileEntity): Integer;
begin
  result := FList.Add(fileEntity);
end;

constructor TFileList.Create(xmlList: String);
begin
  inherited Create;
  FList := TObjectList<TFileEntity>.Create;
  getFileListFromXml(self, xmlList);
end;

destructor TFileList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TFileList.GetCount: integer;
begin
  result := FList.Count;
end;

function TFileList.GetFiles(_index: integer) : TFileEntity;
begin
  result := FList[_index];
end;

end.

