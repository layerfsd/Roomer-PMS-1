
VersionXmlGenerator . > Roomer.xml

if not exist "Deployment" mkdir Deployment

COPY Roomer.exe Deployment
COPY RoomerUpgradeAgent.exe Deployment
COPY Roomer.xml Deployment

signtool sign /f GoDaddyCertificate\roomerpms.pfx /p Baslari.0 /t http://timestamp.verisign.com/scripts/timestamp.dll Deployment\Roomer.exe
signtool sign /f GoDaddyCertificate\roomerpms.pfx /p Baslari.0 /t http://timestamp.verisign.com/scripts/timestamp.dll Deployment\RoomerUpgradeAgent.exe

AWSCLI\aws.exe configure<PRODIAM

AWSCLI\aws.exe s3 rm s3://roomerstore.com/Roomer.xml

REM AWSCLI\aws.exe s3 cp Deployment\Roomer.exe s3://roomerstore.com
REM AWSCLI\aws.exe s3 cp Deployment\RoomerUpgradeAgent.exe s3://roomerstore.com
REM AWSCLI\aws.exe s3 cp Deployment\Roomer.xml s3://roomerstore.com
AWSCLI\aws.exe s3 sync Deployment s3://roomerstore.com
AWSCLI\aws.exe s3 cp s3://roomerstore.com/Roomer.exe s3://roomerstore.com/roomer.exe

REM call cpfStoreSpecificLocation Deployment\Roomer.exe /opt/roomer/store/downloads/roomer
REM call cpfStoreSpecificLocation Deployment\RoomerUpgradeAgent.exe /opt/roomer/store/downloads/roomer
REM call cpfStoreSpecificLocation Deployment\Roomer.xml /opt/roomer/store/downloads/roomer
