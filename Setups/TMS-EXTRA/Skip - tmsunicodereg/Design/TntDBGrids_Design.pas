{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 by TMS software                                          }
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

unit TntDBGrids_Design;

{$INCLUDE ..\Source\TntCompilers.inc}

interface

uses
  DesignEditors, DesignIntf; 

type
  TTntDBGridEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string{TNT-ALLOW string}; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

implementation

uses
  TntDBGrids, DsnDBCst, TntDesignEditors_Design;

procedure Register;
begin
  RegisterComponentEditor(TTntDBGrid, TTntDBGridEditor);
end;

{ TTntDBGridEditor }

function TTntDBGridEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TTntDBGridEditor.GetVerb(Index: Integer): string{TNT-ALLOW string};
begin
  Result := DsnDBCst.SDBGridColEditor;
end;

procedure TTntDBGridEditor.ExecuteVerb(Index: Integer);
begin
  EditPropertyWithDialog(Component, 'Columns', Designer);
end;

end.
