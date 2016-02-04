unit uExcelProcessors;

interface

uses System.SysUtils, System.Types, System.Generics.Collections, Vcl.Graphics, cxsSheet, cxSSTypes, cxSSUtils,
     System.Classes, System.Variants, System.Generics.Defaults, Vcl.Controls
    ;

type

  TProcessorType = (ptRateChanges, ptAvailabilityChanges);

  TOccEntity = class
    ADate : TDate;
    TopClass : String;
    Occ : Integer;
  public
    constructor Create(_Date : TDate; _TopClass : String; _Occ : Integer);
  end;

  TTopClassEntity = class
    TopClass : String;
    ARooms : Integer;
  public
    constructor Create(_TopClass : String; _Rooms : Integer);
  end;

  TDateRange = class
    StartDate : TDate;
    EndDate : TDate;
  public
    constructor Create(_StartDate, _EndDate : TDate);
  end;

  TDateEntity = class
    ADate : TDate;
    ARate : Variant;
    AToHotel : Variant;
    StopSell : Boolean;
    CTA : Boolean;
    MLOS : Integer;
  public
    constructor Create(_Date : TDate; _Rate, _ToHotel : Variant; _StopSell, _CTA : Boolean; _MLOS : Integer);
  end;

  TClassEntity = class
    ClassCode : String;
    ValueList : TObjectList<TDateEntity>;
  public
    constructor Create(_ClassCode : String);
    destructor Destroy;
    procedure AddValue(_Date : TDate; _Rate, _ToHotel : Variant; _StopSell, _CTA : Boolean; _MLOS : Integer);
  end;

  TChannelEntity = class
    ChannelCode : String;
    ChannelName : String;
    Header : String;

    Classes : TObjectList<TClassEntity>;
  private
    function ClassEntityIndex(_ClassCode: String): Integer;
  public
    constructor Create(_ChannelCode, _ChannelName, _Header : String);
    destructor Destroy;

    function CreateClassEntity(_ClassCode : String) : TClassEntity;
  end;

  TExcelProcessors = class
  private
    HeaderFontColor,
    HeaderCellColor,
    NormalFontColor,
    NormalCellColor : Word;
//
//    RatesToHotelCellColor,
//    RatesToHotelHeaderCellColor,
//    RatesToHotelHeaderFontColor,
//    MedHighCellColor,
//    VeryBusyCellColor : Word;


  private
    Excel: TcxSpreadSheetBook;
    FProcessorType : TProcessorType;
    FTopClassStatuses : TObjectList<TOccEntity>;
    FTopClasses : TDictionary<String, TTopClassEntity>;
    FDateRanges : TObjectList<TDateRange>;
    FChannels : TObjectList<TChannelEntity>;
    FTemplateFile : String;
    procedure CreateRateExcelSheet(filename: String);
    procedure CollectDateRanges;
    procedure SetCellValue(ACol, ARow: integer; AValue: Variant; FontColor, BackColor : Word; Bold : Boolean = False);
    function GetCellColour(const aCol, aRow: integer): integer;
    procedure SetCellColor(ACol, ARow: integer; Color: Word);
    procedure SetCellFontColor(ACol, ARow: integer; Color: Word);
    function GetTotalRooms: Integer;
    function IndexOfChannel(ChannelCode, ChannelName: String): Integer;
    function GetCellFontColor(ACol, ARow: integer) : Word;
    procedure SetAlignment(ACol, ARow: integer; align: TcxHorzTextAlign);
    procedure SetBorders(ACol1, ARow1, ACol2, ARow2: integer);
    procedure SetCellBorders(ALeftCol, ATopRow, ARightCol, ABottomRow: Integer; AEdge: TAlign; AStyle: TcxSSEdgeLineStyle);
    procedure SetGroupBorders(ACol1, ARow1, ACol2, ARow2: integer);
    function GetRoomsOfClass(TheClass: String): Integer;
    function ChannelIndex(_ChannelCode, _ChannelName: String): Integer;
    function GetCellFormat(ACol, ARow: integer): TxlsDataFormat;
    procedure GetCellFontAttributes(ACol, ARow: Integer; var AStyle: TFontStyles; var ASize: Integer);
    procedure SetCellFontAttributes(ALeftCol, ATopRow, ARightCol, ABottomRow: Integer; AStyle: TFontStyles; ASize: Integer);
  public
    constructor Create;
    destructor destroy;

    procedure PrepareRateChanges(_TemplateFile : String);
    procedure PrepareAvailabilityChanges;

    procedure AddTopClass(TopClass : String; NumRooms : Integer);
    procedure AddTopClassStatusPerDay(ADate : TDate; TopClass : String; Occ : Integer);
    function CreateChannelEntity(ChannelCode, ChannelName, Header : String) : TChannelEntity;
