unit uRoomerLanguage;

interface

uses
    System.SysUtils
  , DateUtils
  , System.Classes
  , System.Generics.Collections
  , System.Zip
  , System.IoUtils
  , Winapi.Windows
  , Winapi.ShlObj
  , cmpRoomerDataset
  , vcl.Forms
  , vcl.Dialogs
  , vcl.Menus
  , vcl.Buttons
  , vcl.Controls
  , Vcl.ActnList
  , VCLTee.Chart
  , stdCtrls
  , comCtrls
  , extCtrls
  , uStringUtils

  , sButton
  , sCheckBox
  , sTreeView
  , sPageControl
  , sTabControl
  , sGroupBox
  , sLabel
  , sPanel
  , sComboBox
  , sSpeedButton
  , sCheckListBox
  , CheckLst
  , sRadioButton

  , cxButtons
  , dxBar
  , cxDropdownEdit
  , cxGridDBTableView
  , cxGridBandedTableView
  , cxGridDBBandedTableView
  , cxDBPivotGrid
  , dxRibbon
  , cxGrid
  , dxDockPanel

  , ppCtrls
  , AdvEdBtn
  ;

type

  TDictionaryItem = class
  private
    FTemporaryValue: Boolean;
    FKey : String;
    FValue: String;
  public
    constructor Create(value, key : String; temporaryValue : boolean);
    property Value : String read FValue write FValue;
    property Key : String read FKey write FKey;
    property TemporaryValue : Boolean read FTemporaryValue write FTemporaryValue;
  end;

  TDictionaryItemDictionary = TObjectDictionary<String,TDictionaryItem>;
  TLanguageDictionary = class
  private
    FLangId : Integer;
    FLangCode : String;
    FDictionary : TDictionaryItemDictionary;
    function GetKeyDictionaryItem(key : String): TDictionaryItem;
  public
    constructor Create;
    destructor Destroy; override;

    procedure FillLanguageFromDataset(RSet : TRoomerDataSet;
                                      LanguageCode : String;
                                      LangIdFieldName : String = 'id';
                                      LangCodeFieldName : String = 'code';
                                      FormTypeFieldName : String = 'formType';
                                      ComponentNameFieldName : String = 'compName';
                                      extraIdentityFieldName : String = 'extraIdentity';
                                      TextFieldName : String = 'text'
                                      );

    procedure AddKeyAndValue(key, Value: String; temporaryValue : Boolean = false);
    function GetKeyValue(key : String; defaultValue : String = '') : String;
    procedure Clear;
    property LangId : Integer read FLangId;
    property LangCode : String read FLangCode;
    property Dictionary : TDictionaryItemDictionary read FDictionary;
  end;

  TRoomerLanguageItem = class
  private
    FActive: Boolean;
    FLocalName: String;
    FId: Integer;
    FCultureId: String;
    FEnglishName: String;
    FDefault: Boolean;
  public
    constructor Create(id : Integer; active: Boolean; cultureId, englishName, localName : String; _default : Boolean);
    property id : Integer read FId;
    property Active : Boolean read FActive;
    property CultureId : String read FCultureId;
    property EnglishName : String read FEnglishName;
    property LocalName : String read FLocalName;
    property _Default : Boolean read FDefault;
  end;

  TLanguageObjectDictionary = TObjectDictionary<String,TLanguageDictionary>;
  TLanguageItemList = TObjectList<TRoomerLanguageItem>;

  TRoomerLanguage = class(TComponent)
  private
    FRSet: TRoomerDataSet;
    FLanguageCode: String;
    FLanguageId: Integer;
    FLangIds : TLanguageItemList;
    FPerformDBUpdatesWhenUnknownEntitiesFound: Boolean;
    procedure SetLanguageCode(const Value: String);
    procedure Clear;
    procedure CreateDictionaries;

    function FindLanguage(var languageId: Integer): TRoomerLanguageItem;
    function GetLanguage(index: Integer): TRoomerLanguageItem;
    function GetLanguageCount: Integer;
    function GetLanguageById(id: Integer): TRoomerLanguageItem;
    procedure CheckHintComponentName(comp: TControl; hint: String);
    function AddNameOfComponentToHintIfNeeded(comp: TComponent): String;

    function LanguageExistsLocallyOrNeedsRefresh(languageId: Integer): Boolean;

    procedure TranslateThis(comp: TComponent; key : String); overload;
    procedure TranslateThis(comp: TsButton; key: String); overload;
    procedure TranslateThis(comp: TsTreeView; key: String); overload;
    procedure TranslateThis(comp: TcxButton; key: String); overload;
    procedure TranslateThis(comp: TForm; key: String); overload;
    procedure TranslateThis(comp: TdxBarLargeButton; key: String); overload;
    procedure TranslateThis(comp: TdxBarButton; key: String); overload;
    procedure TranslateThis(comp: TdxRibbontab; key: String); overload;
    procedure TranslateThis(comp: TsTabSheet; key: String); overload;
    procedure TranslateThis(comp: TButton; key: String); overload;
    procedure TranslateThis(comp: TTabSheet; key: String); overload;
    procedure TranslateThis(comp: TsRadioGroup; key: String); overload;
    procedure TranslateThis(comp: TRadioGroup; key: String); overload;
    procedure TranslateThis(comp: TRadioButton; key: String); overload;
    procedure TranslateThis(comp: TsRadioButton; key: String); overload;
    procedure TranslateThis(comp: TdxBarSubItem; key: String); overload;
    procedure TranslateThis(comp: TMenuItem; key: String); overload;
    procedure TranslateThis(comp: TAction; key: String); overload;
    procedure TranslateThis(comp: TdxDockPanel; key: String); overload;
    procedure TranslateThis(comp: TsLabel; key: String); overload;
    procedure TranslateThis(comp: TLabel; key: String); overload;
    procedure TranslateThis(comp: TCheckBox; key: String); overload;
    procedure TranslateThis(comp: TsCheckBox; key: String); overload;
    procedure TranslateThis(comp: TppLabel; key: String); overload;
    procedure TranslateThis(comp: TPanel; key: String); overload;
    procedure TranslateThis(comp: TsPanel; key: String); overload;
    procedure TranslateThis(comp: TGroupBox; key: String); overload;
    procedure TranslateThis(comp: TsGroupBox; key: String); overload;
    procedure TranslateThis(comp: TsLabelFx; key: String); overload;
    procedure TranslateThis(comp: TdxBar; key: String); overload;
    procedure TranslateThis(comp: TComboBox; key: String); overload;
    procedure TranslateThis(comp: TsComboBox; key: String); overload;
    procedure TranslateThis(comp: TcxComboBox; key: String); overload;
    procedure TranslateThis(comp: TSpeedButton; key: String); overload;
    procedure TranslateThis(comp: TsSpeedButton; key: String); overload;
    procedure TranslateThis(comp: TAdvEditBtn; key: String); overload;
    procedure TranslateThis(comp: TcxGridDBColumn; key: String); overload;
    procedure TranslateThis(comp: TcxGrid; key: String); overload;
