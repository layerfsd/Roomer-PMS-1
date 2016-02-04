{***************************************************************************}
{ TTntRegistry component                                                    }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2007 - 2008                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ Portions created by Stanley Xu are                                        }
{ Copyright (c) 1999-2007 Stanley Xu                                        }
{ http://gosurfbrowser.com/?go=supportFeedback&ln=en                        }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit TntRegistry;

{$R-,T-,H+,X+}
{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  Registry;

type
  TTntRegistry = TRegistry;

implementation

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}

interface


uses
  Registry, Windows, TntClasses;

  {$HPPEMIT '#define HKEY unsigned'}

{TNT-WARN TRegistry}
type
  TTntRegistry = class(TObject{TNT-ALLOW TObject})
  private
    FAnsiRegistry: TRegistry; // For compatibility with Windows 95/98/Me
    FCurrentKey: HKEY;
    FRootKey: HKEY;
    FLazyWrite: Boolean;
    FCurrentPath: WideString;
    FCloseRootKey: Boolean;
    FAccess: LongWord;
    procedure SetRootKey(Value: HKEY);
  protected
    procedure ChangeKey(Value: HKey; const Path: WideString);
    function GetBaseKey(Relative: Boolean): HKey;
    function GetData(const Name: WideString; Buffer: Pointer;
      BufSize: Integer; var RegData: TRegDataType): Integer;
    function GetKey(const Key: WideString): HKEY;
    procedure PutData(const Name: WideString; Buffer: Pointer; BufSize: Integer; RegData: TRegDataType);
    procedure SetCurrentKey(Value: HKEY);
  public
    constructor Create; overload;
    constructor Create(AAccess: LongWord); overload;
    destructor Destroy; override;
    procedure CloseKey;
    function CreateKey(const Key: WideString): Boolean;
    function DeleteKey(const Key: WideString): Boolean;
    function DeleteValue(const Name: WideString): Boolean;
    function GetDataInfo(const ValueName: WideString; var Value: TRegDataInfo): Boolean;
    function GetDataSize(const ValueName: WideString): Integer;
    function GetDataType(const ValueName: WideString): TRegDataType;
    function GetKeyInfo(var Value: TRegKeyInfo): Boolean;
    procedure GetKeyNames(Strings: TTntStrings);
    procedure GetValueNames(Strings: TTntStrings);
    function HasSubKeys: Boolean;
    function KeyExists(const Key: WideString): Boolean;
    function LoadKey(const Key, FileName: WideString): Boolean;
    procedure MoveKey(const OldName, NewName: WideString; Delete: Boolean);
    function OpenKey(const Key: WideString; CanCreate: Boolean): Boolean;
    function OpenKeyReadOnly(const Key: WideString): Boolean;
    function ReadCurrency(const Name: WideString): Currency;
    function ReadBinaryData(const Name: WideString; var Buffer; BufSize: Integer): Integer;
    function ReadBool(const Name: WideString): Boolean;
    function ReadDate(const Name: WideString): TDateTime;
    function ReadDateTime(const Name: WideString): TDateTime;
    function ReadFloat(const Name: WideString): Double;
    function ReadInteger(const Name: WideString): Integer;
    function ReadString(const Name: WideString): WideString;
    function ReadTime(const Name: WideString): TDateTime;
    function RegistryConnect(const UNCName: WideString): Boolean;
    procedure RenameValue(const OldName, NewName: WideString);
    function ReplaceKey(const Key, FileName, BackUpFileName: WideString): Boolean;
    function RestoreKey(const Key, FileName: WideString): Boolean;
    function SaveKey(const Key, FileName: WideString): Boolean;
    function UnLoadKey(const Key: WideString): Boolean;
    function ValueExists(const Name: WideString): Boolean;
    procedure WriteCurrency(const Name: WideString; Value: Currency);
    procedure WriteBinaryData(const Name: WideString; var Buffer; BufSize: Integer);
    procedure WriteBool(const Name: WideString; Value: Boolean);
    procedure WriteDate(const Name: WideString; Value: TDateTime);
    procedure WriteDateTime(const Name: WideString; Value: TDateTime);
    procedure WriteFloat(const Name: WideString; Value: Double);
    procedure WriteInteger(const Name: WideString; Value: Integer);
    procedure WriteString(const Name, Value: WideString);
    procedure WriteExpandString(const Name, Value: WideString);
    procedure WriteTime(const Name: WideString; Value: TDateTime);
  private
    function GetCurrentKey: HKEY;
    function GetCurrentPath: WideString;
    function GetLazyWrite: Boolean;
    procedure SetLazyWrite(Value: Boolean);
    function GetRootKey: HKEY;
    function GetAccess: LongWord;
    procedure SetAccess(Value: LongWord);
  public
    property CurrentKey: HKEY read GetCurrentKey;
    property CurrentPath: WideString read GetCurrentPath;
    property LazyWrite: Boolean read GetLazyWrite write SetLazyWrite;
    property RootKey: HKEY read GetRootKey write SetRootKey;
    property Access: LongWord read GetAccess write SetAccess;
  end;



implementation

uses
  RTLConsts, SysUtils, TntSysUtils,
  {$IFDEF COMPILER_9_UP}
  WideStrUtils, TntWideStrUtils
  {$ELSE}
  TntWideStrUtils
  {$ENDIF}
  ;


procedure ReadError(const Name: string);
begin
  raise ERegistryException.CreateResFmt(@SInvalidRegType, [Name]);
end;

function IsRelative(const Value: WideString): Boolean;
begin
  Result := not ((Value <> '') and (Value[1] = '\'));
end;

function RegDataToDataType(Value: TRegDataType): Integer;
begin
  case Value of
    rdString: Result := REG_SZ;
    rdExpandString: Result := REG_EXPAND_SZ;
    rdInteger: Result := REG_DWORD;
    rdBinary: Result := REG_BINARY;
  else
    Result := REG_NONE;
  end;
end;

function DataTypeToRegData(Value: Integer): TRegDataType;
begin
  if Value = REG_SZ then Result := rdString
  else if Value = REG_EXPAND_SZ then Result := rdExpandString
  else if Value = REG_DWORD then Result := rdInteger
  else if Value = REG_BINARY then Result := rdBinary
  else Result := rdUnknown;
end;


{ TTntRegistry }

{$IFNDEF COMPILER_9_UP} // fix declaration for RegEnumValueW (lpValueName is a PWideChar)
function RegEnumValueW(hKey: HKEY; dwIndex: DWORD; lpValueName: PWideChar;
  var lpcbValueName: DWORD; lpReserved: Pointer; lpType: PDWORD;
  lpData: PByte; lpcbData: PDWORD): Longint; stdcall; external advapi32 name 'RegEnumValueW';
{$ENDIF}

type
  TRegistryAccess = class(TRegistry);

constructor TTntRegistry.Create;
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry := TRegistry.Create
  else begin
    RootKey := HKEY_CURRENT_USER;
    FAccess := KEY_ALL_ACCESS;
    LazyWrite := True;
  end;
end;

constructor TTntRegistry.Create(AAccess: LongWord);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry := TRegistry.Create(AAccess)
  else begin
    Create;
    FAccess := AAccess;
  end;
end;

destructor TTntRegistry.Destroy;
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.Free
  else begin
    CloseKey;
  end;
  inherited;
end;

procedure TTntRegistry.CloseKey;
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.CloseKey
  else begin
    if CurrentKey <> 0 then
    begin
      if not LazyWrite then
        RegFlushKey(CurrentKey);
      RegCloseKey(CurrentKey);
      FCurrentKey := 0;
      FCurrentPath := '';
    end;
  end;
end;

procedure TTntRegistry.SetRootKey(Value: HKEY);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.RootKey := Value {TNT-ALLOW_ACCESS SetRootKey()}
  else begin
    if RootKey <> Value then
    begin
      if FCloseRootKey then
      begin
        RegCloseKey(RootKey);
        FCloseRootKey := False;
      end;
      FRootKey := Value;
      CloseKey;
    end;
  end;
end;

procedure TTntRegistry.ChangeKey(Value: HKey; const Path: WideString);
begin
  if (not Win32PlatformIsUnicode) then
    TRegistryAccess(FAnsiRegistry).ChangeKey(Value, Path)
  else begin
    CloseKey;
    FCurrentKey := Value;
    FCurrentPath := Path;
  end;
end;

function TTntRegistry.GetBaseKey(Relative: Boolean): HKey;
begin
  if (not Win32PlatformIsUnicode) then
    Result := TRegistryAccess(FAnsiRegistry).GetBaseKey(Relative)
  else begin
    if (CurrentKey = 0) or not Relative then
      Result := RootKey else
      Result := CurrentKey;
  end;
end;

procedure TTntRegistry.SetCurrentKey(Value: HKEY);
begin
  if (not Win32PlatformIsUnicode) then
    TRegistryAccess(FAnsiRegistry).SetCurrentKey(Value)
  else begin
    FCurrentKey := Value;
  end;
end;

function TTntRegistry.CreateKey(const Key: WideString): Boolean;
var
  TempKey: HKey;
  S: WideString;
  Disposition: Integer;
  Relative: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.CreateKey(Key)
  else begin
    TempKey := 0;
    S := Key;
    Relative := IsRelative(S);
    if not Relative then Delete(S, 1, 1);
    Result := RegCreateKeyExW(GetBaseKey(Relative), PWideChar(S), 0, nil,
      REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, nil, TempKey, @Disposition) = ERROR_SUCCESS;
    if Result then RegCloseKey(TempKey)
    else raise ERegistryException.CreateResFmt(@SRegCreateFailed, [Key]);
  end;
end;

function TTntRegistry.OpenKey(const Key: WideString; CanCreate: Boolean): Boolean;
var
  TempKey: HKey;
  S: WideString;
  Disposition: Integer;
  Relative: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.OpenKey(Key, CanCreate)
  else begin
    S := Key;
    Relative := IsRelative(S);

    if not Relative then Delete(S, 1, 1);
    TempKey := 0;
    if not CanCreate or (S = '') then
    begin
      Result := RegOpenKeyExW(GetBaseKey(Relative), PWideChar(S), 0,
        FAccess, TempKey) = ERROR_SUCCESS;
    end else
      Result := RegCreateKeyExW(GetBaseKey(Relative), PWideChar(S), 0, nil,
        REG_OPTION_NON_VOLATILE, FAccess, nil, TempKey, @Disposition) = ERROR_SUCCESS;
    if Result then
    begin
      if (CurrentKey <> 0) and Relative then S := CurrentPath + '\' + S;
      ChangeKey(TempKey, S);
    end;
  end;
end;

function TTntRegistry.OpenKeyReadOnly(const Key: WideString): Boolean;
var
  TempKey: HKey;
  S: WideString;
  Relative: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.OpenKeyReadOnly(Key)
  else begin
    S := Key;
    Relative := IsRelative(S);

    if not Relative then Delete(S, 1, 1);
    TempKey := 0;
    Result := RegOpenKeyExW(GetBaseKey(Relative), PWideChar(S), 0,
      KEY_READ, TempKey) = ERROR_SUCCESS;
    if Result then
    begin
      FAccess := KEY_READ;
      if (CurrentKey <> 0) and Relative then S := CurrentPath + '\' + S;
      ChangeKey(TempKey, S);
    end
    else
    begin
      Result := RegOpenKeyExW(GetBaseKey(Relative), PWideChar(S), 0,
        STANDARD_RIGHTS_READ or KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS,
        TempKey) = ERROR_SUCCESS;
      if Result then
      begin
        FAccess := STANDARD_RIGHTS_READ or KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS;
        if (CurrentKey <> 0) and Relative then S := CurrentPath + '\' + S;
        ChangeKey(TempKey, S);
      end
      else
      begin
        Result := RegOpenKeyExW(GetBaseKey(Relative), PWideChar(S), 0,
          KEY_QUERY_VALUE, TempKey) = ERROR_SUCCESS;
        if Result then
        begin
          FAccess := KEY_QUERY_VALUE;
          if (CurrentKey <> 0) and Relative then S := CurrentPath + '\' + S;
          ChangeKey(TempKey, S);
        end
      end;
    end;
  end;
end;

function TTntRegistry.DeleteKey(const Key: WideString): Boolean;
var
  Len: DWORD;
  I: Integer;
  Relative: Boolean;
  S, KeyName: WideString;
  OldKey, DeleteKey: HKEY;
  Info: TRegKeyInfo;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.DeleteKey(Key)
  else begin
    S := Key;
    Relative := IsRelative(S);
    if not Relative then Delete(S, 1, 1);
    OldKey := CurrentKey;
    DeleteKey := GetKey(Key);
    if DeleteKey <> 0 then
    try
      SetCurrentKey(DeleteKey);
      if GetKeyInfo(Info) then
      begin
        SetString(KeyName, nil, (Info.MaxSubKeyLen + 1) * 2);
        for I := Info.NumSubKeys - 1 downto 0 do
        begin
          Len := (Info.MaxSubKeyLen + 1) * 2;
          if RegEnumKeyExW(DeleteKey, DWORD(I), PWideChar(KeyName), Len, nil, nil, nil,
            nil) = ERROR_SUCCESS then
            Self.DeleteKey(WStrPas(PWideChar(KeyName)){truncates wild content after #0});
        end;
      end;
    finally
      SetCurrentKey(OldKey);
      RegCloseKey(DeleteKey);
    end;
    Result := RegDeleteKeyW(GetBaseKey(Relative), PWideChar(S)) = ERROR_SUCCESS;
  end;
end;

function TTntRegistry.DeleteValue(const Name: WideString): Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.DeleteValue(Name)
  else begin
    Result := RegDeleteValueW(CurrentKey, PWideChar(Name)) = ERROR_SUCCESS;
  end;
end;

function TTntRegistry.GetKeyInfo(var Value: TRegKeyInfo): Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.GetKeyInfo(Value)
  else begin
    FillChar(Value, SizeOf(TRegKeyInfo), 0);
    Result := RegQueryInfoKey(CurrentKey, nil, nil, nil, @Value.NumSubKeys,
      @Value.MaxSubKeyLen, nil, @Value.NumValues, @Value.MaxValueLen,
      @Value.MaxDataLen, nil, @Value.FileTime) = ERROR_SUCCESS;
    if SysLocale.FarEast and (Win32Platform = VER_PLATFORM_WIN32_NT) then
      with Value do
      begin
        Inc(MaxSubKeyLen, MaxSubKeyLen);
        Inc(MaxValueLen, MaxValueLen);
      end;
  end;
end;

procedure TTntRegistry.GetKeyNames(Strings: TTntStrings);
var
  Len: DWORD;
  I: Integer;
  Info: TRegKeyInfo;
  S: WideString;
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.GetKeyNames(Strings.AnsiStrings)
  else begin
    Strings.Clear;
    if GetKeyInfo(Info) then
    begin
      SetString(S, nil, (Info.MaxSubKeyLen + 1) * 2);
      for I := 0 to Info.NumSubKeys - 1 do
      begin
        Len := (Info.MaxSubKeyLen + 1) * 2;
        RegEnumKeyExW(CurrentKey, I, PWideChar(S), Len, nil, nil, nil, nil);
        Strings.Add(WStrPas(PWideChar(S)){truncates wild content after #0});
      end;
    end;
  end;
end;

procedure TTntRegistry.GetValueNames(Strings: TTntStrings);
var
  Len: DWORD;
  I: Integer;
  Info: TRegKeyInfo;
  S: WideString;
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.GetValueNames(Strings.AnsiStrings)
  else begin
    Strings.Clear;
    if GetKeyInfo(Info) then
    begin
      SetString(S, nil, (Info.MaxValueLen + 1) * 2);
      for I := 0 to Info.NumValues - 1 do
      begin
        Len := (Info.MaxValueLen + 1) * 2;
        RegEnumValueW(CurrentKey, I, PWideChar(S), Len, nil, nil, nil, nil);
        Strings.Add(WStrPas(PWideChar(S)){truncates wild content after #0});
      end;
    end;
  end;
end;

function TTntRegistry.GetDataInfo(const ValueName: WideString; var Value: TRegDataInfo): Boolean;
var
  DataType: Integer;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.GetDataInfo(ValueName, Value)
  else begin
    FillChar(Value, SizeOf(TRegDataInfo), 0);
    Result := RegQueryValueExW(CurrentKey, PWideChar(ValueName), nil, @DataType, nil,
      @Value.DataSize) = ERROR_SUCCESS;
    Value.RegData := DataTypeToRegData(DataType);
  end;
end;

function TTntRegistry.GetDataSize(const ValueName: WideString): Integer;
var
  Info: TRegDataInfo;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.GetDataSize(ValueName)
  else begin
    if GetDataInfo(ValueName, Info) then
      Result := Info.DataSize else
      Result := -1;
  end;
end;

function TTntRegistry.GetDataType(const ValueName: WideString): TRegDataType;
var
  Info: TRegDataInfo;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.GetDataType(ValueName)
  else begin
    if GetDataInfo(ValueName, Info) then
      Result := Info.RegData else
      Result := rdUnknown;
  end;
end;

procedure TTntRegistry.WriteString(const Name, Value: WideString);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteString(Name, Value)
  else begin
    PutData(Name, PWideChar(Value), (Length(Value)+1) * SizeOf(WideChar), rdString);
  end;
end;

procedure TTntRegistry.WriteExpandString(const Name, Value: WideString);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteExpandString(Name, Value)
  else begin
    PutData(Name, PWideChar(Value), (Length(Value)+1) * SizeOf(WideChar), rdExpandString);
  end;
end;

function TTntRegistry.ReadString(const Name: WideString): WideString;
var
  Len: Integer;
  RegData: TRegDataType;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadString(Name)
  else begin
    Len := GetDataSize(Name);
    if Len > 0 then
    begin
      if Len = 1 then
        Len := SizeOf(WideChar); // sometimes this occurs for single character values!
      SetLength(Result, Len div SizeOf(WideChar));
      GetData(Name, PWideChar(Result), Len, RegData);
      if (RegData = rdString) or (RegData = rdExpandString) then
        SetLength(Result, WStrLen(PWideChar(Result)))
      else ReadError(Name);
    end
    else Result := '';
  end;
end;

procedure TTntRegistry.WriteInteger(const Name: WideString; Value: Integer);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteInteger(Name, Value)
  else begin
    PutData(Name, @Value, SizeOf(Integer), rdInteger);
  end;
end;

function TTntRegistry.ReadInteger(const Name: WideString): Integer;
var
  RegData: TRegDataType;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadInteger(Name)
  else begin
    GetData(Name, @Result, SizeOf(Integer), RegData);
    if RegData <> rdInteger then ReadError(Name);
  end;
end;

procedure TTntRegistry.WriteBool(const Name: WideString; Value: Boolean);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteBool(Name, Value)
  else begin
    WriteInteger(Name, Ord(Value));
  end;
end;

function TTntRegistry.ReadBool(const Name: WideString): Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadBool(Name)
  else begin
    Result := ReadInteger(Name) <> 0;
  end;
end;

procedure TTntRegistry.WriteFloat(const Name: WideString; Value: Double);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteFloat(Name, Value)
  else begin
    PutData(Name, @Value, SizeOf(Double), rdBinary);
  end;
end;

function TTntRegistry.ReadFloat(const Name: WideString): Double;
var
  Len: Integer;
  RegData: TRegDataType;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadFloat(Name)
  else begin
    Len := GetData(Name, @Result, SizeOf(Double), RegData);
    if (RegData <> rdBinary) or (Len <> SizeOf(Double)) then
      ReadError(Name);
  end;
end;

procedure TTntRegistry.WriteCurrency(const Name: WideString; Value: Currency);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteCurrency(Name, Value)
  else begin
    PutData(Name, @Value, SizeOf(Currency), rdBinary);
  end;
end;

function TTntRegistry.ReadCurrency(const Name: WideString): Currency;
var
  Len: Integer;
  RegData: TRegDataType;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadCurrency(Name)
  else begin
    Len := GetData(Name, @Result, SizeOf(Currency), RegData);
    if (RegData <> rdBinary) or (Len <> SizeOf(Currency)) then
      ReadError(Name);
  end;
end;

procedure TTntRegistry.WriteDateTime(const Name: WideString; Value: TDateTime);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteDateTime(Name, Value)
  else begin
    PutData(Name, @Value, SizeOf(TDateTime), rdBinary);
  end;
end;

function TTntRegistry.ReadDateTime(const Name: WideString): TDateTime;
var
  Len: Integer;
  RegData: TRegDataType;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadDateTime(Name)
  else begin
    Len := GetData(Name, @Result, SizeOf(TDateTime), RegData);
    if (RegData <> rdBinary) or (Len <> SizeOf(TDateTime)) then
      ReadError(Name);
  end;
end;

procedure TTntRegistry.WriteDate(const Name: WideString; Value: TDateTime);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteDate(Name, Value)
  else begin
    WriteDateTime(Name, Value);
  end;
end;

function TTntRegistry.ReadDate(const Name: WideString): TDateTime;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadDate(Name)
  else begin
    Result := ReadDateTime(Name);
  end;
end;

procedure TTntRegistry.WriteTime(const Name: WideString; Value: TDateTime);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteTime(Name, Value)
  else begin
    WriteDateTime(Name, Value);
  end;
end;

function TTntRegistry.ReadTime(const Name: WideString): TDateTime;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadTime(Name)
  else begin
    Result := ReadDateTime(Name);
  end;
end;

procedure TTntRegistry.WriteBinaryData(const Name: WideString; var Buffer; BufSize: Integer);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.WriteBinaryData(Name, Buffer, BufSize)
  else begin
    PutData(Name, @Buffer, BufSize, rdBinary);
  end;
end;

function TTntRegistry.ReadBinaryData(const Name: WideString; var Buffer; BufSize: Integer): Integer;
var
  RegData: TRegDataType;
  Info: TRegDataInfo;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReadBinaryData(Name, Buffer, BufSize)
  else begin
    if GetDataInfo(Name, Info) then
    begin
      Result := Info.DataSize;
      RegData := Info.RegData;
      if ((RegData = rdBinary) or (RegData = rdUnknown)) and (Result <= BufSize) then
        GetData(Name, @Buffer, Result, RegData)
      else ReadError(Name);
    end else
      Result := 0;
  end;
end;

procedure TTntRegistry.PutData(const Name: WideString; Buffer: Pointer;
  BufSize: Integer; RegData: TRegDataType);
var
  DataType: Integer;
begin
  if (not Win32PlatformIsUnicode) then
    TRegistryAccess(FAnsiRegistry).PutData(Name, Buffer, BufSize, RegData)
  else begin
    DataType := RegDataToDataType(RegData);
    if RegSetValueExW(CurrentKey, PWideChar(Name), 0, DataType, Buffer,
      BufSize) <> ERROR_SUCCESS then
      raise ERegistryException.CreateResFmt(@SRegSetDataFailed, [Name]);
  end;
end;

function TTntRegistry.GetData(const Name: WideString; Buffer: Pointer;
  BufSize: Integer; var RegData: TRegDataType): Integer;
var
  DataType: Integer;
begin
  if (not Win32PlatformIsUnicode) then
    Result := TRegistryAccess(FAnsiRegistry).GetData(Name, Buffer, BufSize, RegData)
  else begin
    DataType := REG_NONE;
    if RegQueryValueExW(CurrentKey, PWideChar(Name), nil, @DataType, PByte(Buffer),
      @BufSize) <> ERROR_SUCCESS then
      raise ERegistryException.CreateResFmt(@SRegGetDataFailed, [Name]);
    Result := BufSize;
    RegData := DataTypeToRegData(DataType);
  end;
end;

function TTntRegistry.HasSubKeys: Boolean;
var
  Info: TRegKeyInfo;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.HasSubKeys
  else begin
    Result := GetKeyInfo(Info) and (Info.NumSubKeys > 0);
  end;
end;

function TTntRegistry.ValueExists(const Name: WideString): Boolean;
var
  Info: TRegDataInfo;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ValueExists(Name)
  else begin
    Result := GetDataInfo(Name, Info);
  end;
end;

function TTntRegistry.GetKey(const Key: WideString): HKEY;
var
  S: WideString;
  Relative: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := TRegistryAccess(FAnsiRegistry).GetKey(Key)
  else begin
    S := Key;
    Relative := IsRelative(S);
    if not Relative then Delete(S, 1, 1);
    Result := 0;
    RegOpenKeyExW(GetBaseKey(Relative), PWideChar(S), 0, FAccess, Result);
  end;
end;

function TTntRegistry.RegistryConnect(const UNCName: WideString): Boolean;
var
  TempKey: HKEY;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.RegistryConnect(UNCName)
  else begin
    Result := RegConnectRegistryW(PWideChar(UNCname), RootKey, TempKey) = ERROR_SUCCESS;
    if Result then
    begin
      RootKey := TempKey;
      FCloseRootKey := True;
    end;
  end;
end;

function TTntRegistry.LoadKey(const Key, FileName: WideString): Boolean;
var
  S: WideString;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.LoadKey(Key, FileName)
  else begin
    S := Key;
    if not IsRelative(S) then Delete(S, 1, 1);
    Result := RegLoadKeyW(RootKey, PWideChar(S), PWideChar(FileName)) = ERROR_SUCCESS;
  end;
end;

function TTntRegistry.UnLoadKey(const Key: WideString): Boolean;
var
  S: WideString;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.UnLoadKey(Key)
  else begin
    S := Key;
    if not IsRelative(S) then Delete(S, 1, 1);
    Result := RegUnLoadKeyW(RootKey, PWideChar(S)) = ERROR_SUCCESS;
  end;
end;

function TTntRegistry.RestoreKey(const Key, FileName: WideString): Boolean;
var
  RestoreKey: HKEY;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.RestoreKey(Key, FileName)
  else begin
    Result := False;
    RestoreKey := GetKey(Key);
    if RestoreKey <> 0 then
    try
      Result := RegRestoreKeyW(RestoreKey, PWideChar(FileName), 0) = ERROR_SUCCESS;
    finally
      RegCloseKey(RestoreKey);
    end;
  end;
end;

function TTntRegistry.ReplaceKey(const Key, FileName, BackUpFileName: WideString): Boolean;
var
  S: WideString;
  Relative: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.ReplaceKey(Key, FileName, BackUpFileName)
  else begin
    S := Key;
    Relative := IsRelative(S);
    if not Relative then Delete(S, 1, 1);
    Result := RegReplaceKeyW(GetBaseKey(Relative), PWideChar(S),
      PWideChar(FileName), PWideChar(BackUpFileName)) = ERROR_SUCCESS;
  end;
end;

function TTntRegistry.SaveKey(const Key, FileName: WideString): Boolean;
var
  SaveKey: HKEY;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.SaveKey(Key, FileName)
  else begin
    Result := False;
    SaveKey := GetKey(Key);
    if SaveKey <> 0 then
    try
      Result := RegSaveKeyW(SaveKey, PWideChar(FileName), nil) = ERROR_SUCCESS;
    finally
      RegCloseKey(SaveKey);
    end;
  end;
end;

function TTntRegistry.KeyExists(const Key: WideString): Boolean;
var
  TempKey: HKEY;
  OldAccess: Longword;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.KeyExists(Key)
  else begin
    OldAccess := FAccess;
    try
      FAccess := STANDARD_RIGHTS_READ or KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS;
      TempKey := GetKey(Key);
      if TempKey <> 0 then RegCloseKey(TempKey);
      Result := TempKey <> 0;
    finally
      FAccess := OldAccess;
    end;
  end;
end;

procedure TTntRegistry.RenameValue(const OldName, NewName: WideString);
var
  Len: Integer;
  RegData: TRegDataType;
  Buffer: PChar;
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.RenameValue(OldName, NewName)
  else begin
    if ValueExists(OldName) and not ValueExists(NewName) then
    begin
      Len := GetDataSize(OldName);
      if Len > 0 then
      begin
        Buffer := AllocMem(Len);
        try
          Len := GetData(OldName, Buffer, Len, RegData);
          DeleteValue(OldName);
          PutData(NewName, Buffer, Len, RegData);
        finally
          FreeMem(Buffer);
        end;
      end;
    end;
  end;
end;

procedure TTntRegistry.MoveKey(const OldName, NewName: WideString; Delete: Boolean);
var
  SrcKey, DestKey: HKEY;

  procedure MoveValue(SrcKey, DestKey: HKEY; const Name: WideString);
  var
    Len: Integer;
    OldKey, PrevKey: HKEY;
    Buffer: PChar;
    RegData: TRegDataType;
  begin
    OldKey := CurrentKey;
    SetCurrentKey(SrcKey);
    try
      Len := GetDataSize(Name);
      if Len > 0 then
      begin
        Buffer := AllocMem(Len);
        try
          Len := GetData(Name, Buffer, Len, RegData);
          PrevKey := CurrentKey;
          SetCurrentKey(DestKey);
          try
            PutData(Name, Buffer, Len, RegData);
          finally
            SetCurrentKey(PrevKey);
          end;
        finally
          FreeMem(Buffer);
        end;
      end;
    finally
      SetCurrentKey(OldKey);
    end;
  end;

  procedure CopyValues(SrcKey, DestKey: HKEY);
  var
    Len: DWORD;
    I: Integer;
    KeyInfo: TRegKeyInfo;
    S: WideString;
    OldKey: HKEY;
  begin
    OldKey := CurrentKey;
    SetCurrentKey(SrcKey);
    try
      if GetKeyInfo(KeyInfo) then
      begin
        MoveValue(SrcKey, DestKey, '');
        SetString(S, nil, (KeyInfo.MaxValueLen + 1) * 2);
        for I := 0 to KeyInfo.NumValues - 1 do
        begin
          Len := (KeyInfo.MaxValueLen + 1) * 2;
          if RegEnumValueW(SrcKey, I, PWideChar(S), Len, nil, nil, nil, nil) = ERROR_SUCCESS then
            MoveValue(SrcKey, DestKey, WStrPas(PWideChar(S)){truncates wild content after #0});
        end;
      end;
    finally
      SetCurrentKey(OldKey);
    end;
  end;

  procedure CopyKeys(SrcKey, DestKey: HKEY);
  var
    Len: DWORD;
    I: Integer;
    Info: TRegKeyInfo;
    S: WideString;
    OldKey, PrevKey, NewSrc, NewDest: HKEY;
  begin
    OldKey := CurrentKey;
    SetCurrentKey(SrcKey);
    try
      if GetKeyInfo(Info) then
      begin
        SetString(S, nil, (Info.MaxSubKeyLen + 1) * 2);
        for I := 0 to Info.NumSubKeys - 1 do
        begin
          Len := (Info.MaxSubKeyLen + 1) * 2;
          if RegEnumKeyExW(SrcKey, I, PWideChar(S), Len, nil, nil, nil, nil) = ERROR_SUCCESS then
          begin
            NewSrc := GetKey(WStrPas(PWideChar(S)){truncates wild content after #0});
            if NewSrc <> 0 then
            try
              PrevKey := CurrentKey;
              SetCurrentKey(DestKey);
              try
                CreateKey(WStrPas(PWideChar(S)){truncates wild content after #0});
                NewDest := GetKey(WStrPas(PWideChar(S)){truncates wild content after #0});
                try
                  CopyValues(NewSrc, NewDest);
                  CopyKeys(NewSrc, NewDest);
                finally
                  RegCloseKey(NewDest);
                end;
              finally
                SetCurrentKey(PrevKey);
              end;
            finally
              RegCloseKey(NewSrc);
            end;
          end;
        end;
      end;
    finally
      SetCurrentKey(OldKey);
    end;
  end;

begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.MoveKey(OldName, NewName, Delete)
  else begin
    if KeyExists(OldName) and not KeyExists(NewName) then
    begin
      SrcKey := GetKey(OldName);
      if SrcKey <> 0 then
      try
        CreateKey(NewName);
        DestKey := GetKey(NewName);
        if DestKey <> 0 then
        try
          CopyValues(SrcKey, DestKey);
          CopyKeys(SrcKey, DestKey);
          if Delete then DeleteKey(OldName);
        finally
          RegCloseKey(DestKey);
        end;
      finally
        RegCloseKey(SrcKey);
      end;
    end;
  end;
end;

function TTntRegistry.GetCurrentKey: HKEY;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.CurrentKey {TNT-ALLOW_ACCESS FCurrentKey}
  else begin
    Result := FCurrentKey
  end;
end;

function TTntRegistry.GetCurrentPath: WideString;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.CurrentPath {TNT-ALLOW_ACCESS FCurrentPath}
  else begin
    Result := FCurrentPath
  end;
end;

function TTntRegistry.GetLazyWrite: Boolean;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.LazyWrite {TNT-ALLOW_ACCESS FLazyWrite}
  else begin
    Result := FLazyWrite
  end;
end;

procedure TTntRegistry.SetLazyWrite(Value: Boolean);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.LazyWrite := Value {TNT-ALLOW_ACCESS FLazyWrite}
  else begin
    FLazyWrite := Value;
  end;
end;

function TTntRegistry.GetRootKey: HKEY;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.RootKey {TNT-ALLOW_ACCESS FRootKey}
  else begin
    Result := FRootKey
  end;
end;

function TTntRegistry.GetAccess: LongWord;
begin
  if (not Win32PlatformIsUnicode) then
    Result := FAnsiRegistry.Access {TNT-ALLOW_ACCESS FAccess}
  else begin
    Result := FAccess
  end;
end;

procedure TTntRegistry.SetAccess(Value: LongWord);
begin
  if (not Win32PlatformIsUnicode) then
    FAnsiRegistry.Access := Value {TNT-ALLOW_ACCESS FAccess}
  else begin
    FAccess := Value
  end;
end;

{$ENDIF}

end.