//    procedure AddDateAndValue(ADate : TDate; ChannelCode, ChannelName, TopClass, SubClass : String; AValue : Variant);

    procedure ProcessExcelSheet(filename : String);
  end;

const TOP_CLASS_AVAIL_STARTS_AT_COL = 'E';
      TOP_CLASS_AVAIL_STARTS_AT_ROW = 7;

implementation

uses uDateUtils, ug, hData;

{ TExcelProcessors }

function TExcelProcessors.IndexOfChannel(ChannelCode, ChannelName : String) : Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to FChannels.Count - 1 do
    if (FChannels[i].ChannelCode = ChannelCode) AND (FChannels[i].ChannelName = ChannelName) then
    begin
      result := i;
      Break;
    end;
end;

procedure TExcelProcessors.AddTopClass(TopClass: String; NumRooms: Integer);
var TempItem : TTopClassEntity;
begin
  FTopClasses.AddOrSetValue(TopClass, TTopClassEntity.Create(TopClass, NumRooms));
end;

procedure TExcelProcessors.AddTopClassStatusPerDay(ADate: TDate; TopClass: String; Occ: Integer);
begin
  FTopClassStatuses.Add(TOccEntity.Create(ADate, TopClass, Occ));
end;

var
  OccComparison: TComparison<TOccEntity>;
  DatesComparison: TComparison<TDateRange>;
  ClassComparison: TComparison<TClassEntity>;
  DateEntityComparison : TComparison<TDateEntity>;

constructor TExcelProcessors.Create;
begin
  FTopClasses := TDictionary<String, TTopClassEntity>.Create;

  OccComparison :=  function(const Left, Right: TOccEntity): Integer
                    begin
                      result := TComparer<String>.Default.Compare(Left.TopClass + DateToSqlString(Left.ADate), Right.TopClass + DateToSqlString(Right.ADate));
                    end;

  DatesComparison :=  function(const Left, Right: TDateRange): Integer
                    begin
                      result := TComparer<String>.Default.Compare(DateToSqlString(Left.StartDate) + DateToSqlString(Left.EndDate), DateToSqlString(Right.StartDate) + DateToSqlString(Right.EndDate));
                    end;

  ClassComparison :=  function(const Left, Right: TClassEntity): Integer
                    begin
                      try
                        result := TComparer<String>.Default.Compare(Left.ClassCode, Right.ClassCode);
                      except
                        result := -1;
                      end;
                    end;

  DateEntityComparison :=  function(const Left, Right: TDateEntity): Integer
                    begin
                      result := TComparer<String>.Default.Compare(DateToSqlString(Left.ADate), DateToSqlString(Right.ADate));
                    end;

  FTopClassStatuses := TObjectList<TOccEntity>.Create(TComparer<TOccEntity>.Construct(OccComparison));

  FDateRanges := TObjectList<TDateRange>.Create(TComparer<TDateRange>.Construct(DatesComparison));
  FChannels := TObjectList<TChannelEntity>.Create;
end;

function TExcelProcessors.ChannelIndex(_ChannelCode, _ChannelName: String): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to FChannels.Count - 1 do
    if (FChannels[i].ChannelCode = _ChannelCode) AND (FChannels[i].ChannelName = _ChannelName) then
    begin
      result := i;
      Break;
    end;
end;

function TExcelProcessors.CreateChannelEntity(ChannelCode, ChannelName, Header: String): TChannelEntity;
var idx : Integer;
begin
  idx := ChannelIndex(ChannelCode, ChannelName);
  if idx < 0 then
  begin
    result := TChannelEntity.Create(ChannelCode, ChannelName, Header);
    FChannels.Add(result);
  end else
    result := FChannels[idx];
end;

destructor TExcelProcessors.destroy;
begin
  FTopClassStatuses.Clear;
  FreeAndNil(FTopClassStatuses);

  FTopClasses.Clear;
  FreeAndNil(FTopClasses);

  FDateRanges.Clear;
  FreeAndNil(FDateRanges);

  FChannels.Clear;
  FreeAndNil(FChannels);
end;

