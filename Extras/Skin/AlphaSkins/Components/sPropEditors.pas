unit sPropEditors;
{$I sDefs.inc}

interface


uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  FileCtrl, ComCtrls, ExtCtrls, ImgList, SysUtils, ColnEdit,
  Consts, ComStrs, CommCtrl, TypInfo,
  {$IFDEF DELPHI6UP} DesignEditors, DesignIntf, VCLEditors, {$ELSE} dsgnintf, {$ENDIF}
  {$IFNDEF ALITE}sDialogs, sPageControl, {$ENDIF}
  sVclUtils, sPanel, sGraphUtils, acntUtils, sConst;


type
{$IFNDEF ALITE}
  TsHintProperty = class(TCaptionProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    procedure Edit; override;
  end;


  TsGradientProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


  TsPageControlEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TsFrameBarEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TsTabSheetEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TacHintsTemplatesProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


  TacAlphaHintsEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TsPathDlgEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TacTemplateNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;
{$ENDIF}

  TacSkinInfoProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


  TsImageListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TacImageIndexEditor = class(TIntegerProperty{$IFDEF DELPHI7UP}, ICustomPropertyListDrawing{$ENDIF})
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetMyList:TCustomImageList;
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer); {$IFNDEF DELPHI6UP}override;{$ENDIF}
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer); {$IFNDEF DELPHI6UP}override;{$ENDIF}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean); {$IFNDEF DELPHI6UP}override;{$ENDIF}
  end;


  TacImgListItemsProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


  TsSkinSectionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


  TsSkinNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


  TsDirProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;


  TsInternalSkinsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


  TacThirdPartyProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


  TacSkinManagerEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TacTitleBarEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


procedure Register;

implementation


uses
  stdreg, Menus,
{$IFDEF USEFILTEDIT}
  FiltEdit,
{$ENDIF}
{$IFDEF USEHINTMANAGER}
  sHintEditor,
{$ENDIF}
{$IFNDEF ALITE}
  sToolEdit, sComboBoxes, sBitBtn, sLabel, sStrEdit, acShellCtrls, acRootEdit, acPathDialog, sFrameBar,
  sMemo, acAlphaHintsEdit, acNotebook, acAlphaHints, acImage, acSlider, sColorDialog, sGradBuilder,
{$ENDIF}
  sCommonData, sDefaults, sSkinManager, sMaskData, sSkinProps, sStoreUtils, sInternalSkins, sSpeedButton, sStyleSimply,
  sGradient, acAlphaImageList, sImgListEditor, ac3rdPartyEditor, acSkinInfo, acTitleBar, sSkinProvider;


const
  sectName = 'DesignOptions';
  optionName = 'SkinsDirectory';


var
  FFileName: string = '';

function FileName: string;
begin
  if FFileName = '' then
    FFileName := NormalDir(GetAppPath) + 'AlphaCfg.ini';

  Result := FFileName;
end;


{$IFNDEF ALITE}
procedure TsPageControlEditor.ExecuteVerb(Index: Integer);
var
  NewPage: TsTabSheet;
begin
  case Index of
    0: begin
      NewPage := TsTabSheet.Create(Designer.GetRoot);
      NewPage.Parent := Component as TsPageControl;
      NewPage.PageControl := Component as TsPageControl;
      NewPage.Caption := Designer.UniqueName('sTabSheet');
      NewPage.Name := NewPage.Caption;
    end;

    1: begin
      NewPage := TsTabSheet((Component as TsPageControl).ActivePage);
      NewPage.Free;
    end;

    2:
      (Component as TsPageControl).SelectNextPage(True);

    3:
      (Component as TsPageControl).SelectNextPage(False);
  end;
  if Designer <> nil then
    Designer.Modified;
end;


function TsPageControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'New Page';
    1: Result := 'Delete Page';
    2: Result := 'Next Page';
    3: Result := 'Previous Page';
  end;
