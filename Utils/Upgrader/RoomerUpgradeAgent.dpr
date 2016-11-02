program RoomerUpgradeAgent;

uses
  Vcl.Forms,
  uUpgraderMainForm in 'uUpgraderMainForm.pas' {Form1},
  uRunWithElevatedOption in '..\..\uRunWithElevatedOption.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