procedure TExcelProcessors.PrepareAvailabilityChanges;
begin
  FProcessorType := ptAvailabilityChanges;
end;

procedure TExcelProcessors.PrepareRateChanges(_TemplateFile : String);
begin
  FTemplateFile := _TemplateFile;
  FProcessorType := ptRateChanges;
end;

procedure TExcelProcessors.ProcessExcelSheet(filename: String);
begin
  case FProcessorType of
    ptRateChanges: CreateRateExcelSheet(filename);
    ptAvailabilityChanges: ;
  end;
end;

procedure TExcelProcessors.CreateRateExcelSheet(filename : String);
var iStartCol, iStartRow,
    iCol, iRow : Integer;
    i: Integer;
    i1: Integer;
    Rooms : Integer;
    Occ : Integer;
    OccPercentage : Double;

    StartRatesCol : Integer;
    LastRowIndex : Integer;

    DateRows : TDictionary<TDate, Integer>;

    FloatFormat : TxlsDataFormat;
    ATextColor : Word;

    FloatDigits : byte;
     

    function DateRow(ADate : TDate) : Integer;
    begin
      result := 0;
      DateRows.TryGetValue(ADate, result);
    end;

    function GetTotalOccForDate(Date : TDate) : Integer;
    var i : Integer;
    begin
      result := 0;
      for i := 0 to FTopClassStatuses.Count - 1 do
        if FTopClassStatuses[i].ADate = Date then
          result := result + FTopClassStatuses[i].Occ;
    end;

    procedure DisplayStatuses;
    var i : Integer;
        Keys : TArray<String>;
        Key : String;
        TempItem : TTopClassEntity;
        OccPerc : Double;

      procedure DisplayTopClassOcc(TopClass : String; col, Rooms : Integer);
      var i : Integer;
          OccPerc : Double;
          lastDate : TDate;
          row : Integer;
          s : String;
      begin
        lastDate := 0;
        if FTopClassStatuses.Count > 0 then
          lastDate := FTopClassStatuses[0].Adate - 1;

        for i := 0 to FTopClassStatuses.Count - 1 do
          if (FTopClassStatuses[i].TopClass = TopClass) AND (FTopClassStatuses[i].Adate > lastDate) then
          begin
            row := DateRow(FTopClassStatuses[i].ADate);
            SetCellValue(col, row, Rooms - FTopClassStatuses[i].Occ, NormalFontColor, NormalCellColor);
            SetAlignment(Col, row, haCENTER);

