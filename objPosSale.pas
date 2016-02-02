unit objPosSale;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Contnrs,
  Dialogs,
  NativeXML,
  _Glob
  , System.Generics.Collections

  ;

TYPE

//////////////////////////////////////////////////////////////////////////////
//  TPosSaleItem
//  Vörulína sem kemur frá POS Þessi vörulína fer síðan
//  á uppsöfnunarreikning HOME
//////////////////////////////////////////////////////////////////////////////

  TPosSaleItem = class

    FSaleRefrence     : string  ;
    FLineNumber       : integer ;
    FItemCode         : string  ;
    FItemDescription  : string  ;
    FUnitPrice        : extended;
    FQuantity         : extended;
    FVatCode          : string  ;
    FVatPr            : extended;
    FAmount           : extended;
    FAmountWoVat      : extended;


    function GetSaleRefrence : string;
    function GetLineNumber : integer;
    function GetItemCode : string;
    function GetItemDescription : string;
    function GetUnitPrice : extended;
    function GetQuantity : extended;
    function GetVatCode : string;
    function GetVatPr : extended;
    function GetAmount : extended;
    function GetAmountWoVat : extended;

    procedure SetSaleRefrence(Value :string   );
    procedure SetLineNumber(Value :integer  );
    procedure SetItemCode(Value :string   );
    procedure SetItemDescription(Value :string   );
    procedure SetUnitPrice(Value :extended );
    procedure SetQuantity(Value :extended );
    procedure SetVatCode(Value :string   );
    procedure SetVatPr(Value :extended );
    procedure SetAmount(Value :extended );
    procedure SetAmountWoVat(Value :extended );
  private
    // **
  public
    constructor Create;
    destructor Destroy; override;

    property SaleRefrence    : string   read GetSaleRefrence    write SetSaleRefrence   ;
    property LineNumber      : integer  read GetLineNumber      write SetLineNumber     ;
    property ItemCode        : string   read GetItemCode        write SetItemCode       ;
    property ItemDescription : string   read GetItemDescription write SetItemDescription;
    property UnitPrice       : extended read GetUnitPrice       write SetUnitPrice      ;
    property Quantity        : extended read GetQuantity        write SetQuantity       ;
    property VatCode         : string   read GetVatCode         write SetVatCode        ;
    property VatPr           : extended read GetVatPr           write SetVatPr          ;
    property Amount          : extended read GetAmount          write SetAmount         ;
    property AmountWoVat     : extended read GetAmountWoVat     write SetAmountWoVat    ;
  end;



  TPosSaleItemsList = TList<TPosSaleItem>;

