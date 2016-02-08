unit uFormCreateHook;
interface

uses Forms, WinApi.Windows, vcl.Dialogs, uRoomerLanguage, SysUtils;

var hhk: HHOOK;
    RoomerLanguage : TRoomerLanguage;

procedure InitFormCreateHook;
procedure KillFormCreateHook;

implementation


function CBT_FUNC(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  ClassNameBufferSize = 1024;
var
 hWindow: HWND;
 RetVal : Integer;
 ClassNameBuffer: Array[0..ClassNameBufferSize-1] of Char;
  i: Integer;
begin
  Result := 0;
  if RoomerLanguage = nil then
     exit;
  Result := CallNextHookEx(hhk, nCode, wParam, lParam);
  if nCode<0 then exit;
  case nCode of
    HCBT_ACTIVATE:
//     HCBT_CREATEWND:
    begin
      hWindow := HWND(wParam);
      if (hWindow>0) then
      begin
         RetVal := GetClassName(wParam, ClassNameBuffer, SizeOf(ClassNameBuffer));
         if RetVal>0 then
         begin
            for i := 0 to Application.ComponentCount - 1 do
              if Application.Components[i] is TForm then
                if TForm(Application.Components[i]).Handle = hWindow then
                  RoomerLanguage.TranslateThisForm(TForm(Application.Components[i]));
         end;
      end;
    end;
  end;

end;


procedure InitFormCreateHook;
//var
//  dwThreadID : DWORD;
begin
//  dwThreadID := GetCurrentThreadId;
//  hhk := SetWindowsHookEx(WH_CBT, @CBT_FUNC, hInstance, dwThreadID);
//  if hhk=0 then RaiseLastOSError;
end;

procedure KillFormCreateHook;
begin
//  if (hhk <> 0) then
//    UnhookWindowsHookEx(hhk);
end;

initialization

  RoomerLanguage := nil;

end.