end;


function TsPageControlEditor.GetVerbCount: Integer;
begin
  result := 4;
end;
{$ENDIF}


procedure Register;
begin
  RegisterComponentEditor(TsTitleBar, TacTitleBarEditor);
{$IFNDEF ALITE}
  RegisterComponentEditor(TsPageControl, TsPageControlEditor);
  RegisterComponentEditor(TsTabSheet,    TsTabSheetEditor);
  RegisterComponentEditor(TsFrameBar,    TsFrameBarEditor);
  RegisterComponentEditor(TsAlphaHints,  TacAlphaHintsEditor);
{$IFNDEF BCB}
//  RegisterPropertyEditor(TypeInfo(TStrings), TsNotebook, 'Pages', TPageListProperty);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'TabSkin', TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'HeaderSkin', TsSkinSectionProperty);
{$ENDIF}
  RegisterComponentEditor(TsAlphaImageList, TsImageListEditor);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'MenuLineSkin', TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'IcoLineSkin',  TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'SkinSection',  TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'TitleSkin',    TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'ButtonSkin',   TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'CaptionSkin',  TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'CloseBtnSkin', TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'TabsLineSkin', TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'ProgressSkin', TsSkinSectionProperty);
  RegisterPropertyEditor(TypeInfo(TsSkinName),     TsSkinManager,  'SkinName',      TsSkinNameProperty);
  RegisterPropertyEditor(TypeInfo(TsDirectory),    TsSkinManager,  'SkinDirectory', TsDirProperty);
  RegisterPropertyEditor(TypeInfo(TsStoredSkins),  TsSkinManager,  'InternalSkins', TsInternalSkinsProperty);
  RegisterPropertyEditor(TypeInfo(ThirdPartyList), TsSkinManager,  'ThirdParty',    TacThirdPartyProperty);
  RegisterPropertyEditor(TypeInfo(ThirdPartyList), TsSkinProvider, 'ThirdParty',    TacThirdPartyProperty);
  RegisterPropertyEditor(TypeInfo(TacSkinInfo),    TsSkinManager,  'SkinInfo',      TacSkinInfoProperty);


  RegisterPropertyEditor(TypeInfo(TsImgListItems), TsAlphaImageList, 'Items', TacImgListItemsProperty);
  RegisterComponentEditor(TsSkinManager, TacSkinManagerEditor);

  RegisterPropertyEditor(TypeInfo(Integer), TacTitleBarItem, 'ImageIndex',         TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TacTitleBarItem, 'HotImageIndex',      TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TacTitleBarItem, 'PressedImageIndex',  TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TacTitleBarItem, 'DisabledImageIndex', TacImageIndexEditor);
{$IFNDEF ALITE}
  RegisterPropertyEditor(TypeInfo(Integer), TsSlider, 'GlyphIndexOff', TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSlider, 'GlyphIndexOn',  TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSlider, 'ImageIndexOff', TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSlider, 'ImageIndexOn',  TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSlider, 'ThumbIndexOff', TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSlider, 'ThumbIndexOn',  TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsImage,  'ImageIndex',    TacImageIndexEditor);

  RegisterPropertyEditor(TypeInfo(Integer), TsSpeedButton, 'ImageIndex',         TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSpeedButton, 'ImageIndexHot',      TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSpeedButton, 'ImageIndexPressed',  TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSpeedButton, 'ImageIndexDisabled', TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(Integer), TsSpeedButton, 'ImageIndexSelected', TacImageIndexEditor);

  RegisterPropertyEditor(TypeInfo(Integer), TsBitBtn,              'ImageIndex',   TacImageIndexEditor);
  RegisterPropertyEditor(TypeInfo(TacStrValue), TsAlphaHints,      'TemplateName', TacTemplateNameProperty);
  RegisterPropertyEditor(TypeInfo(TacHintTemplates), TsAlphaHints, 'Templates',    TacHintsTemplatesProperty);
{$IFNDEF TNTUNICODE}
  RegisterPropertyEditor(TypeInfo(TCaption), TObject,    'Caption', TsHintProperty);
  RegisterPropertyEditor(TypeInfo(string), TMenuItem,    'Caption', TsHintProperty);
  RegisterPropertyEditor(TypeInfo(String), TsMemo,       'Text',    TsHintProperty);
  RegisterPropertyEditor(TypeInfo(string), TObject,      'Hint',    TsHintProperty);
  RegisterPropertyEditor(TypeInfo(string), TsBoundLabel, 'Caption', TsHintProperty);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(TsSkinSection), TObject, 'SelectionSkin', TsSkinSectionProperty);