////////////////////////////////////////////////////////////////////
///  TPosItem
///  Positem er vara eins og hún er í vöruskrá þessi gildi eru notuð
///  til þess að viðhalda vöruskrá HOME til samræmis við vöruskra POS
/////////////////////////////////////////////////////////////////////


  TPosItem = class

    FItemCode           : string  ;
    FItemDescription    : string  ;
    FUnitPrice          : extended;
    FVatCode            : string  ;
    FVatPr              : extended;
    FCategoryID         : string  ;
    FCategoryDescription: string  ;


    function GetItemCode : string;
    function GetItemDescription : string;
    function GetUnitPrice : extended;
    function GetVatCode : string;
    function GetVatPr : extended;
    function GetCategoryID : string;
    function GetCategoryDescription : string;

    procedure SetItemCode(Value :string   );
    procedure SetItemDescription(Value :string   );
    procedure SetUnitPrice(Value :extended );
    procedure SetVatCode(Value :string   );
    procedure SetVatPr(Value :extended );
    procedure SetCategoryID(Value :string   );
    procedure SetCategoryDescription(Value :string   );



  private
    // **
  public
    constructor Create;
    destructor Destroy; override;

    property ItemCode            : string   read GetItemCode            write SetItemCode       ;
    property ItemDescription     : string   read GetItemDescription     write SetItemDescription;
    property UnitPrice           : extended read GetUnitPrice           write SetUnitPrice      ;
    property VatCode             : string   read GetVatCode             write SetVatCode        ;
    property VatPr               : extended read GetVatPr               write SetVatPr          ;
    property CategoryID          : string   read GetCategoryID          write SetCategoryID         ;
    property CategoryDescription : string   read GetCategoryDescription write SetCategoryDescription         ;
  end;


  TPosItemsList = TList<TPosItem>;

  //////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  /////////////////////////////////////////////////////////////////////////////////////

  TPosSale = class
  private
    FXmlFileName : string;

    FPosSaleItemsCount : integer;
    FPosSaleItemsList : TPosSaleItemsList;

    FPosItemsCount : integer;
    FPosItemsList : TPosItemsList;

    FHotelcode       : string    ;
    FSaleRefrence    : string    ;
    FStaff           : string    ;
    FPosId           : string    ;
    FExportDateTime  : TDateTime ;
    FImportDateTime  : TDateTime ;  // time of import
    FRoomNumber      : string    ;
    FIsGroupinvoice  : boolean   ;
    FSaleNotes       : string    ;
    FSalesPerson     : string    ;
    FCustomer        : string    ;
    FPersonalId      : string    ;
    FCustomerName    : string    ;
    FAddress1        : string    ;
    FAddress2        : string    ;
    FAddress3        : string    ;
    FAddress4        : string    ;
    FGuestName       : string    ;


    function getPosSaleItemsCount : integer;
    function getPosItemsCount : integer;

    procedure FillLists(var PosSaleItemsCount, PosItemsCount : integer);
    procedure Clear;
  public
    constructor Create(aXmlFileName : string);
    destructor Destroy; override;

    property XmlFileName : string read FXmlFileName write FXmlFileName;

    property Hotelcode      : string    read FHotelcode      write FHotelcode     ;
    property SaleRefrence   : string    read FSaleRefrence   write FSaleRefrence  ;
    property Staff          : string    read FStaff          write FStaff         ;
    property PosId          : string    read FPosId          write FPosId         ;
    property ExportDateTime : TDateTime read FExportDateTime write FExportDateTime;
    property ImportDateTime : TDateTime read FImportDateTime write FImportDateTime;
    property RoomNumber     : string    read FRoomNumber     write FRoomNumber    ;

    property IsGroupinvoice : boolean   read FIsGroupinvoice write FIsGroupinvoice;
    property SaleNotes      : string    read FSaleNotes      write FSaleNotes     ;
    property SalesPerson    : string    read FSalesPerson    write FSalesPerson   ;
    property Customer       : string    read FCustomer       write FCustomer      ;
    property PersonalId     : string    read FPersonalId     write FPersonalId    ;
    property CustomerName   : string    read FCustomerName   write FCustomerName  ;
    property Address1       : string    read FAddress1       write FAddress1      ;
    property Address2       : string    read FAddress2       write FAddress2      ;
    property Address3       : string    read FAddress3       write FAddress3      ;
    property Address4       : string    read FAddress4       write FAddress4      ;
    property GuestName      : string    read FGuestName      write FGuestName     ;

    function FindItemFromSaleItems(sSearchFor : string; StartAt : integer; caseSensitive : Boolean = false) : integer;

    property PosSaleItemsList : TPosSaleItemsList read FPosSaleItemsList write FPosSaleItemsList;
    property PosSaleItemsCount : integer read getPosSaleItemsCount;

    property PosItemsList : TPosItemsList read FPosItemsList write FPosItemsList;
    property PosItemsCount : integer read getPosItemsCount;

  end;

function posSaleTextLog(posSale : TPosSale) : TStringList;


implementation

//////////////////////////////////////////////////////////////////////////////
//  TPosSaleItem
//  Vörulína sem kemur frá POS Þessi vörulína fer síðan
//  á uppsöfnunarreikning HOME
//////////////////////////////////////////////////////////////////////////////

constructor TPosSaleItem.Create;
begin

end;

destructor TPosSaleItem.Destroy;
begin

  inherited;
end;

function TPosSaleItem.GetAmount: extended;
begin
  result := FAmount ;
end;

function TPosSaleItem.GetAmountWoVat: extended;
begin
  result := FAmountWoVat ;
end;

function TPosSaleItem.GetItemCode: string;
begin
  result := FItemCode ;
end;

