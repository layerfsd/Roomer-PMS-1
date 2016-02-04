{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 - 2009 by TMS software                                   }
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

unit TntClipBrd;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  Clipbrd;

type
  TTntClipboard = class(TClipboard)
  private
    function GetAsWideText: String;
    procedure SetAsWideText(const Value: String);
  public
    property AsWideText: String read GetAsWideText write SetAsWideText;
  end;

function TntClipboard: TTntClipboard;

implementation

function TntClipboard: TTntClipboard;
begin
  Result := TTntClipboard(Clipboard);
end;


function TTntClipboard.GetAsWideText: String;
begin
  Result := inherited AsText;
end;

procedure TTntClipboard.SetAsWideText(const Value: String);
begin
  inherited AsText := Value;
end;

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}

interface

uses
  Windows, Clipbrd;

type
{TNT-WARN TClipboard}
  TTntClipboard = class(TClipboard{TNT-ALLOW TClipboard})
  private
    function GetAsWideText: WideString;
    procedure SetAsWideText(const Value: WideString);
  public
    property AsWideText: WideString read GetAsWideText write SetAsWideText;
    property AsText: WideString read GetAsWideText write SetAsWideText;
  end;

{TNT-WARN Clipboard}
function TntClipboard: TTntClipboard;

implementation

{ TTntClipboard }

function TTntClipboard.GetAsWideText: WideString;
var
  Data: THandle;
begin
  Open;
  Data := GetClipboardData(CF_UNICODETEXT);
  try
    if Data <> 0 then
      Result := PWideChar(GlobalLock(Data))
    else
      Result := '';
  finally
    if Data <> 0 then GlobalUnlock(Data);
    Close;
  end;
  if (Data = 0) or (Result = '') then
    Result := inherited AsText
end;

procedure TTntClipboard.SetAsWideText(const Value: WideString);
begin
  Open;
  try
    inherited AsText := Value; {Ensures ANSI compatiblity across platforms.}
    SetBuffer(CF_UNICODETEXT, PWideChar(Value)^, (Length(Value) + 1) * SizeOf(WideChar));
  finally
    Close;
  end;
end;

//------------------------------------------

var
  GTntClipboard: TTntClipboard;

function TntClipboard: TTntClipboard;
begin
  if GTntClipboard = nil then
    GTntClipboard := TTntClipboard.Create;
  Result := GTntClipboard;
end;

initialization

finalization
  GTntClipboard.Free;

{$ENDIF}

end.
