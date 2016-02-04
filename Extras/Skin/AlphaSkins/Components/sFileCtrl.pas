unit sFileCtrl;
{$I sDefs.inc}

{$R-,T-,H+,X+}
interface

uses
  Windows, SysUtils, Classes, Controls, StdCtrls,
  sComboBox;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsFilterComboBox = class(TsCustomComboBox)
{$IFNDEF NOTFORHELP}
  private
    FFilter: string;
    function IsFilterStored: Boolean;
    function GetMask: string;
    procedure SetFilter(const NewFilter: string);
  protected
    procedure Change; override;
    procedure Click; override;
    procedure BuildList;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    MaskList: TStringList;
    procedure CreateWnd; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Mask: string read GetMask;
    property Text;
  published
    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property ImeName;
    property ImeMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
{$ENDIF} // NOTFORHELP
    property Filter: string read FFilter write SetFilter stored IsFilterStored;
  end;


implementation

uses Consts;


procedure TsFilterComboBox.BuildList;
var
  AFilter, MaskName, Mask: string;
  BarPos: Integer;
begin
  Clear;
  MaskList.Clear;
  AFilter := Filter;
  BarPos := AnsiPos('|', AFilter);
  while BarPos <> 0 do begin
    MaskName := Copy(AFilter, 1, BarPos - 1);
    Delete(AFilter, 1, BarPos);
    BarPos := AnsiPos('|', AFilter);
    if BarPos > 0 then begin
      Mask := Copy(AFilter, 1, BarPos - 1);
      Delete(AFilter, 1, BarPos);
    end
    else begin
      Mask := AFilter;
      AFilter := '';
    end;
    Items.Add(MaskName);
    MaskList.Add(Mask);
    BarPos := AnsiPos('|', AFilter);
  end;
  ItemIndex := 0;
end;


procedure TsFilterComboBox.Change;
begin
  inherited Change;
end;


procedure TsFilterComboBox.Click;
begin
  inherited Click;
  Change;
end;


constructor TsFilterComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csDropDownList;
  FFilter := SDefaultFilter;
  MaskList := TStringList.Create;
end;


procedure TsFilterComboBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
end;


destructor TsFilterComboBox.Destroy;
begin
  MaskList.Free;
  inherited Destroy;
end;


function TsFilterComboBox.GetMask: string;
begin
  if ItemIndex < 0 then
    ItemIndex := Items.Count - 1;

  if ItemIndex >= 0 then
    Result := MaskList[ItemIndex]
  else
    Result := '*.*';
end;


function TsFilterComboBox.IsFilterStored: Boolean;
begin
  Result := SDefaultFilter <> FFilter;
end;


procedure TsFilterComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;


procedure TsFilterComboBox.SetFilter(const NewFilter: string);
begin
  if AnsiCompareFileName(NewFilter, FFilter) <> 0 then begin
    FFilter := NewFilter;
    if HandleAllocated then
      BuildList;

    if not (csLoading in ComponentState) then
      Change;
  end;
end;

end.
