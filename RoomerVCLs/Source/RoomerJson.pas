unit RoomerJson;

interface

uses System.SysUtils, System.Classes;

type
{$SCOPEDENUMS ON}

  TJSONValueType = (&string, number, &array, &object, boolean, null, raw);

  IJSONObject = interface;
  IJSONArray = interface;

  TMultiValue = record
    ValueType : TJSONValueType;
    StringValue : string;
    NumberValue : Double;
    IntegerValue : Int64;
    ObjectValue : IJSONObject;
    ArrayValue : IJSONArray;
    constructor Initialize(const Value : String); overload;
    constructor Initialize(const Value : Double); overload;
    constructor Initialize(const Value : Int64); overload;
    constructor Initialize(const Value : Boolean); overload;
    constructor Initialize(const Value : IJSONObject); overload;
    constructor Initialize(const Value : IJSONArray); overload;
    function InitializeNull : TMultiValue;
    constructor InitializeRaw(const Value : String);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;
  end;
  PMultiValue = ^TMultiValue;

  IJSONArray = interface(IInterface)
    ['{2D496737-5D01-4332-B2C2-7328772E3587}']
    function GetBoolean(const idx: integer): Boolean;
    function GetCount: integer;
    function GetNumber(const idx: integer): Double;
    function GetInteger(const idx: integer): Int64;
    function GetItem(const idx: integer): Variant;
    function GetString(const idx: integer): string;
    function GetObject(const idx: integer): IJSONObject;
    function GetArray(const idx: integer): IJSONArray;
    function GetType(const idx: integer): TJSONValueType;
    procedure SetBoolean(const idx: integer; const Value: Boolean);
    procedure SetCount(const Value: integer);
    procedure SetNumber(const idx: integer; const Value: Double);
    procedure SetInteger(const idx: integer; const Value: Int64);
    procedure SetItem(const idx: integer; const Value: Variant);
    procedure SetString(const idx: integer; const Value: string);
    procedure SetArray(const idx: integer; const Value: IJSONArray);
    procedure SetObject(const idx: integer; const Value: IJSONObject);
    procedure SetType(const idx: integer; const Value: TJSONValueType);

    procedure Add(const value : string); overload;
    procedure Add(const value : double); overload;
    procedure Add(const value : int64); overload;
    procedure Add(const value : boolean); overload;
    procedure Add(const value : IJSONArray); overload;
    procedure Add(const value : IJSONObject); overload;
    procedure AddNull;
    procedure AddRaw(const value : string);

    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    property Strings[const idx : integer] : string read GetString write SetString;
    property Numbers[const idx : integer] : Double read GetNumber write SetNumber;
    property Integers[const idx : integer] : Int64 read GetInteger write SetInteger;
    property Booleans[const idx : integer] : Boolean read GetBoolean write SetBoolean;
    property Objects[const idx : integer] : IJSONObject read GetObject write SetObject;
    property Arrays[const idx : integer] : IJSONArray read GetArray write SetArray;
    property Items[const idx : integer] : Variant read GetItem write SetItem; default;
    property Types[const idx : integer] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount write SetCount;
  end;

  IJSONObject = interface(IInterface)
    ['{D99D532B-A21C-4135-9DF5-0FFC8538CED4}']
    function GetBoolean(const name : string): Boolean;
    function GetCount: integer;
    function GetNumber(const name : string): Double;
    function GetInteger(const name : string): Int64;
    function GetItem(const name : string): Variant;
    function GetString(const name : string): string;
    function GetObject(const name : string): IJSONObject;
    function GetArray(const name : string): IJSONArray;
    function GetType(const name : string): TJSONValueType;
    function GetName(const idx : integer): string;
    procedure SetBoolean(const name : string; const Value: Boolean);
    procedure SetNumber(const name : string; const Value: Double);
    procedure SetInteger(const name : string; const Value: Int64);
    procedure SetItem(const name : string; const Value: Variant);
    procedure SetString(const name : string; const Value: string);
    procedure SetArray(const name : string; const Value: IJSONArray);
    procedure SetObject(const name : string; const Value: IJSONObject);
    procedure SetType(const name : string; const Value: TJSONValueType);

    procedure Add(const name : string; const value : string); overload;
    procedure Add(const name : string; const value : double); overload;
    procedure Add(const name : string; const value : Int64); overload;
    procedure Add(const name : string; const value : boolean); overload;
    procedure Add(const name : string; const value : IJSONArray); overload;
    procedure Add(const name : string; const value : IJSONObject); overload;
    procedure AddNull(const name : string);
    procedure AddRaw(const name : string; const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    property Strings[const name : string] : string read GetString write SetString;
    property Numbers[const name : string] : Double read GetNumber write SetNumber;
    property Integers[const name : string] : Int64 read GetInteger write SetInteger;
    property Booleans[const name : string] : Boolean read GetBoolean write SetBoolean;
    property Objects[const name : string] : IJSONObject read GetObject write SetObject;
    property Arrays[const name : string] : IJSONArray read GetArray write SetArray;
    property Items[const name : string] : Variant read GetItem

 write SetItem; default;
    property Types[const name : string] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount;
    property Names[const idx : integer] : string read GetName;
  end;

function JSON(const src : string = '') : IJSONObject;
function JSONArray : IJSONArray;

implementation

uses System.Variants, System.Generics.Collections, RoomerJsonParser;

type
  TJSONArray = class(TInterfacedObject, IJSONArray)
  private // IJSONArray
    function GetBoolean(const idx: integer): Boolean;
    function GetCount: integer;
    function GetNumber(const idx: integer): Double;
    function GetInteger(const idx: integer): Int64;
    function GetItem(const idx: integer): Variant;
    function GetString(const idx: integer): string;
    function GetObject(const idx: integer): IJSONObject;
    function GetArray(const idx: integer): IJSONArray;
    function GetType(const idx: integer): TJSONValueType;
    procedure SetBoolean(const idx: integer; const Value: Boolean);
    procedure SetCount(const Value: integer);
    procedure SetNumber(const idx: integer; const Value: Double);
    procedure SetInteger(const idx: integer; const Value: Int64);
    procedure SetItem(const idx: integer; const Value: Variant);
    procedure SetString(const idx: integer; const Value: string);
    procedure SetArray(const idx: integer; const Value: IJSONArray);
    procedure SetObject(const idx: integer; const Value: IJSONObject);
    procedure SetType(const idx: integer; const Value: TJSONValueType);
  private
    FValues : TList<PMultiValue>;
    procedure EnsureSize(const idx : integer);
  public // IJSONArray
    procedure Add(const value : string); overload;
    procedure Add(const value : double); overload;
    procedure Add(const value : boolean); overload;
    procedure Add(const value : Int64); overload;
    procedure Add(const value : IJSONArray); overload;
    procedure Add(const value : IJSONObject); overload;
    procedure AddNull;
    procedure AddRaw(const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    property Strings[const idx : integer] : string read GetString write SetString;
    property Numbers[const idx : integer] : Double read GetNumber write SetNumber;
    property Integers[const idx : integer] : Int64 read GetInteger write SetInteger;
    property Booleans[const idx : integer] : Boolean read GetBoolean write SetBoolean;
    property Objects[const idx : integer] : IJSONObject read GetObject write SetObject;
    property Arrays[const idx : integer] : IJSONArray read GetArray write SetArray;
    property Items[const idx : integer] : Variant read GetItem write SetItem; default;
    property Types[const idx : integer] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount write SetCount;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TJSONObject = class(TInterfacedObject, IJSONObject)
  private // IJSONObject
    function GetBoolean(const name : string): Boolean;
    function GetCount: integer;
    function GetNumber(const name : string): Double;
    function GetInteger(const name : string): Int64;
    function GetItem(const name : string): Variant;
    function GetString(const name : string): string;
    function GetObject(const name : string): IJSONObject;
    function GetArray(const name : string): IJSONArray;
    function GetType(const name : string): TJSONValueType;
    function GetName(const idx : integer): string;
    procedure SetBoolean(const name : string; const Value: Boolean);
    procedure SetNumber(const name : string; const Value: Double);
    procedure SetInteger(const name : string; const Value: Int64);
    procedure SetItem(const name : string; const Value: Variant);
    procedure SetString(const name : string; const Value: string);
    procedure SetArray(const name : string; const Value: IJSONArray);
    procedure SetObject(const name : string; const Value: IJSONObject);
    procedure SetType(const name : string; const Value: TJSONValueType);
  private
    FValues : TDictionary<string, PMultiValue>;
    procedure DisposeOfValue(Sender: TObject; const Item: PMultiValue; Action: TCollectionNotification);
  public  // IJSONObject
    procedure Add(const name : string; const value : string); overload;
    procedure Add(const name : string; const value : double); overload;
    procedure Add(const name : string; const value : Int64); overload;
    procedure Add(const name : string; const value : boolean); overload;
    procedure Add(const name : string; const value : IJSONArray); overload;
    procedure Add(const name : string; const value : IJSONObject); overload;
    procedure AddNull(const name : string);
    procedure AddRaw(const name : string; const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    property Strings[const name : string] : string read GetString write SetString;
    property Numbers[const name : string] : Double read GetNumber write SetNumber;
    property Integers[const name : string] : Int64 read GetInteger write SetInteger;
    property Booleans[const name : string] : Boolean read GetBoolean write SetBoolean;
    property Objects[const name : string] : IJSONObject read GetObject write SetObject;
    property Arrays[const name : string] : IJSONArray read GetArray write SetArray;
    property Items[const name : string] : Variant read GetItem write SetItem; default;
    property Types[const name : string] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount;
    property Names[const idx : integer] : string read GetName;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

procedure VerifyType(t1, t2 : TJSONValueType);
begin
  if t1 <> t2 then
    raise Exception.Create('Value is not of required type');
end;

function JSON(const src : string) : IJSONObject;
begin
  if src <> '' then
    Result := TParser.Parse(src)
  else
    Result := TJSONObject.Create;
end;

function JSONArray : IJSONArray;
begin
  Result := TJSONArray.Create;
end;

{ TJSONArray }

procedure TJSONArray.Add(const value: double);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: boolean);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: IJSONObject);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: Int64);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: IJSONArray);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.AddNull;
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeNull;
  FValues.Add(pmv);
