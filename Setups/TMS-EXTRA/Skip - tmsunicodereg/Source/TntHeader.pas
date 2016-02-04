{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 - 2008 by TMS software                                   }
{ Email : info@tmssoftware.com                                              }
{ Web : http://www.tmssoftware.com                                          }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit TntHeader;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}
interface
uses
  ExtCtrls;

type
  TTntHeader  = class(THeader);

implementation

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}
interface

uses
  Windows, Messages, Controls, ExtCtrls, Forms, Classes, SysUtils, Graphics,
  Dialogs, TnTGraphics, TntExtCtrls, TnTClasses, TnTControls
  {$IFNDEF COMPILER_10_UP}
  , TntWideStrings
  {$ELSE}
  , WideStrings
  {$ENDIF}
  ;

type
  TTntHeader  = class(TCustomControl)
  private
    FSections: TTntStrings;
    FHitTest: TPoint;
    FCanResize: Boolean;
    FAllowResize: Boolean;
    FBorderStyle: TBorderStyle;
    FResizeSection: Integer;
    FMouseOffset: Integer;
    FOnSizing: TSectionEvent;
    FOnSized: TSectionEvent;
    function IsHintStored: Boolean;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetSections(Strings: TTntStrings);
    procedure FreeSections;
    function GetWidth(X: Integer): Integer;
    procedure SetWidth(X: Integer; Value: Integer);
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;

    function  GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
  protected
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Sizing(ASection, AWidth: Integer); dynamic;
    procedure Sized(ASection, AWidth: Integer); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SectionWidth[X: Integer]: Integer read GetWidth write SetWidth;
  published
    property Color;
    property Sections: TTntStrings read FSections write SetSections;
    property Align;
    property AllowResize: Boolean read FAllowResize write FAllowResize default True;
    property Anchors;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Constraints;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnContextPopup;
    property OnSizing : TSectionEvent read FOnSizing write FOnSizing;
    property OnSized  : TSectionEvent read FOnSized write FOnSized;
    property Hint : WideString read GetHint write SetHint stored IsHintStored;
  end;

implementation

const
  DefaultSectionWidth = 75;

type
  PHeaderSection = ^THeaderSection;
  THeaderSection = record
    FObject: TObject;
    Width : Integer;
    Title : Widestring;
  end;

type
  TTntHeaderStrings = class(TTntStrings{TWideStrings})
  private
    FHeader: TTntHeader;
    FList: TList;
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function Get(Index: Integer): Widestring; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: Widestring); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: Widestring); override;
    procedure Clear; override;
  end;

constructor TTntHeader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDesignInteractive, csOpaque];
  Width := 250;
  Height := 25;
  FSections := TTntHeaderStrings.Create;
  TTntHeaderStrings(FSections).FHeader := Self;
  FAllowResize := True;
  FBorderStyle := bsSingle;
end;

destructor TTntHeader.Destroy;
begin
  FreeSections;
  FSections.Free;
  inherited Destroy;
end;

procedure TTntHeader.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TTntHeader.Paint;
var
  I, Y, W: Integer;
  S: Widestring;
  R: TRect;
begin
  with Canvas do
  begin
    Font := Self.Font;
//    Brush.Color := clBtnFace;
    Brush.Color  :=  Color;
    I := 0;
//    Y:= (WideCanvasTextHeight(Canvas, 'T') div 2);
    Y := (ClientHeight - Canvas.TextHeight('T')) div 2;
    R := Rect(0, 0, 0, ClientHeight);
    W := 0;
    S := '';
    repeat
      if I < FSections.Count then
      begin
        with PHeaderSection(TTntHeaderStrings(FSections).FList[I])^ do
        begin
          W := Width;
          S := Title;
        end;
        Inc(I);
      end;
      R.Left := R.Right;
      Inc(R.Right, W);
      if (ClientWidth - R.Right < 2) or (I = FSections.Count) then
        R.Right := ClientWidth;
      WideCanvasTextRect(Canvas, Rect(R.Left + 1, R.Top + 1, R.Right - 1, R.Bottom - 1),
        R.Left + 3, Y, S);
//      TextRect(Rect(R.Left + 1, R.Top + 1, R.Right - 1, R.Bottom - 1),
//        R.Left + 3, Y, S);
      DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_TOPLEFT);
      DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_BOTTOMRight);
    until R.Right = ClientWidth;
  end;
end;

procedure TTntHeader.FreeSections;
begin
  if FSections <> nil then
    FSections.Clear;
end;

