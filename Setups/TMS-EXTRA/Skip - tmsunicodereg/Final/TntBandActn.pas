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

unit TntBandActn;

{$INCLUDE TntCompilers.inc}

{$IFDEF DELPHI_UNICODE}

interface

uses
  BandActn;

type
  TTntCustomizeActionBars = TCustomizeActionBars;

implementation

{$ENDIF}

{$IFNDEF DELPHI_UNICODE}

interface

uses
  Classes, BandActn, TntActnList;

type
{TNT-WARN TCustomizeActionBars}
  TTntCustomizeActionBars = class(TCustomizeActionBars{TNT-ALLOW TCustomizeActionBars}, ITntAction)
  private
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Hint: WideString read GetHint write SetHint;
  end;

implementation

uses
  ActnList, TntClasses;

{TNT-IGNORE-UNIT}

procedure TntBandActn_AfterInherited_Assign(Action: TCustomAction{TNT-ALLOW TCustomAction}; Source: TPersistent);
begin
  TntAction_AfterInherited_Assign(Action, Source);
  // TCustomizeActionBars
  if (Action is TCustomizeActionBars) and (Source is TCustomizeActionBars) then begin
    TCustomizeActionBars(Action).ActionManager := TCustomizeActionBars(Source).ActionManager;
  end;
end;

//-------------------------
//    TNT BAND ACTN
//-------------------------

{ TTntCustomizeActionBars }

procedure TTntCustomizeActionBars.Assign(Source: TPersistent);
begin
  inherited;
  TntBandActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntCustomizeActionBars.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntCustomizeActionBars.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntCustomizeActionBars.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntCustomizeActionBars.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntCustomizeActionBars.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{$ENDIF}

end.
