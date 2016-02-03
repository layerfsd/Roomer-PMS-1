unit uMailDrop;

interface

uses
  Windows, SysUtils, Classes, Controls, ExtCtrls, ShlObj, ComObj, ActiveX;

type
  POLMailItem = ^TOLMailItem;

  TOLMailItem = packed record
    From: String;
    Subject: String;
    Received: String;
    Size: String;
    Body: String;
  end;

type
  TOlMailDrop = class(TObject)
  private
    // Private declarations
    FItems: TList;
  protected
    // Protected declarations
    function GetItemCount: Integer;
    procedure AddItem(AItem: POLMailItem);
    function GetItems(Index: Integer): TOLMailItem;
  public
    // Public declarations
    constructor Create;
    destructor Destroy; override;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TOLMailItem read GetItems; default;
  end;

type
  TOlMailDragDrop = class(TObject, IUnknown, IDropTarget)
  private
    // Private declarations
    FRefCount: Integer;
    FControl: TWinControl;
  protected
    // Protected declarations for IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // Protected declarations for IDropTarget
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint)
      : HResult; reintroduce; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    // Protected declarations
  public
    // Public declarations
    constructor Create(AControl: TWinControl);
    destructor Destroy; override;
  end;

implementation

// Cliboard formats that need to be registered
var
  CF_FILECONTENTS: Integer;
  CF_FILEDESCRIPTOR: Integer;

function TOlMailDrop.GetItems(Index: Integer): TOLMailItem;
begin
  // Return the item data
  result := POLMailItem(FItems[Index])^;
end;

procedure TOlMailDrop.AddItem(AItem: POLMailItem);
begin
  // Add item to string list
  FItems.Add(AItem);
end;

function TOlMailDrop.GetItemCount;
begin
  // Return the count of mail items
  result := FItems.Count;
end;

constructor TOlMailDrop.Create;
begin
  // Perform inherited
  inherited Create;

  // Set starting values
  FItems := TList.Create;
end;

destructor TOlMailDrop.Destroy;
var
  polmi: POLMailItem;
  i: Integer;
begin
  // Free the item data and list
  for i := FItems.Count - 1 downto 0 do
  begin
    polmi := FItems[i];
    Dispose(polmi);
    FItems.Delete(i);
  end;
  FItems.Free;

  // Perform inherited
  inherited Destroy;
end;

