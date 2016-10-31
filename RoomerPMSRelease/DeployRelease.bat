
VersionXmlGenerator . > Roomer.xml

if not exist "Deployment" mkdir Deployment

COPY Roomer.exe Deployment
COPY RoomerUpgradeAgent.exe Deployment
COPY Roomer.xml Deployment

signtool sign /f CertificateSHA256\roomerpms.pfx /t http://timestamp.comodoca.com/authenticode /p Baslari.0  Deployment\Roomer.exe
signtool sign /f CertificateSHA256\roomerpms.pfx /as /fd sha256 /tr http://timestamp.comodoca.com/rfc3161 /td sha256 /p Baslari.0  Deployment\Roomer.exe

signtool sign /f CertificateSHA256\roomerpms.pfx /t http://timestamp.comodoca.com/authenticode /p Baslari.0 Deployment\RoomerUpgradeAgent.exe
signtool sign /f CertificateSHA256\roomerpms.pfx /as /fd sha256 /tr http://timestamp.comodoca.com/rfc3161 /td sha256 /p Baslari.0 Deployment\RoomerUpgradeAgent.exe

@REM AWSCLI\aws.exe configure<PRODIAM

AWSCLI\aws.exe s3 rm s3://roomerstore.com/Roomer.xml

AWSCLI\aws.exe s3 sync Deployment s3://roomerstore.com
AWSCLI\aws.exe s3 cp s3://roomerstore.com/Roomer.exe s3://roomerstore.com/roomer.exe
