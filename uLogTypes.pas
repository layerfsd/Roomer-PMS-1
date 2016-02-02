unit uLogTypes;

interface

uses Dialogs;

type
 // --- New Log Types.
   TLogState   = ( lsOn
                 , lsOff
   );
   TLogMsgType = ( lmtSevere
                 , lmtError
                 , lmtWarning
                 , lmtInformation
                 , lmtDebug
   );
   TLogMsgTypes = set of TLogMsgType;

 // --- Log Type Conversion functions.
   function LogMsgTypeToString    ( aLogMsgType: TLogMsgType ): string;
   function LogMsgTypeToMsgDlgType( aLogMsgType: TLogMsgType ): TMsgDlgType;



implementation

// --------------------------------------------------------------------------------
// Log Type Conversion functions.
// --------------------------------------------------------------------------------

// ---
//
function LogMsgTypeToString( aLogMsgType: TLogMsgType ): string;
begin
   result := '<unknown>';

   case ( aLogMsgType ) of
      lmtSevere     : result := 'lmtSevere     ';
      lmtError      : result := 'lmtError      ';
      lmtWarning    : result := 'lmtWarning    ';
      lmtInformation: result := 'lmtInformation';
      lmtDebug      : result := 'lmtDebug      ';
   end;
end;

// ---
//
function LogMsgTypeToMsgDlgType( aLogMsgType: TLogMsgType ): TMsgDlgType;
begin
   result := mtCustom;

   case ( aLogMsgType ) of
      lmtSevere     : result := mtError;
      lmtError      : result := mtError;
      lmtWarning    : result := mtWarning;
      lmtInformation: result := mtInformation ;
      lmtDebug      : result := mtCustom ;
   end;
end;

end.
 