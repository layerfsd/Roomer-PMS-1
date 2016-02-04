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

unit TntDBClientActns_Design;

{$INCLUDE TntCompilers.inc}

interface

uses
  Classes;

procedure Register;

implementation

uses
   TntDBClientActns;

procedure Register;
begin
  // DBClientActns
  RegisterClass(TTntClientDataSetApply);
  RegisterClass(TTntClientDataSetRevert);
  RegisterClass(TTntClientDataSetUndo);
end;

end.
