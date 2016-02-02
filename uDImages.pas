unit uDImages;

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls, cxGraphics, PngImageList;

type
  TDImages = class(TDataModule)
    cxLargeImagesFlat: TcxImageList;
    cxSmallImagesFlat: TcxImageList;
    cxImagesSmallExtra: TcxImageList;
    images25x25: TcxImageList;
    ilGuests: TImageList;
    PngImageList1: TPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DImages: TDImages;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
