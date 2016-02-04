unit sMaskData;
{$I sDefs.inc}

interface

uses
  Windows, Graphics,
  sConst;

type
  TacOutEffData = record
    ColorL,
    ColorT,
    ColorR,
    ColorB: TColor;

    OffsetL,
    OffsetT,
    OffsetR,
    OffsetB,

    WidthL,
    WidthT,
    WidthR,
    WidthB,

    Mask,
    Source, // 0 - None, 2 - Generated, 1 - Mask
    Opacity: integer;
  end;


  TacOutEffArray = array of TacOutEffData; // 0 item - Shadow, 1 - Lowered


  TsMaskData = record
    Bmp: TBitmap;

    ClassName,
    PropertyName: string;

    R: TRect;            // Rectangle of the image piece in MasterBitmap

    ImageCount,          // Count of States, allowed for control (count of images in piece)
    MaskType,            // Type of used mask (0 - not used, 1 - AlphaMask, 2... - reserved)
    BorderWidth,
    DrawMode: smallint;  // Fill type if ImgType is texture (0-tiled, 1-stretched, 2-tiled horizontal top, 3-tiled vertical left, 4-stretched horizontal top,
                         //   5-stretched vertical left, 6-tiled hor. bottom, 7-tiled vert. right, 8-stretched hor. bottom, 9-stretched vert. right, A-discrete tiled,
                         //   B-stretch horz, C-stretch vert)

    ImgType: TacImgType; // itisaBorder, itisaTexture, itisaGlyph //, itisanOldType (default)
    Manager: TObject;

    WL,                  // Border width / Left
    WT,                  // Top
    WR,                  // Right
    WB: smallint;        // Bottom

    CornerType,          // 1 - has transparent pixels, 2 - control region must be changed
    SkinIndex: integer;
  end;
  PsMaskData = ^TsMaskData;

  TsFontColor = record
    Color,          // Text color
    Left,           // Colors
    Top,            //   of
    Right,          //   text
    Bottom: TColor; //   contours
  end;


  TsGenState = record
    GlowSize,                     // Size of text glowing
    ImagePercent,                 // Percent of texture in BG
    TextureIndex,
    Transparency,                 // Transparency of control
    GradientPercent: integer;     // Percent of gradient in BG
    Color,                        // Color of background
    GlowColor:       TColor;      // Color of text glowing
    FontColor:       TsFontColor; // Text color structure
    GradientArray:   TsGradArray;
  end;


  TsProps = array [0..ac_MaxPropsIndex] of TsGenState; // Array of properties for different states of control (0 - normal, 1 - active)


  TsGeneralData = record
    ParentClass,                 // Name of parent skin section (if exists)
    ClassName: string;           // Name of skin section
    Props: TsProps;              // Array of properties for different control states

    UseState2,
    GiveOwnFont,                 // Gives own font color for transparent child
    ReservedBoolean: boolean;    // Reserved

    States,                      // Count of defined control states
    ScrollBorderOffset,          // Internal value which used for calculation of border width
    // Text Glow
    GlowCount,                   // Reserved
    GlowMargin,                  // Margin for glowing effect
    GlowSize,
    HotGlowSize,
    // Initialized values
    BorderIndex,                 // Index of border mask
    ImgTL,                       // Indexes
    ImgTR,                       //   of
    ImgBL,                       //     corner
    ImgBR: integer;              //       images

    HotGlowColor,
    GlowColor: TColor;

    // Outer effect
    OuterMode,
    OuterMask,
    OuterOpacity: integer;
    OuterOffset: TRect;
  end;


  TsMaskArray = array of TsMaskData;
  TsGeneralDataArray = array of TsGeneralData;


function WidthOfImage (const md: TsMaskData): integer;
function HeightOfImage(const md: TsMaskData): integer;
function MkSize       (const md: TsMaskData): TSize; overload;

implementation

uses acntUtils;


function WidthOfImage(const md: TsMaskData): integer;
begin
  case md.ImageCount of
    0:   Result := 0;
    1:   Result := WidthOf(md.R)
    else Result := WidthOf(md.R) div md.ImageCount
  end;
end;


function HeightOfImage(const md: TsMaskData): integer;
begin
  case md.MaskType of
   -1:   Result := 0;
    0:   Result := HeightOf(md.R);
    1:   Result := HeightOf(md.R) div 2
    else Result := HeightOf(md.R) div (md.MaskType + 1)
  end;
end;


function MkSize(const md: TsMaskData): TSize;
begin
  Result.cx := WidthOfImage (md);
  Result.cy := HeightOfImage(md);
end;

end.