//    procedure TranslateThis(comp : TcxDBPivotGrid; key : String); overload;
    procedure TranslateThis(comp: TcxGridDBBandedColumn; key: String); overload;
    procedure TranslateThis(comp: TcxDBPivotGridField; key: String); overload;
    procedure TranslateThis(comp: TsTabControl; key: String); overload;
    procedure TranslateThis(comp: TdxBarCombo; key: String); overload;
    procedure TranslateThis(comp: TsCheckListBox; key: String); overload;
    procedure TranslateThis(comp: TCheckListBox; key: String); overload;
    procedure TranslateThis(comp: TChart; key: String); overload;
    procedure TranslateThis(comp: TcxGridDBBandedTableView; key: String); overload;

    procedure LoadFromStream(stream: TStream);
    procedure SaveToStream(stream: TStream);
    function GetLanguageFilename: String;
    procedure PrepareLanguageItem(languageId: integer);
    procedure SetSystemConstants;
    procedure RemoveDictionaries;
    { Private declarations }
  protected
    { Protected declarations }
    FLanguages : TLanguageObjectDictionary;
    ExecutionPlan : TRoomerExecutionPlan;
    CurrentCollection : TStringList;
    LanguageCollectionActive : Boolean;
    LastAccessKey : String;

    function GetTranslationOfSpecifiedKey(Key : String; defaultValue : String) : String; overload;
    function GetTranslationOfSpecifiedKey(SourceUnit, Key : String; defaultValue : String) : String; overload;
  public
    { Public declarations }
    ShowComponentNameOnHint : Boolean;
    {$IFDEF EXTRADEBUG}
      WrongIdCollection : TStringList;
    {$ENDIF}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadLanguage(forceRefresh : Boolean = False);

    procedure LoadFromZip(const AFileName: string);
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToZip(const AFileName: string);
    procedure SaveToFile(const AFileName: string);

    procedure PrepareLanguages(RoomerDataset : TRoomerDataSet);
    procedure PrepareDictionaries(languageId : integer; forceRefresh : Boolean = False);
    procedure TranslateThisForm(FormToTranslate : TForm);
    procedure TranslateThisControl(FormToTranslate: TForm; ControlToTranslate: TControl);
    function TranslateSpecifiedKey(Key : String; defaultValue : String) : String;
    function GetTranslatedText(nameOfConstant: String): String;

    procedure ActivateDBLanguageCollection;
    procedure SubmitDBLanguageCollection;
    procedure DeactivateDBLanguageCollection;

    property LanguageCode : String read FLanguageCode write SetLanguageCode;
    procedure SetLanguageId(const Value: Integer; AccessKey : String);

    property LanguageId : Integer read FLanguageId;
    property Language[index : Integer] : TRoomerLanguageItem read GetLanguage;
    property LanguageById[id : Integer] : TRoomerLanguageItem read GetLanguageById;
    property LanguageCount : Integer read GetLanguageCount;

    property PerformDBUpdatesWhenUnknownEntitiesFound : Boolean read FPerformDBUpdatesWhenUnknownEntitiesFound write FPerformDBUpdatesWhenUnknownEntitiesFound;
  published
    { Published declarations }
  end;


var RoomerLanguageActivated : Boolean;
    RoomerLanguageCreated : Boolean;

    RoomerLanguage : TRoomerLanguage;

    constants : TDictionary<String, String>;

procedure Register;

implementation

uses uFormCreateHook, uFileSystemUtils;

resourcestring
  RoomerLanguageFileName = 'RoomerLanguage_%s(%d).src';

procedure Register;
begin
  RegisterComponents('Roomer', [TRoomerLanguage]);
end;

CONST KEY_MASK = '%s.%s.%s';
      NOT_FOUND_TEXT = '-*/:\*-';

{ TLanguageDictionary }

procedure TLanguageDictionary.Clear;
begin
  FDictionary.Clear;
end;

constructor TLanguageDictionary.Create;
begin
  FDictionary := TDictionaryItemDictionary.Create([doOwnsValues]);
  FLangId := -1;
  FLangCode := '---';
end;

destructor TLanguageDictionary.Destroy;
begin
  FDictionary.Clear;
  try FreeAndNil(FDictionary); Except end;
  inherited;
end;

procedure TLanguageDictionary.FillLanguageFromDataset(RSet: TRoomerDataSet;
            LanguageCode,
            LangIdFieldName,
            LangCodeFieldName,
            FormTypeFieldName,
            ComponentNameFieldName,
            extraIdentityFieldName,
            TextFieldName: String);
begin
  FLangCode := LanguageCode;
  RSet.First;
  while NOT RSet.Eof do
  begin
    if LowerCase(RSet[LangCodeFieldName]) = Lowercase(LanguageCode) then
    begin
      if FLangId = -1 then
        FLangId := RSet[LangIdFieldName];
      AddKeyAndValue(format(KEY_MASK, [RSet[FormTypeFieldName], RSet[ComponentNameFieldName], RSet[extraIdentityFieldName]]),
                     RSet[TextFieldName]);
    end;
    RSet.Next;
  end;