//            OccPerc := FTopClassStatuses[i].Occ * 100 / GetRoomsOfClass(FTopClassStatuses[i].TopClass);
//            if OccPerc > 90 then
//              SetCellColor(col, row, VeryBusyCellColor)
//            else
//            if OccPerc > 70 then
//              SetCellColor(col, row, MedHighCellColor)
//            else
//              SetCellColor(col, row, NormalCellColor);

            lastDate := FTopClassStatuses[i].Adate;
          end;
      end;

    var iCol, iRow : Integer;
    begin
      Keys := FTopClasses.Keys.ToArray;
      SetCellValue(iStartCol, TOP_CLASS_AVAIL_STARTS_AT_ROW - 2, 'AVALABILITY', HeaderFontColor, HeaderCellColor, true);
      SetAlignment(iStartCol, TOP_CLASS_AVAIL_STARTS_AT_ROW - 2, haCENTER);
      Excel.ActiveSheet.SetMergedState(Rect(iStartCol,
                                            TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                                            iStartCol + HIGH(Keys),
                                            TOP_CLASS_AVAIL_STARTS_AT_ROW - 2),
                  true);
      SetCellBorders(iStartCol - 1,
                     TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                     iStartCol - 1,
                     LastRowIndex,
                     alRight,
                     lsMedium);
      for i := LOW(Keys) to HIGH(Keys) do
      begin
        Key := Keys[i];
        FTopClasses.TryGetValue(key, TempItem);
        iCol := iStartCol + i;
        iRow := TOP_CLASS_AVAIL_STARTS_AT_ROW;
        SetCellValue(iCol, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, TempItem.TopClass, HeaderFontColor, HeaderCellColor, true);
        SetAlignment(iCol, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);

        DisplayTopClassOcc(TempItem.TopClass, iCol, TempItem.ARooms);
      end;

      StartRatesCol := iStartCol + HIGH(Keys) + 1;
      SetCellBorders(StartRatesCol - 1,
                     TOP_CLASS_AVAIL_STARTS_AT_ROW - 3,
                     StartRatesCol - 1,
                     LastRowIndex,
                     alRight,
                     lsMedium);

      SetCellBorders(iStartCol,
                     TOP_CLASS_AVAIL_STARTS_AT_ROW - 1,
                     iStartCol + HIGH(Keys),
                     TOP_CLASS_AVAIL_STARTS_AT_ROW - 1,
                     alTop,
                     lsMedium);
    end;

    procedure DisplayRates;
    var i, i1, l : Integer;
        iX, ir : Integer;
        s : String;
    begin
      ix := StartRatesCol;
      for i1 := 0 to FChannels.Count - 1 do
      begin
        SetCellValue(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 3, FChannels[i1].ChannelName, HeaderFontColor, HeaderCellColor, true);
        Excel.ActiveSheet.SetMergedState(Rect(ix,
                                              TOP_CLASS_AVAIL_STARTS_AT_ROW - 3,
                                              ix + (3 * FChannels[i1].Classes.Count) - 1,
                                              TOP_CLASS_AVAIL_STARTS_AT_ROW - 3),
                    true);
        SetAlignment(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 3, haCENTER);
        SetCellBorders(ix,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                       ix + (3 * FChannels[i1].Classes.Count) - 1,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                       alTop,
                       lsMedium);
        for i := 0 to FChannels[i1].Classes.Count - 1 do
        begin
          SetCellValue(ix,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                       FChannels[i1].Classes[i].ClassCode,
                       HeaderFontColor,
                       HeaderCellColor, true);
          Excel.ActiveSheet.SetMergedState(Rect(ix,
                                                TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                                                ix + 2,
                                                TOP_CLASS_AVAIL_STARTS_AT_ROW - 2),
                      true);
          SetAlignment(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 2, haCENTER);
          SetCellValue(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, 'RATE', HeaderFontColor, HeaderCellColor, true);
          SetCellValue(ix + 1, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, 'SELL/CTA', HeaderFontColor, HeaderCellColor, true);
          SetCellValue(ix + 2, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, 'MLOS', HeaderFontColor, HeaderCellColor, true);
          SetAlignment(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);
          SetAlignment(ix + 1, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);
          SetAlignment(ix + 2, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);

          if i > 0 then
            SetCellBorders(ix - 1,
                           TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                           ix - 1,
                           LastRowIndex,
                           alRight,
                           lsMedium);

          for l := 0 to FChannels[i1].Classes[i].ValueList.Count - 1 do
          begin
            s := TcxSSUtils.FormatText(FChannels[i1].Classes[i].ValueList[l].ARate, FloatFormat, 2, ATextColor);
            ir := DateRow(FChannels[i1].Classes[i].ValueList[l].ADate);
            SetCellValue(ix, ir, s, 0, 1);

            s := '';
            if FChannels[i1].Classes[i].ValueList[l].StopSell then
              s := 'STOP';
            if FChannels[i1].Classes[i].ValueList[l].CTA then
              s := 'CTA';
            SetCellValue(ix + 1, ir, s, 0, 1);

            s := '';
            if FChannels[i1].Classes[i].ValueList[l].MLOS > 0 then
              s := inttostr(FChannels[i1].Classes[i].ValueList[l].MLOS);
            SetCellValue(ix + 2, ir, s, 0, 1);

            SetAlignment(ix, ir, haCENTER);
            SetAlignment(ix + 1, ir, haCENTER);
            SetAlignment(ix + 2, ir, haCENTER);

          end;
          ix := ix + 3;
        end;

        SetCellBorders(ix - 1,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 3,
                       ix - 1,
                       LastRowIndex,
                       alRight,
                       lsMedium);
      end;

      StartRatesCol := ix + 2;

    end;

    procedure DisplayRatesToHotel;
    var i, i1, l : Integer;
        iX, ir, iStart : Integer;
        s : String;
    begin
      ix := StartRatesCol;
      iStart := ix;
      SetCellBorders(ix - 1,
                     TOP_CLASS_AVAIL_STARTS_AT_ROW - 3,
                     ix - 1,
                     LastRowIndex,
                     alRight,
                     lsMedium);
      for i1 := 0 to FChannels.Count - 1 do
      begin
        SetCellValue(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 3, FChannels[i1].ChannelName, HeaderFontColor, HeaderCellColor, true);
        Excel.ActiveSheet.SetMergedState(Rect(ix,
                                              TOP_CLASS_AVAIL_STARTS_AT_ROW - 3,
                                              ix + FChannels[i1].Classes.Count - 1,
                                              TOP_CLASS_AVAIL_STARTS_AT_ROW - 3),
                    true);
        SetAlignment(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 3, haCENTER);
        SetCellBorders(ix,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                       ix + FChannels[i1].Classes.Count - 1,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                       alTop,
                       lsMedium);
        for i := 0 to FChannels[i1].Classes.Count - 1 do
        begin
          SetCellValue(ix,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 2,
                       FChannels[i1].Classes[i].ClassCode,
                       HeaderFontColor,
                       HeaderCellColor, true);
          SetAlignment(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 2, haCENTER);
          SetCellValue(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, 'RATE', HeaderFontColor, HeaderCellColor, true);
          SetAlignment(ix, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);
          for l := 0 to FChannels[i1].Classes[i].ValueList.Count - 1 do
          begin
            s := TcxSSUtils.FormatText(FChannels[i1].Classes[i].ValueList[l].AToHotel, FloatFormat, 2, ATextColor);
            ir := DateRow(FChannels[i1].Classes[i].ValueList[l].ADate);
            SetCellValue(ix,
                         ir,
                         s, 0, 1);
            SetAlignment(ix, ir, haCENTER);
          end;
          ix := ix + 1;
        end;
        SetCellBorders(ix - 1,
                       TOP_CLASS_AVAIL_STARTS_AT_ROW - 3,
                       ix - 1,
                       LastRowIndex,
                       alRight,
                       lsMedium);
      end;
      Excel.ActiveSheet.SetMergedState(Rect(iStart,
                                            TOP_CLASS_AVAIL_STARTS_AT_ROW - 4,
                                            ix - 1,
                                            TOP_CLASS_AVAIL_STARTS_AT_ROW - 4),
                                       true);
      SetCellValue(iStart, TOP_CLASS_AVAIL_STARTS_AT_ROW - 4, 'NET TO HOTEL', HeaderFontColor, HeaderCellColor, true);
      SetAlignment(iStart, TOP_CLASS_AVAIL_STARTS_AT_ROW - 4, haCENTER);

    end;