function TPosSaleItem.GetItemDescription: string;
begin
  result := FItemDescription ;
end;

function TPosSaleItem.GetLineNumber: integer;
begin
  result := FLineNumber ;
end;

function TPosSaleItem.GetQuantity: extended;
begin
  result := FQuantity ;
end;

function TPosSaleItem.GetSaleRefrence: string;
begin
  result := FSaleRefrence ;
end;

function TPosSaleItem.GetUnitPrice: extended;
begin
  result := FUnitPrice ;
end;

function TPosSaleItem.GetVatCode: string;
begin
  result := FVatCode ;
end;

function TPosSaleItem.GetVatPr: extended;
begin
  result := FVatPr ;
end;


//////////////////////////////////////////////

procedure TPosSaleItem.SetAmount(Value: extended);
begin
  FAmount := value;
end;

procedure TPosSaleItem.SetAmountWoVat(Value: extended);
begin
  FAmountWoVat := value;
end;

procedure TPosSaleItem.SetItemCode(Value: string);
begin
  FItemCode := value;
end;

procedure TPosSaleItem.SetItemDescription(Value: string);
begin
  FItemDescription := value;
end;

procedure TPosSaleItem.SetLineNumber(Value: integer);
begin
  FLineNumber := value;
end;

procedure TPosSaleItem.SetQuantity(Value: extended);
begin
  FQuantity := value;
end;

procedure TPosSaleItem.SetSaleRefrence(Value: string);
begin
  FSaleRefrence := value;
end;

procedure TPosSaleItem.SetUnitPrice(Value: extended);
begin
  FUnitPrice := value;
end;

procedure TPosSaleItem.SetVatCode(Value: string);
begin
  FVatCode := value;
end;

procedure TPosSaleItem.SetVatPr(Value: extended);
begin
  FVatPr := value;
end;

////////////////////////////////////////////////////////////////////
///  TPosItem
///  Positem er vara eins og hún er í vöruskrá þessi gildi eru notuð
///  til þess að viðhalda vöruskrá HOME til samræmis við vöruskra POS
/////////////////////////////////////////////////////////////////////

constructor TPosItem.Create;
begin
  //**
end;

destructor TPosItem.Destroy;
begin
  inherited;
end;

function TPosItem.GetCategoryDescription: string;
begin
  result := FCategoryDescription ;
end;

function TPosItem.GetCategoryID: string;
begin
  result := FCategoryID ;
end;

function TPosItem.GetItemCode: string;
begin
  result := FItemCode ;
end;

function TPosItem.GetItemDescription: string;
begin
  result := FItemDescription ;
end;


function TPosItem.GetUnitPrice: extended;
begin
  result := FUnitPrice ;
end;

function TPosItem.GetVatCode: string;
begin
  result := FVatCode ;
end;

function TPosItem.GetVatPr: extended;
begin
  result := FVatPr ;
end;

procedure TPosItem.SetCategoryDescription(Value: string);
begin
  FCategoryDescription := value;
end;

procedure TPosItem.SetCategoryID(Value: string);
begin
  FCategoryID := value;
end;

procedure TPosItem.SetItemCode(Value: string);
begin
  FItemCode := value;
end;

procedure TPosItem.SetItemDescription(Value: string);
begin
  FItemDescription := value;
end;


procedure TPosItem.SetUnitPrice(Value: extended);
begin
  FUnitPrice := value;
end;

procedure TPosItem.SetVatCode(Value: string);
begin
  FVatCode := value;
end;

procedure TPosItem.SetVatPr(Value: extended);
begin
  FVatPr := value;
end;

//////////////////////////////////////////////////////////////////////////////
///  TPosSale
///
///
///
//////////////////////////////////////////////////////////////////////////////

constructor TPosSale.Create(aXmlFileName: string);
begin
  inherited Create;
  try
    FPosSaleItemsList := TPosSaleItemsList.Create;
  Except
    //loga
  end;

  try
    FPosItemsList := TPosItemsList.Create;
  Except
    //Loga
  end;

  FXmlFileName := aXmlFileName;

  FPosSaleItemsCount := 0;
  FPosItemsCount := 0;

  try
    FillLists(FPosSaleItemsCount,FPosItemsCount);
  Except
    // logga
  end;
