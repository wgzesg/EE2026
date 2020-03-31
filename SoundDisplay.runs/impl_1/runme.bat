@echo off

rem  Vivado (TM)
rem  runme.bat: a Vivado-generated Script
rem  Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.


set HD_SDIR=%~dp0
cd /d "%HD_SDIR%"
<<<<<<< HEAD
=======
set PATH=%SYSTEMROOT%\system32;%PATH%
>>>>>>> 2df6aee9930837762d1bca2ec291f2320556f75e
cscript /nologo /E:JScript "%HD_SDIR%\rundef.js" %*
