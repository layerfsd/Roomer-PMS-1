unit JSonManager;
// ****************************************************************
// Serializes, deserializes, marshalls and  unmarshalls json
// wrapped object.
// Date:   28-01-2013
// Author: Bjorn Heidarr
// ****************************************************************

interface

uses System.Classes, Character, Generics.Collections, System.SysUtils,
  System.Rtti, System.TypInfo, System.Types, RoomerCloudEntities,
  System.Variants, Dialogs;

function ProcessJson(var json : String; className : String): TList<TPersistent>;

function Marshal(var jsonString : String; className : String): TList<TPersistent>;
function UnMarshal(obj: TPersistent): String;

function ToUpperAndRemoveWhiteSpace(const s: string): string;
function ToLowerAndRemoveWhiteSpace(s: string): string;
procedure RTTICall(aObj: TPersistent; MethodName: string; value: variant);
// function getProperty(obj : TPersistent; propertyName : String) : Variant;

implementation

uses RoomerJson, uDateUtils, uStringUtils, uFloatUtils;

resourcestring
  CJSON = 'json';
  CTRUE = 'true';
  CFALSE = 'false';
  C_CAMEL_JSON = 'Json';
  CSET = 'Set';
  CNULL = 'null';

function ProcessJson(var json : String; className : String): TList<TPersistent>;
begin
  if (LowerCase(json)=CNULL) OR (LowerCase(json)='') then
    result := TList<TPersistent>.create
  else
    result := Marshal(json, className);
end;

function Marshal(var jsonString : String; className : String): TList<TPersistent>;
var
  CRef: TPersistentClass;
  AControl: TPersistent;
  jso: IJSONObject;
  entities: IJSONObject;
  i, i1: integer;
  objName: String;
  CentralClassName : String;
  value, method, entity: String;
  varValue : Variant;
begin
  result := TList<TPersistent>.create;
  jso := json(jsonString);
  objName := jso.Names[0];
  CRef := GetClass('T' + objName);
  if CRef = nil then
  begin
    CentralClassName := copy(ClassName, 2, 255);
    jsonString := format('{"%s":%s}', [CentralClassName,jsonString]);
    jso := json(jsonString);
    CRef := GetClass(className);
    objName := jso.Names[0];
  end;
  if CRef <> nil then
  begin
    if jso.Types[objName] = TJSONValueType.&array then
    begin
      for i1 := 0 to jso.Arrays[objName].count - 1 do
      begin
        entities := jso.Arrays[objName].Objects[i1];
        AControl := TPersistent(TPersistentClass(CRef).create);
        RTTICall(AControl, CSET + C_CAMEL_JSON, entities.AsJSON);
        for i := 0 to entities.count - 1 do
        begin
          entity := entities.Names[i];
          varValue := entities.Items[entity];
          if varValue <> Null then
          begin
            value := String(varValue);
            try
              method := CSET + ToUpperAndRemoveWhiteSpace(entity);
              RTTICall(AControl, method, value);
            except end;
          end;
        end;
        result.Add(AControl);
      end;
    end
    else
    begin
      entities := jso.Objects[objName];
      AControl := TPersistent(TPersistentClass(CRef).create);
      RTTICall(AControl, CSET + C_CAMEL_JSON, entities.AsJSON);
      for i := 0 to entities.count - 1 do
      begin
        entity := entities.Names[i];
        value := String(entities.Items[entity]);
        method := CSET + ToUpperAndRemoveWhiteSpace(entities.Names[i]);
        RTTICall(AControl, method, value);
      end;
      result.Add(AControl);
    end;
  end;
end;

function UnMarshal(obj: TPersistent): String;
var
  CRef: TPersistentClass;
  jso: IJSONObject;
  entities: IJSONObject;
  i: integer;
  objName: String;
  varValue: variant;
  jsonString: String;

  c: TRttiContext;
  t: TRttiInstanceType;
  value: TValue;
  Prop: TRttiProperty;
  CurrentClassProps: TArray<TRttiProperty>;
  tempFloat, properName, propertyName: String;

  ADate : TDateTime;
  valueFloat : Double;