procedure TTntHeader.SetBorderStyle(Value: TBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TTntHeader.SetSections(Strings: TTntStrings);
begin
  FSections.Assign(Strings);
end;

function TTntHeader.GetWidth(X: Integer): Integer;
var
  I, W: Integer;
begin
  if X = FSections.Count - 1 then
  begin
    W := 0;
    for I := 0 to X - 1 do
      Inc(W, PHeaderSection(TTntHeaderStrings(FSections).FList[I])^.Width);
    Result := ClientWidth - W;
  end
  else if (X >= 0) and (X < FSections.Count) then
    Result := PHeaderSection(TTntHeaderStrings(FSections).FList[X])^.Width
  else
    Result := 0;
end;

procedure TTntHeader.SetWidth(X: Integer; Value: Integer);
begin
  if X < 0 then Exit;
  PHeaderSection(TTntHeaderStrings(FSections).FList[X])^.Width := Value;
  Invalidate;
end;

procedure TTntHeader.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  FHitTest := SmallPointToPoint(Msg.Pos);
end;

procedure TTntHeader.WMSetCursor(var Msg: TWMSetCursor);
var
  Cur: HCURSOR;
  I: Integer;
  X: Integer;
begin
  Cur := 0;
  FResizeSection := 0;
  FHitTest := ScreenToClient(FHitTest);
  X := 2;
  with Msg do
    if HitTest = HTCLIENT then
      for I := 0 to FSections.Count - 2 do  { don't count last section }
      begin
        Inc(X, PHeaderSection(TTntHeaderStrings(FSections).FList[I])^.Width);
        FMouseOffset := X - (FHitTest.X + 2);
        if Abs(FMouseOffset) < 4 then
        begin
          Cur := LoadCursor(0, IDC_SIZEWE);
          FResizeSection := I;
          Break;
        end;
      end;
  FCanResize := (FAllowResize or (csDesigning in ComponentState)) and (Cur <> 0);
  if FCanResize then SetCursor(Cur)
  else inherited;
end;

procedure TTntHeader.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if ((csDesigning in ComponentState) and (Button = mbRight)) or (Button = mbLeft) then
    if FCanResize then SetCapture(Handle);
end;

procedure TTntHeader.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  AbsPos: Integer;
  MinPos: Integer;
  MaxPos: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (GetCapture = Handle) and FCanResize then
  begin
    { absolute position of this item }
    AbsPos := 2;
    for I := 0 to FResizeSection do
      Inc(AbsPos, PHeaderSection(TTntHeaderStrings(FSections).FList[I])^.Width);

    if FResizeSection > 0 then MinPos := AbsPos -
      PHeaderSection(TTntHeaderStrings(FSections).FList[FResizeSection])^.Width + 2
    else MinPos := 2;
    MaxPos := ClientWidth - 2;
    if X < MinPos then X := MinPos;
    if X > MaxPos then X := MaxPos;

    Dec(PHeaderSection(TTntHeaderStrings(FSections).FList[FResizeSection])^.Width,
      (AbsPos - X - 2) - FMouseOffset);
    Sizing(FResizeSection,
      PHeaderSection(TTntHeaderStrings(FSections).FList[FResizeSection])^.Width);
    Refresh;
  end;
end;

procedure TTntHeader.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FCanResize then
  begin
    ReleaseCapture;
    Sized(FResizeSection,
      PHeaderSection(TTntHeaderStrings(FSections).FList[FResizeSection])^.Width);
    FCanResize := False;
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TTntHeader.Sizing(ASection, AWidth: Integer);
begin
  if Assigned(FOnSizing) then FOnSizing(Self, ASection, AWidth);
end;

procedure TTntHeader.Sized(ASection, AWidth: Integer);
var
  Form: TCustomForm;
begin
  if Assigned(FOnSized) then FOnSized(Self, ASection, AWidth);
  if csDesigning in ComponentState then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Designer.Modified;
  end;
end;

procedure TTntHeader.WMSize(var Msg: TWMSize);
begin
  inherited;
  Invalidate;
end;

procedure TTntHeader.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

function TTntHeader.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

procedure TTntHeader.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

function TTntHeader.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

procedure FreeSection(Section: PHeaderSection);
begin
  if Section <> nil then Dispose(Section);
end;

function NewSection(const ATitle: Widestring; AWidth: Integer; AObject: TObject): PHeaderSection;
begin
  New(Result);
  with Result^ do
  begin
    Title := ATitle;
    Width := AWidth;
    FObject := AObject;
  end;
end;

//******************************************************************************
// Header Strings
//******************************************************************************
constructor TTntHeaderStrings.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TTntHeaderStrings.Destroy;
begin
  if FList <> nil then
  begin
    Clear;
    FList.Free;
  end;
  inherited Destroy;
end;

procedure TTntHeaderStrings.Assign(Source: TPersistent);
var
  I, J: Integer;
  Strings: TWideStrings;
  NewList: TList;
  Section: PHeaderSection;
  TempStr: Widestring;
  Found: Boolean;
begin
  if Source is TWideStrings then
  begin
    Strings := TWideStrings(Source);
    BeginUpdate;
    try
      NewList := TList.Create;
      try
        { Delete any sections not in the new list }
        I := FList.Count - 1;
        Found := False;
        while I >= 0 do
        begin
          TempStr := Get(I);
          for J := 0 to Strings.Count - 1 do
          begin
            Found := AnsiCompareStr(Strings[J], TempStr) = 0;
            if Found then Break;
          end;
          if not Found then Delete(I);
          Dec(I);
        end;

        { Now iterate over the lists and maintain section widths of sections in
          the new list }
        I := 0;
        for J := 0 to Strings.Count - 1 do
        begin
          if (I < FList.Count) and (AnsiCompareStr(Strings[J], Get(I)) = 0) then
          begin
            Section := NewSection(Get(I), PHeaderSection(FList[I])^.Width, GetObject(I));
            Inc(I);
          end else
            Section := NewSection(Strings[J],
              FHeader.Canvas.TextWidth(Strings[J]) + 8, Strings.Objects[J]);
          NewList.Add(Section);
        end;
        Clear;
        FList.Destroy;
        FList := NewList;
        FHeader.Invalidate;
      except
        for I := 0 to NewList.Count - 1 do
          FreeSection(NewList[I]);
        NewList.Destroy;
        raise;
      end;
    finally
      EndUpdate;
    end;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TTntHeaderStrings.DefineProperties(Filer: TFiler);
begin
  { This will allow the old file image read in }
  if Filer is TReader then inherited DefineProperties(Filer);
  Filer.DefineProperty('Sections', ReadData, WriteData, Count > 0);
end;

procedure TTntHeaderStrings.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    FreeSection(FList[I]);
  FList.Clear;
end;

procedure TTntHeaderStrings.Delete(Index: Integer);
begin
  FreeSection(FList[Index]);
  FList.Delete(Index);
  if FHeader <> nil then FHeader.Invalidate;
end;

function TTntHeaderStrings.Get(Index: Integer): Widestring;
begin
  Result := PHeaderSection(FList[Index])^.Title;
end;

function TTntHeaderStrings.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TTntHeaderStrings.GetObject(Index: Integer): TObject;
begin
  Result := PHeaderSection(FList[Index])^.FObject;
end;

procedure TTntHeaderStrings.Insert(Index: Integer; const S: Widestring);
var
  Width: Integer;
begin
  if FHeader <> nil then
    Width :=  WideCanvasTextWidth(FHeader.Canvas, s)+ 10
//    FHeader.Canvas.TextWidth(S) + 8
  else
    Width := DefaultSectionWidth;
  FList.Expand.Insert(Index, NewSection(S, Width, nil));
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure TTntHeaderStrings.Put(Index: Integer; const S: Widestring);
var
  P: PHeaderSection;
  Width: Integer;
begin
  P := FList[Index];
  if FHeader <> nil then
    Width :=  WideCanvasTextWidth(FHeader.Canvas, s)+ 10
//    Width := FHeader.Canvas.TextWidth(S) + 8
  else Width := DefaultSectionWidth;
  FList[Index] := NewSection(S, Width, P^.FObject);
  FreeSection(P);
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure TTntHeaderStrings.PutObject(Index: Integer; AObject: TObject);
begin
  PHeaderSection(FList[Index])^.FObject := AObject;
  if FHeader <> nil then FHeader.Invalidate;
end;

procedure TTntHeaderStrings.SetUpdateState(Updating: Boolean);
begin
  if FHeader <> nil then
  begin
    SendMessage(FHeader.Handle, WM_SETREDRAW, Ord(not Updating), 0);
    if not Updating then FHeader.Refresh;
  end;
end;

procedure TTntHeaderStrings.ReadData(Reader: TReader);
var
  Width, I: Integer;
  Str: Widestring;
begin
  Reader.ReadListBegin;
  Clear;
  while not Reader.EndOfList do
  begin
    i :=  Reader.ReadInteger;
    Str := Reader.ReadWideString;
//    if (I<0) or (I> TWinControl(Self.Parent).Width) then
//      Width := DefaultSectionWidth;
//    else
      Width := i;

  //    Width := DefaultSectionWidth;
//    Reader.ReadWideString(Str);
  (*    I := 1;
    if Str[1] = '~' then//#0 then
    begin
      repeat
        Inc(I);
      until (I > Length(Str)) or (Str[I] = #0);
      Width := StrToIntDef(Copy(Str, 2, I - 2), DefaultSectionWidth);
      System.Delete(Str, 1, I);
    end;
*)    FList.Expand.Insert(FList.Count, NewSection(Str, Width, nil));
  end;
  Reader.ReadListEnd;
end;

procedure TTntHeaderStrings.WriteData(Writer: TWriter);
var
  I: Integer;
  HeaderSection: PHeaderSection;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do
  begin
    HeaderSection := FList[I];
    with HeaderSection^ do
      begin
//        Wide
        Writer.WriteInteger(Width);
        Writer.WriteWideString(Title);
      end;
    //      Writer.WriteWideString(WideFormat('~%d~%s', [Width, Title]));
  end;
  Writer.WriteListEnd;
end;

{$ENDIF}

end.
