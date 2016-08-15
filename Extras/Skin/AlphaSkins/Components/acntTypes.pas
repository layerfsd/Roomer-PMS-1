unit acntTypes;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  {$IFDEF TNTUNICODE} TntMenus, {$ENDIF}
{$IFNDEF NOJPG}
  {$IFDEF TINYJPG} acTinyJpg, {$ELSE} Jpeg, {$ENDIF}
{$ENDIF}
  Controls, Menus, Windows, Classes, Forms, Graphics, Messages;

{$IFNDEF NOTFORHELP}

type
  TacBounds = record
    BLeft, BTop, BWidth, BHeight: integer;
  end;

  TSrcRect = packed record
    SLeft, STop, SRight, SBottom: {$IFDEF DELPHI_XE8}FixedInt{$ELSE}Longint{$ENDIF};
  end;

  TDstRect = packed record
    DLeft, DTop, DRight, DBottom: {$IFDEF DELPHI_XE8}FixedInt{$ELSE}Longint{$ENDIF};
  end;

  PacLayerPos = ^TacLayerPos;
  TacLayerPos = record
    Bounds: TacBounds;
    LayerBlend: byte;
  end;

  TStringLists = array of TStringList;
  TRects = array of Windows.TRect;
  TacJpegClass = {$IFDEF TINYJPG}TacTinyJPGImage{$ELSE}TJPEGImage{$ENDIF};
  TacMenuItem = {$IFDEF TNTUNICODE}TTntMenuItem{$ELSE}TMenuItem{$ENDIF};

  TacAccessControl = class(TControl)
  public
    property AutoSize;
    property ParentColor;
    property Color;
    property ParentFont;
    property PopupMenu;
    property Font;
  end;

  TacAccessCanvas = class({$IFDEF D2010}TCustomCanvas{$ELSE}TPersistent{$ENDIF})
  public
    FHandle: HDC;
  end;

  TacGlowForm = class(TCustomForm)
  public
    procedure AfterConstruction; override;
    procedure CreateWnd; override;
    procedure WndProc(var Message: TMessage); override;
  end;

{$IFDEF FPC}
{
  TShowAction = (saIgnore, saRestore, saMinimize, saMaximize);

  TWMCopyData = packed record
    Msg: Cardinal;
    From: HWND;
    CopyDataStruct: PCopyDataStruct;
    Result: Longint;
  end;

  TWMNCActivate = packed record
    Msg: Cardinal;
    Active: BOOL;
    Unused,
    Result: Longint;
  end;
}
{$ENDIF}

function acBounds(Left, Top, Width, Height: integer): TacBounds;

{$ENDIF}

implementation

uses
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  sConst;


function acBounds(Left, Top, Width, Height: integer): TacBounds;
begin
  with Result do begin
    BLeft := Left;
    BTop := Top;
    BWidth := Width;
    BHeight := Height;
  end;
end;


procedure TacGlowForm.AfterConstruction;
begin
  inherited;
  Tag := ExceptTag;
  BorderStyle := bsNone;
  Assert(not Visible);
//  Visible := False;
end;


procedure TacGlowForm.CreateWnd;
begin
  inherited;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE);
  SetClassLong(Handle, GCL_STYLE, GetClassLong(Handle, GCL_STYLE) and not NCS_DROPSHADOW);
//  BorderStyle := bsNone;
end;


procedure TacGlowForm.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  if Tag = 2 then
    AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    // Removing of blinking
    CM_VISIBLECHANGED, WM_SHOWWINDOW:
      if (Message.WParam = 0) and HandleAllocated then // If hide
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWPA_HIDE or SWP_NOMOVE or SWP_NOSIZE);

    WM_NCHITTEST: begin
      Message.Result := HTTRANSPARENT;
      Exit;
    end;
  end;
  inherited;
end;

end.