end;

procedure TJSONArray.AddRaw(const value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeRaw(value);
  FValues.Add(pmv);
end;

function TJSONArray.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TJSONArray.AsJSON(var Result : string);
var
  i: Integer;
begin
  Result := Result+'[';
  for i := 0 to FValues.Count-1 do
  begin
    if i > 0 then
      Result := Result+',';
    FValues[i].AsJSON(Result);
  end;
  Result := Result+']';
end;

constructor TJSONArray.Create;
begin
  inherited Create;
  FValues := TList<PMultiValue>.Create;
end;

destructor TJSONArray.Destroy;
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    Dispose(FValues[i]);
  FValues.Free;
  inherited;
end;

procedure TJSONArray.EnsureSize(const idx: integer);
var
  pmv : PMultiValue;
begin
  while FValues.Count <= idx do
  begin
    New(pmv);
    pmv.InitializeNull;
    FValues.Add(pmv);
  end;
end;

function TJSONArray.GetArray(const idx: integer): IJSONArray;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.&array);
  Result := FValues.Items[idx].ArrayValue;
end;

function TJSONArray.GetBoolean(const idx: integer): Boolean;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.boolean);
  Result := FValues.Items[idx].IntegerValue <> 0;
end;

function TJSONArray.GetCount: integer;
begin
  Result := FValues.Count;
