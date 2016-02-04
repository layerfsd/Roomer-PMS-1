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

unit TntDBClientActns;

{$INCLUDE TntCompilers.inc}


interface

uses
  Classes, ActnList, DBClientActns, TntActnList;

type
{TNT-WARN TClientDataSetApply}
  TTntClientDataSetApply = class(TClientDataSetApply{TNT-ALLOW TClientDataSetApply}, ITntAction)
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

{TNT-WARN TClientDataSetRevert}
  TTntClientDataSetRevert = class(TClientDataSetRevert{TNT-ALLOW TClientDataSetRevert}, ITntAction)
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

{TNT-WARN TClientDataSetUndo}
  TTntClientDataSetUndo = class(TClientDataSetUndo{TNT-ALLOW TClientDataSetUndo}, ITntAction)
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
  TntClasses, TntDBActns;

{TNT-IGNORE-UNIT}

procedure TntDBClientActn_AfterInherited_Assign(Action: TCustomAction{TNT-ALLOW TCustomAction}; Source: TPersistent);
begin
  TntDBActn_AfterInherited_Assign(Action, Source);
  // TClientDataSetApply
  if (Action is TClientDataSetApply) and (Source is TClientDataSetApply) then begin
    TClientDataSetApply(Action).MaxErrors := TClientDataSetApply(Source).MaxErrors;
    TClientDataSetApply(Action).DisplayErrorDlg := TClientDataSetApply(Source).DisplayErrorDlg;
  end;
  // TClientDataSetUndo
  if (Action is TClientDataSetUndo) and (Source is TClientDataSetUndo) then begin
    TClientDataSetUndo(Action).FollowChange := TClientDataSetUndo(Source).FollowChange;
  end;
end;

//-------------------------
//    TNT DB ACTNS
//-------------------------

{ TTntClientDataSetApply }

procedure TTntClientDataSetApply.Assign(Source: TPersistent);
begin
  inherited;
  TntDBClientActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntClientDataSetApply.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntClientDataSetApply.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntClientDataSetApply.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntClientDataSetApply.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntClientDataSetApply.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntClientDataSetRevert }

procedure TTntClientDataSetRevert.Assign(Source: TPersistent);
begin
  inherited;
  TntDBClientActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntClientDataSetRevert.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntClientDataSetRevert.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntClientDataSetRevert.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntClientDataSetRevert.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntClientDataSetRevert.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

{ TTntClientDataSetUndo }

procedure TTntClientDataSetUndo.Assign(Source: TPersistent);
begin
  inherited;
  TntDBClientActn_AfterInherited_Assign(Self, Source);
end;

procedure TTntClientDataSetUndo.DefineProperties(Filer: TFiler);
begin
  inherited;
  TntPersistent_AfterInherited_DefineProperties(Filer, Self);
end;

function TTntClientDataSetUndo.GetCaption: WideString;
begin
  Result := TntAction_GetCaption(Self);
end;

procedure TTntClientDataSetUndo.SetCaption(const Value: WideString);
begin
  TntAction_SetCaption(Self, Value);
end;

function TTntClientDataSetUndo.GetHint: WideString;
begin
  Result := TntAction_GetHint(Self);
end;

procedure TTntClientDataSetUndo.SetHint(const Value: WideString);
begin
  TntAction_SetHint(Self, Value);
end;

end.
