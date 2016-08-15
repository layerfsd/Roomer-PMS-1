unit acWebBrowser;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  SysUtils, Classes, Variants, SHDocVw, MSHTML, Activex, Messages, Windows, Controls,
  sCommonData, acWB;

  
type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsWebBrowser = class(TWebBrowser)
{$IFNDEF NOTFORHELP}
  private
    FCommonData: TsScrollWndData;
  protected
    ListSW: TacWBWnd;
  public
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
{$ENDIF}
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
  end;


implementation

uses sConst, sMessages, sVCLUtils, acSBUtils, sStyleSimply;


procedure RefreshWBScrolls(SkinData: TsScrollWndData; var ListSW: TacWBWnd);
var
  sp: TacSkinParams;
begin
  if SkinData.Skinned then begin
    if (ListSW <> nil) and ListSW.Destroyed then
      FreeAndNil(ListSW);

    if ListSW = nil then
      ListSW := TacWBWnd.Create(TWinControl(SkinData.FOwnerControl).Handle, SkinData, SkinData.SkinManager, sp);
  end
  else
    if ListSW <> nil then
      FreeAndNil(ListSW);
end;


procedure TsWebBrowser.AfterConstruction;
begin
  inherited AfterConstruction;
  FCommonData.Loaded;
end;


constructor TsWebBrowser.Create(AOwner: TComponent);
begin
  FCommonData := TsScrollWndData.Create(Self);
  FCommonData.COC := COC_TsEdit;
  inherited Create(AOwner);
end;


destructor TsWebBrowser.Destroy;
begin
  if ListSW <> nil then
    FreeAndNil(ListSW);

  FreeAndNil(FCommonData);
  inherited;
end;


procedure TsWebBrowser.Loaded;
begin
  inherited;
  FCommonData.Loaded;
  RefreshWBScrolls(SkinData, ListSW);
end;


procedure TsWebBrowser.WndProc(var Message: TMessage);
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  if Message.Msg = SM_ALPHACMD then
    case Message.WParamHi of
      AC_CTRLHANDLED: begin
        Message.Result := 1;
        Exit;
      end; // AlphaSkins supported

      AC_SETNEWSKIN:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          CommonWndProc(Message, FCommonData);
          Exit;
        end;

      AC_REMOVESKIN:
        if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
          if ListSW <> nil then
            FreeAndNil(ListSW);

          CommonWndProc(Message, FCommonData);
          RecreateWnd;
          Exit;
        end;

      AC_REFRESH:
        if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then begin
          CommonWndProc(Message, FCommonData);
          RefreshWBScrolls(SkinData, ListSW);
          if HandleAllocated and Visible then
            RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);

          Exit;
        end;

      AC_GETDEFINDEX: begin
        if FCommonData.SkinManager <> nil then
          Message.Result := FCommonData.SkinManager.ConstData.Sections[ssEdit] + 1;

        Exit;
      end;
    end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else 
    if not CommonWndProc(Message, FCommonData) then begin
      inherited;
      case Message.Msg of
        CM_SHOWINGCHANGED:
          RefreshWBScrolls(SkinData, ListSW);
      end;
    end;
end;

end.