var iRowCounter : Integer;
    s : String;
    lastDate : TDate;
begin
  LastRowIndex := 0;
  DateRows := TDictionary<TDate, Integer>.Create;
  CollectDateRanges;
  iStartCol := 4;
  Excel := TcxSpreadSheetBook.Create(nil);
  Excel.LoadFromFile(FTemplateFile);

  HeaderFontColor := GetCellFontColor(0, 6);
  HeaderCellColor := GetCellColour(0, 6);
  NormalFontColor := GetCellFontColor(0, 5);
  NormalCellColor := GetCellColour(0, 5);

  FTopClassStatuses.Sort;
  FDateRanges.Sort;
  for i := 0 to FChannels.Count - 1 do
  begin
    FChannels[i].Classes.Sort;
    for i1 := 0 to FChannels[i].Classes.Count - 1 do
      FChannels[i].Classes[i1].ValueList.Sort;
  end;
//  FChannels : TObjectList<TChannelEntity>;

  iRowCounter := -1;
  FloatFormat := GetCellFormat(7, 5);
  FloatDigits := 8;
  ATextColor := 0;
  Rooms := GetTotalRooms;

  SetCellValue(0, 0, format('%s - %s - %s - %s', [ctrlGetString('CompanyName'), ctrlGetString('Address4'), ctrlGetString('Country'), ctrlGetString('NativeCurrency')]),
      HeaderFontColor, HeaderCellColor, true);

  SetCellValue(0, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, 'DAY', HeaderFontColor, HeaderCellColor, true);
  SetCellValue(1, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, 'MONTH', HeaderFontColor, HeaderCellColor, true);
  SetCellValue(2, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, 'YEAR', HeaderFontColor, HeaderCellColor, true);
  SetAlignment(0, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);
  SetAlignment(1, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);
  SetAlignment(2, TOP_CLASS_AVAIL_STARTS_AT_ROW - 1, haCENTER);


//  SetCellValue(iStartCol, TOP_CLASS_AVAIL_STARTS_AT_ROW + 3, Rooms, HeaderFontColor, HeaderCellColor);
  lastDate := 0;
  if FDateRanges.Count > 0 then
     lastDate := FDateRanges[0].StartDate - 1;
  for i := 0 to FDateRanges.Count - 1 do
  begin
    if i > 0 then
      inc(iRowCounter);
    for i1 := 0 to TRUNC(FDateRanges[i].EndDate - FDateRanges[i].StartDate) do
    begin
      inc(iRowCounter);
