: --
REM openssl pkcs12 -inkey privateKey.key -in 3f992c99079b90d6-SHA2.pem -certfile 3f992c99079b90d6-SHA2.spc -export -out roomerpms.pfx

signtool sign /f CertificateSHA256\roomerpms.pfx /t http://timestamp.comodoca.com/authenticode /p Baslari.0 Roomer.exe
signtool sign /f CertificateSHA256\roomerpms.pfx /as /fd sha256 /tr http://timestamp.comodoca.com/rfc3161 /td sha256 /p Baslari.0 Roomer.exe

