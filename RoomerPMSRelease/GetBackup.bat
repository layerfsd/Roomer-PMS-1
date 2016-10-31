@ECHO OFF
SET A_FEW_SPACES=                                                                     .
SET OK_TOEXECUTE=1
IF "%1"=="" (
  SET OK_TOEXECUTE=0
) ELSE (
	IF "%2"=="" (
	  SET OK_TOEXECUTE=0
	) ELSE (
		IF "%3"=="" (
		  SET OK_TOEXECUTE=0
		)
	)
)

IF "%OK_TOEXECUTE%"=="0" (

  ECHO %A_FEW_SPACES%
  ECHO Syntax:
  ECHO    GetBackup `HOTEL_ID` `DATE YYYY-MM-DD` `DESTINATION`  
  ECHO =============================================================
  ECHO %A_FEW_SPACES%
  ECHO Syntax examples:
  ECHO    GetBackup chnl 2015-05-17 C:\Temp
  ECHO or:
  ECHO    GetBackup X 2015-05-17 C:\Temp
) ELSE (

	IF "%1"=="X" (
	   SET "FILE_TO_DOWNLOAD=s3://nl.promoir.roomer.backup/db/home100.backup.%2.gz"
	) ELSE (
	   SET "FILE_TO_DOWNLOAD=s3://nl.promoir.roomer.backup/db/home100_%1.backup.%2.gz"
	)
    ECHO %A_FEW_SPACES%
    ECHO Downloading !FILE_TO_DOWNLOAD! TO %3
    ECHO %A_FEW_SPACES%
    AWSCLI\aws.exe configure<PRODIAM
    AWSCLI\aws.exe s3 cp !FILE_TO_DOWNLOAD! %3

)


REM AWSCLI\aws.exe s3 cp s3://nl.promoir.roomer.logging/appservers/appserver1/ C:\Temp --include "2015-05-17*"
