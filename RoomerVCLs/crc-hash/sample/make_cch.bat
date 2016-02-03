@echo off
Echo Make dual OS version of cch     (c) W.Ehrhardt 2003-2009

::comment next line if upx not in path
set pack=upx
set packopt=-9 -qq

::compile 16 bit DOS stub
call p7 -b -q -$I- cch.pas
if not (%pack%)==() %pack% %packopt% cch.exe
move cch.exe cch16.exe

::compile 32 bit PE
echo STUB 'cch16.exe' >cch.def
call vpc -b -q -$H- -$I- cch.pas
if not (%pack%)==() %pack% %packopt% cch.exe

del cch16.exe
del cch.def
