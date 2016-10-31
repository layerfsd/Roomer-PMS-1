

signtool sign /f GoDaddyCertificate\roomerpms.pfx /p Baslari.0 /t http://timestamp.verisign.com/scripts/timestamp.dll Roomer.exe

AWSCLI\aws.exe configure<PRODIAM

AWSCLI\aws.exe s3 cp Roomer.exe s3://roomerstore.com/Roomer.exe
AWSCLI\aws.exe s3 cp s3://roomerstore.com/Roomer.exe s3://roomerstore.com/roomer.exe