{$IFDEF USEFILTEDIT}
  RegisterPropertyEditor(TypeInfo(string), TsFileNameEdit, 'Filter', TFilterProperty);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(string), TacGradPaintData, 'CustomGradient', TsGradientProperty);
  // Shell ctrls
  RegisterPropertyEditor(TypeInfo(TacRoot), TsShellListView, 'Root', TacRootProperty);
  RegisterPropertyEditor(TypeInfo(TacRoot), TsShellTreeView, 'Root', TacRootProperty);
  RegisterPropertyEditor(TypeInfo(TacRoot), TsShellComboBox, 'Root', TacRootProperty);
  RegisterPropertyEditor(TypeInfo(TacRoot), TsPathDialog,    'Root', TacRootProperty);
  RegisterPropertyEditor(TypeInfo(TacRoot), TsDirectoryEdit, 'Root', TacRootProperty);
  RegisterComponentEditor(TsPathDialog, TsPathDlgEditor);
{$ENDIF}
end;


function TsSkinNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paAutoUpdate];
end;


procedure TsSkinNameProperty.GetValues(Proc: TGetStrProc);
var
  i, DosCode: Integer;
  FileInfo: TSearchRec;
  s, sDir: string;
begin
  // Internal skins names loading
  if TsSkinManager(GetComponent(0)).InternalSkins.Count > 0 then
    for i := 0 to TsSkinManager(GetComponent(0)).InternalSkins.Count - 1 do
      Proc(TsSkinManager(GetComponent(0)).InternalSkins[i].Name);

  // External skins names loading
  sDir := TsSkinManager(GetComponent(0)).GetFullskinDirectory;
  if DirectoryExists(sDir) then begin
    s := sDir + '\*.*';
    DosCode := FindFirst(s, faDirectory, FileInfo);
    try
      while DosCode = 0 do begin
        if (FileInfo.Name[1] <> s_Dot) then
          if (FileInfo.Attr and faDirectory = faDirectory) then begin
            if FileExists(sDir + FileInfo.Name + s_Slash + OptionsDatName) then
              Proc(FileInfo.Name); // If 'Options.dat' file exists
          end
          else
            if (FileInfo.Attr and faDirectory <> faDirectory) and (ExtractFileExt(FileInfo.Name) = s_Dot + acSkinExt) then begin
              s := FileInfo.Name;
              Delete(s, pos(s_Dot + acSkinExt, LowerCase(s)), 4);
//              s := ExtractWord(1, FileInfo.Name, [s_Dot]);
              Proc(s);
            end;

        DosCode := FindNext(FileInfo);
      end;
    finally
      FindClose(FileInfo);
    end;
  end;
end;


function TsDirProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paAutoUpdate];
end;


procedure TsDirProperty.Edit;
var
  s: string;
begin
  s := TsSkinManager(GetComponent(0)).SkinDirectory;
  if not directoryExists(s) then
    s := 'C:\';
    
