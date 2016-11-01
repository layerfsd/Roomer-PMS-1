@echo off
setlocal
signtool sign /f CertificateSHA256\roomerpms.pfx /t http://timestamp.comodoca.com/authenticode /p Baslari.0 %1
signtool sign /f CertificateSHA256\roomerpms.pfx /as /fd sha256 /tr http://timestamp.comodoca.com/rfc3161 /td sha256 /p Baslari.0 %1
endlocal

