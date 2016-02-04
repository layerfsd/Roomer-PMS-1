{***************************************************************************}
{ TMS Unicode Component Pack                                                }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ Copyright © 2007 by TMS software                                          }
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

unit TntMaskEdit_Design;

{$INCLUDE ..\Source\TntCompilers.inc}

interface

uses
  Classes, Controls, TntStdCtrls, TntEditMask_Editor, TntMaskEditText_Editor, Forms, dialogs,
  MaskUtils, DesignEditors, DesignIntf;


type

  TEditMaskProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetValue(const Value: String); override;
    function GetValue: String; override;
  end;

  TMaskEditTextProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    procedure SetValue(const Value: String); override;
    function GetValue: String; override;
  end;


procedure Register;
  
implementation

uses
  SysUtils;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TEditMask), TTntMaskEdit, 'EditMask', TEditMaskProperty);
  RegisterPropertyEditor(TypeInfo(WideString), TTntMaskEdit, 'Text', TMaskEditTextProperty);
end;

//------------------------------------------------------------------------------

{ TEditMaskProperty }

function TEditMaskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

//------------------------------------------------------------------------------

procedure TEditMaskProperty.Edit;
var
  EditMaskEditor: TEditMaskForm;
  MaskEdit: TTntMaskEdit;
begin
  if (GetComponent(0) is TTntMaskEdit) then
  begin
    MaskEdit := TTntMaskEdit(GetComponent(0));
    EditMaskEditor := TEditMaskForm.Create(Application);
    EditMaskEditor.SetInputMask(MaskEdit.EditMask);
    try
      if EditMaskEditor.Showmodal = mrOK then
      begin
        MaskEdit.EditMask := EditMaskEditor.Edt_InputMask.Text;
        Modified;
      end;
    finally
      EditMaskEditor.Free;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TEditMaskProperty.SetValue(const Value: String);
begin
  if (GetComponent(0) is TTntMaskEdit) then
    TTntMaskEdit(GetComponent(0)).EditMask := Value;
end;

//------------------------------------------------------------------------------

function TEditMaskProperty.GetValue: String;
begin
  Result:='(EditMask)';
  if (GetComponent(0) is TTntMaskEdit) then
    Result := TTntMaskEdit(GetComponent(0)).EditMask;
end;

//------------------------------------------------------------------------------

{ TMaskEditTextProperty }

function TMaskEditTextProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

//------------------------------------------------------------------------------

procedure TMaskEditTextProperty.Edit;
var
  MaskEditTextEditor: TMaskEditTextForm;
  MaskEdit: TTntMaskEdit;
begin
  if (GetComponent(0) is TTntMaskEdit) then
  begin
    MaskEdit := TTntMaskEdit(GetComponent(0));
    MaskEditTextEditor := TMaskEditTextForm.Create(Application);
    MaskEditTextEditor.TntMEdit_InputText.EditMask := MaskEdit.EditMask;
    MaskEditTextEditor.Lbl_EditMask.Caption := MaskEditTextEditor.TntMEdit_InputText.EditMask;
    MaskEditTextEditor.TntMEdit_InputText.Text := MaskEdit.Text;
    try
      if MaskEditTextEditor.Showmodal = mrOK then
      begin
        MaskEdit.Text := MaskEditTextEditor.TntMEdit_InputText.Text;
        Modified;
      end;
    finally
      MaskEditTextEditor.Free;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TMaskEditTextProperty.SetValue(const Value: String);
begin
  if (GetComponent(0) is TTntMaskEdit) then
    TTntMaskEdit(GetComponent(0)).Text := Value;
end;

//------------------------------------------------------------------------------

function TMaskEditTextProperty.GetValue: String;
begin
  Result:='(Text)';
  if (GetComponent(0) is TTntMaskEdit) then
    Result := TTntMaskEdit(GetComponent(0)).Text;
end;

end.