{$IFNDEF ALITE}
  {if TsSkinManager(GetComponent(0)).SkinData.Active then }
  begin
    PathDialogForm := TPathDialogForm.Create(Application);
    try
      PathDialogForm.sShellTreeView1.Path := s;
      if PathDialogForm.ShowModal = mrOk then begin
        s := PathDialogForm.sShellTreeView1.Path;
        if (s <> '') and DirectoryExists(s) then
          TsSkinManager(GetComponent(0)).SkinDirectory := s;
      end;
    finally
      FreeAndNil(PathDialogForm);
    end;
  end;
{$ELSE}
  if SelectDirectory('', '', s) then begin
    if (s <> '') and DirectoryExists(s) then
      TsSkinManager(GetComponent(0)).SkinDirectory := s;
  end;
{$ENDIF}
end;


function TsDirProperty.GetValue: string;
var
  s: string;
begin
  Result := inherited GetValue;
  if Result = DefSkinsDir then begin
    s := sStoreUtils.ReadRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath);
//    s := sStoreUtils.ReadRegString(sectName, optionName, fileName);
    if (s <> '') and DirectoryExists(s) then begin
      Result := s;
      TsSkinManager(GetComponent(0)).SkinDirectory := s;
    end;
  end;
end;


procedure TsDirProperty.SetValue(const Value: string);
begin
  inherited;
//  sStoreUtils.WriteIniStr(sectName, optionName, Value, fileName);
  sStoreUtils.WriteRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath, Value);
end;


procedure TsInternalSkinsProperty.Edit;
var
  i: integer;
begin
  Application.CreateForm(TFormInternalSkins, FormInternalSkins);
  FormInternalSkins.ListBox1.Clear;
  FormInternalSkins.SkinManager := TsSkinManager(GetComponent(0));
  for i := 0 to FormInternalSkins.SkinManager.InternalSkins.Count - 1 do
    FormInternalSkins.ListBox1.Items.Add(FormInternalSkins.SkinManager.InternalSkins.Items[i].Name);

  if (FormInternalSkins.ShowModal = mrOk) and (Designer <> nil) then
    Designer.Modified;

//  sStoreUtils.WriteIniStr(sectName, optionName, FormInternalSkins.SkinManager.SkinDirectory, fileName);
  sStoreUtils.WriteRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath, FormInternalSkins.SkinManager.SkinDirectory);
  if Assigned(FormInternalSkins) then
    FreeAndNil(FormInternalSkins);

  inherited;
end;


function TsInternalSkinsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paAutoUpdate, paReadOnly];
end;


procedure TacSkinManagerEditor.ExecuteVerb(Index: Integer);
var
  i: integer;
  sm: TsSkinManager;
begin
  case Index of
    0: begin
      sm := TsSkinManager(Component);
      Application.CreateForm(TFormInternalSkins, FormInternalSkins);
      FormInternalSkins.ListBox1.Clear;
      FormInternalSkins.SkinManager := sm;
      for i := 0 to sm.InternalSkins.Count - 1 do
        FormInternalSkins.ListBox1.Items.Add(sm.InternalSkins.Items[i].Name);

      FormInternalSkins.ShowModal;
