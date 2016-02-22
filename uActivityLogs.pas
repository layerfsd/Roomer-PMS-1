unit uActivityLogs;

interface

uses SysUtils, Classes, uUtils, TypInfo,
     uRoomerThreadedRequest
     ;

type

  TActivityType = (ROOMER, INVOICE, RESERVATION, AVAILABILITY, RATE, TABLE_CHANGE, OFFLINEREPORT);
  TRoomerAction = (LOGIN, LOGOUT, BUTTON_CLICK, ERROR);

  TInvoiceAction = (ADD_LINE, DELETE_LINE, CHANGE_ITEM, ADD_PAYMENT, DELETE_PAYMENT, CHANGE_PAYMENT, PRINT_PROFORMA, PAY_AND_PRINT);

  TReservationAction = (NEW_RESERVATION,
                        CHANGE_RESERVATION,
                        DELETE_RESERVATION,
                        NEW_ROOMRESERVATION,
                        CHANGE_ROOMRESERVATION,
                        DELETE_ROOMRESERVATION,
                        CHANGE_ROOMRESERVATION_STATUS,
                        CHANGE_ARRIVAL_DATE,
                        CHANGE_DEPARTURE_DATE,
                        CHANGE_NUMBER_OF_GUESTS,
                        NEW_ROOM_NUMBER,
                        NEW_ROOM_TYPE);


  TAvailabilityAction = (EDIT, BULK);
  TRateAction = (RATE_EDIT, STOP_EDIT, MIN_EDIT, MAX_EDIT);

  TOfflineReportAction = (REPORTEXCEPTION);

procedure AddOfflineReportActivityLog(const user : String;
                               action : TOfflineReportAction;
                               const reportname: string;
                               const result : String;
                               const moreInfo : String);

procedure AddRoomerActivityLog(const user : String;
                               action : TRoomerAction;
                               const result : String;
                               const moreInfo : String);

procedure AddInvoiceActivityLog(const user : String;
                                iReservation,
                                iRoomReservation,
                                invoiceIndex : Integer;
                                action : TInvoiceAction;
                                const code : String;
                                value : Double;
                                lineId : Integer;
                                const moreInfo : String);

procedure AddReservationActivityLog(const user : String;
                                    iReservation,
                                    iRoomReservation : Integer;
                                    action : TReservationAction;
                                    const OldValue : String;
                                    const NewValue : String;
                                    const moreInfo : String);

procedure AddAvailabilityActivityLog(const user : String;
                                     action : TAvailabilityAction;
                                     const roomClass : String;
                                     iAvailability : Integer;
                                     date : TDate;
                                     const moreInfo : String);

procedure AddRateActivityLog(const user : String;
                             action : TRateAction;
                             const roomClass : String;
                             rate : Double;
                             stop : Boolean;
                             min : Integer;
                             max : Integer;
                             date : TDate;
                             const moreInfo : String);

procedure PushActivityLogs;

procedure UserClickedDxLargeButton(Sender: TObject);

function CreateInvoiceActivityLog(const user : String;
                                iReservation,
                                iRoomReservation,
                                invoiceIndex : Integer;
                                action : TInvoiceAction;
                                const code : String;
                                value : Double;
                                lineId : Integer;
                                const moreInfo : String) : String;

function WriteInvoiceActivityLog(const sLine : String) : String;


function CreateReservationActivityLog(const user : String;
                                    iReservation,
                                    iRoomReservation : Integer;
                                    action : TReservationAction;
                                    const OldValue : String;
                                    const NewValue : String;
                                    const moreInfo : String) : String;

function WriteReservationActivityLog(const sLine : String) : String;

var ActivityLogGetThreadedData : TGetThreadedData = nil;

implementation

uses Menus, sButton, sLabel, ud, ioUtils, uAppGlobal, uDateUtils, uStringUtils, dxBar
    , WinApi.Windows
    ;


function GetDataFileLocationWithName(activity: TActivityType): String;
var filename : String;
begin
  filename := 'User_Logs_' + GetEnumName(TypeInfo(TActivityType), Ord(activity)) + '.log';
  result := TPath.Combine(glb.GetDataCacheLocation, filename);
