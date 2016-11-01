
call SignSpecific Roomer.exe

@REM AWSCLI\aws.exe configure<PRODIAM
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
  %AWSCMD% s3 cp Roomer.exe s3://roomerstore.com/Roomer.exe
  %AWSCMD% s3 cp s3://roomerstore.com/Roomer.exe s3://roomerstore.com/roomer.exe
) else (
  echo Upload cancelled
)