function TOlMailDragDrop.DragEnter(const dataObj: IDataObject;
  grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
var
  fc: tagFORMATETC;
  stgm: tagSTGMEDIUM;
  pstg: IStorage;
  pstm: IStream;
  accept: Boolean;
begin
  // Set default
  accept := False;

  // Check for outlook mail item
  fc.cfFormat := CF_FILECONTENTS;
  fc.ptd := nil;
  fc.dwAspect := 1;
  fc.lindex := 0;
  fc.tymed := TYMED_ISTORAGE;
  if dataObj.GetData(fc, stgm) = S_OK then
  begin
    pstg := IStorage(stgm.stg);
    // Hard coded to open the outlook message item stream
    if (pstg.OpenStream('__substg1.0_1000001E', nil, STGM_SHARE_EXCLUSIVE or
      STGM_READ, 0, pstm) = S_OK) OR
       (pstg.OpenStream('__substg1.0_1000001F', nil, STGM_SHARE_EXCLUSIVE or
      STGM_READ, 0, pstm) = S_OK) then
    begin
      accept := True;
      pstm := nil;
    end;
    pstg := nil;
    ReleaseStgMedium(stgm);
  end;

  // Dont allow drop if not an outlook mail item
  if not(accept) then
  begin
    result := S_FALSE;
    exit;
  end;

  // Success
  result := S_OK;

  // Send the drag enter message to the control (subclassed as panel)
  if Assigned(TPanel(FControl).OnDragOver) then
  begin
    accept := False;
    TPanel(FControl).OnDragOver(FControl, Self, pt.x, pt.y,
      dsDragEnter, accept);
    if not(accept) then
      dwEffect := DROPEFFECT_NONE;
  end

end;

function TOlMailDragDrop.DragOver(grfKeyState: Longint; pt: TPoint;
  var dwEffect: Longint): HResult; stdcall;
var
  accept: Boolean;
begin

  // Always return success
  result := S_OK;

  // Send the drag move message to the control (subclassed as panel)
  if Assigned(TPanel(FControl).OnDragOver) then
  begin
    accept := False;
    TPanel(FControl).OnDragOver(FControl, Self, pt.x, pt.y, dsDragMove, accept);
    if not(accept) then
      dwEffect := DROPEFFECT_NONE;
  end
  else
    dwEffect := DROPEFFECT_NONE;

end;

function TOlMailDragDrop.DragLeave: HResult; stdcall;
var
  accept: Boolean;
  pt: TPoint;
begin
  // Always return success
  result := S_OK;

  // Send the drag record message to the control (subclassed as panel)
  if Assigned(TPanel(FControl).OnDragOver) then
  begin
    accept := False;
    pt := FControl.ScreenToClient(Point(0, 0));
    TPanel(FControl).OnDragOver(FControl, Self, pt.x, pt.y,
      dsDragLeave, accept);
  end;
end;

function TOlMailDragDrop.Drop(const dataObj: IDataObject; grfKeyState: Longint;
  pt: TPoint; var dwEffect: Longint): HResult; stdcall;
var
  oditem: TOlMailDrop;
  stgm: tagSTGMEDIUM;
  stgmitem: tagSTGMEDIUM;
  tsitems: TStringList;
  stat: STATSTG;
  pstg: IStorage;
  pstm: IStream;
  polmi: POLMailItem;
  fc: tagFORMATETC;
  szhead: String;
  buff: PChar;
  pfgd: PFileGroupDescriptor;
  dwCount: Integer;
  dwfetch: Integer;
begin
  // Always return success
  result := S_OK;

  // Allocate string list for text form of dropped mail items
  tsitems := TStringList.Create;

  // Send the drop message to the control (subclassed as panel)
  if Assigned(TPanel(FControl).OnDragDrop) then
  begin
    // Create the OLE drop item
    oditem := TOlMailDrop.Create;

    // Get the text first
    fc.cfFormat := CF_TEXT;
    fc.ptd := nil;
    fc.dwAspect := 1;
    fc.lindex := -1;
    fc.tymed := TYMED_HGLOBAL;
    if (dataObj.GetData(fc, stgm) = S_OK) then
    begin
      tsitems.Text := String(PChar(GlobalLock(stgm.hGlobal)));
      GlobalUnlock(stgm.hGlobal);
      ReleaseStgMedium(stgm);
    end;

    // First line should contain the header, so remove it
    if (tsitems.Count > 0) then
      tsitems.Delete(0);

    // Get the file descriptors
    fc.cfFormat := CF_FILEDESCRIPTOR;
    fc.ptd := nil;
    fc.dwAspect := 1;
    fc.lindex := -1;
    fc.tymed := TYMED_HGLOBAL;
    if (dataObj.GetData(fc, stgm) = S_OK) then
    begin
      pfgd := PFileGroupDescriptor(GlobalLock(stgm.hGlobal));
      // Iterate each of the files
      for dwCount := 0 to pfgd.cItems - 1 do
      begin
        // Set up for getting the file data
        fc.cfFormat := CF_FILECONTENTS;
        fc.ptd := nil;
        fc.dwAspect := 1;
        fc.lindex := dwCount;
        fc.tymed := TYMED_ISTORAGE;
        if (dataObj.GetData(fc, stgmitem) = S_OK) then
        begin
          // IStorage (handle the outlook item)
          pstg := IStorage(stgmitem.stg);
          // Hard coded to open the outlook message item stream
          if (pstg.OpenStream('__substg1.0_1000001E', nil,
            STGM_SHARE_EXCLUSIVE or STGM_READ, 0, pstm) = S_OK) then
          begin
            pstm.stat(stat, STATFLAG_DEFAULT);
            buff := AllocMem(stat.cbSize);
            pstm.Read(buff, stat.cbSize, @dwfetch);
            // Build the mail item
            New(polmi);
            // Parse the header record
            if (tsitems.Count > dwCount) then
            begin
              szhead := tsitems[dwCount];
              polmi.From := Copy(szhead, 1, Pos(#9, szhead) - 1);
              Delete(szhead, 1, Pos(#9, szhead));
              polmi.Subject := Copy(szhead, 1, Pos(#9, szhead) - 1);
              Delete(szhead, 1, Pos(#9, szhead));
              polmi.Received := Copy(szhead, 1, Pos(#9, szhead) - 1);
              Delete(szhead, 1, Pos(#9, szhead));
              polmi.Size := Copy(szhead, 1, Pos(#9, szhead) - 1);
              Delete(szhead, 1, Pos(#9, szhead));
            end
            else
            begin
              polmi.From := '';
              polmi.Subject := '';
              polmi.Received := '';
              polmi.Size := '';
            end;
            // Set the msg body
            polmi.Body := String(buff);
            // Add the mail item
            oditem.AddItem(polmi);
            // Free buffer memory
            FreeMem(buff);
            // Free the stream
            pstm := nil;
          end;
          // Free the storage
          pstg := nil;
          // Release the storage medium
          ReleaseStgMedium(stgmitem);
        end;
      end;
      // Unlock the memory
      GlobalUnlock(stgm.hGlobal);
      // Release the storage medium
      ReleaseStgMedium(stgm);
    end;

    // Pass the OLE drop item as the source
    TPanel(FControl).OnDragDrop(FControl, oditem, pt.x, pt.y);

    // Free the string list
    tsitems.Free;

    // Free the OLE drop item
    oditem.Free;
  end
  else
    dwEffect := DROPEFFECT_NONE;
end;

function TOlMailDragDrop.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  // Return the requested interface
  if GetInterface(IID, Obj) then
    result := S_OK
  else
    result := E_NOINTERFACE;
end;

function TOlMailDragDrop._AddRef: Integer;
begin
  // Increment and return the ref count
  Inc(FRefCount);
  result := FRefCount;
end;

function TOlMailDragDrop._Release: Integer;
begin
  // Decrement and return the ref count
  Dec(FRefCount);
  result := FRefCount;
end;

constructor TOlMailDragDrop.Create(AControl: TWinControl);
begin
  // Perform inherited
  inherited Create;

  // Set ref count
  FRefCount := 1;

  // Set control and register as drop target
  FControl := AControl;
  OleCheck(RegisterDragDrop(FControl.Handle, Self));
end;

destructor TOlMailDragDrop.Destroy;
begin
  // Revoke the drop target
  RevokeDragDrop(FControl.Handle);

  // Perform inherited
  inherited Destroy;
end;

initialization

  // Initialize the OLE libraries
  OleInitialize(nil);

  // Register the clipboard formats that we need to handle in the
  // OLE drag drop operation
  CF_FILECONTENTS := RegisterClipboardFormat(CFSTR_FILECONTENTS);
  CF_FILEDESCRIPTOR := RegisterClipboardFormat(CFSTR_FILEDESCRIPTOR);

finalization

  try OleUninitialize; except end;

end.