end;

function CreateXmlElement(const User : String;
                          const When : String;
                          const Category : String;
                          const Action : String;
                          const Description : String;
                          const DetailedDescription : String;
                          const OldValue : String;
                          const NewValue : String;
                          const Code : String;
                          Reservation : Integer;
                          RoomReservation : Integer;
                          ID_1 : Integer;
                          ID_2 : Integer;
                          ID_3 : Integer;
                          const ADate : String) : String;
begin
  result := '<log user="%s" type="%s" action="%s" when="%s">' +
            '<description>%s</description>' +
            '<detailedDescription>%s</detailedDescription>' +
            '<machineName>%s</machineName>' +
            '<oldValue>%s</oldValue>' +
            '<newValue>%s</newValue>' +
            '<code>%s</code>' +
            '<reservation>%s</reservation>' +
            '<roomReservation>%s</roomReservation>' +
            '<id1>%s</id1>' +
            '<id2>%s</id2>' +
            '<id3>%s</id3>' +
            '<date>%s</date>' +
            '</log>';
  result := format(result, [
                   XmlEncode_ex(User, ''),
                   XmlEncode_ex(Category, ''),
                   XmlEncode_ex(Action, ''),
                   When,
                   XmlEncode_ex(Description, ''),
                   XmlEncode_ex(DetailedDescription, ''),
                   XmlEncode_ex(ComputerName, ''), // From uUtils
                   XmlEncode_ex(OldValue, ''),
                   XmlEncode_ex(NewValue, ''),
                   XmlEncode_ex(Code, ''),
                   inttostr(Reservation),
                   inttostr(RoomReservation),
                   inttostr(ID_1),
                   inttostr(ID_2),
                   inttostr(ID_3),
                   ADate
                   ]);
end;


function CreateInvoiceActivityLog(const user : String;
                                iReservation,
                                iRoomReservation,
                                invoiceIndex : Integer;
                                action : TInvoiceAction;
                                const code : String;
                                value : Double;
                                lineId : Integer;
                                const moreInfo : String) : String;
var categoryName, actionName : String;
begin
  categoryName := GetEnumName(TypeInfo(TActivityType), Ord(INVOICE));
  actionName := GetEnumName(TypeInfo(TInvoiceAction), Ord(action));

  result := CreateXmlElement(user,
                            uDateUtils.dateTimeToXmlString(now),
                            categoryName,
                            actionName,
                            moreinfo,
                            moreinfo,
                            '',
                            FloatToXml(value, 2),
                            code,
                            iReservation,
                            iRoomReservation,
                            lineId,
                            invoiceIndex,
                            0,
                            '');
end;



function WriteInvoiceActivityLog(const sLine : String) : String;
begin
  AddToTextFile(GetDataFileLocationWithName(INVOICE), sLine);
end;

procedure AddInvoiceActivityLog(const user : String;
                                iReservation,
                                iRoomReservation,
                                invoiceIndex : Integer;
                                action : TInvoiceAction;
                                const code : String;
                                value : Double;
                                lineId : Integer;
                                const moreInfo : String);
begin
  WriteInvoiceActivityLog(
     CreateInvoiceActivityLog(user,
                              iReservation,
                              iRoomReservation,
                              invoiceIndex,
                              action,
                              code,
                              value,
                              lineId,
                              moreInfo));
end;

procedure AddReservationActivityLog(const user : String;
                                    iReservation,
                                    iRoomReservation : Integer;
                                    action : TReservationAction;
                                    const OldValue : String;
                                    const NewValue : String;
                                    const moreInfo : String);
var categoryName, actionName, sLine : String;
begin
  categoryName := GetEnumName(TypeInfo(TActivityType), Ord(RESERVATION));
  actionName := GetEnumName(TypeInfo(TReservationAction), Ord(action));

  sLine := CreateXmlElement(user,
                            uDateUtils.dateTimeToXmlString(now),
                            categoryName,
                            actionName,
                            moreinfo,
                            moreinfo,
                            OldValue,
                            NewValue,
                            '',
                            iReservation,
                            iRoomReservation,
                            0,
                            0,
                            0,
                            '');
  AddToTextFile(GetDataFileLocationWithName(RESERVATION), sLine);