end;

function TJSONArray.GetNumber(const idx: integer): Double;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.number);
  Result := FValues.Items[idx].NumberValue;
end;

function TJSONArray.GetInteger(const idx: integer): Int64;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.number);
  Result := FValues.Items[idx].IntegerValue;
end;

function TJSONArray.GetItem(const idx: integer): Variant;
var
  jsNull : IJSONObject;
begin
  case FValues.Items[idx].ValueType of
    TJSONValueType.string:
      result := GetString(idx);
    TJSONValueType.number:
      result := GetNumber(idx);
    TJSONValueType.&array:
      result := GetArray(idx);
    TJSONValueType.&object:
      result := GetObject(idx);
    TJSONValueType.boolean:
      result := GetBoolean(idx);
    TJSONValueType.null:
    begin
      jsNull := nil;
      result := jsNull;
    end;
  end;
end;

function TJSONArray.GetObject(const idx: integer): IJSONObject;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.&object);
  Result := FValues.Items[idx].ObjectValue;
end;

function TJSONArray.GetString(const idx: integer): string;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.string);
  Result := FValues.Items[idx].StringValue;
end;

function TJSONArray.GetType(const idx: integer): TJSONValueType;
begin
  Result := FValues.Items[idx].ValueType;
end;

procedure TJSONArray.SetArray(const idx: integer; const Value: IJSONArray);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetBoolean(const idx: integer; const Value: Boolean);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetCount(const Value: integer);
begin
  EnsureSize(Value);
  while FValues.Count > Value do
    FValues.Delete(FValues.Count-1);
