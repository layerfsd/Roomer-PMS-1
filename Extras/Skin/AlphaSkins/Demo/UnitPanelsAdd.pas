unit UnitPanelsAdd;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sFrameAdapter, ExtCtrls, sPanel;

type
  TFrameBar = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.DFM}

end.