//      sStoreUtils.WriteIniStr(sectName, optionName, FormInternalSkins.SkinManager.SkinDirectory, fileName);
      sStoreUtils.WriteRegString(HKEY_CURRENT_USER, 'SOFTWARE\' + s_RegName, s_IntSkinsPath, FormInternalSkins.SkinManager.SkinDirectory);
      if Assigned(FormInternalSkins) then
        FreeAndNil(FormInternalSkins);

      if Designer <> nil then
        Designer.Modified;
    end;

    1: begin
      Application.CreateForm(TForm3rdPartyEditor, Form3rdPartyEditor);
      Form3rdPartyEditor.Cmp := Component;

      if Component is TsSkinManager then
        Form3rdPartyEditor.Lists := TsSkinManager(Component).ThirdLists
      else
        Form3rdPartyEditor.Lists := TsSkinProvider(Component).ThirdLists;

      Form3rdPartyEditor.sListView1.Items.Clear;
      Form3rdPartyEditor.Populate;
      Form3rdPartyEditor.ShowModal;

      for i := 0 to Length(Form3rdPartyEditor.Lists) - 1 do
        TsSkinManager(Component).ThirdLists[i].Text := Form3rdPartyEditor.Lists[i].Text;

      UpdateThirdNames(TsSkinManager(Component));

      if Assigned(Form3rdPartyEditor) then
        FreeAndNil(Form3rdPartyEditor);

      if Designer <> nil then
        Designer.Modified;

      inherited;
    end;
  end;
  inherited;
end;


function TacSkinManagerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Internal skins...';
    1: Result := '&Third party controls...';
    2: Result := CharMinus;
  end;
end;


function TacSkinManagerEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;


{$IFNDEF ALITE}
procedure TsTabSheetEditor.ExecuteVerb(Index: Integer);
var
  NewPage: TsTabSheet;
begin
  case Index of
    0: begin
      NewPage := TsTabSheet.Create(Designer.GetRoot);
      NewPage.Parent := TsTabSheet(Component).PageControl;
      NewPage.PageControl := TsTabSheet(Component).PageControl;
      NewPage.Caption := Designer.UniqueName('sTabSheet');
      NewPage.Name := NewPage.Caption;
    end;

    1: begin
      NewPage := TsTabSheet(TsTabSheet(Component).PageControl.ActivePage);
      NewPage.Free;
    end;

    2:
      TsTabSheet(Component).PageControl.SelectNextPage(True);

    3:
      TsTabSheet(Component).PageControl.SelectNextPage(False);
  end;
  if Designer <> nil then
    Designer.Modified;
end;


function TsTabSheetEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'New Page';
    1: Result := 'Delete Page';
    2: Result := 'Next Page';
    3: Result := 'Previous Page';
  end;
end;


function TsTabSheetEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;


procedure TsHintProperty.Edit;
var
  Temp: string;
  Comp: TPersistent;
  sed: TStrEditDlg;
begin
  sed := TStrEditDlg.Create(Application);
  with sed do try
    Comp := GetComponent(0);
    if Comp is TComponent then
      Caption := TComponent(Comp).Name + s_Dot + GetName
    else
      Caption := GetName;

    Temp := GetStrValue;
    Memo.Text := Temp;
{$IFNDEF TNTUNICODE}
    Memo.MaxLength := GetEditLimit;
{$ENDIF}
    UpdateStatus(nil);
    if ShowModal = mrOk then begin
      Temp := Memo.Text;
      while (Length(Temp) > 0) and (Temp[Length(Temp)] < s_Space) do
        System.Delete(Temp, Length(Temp), 1);

      SetStrValue(Temp);
      if Designer <> nil then
        Designer.Modified;
    end;
  finally
    Free;
  end;
end;


function TsHintProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog, paAutoUpdate];
end;


function TsHintProperty.GetEditLimit: Integer;
begin
  if GetPropType^.Kind = tkString then
    Result := GetTypeData(GetPropType)^.MaxLength
  else
    Result := 1024;
end;


procedure TsPathDlgEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  TsPathDialog(Component).Execute;
end;


function TsPathDlgEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Test dialog...';
    1: Result := CharMinus;
  end;
end;


function TsPathDlgEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;


procedure TsFrameBarEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  ShowCollectionEditor(Designer, Component, (Component as TsFrameBar).Items, 'Items');
end;


function TsFrameBarEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Items editor...';
  end;
end;


function TsFrameBarEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


procedure TacHintsTemplatesProperty.Edit;
begin
  if EditHints(TsAlphaHints(GetComponent(0))) and (Designer <> nil) then
    Designer.Modified;

  inherited;
end;


function TacHintsTemplatesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paAutoUpdate, paReadOnly];
end;