//      if (FDateRanges[i].StartDate + i1) - lastDate > 1 then
//        inc(iRowCounter);

      SetCellValue(0, TOP_CLASS_AVAIL_STARTS_AT_ROW + iRowCounter, DayOfMonth(FDateRanges[i].StartDate + i1), NormalFontColor, NormalCellColor);
      SetCellValue(1, TOP_CLASS_AVAIL_STARTS_AT_ROW + iRowCounter, UpperCase(FormatSettings.LongMonthNames[Month(FDateRanges[i].StartDate + i1)]), NormalFontColor, NormalCellColor);
      SetCellValue(2, TOP_CLASS_AVAIL_STARTS_AT_ROW + iRowCounter, inttostr(Year(FDateRanges[i].StartDate + i1)), NormalFontColor, NormalCellColor);
      SetAlignment(0, TOP_CLASS_AVAIL_STARTS_AT_ROW - iRowCounter, haCENTER);
      SetAlignment(1, TOP_CLASS_AVAIL_STARTS_AT_ROW - iRowCounter, haCENTER);
      SetAlignment(2, TOP_CLASS_AVAIL_STARTS_AT_ROW - iRowCounter, haCENTER);

//      Occ := GetTotalOccForDate(FDateRanges[i].StartDate + i1);
//      OccPercentage := Occ / Rooms * 100;
//      s := TcxSSUtils.FormatText(OccPercentage, FloatFormat, 2, ATextColor);
//      SetCellValue(iStartCol, TOP_CLASS_AVAIL_STARTS_AT_ROW + 4 + iRowCounter, Rooms - Occ, 0, 1);
//      SetCellValue(iStartCol + 1, TOP_CLASS_AVAIL_STARTS_AT_ROW + 4 + iRowCounter, s, 0, 1);
//
//      if OccPercentage > 90 then
//        SetCellColor(iStartCol - 3, TOP_CLASS_AVAIL_STARTS_AT_ROW + 4 + iRowCounter, VeryBusyCellColor)
//      else
//      if OccPercentage > 70 then
//        SetCellColor(iStartCol - 3, TOP_CLASS_AVAIL_STARTS_AT_ROW + 4 + iRowCounter, MedHighCellColor)
//      else
//        SetCellColor(iStartCol - 3, TOP_CLASS_AVAIL_STARTS_AT_ROW + 4 + iRowCounter, NormalCellColor);
//
      DateRows.AddOrSetValue(FDateRanges[i].StartDate + i1, TOP_CLASS_AVAIL_STARTS_AT_ROW + iRowCounter);
      LastRowIndex := TOP_CLASS_AVAIL_STARTS_AT_ROW + iRowCounter;
    end;
  end;
  DisplayStatuses;
  DisplayRates;
  DisplayRatesToHotel;

  Excel.SaveToFile(filename);
end;

function TExcelProcessors.GetTotalRooms : Integer;
var i : Integer;
    Keys : TArray<String>;
    Key : String;
    TempItem : TTopClassEntity;
begin
  result := 0;
  Keys := FTopClasses.Keys.ToArray;
  for i := LOW(Keys) to HIGH(Keys) do
  begin
    Key := Keys[i];
    FTopClasses.TryGetValue(key, TempItem);
    result := result + TempItem.ARooms;
  end;
end;

function TExcelProcessors.GetRoomsOfClass(TheClass : String) : Integer;
var i : Integer;
    Keys : TArray<String>;
    Key : String;
    TempItem : TTopClassEntity;
begin
  result := 0;
  Keys := FTopClasses.Keys.ToArray;
  for i := LOW(Keys) to HIGH(Keys) do
  begin
    Key := Keys[i];
    FTopClasses.TryGetValue(key, TempItem);
    if TempItem.TopClass = TheClass then
    begin
      result := TempItem.ARooms;
      Break;
    end;
  end;
end;

procedure TExcelProcessors.SetBorders(ACol1, ARow1, ACol2, ARow2: integer);
begin
  SetCellBorders(ACol1, ARow1, ACol2, ARow2, alClient, lsThin);
end;

procedure TExcelProcessors.SetGroupBorders(ACol1, ARow1, ACol2, ARow2: integer);
var
  i: Integer;
