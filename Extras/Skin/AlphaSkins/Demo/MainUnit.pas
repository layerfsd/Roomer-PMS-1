unit MainUnit;
{$I sDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, sSkinProvider, sSkinManager, ExtCtrls,
  sPanel, FileCtrl, sScrollBox, UnitFrameDemo, ImgList, sStatusBar, sGauge, sCheckbox, ExtDlgs, ComCtrls, StdCtrls,
  Buttons, sSpeedButton, sComboBox, sHintManager, sDialogs, sMemo, CheckLst, sFrameBar, sLabel, Menus, UnitContact,
  Mask, sMaskEdit, sCustomComboEdit, sTooledit, UnitButtons, sTrackBar, sEdit, ActnList, StdActns, ToolWin, acMagn,
  XPMan, sListBox, acProgressBar, sButton, acAlphaImageList, acAlphaHints, acPNG, sPageControl, sBitBtn, sBevel,
  sComboBoxes, acTitleBar;

type
  TMainForm = class(TForm)
    ImageList16: TsAlphaImageList;
    sStatusBar1: TsStatusBar;
    sGauge3: TsGauge;
    ImageList24: TsAlphaImageList;
    sFrameLookBar1: TsFrameBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    Skinned1: TMenuItem;
    Enabled1: TMenuItem;
    sSkinProvider1: TsSkinProvider;
    N1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Skinned2: TMenuItem;
    Hints2: TMenuItem;
    Enabled2: TMenuItem;
    Exit2: TMenuItem;
    MainActionList: TActionList;
    ActionSkinned: TAction;
    ActionHintsDisable: TAction;
    ActionEnabled: TAction;
    ActionClose: TWindowClose;
    ActionAnimation: TAction;
    Allowanimation1: TMenuItem;
    Allowanimation2: TMenuItem;
    N3: TMenuItem;
    ActionHintsSkinned: TAction;
    ActionHintsCustom: TAction;
    Skinnedhints1: TMenuItem;
    Customhints1: TMenuItem;
    Hintskind1: TMenuItem;
    Hintsshowing1: TMenuItem;
    Custom1: TMenuItem;
    Skinned3: TMenuItem;
    Disabled1: TMenuItem;
    sSkinManager1: TsSkinManager;
    sMagnifier1: TsMagnifier;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenPictureDialog2: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    FindDialog1: TFindDialog;
    ReplaceDialog1: TReplaceDialog;
    sColorDialog1: TsColorDialog;
    ActionCloseForm: TAction;
    ImageList32: TsAlphaImageList;
    ActionHintsStd: TAction;
    sAlphaHints1: TsAlphaHints;
    Standard2: TMenuItem;
    Standard3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    ImgList_MultiState: TsAlphaImageList;
    ImgList_Multi16: TsAlphaImageList;
    sTrackBar3: TsTrackBar;
    sPageControl1: TsPageControl;
    sMenuTab: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet1: TsTabSheet;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sPanel4: TsPanel;
    sTabSheet3: TsTabSheet;
    SkinsDirectoryEdit: TsDirectoryEdit;
    sLabelFX1: TsLabelFX;
    sLabel2: TsLabel;
    sTrackBar2: TsTrackBar;
    sStickyLabel3: TsStickyLabel;
    sStickyLabel1: TsStickyLabel;
    sTrackBar1: TsTrackBar;
    sLabel1: TsLabel;
    sPanel1: TsPanel;
    SkinsComboBox: TsComboBoxEx;
    sWebLabel1: TsWebLabel;
    sWebLabel2: TsWebLabel;
    sStickyLabel2: TsStickyLabel;
    sWebLabel3: TsWebLabel;
    sStickyLabel4: TsStickyLabel;
    sStickyLabel5: TsStickyLabel;
    sWebLabel4: TsWebLabel;
    sStickyLabel6: TsStickyLabel;
    sSpeedButton6: TsSpeedButton;
    PopupDialogs: TPopupMenu;
    Standarddlgsamples1: TMenuItem;
    miOpenDialog1: TMenuItem;
    miSaveDialog1: TMenuItem;
    miOpenPictureDialog1: TMenuItem;
    miSavePictureDialog1: TMenuItem;
    miFontDialog1: TMenuItem;
    miColorDialog1: TMenuItem;
    miPrintDialog1: TMenuItem;
    miPrinterSetupDialog1: TMenuItem;
    miFindDialog1: TMenuItem;
    miReplaceDialog1: TMenuItem;
    Additional1: TMenuItem;
    miAlphaColordialog1: TMenuItem;
    miSelectSkindialog1: TMenuItem;
    sSpeedButton7: TsSpeedButton;
    sSpeedButton8: TsSpeedButton;
    Image1: TImage;
    sCheckBox1: TsCheckBox;
    sSpeedButton3: TsSpeedButton;
    sPanel2: TsPanel;
    sSpeedButton11: TsSpeedButton;
    sSpeedButton9: TsSpeedButton;
    sSpeedButton12: TsSpeedButton;
    sTabSheet4: TsTabSheet;
    sLabel3: TsLabel;
    sTitleBar1: TsTitleBar;
    Builtinskins1: TMenuItem;
    Externalskins1: TMenuItem;
    A1: TMenuItem;
    S1: TMenuItem;
    S2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure sSkinManager1AfterChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FrameDemo1Items0CreateFrame(Sender: TObject; var Frame: TCustomFrame);
    procedure sFrameLookBar1Items2CreateFrame(Sender: TObject; var Frame: TCustomFrame);
    procedure sFrameLookBar1Items3CreateFrame(Sender: TObject; var Frame: TCustomFrame);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure SkinMenuClick(Sender: TObject);
    procedure SkinsComboBoxClick(Sender: TObject);
    procedure SkinsDirectoryEditChange(Sender: TObject);
    procedure sSkinManager1BeforeChange(Sender: TObject);
    procedure sSkinManager1GetMenuExtraLineData(FirstItem: TMenuItem; var SkinSection, Caption: String; var Glyph: TBitmap; var LineVisible: Boolean);
    procedure ActionSkinnedExecute(Sender: TObject);
    procedure ActionHintsDisableExecute(Sender: TObject);
    procedure ActionEnabledExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionAnimationExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionHintsSkinnedExecute(Sender: TObject);
    procedure ActionHintsCustomExecute(Sender: TObject);
    procedure sLabelFX1MouseEnter(Sender: TObject);
    procedure sLabelFX1MouseLeave(Sender: TObject);
    procedure sLabelFX1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sHintManager1ShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo; var Frame: TFrame);
    procedure miOpenDialog1Click(Sender: TObject);
    procedure miSaveDialog1Click(Sender: TObject);
    procedure miOpenPictureDialog1Click(Sender: TObject);
    procedure miSavePictureDialog1Click(Sender: TObject);
    procedure miFontDialog1Click(Sender: TObject);
    procedure miColorDialog1Click(Sender: TObject);
    procedure miPrintDialog1Click(Sender: TObject);
    procedure miPrinterSetupDialog1Click(Sender: TObject);
    procedure miFindDialog1Click(Sender: TObject);
    procedure miReplaceDialog1Click(Sender: TObject);
    procedure miAlphaColorDialog1Click(Sender: TObject);
    procedure sMagnifier1DblClick(Sender: TObject);
    procedure ActionCloseFormExecute(Sender: TObject);
    procedure sTrackBar1Change(Sender: TObject);
    procedure sTrackBar2Change(Sender: TObject);
    procedure ActionHintsStdExecute(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sTrackBar3Change(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sStatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure sSpeedButton8Click(Sender: TObject);
    procedure sTitleBar1Items8Click(Sender: TObject);
    procedure sTitleBar1Items0Click(Sender: TObject);
    procedure sSkinManager1GetPopupItemData(Item: TMenuItem; State: TOwnerDrawState; ItemData: TacMenuItemData);
    procedure sSpeedButton9Click(Sender: TObject);
    procedure sTitleBar1Items5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  public
    PressedBtn : TObject;
    procedure UpdateFrame(Sender : TObject = nil);
    procedure GenerateSkinsList;
  end;

var
  IniName : string;
  MainForm: TMainForm;
  Loading : boolean;
  OldFrame, CurrentFrame : TFrame;
  Animated : boolean = True;
  DialogLoading : boolean = False;

  AppLoading : boolean;         // Prevent of frame animating while app is in loading
  FormShowed : boolean = False; // This variable used in a first form initialization
  // in the OnShow event. Used for preventing of repeated init after each form recreating.
  // Form.OnShow event is processed after each switching to skinned or non-skinned mode.

implementation

uses sMaskData, sStyleSimply, sSkinProps, ShellApi, sMessages, sStoreUtils, sGraphUtils, sVclUtils,
  UnitBarPanel_Visible, UnitBarPanel_Invisible, sHintDesigner, acntUtils, sConst, acSelectSkin, sCommonData, UnitHints;

{$R *.DFM}

procedure TMainForm.FormShow(Sender: TObject);
begin
  if FormShowed then Exit;
  AppLoading := True;
  FormShowed := True; // preventing of repeated initialization
  SkinsDirectoryEdit.Text := sSkinManager1.GetFullSkinDirectory;

  // Opening the first framebar item ( TFrameBarControls )
  sFrameLookBar1.OpenItem(0, True);

  // Example of access to the frame (click on sBitBtn5)
  TBarPanel_Visible(sFrameLookBar1.Items[0].Frame).sBitBtn5.OnClick(TBarPanel_Visible(sFrameLookBar1.Items[0].Frame).sBitBtn5);

  // Available skins searching
  GenerateSkinsList;
  // Initialize combobox with skins list
  SkinsComboBox.ItemIndex := SkinsComboBox.Items.IndexOf(sSkinManager1.SkinName);
  AppLoading := False;
end;

procedure TMainForm.sSkinManager1AfterChange(Sender: TObject);
var
  i : integer;
  b : boolean;
begin
  i := sSkinManager1.GetSkinIndex(s_Form);
  if sSkinManager1.IsValidSkinIndex(i) then begin
    i := SkinsComboBox.Items.IndexOf(sSkinManager1.SkinName);
    if i <> SkinsComboBox.ItemIndex then begin
      Loading := True;
      SkinsComboBox.Items.BeginUpdate;
      SkinsComboBox.ItemIndex := i;
      SkinsComboBox.Items.EndUpdate;
      Loading := False;
    end;
    b := True;
    for i := 0 to Builtinskins1.Count - 1 do // Search of item with current skin name
      if b and (DelChars(Builtinskins1.Items[i].Caption, '&') = sSkinManager1.SkinName) then begin
        Builtinskins1.Items[i].Checked := True;
        b := False;
      end
      else Builtinskins1.Items[i].Checked := False;
    for i := 0 to Externalskins1.Count - 1 do // Search of item with current skin name
      if b and (DelChars(Externalskins1.Items[i].Caption, '&') = sSkinManager1.SkinName) then begin
        Externalskins1.Items[i].Checked := True;
        b := False;
      end
      else Externalskins1.Items[i].Checked := False;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not IsZoomed(Handle) then begin
    try
      // Save window position in Ini-file if it's possible
      sStoreUtils.WriteIniStr('Demo', 'Top', IntToStr(Top), IniName);
    finally
      sStoreUtils.WriteIniStr('Demo', 'Left', IntToStr(Left), IniName);
    end;
  end;
  // Save skin data if exists in Ini
  sStoreUtils.WriteIniStr('Demo', 'SkinDirectory', sSkinManager1.SkinDirectory, IniName);          // Skin directory is stored?
  sStoreUtils.WriteIniStr('Demo', 'SkinName', sSkinManager1.SkinName, IniName);                    // Skin directory is stored?
  sStoreUtils.WriteIniStr('Demo', 'SkinActive', IntToStr(integer(sSkinManager1.Active)), IniName); // Skin is active? Default value is True
end;

procedure TMainForm.UpdateFrame(Sender : TObject);
var
  wTime : word;
begin
  if Animated then wTime := 150 else wTime := 0;
  if Assigned(MainForm) and Assigned(CurrentFrame) then begin
    if Sender <> nil then TsSpeedButton(Sender).ImageIndex := 1;
    CurrentFrame.Visible := False;
    CurrentFrame.SetBounds(Mainform.sFrameLookBar1.Left + Mainform.sFrameLookBar1.Width + 6, Mainform.sFrameLookBar1.Top,
                           Width - Mainform.sFrameLookBar1.Width - Mainform.sFrameLookBar1.Left - 24, Mainform.sFrameLookBar1.Height);
    CurrentFrame.Parent := MainForm;
    CurrentFrame.Anchors := CurrentFrame.Anchors + [akRight];
    if sSkinManager1.Active and not AppLoading then begin
      PrepareForAnimation(CurrentFrame);
      CurrentFrame.Visible := True;
      AnimShowControl(CurrentFrame, wTime);
    end
    else begin
      CurrentFrame.Visible := True;
      CurrentFrame.Repaint
    end;
    if Assigned(OldFrame) then FreeAndNil(OldFrame);
  end;
end;

procedure TMainForm.FrameDemo1Items0CreateFrame(Sender: TObject; var Frame: TCustomFrame);
begin Frame := TBarPanel_Visible.Create(nil) end;

procedure TMainForm.sFrameLookBar1Items2CreateFrame(Sender: TObject; var Frame: TCustomFrame);
begin Frame := TBarPanel_Invisible.Create(nil) end;

procedure TMainForm.sFrameLookBar1Items3CreateFrame(Sender: TObject; var Frame: TCustomFrame);
begin
  Frame := TFrameContact.Create(nil);
  // Controls initialization
  TFrameContact(Frame).sCheckBox1.Checked := beMouseEnter in sSkinManager1.AnimEffects.Buttons.Events;
  TFrameContact(Frame).sCheckBox2.Checked := beMouseLeave in sSkinManager1.AnimEffects.Buttons.Events;
  TFrameContact(Frame).sCheckBox3.Checked := beMouseDown in sSkinManager1.AnimEffects.Buttons.Events;
  TFrameContact(Frame).sCheckBox4.Checked := beMouseup in sSkinManager1.AnimEffects.Buttons.Events;
end;

procedure TMainForm.sSpeedButton1Click(Sender: TObject);
begin
  ActionAnimation.Execute;
end;

procedure TMainForm.SkinMenuClick(Sender: TObject);
begin
  sSkinManager1.SkinName := DelChars(TMenuItem(Sender).Caption, '&');
end;

procedure TMainForm.SkinsComboBoxClick(Sender: TObject);
begin
  if not Loading and (sSkinManager1.SkinName <> SkinsComboBox.Items[SkinsComboBox.ItemIndex]) then begin
    sSkinManager1.SkinName := SkinsComboBox.Items[SkinsComboBox.ItemIndex];
  end;
end;

procedure TMainForm.SkinsDirectoryEditChange(Sender: TObject);
begin
  if DirectoryExists(SkinsDirectoryEdit.Text) and (sSkinManager1.SkinDirectory <> SkinsDirectoryEdit.Text) then begin
    sSkinManager1.SkinDirectory := SkinsDirectoryEdit.Text;
    GenerateSkinsList;
  end;
end;

procedure TMainForm.GenerateSkinsList;
var
  sl : TacStringList;
  i : integer;
  mi : TMenuItem;
begin
  sl := TacStringList.Create;
  sSkinManager1.GetSkinNames(sl);
  SkinsComboBox.Items.BeginUpdate;
  SkinsComboBox.ItemsEx.Clear;
  for i := 0 to sl.Count - 1 do SkinsComboBox.Items.Add(sl[i]);
  SkinsComboBox.Items.EndUpdate;
  // If no available skins...
  if SkinsComboBox.Items.Count < 1 then SkinsComboBox.Items.Add('No skins available');
  FreeAndNil(sl);
  // Menu update
  Builtinskins1.Clear;
  // Build-in skins list
  for i := 0 to sSkinManager1.InternalSkins.Count - 1 do begin
    mi := TMenuItem.Create(Application);
    mi.Caption := sSkinManager1.InternalSkins[i].Name;
    if mi.Caption = sSkinManager1.SkinName then mi.Checked := True;
    mi.OnClick := SkinMenuClick;
    mi.RadioItem := True;
    Builtinskins1.Add(mi);
  end;
  // External skins list
  Externalskins1.Clear;
  sl := TacStringList.Create;
  sSkinManager1.GetExternalSkinNames(sl);
  if sl.Count > 0 then begin
    sl.Sort;
    for i := 0 to sl.Count - 1 do begin
      mi := TMenuItem.Create(Application);
      mi.Caption := sl[i];
      if mi.Caption = sSkinManager1.SkinName then mi.Checked := True;
      mi.OnClick := SkinMenuClick;
      mi.RadioItem := True;
      if (i <> 0) and (i mod 20 = 0) then mi.Break := mbBreak;
      Externalskins1.Add(mi);
    end;
  end;
  FreeAndNil(sl);
end;

procedure TMainForm.sSkinManager1BeforeChange(Sender: TObject);
begin
  // Reset color options to 0
  sLabel1.Caption := '0';
  sLabel2.Caption := sLabel1.Caption;
  sSkinManager1.FHueOffset := 0;
  sSkinManager1.FSaturation := sSkinManager1.FHueOffset;
  sTrackBar1.Position := sSkinManager1.FHueOffset;
  sTrackBar2.Position := sSkinManager1.FSaturation;
end;

procedure TMainForm.sSkinManager1GetMenuExtraLineData(FirstItem: TMenuItem; var SkinSection, Caption: String; var Glyph: TBitmap; var LineVisible: Boolean);
  procedure PrepareGlyph;
  begin
    Glyph := TBitmap.Create;
    // Prepare transparent background
    Glyph.Canvas.Brush.Color := clFuchsia;
    Glyph.Canvas.FillRect(Rect(0, 0, Glyph.Width, Glyph.Height));
    Glyph.Transparent := True;
    // Receiving from imagelist
    ImageList24.DrawingStyle := dsTransparent;
    ImageList24.GetBitmap(12, Glyph);
  end;
begin
  // If item is a first subitem of 'Available skins' (in system menu)
  if (sSkinProvider1.SystemMenu.Items[0].Name = s_SkinSelectItemName) and
       (sSkinProvider1.SystemMenu.Items[0].Count > 8) and // Height of popup-menu must be higher then extra-line width...
         (FirstItem = sSkinProvider1.SystemMenu.Items[0].Items[0]) then begin
    LineVisible := True; // External line available
    Caption := sSkinProvider1.SystemMenu.Items[0].Caption;
    PrepareGlyph;
  end
  else if (Externalskins1.Count > 8) and (FirstItem = Externalskins1.Items[0]) then begin
    LineVisible := True;
    Caption := Externalskins1.Caption;
    PrepareGlyph;
  end
  else if (FirstItem = PopupMenu1.Items[0]) then begin
    LineVisible := True;
    Caption := 'Example of skinned menu';
  end
  else if (FirstItem = Standarddlgsamples1) then begin
    LineVisible := True;
    Caption := 'Most system dialogs are skinned';
  end
  else LineVisible := False;
end;

procedure TMainForm.ActionSkinnedExecute(Sender: TObject);
begin
  ActionSkinned.Checked := not ActionSkinned.Checked;
//  AvailableSkinsMenu.Enabled := ActionSkinned.Checked;
  SkinsDirectoryEdit.Enabled := ActionSkinned.Checked;
  sTabSheet1.Enabled := ActionSkinned.Checked;
  SkinsComboBox.Enabled := ActionSkinned.Checked;
  sTrackBar1.Enabled := ActionSkinned.Checked;
  sTrackBar2.Enabled := ActionSkinned.Checked;
  sSkinManager1.Active := ActionSkinned.Checked;
end;

procedure TMainForm.ActionHintsDisableExecute(Sender: TObject);
begin
  if not ActionHintsDisable.Checked then begin
    ActionHintsDisable.Checked := True;
    ActionHintsCustom.Checked := False;
    ActionHintsSkinned.Checked := False;
    ActionHintsStd.Checked := False;
    ShowHint := False;
    sAlphaHints1.Active := not ActionHintsStd.Checked;
    if CurrentFrame is TFrameHints then TFrameHints(CurrentFrame).UpdateStates
  end;
end;

procedure TMainForm.ActionEnabledExecute(Sender: TObject);
  procedure EnableControl(Control : TWinControl; Value : boolean);
  var
    i : integer;
  begin
    for i := 0 to Control.ControlCount - 1 do begin
      if (Control.Controls[i].Tag = 5) then TControl(Control.Controls[i]).Enabled := Value;
      if (Control.Controls[i] is TWinControl) then EnableControl(TWinControl(Control.Controls[i]), Value);
    end;
  end;
begin
  ActionEnabled.Checked := not ActionEnabled.Checked;
  EnableControl(Self, ActionEnabled.Checked);
end;

procedure TMainForm.ActionCloseExecute(Sender: TObject); begin Close end;

procedure TMainForm.ActionAnimationExecute(Sender: TObject);
begin
  Animated := not ActionAnimation.Checked; // Saving option in variable
  ActionAnimation.Checked := Animated;
  if Animated then begin
    sSpeedButton1.Caption := 'Stop'#13#10'animation';
    sSpeedButton1.ImageIndex := 0;
  end
  else begin
    sSpeedButton1.Caption := 'Allow'#13#10'animation';
    sSpeedButton1.ImageIndex := 1;
  end;
  with sSkinManager1.AnimEffects do begin
    FormShow.Time := integer(Animated) * 100;
    FormHide.Time := FormShow.Time;
    DialogShow.Time := FormShow.Time;
    DialogHide.Time := FormShow.Time;
    PageChange.Time := FormShow.Time;
    SkinChanging.Time := FormShow.Time * 2;
  end;
  if Animated
    then sSkinManager1.AnimEffects.Buttons.Events := [beMouseEnter, beMouseLeave, beMouseDown, beMouseUp]
    else sSkinManager1.AnimEffects.Buttons.Events := [];
  sFrameLookBar1.Animation := Animated;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  l, t : integer;
  s : string;
begin
  IniName := ExtractFilePath(Application.ExeName) + 'ASkinDemo.ini';
  if not acDirExists(sSkinManager1.SkinDirectory) then sSkinManager1.SkinDirectory := ExtractFilePath(Application.ExeName) + 'Skins';
{$IFNDEF DISABLEPREVIEWMODE}
  if (ParamCount > 0) and (ParamStr(1) = s_PreviewKey) then ActionAnimation.Execute; // If called from the SkinEditor for a skin preview (Skin Edit mode)
{$ENDIF}
  // Disable hints on start
  ActionHintsDisable.Execute;
  sTitleBar1.Items[12].Caption := 'v' + sSkinManager1.Version;
  // Restore the form position
  t := sStoreUtils.ReadIniInteger('Demo', 'Top', -1, IniName);
  l := sStoreUtils.ReadIniInteger('Demo', 'Left', -1, IniName);
  if (t <> -1) and (l <> -1) then begin
    SetBounds(l, t, Width, Height);
    Position := poDesigned;
  end;
  // Load skin data if exists in Ini
  s := sStoreUtils.ReadIniString('Demo', 'SkinDirectory', IniName);  // Skin directory is stored?
  if s <> '' then sSkinManager1.SkinDirectory := s;
  s := sStoreUtils.ReadIniString('Demo', 'SkinName', IniName);       // Skin name is stored?
  if s <> '' then sSkinManager1.SkinName := s;
  t := sStoreUtils.ReadIniInteger('Demo', 'SkinActive', 1, IniName); // Skin is active? Default value is True
  sSkinManager1.Active := t = 1;
  if not sSkinManager1.Active then ActionSkinned.Execute
end;

procedure TMainForm.ActionHintsSkinnedExecute(Sender: TObject);
begin
  if not ActionHintsSkinned.Checked then begin
    ActionHintsSkinned.Checked := True;
    ActionHintsCustom.Checked := False;
    ActionHintsDisable.Checked := False;
    ActionHintsStd.Checked := False;
    sAlphaHints1.UseSkinData := True;
    ShowHint := True;
    sAlphaHints1.Active := not ActionHintsStd.Checked;
    if CurrentFrame is TFrameHints then TFrameHints(CurrentFrame).UpdateStates
  end;
end;

procedure TMainForm.ActionHintsCustomExecute(Sender: TObject);
begin
  if not ActionHintsCustom.Checked then begin
    ActionHintsCustom.Checked := True;
    ActionHintsSkinned.Checked := False;
    ActionHintsDisable.Checked := False;
    ActionHintsStd.Checked := False;
    sAlphaHints1.UseSkinData := False;
    ShowHint := True;
    sAlphaHints1.Active := not ActionHintsStd.Checked;
    if CurrentFrame is TFrameHints then TFrameHints(CurrentFrame).UpdateStates
  end;
end;

procedure TMainForm.sLabelFX1MouseEnter(Sender: TObject);
begin
  // Switching the label to unskinned mode
  if sSkinManager1.Active and (sSkinManager1.gd[sSkinManager1.ConstData.IndexGLobalInfo].FontColor[3] <> -1) {If is defined} then begin
    sLabelFX1.Kind.Color := sSkinManager1.gd[sSkinManager1.ConstData.IndexGLobalInfo].FontColor[3];
  end
  else sLabelFX1.Kind.Color := clRed;
  sLabelFX1.Kind.KindType := ktCustom;
  sLabelFX1.Font.Style := sLabelFX1.Font.Style + [fsUnderLine]
end;

procedure TMainForm.sLabelFX1MouseLeave(Sender: TObject);
begin
  // Switching the label to skinned mode
  sLabelFX1.Font.Style := sLabelFX1.Font.Style - [fsUnderLine];
  sLabelFX1.Kind.KindType := ktSkin;
end;

procedure TMainForm.sLabelFX1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and PtInRect(Rect(0, 0, sLabelFX1.Width, sLabelFX1.Height), Point(x, y)) then begin
    ShellExecute(Application.Handle, 'open', PChar('http://www.alphaskins.com'), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TMainForm.sHintManager1ShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo; var Frame: TFrame);
var
  si : TacSectionInfo;
begin
  // Hints can use some Html tags if sHintManager1.HTMLMode = True
  HintStr := 'Class name = <b><u>' + HintInfo.HintControl.ClassName + '</u></b><br>Component name = ' + HintInfo.HintControl.Name;
  si.SkinIndex := -1;
  HintInfo.HintControl.Perform(SM_ALPHACMD, MakeWParam(0, AC_GETSKININDEX), integer(@si));
  if si.SkinIndex >= 0 then begin
    HintStr := HintStr + '<br>' + 'SkinData.SkinSection = <b>' + sSkinManager1.gd[si.SkinIndex].ClassName + '<b>';
  end;
end;

procedure TMainForm.miOpenDialog1Click(Sender: TObject);
begin
  OpenDialog1.Execute
end;

procedure TMainForm.miSaveDialog1Click(Sender: TObject);
begin
  SaveDialog1.Execute
end;

procedure TMainForm.miOpenPictureDialog1Click(Sender: TObject);
begin
  OpenPictureDialog2.Execute
end;

procedure TMainForm.miSavePictureDialog1Click(Sender: TObject);
begin
  SavePictureDialog1.Execute
end;

procedure TMainForm.miFontDialog1Click(Sender: TObject);
begin
  FontDialog1.Execute
end;

procedure TMainForm.miColorDialog1Click(Sender: TObject);
begin
  ColorDialog1.Execute
end;

procedure TMainForm.miPrintDialog1Click(Sender: TObject);
begin
  PrintDialog1.Execute
end;
                                                    
procedure TMainForm.miPrinterSetupDialog1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute
end;

procedure TMainForm.miFindDialog1Click(Sender: TObject);
begin
  FindDialog1.Execute
end;

procedure TMainForm.miReplaceDialog1Click(Sender: TObject);
begin
  ReplaceDialog1.Execute
end;

procedure TMainForm.miAlphaColorDialog1Click(Sender: TObject);
begin
  sColorDialog1.Execute
end;

procedure TMainForm.sMagnifier1DblClick(Sender: TObject);
begin
  sMagnifier1.Hide
end;

procedure TMainForm.ActionCloseFormExecute(Sender: TObject);
begin
  Close
end;

procedure TMainForm.sTrackBar1Change(Sender: TObject);
begin
  if not aSkinChanging and (sSkinManager1.HueOffset <> sTrackBar1.Position) then begin // If not in a skin changing (global variable from AC package used)
    sSkinManager1.BeginUpdate;
    sLabel1.Caption := IntToStr(sTrackBar1.Position);
    sSkinManager1.HueOffset := sTrackBar1.Position;
    sSkinManager1.EndUpdate(True, False);
  end;
end;

procedure TMainForm.sTrackBar2Change(Sender: TObject);
begin
  if not aSkinChanging and (sSkinManager1.Saturation <> sTrackBar2.Position) then begin // If not in a skin changing (global variable from AC package used)
    sSkinManager1.BeginUpdate;
    sLabel2.Caption := IntToStr(sTrackBar2.Position);
    sSkinManager1.Saturation := sTrackBar2.Position;
    sSkinManager1.EndUpdate(True, False);
  end;
end;

procedure TMainForm.ActionHintsStdExecute(Sender: TObject);
begin
  if not ActionHintsStd.Checked then begin
    ActionHintsStd.Checked := True;
    ActionHintsSkinned.Checked := False;
    ActionHintsDisable.Checked := False;
    ActionHintsCustom.Checked := False;
    sAlphaHints1.UseSkinData := False;
    ShowHint := True;
    sAlphaHints1.Active := not ActionHintsStd.Checked;
    if CurrentFrame is TFrameHints then TFrameHints(CurrentFrame).UpdateStates
  end;
end;

procedure TMainForm.sSpeedButton2Click(Sender: TObject);
begin
  sSkinManager1.Effects.AllowGlowing := not sSkinManager1.Effects.AllowGlowing;
  if sSkinManager1.Effects.AllowGlowing then begin
    sSpeedButton2.ImageIndex := 2;
    sSpeedButton2.Caption := 'Stop'#13#10'glowing';
  end
  else begin
    sSpeedButton2.ImageIndex := 3;
    sSpeedButton2.Caption := 'Allow'#13#10'glowing';
  end;
end;

procedure TMainForm.sTrackBar3Change(Sender: TObject);
begin
  sGauge3.Progress := sTrackBar3.Position
end;

procedure TMainForm.sSpeedButton5Click(Sender: TObject);
begin
  sSkinManager1.ExtendedBorders := not sSkinManager1.ExtendedBorders;
end;

procedure TMainForm.sSpeedButton4Click(Sender: TObject);
begin
  if sSpeedButton4.Down then ActionHintsSkinned.Execute {enable hints} else ActionHintsDisable.Execute {disable hints};
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
//  sSkinProvider1.AllowExtBorders := not IsZoomed(MainForm.Handle); // ExtendedBorders will be disabled when form is maximized if this code used
end;

procedure TMainForm.sStatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel.Index = 2 then begin // Paint glyph on status panel
    ImageList16.Draw(StatusBar.Canvas, Rect.Left + 2, Rect.Top + 2, 0);
  end;
end;

procedure TMainForm.sSpeedButton8Click(Sender: TObject);
begin
  sMagnifier1.Execute
end;

procedure TMainForm.sTitleBar1Items8Click(Sender: TObject);
begin
  sMagnifier1.Execute
end;

procedure TMainForm.sTitleBar1Items0Click(Sender: TObject);
begin
  sTitleBar1.Items[0].Visible := False;      // Btn
  sTitleBar1.Items[1].Visible := False;      // Spacing
  sSkinProvider1.TitleIcon.Visible := False; // Title icon
end;

procedure TMainForm.sSkinManager1GetPopupItemData(Item: TMenuItem; State: TOwnerDrawState; ItemData: TacMenuItemData);
begin
  // Example of custom font in menu items
  if (Item = Builtinskins1) or (Item = miAlphaColordialog1) then begin
    ItemData.Font.Style := [fsBold];
    ItemData.Font.Size := ItemData.Font.Size + 2;
  end;
end;

procedure TMainForm.sSpeedButton9Click(Sender: TObject);
begin
  SelectSkin(sSkinManager1);
end;

procedure TMainForm.sTitleBar1Items5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Disable animation of skin changing
  sSkinManager1.AnimEffects.SkinChanging.Active := False;
  // Return a normal state for this button
  sTitleBar1.Items[5].State := 0;
  sSkinManager1.HueOffset := sSkinManager1.HueOffset + 40;
  // Enable animation of skin changing
  sSkinManager1.AnimEffects.SkinChanging.Active := True;
end;

var
  i : integer = 0;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  inc(i);
  Caption := IntToStr(i);
end;

end.
