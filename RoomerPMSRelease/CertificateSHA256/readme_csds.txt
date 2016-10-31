Use only one of the certificate files contained in this ZIP, based on the:
*Code you are signing
*Hash algorithm you are using

NOTE: We strongly encourage you to use SHA-2; only use SHA-1 if the OS where your code will be executed does not support SHA-2.

| CODE    | HASH  | FILE                                |
|---------|-------|-------------------------------------|
| JAVA    | SHA-2 | <certificate_serial_number>-SHA2.pem |
| WINDOWS | SHA-2 | <certificate_serial_number>-SHA2.spc |
| JAVA    | SHA-1 | <certificate_serial_number>-SHA1.pem |
| WINDOWS | SHA-1 | <certificate_serial_number>-SHA1.spc |

Remember to install the certificate chain that may include intermediate or cross certificates.
