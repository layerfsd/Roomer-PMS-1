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

unit TntUnicodeVcl_Register;

{$INCLUDE TntCompilers.inc}

{$R TntActnList.dcr}
{$R TntButtons.dcr}
{$R TntComCtrls.dcr}
{$R TntDBCtrls.dcr}
{$R TntDialogs.dcr}
{$R TntExtCtrls.dcr}
{$R TntExtDlgs.dcr}
{$R TntForms.dcr}
{$R TntGrids.dcr}
{$R TntStdCtrls.dcr}


interface

{ TODO: $IFDEF DelphiPersonalEdition }

procedure Register;

implementation

uses
  Classes, DB, TntForms, TntMenus, TntStdCtrls, TntCheckLst, TntGrids, TntExtCtrls,
  TntComCtrls, TntButtons, TntDB, TntDBCtrls, TntDBGrids, TntActnList, TntDialogs,
  TntExtDlgs, TntTaskDialog
  {$IFDEF COMPILER_7_UP}
  , TntHeader, TntTabs
  {$ENDIF}
  {$IFDEF DELPHI_7_UP}
  , DesignIntf
  {$ENDIF}
  ;


const
  TNT_STANDARD      = 'TMS Unicode Standard';
  TNT_ADDITIONAL    = 'TMS Unicode Additional';
  TNT_WIN32         = 'TMS Unicode Win32';
  TNT_DATA_CONTROLS = 'TMS Unicode Data Controls';
  TNT_DIALOGS       = 'TMS Unicode Dialogs';

procedure Register;
begin
  {$IFDEF COMPILER_9_UP}
  //  ForceDemandLoadState(dlDisable);
  {$ENDIF}

  // ------- Standard -------
  RegisterComponents(TNT_STANDARD, [TTntMainMenu]);
  RegisterComponents(TNT_STANDARD, [TTntPopupMenu]);
  RegisterComponents(TNT_STANDARD, [TTntLabel]);
  RegisterComponents(TNT_STANDARD, [TTntEdit]);
  RegisterComponents(TNT_STANDARD, [TTntMemo]);
  RegisterComponents(TNT_STANDARD, [TTntButton]);
  RegisterComponents(TNT_STANDARD, [TTntCheckBox]);
  RegisterComponents(TNT_STANDARD, [TTntRadioButton]);
  RegisterComponents(TNT_STANDARD, [TTntListBox]);
  RegisterComponents(TNT_STANDARD, [TTntComboBox]);
  RegisterComponents(TNT_STANDARD, [TTntScrollBar]);
  RegisterComponents(TNT_STANDARD, [TTntGroupBox]);
  RegisterComponents(TNT_STANDARD, [TTntRadioGroup]);
  RegisterComponents(TNT_STANDARD, [TTntPanel]);
  RegisterComponents(TNT_STANDARD, [TTntActionList]);
  RegisterComponents(TNT_STANDARD, [TTntLabeledEdit]);
  RegisterComponents(TNT_STANDARD, [TTntMaskEdit]);

  // ------- Additional -------
  RegisterComponents(TNT_ADDITIONAL, [TTntBitBtn]);
  RegisterComponents(TNT_ADDITIONAL, [TTntSpeedButton]);
  { -- TTntMaskEdit goes here -- }
  RegisterComponents(TNT_ADDITIONAL, [TTntStringGrid]);
  RegisterComponents(TNT_ADDITIONAL, [TTntDrawGrid]);
  RegisterComponents(TNT_ADDITIONAL, [TTntImage]);
  RegisterComponents(TNT_ADDITIONAL, [TTntShape]);
  RegisterComponents(TNT_ADDITIONAL, [TTntBevel]);
  RegisterComponents(TNT_ADDITIONAL, [TTntScrollBox]);
  RegisterComponents(TNT_ADDITIONAL, [TTntCheckListBox]);
  RegisterComponents(TNT_ADDITIONAL, [TTntSplitter]);
  RegisterComponents(TNT_ADDITIONAL, [TTntStaticText]);
  RegisterComponents(TNT_ADDITIONAL, [TTntControlBar]);
  {$IFDEF DELPHI_10}
  RegisterComponents(TNT_ADDITIONAL, [TTntTrayIcon]);
  {$ENDIF}

  // ------- Win32 -------
  RegisterComponents(TNT_WIN32, [TTntTabControl]);
  RegisterComponents(TNT_WIN32, [TTntPageControl]);
  RegisterComponents(TNT_WIN32, [TTntRichEdit]);
  RegisterComponents(TNT_WIN32, [TTntTrackBar]);
  RegisterComponents(TNT_WIN32, [TTntProgressBar]);
  RegisterComponents(TNT_WIN32, [TTntUpDown]);
  { -- TTntHotKey goes here -- }
  { -- TTntAnimate goes here -- }
  RegisterComponents(TNT_WIN32, [TTntDateTimePicker]);
  RegisterComponents(TNT_WIN32, [TTntMonthCalendar]);
  RegisterComponents(TNT_WIN32, [TTntTreeView]);
  RegisterComponents(TNT_WIN32, [TTntListView]);
  { -- TTntHeader goes here -- }
  {$IFDEF COMPILER_7_UP}
  RegisterComponents(TNT_WIN32, [TTntHeader]);
  RegisterComponents(TNT_WIN32, [TTntTabSet]);
  {$ENDIF}
  RegisterComponents(TNT_WIN32, [TTntStatusBar]);
  RegisterComponents(TNT_WIN32, [TTntToolBar]);
  { -- TTntCoolBar goes here -- }
  RegisterComponents(TNT_WIN32, [TTntPageScroller]);
  { -- TTntComboBoxEx goes here -- }

  // ------- System -------
  RegisterComponents(TNT_ADDITIONAL, [TTntPaintBox]);
  { -- TTntMediaPlayer goes here -- }
  { -- TTntOleContainer goes here -- }

  // ------- Data Controls -------
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBGrid]);
  { -- TTntDBNavigator goes here -- }
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBText]);
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBEdit]);
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBMemo]);
  { -- TTntDBImage goes here -- }
  { -- TTntDBListBox goes here -- }
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBComboBox]);
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBCheckBox]);
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBRadioGroup]);
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBLookupListBox]);
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBLookupComboBox]);
  { -- TTntDBLookupListBox goes here -- }
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBRichEdit]);

  {$IFNDEF DELPHI_UNICODE}
  RegisterComponents(TNT_DATA_CONTROLS, [TTntDBMaskEdit]);
  {$ENDIF}
  { -- TTntDBCtrlGrid here -- }
  { -- TTntDBLookupListBox goes here -- }
  { -- TTntDBChart goes here -- }

  // ------- Dialogs -------
  RegisterComponents(TNT_DIALOGS, [TTntOpenDialog]);
  RegisterComponents(TNT_DIALOGS, [TTntSaveDialog]);
  RegisterComponents(TNT_DIALOGS, [TTntOpenPictureDialog]);
  RegisterComponents(TNT_DIALOGS, [TTntSavePictureDialog]);
  RegisterComponents(TNT_DIALOGS, [TTntTaskDialog]);
  RegisterComponents(TNT_DIALOGS, [TTntFindDialog]);
  RegisterComponents(TNT_DIALOGS, [TTntReplaceDialog]);

  // --------- Fields --------------
  RegisterTntFields;

  // --------- Classes --------------
  RegisterClass(TTntMenuItem);
  RegisterClass(TTntTabSheet);
  RegisterClass(TTntToolButton);
end;

end.