begin
  c := TRttiContext.create;
  t := (c.GetType(obj.ClassType) as TRttiInstanceType);
  CurrentClassProps := t.GetProperties;
  jsonString := t.GetProperty(CJSON).GetValue(obj).AsString;
  jso := json('');
  objName := obj.ClassName;
  CRef := GetClass(objName);
  if CRef <> nil then
  begin
    entities := jso;
    try
      for i := LOW(CurrentClassProps) to HIGH(CurrentClassProps) do
      begin
        Prop := CurrentClassProps[i];
        propertyName := Prop.Name;
        if LowerCase(propertyName) = CJSON then
          Continue;
        value := t.GetProperty(propertyName).GetValue(obj);

        if Prop.PropertyType.TypeKind = tkFloat then
        begin
          valueFloat := value.AsCurrency;
          tempFloat := Trim(StringReplace(FloatToStr(valueFloat),
            SystemDecimalSeparator, '.', [rfReplaceAll]));
          varValue := tempFloat;
        end else
        if Prop.PropertyType.TypeKind = tkRecord then
        begin
          if value.IsType<TTimeStamp> then
          begin
            ADate := value.AsType<TTimeStamp>.Date;
            varValue := uDateUtils.dateToJsonString(ADate);
          end;
        end else
          varValue := value.AsVariant;

        properName := propertyName;
        entities[ToLowerAndRemoveWhiteSpace(properName)] := varValue;
      end;
      varValue := entities.AsJSON;
      t.getProperty(CJSON).SetValue(obj, TValue.FromVariant(varValue));
    except
      on E: Exception do
        ShowMessage(E.ClassName + ': ' + E.Message);
    end;
  end;
end;

// function getProperty(obj : TPersistent; propertyName : String) : Variant;
//
// var
// c: TRttiContext;
// t: TRttiInstanceType;
// value : TValue;
// Prop: TRttiProperty;
// CurrentClassProps : TArray<TRttiProperty>;
// begin
// try
// c := TRttiContext.create;
// t := (c.GetType(obj.ClassType) as TRttiInstanceType);
// value := t.GetProperty(propertyName).GetValue(obj);
// result := value.AsVariant;
// except
// on E: Exception do
// Writeln(E.ClassName, ': ', E.Message);
// end;
// end;


const
  UnixStartDate = 25569.0;
function UnixTimeToDateTime(const UnixDate: Cardinal): TDateTime;
begin
  Result := (UnixDate / 1000) / 86400 + UnixStartDate;
end;

procedure RTTICall(aObj: TPersistent; MethodName: string; value: variant);
var
  c: TRttiContext;
  t: TRttiInstanceType;
  ts : TTimeStamp;
  parameters: TArray<TRttiParameter>;
  aUnixTime : Cardinal;
  code : Integer;
  method : TRttiMethod;
  r: TValue;
begin
  try
    c := TRttiContext.create;
    t := (c.GetType(aObj.ClassType) as TRttiInstanceType);
    r := TValue.Empty;

    method := t.GetMethod(MethodName);
    if method = nil then exit;

    parameters := method.GetParameters;
    if parameters[0].ParamType.TypeKind = tkFloat then
    begin
      value := StringReplace(value, '.', SystemDecimalSeparator,
        [rfReplaceAll]);
      value := StringReplace(value, ',', SystemDecimalSeparator,
        [rfReplaceAll]);
      method.Invoke(aObj, [LocalizedFloatValue(value)])
    end else
    if parameters[0].ParamType.TypeKind = tkRecord then
    begin
        try
          ts := DateTimeToTimeStamp(uDateUtils.JsonStringToDate(value));
        except
          val(value, aUnixTime, code);
          ts := DateTimeToTimeStamp(UnixTimeToDateTime(aUnixTime));
        end;
        method.Invoke(aObj, [r.From<TTimeStamp>(ts)]);
    end else if parameters[0].ParamType.TypeKind = tkInteger then
    begin
      if (LowerCase(value) = CTRUE) then
        t.GetMethod(MethodName).Invoke(aObj, [1])
      else if (LowerCase(value) = CFALSE) then
        method.Invoke(aObj, [0])
      else
        method.Invoke(aObj, [StrToInt(value)])
    end
    else
      method.Invoke(aObj, [String(value)]);
  except
    on E: Exception do
      ShowMessage(E.ClassName + ': ' + E.Message);
  end;
end;

function ToUpperAndRemoveWhiteSpace(const s: string): string;
var
  i, j: integer;
begin
  SetLength(result, Length(s));
  j := 0;
  for i := 1 to Length(s) do
  begin
    if not TCharacter.IsWhiteSpace(s[i]) then
    begin
      inc(j);
      if j = 1 then
        result[j] := ToUpper(s[i])
      else
        result[j] := s[i];
    end;
  end;
  SetLength(result, j);
end;

function ToLowerAndRemoveWhiteSpace(s: string): string;
var
  i, j: integer;
begin
  SetLength(result, Length(s));
  for i := Length(s) downto 2 do
  begin
    if TCharacter.IsUpper(s[i]) AND TCharacter.IsUpper(s[i-1]) then
    begin
        s[i] := ToLower(s[i])
    end;
  end;
  j := 0;
  for i := 1 to Length(s) do
  begin
    if not TCharacter.IsWhiteSpace(s[i]) then
    begin
      inc(j);
      if j = 1 then
        result[j] := ToLower(s[i])
      else
        result[j] := s[i];
    end;
  end;
  SetLength(result, j);
end;

end.