procedure TacAlphaHintsEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
      if EditHints(TsAlphaHints(Component)) and (Designer <> nil) then
        Designer.Modified;
  end;
end;


function TacAlphaHintsEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Hints templates editor...';
  end;
end;


function TacAlphaHintsEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


function TacTemplateNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;


procedure TacTemplateNameProperty.GetValues(Proc: TGetStrProc);
var
  i: integer;
begin
  inherited;
  for i := 0 to TsAlphaHints(GetComponent(0)).Templates.Count - 1 do
    Proc(TsAlphaHints(GetComponent(0)).Templates[i].Name);
end;


procedure TsGradientProperty.Edit;
var
  GradArray: TsGradArray;
  PaintData: TObject;
begin
  PaintData := GetComponent(0);
  if (PaintData is TacGradPaintData) then
    with TacGradPaintData(PaintData) do begin
      CreateEditorForm(ColDlg);
      PrepareGradArray(CustomGradient, GradArray);
      GradBuilder.LoadFromArray(GradArray);
      GradBuilder.ShowModal;
      case GradBuilder.ModalResult of
        mrOk:   CustomGradient := GradBuilder.AsString;
        mrNone: CustomGradient := '';
      end;
      KillForm;
    end;
end;


function TsGradientProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];//, paFullWidthName];
end;
{$ENDIF}


function TsSkinSectionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paAutoUpdate, paMultiSelect];
end;


procedure TsSkinSectionProperty.GetValues(Proc: TGetStrProc);
var
  i: integer;
begin
  inherited;
  if Assigned(DefaultManager) and (Length(DefaultManager.gd) > 0) then
    for i := 0 to Length(DefaultManager.gd) - 1 do
      if DefaultManager.gd[i].ClassName <> s_GlobalInfo then
        Proc(DefaultManager.gd[i].ClassName);
end;


function TacImageIndexEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;


function TacImageIndexEditor.GetMyList: TCustomImageList;
var
  Obj: TObject;
begin
  Obj := GetComponent(0);
{$IFDEF DELPHI6UP}
  if Obj is TCollectionItem then // Search a component if property owner is TCollectionItem
    Obj := TCollectionItem(Obj).Collection.Owner;
{$ENDIF}
  Result := TCustomImageList(GetObjectProp(Obj, 'Images', TObject));
end;


procedure TacImageIndexEditor.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  MyList: TCustomImageList;
begin
  MyList := GetMyList;
  if Assigned(MyList) then
    for i := 0 to MyList.Count-1 do
      Proc(IntToStr(i));
end;


procedure TacImageIndexEditor.ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  MyLeft: Integer;
  MyList: TCustomImageList;
begin
  ACanvas.FillRect(ARect);
  MyList := GetMyList;
  MyLeft := ARect.Left + 2;
  if Assigned(MyList) then begin
    MyList.Draw(ACanvas,MyLeft, ARect.Top + 2, StrToInt(Value));
    Inc(MyLeft, MyList.Width);
  end;
  ACanvas.TextOut(MyLeft + 2, ARect.Top + 1,Value);
end;


procedure TacImageIndexEditor.ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);
var
  MyList: TCustomImageList;
begin
  MyList := GetMyList;
  AHeight := ACanvas.TextHeight(Value) + 2;
  if Assigned(MyList) and (MyList.Height + 4 > AHeight) then
    AHeight := MyList.Height + 4;
end;


procedure TacImageIndexEditor.ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);
var
  MyList: TCustomImageList;
begin
  MyList := GetMyList;
  AWidth := ACanvas.TextWidth(Value) + 4;
  if Assigned(MyList) then
    Inc(AWidth, MyList.Width);
end;


procedure TacThirdPartyProperty.Edit;
var
  i: integer;
