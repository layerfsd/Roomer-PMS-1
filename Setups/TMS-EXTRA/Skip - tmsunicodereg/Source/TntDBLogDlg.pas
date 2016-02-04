{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 - 2008 by TMS software                                   }
{ Email : info@tmssoftware.com                                              }
{ Web : http://www.tmssoftware.com                                          }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit TntDBLogDlg;

{$INCLUDE TntCompilers.inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics,  
  TntForms, TntStdCtrls, TntExtCtrls, StdCtrls, ExtCtrls, Controls;

type
  TTntLoginDialog = class(TTntForm)
    Panel: TTntPanel;
    Bevel: TTntBevel;
    DatabaseName: TTntLabel;
    OKButton: TTntButton;
    CancelButton: TTntButton;
    Panel1: TTntPanel;
    Label1: TTntLabel;
    Label2: TTntLabel;
    Label3: TTntLabel;
    Password: TTntEdit;
    UserName: TTntEdit;
    procedure FormShow(Sender: TObject);
  end;

{TNT-WARN LoginDialog}
function TntLoginDialog(const ADatabaseName: WideString;
  var AUserName, APassword: WideString): Boolean;

{TNT-WARN LoginDialogEx}
function TntLoginDialogEx(const ADatabaseName: WideString;
  var AUserName, APassword: WideString; NameReadOnly: Boolean): Boolean;

{TNT-WARN RemoteLoginDialog}
function TntRemoteLoginDialog(var AUserName, APassword: WideString): Boolean;

implementation

{$R *.dfm}

uses
  Forms, VDBConsts;

function TntLoginDialog(const ADatabaseName: WideString;
  var AUserName, APassword: WideString): Boolean;
begin
  with TTntLoginDialog.Create(Application) do
  try
    DatabaseName.Caption := ADatabaseName;
    UserName.Text := AUserName;
    Result := False;
    if AUserName = '' then ActiveControl := UserName;
    if ShowModal = mrOk then
    begin
      AUserName := UserName.Text;
      APassword := Password.Text;
      Result := True;
    end;
  finally
    Free;
  end;
end;

function TntLoginDialogEx(const ADatabaseName: WideString;
  var AUserName, APassword: WideString; NameReadOnly: Boolean): Boolean;
begin
  with TTntLoginDialog.Create(Application) do
  try
    DatabaseName.Caption := ADatabaseName;
    UserName.Text := AUserName;
    Result := False;
    if NameReadOnly then
      UserName.Enabled := False
    else
      if AUserName = '' then ActiveControl := UserName;
    if ShowModal = mrOk then
    begin
      AUserName := UserName.Text;
      APassword := Password.Text;
      Result := True;
    end;
  finally
    Free;
  end;
end;

function TntRemoteLoginDialog(var AUserName, APassword: WideString): Boolean;
begin
  with TTntLoginDialog.Create(Application) do
  try
    Caption := SRemoteLogin;
    Bevel.Visible := False;
    DatabaseName.Visible := False;
    Label3.Visible := False;
    Panel.Height := Panel.Height - Bevel.Top;
    OKButton.Top := OKButton.Top - Bevel.Top;
    CancelButton.Top := CancelButton.Top - Bevel.Top;
    Height := Height - Bevel.Top;
    UserName.Text := AUserName;
    Result := False;
    if AUserName = '' then ActiveControl := UserName;
    if ShowModal = mrOk then
    begin
      AUserName := UserName.Text;
      APassword := Password.Text;
      Result := True;
    end;
  finally
    Free;
  end;
end;

{ TTntLoginDialog }

procedure TTntLoginDialog.FormShow(Sender: TObject);
begin
  if (DatabaseName.Width + DatabaseName.Left) >= Panel.ClientWidth then
    DatabaseName.Width := (Panel.ClientWidth - DatabaseName.Left) - 5;
end;

end.
