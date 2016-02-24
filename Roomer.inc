////////////////////////////////////////////////////////////////////////////////
// Roomer.inc
// Include file with rommer specific Delphi {$define} statements
////////////////////////////////////////////////////////////////////////////////

{$define ROOMERSTORE}


// Defines that can be used to mimic or force behaviour while developing
{$ifdef DEBUG}
  {.$define rmEnableOffLineLogin} // Forced visiblity of Offline login
  {.$define rmForceOffline}       // Force detecting no internet connection
  {.$define rmUseLOCALRESOURCE}
  {.$define rmROOMERSSL}
  {$define rmMONITOR_LEAKAGE} // Report memory leaks on shutdown

  {$define UseFastMM}
{$endif DEBUG}
