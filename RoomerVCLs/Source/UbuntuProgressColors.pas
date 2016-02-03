//  TUbuntuProgress
//  Colorsets
//
//  Copyright 2008 bei Jonas Döbertin
//  Nähere Informationen siehe UbuntuProgress.pas

unit UbuntuProgressColors;

interface

uses
  Graphics, UbuntuProgress;

type

  TUbuntuProgressColorSetData = packed record
    ColorSet: TUbuntuProgressColorSets;
    Progress: Array[0..13] of TColor;
    JoistLeft: Array[0..15] of TColor;
    JoistRight: Array[0..15] of TColor;
  end;

const
  UbuntuProgressColorSets : Array[TUbuntuProgressColorSets] of TUbuntuProgressColorSetData =
    (
      (
        ColorSet : csOriginal;
        Progress : (
          $009CC3FF,
          $0094BEFF,
          $008CBAFF,
          $0084B6FF,
          $007BAEFF,
          $0073AAFF,
          $006BA6FF,
          $0063A2FF,
          $001071FF,
          $001875FF,
          $00398AFF,
          $0084B6FF,
          $0063A2FF,
          $003182FF
        );
        JoistLeft : (
          $008CB2E7,
          $0084AAE7,
          $007BAAE7,
          $0073A6E7,
          $006B9EE7,
          $006B9AE7,
          $006396E7,
          $005A92E7,
          $000865E7,
          $000865E7,
          $000865E7,
          $001069E7,
          $00317DE7,
          $0073A6E7,
          $005A92E7,
          $002975E7
        );
        JoistRight : (
          $00B5D3FF,
          $00ADCFFF,
          $00A5CBFF,
          $009CC7FF,
          $0094BEFF,
          $0094BEFF,
          $008CBAFF,
          $0084B6FF,
          $00428EFF,
          $00428EFF,
          $00428EFF,
          $004A92FF,
          $0063A2FF,
          $009CC7FF,
          $0084B6FF,
          $005A9EFF
        );
      ),
      (
        ColorSet : csBlue;
        Progress : (
          $00D8B4A9,
          $00D3AFA2,
          $00D1A79A,
          $00CC9E90,
          $00CC9C8C,
          $00C69585,
          $00C48F7D,
          $00C18776,
          $00A0472E,
          $00A34D35,
          $00AF6852,
          $00CC9E90,
          $00C18776,
          $00AF644D
        );
        JoistLeft : (
          $00BF9E95,
          $00BC9A8F,
          $00B78F86,
          $00B5887C,
          $00B28577,
          $00B5897B,
          $00AF8172,
          $00AD7A69,
          $008C3821,
          $008C3821,
          $008C3821,
          $0091402A,
          $009B5845,
          $00B5887C,
          $00AD7A69,
          $009B5641
        );
        JoistRight : (
          $00E0C6BE,
          $00DDBFB5,
          $00D8B6AD,
          $00D6B0A7,
          $00D3AFA2,
          $00D3AFA2,
          $00D1A79A,
          $00CC9E90,
          $00B26C57,
          $00B26C57,
          $00B26C57,
          $00B77661,
          $00C18776,
          $00D6B0A7,
          $00CC9E90,
          $00BC7F60
        );
      ),
      (
        ColorSet : csRed;
        Progress : (
          $00A8AAD3,
          $00A0A2CB,
          $009999CF,
          $009494CA,
          $008E8FCB,
          $008586C2,
          $007C7EBF,
          $00787ABB,
          $002E339A,
          $003738A0,
          $005759A0,
          $008C8ED5,
          $007475C5,
          $005152A2
        );
        JoistLeft : (
          $009496BF,
          $008D8FB8,
          $008686BC,
          $007D7DB3,
          $007475B1,
          $00797AB6,
          $006F71B2,
          $006769AA,
          $0020258C,
          $0020258C,
          $0023248C,
          $002A2B93,
          $00494B92,
          $007678BF,
          $006364B4,
          $00434494
        );
        JoistRight : (
          $00BBBBDF,
          $00B5B5D9,
          $00ACAED6,
          $00A8AAD2,
          $009FA1D1,
          $009FA1D1,
          $009798D0,
          $009192CA,
          $005459AE,
          $005459AE,
          $005759AD,
          $006062B6,
          $007B7CB6,
          $00A4A5DF,
          $008E90D1,
          $006F71B2
        );
      )
    );

implementation

end.
