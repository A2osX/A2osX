@echo off
title Kernel DOC generator
COLOR 2A
prompt ]
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

mode con:cols=80 lines=24

cls
echo                                 Apple //e

(echo.)>SHIFT.L1.TXT
set /a B=0
set SHIFT=				.DA 

:LOOP1

call :ToBin %B%

set SHIFT=%SHIFT% #%Output:~2,6%%Output:~0,1%



set /a B+=1
set /a MOD=B%%4 

if "%MOD%" EQU "0" (
	echo %SHIFT%
	set SHIFT=				.DA 
	)

if "%B%" NEQ "128" goto LOOP1





echo.
echo (I know, this batch is stupid ;-)
echo.
pause
exit 0


:ToBin

SET Output=
SET CurrentValue=64
SET InputValue=%1

:TopLoop
IF !CurrentValue! LEQ !InputValue! (
SET Output=!Output!1
SET /A InputValue=!InputValue!-!CurrentValue!
) ELSE (
SET Output=!Output!0
) 

If !CurrentValue! EQU 1 GOTO :EOF
SET /A CurrentValue=!CurrentValue!/2

Goto TopLoop

