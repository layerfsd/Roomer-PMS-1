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

unit TntAxCtrls;

{$INCLUDE TntCompilers.inc}

interface

uses
  ComObj, StdVcl,
  {$IFNDEF COMPILER_10_UP}
  TntWideStrings,
  {$ELSE}
  WideStrings,
  {$ENDIF}
  TntClasses, Classes;

type
  TWideStringsAdapter = class(TAutoIntfObject, IStrings, IWideStringsAdapter)
  private
    {$IFDEF DELPHI_UNICODE}
    FStrings: TStrings;
    {$ENDIF}
    {$IFNDEF DELPHI_UNICODE}
    FStrings: TWideStrings;
    {$ENDIF}
  protected
    { IWideStringsAdapter }
    procedure ReferenceStrings(S: TWideStrings);
    procedure ReleaseStrings;
    { IStrings }
    function Get_ControlDefault(Index: Integer): OleVariant; safecall;
    procedure Set_ControlDefault(Index: Integer; Value: OleVariant); safecall;
    function Count: Integer; safecall;
    function Get_Item(Index: Integer): OleVariant; safecall;
    procedure Set_Item(Index: Integer; Value: OleVariant); safecall;
    procedure Remove(Index: Integer); safecall;
    procedure Clear; safecall;
    function Add(Item: OleVariant): Integer; safecall;
    function _NewEnum: IUnknown; safecall;
  public
    constructor Create(Strings: TTntStrings);
  end;

implementation

uses
  ActiveX, Variants;

{ TStringsEnumerator }

type
  TStringsEnumerator = class(TContainedObject, IEnumString)
  private
    FIndex: Integer;  // index of next unread string
    FStrings: IStrings;
  public
    constructor Create(const Strings: IStrings);
    function Next(celt: Longint; out elt;
      pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out enm: IEnumString): HResult; stdcall;
  end;

constructor TStringsEnumerator.Create(const Strings: IStrings);
begin
  inherited Create(Strings);
  FStrings := Strings;
end;

function TStringsEnumerator.Next(celt: Longint; out elt; pceltFetched: PLongint): HResult;
var
  I: Integer;
begin
  I := 0;
  while (I < celt) and (FIndex < FStrings.Count) do
  begin
    TPointerList(elt)[I] := PWideChar(WideString(FStrings.Item[FIndex]));
    Inc(I);
    Inc(FIndex);
  end;
  if pceltFetched <> nil then pceltFetched^ := I;
  if I = celt then Result := S_OK else Result := S_FALSE;
end;

function TStringsEnumerator.Skip(celt: Longint): HResult;
begin
  if (FIndex + celt) <= FStrings.Count then
  begin
    Inc(FIndex, celt);
    Result := S_OK;
  end
  else
  begin
    FIndex := FStrings.Count;
    Result := S_FALSE;
  end;
end;

function TStringsEnumerator.Reset: HResult;
begin
  FIndex := 0;
  Result := S_OK;
end;

function TStringsEnumerator.Clone(out enm: IEnumString): HResult;
begin
  try
    enm := TStringsEnumerator.Create(FStrings);
    TStringsEnumerator(enm).FIndex := FIndex;
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

{ TWideStringsAdapter }

constructor TWideStringsAdapter.Create(Strings: TTntStrings);
var
  StdVcl: ITypeLib;
begin
  OleCheck(LoadRegTypeLib(LIBID_STDVCL, 4, 0, 0, StdVcl));
  inherited Create(StdVcl, IStrings);
  FStrings := Strings;
end;

procedure TWideStringsAdapter.ReferenceStrings(S: TWideStrings);
begin
  FStrings := S;
end;

procedure TWideStringsAdapter.ReleaseStrings;
begin
  FStrings := nil;
end;

function TWideStringsAdapter.Get_ControlDefault(Index: Integer): OleVariant;
begin
  Result := Get_Item(Index);
end;

procedure TWideStringsAdapter.Set_ControlDefault(Index: Integer; Value: OleVariant);
begin
  Set_Item(Index, Value);
end;

function TWideStringsAdapter.Count: Integer;
begin
  Result := 0;
  if FStrings <> nil then Result := FStrings.Count;
end;

function TWideStringsAdapter.Get_Item(Index: Integer): OleVariant;
begin
  Result := NULL;
  if (FStrings <> nil) then Result := WideString(FStrings[Index]);
end;

procedure TWideStringsAdapter.Set_Item(Index: Integer; Value: OleVariant);
begin
  if (FStrings <> nil) then FStrings[Index] := Value;
end;

procedure TWideStringsAdapter.Remove(Index: Integer);
begin
  if FStrings <> nil then FStrings.Delete(Index);
end;

procedure TWideStringsAdapter.Clear;
begin
  if FStrings <> nil then FStrings.Clear;
end;

function TWideStringsAdapter.Add(Item: OleVariant): Integer;
begin
  Result := -1;
  if FStrings <> nil then Result := FStrings.Add(Item);
end;

function TWideStringsAdapter._NewEnum: IUnknown;
begin
  Result := TStringsEnumerator.Create(Self);
end;

end.