end;

procedure TLanguageDictionary.AddKeyAndValue(key, Value: String; temporaryValue : Boolean = false);
begin
  FDictionary.Add(LowerCase(key), TDictionaryItem.Create(value, key, temporaryValue));
end;

function TLanguageDictionary.GetKeyValue(key: String; defaultValue : String = ''): String;
var res : TDictionaryItem;
begin
  if FDictionary.TryGetValue(LowerCase(key), res) then
    result := res.FValue
  else
    result := defaultValue;
end;

function TLanguageDictionary.GetKeyDictionaryItem(key: String): TDictionaryItem;
begin
  if NOT FDictionary.TryGetValue(LowerCase(key), result) then
    result := nil;
end;

{ TRoomerLanguage }

constructor TRoomerLanguage.Create(AOwner: TComponent);
begin
  inherited;  {$IFDEF DEBUG}
  ShowComponentNameOnHint := Lowercase(ParameterByName('ShowComponentNameOnHint')) = 'true';
    {$IFDEF EXTRADEBUG}
      WrongIdCollection := TStringList.Create;
      WrongIdCollection.Duplicates := dupIgnore;
      if FileExists(ChangeFileExt(Application.ExeName, '.lang.txt')) then
         WrongIdCollection.LoadFromFile(ChangeFileExt(Application.ExeName, '.lang.txt'));
    {$ENDIF}
  {$ENDIF}
  LastAccessKey := '';
  ExecutionPlan := nil;
  CurrentCollection := nil;
  LanguageCollectionActive := false;
  FPerformDBUpdatesWhenUnknownEntitiesFound := false;
  CreateDictionaries;
  RoomerLanguage := self;
end;

destructor TRoomerLanguage.Destroy;
begin
  Clear;
  KillFormCreateHook;
  {$IFDEF DEBUG}
    {$IFDEF EXTRADEBUG}
      WrongIdCollection.Free;
    {$ENDIF}
  {$ENDIF}
  inherited;
end;

procedure TRoomerLanguage.ActivateDBLanguageCollection;
begin
  if FPerformDBUpdatesWhenUnknownEntitiesFound then
  begin
    ExecutionPlan := FRSet.CreateExecutionPlan;
    CurrentCollection := TStringList.Create;
  end;

  LanguageCollectionActive := True;
end;

procedure TRoomerLanguage.Clear;
begin
  RoomerLanguageActivated := False;
  RemoveDictionaries;
end;


procedure TRoomerLanguage.CreateDictionaries;
begin
  FLanguages := TLanguageObjectDictionary.Create([doOwnsValues]);
  FLangIds := TLanguageItemList.Create(True); // owns objects!
end;

procedure TRoomerLanguage.RemoveDictionaries;
begin
  FLanguages.Clear;
  FLanguages.Free;
  FLangIds.Clear;
  FLangIds.Free;
end;

function TRoomerLanguage.GetTranslationOfSpecifiedKey(Key: String; defaultValue : String): String;
var Dictionary : TLanguageDictionary;
    TempItem : TDictionaryItem;
    list : TStrings;
    i: Integer;

