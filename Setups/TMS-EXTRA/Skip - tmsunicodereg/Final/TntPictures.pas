{**************************************************************************}
{ TTntPictureContainer component                                           }
{ for Delphi & C++Builder                                                  }
{                                                                          }
{ Copyright © 2002 - 2007                                                  }
{   TMS Software                                                           }
{   Email : info@tmssoftware.com                                           }
{   Web : http://www.tmssoftware.com                                       }
{                                                                          }
{ The source code is given as is. The author is not responsible            }
{ for any possible damage done due to the use of this code.                }
{ The component can be freely used in any application. The complete        }
{ source code remains property of the author and may not be distributed,   }
{ published, given or sold in any form as such. No parts of the source     }
{ code can be included in any other component or application without       }
{ written authorization of the author.                                     }
{**************************************************************************}

unit TntPictures;
                             
{$INCLUDE TntCompilers.inc}
{$J+}
{$R-}
{$B-}
{$C+}


{$IFDEF DELPHI_7_UP}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$ENDIF}

{$M+}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComObj, ActiveX
  {$IFDEF USEWININET}
  , WinInet
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.


type
  TPicturePosition = (bpTopLeft,bpTopRight,bpBottomLeft,bpBottomRight,bpCenter,bpTiled,bpStretched);

  THTMLPicture = class;

  PInternetContent = ^TInternetContent;
  TInternetContent = record
  {$IFDEF USEWININET}
    hresource: hinternet;
  {$ENDIF}
    Complete: Boolean;
    HTMLPicture:THTMLPicture;
  end;

  TDownloadErrorEvent = procedure(Sender:TObject;err:string) of object;
  TDownloadCompleteEvent = procedure(Sender:TObject) of object;
  TDownloadCancelEvent = procedure(Sender:TObject;var Cancel:boolean) of object;
  TDownloadProgressEvent = procedure(Sender:TObject;dwSize,dwTotSize:dword) of object;

  TDownLoadThread = class(TThread)
  private
    HTMLPicture:THTMLPicture;
  protected
    procedure Execute; override;
  public
    constructor Create(aHTMLPicture:THTMLPicture);
  end;

  THTMLPicture = class(TGraphic)
  private
    { Private declarations }
    FDatastream:TMemoryStream;
    FIsEmpty: Boolean;
    FStretched: Boolean;
    gpPicture: IPicture;
    FLogPixX,FLogPixY: Integer;
    FURL:string;
    FID:string;
    FIsDB: Boolean;
    FAsynch: Boolean;
    FThreadBusy: Boolean;
    FFrame: Integer;
    FFrameCount: Integer;
    FOnFrameChange: TNotifyEvent;
    FFrameXPos: Word;
    FFrameYPos: Word;
    FFrameXSize: Word;
    FFrameYSize: Word;
    FFrameTransp: Boolean;
    FFrameDisposal: Word;
    FAnimMaxX,FAnimMaxY: Word;
    FNextCount: Integer;
    FTimerCount: Integer;
    FOnDownLoadProgress: TDownLoadProgressEvent;
    FOnDownLoadCancel: TDownLoadCancelEvent;
    FOnDownLoadComplete: TDownLoadCompleteEvent;
    FOnDownLoadError: TDownLoadErrorEvent;
    procedure LoadPicture;
    function GetFrameCount: Integer;
    function IsGIFFile: Boolean;
    function GetFrameTime(i: Integer): Integer;
  protected
    { Protected declarations }
    function GetEmpty: Boolean; override;
    function GetHeight: integer; override;
    function GetWidth: integer; override;
    procedure SetHeight(Value: integer); override;
    procedure SetWidth(Value: integer); override;
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    procedure DownLoadError(err:string);
    procedure DownLoadComplete;
    procedure DownLoadCancel(var cancel:boolean);
    procedure DownLoadProgress(dwSize,dwTotSize:dword);
    {$IFDEF USEWININET}
    procedure DownLoad;
    {$ENDIF}
  public
    { Public declarations }
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromResourceName(Instance: THandle; const ResName: String);
    procedure LoadFromResourceID(Instance: THandle; ResID: Integer);
    procedure LoadFromURL(url:string);
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPALETTE); override;
    property Busy: Boolean read fThreadBusy;
    property Asynch: Boolean read fAsynch write fAsynch;
    property ID: string read FID write FID;
    property IsDB: boolean read FIsDB write FIsDB;
    property IsGIF: Boolean read IsGIFFile;
    property FrameCount:Integer read GetFrameCount;
    property FrameTime[i:Integer]:Integer read GetFrameTime;
    function GetMaxHeight: Integer;
    function GetMaxWidth: Integer;
    procedure SetFrame(const Value:Integer);
    procedure FrameNext;
    procedure FramePrev;
    function Step: Boolean;
    property MaxWidth: integer read GetMaxWidth;
    property MaxHeight: integer read GetMaxHeight;
    property FrameXPos: word read FFrameXPos;
    property FrameYPos: word read FFrameYPos;
  published
    { Published declarations }
    property Stretch:boolean read FStretched write FStretched;
    property Frame:Integer read FFrame write SetFrame;
    property OnFrameChange: TNotifyEvent read FOnFrameChange write FOnFrameChange;
    property OnDownLoadError:TDownLoadErrorEvent read fOnDownLoadError write fOnDownLoadError;
    property OnDownLoadComplete:TDownLoadCompleteEvent read fOnDownLoadComplete write fOnDownLoadComplete;
    property OnDownLoadCancel:TDownLoadCancelEvent read fOnDownLoadCancel write fOnDownLoadCancel;
    property OnDownLoadProgress:TDownLoadProgressEvent read fOnDownLoadProgress write fOnDownLoadProgress;
  end;

  TTntHTMLPictureCache = class(TList)
  private
    procedure SetPicture(Index: Integer; Value: THTMLPicture);
    function GetPicture(Index: Integer):THTMLPicture;
  public
    destructor Destroy; override;
    property Items[index: Integer]: THTMLPicture read GetPicture write SetPicture; default;
    function AddPicture:THTMLPicture;
    function FindPicture(ID:string):THTMLPicture;
    procedure ClearPictures;
    function Animate: boolean;
  published
  end;

  THTMLImage = class(TGraphicControl)
  private
    { Private declarations }
    FHTMLPicture:THTMLPicture;
    FPicturePosition:TPicturePosition;
    FOnDownLoadCancel: TDownLoadCancelEvent;
    FOnDownLoadComplete: TDownLoadCompleteEvent;
    FOnDownLoadError: TDownLoadErrorEvent;
    FOnDownLoadProgress: TDownLoadProgressEvent;
    procedure SetHTMLPicture(const Value: THTMLPicture);
    procedure PictureChanged(sender:TObject);
    procedure SetPicturePosition(const Value: TPicturePosition);
    procedure DownLoadError(Sender:TObject;err:string);
    procedure DownLoadComplete(Sender:TObject);
    procedure DownLoadCancel(Sender:TObject;var Cancel: Boolean);
    procedure DownLoadProgress(Sender:TObject;dwSize,dwTotSize:dword);
  protected
    { Protected declarations }
    procedure Paint; override;
    procedure Loaded; override;
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property HTMLPicture:THTMLPicture read FHTMLPicture write SetHTMLPicture;
    property PicturePosition:TPicturePosition read FPicturePosition write SetPicturePosition;
    { inherited published properties}
    property Align;
    property Anchors;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Hint;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnStartDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnStartDrag;
    property OnDownLoadError:TDownLoadErrorEvent read FOnDownLoadError write FOnDownLoadError;
    property OnDownLoadComplete:TDownLoadCompleteEvent read FOnDownLoadComplete write FOnDownLoadComplete;
    property OnDownLoadCancel:TDownLoadCancelEvent read FOnDownLoadCancel write FOnDownLoadCancel;
    property OnDownLoadProgress:TDownLoadProgressEvent read FOnDownLoadProgress write FOnDownLoadProgress;
  end;

  TPictureItem = class(TCollectionItem)
  private
    FPicture: THTMLPicture;
    FTag: Integer;
    FName: string;
    procedure SetPicture(const Value: THTMLPicture);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Picture: THTMLPicture read FPicture write SetPicture;
    property Name: string read FName write FName;
    property Tag: Integer read FTag write FTag;
  end;

  TPictureCollection = class(TCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TPictureItem;
    procedure SetItem(Index: Integer; Value: TPictureItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner:TComponent);
    function Add: TPictureItem;
    function Insert(index:integer): TPictureItem;
    property Items[Index: Integer]: TPictureItem read GetItem write SetItem;
    function Animate:Boolean;
  end;

  TTntPictureContainer = class(TComponent)
  private
    FItems: TPictureCollection;
    procedure SetItems(const Value: TPictureCollection);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetVersionNr: Integer;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindPicture(s:string): THTMLPicture; virtual;
  published
    { Published declarations }
    property Items: TPictureCollection read FItems write SetItems;
    property Version: string read GetVersion write SetVersion;
  end;


implementation

const
  HIMETRIC_INCH = 2540;

{ THTMLPicture }

procedure THTMLPicture.Assign(Source: TPersistent);
begin
  FIsEmpty := true;
  gpPicture := nil;
  FFrameCount := -1;
  FNextCount := -1;
  FTimerCount := -1;
  Frame := 1;

  if Source = nil then
    FDataStream.Clear
  else
  begin
    if Source is THTMLPicture then
    begin
      FDataStream.LoadFromStream(THTMLPicture(Source).fDataStream);
      FIsEmpty := False;
      LoadPicture;
      if Assigned(OnChange) then
        OnChange(self);
    end;
  end;    
end;

constructor THTMLPicture.Create;
begin
  inherited;
  FDataStream := TMemoryStream.Create;
  FIsEmpty := True;
  gpPicture := nil;
  FLogPixX := 96;
  FLogPixY := 96;
  FThreadBusy := False;
  FAsynch := True;
  FFrameCount := -1;
  FNextCount := -1;
  FTimerCount := -1;
  FFrame := 1;
  FIsDB := False;
end;

destructor THTMLPicture.Destroy;
begin
  FDataStream.Free;
  inherited;
end;

procedure THTMLPicture.LoadPicture;
const
  IID_IPicture: TGUID = (
  D1:$7BF80980;D2:$BF32;D3:$101A;D4:($8B,$BB,$00,$AA,$00,$30,$0C,$AB));

var
  hGlobal: THandle;
  pvData: Pointer;
  pstm: IStream;
  hr: hResult;
  GifStream: TMemoryStream;
  i: Integer;
  b,c,d,e: Byte;
  skipimg: Boolean;
  imgidx: Integer;
begin
  hGlobal := GlobalAlloc(GMEM_MOVEABLE, FDataStream.Size);
  if hGlobal = 0 then
    raise Exception.Create('Could not allocate memory for image');

  try
    pvData := GlobalLock(hGlobal);
    FDataStream.Position := 0;

    FFrameXPos := 0;
    FFrameYPos := 0;
    FAnimMaxX := 0;
    FAnimMaxY := 0;

    {skip first image ctrl}

    if IsGIF and (FrameCount > 0) then
     begin
      //manipulate the stream here for animated GIF ?
      Gifstream := TMemoryStream.Create;

      ImgIdx := 1;
      SkipImg := False;

      FDataStream.Position := 6;
      FDataStream.Read(FAnimMaxX,2);
      FDataStream.Read(FAnimMaxY,2);

      for i := 1 to FDataStream.Size do
       begin
         FDataStream.Position := i - 1;
         FDataStream.Read(b,1);

         if (b = $21) and (i + 8 < FDataStream.Size) then
          begin
           FDataStream.Read(c,1);
           FDataStream.Read(d,1);
           FDataStream.Position := FDataStream.Position + 5;

           FDataStream.Read(e,1);
           if (c = $F9) and (d = $4) and (e = $2C) then
             begin
               if imgidx = FFrame then
                begin
                 FDataStream.Read(FFrameXPos,2);
                 FDataStream.Read(FFrameYPos,2);
                 FDataStream.Read(FFrameXSize,2);
                 FDataStream.Read(FFrameYSize,2);
                end;

               Inc(ImgIdx);
               if ImgIdx <= FFrame then
                 SkipImg := True
               else
                 SkipImg := False;
             end;
          end;
        if not SkipImg then GifStream.Write(b,1);
       end;
      GifStream.Position := 0;
      GifStream.ReadBuffer(pvData^,GifStream.Size);
      GifStream.Free;
     end
    else
    begin
      FDataStream.ReadBuffer(pvData^,fDataStream.Size);
    end;

    GlobalUnlock(hGlobal);

    pstm := nil;

    // Create IStream* from global memory
    hr := CreateStreamOnHGlobal(hGlobal, TRUE, pstm);

    if (not hr=S_OK) then
      raise Exception.Create('Could not create image stream')
    else
      if (pstm = nil) then
        raise Exception.Create('Empty image stream created');

    // Create IPicture from image file
    hr := OleLoadPicture(pstm, FDataStream.Size,FALSE,IID_IPicture,gpPicture);

    if not (hr = S_OK) then
      raise Exception.Create('Could not load image. Invalid format')
    else
      if gpPicture = nil then
        raise Exception.Create('Could not load image');

  finally
    GlobalFree(hGlobal);
  end;
end;


procedure THTMLPicture.Draw(ACanvas: TCanvas; const Rect: TRect);
var
  hmWidth:integer;
  hmHeight:integer;
  nPixX,nPixY:integer;
  pnWidth,pnHeight:integer;

begin
  if Empty then Exit;

  if gpPicture = nil then Exit;

  hmWidth  := 0;
  hmHeight := 0;
  gpPicture.get_Width(hmWidth);
  gpPicture.get_Height(hmHeight);


  if FStretched then
  begin
    gpPicture.Render(ACanvas.Handle,Rect.Left,Rect.Bottom,Rect.Right - Rect.Left,-(Rect.Bottom - Rect.Top),0,0,
                     hmWidth,hmHeight, Rect);
  end
  else
  begin
    nPixX := GetDeviceCaps(ACanvas.Handle,LOGPIXELSX);
    nPixY := GetDeviceCaps(ACanvas.Handle,LOGPIXELSY);
    //Convert to device units
    pnWidth  := MulDiv(hmWidth,  nPixX, HIMETRIC_INCH);
    pnHeight := MulDiv(hmHeight, nPixY, HIMETRIC_INCH);

    //gpPicture.Render(ACanvas.Handle,Rect.Left,Rect.Top + pnHeight,pnWidth,-pnHeight,0,0,
    //                 hmWidth,hmHeight, Rect);
    gpPicture.Render(ACanvas.Handle,Rect.Left,Rect.Top,
      pnWidth,pnHeight,0,hmHeight, hmWidth,-hmHeight, Rect);
  end;

end;

function THTMLPicture.GetEmpty: Boolean;
begin
  Result := FIsEmpty;
end;

function THTMLPicture.GetHeight: integer;
var
  hmHeight:integer;
begin
  if gpPicture = nil then
    Result := 0
  else
  begin
    gpPicture.get_Height(hmHeight);
    Result := MulDiv(hmHeight, FLogPixY, HIMETRIC_INCH);
  end;
end;

function THTMLPicture.GetWidth: Integer;
var
  hmWidth: Integer;
begin
  if gpPicture = nil then
    Result := 0
  else
  begin
    gpPicture.get_Width(hmWidth);
    Result := MulDiv(hmWidth, FLogPixX, HIMETRIC_INCH);
  end;
end;

procedure THTMLPicture.LoadFromFile(const FileName: string);
begin
  try
    FDataStream.LoadFromFile(Filename);
    FIsEmpty:=false;
    LoadPicture;
    if Assigned(OnChange) then
      OnChange(self);
  except
    FIsEmpty:=true;
  end;
end;

procedure THTMLPicture.LoadFromStream(Stream: TStream);
begin
  if Assigned(Stream) then
  begin
    FDataStream.LoadFromStream(Stream);
    FIsEmpty := False;
    LoadPicture;
    if Assigned(OnChange) then
      OnChange(self);
  end;
end;

procedure THTMLPicture.ReadData(Stream: TStream);
begin

 if assigned(Stream) then
   begin
     fDataStream.LoadFromStream(stream);
     fIsEmpty:=false;
     LoadPicture;
   end;
end;

procedure THTMLPicture.SaveToStream(Stream: TStream);
begin
  if Assigned(Stream) then fDataStream.SaveToStream(Stream);
end;

procedure THTMLPicture.LoadFromResourceName(Instance: THandle; const ResName: string);
var
  Stream: TCustomMemoryStream;
begin
  if FindResource(Instance,pchar(ResName),RT_RCDATA)<>0 then
  begin
    Stream := TResourceStream.Create(Instance, ResName, RT_RCDATA);
    try
      LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

procedure THTMLPicture.LoadFromResourceID(Instance: THandle; ResID: Integer);
var
  Stream: TCustomMemoryStream;
begin
  Stream := TResourceStream.CreateFromID(Instance, ResID, RT_RCDATA);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;


procedure THTMLPicture.SetHeight(Value: integer);
begin

end;

procedure THTMLPicture.SetWidth(Value: integer);
begin

end;

procedure THTMLPicture.WriteData(Stream: TStream);
begin
  if Assigned(Stream) then
   begin
     FDataStream.savetostream(stream);
   end;
end;

procedure THTMLPicture.LoadFromURL(url: string);
var
  UUrl: string;
begin
  UUrl := UpperCase(url);

  if Pos('RES://',UUrl) = 1 then
  begin
    ID := url;
    Delete(url,1,6);
    if url <> '' then
      LoadFromResourceName(hinstance,url);
    Exit;
  end;

  if Pos('FILE://',Uurl) = 1 then
  begin
    ID := url;
    Delete(url,1,7);
    if url <> '' then
      LoadFromFile(url);
    Exit;
  end;

  if FAsynch then
  begin
    if FThreadBusy then
      Exit;
    FURL := url;
    FThreadBusy := True;
    TDownLoadThread.Create(self);
  end
  else
  begin
    FURL := url;
    ID := url;
    {$IFDEF USEWININET}
    DownLoad;
    {$ENDIF}
  end;
end;

{$IFDEF USEWININET}
procedure THTMLPicture.DownLoad;
var
  RBSIZE:dword;
  httpstatus,httpsize,err:integer;
  dwIdx:dword;
  dwBufSize:dword;
  ms:TMemoryStream;
  len:dword;
  cbuf:array[0..255] of char;
  rb:array[0..4095] of byte;

  FISession:hinternet;
  FIHttp:hinternet;
  Cancel:boolean;

begin
  fISession:=InternetOpen('HTMLImage',INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
  if (fISession=nil) then
  begin
    DownLoadError('Cannot open internet session');
    fThreadBusy:=false;
    Exit;
  end;

  fIHttp:=InternetOpenURL(fISession,pchar(furl),nil,0,
   INTERNET_FLAG_PRAGMA_NOCACHE or INTERNET_FLAG_NO_CACHE_WRITE or INTERNET_FLAG_RELOAD,0);

  if (fIHttp=nil) then
  begin
    InternetCloseHandle(fISession);
    DownLoadError('Cannot open http connection');
    fThreadBusy:=false;
    Exit;
  end;

  dwBufSize := SizeOf(cbuf);
  dwidx := 0;
  HttpQueryInfo(fIHttp,HTTP_QUERY_STATUS_CODE,@cbuf,dwBufSize,dwIdx);

  val(cbuf,httpstatus,err);
  if (httpstatus <> 200) or (err <> 0) then
  begin
    InternetCloseHandle(fISession);
    InternetCloseHandle(fIHttp);
    DownLoadError('Cannot open URL '+furl);
    FThreadBusy:=false;
    Exit;
  end;

  dwBufSize := SizeOf(cbuf);
  dwidx := 0;
  HttpQueryInfo(fIHttp,HTTP_QUERY_CONTENT_TYPE,@cbuf,dwBufSize,dwIdx);

  if Pos('IMAGE',UpperCase(StrPas(cbuf))) = 0 then
  begin
    InternetCloseHandle(fISession);
    InternetCloseHandle(fIHttp);
    DownLoadError('Resource is not of image type : ' + FUrl);
    fThreadBusy := false;
    Exit;
  end;

  dwBufSize := SizeOf(cbuf);
  dwidx := 0;
  HttpQueryInfo(fIHttp,HTTP_QUERY_CONTENT_LENGTH,@cbuf,dwBufSize,dwIdx);

  val(cbuf,httpsize,err);
  if (httpsize = 0) or (err <> 0) then
  begin
    InternetCloseHandle(fISession);
    InternetCloseHandle(fIHttp);
    DownLoadError('Image size is 0');
    fThreadBusy:=false;
    Exit;
  end;

  DownLoadProgress(0,httpsize);

  len := 4096;
  RBSIZE := 4096;

  ms := TMemoryStream.Create;

  cancel:=false;

  while (len=RBSIZE) and not Cancel do
  begin
    InternetReadFile(fIHttp,@rb,RBSIZE,len);
    if len>0 then ms.WriteBuffer(rb,len);
    DownLoadProgress(ms.Size,httpsize);
    DownLoadCancel(cancel);
  end;

  if not cancel then
  begin
    ms.Position := 0;
    LoadFromStream(ms);
  end;

  ms.Free;

  InternetCloseHandle(fIHttp);
  InternetCloseHandle(fISession);
  FThreadBusy:=false;
end;
{$ENDIF}

procedure THTMLPicture.DownLoadCancel(var cancel: boolean);
begin
  if assigned(FOnDownLoadCancel) then
    FOnDownLoadCancel(self,cancel);
end;

procedure THTMLPicture.DownLoadComplete;
begin
  if Assigned(FOnDownLoadComplete) then
    FOnDownLoadComplete(self);
end;

procedure THTMLPicture.DownLoadError(err: string);
begin
  if Assigned(fOnDownloadError) then
    FOnDownLoadError(self,err);
end;

procedure THTMLPicture.DownLoadProgress(dwSize, dwTotSize: dword);
begin
  if Assigned(FOnDownLoadProgress) then
    FOnDownLoadProgress(self,dwSize,dwTotSize);
end;


procedure THTMLPicture.LoadFromClipboardFormat(AFormat: Word;
  AData: THandle; APalette: HPALETTE);
begin
end;

procedure THTMLPicture.SaveToClipboardFormat(var AFormat: Word;
  var AData: THandle; var APalette: HPALETTE);
begin
end;

function THTMLPicture.GetFrameCount: Integer;
var
  i: Integer;
  b,c,d,e: Byte;
  Res: Integer;
begin
  Result := -1;

  if FFrameCount <> -1 then
    Result := FFrameCount
  else
    if IsGIFFile then
    begin
      Res := 0;
      for i := 1 to FDataStream.Size do
      begin
        FDataStream.Position := i - 1;
        FDataStream.Read(b,1);
        if (b = $21) and (i + 8 < FDataStream.Size) then
        begin
          FDataStream.Read(c,1);
          FDataStream.Read(d,1);
          FDataStream.Position := FDataStream.Position+5;
          FDataStream.Read(e,1);
          if (c = $F9) and (d = $4) and (e = $2C) then Inc(res);
        end;
      end;
      FFrameCount := Res;
      Result := Res;
      FDataStream.Position := 0;
    end;
end;

function THTMLPicture.IsGIFFile: Boolean;
var
  buf: array[0..4] of char;
begin
  Result := False;
  if FDataStream.Size>4 then
  begin
    FDataStream.Position := 0;
    {$IFNDEF TMSDOTNET}
    FDataStream.Read(buf,4);
    buf[4] := #0;
    Result := Strpas(buf) = 'GIF8';
    {$ENDIF}
    FDataStream.Position := 0;

  end;
end;

function THTMLPicture.GetFrameTime(i: Integer): Integer;
var
 j: Integer;
 b,c,d,e: Byte;
 res: Integer;
 ft: Word;

begin
  Result := -1;

  if IsGIFFile then
  begin
    Res := 0;
    for j := 1 to FDataStream.Size do
    begin
      FDataStream.Position := j-1;
      FDataStream.Read(b,1);
      if (b = $21) and (i + 8 < FDataStream.Size) then
      begin
        FDataStream.Read(c,1);
        FDataStream.Read(d,1);
        FDataStream.Read(b,1);
        {transp. flag here}

        FDataStream.Read(ft,2);
        FDataStream.Position := FDataStream.Position + 2;

        FDataStream.Read(e,1);
        if (c = $F9) and (d = $4) and (e = $2C) then
        begin
          Inc(res);
          if res = i then
          begin
            Result := ft;
            FFrameTransp := b and $01=$01;
            FFrameDisposal := (b shr 3) and $7;
          end;
        end;
      end;
    end;
  end;
  FDataStream.Position := 0;
end;

function THTMLPicture.GetMaxHeight: Integer;
var
  hmHeight: Integer;
begin
  if gpPicture = nil then
    Result := 0
  else
  begin
    if FAnimMaxY>0 then Result:=FAnimMaxY
    else
    begin
      gpPicture.get_Height(hmHeight);
      Result := MulDiv(hmHeight, fLogPixY, HIMETRIC_INCH);
    end;
  end;
end;

function THTMLPicture.GetMaxWidth: Integer;
var
  hmWidth: Integer;
begin
  if gpPicture = nil then
    Result := 0
  else
  begin
    if FAnimMaxX > 0 then
      Result := FAnimMaxX
    else
    begin
      gpPicture.get_Width(hmWidth);
      Result := MulDiv(hmWidth, fLogPixX, HIMETRIC_INCH);
    end;
  end;
end;


procedure THTMLPicture.SetFrame(const Value: Integer);
begin
  FFrame := Value;
  if FDataStream.Size > 0 then
  begin
    LoadPicture;
    if Assigned(OnFrameChange) then
      OnFrameChange(self);
  end;
end;

procedure THTMLPicture.FrameNext;
begin
  if FFrame < FFrameCount then
    Inc(FFrame)
  else
    FFrame := 1;
end;

function THTMLPicture.Step: Boolean;
begin
  Result := False;
  if (FFrameCount <= 1) or FIsEmpty then
    Exit;

  if FNextCount = -1 then
    FrameTime[FFrame];

  if FTimerCount*10 >= FNextCount then
  begin
    FrameNext;
    LoadPicture;
    FNextCount := FNextCount + FrameTime[FFrame];
    Result := True;
  end;

  Inc(FTimerCount);
end;

procedure THTMLPicture.FramePrev;
begin
  if FFrame > 1 then
    Dec(FFrame)
  else
    FFrame := FFrameCount;
end;


{ THTMLImage }

constructor THTMLImage.Create(aOwner: TComponent);
begin
  inherited;
  fHTMLPicture:=THTMLPicture.Create;
  fHTMLPicture.OnChange:=PictureChanged;
  Width:=100;
  Height:=100;
  fHTMLPicture.OnDownLoadError:=DownLoadError;
  fHTMLPicture.OnDownLoadCancel:=DownLoadCancel;
  fHTMLPicture.OnDownLoadProgress:=DownLoadProgress;
  fHTMLPicture.OnDownLoadComplete:=DownLoadComplete;
end;

destructor THTMLImage.Destroy;
begin
  fHTMLPicture.Free;
  inherited;
end;

procedure THTMLImage.Loaded;
begin
  inherited;
  fHTMLPicture.fLogPixX := GetDeviceCaps(canvas.handle,LOGPIXELSX);
  fHTMLPicture.fLogPixY := GetDeviceCaps(canvas.handle,LOGPIXELSY);
end;

procedure THTMLImage.Paint;
var
 xo,yo:integer;

   function Max(a,b:integer):integer;
   begin
    if (a>b) then result:=a else result:=b;
   end;

begin
  inherited;
  if assigned(fHTMLPicture) then
  begin
   if not fHTMLPicture.Empty then
   case fPicturePosition of
   bpTopLeft:Canvas.Draw(0,0,fHTMLPicture);
   bpTopRight:Canvas.Draw(Max(0,width-fHTMLPicture.Width),0,fHTMLPicture);
   bpBottomLeft:Canvas.Draw(0,Max(0,height-fHTMLPicture.Height),fHTMLPicture);
   bpBottomRight:Canvas.Draw(Max(0,width-fHTMLPicture.Width),Max(0,height-fHTMLPicture.Height),fHTMLPicture);
   bpCenter:Canvas.Draw(Max(0,width-fHTMLPicture.Width) shr 1,Max(0,height-fHTMLPicture.Height) shr 1,fHTMLPicture);
   bpTiled:begin
            yo:=0;
            while (yo<Height) do
             begin
              xo:=0;
              while (xo<Width) do
               begin
                Canvas.Draw(xo,yo,fHTMLPicture);
                xo:=xo+fHTMLPicture.Width;
               end;
              yo:=yo+fHTMLPicture.Height;
             end;
           end;
   bpStretched:canvas.StretchDraw(rect(0,0,width,height),fHTMLPicture) else
   end;
  end;

end;

procedure THTMLImage.PictureChanged(sender: TObject);
begin
 Invalidate;
end;

procedure THTMLImage.SetHTMLPicture(const Value: THTMLPicture);
begin
  fHTMLPicture.Assign(Value);
  Invalidate;
end;

procedure THTMLImage.SetPicturePosition(const Value: TPicturePosition);
begin
 if ( fPicturePosition <> Value) then
  begin
   fPicturePosition := Value;
   Invalidate;
  end;
end;

procedure THTMLImage.DownLoadCancel(Sender: TObject; var cancel: boolean);
begin
 if assigned(fOnDownLoadCancel) then fOnDownLoadCancel(self,cancel);
end;

procedure THTMLImage.DownLoadComplete(Sender: TObject);
begin
 if assigned(fOnDownLoadComplete) then fOnDownLoadComplete(self);
end;

procedure THTMLImage.DownLoadError(Sender: TObject; err: string);
begin
  if Assigned(FOnDownloadError) then
    FOnDownLoadError(self,err);
end;

procedure THTMLImage.DownLoadProgress(Sender: TObject; dwSize,
  dwTotSize: dword);
begin
 if Assigned(FOnDownLoadProgress) then
   FOnDownLoadProgress(self,dwSize,dwTotSize);
end;

{ TDownLoadThread }

constructor TDownLoadThread.Create(aHTMLPicture: THTMLPicture);
begin
  inherited Create(false);
  HTMLPicture := aHTMLPicture;
  FreeOnTerminate := True;
end;

procedure TDownLoadThread.Execute;
begin
 {$IFDEF USEWININET}
 HTMLPicture.DownLoad;
 {$ENDIF}
end;

{ TTntHTMLPictureCache }

destructor TTntHTMLPictureCache.Destroy;
begin
  ClearPictures;
  inherited;
end;

function TTntHTMLPictureCache.AddPicture: THTMLPicture;
begin
  Result := THTMLPicture.Create;
  Add(pointer(result));
end;

procedure TTntHTMLPictureCache.ClearPictures;
var
  i: Integer;
begin
  for i := 1 to Count do
    Items[i - 1].Free;
  inherited;
end;

function TTntHTMLPictureCache.FindPicture(ID: string): THTMLPicture;
var
  i: Integer;
begin
  Result := nil;
  for i := 1 to Count do
  begin
    if (Items[i - 1].ID = ID) then
    begin
      Result := Items[i - 1];
      Break;
    end;
  end;
end;

function TTntHTMLPictureCache.GetPicture(Index: Integer): THTMLPicture;
begin
  Result := THTMLPicture(inherited Items[Index]);
end;

procedure TTntHTMLPictureCache.SetPicture(Index: Integer; Value: THTMLPicture);
begin
  inherited Items[index] := Pointer(Value);
end;

function TTntHTMLPictureCache.Animate: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Count do
  begin
    if Items[i - 1].Step then
      Result := True;
  end;
end;

{ TPictureItem }

procedure TPictureItem.Assign(Source: TPersistent);
begin
  Name := (Source as TPictureItem).Name;
  Tag := (Source as TPictureItem).Tag;
  Picture.Assign((Source as TPictureItem).Picture)
end;

constructor TPictureItem.Create(Collection: TCollection);
begin
  inherited;
  FPicture := THTMLPicture.Create;
end;

destructor TPictureItem.Destroy;
begin
  FPicture.Free;
  inherited;
end;

procedure TPictureItem.SetPicture(const Value: THTMLPicture);
begin
  FPicture.Assign(Value);
end;

{ TPictureCollection }

function TPictureCollection.Add: TPictureItem;
begin
  Result := TPictureItem(inherited Add);
end;

function TPictureCollection.Animate: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Count do
  begin
    if Items[i - 1].Picture.Step then
      Result := True;
  end;

end;

constructor TPictureCollection.Create(AOwner: TComponent);
begin
  inherited Create(TPictureItem);
  FOwner := AOwner;
end;

function TPictureCollection.GetItem(Index: Integer): TPictureItem;
begin
  Result := TPictureItem(inherited Items[Index]);
end;

function TPictureCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TPictureCollection.Insert(index: Integer): TPictureItem;
begin
  Result := TPictureItem(inherited Insert(Index));
end;

procedure TPictureCollection.SetItem(Index: Integer;
  Value: TPictureItem);
begin
  inherited SetItem(Index, Value);
end;

{ TTntPictureContainer }

constructor TTntPictureContainer.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TPictureCollection.Create(Self);
end;

destructor TTntPictureContainer.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TTntPictureContainer.FindPicture(s: string): THTMLPicture;
var
  i: Integer;
begin
  Result := nil;
  s := Uppercase(s);
  i := 1;
  while i <= Items.Count do
  begin
    if Uppercase(Items.Items[i - 1].Name) = s then
    begin
      Result := Items.Items[i - 1].Picture;
      Break;
    end;
    Inc(i);
  end;
end;

procedure TTntPictureContainer.SetItems(const Value: TPictureCollection);
begin
  FItems := Value;
end;

function TTntPictureContainer.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TTntPictureContainer.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TTntPictureContainer.SetVersion(const Value: string);
begin

end;


end.
