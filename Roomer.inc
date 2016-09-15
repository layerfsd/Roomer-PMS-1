////////////////////////////////////////////////////////////////////////////////
// Roomer.inc
// Include file with rommer specific Delphi {$define} statements
////////////////////////////////////////////////////////////////////////////////

{$define ROOMERSTORE}


// Defines that can be used to mimic or force behaviour while developing
{$ifdef DEBUG}
  {.$define rmEnableOffLineLogin} // Forced visiblity of Offline login
  {.$define rmForceOffline}       // Force detecting no internet connection
  {.$define rmROOMERSSL}
  {$define rmMONITOR_LEAKAGE}     // Report memory leaks on shutdown
  {$define DISABLEOFFLINEREPORTS} // turn off offline reports for easier debugging
  {.$define UseEditInvoice2015}   //
{$endif DEBUG}


{$define UseFastMM}