end;


function CreateReservationActivityLog(const user : String;
                                    iReservation,
                                    iRoomReservation : Integer;
                                    action : TReservationAction;
                                    const OldValue : String;
                                    const NewValue : String;
                                    const moreInfo : String) : String;

var categoryName, actionName : String;
begin
  categoryName := GetEnumName(TypeInfo(TActivityType), Ord(RESERVATION));
  actionName := GetEnumName(TypeInfo(TReservationAction), Ord(action));

  result := CreateXmlElement(user,
                            uDateUtils.dateTimeToXmlString(now),
                            categoryName,
                            actionName,
                            moreinfo,
                            moreinfo,
                            OldValue,
                            NewValue,
                            '',
                            iReservation,
                            iRoomReservation,
                            0,
                            0,
                            0,
                            '');

end;

function WriteReservationActivityLog(const sLine : String) : String;
begin
  AddToTextFile(GetDataFileLocationWithName(RESERVATION), sLine);
end;


//****************************************

procedure AddOfflineReportActivityLog(const user : String;
                               action : TOfflineReportAction;
                               const reportname: string;
                               const result : String;
                               const moreInfo : String);
var
  sLine: string;
  categoryName: string;
  actionName: string;
begin

  categoryName := GetEnumName(TypeInfo(TActivityType), ORD(OFFLINEREPORT));
  actionName := GetEnumName(TypeInfo(TRoomerAction), ORD(action));



  sLine := CreateXmlElement(user,
                            uDateUtils.dateTimeToXmlString(now),
                            categoryName + ': ' + reportname,
                            actionName,
                            result,
                            moreinfo,
                            '',
                            '',
                            '',
                            0,
                            0,
                            0,
                            0,
                            0,
                            '');
  AddToTextFile(GetDataFileLocationWithName(OFFLINEREPORT), sLine);

end;

procedure AddRoomerActivityLog(const user : String;
                               action : TRoomerAction;
                               const result : String;
                               const moreInfo : String);
var categoryName, actionName, sLine : String;
begin
  try
    if d.roomerMainDataSet.hotelId = '' then exit;
  except exit; end;

  categoryName := GetEnumName(TypeInfo(TActivityType), ORD(ROOMER));
  actionName := GetEnumName(TypeInfo(TRoomerAction), ORD(action));

  sLine := CreateXmlElement(user,
                            uDateUtils.dateTimeToXmlString(now),
                            categoryName,
                            actionName,
                            moreinfo,
                            moreinfo,
                            '',
                            '',
                            '',
                            0,
                            0,
                            0,
                            0,
                            0,
                            '');
  AddToTextFile(GetDataFileLocationWithName(ROOMER), sLine);
end;

procedure AddAvailabilityActivityLog(const user : String;
                                     action : TAvailabilityAction;
                                     const roomClass : String;
                                     iAvailability : Integer;
                                     date : TDate;
                                     const moreInfo : String);
var categoryName, actionName, sLine : String;
begin
  categoryName := GetEnumName(TypeInfo(TActivityType), ORD(AVAILABILITY));
  actionName := GetEnumName(TypeInfo(TAvailabilityAction), ORD(action));

  sLine := CreateXmlElement(user,
                            uDateUtils.dateTimeToXmlString(now),
                            categoryName,
                            actionName,
                            moreinfo,
                            moreinfo,
                            '',
                            inttostr(iAvailability),
                            roomClass,
                            0,
                            0,
                            0,
                            0,
                            0,
                            uDateUtils.dateTimeToXmlString(date));
  AddToTextFile(GetDataFileLocationWithName(AVAILABILITY), sLine);
end;

procedure AddRateActivityLog(const user : String;
                             action : TRateAction;
                             const roomClass : String;
                             rate : Double;
                             stop : Boolean;
                             min : Integer;
                             max : Integer;
                             date : TDate;
                             const moreInfo : String);
