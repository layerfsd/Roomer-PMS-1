(*************************************************************************

 DESCRIPTION     :  GUI demo for CRC/HASH

 REQUIREMENTS    :  D2-D6

 EXTERNAL DATA   :  ---

 MEMORY USAGE    :  ---

 DISPLAY MODUS   :  ---

 REFERENCES      :  ---


 Version  Date      Author      Modification
 -------  --------  -------     ------------------------------------------
 0.10     18.03.02  we          Initial version
 0.20     06.05.03  we          With hints, info button, icon, version info
 0.30     02.11.03  we          Without DLL



(*-------------------------------------------------------------------------
 (C) Copyright 2002-2004 Wolfgang Ehrhardt

 This software is provided 'as-is', without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.

 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it
 freely, subject to the following restrictions:

 1. The origin of this software must not be misrepresented; you must not
    claim that you wrote the original software. If you use this software in
    a product, an acknowledgment in the product documentation would be
    appreciated but is not required.

 2. Altered source versions must be plainly marked as such, and must not be
    misrepresented as being the original software.

 3. This notice may not be removed or altered from any source distribution.
----------------------------------------------------------------------------*)

program gch;

uses
  Forms,
  chksum_u in 'chksum_u.pas' {CS_Main};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TCS_Main, CS_Main);
  Application.Run;
end.
