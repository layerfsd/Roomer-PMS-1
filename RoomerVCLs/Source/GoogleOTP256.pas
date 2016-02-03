unit GoogleOTP256;

interface

uses
  System.SysUtils, System.Math, uStringUtils, IdGlobal, Windows, System.DateUtils,
  hmac, hash, sha256;

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

function CalculateOTP(const Secret: String; const Counter: Integer = -1): String;
function CalculateOTPOnSpecifiedTime(const Secret: String; tim : Extended): String;
function ValidateTOPT(const Secret: String; const Token: String; const WindowSize: Integer = 4): Boolean;

implementation

const
  otpLength = 8;
  keyRegeneration = 30;
  totpTimeTruncInterval	= 30000;

function HMACSHA256x(const _Key: TIdBytes; const Buffer: TIdBytes): TIdBytes;
var ctx: THMAC_Context;
    phash: PHashDesc;
    dlen, klen: word;
    mac: THashDigest;
    AlgoName: THashName;
    i : Integer;
begin
  klen := HIGH(_Key) + 1;
  dlen := HIGH(Buffer) + 1;

  AlgoName := 'sha256';
  phash := FindHash_by_Name(AlgoName);
  hmac_init(ctx, phash, _Key, klen);
  hmac_updateXL(ctx, Buffer, dlen);
  hmac_final(ctx, mac);

  setLength(result, 32);
  Move(mac[0], result[0], 32);
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

function getTime(tim : Extended = 0) : String;
var numberOfTimeSteps : int64;
    LocalDateTime : Extended;
begin
  result := '0'; // '0000000002C6B1F9';
  if tim = 0 then
    tim := now;
  LocalDateTime := TTimeZone.Local.ToUniversalTime(tim);
  numberOfTimeSteps := DateTimetoUnix(LocalDateTime) div (totpTimeTruncInterval div 1000);
  result := Uppercase(IntToHex(numberOfTimeSteps, 16));
  while (result.Length < 16) do
        result := '0' + result;
end;


function CalculateOTP(const Secret: String; const Counter: Integer = -1): String;
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
  ResultHash := HMACSHA256x(SecretKeyArray, TimeArray);

  Offset := (ResultHash[HIGH(ResultHash)] AND $0F);
  Part1 := (ResultHash[Offset+0] AND $7F);
  Part2 := (ResultHash[Offset+1] AND $FF);
  Part3 := (ResultHash[Offset+2] AND $FF);
  Part4 := (ResultHash[Offset+3] AND $FF);

  Key := (Part1 shl 24) OR (Part2 shl 16) OR (Part3 shl 8) OR (Part4);
  Result :=  FillPreTextWithChar(inttostr(Key mod Trunc(IntPower(10, otpLength))), '0', otpLength);
end;

function CalculateOTPOnSpecifiedTime(const Secret: String; tim : Extended): String;
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
  Time := getTime(tim); // '0000000002C6B1F9';
  TimeArray := HexStrToIdBytes(Time);

  SecretKeyArray := HexStrToIdBytes(Secret);
  ResultHash := HMACSHA256x(SecretKeyArray, TimeArray);

  Offset := (ResultHash[HIGH(ResultHash)] AND $0F);
  Part1 := (ResultHash[Offset+0] AND $7F);
  Part2 := (ResultHash[Offset+1] AND $FF);
  Part3 := (ResultHash[Offset+2] AND $FF);
  Part4 := (ResultHash[Offset+3] AND $FF);

  Key := (Part1 shl 24) OR (Part2 shl 16) OR (Part3 shl 8) OR (Part4);
  Result :=  FillPreTextWithChar(inttostr(Key mod Trunc(IntPower(10, otpLength))), '0', otpLength);
end;

function ValidateTOPT(const Secret: String; const Token: String; const WindowSize: Integer = 4): Boolean;
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
