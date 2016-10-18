unit XmlUtils;

interface

uses
  System.Classes
  , SysUtils
  , XMLDoc
  , XMLIntf
  , xmldom
  , MSXML2_TLB
  , ActiveX
  ;

function CreateXmlDocument : IXMLDOMDocument2; overload;
function CreateXMLDocument( var Owner1: TComponent): TXMLDocument; overload;
function XPATHSelect( const FocusNode: IXMLNode; const sXPath: string): TArray<IXMLNode>;
function XPATHSelectFirst( const FocusNode: IXMLNode; const sXPath: string; var SelectedNode: IXMLNode): boolean;
function GetAttributeValue(Node: IXMLDomNode; AttribName, defaultValue: String): String;

implementation

function GetAttributeValue(Node: IXMLDomNode; AttribName, defaultValue: String): String;
var
  i: Integer;
begin
  Result := defaultValue;
  for i := 0 to Node.Attributes.length - 1 do
    if Node.Attributes.item[i].nodeName = AttribName then
    begin
      Result := Node.Attributes.item[i].Text;
      Break;
    end;
end;


function CreateXmlDocument : IXMLDOMDocument2;
begin
  CoInitialize(nil);
  try
    try
      result := MSXML2_TLB.CoDOMDocument60.Create;
    except // Not registered? Try version 6...
      result := CoDOMDocument60.Create;
    end;
  finally
    CoUninitialize;
  end;
end;



function CreateXMLDocument( var Owner1: TComponent): TXMLDocument;
begin
  Owner1 := TComponent.Create( nil);
  result  := TXMLDocument.Create( Owner1);
  result.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull,
                     doAutoPrefix, doNamespaceDecl];
  result.DOMVendor := GetDOMVendor( 'MSXML');
end;

function XPATHSelect( const FocusNode: IXMLNode; const sXPath: string): TArray<IXMLNode>;
var
  DomNodeSelect: IDomNodeSelect;
  DOMNode      : IDomNode;
  DocAccess    : IXmlDocumentAccess;
  Doc          : TXmlDocument;
  DOMNodes     : IDOMNodeList;
  iDOMNode     : integer;
begin
  SetLength( result, 0);
  if assigned( FocusNode) and
     Supports( FocusNode.DOMNode, IDomNodeSelect, DomNodeSelect) then
      DOMNodes := DomNodeSelect.SelectNodes( sXPath);
  if not assigned( DOMNodes) then exit;
  SetLength( result, DOMNodes.Length);
  for iDOMNode := 0 to DOMNodes.Length - 1 do
    begin
      Doc := nil;
      DOMNode := DOMNodes.item[iDOMNode];
      if Supports( DOMNode, IXmlDocumentAccess, DocAccess) then
        Doc := DocAccess.DocumentObject;
      result[ iDOMNode] := TXmlNode.Create( DOMNode, nil, Doc) as IXMLNode;
    end
end;

function XPATHSelectFirst( const FocusNode: IXMLNode; const sXPath: string; var SelectedNode: IXMLNode): boolean;
var
  DomNodeSelect: IDomNodeSelect;
  DOMNode      : IDomNode;
  DocAccess    : IXmlDocumentAccess;
  Doc          : TXmlDocument;
begin
  SelectedNode := nil;
  Doc := nil;
  if assigned( FocusNode) and
     Supports( FocusNode.DOMNode, IDomNodeSelect, DomNodeSelect) then
    DOMNode := DomNodeSelect.selectNode( sXPath);
  if assigned( DOMNode) and
     Supports( DOMNode.OwnerDocument, IXmlDocumentAccess, DocAccess) then
    Doc := DocAccess.DocumentObject;
  if Assigned( DOMNode) then
    SelectedNode := TXmlNode.Create( DOMNode, nil, Doc);
  result := assigned( SelectedNode)
end;

end.