end;

destructor TPosSale.Destroy;
begin
  Clear;
  FPosSaleItemsList.Free;
  FPosItemsList.Free;
  inherited;
end;

procedure TPosSale.Clear;
begin
  while FPosSaleItemsList.Count > 0 do
  begin
    FPosSaleItemsList[0].Free;
    FPosSaleItemsList.Delete(0);
  end;
  while FPosItemsList.Count > 0 do
  begin
    FPosItemsList[0].Free;
    FPosItemsList.Delete(0);
  end;
end;


procedure TPosSale.FillLists(var PosSaleItemsCount, PosItemsCount : integer);
var
  PosSaleItem : TPosSaleItem;
  PosItem : TPosItem;


  aDoc : TNativeXml;

  rootNode      : TXmlNode;

  salesNode     : TXmlNode;
  saleheadNode  : TXmlNode;

  saleItemsNode : TXmlNode;
  saleItemNode  : TXmlNode;

  ItemsNode : TXmlNode;
  ItemNode  : TXmlNode;

  i, ii : Integer;
  s     : string;

  lbx1 : tStringList;


  SaleRefrence     : string  ;
  LineNumber       : integer ;
  ItemCode         : string  ;
  ItemDescription  : string  ;
  UnitPrice        : extended;
  Quantity         : extended;
  VatCode          : string  ;
  VatPr            : extended;
  Amount           : extended;
  AmountWoVat      : extended;

  categoryID          : string;
  categoryDescription : string;

  sTmp : string;


