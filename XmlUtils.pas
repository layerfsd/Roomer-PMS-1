unit XmlUtils;

interface
uses System.Classes, SysUtils, XMLDoc, XMLIntf, xmldom;

function CreateXMLDocument( var Owner1: TComponent): TXMLDocument;
function XPATHSelect( const FocusNode: IXMLNode; const sXPath: string): TArray<IXMLNode>;
function XPATHSelectFirst( const FocusNode: IXMLNode; const sXPath: string; var SelectedNode: IXMLNode): boolean;

implementation


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