begin
  if NOT FLanguages.TryGetValue(FLanguageCode, Dictionary) then
    result := defaultValue
  else
  begin
    TempItem := Dictionary.GetKeyDictionaryItem(key);
    {$IFDEF EXTRADEBUG}
      WrongIdCollection.Add(key + ' = ' + defaultValue);
    {$ENDIF}
    if (TempItem = nil) OR
       (LanguageCollectionActive AND
        FPerformDBUpdatesWhenUnknownEntitiesFound AND
        TempItem.TemporaryValue) then
    begin
      if (TempItem = nil) then
      begin
        Dictionary.AddKeyAndValue(key, defaultValue, True);
        TempItem := Dictionary.GetKeyDictionaryItem(key);
      end;
      if LanguageCollectionActive AND FPerformDBUpdatesWhenUnknownEntitiesFound then
      begin
        TempItem.TemporaryValue := False;
        list := SplitStringToTStrings('.', key);
        try
          if CurrentCollection.IndexOf(key) = -1 then
          begin
            CurrentCollection.Add(key);
            for i := 0 to FLangIds.Count - 1 do
            begin
              ExecutionPlan.AddExec(
                  format('INSERT INTO home100.dictionary ' +
                         '(languageId, ' +
                         'formType, ' +
                         'compName, ' +
                         'extraIdentity, ' +
                         ' text) ' +
                         'VALUES ' +
                         '( ' +
                         '%d, ' +
                         '''%s'', ' +
                         '''%s'', ' +
                         '''%s'', ' +
                         '%s ' +
                         ') ',
                         [
                           FLangIds[i].id,
                           list[0],
                           list[1],
                           list[2],
                           _dbString(defaultValue)
                         ]));
            end;
          end;
        finally
          list.Free;
        end;
      end;
    end;
    result := TempItem.Value;
  end;
end;

function TRoomerLanguage.GetLanguage(index: Integer): TRoomerLanguageItem;
begin
  result := FLangIds[index];
end;

function TRoomerLanguage.GetLanguageById(id: Integer): TRoomerLanguageItem;
begin
  result := FindLanguage(id);
end;

function TRoomerLanguage.GetLanguageCount: Integer;
begin
  result := FLangIds.Count;
end;

function TRoomerLanguage.GetTranslationOfSpecifiedKey(SourceUnit, Key: String; defaultValue : String): String;
begin
  result := GetTranslationOfSpecifiedKey(format(KEY_MASK, [SourceUnit, Key, '']), defaultValue);
end;

procedure TRoomerLanguage.PrepareLanguageItem(languageId : integer);
var LangItem : TRoomerLanguageItem;
begin
  LangItem := FindLanguage(languageId);
  if LangItem = nil then
  begin
    languageId := -1;
    LangItem := FindLanguage(languageId);
    if LangItem = nil then
    begin
      if LanguageCount > 0 then
      begin
        languageId := FLangIds[0].id;
        LangItem := FindLanguage(languageId);
        LanguageCode := LangItem.CultureId;
      end else
        LanguageCode := 'en-US';
    end;
  end else
    try LanguageCode := LangItem.CultureId; except end;
end;

procedure TRoomerLanguage.PrepareDictionaries(languageId : integer; forceRefresh : Boolean = False);
var lDictionary : TLanguageDictionary;
    RSetDictionary: TRoomerDataSet;
begin
  PrepareLanguageItem(LanguageId);

  if forceRefresh then
  begin
    lDictionary := TLanguageDictionary.Create;

    RSetDictionary := FRSet.ActivateNewDataset(FRSet.SystemGetDictionary(LanguageId));
    try
      lDictionary.FillLanguageFromDataset(RSetDictionary, LanguageCode);
      FLanguages.AddOrSetValue(LanguageCode, lDictionary); // replaces previous TLanguageDictionary object which will be freed automatically
    finally
      FreeAndNil(RSetDictionary);
    end;
  end else
  if (NOT FLanguages.TryGetValue(LanguageCode, lDictionary)) then
  begin
    RSetDictionary := FRSet.ActivateNewDataset(FRSet.SystemGetDictionary(LanguageId));
    try
      lDictionary := TLanguageDictionary.Create;
      lDictionary.FillLanguageFromDataset(RSetDictionary, LanguageCode);
      FLanguages.Add(LanguageCode, lDictionary)
    finally
      FreeAndNil(RSetDictionary);
    end;
  end;

  RoomerLanguageActivated := True;
end;

function TRoomerLanguage.FindLanguage(var languageId : Integer) : TRoomerLanguageItem;
var i : integer;
begin
  result := nil;
  if languageId < 1 then
    for i := 0 to FLangIds.Count - 1 do
      if FLangIds[i]._default then
      begin
         languageId := FLangIds[i].id;
         break;
      end;
  if languageId = -1 then
    exit;

  for i := 0 to FLangIds.Count - 1 do
    if FLangIds[i].id = languageId then
    begin
       result := FLangIds[i];
       break;
    end;
end;


function TRoomerLanguage.LanguageExistsLocallyOrNeedsRefresh(languageId : Integer) : Boolean;
var filename : String;
    fileDate : TDateTime;
begin
  filename := GetLanguageFilename;
  result := FileExists(filename);
  if result then
  begin
    FileAge(filename, FileDate);
    if now - fileDate > 2 then
    begin
      result := False;
      DeleteFile(PWideChar(filename));
    end;
  end;

end;


procedure TRoomerLanguage.LoadFromZip(const AFileName: string);
var
  stream: TStream;
  localHeader: TZipHeader;
  zipFile: TZipFile;
begin
  zipFile := TZipFile.Create;
  try
    zipFIle.Open(AFIleName, zmRead);
    zipFile.Read('language', stream, localHeader);
    try
      LoadFromStream(stream);
    finally
      stream.Free;
    end;
    zipFile.Close;
  finally
    zipFile.Free;
  end;
end;

procedure TRoomerLanguage.SaveToZip(const AFileName: string);
var
  stream: TStream;
  zipFile: TZipFile;
begin
  stream := TMemoryStream.Create;
  try
    SaveToStream(stream);
    stream.Position := 0;
    zipFile := TZipFile.Create;
    try
      zipFile.Open(AFileName, zmWrite);
      zipFile.Add(stream, 'language');
      zipFile.Close;
    finally
      zipFile.Free;
    end;
  finally
    stream.Free;
  end;
end;

procedure TRoomerLanguage.SaveToStream(stream: TStream);
var
  i: Integer;
  Key, Value : String;
  Keys : TArray<String>;
  writer: TStreamWriter;
  Dictionary : TLanguageDictionary;
  TempItem : TDictionaryItem;
begin
  if FLanguages.TryGetValue(FLanguageCode, Dictionary) then
  begin
    writer := TStreamWriter.Create(stream, TEncoding.UTF8);
    try
      Keys := Dictionary.Dictionary.Keys.ToArray;
      for i := LOW(Keys) to HIGH(Keys) do
      begin
        Key := Keys[i];
        TempItem := Dictionary.GetKeyDictionaryItem(key);
        if NOT TempItem.TemporaryValue then
        begin
          Value := TempItem.Value;
          writer.Write(TempItem.Key + '=' + StringReplace(StringReplace(Value, #10, '_chr10_', [rfReplaceAll]), #13, '_chr13_', [rfReplaceAll])); writer.WriteLine;
        end;
      end;
    finally
      writer.Free;
    end;
  end;
end;

procedure TRoomerLanguage.LoadFromStream(stream: TStream);
var
  i: Integer;
  Key, Value: string;
  reader: TStreamReader;
  Dictionary : TLanguageDictionary;
begin
  IF NOT FLanguages.TryGetValue(FLanguageCode, Dictionary) then
  begin
    Dictionary := TLanguageDictionary.Create;
    Dictionary.FLangId := FLanguageId;
    Dictionary.FLangCode := FLanguageCode;
    FLanguages.Add(LanguageCode, Dictionary);

    reader := TStreamReader.Create(stream, TEncoding.UTF8);
    try
      while NOT reader.EndOfStream do
      begin
        Key := reader.ReadLine;
        i := pos('=', Key);
        Value := copy(Key, i + 1, maxInt);
        Key := copy(Key, 1, i - 1);
        Value := StringReplace(StringReplace(Value, '_chr10_', #10, [rfReplaceAll]), '_chr13_', #13, [rfReplaceAll]);
        Dictionary.AddKeyAndValue(Key, Value, False);
      end;
    finally
      reader.Free;
    end;
  end;
end;

procedure TRoomerLanguage.LoadFromFile(const AFileName: string);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(stream);
  finally
    stream.Free;
  end;
end;

procedure TRoomerLanguage.SaveToFile(const AFileName: string);
var
  stream: TStream;
begin
  stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(stream);
  finally
    stream.Free;
  end;
end;


function TRoomerLanguage.GetLanguageFilename : String;
var sPath : String;
begin
  sPath := TPath.Combine(LocalAppDataPath, 'Roomer');
  sPath := TPath.Combine(sPath, 'Languages');
  forceDirectories(sPath);

  result := TPath.Combine(sPath, format(RoomerLanguageFileName, [FLanguageCode, FLanguageId]));
end;

procedure TRoomerLanguage.LoadLanguage(forceRefresh : Boolean = False);
begin
  if NOT LanguageExistsLocallyOrNeedsRefresh(FLanguageId) then
  begin
    PrepareDictionaries(FLanguageId, forceRefresh);
    SaveToFile(GetLanguageFilename);
  end;
  LoadFromFile(GetLanguageFilename);
  RoomerLanguageActivated := True;
end;

procedure TRoomerLanguage.PrepareLanguages(RoomerDataset: TRoomerDataSet);
var
    RSetLanguages: TRoomerDataset;
begin

  if FLangIds.Count > 0 then
    exit;

  Clear;
  CreateDictionaries;

  FRSet := RoomerDataset;
  KillFormCreateHook;
  InitFormCreateHook;

  RSetLanguages := RoomerDataset.ActivateNewDataset(RoomerDataset.SystemGetLanguages);
  try
    RSetLanguages.First;
    while NOT RSetLanguages.EOF do
    begin
      FLangIds.Add(TRoomerLanguageItem.Create(RSetLanguages['id'],
                          RSetLanguages['Active'],
                          RSetLanguages['languageCode'],
                          RSetLanguages['LanguageNameEnglish'],
                          RSetLanguages['LanguageNameNative'],
                          RSetLanguages['default']));
      RSetLanguages.Next;
    end;
  except
  end;
  FreeAndNil(RSetLanguages);
end;

procedure TRoomerLanguage.SetLanguageCode(const Value: String);
begin
  FLanguageCode := Value;
end;

procedure TRoomerLanguage.SetLanguageId(const Value: Integer; AccessKey : String);
begin
  if AccessKey = LastAccessKey then
    exit;

  LastAccessKey := AccessKey;
  FLanguageId := Value;
  PrepareLanguageItem(FLanguageId);
  LoadLanguage;
  SetSystemConstants;
end;

const PRE_KEY_NAME = 'PrjConst.Constants.';

      SYS_MONTHS_LONG = 'shSystem_Months_Long_';
      SYS_MONTHS_SHORT = 'shSystem_Months_Short_';

      SYS_DAYS_LONG = 'shSystem_Days_Long_';
      SYS_DAYS_SHORT = 'shSystem_Days_Short_';

      SYS_DATE_FORMAT_LONG = 'shSystem_Date_Format_Long';
      SYS_DATE_FORMAT_SHORT = 'shSystem_Date_Format_Short';

      SYS_DATE_SEPARATOR = 'shSystem_Date_Separator';
      SYS_TIME_SEPARATOR = 'shSystem_Time_Separator';
procedure TRoomerLanguage.SetSystemConstants;
var i : Integer;
begin
  for i := 1 to 12 do
  begin
    FormatSettings.LongMonthNames[i] := GetTranslatedText(SYS_MONTHS_LONG + inttostr(i));
    FormatSettings.ShortMonthNames[i] := GetTranslatedText(SYS_MONTHS_SHORT + inttostr(i));
  end;

  for i := 1 to 7 do
  begin
    FormatSettings.LongDayNames[i] := GetTranslatedText(SYS_DAYS_LONG + inttostr(i));
    FormatSettings.ShortDayNames[i] := GetTranslatedText(SYS_DAYS_SHORT + inttostr(i));
  end;

  FormatSettings.LongDateFormat := GetTranslatedText(SYS_DATE_FORMAT_LONG);
  FormatSettings.ShortDateFormat := GetTranslatedText(SYS_DATE_FORMAT_SHORT);

  try
  FormatSettings.DateSeparator := GetTranslatedText(SYS_DATE_SEPARATOR)[1];
  FormatSettings.TimeSeparator := GetTranslatedText(SYS_TIME_SEPARATOR)[1];
  except

  end;
end;

function TRoomerLanguage.GetTranslatedText(nameOfConstant : String) : String;
var key, value : String;
begin
  if constants.TryGetValue(nameOfConstant, value) then
  begin
    key := PRE_KEY_NAME + nameOfConstant;
    result := RoomerLanguage.TranslateSpecifiedKey(key, value)
  end else
{$IFDEF TRANSLATION_EXCEPTIONS_ACTIVE}
    raise Exception.Create(format('Constant %s was not found in the translation dictionary', [nameOfConstant]));
{$ELSE}
    result :=  '';
{$ENDIF}
end;


procedure TRoomerLanguage.SubmitDBLanguageCollection;
begin
  if FPerformDBUpdatesWhenUnknownEntitiesFound AND
     LanguageCollectionActive AND
     (ExecutionPlan.ExecCount > 0) then
  begin
    try
    ExecutionPlan.Execute(ptExec, false, false);
    except end;
    ExecutionPlan.Clear;
  end;
end;

procedure TRoomerLanguage.DeactivateDBLanguageCollection;
begin
//  if LanguageCollectionActive AND FPerformDBUpdatesWhenUnknownEntitiesFound then
//  begin
    ExecutionPlan.Free;
    CurrentCollection.Free;
//  end;
  ExecutionPlan := nil;
  CurrentCollection := nil;
  LanguageCollectionActive := false;
end;

procedure TRoomerLanguage.TranslateThisForm(FormToTranslate: TForm);
var i : Integer;
    formTypeName : String;
begin
  if NOT RoomerLanguageActivated then exit;

  ActivateDBLanguageCollection;
  try
    try
      formTypeName := GetWindowClassName(FormToTranslate.Handle);
      TranslateThis(FormToTranslate,
                    format(KEY_MASK, [formTypeName, 'Form', '']));
      for i := 0 to FormToTranslate.ComponentCount - 1 do
      begin
        TranslateThis(FormToTranslate.Components[i],
                      format(KEY_MASK, [formTypeName, FormToTranslate.Components[i].Name, '']));
      end;

      SubmitDBLanguageCollection;
    except
      // Hmmm....
    end;
  finally
    DeactivateDBLanguageCollection;
  end;
end;

procedure TRoomerLanguage.TranslateThisControl(FormToTranslate: TForm; ControlToTranslate: TControl);
var formTypeName : String;
begin
  if NOT RoomerLanguageActivated then exit;

  formTypeName := GetWindowClassName(FormToTranslate.Handle);
  TranslateThis(ControlToTranslate,
                format(KEY_MASK, [formTypeName, ControlToTranslate.Name, '']));
end;

procedure TRoomerLanguage.TranslateThis(comp : TComponent; key : String);
begin
  if Copy(comp.Name, 1, 2) = '__' then // Skip Components starting with __
    exit;


///////////////////////////////// Alphaskins
  if comp is TsRadioButton then
    TranslateThis(comp AS TsRadioButton, key)
  else
  if comp is TsRadioGroup then
    TranslateThis(comp AS TsRadioGroup, key)
  else
  if comp is TsComboBox then
    TranslateThis(comp AS TsComboBox, key)
  else
  if comp is TsChecklistBox then
    TranslateThis(comp AS TsChecklistBox, key)
  else
  if comp is TsGroupBox then
    TranslateThis(comp AS TsGroupBox, key)
  else
  if comp is TsPanel then
    TranslateThis(comp AS TsPanel, key)
  else
  if comp is TsCheckBox then
    TranslateThis(comp AS TsCheckBox, key)
  else
  if comp is TsButton then
    TranslateThis(comp AS TsButton, key)
  else
  if comp is TsTreeView then
    TranslateThis(comp AS TsTreeView, key)
  else
  if comp is TsSpeedButton then
    TranslateThis(comp AS TsSpeedButton, key)
  else
  if comp is TsLabel then
    TranslateThis(comp AS TsLabel, key)
  else
  if comp is TdxDockPanel then
    TranslateThis(comp AS TdxDockPanel, key)
  else
  if comp is TsLabelFx then
    TranslateThis(comp AS TsLabelFx, key)
  else
  if comp is TsTabSheet then
    TranslateThis(comp AS TsTabSheet, key)
  else
  if comp is TsTabControl then
    TranslateThis(comp AS TsTabControl, key)
  else

///////////////////////////////// Dev Express
  if comp is TcxComboBox then
    TranslateThis(comp AS TcxComboBox, key)
  else
  if comp is TdxBarCombo then
    TranslateThis(comp AS TdxBarCombo, key)
  else
  if comp is TcxButton then
    TranslateThis(comp AS TcxButton, key)
  else
  if comp is TcxGridDBColumn then
    TranslateThis(comp AS TcxGridDBColumn, key)
  else
  if comp is TcxGridDBBandedColumn then
    TranslateThis(comp AS TcxGridDBBandedColumn, key)
  else
  if comp is TcxGrid then
    TranslateThis(comp AS TcxGrid, key)
  else
  if comp is TcxDBPivotGridField then
    TranslateThis(comp AS TcxDBPivotGridField, key)
  else
  if comp is TdxBarLargeButton then
    TranslateThis(comp AS TdxBarLargeButton, key)
  else
  if comp is TdxBarButton then
    TranslateThis(comp AS TdxBarButton, key)
  else
  if comp is TdxRibbonTab then
    TranslateThis(comp AS TdxRibbonTab, key)
  else
  if comp is TdxBarSubItem then
    TranslateThis(comp AS TdxBarSubItem, key)
  else
  if comp is TdxBar then
    TranslateThis(comp AS TdxBar, key)
  else
  if comp is TcxGridDBBandedTableView then
    TranslateThis(comp AS TcxGridDBBandedTableView, key)
  else

///////////////////////////////// Delphi
  if comp is TRadioButton then
    TranslateThis(comp AS TRadioButton, key)
  else
  if comp is TRadioGroup then
    TranslateThis(comp AS TRadioGroup, key)
  else
  if comp is TComboBox then
    TranslateThis(comp AS TComboBox, key)
  else
  if comp is TChecklistBox then
    TranslateThis(comp AS TChecklistBox, key)
  else
  if comp is TGroupBox then
    TranslateThis(comp AS TGroupBox, key)
  else
  if comp is TPanel then
    TranslateThis(comp AS TPanel, key)
  else
  if comp is TCheckBox then
    TranslateThis(comp AS TCheckBox, key)
  else
  if comp is TAction then
    TranslateThis(comp as TAction, key)
  else
  if comp is TMenuItem then
    TranslateThis(comp AS TMenuItem, key)
  else
  if comp is TButton then
    TranslateThis(comp AS TButton, key)
  else
  if comp is TSpeedButton then
    TranslateThis(comp AS TSpeedButton, key)
  else
  if comp is TLabel then
    TranslateThis(comp AS TLabel, key)
  else
  if comp is TTabSheet then
    TranslateThis(comp AS TTabSheet, key)
  else
  if comp is TRadioGroup then
    TranslateThis(comp AS TRadioGroup, key)
  else
  if comp is TChart then
    TranslateThis(comp AS TChart, key)
  else

/////////////////////////////////  Reports
  if comp is TppLabel then
    TranslateThis(comp AS TppLabel, key)
  else

/////////////////////////////////  Other
  if comp is TAdvEditBtn then
    TranslateThis(comp AS TAdvEditBtn, key)

end;

// ******************************************************************************************

function TRoomerLanguage.AddNameOfComponentToHintIfNeeded(comp : TComponent) : String;
begin
  if ShowComponentNameOnHint then
    result := comp.Name + #13#13
  else
    result := '';
end;

procedure TRoomerLanguage.CheckHintComponentName(comp : TControl; hint : String);
var
  ClassName: array[0..259] of Char;
  ControlAsWinControl : TWinControl;
begin
  if ShowComponentNameOnHint then
  begin
    if comp IS TWinControl then
    begin
      ControlAsWinControl := comp AS TWinControl;
      GetClassName(ControlAsWinControl.Handle, ClassName, Length(ClassName));
    end;
    if (comp IS TWinControl) AND (Lowercase(copy(ClassName, 1, 3)) = 'tdx') then
      comp.Hint := format('%s' + #13#13, [comp.Name]) + Hint
    else
      comp.Hint := format('<b>%s</b><br><br>', [comp.Name]) + Hint;
  end else
    comp.Hint := Hint;
end;

///////////////////////////////// Delphi
procedure TRoomerLanguage.TranslateThis(comp : TGroupBox; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TComboBox; key : String);
var i, l : integer;
begin
  l := comp.ItemIndex;
  for i := 0 to comp.Items.Count - 1 do
    comp.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Items[i]);
  comp.Text := GetTranslationOfSpecifiedKey(key + 'Text', comp.Text);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  comp.ItemIndex := l;
end;

procedure TRoomerLanguage.TranslateThis(comp : TsCheckListBox; key : String);
var i, l : integer;
begin
  l := comp.ItemIndex;
  for i := 0 to comp.Items.Count - 1 do
    comp.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Items[i]);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  comp.ItemIndex := l;
end;

procedure TRoomerLanguage.TranslateThis(comp : TCheckListBox; key : String);
var i, l : integer;
begin
  l := comp.ItemIndex;
  for i := 0 to comp.Items.Count - 1 do
    comp.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Items[i]);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  comp.ItemIndex := l;
end;

procedure TRoomerLanguage.TranslateThis(comp : TPanel; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TCheckBox; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TButton; key : String);
begin
  if comp.Action = nil then
  begin
    comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
    CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  end;
end;

procedure TRoomerLanguage.TranslateThis(comp : TSpeedButton; key : String);
begin
  if comp.Action = nil then
  begin
    comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
    CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  end;
end;

procedure TRoomerLanguage.TranslateThis(comp : TLabel; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TMenuItem; key : String);
begin
  if comp.Action = nil then
  begin
    comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
    comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
  end;
end;

procedure TRoomerLanguage.TranslateThis(comp : TAction; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
end;

procedure TRoomerLanguage.TranslateThis(comp : TRadioGroup; key : String);
var i : integer;
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  for i := 0 to comp.Items.Count - 1 do
    comp.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Items[i]);
end;

procedure TRoomerLanguage.TranslateThis(comp : TTabSheet; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;


///////////////////////////////// AlphaSkins

procedure TRoomerLanguage.TranslateThis(comp : TsGroupBox; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TsComboBox; key : String);
var i, l : integer;
begin
  l := comp.ItemIndex;
  for i := 0 to comp.Items.Count - 1 do
    comp.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Items[i]);
  comp.Text := GetTranslationOfSpecifiedKey(key + 'Text', comp.Text);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  comp.ItemIndex := l;
end;

procedure TRoomerLanguage.TranslateThis(comp : TsCheckBox; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TsPanel; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TsRadioGroup; key : String);
var i : integer;
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  for i := 0 to comp.Items.Count - 1 do
    comp.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Items[i]);
end;

procedure TRoomerLanguage.TranslateThis(comp : TsButton; key : String);
begin
  if comp.Action = nil then
  begin
    comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
    CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  end;
end;

procedure TRoomerLanguage.TranslateThis(comp : TsTreeView; key : String);
var
  Node : TTreeNode;
begin
  for Node in comp.Items do
    Node.Text := GetTranslationOfSpecifiedKey(key + 'ItemsSelectIndex' + inttostr(Node.SelectedIndex), Node.Text);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TChart; key : String);
begin
  comp.Title.Text.Text := GetTranslationOfSpecifiedKey(key + 'Title-Text', comp.Title.Text.Text);
  comp.Foot.Text.Text := GetTranslationOfSpecifiedKey(key + 'Foot-Text', comp.Foot.Text.Text);
  comp.SubTitle.Text.Text := GetTranslationOfSpecifiedKey(key + 'SubTitle-Text', comp.SubTitle.Text.Text);
  comp.SubFoot.Text.Text := GetTranslationOfSpecifiedKey(key + 'SubFoot-Text', comp.SubFoot.Text.Text);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TsSpeedButton; key : String);
begin
  if comp.Action = nil then
  begin
    comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
    CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  end;
end;

procedure TRoomerLanguage.TranslateThis(comp : TsLabel; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TdxDockPanel; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TsLabelFx; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TsTabSheet; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;

procedure TRoomerLanguage.TranslateThis(comp : TsTabControl; key : String);
var i : integer;
begin
  for i := 0 to comp.Tabs.Count - 1 do
    comp.Tabs[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Tabs[i]);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
end;


///////////////////////////////// Dev Express

procedure TRoomerLanguage.TranslateThis(comp : TcxComboBox; key : String);
var i, l : integer;
begin
  l := comp.ItemIndex;
  for i := 0 to comp.Properties.Items.Count - 1 do
    comp.Properties.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Properties.Items[i]);
  CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  comp.ItemIndex := l;
end;

procedure TRoomerLanguage.TranslateThis(comp : TcxButton; key : String);
begin
  if comp.Action = nil then
  begin
    comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
    CheckHintComponentName(comp, GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint));
  end;
end;

procedure TRoomerLanguage.TranslateThis(comp : TcxGridDBColumn; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
end;

procedure TRoomerLanguage.TranslateThis(comp : TcxGrid; key : String);
var i, l : integer;
    tv : TcxGridDBBandedTableView;
begin
  for i := 0 to comp.ComponentCount - 1 do
    if comp.Components[i] IS TcxGridDBBandedTableView then
    begin
      tv := (comp.Components[i] AS TcxGridDBBandedTableView);
      for l := 0 to tv.Bands.Count - 1 do
        tv.Bands[l].Caption := GetTranslationOfSpecifiedKey(key + 'TVBandItems' + inttostr(l), tv.Bands[l].Caption);
    end;
end;

//procedure TRoomerLanguage.TranslateThis(comp : TcxDBPivotGrid; key : String);
//var i, l : integer;
//    tv : TcxGridDBBandedTableView;
//begin
//  try
//    for i := 0 to comp.ComponentCount - 1 do
//      if comp.Components[i] IS TcxGridDBBandedTableView then
//      begin
//        tv := (comp.Components[i] AS TcxGridDBBandedTableView);
//        for l := 0 to tv.Bands.Count - 1 do
//          tv.Bands[l].Caption := GetTranslationOfSpecifiedKey(key + 'TVBandItems' + inttostr(l), tv.Bands[l].Caption);
//      end;
//  except
//
//  end;
//end;

procedure TRoomerLanguage.TranslateThis(comp : TcxGridDBBandedColumn; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
end;


procedure TRoomerLanguage.TranslateThis(comp : TcxDBPivotGridField; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
end;

procedure TRoomerLanguage.TranslateThis(comp: TdxRibbontab; key: String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
end;

procedure TRoomerLanguage.TranslateThis(comp : TdxBarLargeButton; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
end;

procedure TRoomerLanguage.TranslateThis(comp : TdxBarButton; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
end;

procedure TRoomerLanguage.TranslateThis(comp : TdxBarCombo; key : String);
var i, l, l1 : integer;
begin
  l := comp.ItemIndex;
  l1 := comp.CurItemIndex;
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
  for i := 0 to comp.Items.Count - 1 do
    comp.Items[i] := GetTranslationOfSpecifiedKey(key + 'Items' + inttostr(i), comp.Items[i]);
  comp.ItemIndex := l;
  comp.CurItemIndex := l1;
end;

procedure TRoomerLanguage.TranslateThis(comp : TcxGridDBBandedTableView; key : String);
var i : Integer;
begin
  for i := 0 to comp.Bands.Count - 1 do
    comp.Bands[i].Caption := GetTranslationOfSpecifiedKey(key + 'Bands' + inttostr(i), comp.Bands[i].Caption);
end;

procedure TRoomerLanguage.TranslateThis(comp: TRadioButton; key: String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
end;

procedure TRoomerLanguage.TranslateThis(comp: TsRadioButton; key: String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
end;

procedure TRoomerLanguage.TranslateThis(comp : TdxBarSubItem; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := AddNameOfComponentToHintIfNeeded(comp) + GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
end;

procedure TRoomerLanguage.TranslateThis(comp : TdxBar; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
end;


///////////////////////////////// Reports
procedure TRoomerLanguage.TranslateThis(comp : TppLabel; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
end;

///////////////////////////////// Other
function TRoomerLanguage.TranslateSpecifiedKey(Key, defaultValue: String): String;
begin
  result := GetTranslationOfSpecifiedKey(Key, defaultValue);
end;

procedure TRoomerLanguage.TranslateThis(comp : TAdvEditBtn; key : String);
var i : Integer;
begin
  comp.EmptyText := GetTranslationOfSpecifiedKey(key + 'EmptyText', comp.EmptyText);
  comp.ButtonCaption := GetTranslationOfSpecifiedKey(key + 'ButtonCaption', comp.ButtonCaption);
  comp.ButtonHint := GetTranslationOfSpecifiedKey(key + 'ButtonHint', comp.ButtonHint);
  comp.LabelCaption := GetTranslationOfSpecifiedKey(key + 'LabelCaption', comp.LabelCaption);
  for i := 0 to comp.Lookup.ValueList.Count - 1 do
    comp.Lookup.ValueList[i] := GetTranslationOfSpecifiedKey(key + 'ValueListItems' + inttostr(i), comp.Lookup.ValueList[i]);
end;

//////////////////////////////// TForm

procedure TRoomerLanguage.TranslateThis(comp : TForm; key : String);
begin
  comp.Caption := GetTranslationOfSpecifiedKey(key + 'Caption', comp.Caption);
  comp.Hint := GetTranslationOfSpecifiedKey(key + 'Hint', comp.Hint);
end;


{ TRoomerLanguageItem }

constructor TRoomerLanguageItem.Create(id: Integer; active: Boolean; cultureId, englishName, localName: String; _default : Boolean);
begin
  FActive := Active;
  FId := id;
  FCultureId := CultureId;
  FEnglishName := EnglishName;
  FLocalName := LocalName;
  FDefault := _default;
end;

function ParameterByName(name: String): String;
var
  i, iNameLength: Integer;
  param: String;
begin
  Result := '';
  for i := 1 to ParamCount do
  begin
    iNameLength := length(name) + 1;
    param := ParamStr(i);
    if Lowercase(copy(param, 1, iNameLength)) = Lowercase(name) + '=' then
    begin
      Result := copy(param, iNameLength + 1, length(param));
    end;
  end;
end;


{ TDictionaryItem }

constructor TDictionaryItem.Create(value, key: String; temporaryValue: boolean);
begin
  FValue := value;
  FKey := key;
  FTemporaryValue := temporaryValue;
end;

initialization

  RoomerLanguageActivated := False;
  RoomerLanguageCreated := False;
  RoomerLanguage := TRoomerLanguage.Create(nil);
  RoomerLanguageCreated := True;
  RoomerLanguage.PerformDBUpdatesWhenUnknownEntitiesFound := Lowercase(ParameterByName('LanguageUpdateOn')) = 'true';

finalization
  RoomerLanguageCreated := False;

  {$IFDEF EXTRADEBUG}
  if RoomerLanguage.WrongIdCollection.Count > 0 then
  begin
    RoomerLanguage.WrongIdCollection.SaveToFile(ChangeFileExt(Application.ExeName, '.lang.txt'));
//    CopyToClipboard(RoomerLanguage.WrongIdCollection.Text);
    MessageDLG(inttostr(RoomerLanguage.WrongIdCollection.Count) + ' items where not found in the translation dioctionary.' + #13#13 +
               'The list has been copied to the clipboard and save to file:' + #13#13 +
               ChangeFileExt(Application.ExeName, '.lang.txt'),

               mtWarning,
               [mbOK],
               0);
  end;
  {$ENDIF}
  RoomerLanguage.Free;

end.
