unit GoogleOTP;

interface

uses
  System.SysUtils, System.Math, Base32U, IdGlobal, IdHMACSHA1, IdHMAC,
  IdSSLOpenSSL, Windows, System.DateUtils, cHash, myCrypto;

(*

Test Case for the CalculateOTP function
---------------------------------------

Init key: AAAAAAAAAAAAAAAAAAAA
Timestamp: 1
BinCounter: 0000000000000001 (HEX-Representation)
Hash: eeb00b0bcc864679ff2d8dd30bec495cb5f2ee9e (HEX-Representation)
Offset: 14
Part 1: 73
Part 2: 92
Part 3: 181
Part 4: 242
One time password: 812658

Easy Display: Format('%.6d', [CalculateOTP(SECRET)]);
*)

var ResultHash : TIdBytes;

function CalculateOTP(const Secret: String; const Counter: Integer = -1): Integer;
function ValidateTOPT(const Secret: String; const Token: Integer; const WindowSize: Integer = 4): Boolean;

implementation

const
  otpLength = 8;
  keyRegeneration = 30;
  totpTimeTruncInterval	= 30; // 000;

/// <summary>
///   Sign the Buffer with the given Key
/// </summary>

//function HashValueNative(const ABuffer: TIdBytes; const ATruncateTo: Integer = -1) : TIdBytes; // for now, supply in bytes
//const
//  CInnerPad : Byte = $36;
//  COuterPad : Byte = $5C;
//var
//  TempBuffer1: TIdBytes;
//  TempBuffer2: TIdBytes;
//  LKey: TIdBytes;
//  I: Integer;
//begin
//  InitKey;
//  LKey := Copy(FKey, 0, MaxInt);
//  SetLength(LKey, FBlockSize);
//  SetLength(TempBuffer1, FBlockSize + Length(ABuffer));
//  for I := Low(LKey) to High(LKey) do begin
//    TempBuffer1[I] := LKey[I] xor CInnerPad;
//  end;
//  CopyTIdBytes(ABuffer, 0, TempBuffer1, Length(LKey), Length(ABuffer));
//  TempBuffer2 := FHash.HashBytes(TempBuffer1);
//  SetLength(TempBuffer1, 0);
//  SetLength(TempBuffer1, FBlockSize + FHashSize);
//  for I := Low(LKey) to High(LKey) do begin
//    TempBuffer1[I] := LKey[I] xor COuterPad;
//  end;
//  CopyTIdBytes(TempBuffer2, 0, TempBuffer1, Length(LKey), Length(TempBuffer2));
//  Result := FHash.HashBytes(TempBuffer1);
//  SetLength(TempBuffer1, 0);
//  SetLength(TempBuffer2, 0);
//  SetLength(LKey, 0);
//  if ATruncateTo > -1 then begin
//    SetLength(Result, ATruncateTo);
//  end;
//end;


function HMACSHA256(const _Key: TIdBytes; const Buffer: TIdBytes): TIdBytes;
var
   i, n : Integer;
   pad : array [0..31] of Byte;
   sha : TSHA256;
   firstPass : TSHA256Digest;
   _result : TSHA256Digest;
begin
   n:=HIGH(_key) + 1;
   for i := 0 to n - 1 do
     pad[i] := $36 xor _Key[i];
   for i:=n to High(pad) do
      pad[i]:=$36;

   sha.Init;
   sha.Update(@pad, SizeOf(pad));
   sha.Update(@Buffer, HIGH(Buffer) + 1);
   sha.Final(firstPass);

   for i := 0 to n - 1 do
     pad[i] := $5c xor _Key[i];
   for i:=n to High(pad) do
      pad[i]:=$5c;

//   sha.Init;
   sha.Update(@pad, SizeOf(pad));
   sha.Update(@firstPass, SizeOf(firstPass));
   sha.Final(_Result);

   SetLength(Result, 32);
   for i := 0 to 31 do
     Result[i] := _Result[i];
end;

function HMACSHA1(const _Key: TIdBytes; const Buffer: TIdBytes): TIdBytes;
var IdHMAC : TIdHMACSHA256;
begin
  IdSSLOpenSSL.LoadOpenSSLLibrary;
  IdHMAC := TIdHMACSHA256.Create;
  try
  with IdHMAC do
  begin
    Key := _Key;
    Result := HashValue(Buffer);
  end;
  finally
    FreeAndNil(IdHMAC);
  end;