var categoryName, actionName, sLine : String;
begin
  categoryName := GetEnumName(TypeInfo(TActivityType), ORD(AVAILABILITY));
  actionName := GetEnumName(TypeInfo(TRateAction), ORD(action));

  sLine := CreateXmlElement(user,
                            uDateUtils.dateTimeToXmlString(now),
                            categoryName,
                            actionName,
                            moreinfo,
                            moreinfo,
                            '',
                            FloatToXml(rate, 2),
                            roomClass,
                            0,
                            0,
                            ORD(Stop),
                            min,
                            max,
                            uDateUtils.dateTimeToXmlString(date));
  AddToTextFile(GetDataFileLocationWithName(AVAILABILITY), sLine);
end;

procedure PushActivityLogs;
var activity  : TActivityType;
    filename  : String;
    content   : TStringList;
    i         : Integer;
    list      : TStringList;
    sql       : String;
begin
  try
  list := TStringList.Create;
  try
    for activity := LOW(TActivityType) to HIGH(TActivityType) do
    begin
      filename := GetDataFileLocationWithName(activity);
      if FileExists(filename) then
      begin
        if FileExists(filename + '.busy') then
          SysUtils.DeleteFile(filename + '.busy');
        if SysUtils.RenameFile(filename, filename + '.busy') then
        begin
          filename := filename + '.busy';
          content := TStringList.Create;
          try
            content.LoadFromFile(filename);
            for i := 0 to content.Count - 1 do
              list.Add(content[i]);

            // Then delete the file...
            SysUtils.DeleteFile(filename);
          finally
            content.Free;
          end;
        end;
      end;

    end;

    if list.Count > 0 then
    begin
      sql := '<?xml version="1.0" encoding="UTF-8"?>' + #10 +
             '<logs>' + #10 +
                list.Text +
             '</logs>' + #10;
      if NOT Assigned(ActivityLogGetThreadedData) then
         ActivityLogGetThreadedData := TGetThreadedData.Create;
      ActivityLogGetThreadedData.Put('userlogs', 'logs=' + d.roomerMainDataSet.UrlEncode(sql), nil);
    end;
  finally
    list.Free;
  end;
  except
     on e: Exception do begin
        // TODO - Ignore for the time being
     end;
  end;
end;

procedure UserClickedDxLargeButton(Sender: TObject);
begin
  if Assigned(Sender) then
    if (Sender IS TdxBarLargeButton) then
       AddRoomerActivityLog(d.roomerMainDataSet.username, uActivityLogs.BUTTON_CLICK, TdxBarLargeButton(Sender).Name, 'User ' + d.roomerMainDataSet.username + ' clicked ' + TdxBarLargeButton(Sender).Caption + ' (' + TdxBarLargeButton(Sender).Name + ')')
    else
    if (Sender IS TMenuItem) then
       AddRoomerActivityLog(d.roomerMainDataSet.username, uActivityLogs.BUTTON_CLICK, TMenuItem(Sender).Name, 'User ' + d.roomerMainDataSet.username + ' clicked ' + TMenuItem(Sender).Caption + ' (' + TMenuItem(Sender).Name + ')')
    else
    if (Sender IS TsButton) then
       AddRoomerActivityLog(d.roomerMainDataSet.username, uActivityLogs.BUTTON_CLICK, TsButton(Sender).Name, 'User ' + d.roomerMainDataSet.username + ' clicked ' + TsButton(Sender).Caption + ' (' + TsButton(Sender).Name + ')')
    else
    if (Sender IS TsLabel) then
       AddRoomerActivityLog(d.roomerMainDataSet.username, uActivityLogs.BUTTON_CLICK, TsLabel(Sender).Name, 'User ' + d.roomerMainDataSet.username + ' clicked ' + TsLabel(Sender).Caption + ' (' + TsLabel(Sender).Name + ')')

    else
       AddRoomerActivityLog(d.roomerMainDataSet.username, uActivityLogs.BUTTON_CLICK, '<UNKNOWN>', 'User ' + d.roomerMainDataSet.username + ' clicked <UNKNOWN> (<UNKNOWN>)');
end;


initialization

finalization
  // Destruction should be here, but generates an InvalidPointererror when destroying SQL TStringlist of TROomerdataset
  // Destruction is now in the FormDestroy of uMain
//  FreeAndNil(ActivityLogGetThreadedData);

end.
