unit sMessages;
{$I sDefs.inc}

interface

uses Controls {$IFDEF FPC}, LMessages{$ENDIF};

type                
  TacSectionInfo = record
    Name: string;
    SkinIndex: integer;
    RepaintNeeded: boolean;
  end;

  PacSectionInfo = ^TacSectionInfo;

const
  SM_ALPHACMD               = $A100;

  AC_SETNEWSKIN             = 1;
  AC_REMOVESKIN             = 2;
  AC_REFRESH                = 3; // if WParamLo = 1 then message will not be broadcasted to children
  AC_GETPROVIDER            = 4;
  AC_GETCACHE               = 5;
  AC_ENDPARENTUPDATE        = 6;
  AC_CTRLHANDLED            = 7;
  AC_UPDATING               = 8;
  AC_GETDEFINDEX            = 9; // Get skin index if SkinSection is empty (incremented to 1)
  AC_PREPARING              = 10;
  AC_GETHALFVISIBLE         = 11;
  AC_GETLISTSW              = 12;

  AC_UPDATESECTION          = 13;
  AC_DROPPEDDOWN            = 14;
  AC_SETSECTION             = 15;

  AC_STOPFADING             = 16;
  AC_SETBGCHANGED           = 17;
  AC_INVALIDATE             = 18;
  AC_CHILDCHANGED           = 19;
  AC_SETCHANGEDIFNECESSARY  = 20;  // Defines BgChanged to True if required, with repainting if WParamLo = 1
  AC_GETCONTROLCOLOR        = 21;  // Returns control BG color
  AC_SETHALFVISIBLE         = 22;
  AC_PREPARECACHE           = 23;
  AC_DRAWANIMAGE            = 24;
  AC_CONTROLLOADED          = 25;
  AC_GETSKININDEX           = 26;
  AC_GETSERVICEINT          = 27;
  AC_UPDATECHILDREN         = 28;
  AC_MOUSEENTER             = 29;
  AC_MOUSELEAVE             = 30;
  AC_BEGINUPDATE            = 31;
  AC_ENDUPDATE              = 32;
  AC_CLEARCACHE             = 33;

  AC_GETBG                  = 34;
  AC_GETDISKIND             = 35;  // Init a look of disabled control
  AC_GETSKINSTATE           = 36;
  AC_GETSKINDATA            = 37;
  AC_PRINTING               = 38;

  AC_PAINTOUTER             = 40;  // Paint a Shadow or other effect, LParam is PBGInfo, if WParamLo is 1 - use cached BG if exists 

  AC_BEFORESCROLL           = 51;
  AC_AFTERSCROLL            = 52;
  AC_REINITSCROLLS          = 53;
  AC_GETAPPLICATION         = 60;
  AC_PARENTCLOFFSET         = 61;
  AC_NCPAINT                = 62;
  AC_SETPOSCHANGING         = 63;
  AC_GETPOSCHANGING         = 64;
  AC_SETALPHA               = 65;
  AC_GETFONTINDEX           = 66;
  AC_GETBORDERWIDTH         = 68;

  AC_GETOUTRGN              = 70;
  AC_COPYDATA               = 71;

  WM_DRAWMENUBORDER         = CN_NOTIFY + 101;
  WM_DRAWMENUBORDER2        = CN_NOTIFY + 102;

{$IFNDEF D2010}
  {$EXTERNALSYM WM_DWMSENDICONICTHUMBNAIL}
  WM_DWMSENDICONICTHUMBNAIL         = $0323;
  {$EXTERNALSYM WM_DWMSENDICONICLIVEPREVIEWBITMAP}
  WM_DWMSENDICONICLIVEPREVIEWBITMAP = $0326;
{$ENDIF}

implementation

end.