begin
  //**
  Clear;

  PosSaleItemsCount := 0;
  PosItemsCount := 0;

  lbx1 := TStringList.Create;
  try
    if fileExists(FxmlFilename) then
    begin
      aDoc := TNativeXml.Create(nil);
      try
        aDoc.Clear;
        aDoc.LoadFromFile(FxmlFilename);
        aDoc.XmlFormat := xfReadable;

        rootNode  := aDoc.Root;
        salesNode := rootNode.FindNode('sale');

        if assigned(salesNode) then
        begin
          FHotelcode     := String(salesNode.ReadAttributeString(UTF8String('hotelcode')));
          FSaleRefrence  := String(salesNode.ReadAttributeString(UTF8String('sale_refrence')));
          FStaff         := String(salesNode.ReadAttributeString(UTF8String('staff')));
          FPosId         := String(salesNode.ReadAttributeString(UTF8String('pos_id')));
          try
            sTmp := String(salesNode.ReadAttributeString(UTF8String('exportdatetime')));
            FExportDateTime:= StrToDateTime(sTmp);
          Except
            FExportDateTime:= now;
          end;

          FImportDateTime:= now   ; //salesNode.ReadAttributeString('exportdatetime')

          saleheadNode := salesNode.FindNode('salehead');
          if assigned(saleheadNode) then
          begin
            FIsGroupinvoice:= false;  //saleheadNode.ReadString('is_groupinvoice');
            FSaleNotes     := String(saleheadNode.ReadString(UTF8String('salenotes')));
            FRoomNumber    := String(saleheadNode.ReadString(UTF8String('roomnumber')));
            FSalesPerson   := String(saleheadNode.ReadString(UTF8String('salesperson')));
            FCustomer      := String(saleheadNode.ReadString(UTF8String('customer')));
            FPersonalId    := String(saleheadNode.ReadString(UTF8String('personalid')));
            FCustomerName  := String(saleheadNode.ReadString(UTF8String('customername')));
            FAddress1      := String(saleheadNode.ReadString(UTF8String('address1')));
            FAddress2      := String(saleheadNode.ReadString(UTF8String('address2')));
            FAddress3      := String(saleheadNode.ReadString(UTF8String('address3')));
            FAddress4      := String(saleheadNode.ReadString(UTF8String('address4')));
            FGuestName     := String(saleheadNode.ReadString(UTF8String('guestname')));
          end;

          saleItemsNode := salesNode.FindNode('sale_items');
          if assigned(saleItemsNode) then
          begin
            for i := 0 to saleItemsNode.NodeCount - 1 do
            begin
              saleItemNode := saleItemsNode[i];
              if saleItemNode.HasAttribute('line') then
              begin
                SaleRefrence     := FSalerefrence;

                try
                  LineNumber       := strToInt(trim(String(saleItemNode.ReadAttributeString(UTF8String('line')))));
                except
                  LineNumber       := 0;
                end;

                ItemCode         := trim(String(saleItemNode.ReadString(UTF8String('itemcode'))));
                ItemDescription  := trim(String(saleItemNode.ReadString(UTF8String('itemdescription'))));

                try
                  UnitPrice :=  _strToFloat(trim(String(saleItemNode.ReadString(UTF8String('unitprice')))));
                except
                  UnitPrice := 0.00;
                end;

                try
                  Quantity := _strToFloat(trim(String(saleItemNode.ReadString(UTF8String('quantity')))));
                Except
                  Quantity         := 0.00;
                end;

                VatCode := trim(String(saleItemNode.ReadString(UTF8String('vatcode'))));

                try
                  VatPr := _strToFloat(trim(String(saleItemNode.ReadString(UTF8String('vatpr')))));
                Except
                  VatPr := 0.00;
                end;

                try
                  Amount := _strToFloat(trim(String(saleItemNode.ReadString(UTF8String('amount')))));
                Except
                  Amount := 0.00;
                end;

                try
                  AmountWoVat := _strToFloat(trim(String(saleItemNode.ReadString(UTF8String('amountwovat')))));
                Except
                  AmountWoVat := 0.00;
                end;

                PosSaleItem := TPosSaleItem.Create;
                try
                  PosSaleItem.SetSaleRefrence(SaleRefrence);
                  PosSaleItem.SetLineNumber(LineNumber);
                  PosSaleItem.SetItemCode(ItemCode);
                  PosSaleItem.SetItemDescription(ItemDescription);
                  PosSaleItem.SetUnitPrice(UnitPrice);
                  PosSaleItem.SetQuantity(Quantity);
                  PosSaleItem.SetVatCode(VatCode);
                  PosSaleItem.SetVatPr(VatPr);
                  PosSaleItem.SetAmount(Amount);
                  PosSaleItem.SetAmountWoVat(AmountWoVat);
                  FPosSaleItemsList.Add(PosSaleItem);
                except
                   // logga
                end;

              end;
            end;
          end;


          ItemsNode := salesNode.FindNode('items');
          if assigned(ItemsNode) then
          begin
            for i := 0 to ItemsNode.NodeCount - 1 do
            begin
              ItemNode := ItemsNode[i];
              if ItemNode.HasAttribute('itemcode') then
              begin

                ItemCode         := trim(String(ItemNode.ReadAttributeString(UTF8String('itemcode'))));
                ItemDescription  := trim(String(ItemNode.ReadString(UTF8String('itemdescription'))));

                try
                  UnitPrice :=  _strToFloat(trim(String(ItemNode.ReadString(UTF8String('unitprice')))));
                except
                  UnitPrice := 0.00;
                end;


                VatCode := trim(String(ItemNode.ReadString(UTF8String('vatcode'))));

                try
                  VatPr := _strToFloat(trim(String(ItemNode.ReadString(UTF8String('vatpr')))));
                Except
                  VatPr := 0.00;
                end;

                categoryID := trim(String(ItemNode.ReadString(UTF8String('categoryID'))));
                categoryDescription := trim(String(ItemNode.ReadString(UTF8String('category_description'))));


                PosItem := TPosItem.Create;
                try
                  PosItem.SetItemCode(ItemCode);
                  PosItem.SetItemDescription(ItemDescription);
                  PosItem.SetUnitPrice(UnitPrice);
                  PosItem.SetVatCode(VatCode);
                  PosItem.SetVatPr(VatPr);
                  PosItem.SetCategoryID(categoryID);
                  PosItem.SetCategoryDescription(categoryDescription);
                  FPosItemsList.Add(PosItem);
                except
                   // logga
                end;
              end;
            end;
          end;
        end;
      finally
        freeandnil(aDoc);
      end;
    end else
    begin
      // logg
    end;
    PosSaleItemsCount := FPosSaleItemsList.Count;
    PosItemsCount := FPosItemsList.Count;


  finally
    lbx1.Free;
  end;
