unit uRunWithElevatedOption;

interface

uses
  Windows, ShellAPI, Forms;

type
  TExecuteFileOption = (
    eoHide,
    eoWait,
    eoElevate,
    eoMinimized,
    eoMaximized
  );
  TExecuteFileOptions = set of TExecuteFileOption;

function ExecuteFile(Handle: HWND; const Filename, Paramaters: String; Options: TExecuteFileOptions): Integer;

implementation

function ExecuteFile(Handle: HWND; const Filename, Paramaters: String; Options: TExecuteFileOptions): Integer;
var
  ShellExecuteInfo: TShellExecuteInfo;
  ExitCode: DWORD;
begin
  Result := -1;

  ZeroMemory(@ShellExecuteInfo, SizeOf(ShellExecuteInfo));
  ShellExecuteInfo.cbSize := SizeOf(TShellExecuteInfo);
  ShellExecuteInfo.Wnd := Handle;
  ShellExecuteInfo.fMask := SEE_MASK_NOCLOSEPROCESS;

  if (eoElevate in Options) then //and (IsUACActive) then
    ShellExecuteInfo.lpVerb := PChar('runas');

  ShellExecuteInfo.lpFile := PChar(Filename);

  if Paramaters <> '' then
    ShellExecuteInfo.lpParameters := PChar(Paramaters);

  // Show or hide the window
  if eoHide in Options then
    ShellExecuteInfo.nShow := SW_HIDE
  else
  if eoMaximized in Options then
    ShellExecuteInfo.nShow := SW_SHOWMAXIMIZED
  else
  if eoMinimized in Options then
    ShellExecuteInfo.nShow := SW_SHOWMINIMIZED
  else
    ShellExecuteInfo.nShow := SW_SHOWNORMAL;

  if ShellExecuteEx(@ShellExecuteInfo) then
    Result := 0;

  if (Result = 0) and (eoWait in Options) then
  begin
    GetExitCodeProcess(ShellExecuteInfo.hProcess, ExitCode);

    while (ExitCode = STILL_ACTIVE) and
          (not Application.Terminated) do
    begin
      sleep(50);

      GetExitCodeProcess(ShellExecuteInfo.hProcess, ExitCode);
    end;

    Result := ExitCode;
  end;
end;

end.