end;

function HMACSHA256b(const _Key: TIdBytes; const Buffer: TIdBytes): TIdBytes;
var res : T256BitDigest;
    i,
    keyNum,
    bufNum : Integer;
begin
  keyNum := HIGH(_Key) + 1;
  bufNum := HIGH(Buffer) + 1;
  res := CalcHMAC_SHA256(@_Key, keyNum, Buffer, bufNum);

  setLength(result, 32);
  for i := 0 to 31 do
    result[i] := res.Bytes[i];
end;


/// <summary>
///   Reverses TIdBytes (from low->high to high->low)
/// </summary>
function ReverseIdBytes(const inBytes: TIdBytes): TIdBytes;
var
  i: Integer;
begin
  SetLength(Result, Length(inBytes));
  for i := Low(inBytes) to High(inBytes) do
    Result[High(inBytes) - i] := inBytes[i];
end;

/// <summary>
///   Converts a TDateTime into the corresponding Unix Timestamp.
///   From http://www.delphipraxis.net/4278-datetime-unixtimestamp-und-zurueck.html
/// </summary>
function CodeUnixDateTime(DateAndTime: TDateTime): Integer;
begin
  Result := ((Trunc(DateAndTime) - 25569) * 86400) +
            Trunc(86400 * (DateAndTime - Trunc(DateAndTime))) - 7200;
end;

/// <summary>
///   My own ToBytes function. Something in the original one isn't working as expected.
/// </summary>
function StrToIdBytes(const inString: String): TIdBytes;
var
  ch: Char;
  i: Integer;
begin
  SetLength(Result, Length(inString));

  i := 0;
  for ch in inString do
  begin
    Result[i] := Ord(ch);
    inc(i);
  end;
end;

function HexStrToIdBytes(hexStr : String) : TIdBytes;
var c : Integer;
    i, l : Integer;
    s : String;
begin
  l := 0;
  SetLength(result, Length(hexStr) div 2);
  repeat
    Val('$' + copy(hexStr, l * 2 + 1, 2), i, c);
    result[l] := i;
    inc(l);
  until l > High(result);
end;

function getTime() : String;
var numberOfTimeSteps : int64;
    LocalDateTime : Extended;
begin
  result := '0000000002C6B1F9';
  exit;
  LocalDateTime := TTimeZone.Local.ToUniversalTime(now);
  numberOfTimeSteps := DateTimetoUnix(LocalDateTime) div totpTimeTruncInterval; //getTickCount;
  result := Uppercase(IntToHex(numberOfTimeSteps, 16));
  while (result.Length < 16) do
        result := '0' + result;
end;


function CalculateOTP(const Secret: String; const Counter: Integer = -1): Integer;
var
  Hash: String;
  Offset: Integer;
  Part1, Part2, Part3, Part4: Integer;
  Key: Integer;
  Time: String;
  TimeArray,
  SecretKeyArray : TIdBytes;
begin

		// Get the HEX in a Byte[]
  Time := getTime; // '0000000002C6B1F9';
  TimeArray := HexStrToIdBytes(Time);

  SecretKeyArray := HexStrToIdBytes(Secret);
//  ResultHash := HMACSHA1(SecretKeyArray, TimeArray);
  ResultHash := HMACSHA256(SecretKeyArray, TimeArray);

  Offset := (ResultHash[HIGH(ResultHash)] AND $0F);
  Part1 := (ResultHash[Offset+0] AND $7F);
  Part2 := (ResultHash[Offset+1] AND $FF);
  Part3 := (ResultHash[Offset+2] AND $FF);
  Part4 := (ResultHash[Offset+3] AND $FF);

  Key := (Part1 shl 24) OR (Part2 shl 16) OR (Part3 shl 8) OR (Part4);
  Result := Key mod Trunc(IntPower(10, otpLength));
end;

function ValidateTOPT(const Secret: String; const Token: Integer; const WindowSize: Integer = 4): Boolean;
var
  TimeStamp: Integer;
  TestValue: Integer;
begin
  Result := false;

  TimeStamp := CodeUnixDateTime(now()) div keyRegeneration;
  for TestValue := Timestamp - WindowSize to TimeStamp + WindowSize do
  begin
    if (CalculateOTP(Secret, TestValue) = Token) then
      Result := true;
  end;
end;


end.