begin
  SetCellBorders(ACol1, ARow1, ACol2, ARow1, alTop, lsMedium);
  SetCellBorders(ACol1, ARow2, ACol2, ARow2, alBottom, lsMedium);
  SetCellBorders(ACol1, ARow1, ACol1, ARow2, alLeft, lsMedium);
  SetCellBorders(ACol2, ARow1, ACol2, ARow2, alRight, lsMedium);
end;

procedure TExcelProcessors.SetCellBorders(ALeftCol, ATopRow, ARightCol, ABottomRow: Integer;
  AEdge: TAlign; AStyle: TcxSSEdgeLineStyle);
var
  i, j: Integer;
begin
  if AEdge <> alNone then
  with Excel.ActiveSheet do // using our active page
    for i := ALeftCol to ARightCol do // for each column specified
      for j := ATopRow to ABottomRow do // for each row specified
        with GetCellObject(i, j) do // get the cell
        try
          case AEdge of // depending on which edge has been requested
            alTop:
              Style.Borders.Top.Style := AStyle;
            alBottom:
              Style.Borders.Bottom.Style := AStyle;
            alLeft:
              Style.Borders.Left.Style := AStyle;
            alRight:
              Style.Borders.Right.Style := AStyle;
            alClient:
              begin
                Style.Borders.Left.Style := AStyle;
                Style.Borders.Top.Style := AStyle;
                Style.Borders.Right.Style := AStyle;
                Style.Borders.Bottom.Style := AStyle;
              end;
          end;
        finally
          Free; // free it
        end;
end;

procedure TExcelProcessors.SetCellFontAttributes(ALeftCol, ATopRow, ARightCol, ABottomRow: Integer;
  AStyle: TFontStyles; ASize: Integer);
var
  i, j: Integer;
begin
  with Excel.ActiveSheet do // using our active page
    for i := ALeftCol to ARightCol do // for each column specified
      for j := ATopRow to ABottomRow do // for each row specified
        with GetCellObject(i, j) do // get the cell
        try
          Style.Font.Style := AStyle;
          Style.Font.Size := ASize;
        finally
          Free; // free it
        end;
end;

procedure TExcelProcessors.GetCellFontAttributes(ACol, ARow: Integer; var AStyle: TFontStyles; var ASize: Integer);
var
  i, j: Integer;
begin
  with Excel.ActiveSheet do // using our active page
    with GetCellObject(ACol, ARow) do // get the cell
    try
      AStyle := Style.Font.Style;
      ASize := Style.Font.Size;
    finally
      Free; // free it
    end;
end;


procedure TExcelProcessors.SetCellValue(ACol, ARow: integer; AValue: Variant; FontColor, BackColor : Word; Bold : Boolean = False);
var AStyle: TFontStyles;
    ASize : Integer;
begin
  with Excel.ActiveSheet.GetCellObject(ACol, ARow) do
  begin
    try
      Text := AValue; { <- Set data to cell record }
    finally
      Free;
    end;
    if FontColor <> 9999 then
      SetCellFontColor(ACol, ARow, FontColor);
    if BackColor <> 9999 then
      SetCellColor(ACol, ARow, BackColor);
    if Bold then
    begin
       GetCellFontAttributes(ACol, ARow, AStyle, ASize);
       SetCellFontAttributes(ACol, ARow, ACol, ARow, [fsBold], ASize);
    end;
  end;
end;

procedure TExcelProcessors.SetCellFontColor(ACol, ARow: integer; Color : Word);
begin
  with Excel.ActiveSheet.GetCellObject(ACol, ARow) do
  begin
    Style.Font.FontColor := Color;
    Style.HorzTextAlign
  end;
end;

procedure TExcelProcessors.SetAlignment(ACol, ARow: integer; align : TcxHorzTextAlign);
begin
  with Excel.ActiveSheet.GetCellObject(ACol, ARow) do
  try
    begin
      Style.HorzTextAlign := align;
    end;
  finally
    free;
  end;
end;

function TExcelProcessors.GetCellFontColor(ACol, ARow: integer) : Word;
begin
  with Excel.ActiveSheet.GetCellObject(ACol, ARow) do
  try
      result := Style.Font.FontColor;
  finally
    free;
  end;
end;

function TExcelProcessors.GetCellFormat(ACol, ARow: integer) : TxlsDataFormat;
var CellObj : TcxSSCellObject;
begin
  with Excel.ActiveSheet.GetCellObject(ACol, ARow) do
  try
      result := Style.Format;
  finally
    free;
  end;