end;

procedure TJSONArray.SetNumber(const idx: integer; const Value: Double);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetInteger(const idx: integer; const Value: Int64);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetItem(const idx: integer; const Value: Variant);
var
  jso : IJSONObject;
  jsa : IJSONArray;
  d : Double;
  s : string;
  b : Boolean;
  i : integer;
begin
  EnsureSize(idx);
  if VarIsType(Value,varUnknown) then
  begin
    if Supports(Value, IJSONObject, jso) then
    begin
      FValues.Items[idx].Initialize(jso)
    end else if Supports(Value, IJSONArray, jsa) then
    begin
      FValues.Items[idx].Initialize(jsa);
    end else
      raise Exception.Create('Unknown variant type.');
  end else
    case VarType(Value) of
      varSmallInt,
      varInteger,
      varSingle,
      varDouble,
      varCurrency,
      varShortInt,
      varByte,
      varWord,
      varLongWord,
      varInt64,
      varUInt64:
      begin
        d := VarAsType(Value,varDouble);
        FValues.Items[idx].Initialize(d);
      end;

      varDate:
      begin
        FValues.Items[idx].Initialize(DateToStr(Value,TFormatSettings.Create('en-us')));
      end;

      varBoolean:
      begin
        b := VarAsType(Value,varBoolean);
        FValues.Items[idx].Initialize(b);
      end;

      varOleStr,
      varString,
      varUString:
      begin
        s := VarAsType(Value,varString);
        FValues.Items[idx].Initialize(s);
      end;

      varArray:
      begin
        jsa := TJSONArray.Create;
        for i := VarArrayLowBound(Value,1) to VarArrayHighBound(Value,1) do
          jsa[i] := Value[i];

        FValues.Items[idx].Initialize(jsa);
      end;

      else
        raise Exception.Create('Unknown variant type.');
    end;
end;

procedure TJSONArray.SetObject(const idx: integer; const Value: IJSONObject);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetString(const idx: integer; const Value: string);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetType(const idx: integer; const Value: TJSONValueType);
begin
  EnsureSize(idx);
  if Value <> FValues.Items[idx].ValueType then
    case Value of
      TJSONValueType.string:
        FValues.Items[idx].Initialize('');
      TJSONValueType.number:
        FValues.Items[idx].Initialize(0);
      TJSONValueType.array:
        FValues.Items[idx].Initialize(TJSONArray.Create);
      TJSONValueType.object:
        FValues.Items[idx].Initialize(TJSONObject.Create);
      TJSONValueType.boolean:
        FValues.Items[idx].Initialize(False);
      TJSONValueType.null:
        FValues.Items[idx].InitializeNull;
    end;
end;

{ TJSONObject }

procedure TJSONObject.Add(const name: string; const value: double);
begin
  Numbers[name] := value;
end;

procedure TJSONObject.Add(const name, value: string);
begin
  Strings[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: boolean);
begin
  Booleans[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: IJSONObject);
begin
  Objects[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: Int64);
begin
  Integers[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: IJSONArray);
begin
  Arrays[name] := value;
end;

