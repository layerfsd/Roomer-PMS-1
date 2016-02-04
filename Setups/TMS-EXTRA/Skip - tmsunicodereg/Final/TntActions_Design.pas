{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 - 2012 by TMS software                                   }
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

unit TntActions_Design;

{$INCLUDE TntCompilers.inc}

interface

procedure Register;

implementation

uses
  Classes, ActnList, TntActnList, StdActns, TntStdActns,
  ExtActns, TntExtActns, ListActns, TntListActns, BandActn, TntBandActn,
  DBActns, TntDBActns, TntDesignEditors_Design
  {$IFDEF DELPHI_XE3}
  , System.Actions
  {$ENDIF}
  ;

procedure Register;
begin
  RegisterClass(TTntAction);
  // StdActns
  RegisterClass(TTntEditAction);
  RegisterClass(TTntEditCut);
  RegisterClass(TTntEditCopy);
  RegisterClass(TTntEditPaste);
  RegisterClass(TTntEditSelectAll);
  RegisterClass(TTntEditUndo);
  RegisterClass(TTntEditDelete);
  RegisterClass(TTntWindowAction);
  RegisterClass(TTntWindowClose);
  RegisterClass(TTntWindowCascade);
  RegisterClass(TTntWindowTileHorizontal);
  RegisterClass(TTntWindowTileVertical);
  RegisterClass(TTntWindowMinimizeAll);
  RegisterClass(TTntWindowArrange);
  RegisterClass(TTntHelpAction);
  RegisterClass(TTntHelpContents);
  RegisterClass(TTntHelpTopicSearch);
  RegisterClass(TTntHelpOnHelp);
  RegisterClass(TTntHelpContextAction);
  RegisterClass(TTntFileOpen);
  RegisterClass(TTntFileOpenWith);
  RegisterClass(TTntFileSaveAs);
  RegisterClass(TTntFilePrintSetup);
  RegisterClass(TTntFileExit);
  RegisterClass(TTntSearchFind);
  RegisterClass(TTntSearchReplace);
  RegisterClass(TTntSearchFindFirst);
  RegisterClass(TTntSearchFindNext);
  RegisterClass(TTntFontEdit);
  RegisterClass(TTntColorSelect);
  RegisterClass(TTntPrintDlg);
  // ExtActns
  RegisterClass(TTntFileRun);
  RegisterClass(TTntRichEditAction);
  RegisterClass(TTntRichEditBold);
  RegisterClass(TTntRichEditItalic);
  RegisterClass(TTntRichEditUnderline);
  RegisterClass(TTntRichEditStrikeOut);
  RegisterClass(TTntRichEditBullets);
  RegisterClass(TTntRichEditAlignLeft);
  RegisterClass(TTntRichEditAlignRight);
  RegisterClass(TTntRichEditAlignCenter);
  RegisterClass(TTntPreviousTab);
  RegisterClass(TTntNextTab);
  RegisterClass(TTntOpenPicture);
  RegisterClass(TTntSavePicture);
  RegisterClass(TTntURLAction);
  RegisterClass(TTntBrowseURL);
  RegisterClass(TTntDownLoadURL);
  RegisterClass(TTntSendMail);
  RegisterClass(TTntListControlCopySelection);
  RegisterClass(TTntListControlDeleteSelection);
  RegisterClass(TTntListControlSelectAll);
  RegisterClass(TTntListControlClearSelection);
  RegisterClass(TTntListControlMoveSelection);
  // ListActns
  RegisterClass(TTntStaticListAction);
  RegisterClass(TTntVirtualListAction);
  {$IFDEF COMPILER_7_UP}
  RegisterClass(TTntFilePageSetup);
  {$ENDIF}
  // DBActns
  RegisterClass(TTntDataSetAction);
  RegisterClass(TTntDataSetFirst);
  RegisterClass(TTntDataSetPrior);
  RegisterClass(TTntDataSetNext);
  RegisterClass(TTntDataSetLast);
  RegisterClass(TTntDataSetInsert);
  RegisterClass(TTntDataSetDelete);
  RegisterClass(TTntDataSetEdit);
  RegisterClass(TTntDataSetPost);
  RegisterClass(TTntDataSetCancel);
  RegisterClass(TTntDataSetRefresh);
  // BandActn
  RegisterClass(TTntCustomizeActionBars);
end;

//------------------------

function GetTntActionClass(OldActionClass: TContainedActionClass): TContainedActionClass;
begin
  Result := TContainedActionClass(GetClass('TTnt' + Copy(OldActionClass.ClassName, 2, Length(OldActionClass.ClassName))));
end;

type
  TAccessContainedAction = class(TContainedAction);

function UpgradeAction(ActionList: TTntActionList; OldAction: TContainedAction): TContainedAction;
var
  Name: TComponentName;
  i: integer;
  NewActionClass: TContainedActionClass;
begin
  Result := nil;
  if (OldAction = nil) or (OldAction.Owner = nil) or (OldAction.Name = '') then
    Exit;

  NewActionClass := GetTntActionClass(TContainedActionClass(OldAction.ClassType));
  if NewActionClass <> nil then begin
    // create new action
    Result := NewActionClass.Create(OldAction.Owner) as TContainedAction;
    Include(TAccessContainedAction(Result).FComponentStyle, csTransient);
    // copy base class info
    Result.ActionComponent := OldAction.ActionComponent;
    Result.Category := OldAction.Category; { Assign Category before ActionList/Index to avoid flicker. }
    Result.ActionList := ActionList;
    Result.Index := OldAction.Index;
    // assign props
    Result.Assign(OldAction);
    // point all links to this new action

    {$IFDEF DELPHI_XE3}
    for i := TAccessContainedAction(OldAction).ClientCount - 1 downto 0 do
      TBasicActionLink(TAccessContainedAction(OldAction).Clients[i]).Action := Result;
    {$ENDIF}

    {$IFNDEF DELPHI_XE3}
    for i := TAccessContainedAction(OldAction).FClients.Count - 1 downto 0 do
      TBasicActionLink(TAccessContainedAction(OldAction).FClients[i]).Action := Result;
    {$ENDIF}
    // free old object, preserve name...
    Name := OldAction.Name;
    OldAction.Free;
    Result.Name := Name; { link up to old name }
    Exclude(TAccessContainedAction(Result).FComponentStyle, csTransient);
  end;
end;

procedure TntActionList_UpgradeActionListItems(ActionList: TTntActionList);
var
  DesignerNotify: IDesignerNotify;
  Designer: ITntDesigner;
  TntSelections: TTntDesignerSelections;
  i: integer;
  OldAction, NewAction: TContainedAction;
begin
  DesignerNotify := FindRootDesigner(ActionList);
  if (DesignerNotify <> nil) then begin
    DesignerNotify.QueryInterface(ITntDesigner, Designer);
    if (Designer <> nil) then begin
      TntSelections := TTntDesignerSelections.Create;
      try
        Designer.GetSelections(TntSelections);
        for i := ActionList.ActionCount - 1 downto 0 do begin
          OldAction := ActionList.Actions[i];
          NewAction := UpgradeAction(ActionList, OldAction);
          if (NewAction <> nil) then
            TntSelections.ReplaceSelection(OldAction, NewAction);
        end;
        Designer.SetSelections(TntSelections);
      finally
        TntSelections.Free;
      end;
    end;
  end;
end;

initialization
  {$IFNDEF DELPHI_UNICODE}
  UpgradeActionListItemsProc := TntActionList_UpgradeActionListItems;
  {$ENDIF}

end.
