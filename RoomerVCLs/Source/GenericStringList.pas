unit GenericStringList;

{
Copyright (C) 2013 Michal Turecki
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
History:
  v1.0 2013-07-25 First public release
}

interface

uses
  Classes,
  Generics.Collections;

type
  TStringList<T: class> = class(TStringList)
  private
    function GetItem(const Index: string): T;
  protected
    function GetObject(Index: Integer): T; reintroduce; virtual;
    procedure PutObject(Index: Integer; const Value: T); reintroduce; virtual;
  public
    function AddObject(const S: string; AObject: T): Integer; reintroduce; virtual;
  public
    property Objects[Index: Integer]: T read GetObject write PutObject; default;
    property Items[const Index: string]: T read GetItem;
  end;

  TPersistentStringList<T: TPersistent, constructor> = class(TStringList<T>)
  public
    procedure Assign(Source: TPersistent); override;
  end;

  TPersistentList<T: TPersistent, constructor> = class(TObjectList<T>)
  public
    procedure Assign(Source: TList<T>);
  end;

implementation

{ TStringList<T> }

function TStringList<T>.AddObject(const S: string; AObject: T): Integer;
begin
  Result := inherited AddObject(S, AObject);
end;

function TStringList<T>.GetItem(const Index: string): T;
var
  idx: Integer;
begin
  idx := IndexOf(Index);
  if idx >= 0 then
    Result := Objects[idx]
  else
    Result := nil;
end;

function TStringList<T>.GetObject(Index: Integer): T;
begin
  Result := T(inherited GetObject(Index));
end;

procedure TStringList<T>.PutObject(Index: Integer; const Value: T);
begin
  inherited PutObject(Index, Value);
end;

{ TPersistentList<T> }

procedure TPersistentStringList<T>.Assign(Source: TPersistent);
var
  i: Integer;
  o: T;
begin
  inherited Assign(Source);
  for i := 0 to Count - 1 do
  begin
    if Assigned(Objects[i]) then
    begin
      o := T(T.Create);
      o.Assign(Objects[i]);
      inherited PutObject(i, o);
    end;
  end;
end;

{ TPersistentList<T> }

procedure TPersistentList<T>.Assign(Source: TList<T>);
var
  i: Integer;
  o: T;
begin
  Capacity := Source.Capacity;
  for i := 0 to Source.Count - 1 do
  begin
    if Assigned(Source.Items[i]) then
    begin
      o := T(T.Create);
      o.Assign(Source.Items[i]);
      Add(o);
    end;
  end;
end;

end.