end;

procedure TExcelProcessors.SetCellColor(ACol, ARow: integer; Color : Word);
begin
  with Excel.ActiveSheet.GetCellObject(ACol, ARow) do
  try
    Style.Brush.BackgroundColor := Color;
  finally
    free;
  end;
end;

function TExcelProcessors.GetCellColour(const aCol, aRow: integer): integer;     // Get the Cell colour as a plaette entry
begin
  with Excel.ActiveSheet.GetCellObject(aCol, aRow) do   // Get the cell object
    try
      try
        Result := Style.Brush.BackgroundColor;             // Return the entry
      except
        Result := 0;                                       // JIC
      end;
    finally
      Free;                                                // Free the cell object
    end;
end;


procedure TExcelProcessors.CollectDateRanges;
var i : Integer;
    dates : TStringList;
    lastDate, currDate : String;
    dLastDate, dCurrDate : TDate;
begin
  dates := TStringList.Create;
  try
    // Compress into a simple, sorted list of unique dates
    for i := 0 to FTopClassStatuses.Count - 1 do
    begin
      currDate := uDateUtils.dateToSqlString(FTopClassStatuses[i].ADate);
      if dates.IndexOf(currDate) = -1 then
        dates.Add(currDate);
    end;
    dates.Sort;
    dLastDate := 0;
    for i := 0 to dates.Count - 1 do
    begin
      dCurrDate := uDateUtils.SqlStringToDate(dates[i]);
      if dCurrDate - dLastDate > 1 then
        FDateRanges.Add(TDateRange.Create(dCurrDate, dCurrDate))
      else
        FDateRanges[FDateRanges.Count - 1].EndDate := dCurrDate;
      dLastDate := dCurrDate;
    end;

  finally
    dates.Free;
  end;
end;


{ TDateEntity }

constructor TDateEntity.Create(_Date: TDate; _Rate, _ToHotel: Variant; _StopSell, _CTA : Boolean; _MLOS : Integer);
begin
  ADate := _Date;
  ARate := _Rate;
  AToHotel := _ToHotel;
  StopSell := _StopSell;
  CTA := _CTA;
  MLOS := _MLOS;
end;

{ TTopClassEntity }

constructor TTopClassEntity.Create(_TopClass: String; _Rooms: Integer);
begin
  TopClass := _TopClass;
  ARooms := _Rooms;
end;

{ TOccEntity }

constructor TOccEntity.Create(_Date: TDate; _TopClass: String; _Occ: Integer);
begin
  ADate := _Date;
  TopClass := _TopClass;
  Occ := _Occ;
end;

{ TDateRange }

constructor TDateRange.Create(_StartDate, _EndDate: TDate);
begin
  StartDate := _StartDate;
  EndDate := _EndDate;
end;

{ TChannelEntity }

constructor TChannelEntity.Create(_ChannelCode, _ChannelName, _Header: String);
begin
  ChannelCode := _ChannelCode;
  ChannelName := _ChannelName;
  Header := _Header;
  Classes := TObjectList<TClassEntity>.Create(TComparer<TClassEntity>.Construct(ClassComparison));
end;

function TChannelEntity.CreateClassEntity(_ClassCode: String): TClassEntity;
var idx : Integer;
begin
  idx := ClassEntityIndex(_ClassCode);
  if idx = -1 then
  begin
    result := TClassEntity.Create(_ClassCode);
    Classes.Add(result);
  end else
    result := Classes[idx];
end;

function TChannelEntity.ClassEntityIndex(_ClassCode: String): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to Classes.Count - 1 do
    if Classes[i].ClassCode = _ClassCode then
    begin
      result := i;
      Break;
    end;
end;


destructor TChannelEntity.Destroy;
begin
  Classes.Free;
end;

{ TClassEntity }

procedure TClassEntity.AddValue(_Date: TDate; _Rate, _ToHotel : Variant; _StopSell, _CTA : Boolean; _MLOS : Integer);
begin
  ValueList.Add(TDateEntity.Create(_Date, _Rate, _ToHotel, _StopSell, _CTA,_MLOS))
end;

constructor TClassEntity.Create(_ClassCode: String);
begin
  ClassCode := _ClassCode;
  ValueList := TObjectList<TDateEntity>.Create(TComparer<TDateEntity>.Construct(DateEntityComparison));
end;

destructor TClassEntity.Destroy;
begin
  ValueList.Free;
end;

end.