begin
  Application.CreateForm(TForm3rdPartyEditor, Form3rdPartyEditor);
  Form3rdPartyEditor.Cmp := TComponent(GetComponent(0));
  if Form3rdPartyEditor.Cmp is TsSkinManager then
    Form3rdPartyEditor.Lists := TsSkinManager(Form3rdPartyEditor.Cmp).ThirdLists
  else
    Form3rdPartyEditor.Lists := TsSkinProvider(Form3rdPartyEditor.Cmp).ThirdLists;

  Form3rdPartyEditor.sListView1.Items.Clear;
  Form3rdPartyEditor.Populate;
  Form3rdPartyEditor.ShowModal;

  if Form3rdPartyEditor.Cmp is TsSkinManager then begin
    for i := 0 to Length(Form3rdPartyEditor.Lists) - 1 do
      TsSkinManager(Form3rdPartyEditor.Cmp).ThirdLists[i].Text := Form3rdPartyEditor.Lists[i].Text;

    UpdateThirdNames(TsSkinManager(Form3rdPartyEditor.Cmp));
  end
  else begin
    for i := 0 to Length(Form3rdPartyEditor.Lists) - 1 do
      TsSkinProvider(Form3rdPartyEditor.Cmp).ThirdLists[i].Text := Form3rdPartyEditor.Lists[i].Text;

    UpdateProviderThirdNames(TsSkinProvider(Form3rdPartyEditor.Cmp));
  end;

  if Assigned(Form3rdPartyEditor) then
    FreeAndNil(Form3rdPartyEditor);

  if Designer <> nil then
    Designer.Modified;

  inherited;
end;


function TacThirdPartyProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paAutoUpdate, paReadOnly];
end;


procedure TacImgListItemsProperty.Edit;
var
  Form: TFormImgListEditor;
begin
  Application.CreateForm(TFormImgListEditor, Form);
  Form.InitFromImgList(TsAlphaImageList(GetComponent(0)));
  Form.ShowModal;
  FreeAndNil(Form);
  if Designer <> nil then
    Designer.Modified;
end;


function TacImgListItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;


procedure TacSkinInfoProperty.Edit;
begin
  with TsSkinManager(GetComponent(0)) do
    if CommonSkinData.Active then begin
      SkinInfoForm := TSkinInfoForm.Create(Application);
      SkinInfoForm.sMemo1.Lines.Add('Name: '        + SkinName);
      SkinInfoForm.sMemo1.Lines.Add('Version: '     + SkinInfo);
      SkinInfoForm.sMemo1.Lines.Add('Author: '      + CommonSkinData.Author);
      SkinInfoForm.sMemo1.Lines.Add('Description: ' + CommonSkinData.Description);
      if CommonSkinData.Version < CompatibleSkinVersion then
        SkinInfoForm.Label1.Visible := True;

      try
        SkinInfoForm.ShowModal;
      finally
        FreeAndNil(SkinInfoForm);
      end;
    end
    else
      MessageDlg('Skins are not activated.', mtInformation, [mbOK], 0);
end;


function TacSkinInfoProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly, {$IFDEF DELPHI_XE}{paDisplayReadOnly, }{$ENDIF}paFullWidthName];
end;


procedure TsImageListEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: begin
      Application.CreateForm(TFormImgListEditor, FormImgListEditor);
      FormImgListEditor.InitFromImgList(Component as TsAlphaImageList);
      FormImgListEditor.ShowModal;
      FreeAndNil(FormImgListEditor);
    end;
  end;
  if Designer <> nil then
    Designer.Modified;
end;


function TsImageListEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&ImageList editor...';
  end;
end;


function TsImageListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


procedure TacTitleBarEditor.ExecuteVerb(Index: Integer);
begin
  ShowCollectionEditorClass(Designer, TCollectionEditor,
    TsTitleBar(Component), TsTitleBar(Component).Items, 'Items', [coAdd, coDelete, coMove]);

  inherited;
end;


function TacTitleBarEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := '&Title bar items...';
    1: Result := CharMinus;
  end;
end;


function TacTitleBarEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.



