@echo off
setlocal
VersionXmlGenerator . > Roomer.xml

if not exist "Deployment" mkdir Deployment

copy Roomer.exe Deployment
copy RoomerUpgradeAgent.exe Deployment
copy Roomer.xml Deployment

call SignSpecific Deployment\Roomer.exe
call SignSpecific Deployment\RoomerUpgradeAgent.exe


set AWSCMD="aws.exe"
where /Q %AWSCMD%
if errorlevel 1 (
  Echo ERROR: AWS-CLI not found on path
  goto :EOF
)

echo .
set answer=
set /p answer="Type yes to start copying to s3://roomerstore ..."
if "%answer%"=="yes" (
  %AWSCMD% s3 rm s3://roomerstore.com/Roomer.xml
  %AWSCMD% s3 sync Deployment s3://roomerstore.com
  %AWSCMD% s3 cp s3://roomerstore.com/Roomer.exe s3://roomerstore.com/roomer.exe
 ) else (
  echo Copying to S3 cancelled
)
endlocal