end;

function TPosSale.FindItemFromSaleItems(sSearchFor: string; StartAt: integer; caseSensitive: Boolean): integer;
begin
  //**
  result := 0;
end;

function TPosSale.getPosItemsCount: integer;
begin
  result := FPosItemsList.Count;
end;

function TPosSale.getPosSaleItemsCount: integer;
begin
  result := FPosSaleItemsList.Count;
end;

function posSaleTextLog(posSale : TPosSale) : TstringList;
var
  sTime   : string;
  i       : integer;
begin
  result := TStringList.Create;
  try
    datetimeTostring(sTime,'yyyy-mm-dd_hhnnss-zzz',now);
    result.Add(sTime);
    result.Add('');
    result.Add('Hotelcode       : '+posSale.Hotelcode     );
    result.Add('SaleRefrence    : '+posSale.SaleRefrence  );
    result.Add('Staff           : '+posSale.Staff         );
    result.Add('PosId           : '+posSale.PosId         );
    result.Add('ExportDateTime  : '+dateTimeTostr(posSale.ExportDateTime));
    result.Add('ImportDateTime  : '+dateTimeTostr(posSale.ImportDateTime));
    result.Add('RoomNumber      : '+posSale.RoomNumber    );
    result.Add('IsGroupinvoice  : '+booltostr(posSale.IsGroupinvoice));
    result.Add('SaleNotes       : '+posSale.SaleNotes     );
    result.Add('SalesPerson     : '+posSale.SalesPerson   );
    result.Add('Customer        : '+posSale.Customer      );
    result.Add('PersonalId      : '+posSale.PersonalId    );
    result.Add('CustomerName    : '+posSale.CustomerName  );
    result.Add('Address1        : '+posSale.Address1      );
    result.Add('Address2        : '+posSale.Address2      );
    result.Add('Address3        : '+posSale.Address3      );
    result.Add('Address4        : '+posSale.Address4      );
    result.Add('GuestName       : '+posSale.GuestName     );

    result.Add('');
    result.Add('  ----- SaleItems ------- ');
    for i  := 0 to posSale.PosSaleItemsList.Count - 1 do
    begin
      result.Add('SaleRefrence     :  '+possale.PosSaleItemsList[i].SaleRefrence);
      result.Add('LineNumber       :  '+inttostr(possale.PosSaleItemsList[i].LineNumber));
      result.Add('ItemCode         :  '+possale.PosSaleItemsList[i].ItemCode);
      result.Add('ItemDescription  :  '+possale.PosSaleItemsList[i].ItemDescription);
      result.Add('UnitPrice        :  '+floattostr(possale.PosSaleItemsList[i].UnitPrice));
      result.Add('Quantity         :  '+floattostr(possale.PosSaleItemsList[i].Quantity));
      result.Add('VatCode          :  '+possale.PosSaleItemsList[i].VatCode);
      result.Add('VatPr            :  '+floattostr(possale.PosSaleItemsList[i].VatPr));
      result.Add('Amount           :  '+floattostr(possale.PosSaleItemsList[i].Amount));
      result.Add('AmountWoVat      :  '+floattostr(possale.PosSaleItemsList[i].AmountWoVat));
      result.Add('');
    end;

    result.Add('');
    result.Add('  ----- Items ------- ');
    for i  := 0 to posSale.PosItemsList.Count - 1 do
    begin
      result.Add('ItemCode           :  '+possale.PosItemsList[i].ItemCode);
      result.Add('ItemDescription    :  '+possale.PosItemsList[i].ItemDescription);
      result.Add('UnitPrice          :  '+floattostr(possale.PosItemsList[i].UnitPrice));
      result.Add('VatCode            :  '+possale.PosItemsList[i].VatCode);
      result.Add('VatPr              :  '+floattostr(possale.PosItemsList[i].VatPr));
      result.Add('CategoryID         :  '+possale.PosItemsList[i].categoryID);
      result.Add('CategoryDescription:  '+possale.PosItemsList[i].categoryDescription);
      result.Add('');
    end;
  Except
  end;
end;


end.