procedure TJSONObject.AddNull(const name: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeNull;
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.AddRaw(const name, value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeRaw(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

function TJSONObject.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TJSONObject.AsJSON(var Result : string);
var
  item : TPair<string, PMultiValue>;
  bFirst : boolean;
begin
  Result := Result+'{';
  bFirst := True;
  for item in FValues do
  begin
    if not bFirst then
      Result := Result +', "'+item.Key+'" : '
    else
      Result := Result+'"'+item.Key+'" : ';
    item.Value.AsJSON(Result);
    bFirst := False;
  end;
  Result := Result+'}';
end;

constructor TJSONObject.Create;
begin
  inherited Create;
  FValues := TDictionary<string, PMultiValue>.Create;
  FValues.OnValueNotify := DisposeOfValue;
end;

destructor TJSONObject.Destroy;
begin
  FValues.Free;
  inherited;
end;

procedure TJSONObject.DisposeOfValue(Sender: TObject; const Item: PMultiValue;
  Action: TCollectionNotification);
begin
  if Action = TCollectionNotification.cnRemoved then
    Dispose(Item);
end;

function TJSONObject.GetArray(const name: string): IJSONArray;
begin
  VerifyType(FValues[Name].ValueType, TJSONValueType.&array);
  Result := FValues[Name].ArrayValue;
end;

function TJSONObject.GetBoolean(const name: string): Boolean;
begin
  VerifyType(FValues[Name].ValueType, TJSONValueType.boolean);
  Result := FValues[Name].IntegerValue <> 0;
end;

function TJSONObject.GetCount: integer;
begin
  Result := FValues.Count;
end;

function TJSONObject.GetNumber(const name: string): Double;
begin
  VerifyType(FValues[Name].ValueType, TJSONValueType.number);
  Result := FValues[Name].NumberValue;
end;

function TJSONObject.GetInteger(const name: string): Int64;
begin
  VerifyType(FValues[Name].ValueType, TJSONValueType.number);
  Result := FValues[Name].IntegerValue;
end;

function TJSONObject.GetItem(const name: string): Variant;
var
  mv : PMultiValue;
begin
  mv := FValues[Name];
  case mv.ValueType of
    TJSONValueType.string:
      Result := mv.StringValue;
    TJSONValueType.number:
      Result := mv.NumberValue;
    TJSONValueType.array:
      Result := mv.ArrayValue;
    TJSONValueType.object:
      Result := mv.ObjectValue;
    TJSONValueType.boolean:
      Result := mv.IntegerValue <> 0;
    TJSONValueType.null:
      Result := Null;
  end;
end;

function TJSONObject.GetName(const idx: integer): string;
begin
  Result := FValues.Keys.ToArray[idx];
end;

function TJSONObject.GetObject(const name: string): IJSONObject;
begin
  VerifyType(FValues[Name].ValueType, TJSONValueType.&object);
  Result := FValues[Name].ObjectValue;
end;

function TJSONObject.GetString(const name: string): string;
begin
  VerifyType(FValues[Name].ValueType, TJSONValueType.string);
  Result := FValues[Name].StringValue;
end;

function TJSONObject.GetType(const name: string): TJSONValueType;
begin
  Result := FValues[Name].ValueType;
end;

{class function TJSONObject.NewValue: PMultiValue;
begin
  //TMonitor.Enter(FCache);
  //try
    if FCache.Count = 0 then
    begin
      New(Result);
    end else
      Result := FCache.Pop;
  //finally
    //TMonitor.Exit(FCache);
  //end;
end;}

procedure TJSONObject.SetArray(const name: string; const Value: IJSONArray);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetBoolean(const name: string; const Value: Boolean);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetNumber(const name: string; const Value: Double);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetInteger(const name: string; const Value: Int64);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetItem(const name: string; const Value: Variant);
var
  jso : IJSONObject;
  jsa : IJSONArray;
  d : Double;
  s : string;
  b : Boolean;
  i : integer;
begin
  if VarIsType(Value,varUnknown) then
  begin
    if Supports(Value, IJSONObject, jso) then
    begin
      SetObject(name, jso);
    end else if Supports(Value, IJSONArray, jsa) then
    begin
      SetArray(name, jsa);
    end else
      raise Exception.Create('Unknown variant type.');
  end else
    case VarType(Value) of
      varSmallInt,
      varInteger,
      varSingle,
      varDouble,
      varCurrency,
      varShortInt,
      varByte,
      varWord,
      varLongWord,
      varInt64,
      varUInt64:
      begin
        d := VarAsType(Value,varDouble);
        SetNumber(Name, d);
      end;

      varDate:
      begin
        SetString(Name, DateToStr(Value,TFormatSettings.Create('en-us')));
      end;

      varBoolean:
      begin
        b := VarAsType(Value,varBoolean);
        SetBoolean(Name, b);
      end;

      varOleStr,
      varString,
      varUString:
      begin
        s := VarAsType(Value,varString);
        SetString(Name, s);
      end;

      varArray:
      begin
        jsa := TJSONArray.Create;
        for i := VarArrayLowBound(Value,1) to VarArrayHighBound(Value,1) do
          jsa[i] := Value[i];

        SetArray(Name, jsa);
      end;

      else
        raise Exception.Create('Unknown variant type.');
    end;

end;

procedure TJSONObject.SetObject(const name: string; const Value: IJSONObject);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetString(const name, Value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetType(const name: string; const Value: TJSONValueType);
var
  mv : PMultiValue;
begin
  mv := FValues[name];

  if mv.ValueType <> Value then
  begin
    case Value of
      TJSONValueType.string:
        SetString(Name, '');
      TJSONValueType.number:
        SetNumber(Name, 0);
      TJSONValueType.array:
        SetArray(Name, TJSONArray.Create);
      TJSONValueType.object:
        SetObject(Name, TJSONObject.Create);
      TJSONValueType.boolean:
        SetBoolean(Name, False);
      TJSONValueType.null:
        AddNull(Name);
    end;
  end;
end;

{ TMultiValue }

constructor TMultiValue.Initialize(const Value: Double);
begin
  Self.ValueType := TJSONValueType.number;
  Self.NumberValue := Value;
  Self.IntegerValue := Round(Value);
end;

constructor TMultiValue.Initialize(const Value: String);
begin
  Self.ValueType := TJSONValueType.string;
  Self.StringValue := Value;
end;

function TMultiValue.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TMultiValue.AsJSON(var result : string);
  procedure Escape(var s : String);
  var
    i : integer;
  begin
    for i := Length(s) downto 1 do
    begin
      if s[i] = '"' then
        insert('\',s,i);
    end;
  end;
var
  s : string;
begin
  case Self.ValueType of
    TJSONValueType.raw:
      Result := Result+Self.StringValue;
    TJSONValueType.string:
    begin
      s := Self.StringValue;
      Escape(s);
      Result := Result+'"'+s+'"';
    end;
    TJSONValueType.number:
      if (Self.NumberValue = Round(Self.NumberValue)) and
         (Self.NumberValue <> Self.IntegerValue) then
        Result := Result+IntToStr(Self.IntegerValue)
      else
        Result := Result+FloatToStr(Self.NumberValue);
    TJSONValueType.array:
    begin
      Self.ArrayValue.AsJSON(Result);
    end;
    TJSONValueType.object:
      Self.ObjectValue.AsJSON(Result);
    TJSONValueType.boolean:
      if Self.IntegerValue = 1 then
        Result := Result+'true'
      else
        Result := Result+'false';
    TJSONValueType.null:
      Result := Result+'null';
  end;
end;

constructor TMultiValue.Initialize(const Value: IJSONArray);
begin
  Self.ValueType := TJSONValueType.&array;
  Self.ArrayValue := Value;
end;

constructor TMultiValue.Initialize(const Value: Int64);
begin
  Self.ValueType := TJSONValueType.number;
  Self.NumberValue := Value;
  Self.IntegerValue := Value;
end;

constructor TMultiValue.Initialize(const Value: IJSONObject);
begin
  Self.ValueType := TJSONValueType.&object;
  Self.ObjectValue := Value;
end;

function TMultiValue.InitializeNull : TMultiValue;
begin
  Self.ValueType := TJSONValueType.&null;
  Self.ObjectValue := nil;
  Result := Self;
end;

constructor TMultiValue.InitializeRaw(const Value: String);
begin
  Self.ValueType := TJSONValueType.raw;
  Self.StringValue := Value;
end;

constructor TMultiValue.Initialize(const Value: Boolean);
begin
  Self.ValueType := TJSONValueType.boolean;
  if Value then
    Self.IntegerValue := 1
  else
    Self.IntegerValue := 0;
end;

end.
