

signtool sign /f CertificateSHA256\roomerpms.pfx /t http://timestamp.comodoca.com/authenticode /p Baslari.0 Roomer.exe
signtool sign /f CertificateSHA256\roomerpms.pfx /as /fd sha256 /tr http://timestamp.comodoca.com/rfc3161 /td sha256 /p Baslari.0 Roomer.exe

@REM AWSCLI\aws.exe configure<PRODIAM

AWSCLI\aws.exe s3 cp Roomer.exe s3://roomerstore.com/Roomer.exe
AWSCLI\aws.exe s3 cp s3://roomerstore.com/Roomer.exe s3://roomerstore.com/roomer.exe
