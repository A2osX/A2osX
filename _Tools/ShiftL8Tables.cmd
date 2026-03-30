@echo off
title Shift table generator
COLOR 2A
prompt ]
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

mode con:cols=80 lines=24

cls
echo                                 Apple //e

(echo.)>SHIFT.TXT

SET S=1

:LOOP0
set /a B=0
set SHIFTL=
echo Creating SHIFT8.L%S%...

:LOOP1

call :ToBin %B%

if "%S%" EQU "1" set SHIFT=#%%%Output:~1,7%%Output:~0,1%
if "%S%" EQU "2" set SHIFT=#%%%Output:~2,6%%Output:~0,2%
if "%S%" EQU "3" set SHIFT=#%%%Output:~3,5%%Output:~0,3%
if "%S%" EQU "4" set SHIFT=#%%%Output:~4,4%%Output:~0,4%
if "%S%" EQU "5" set SHIFT=#%%%Output:~5,3%%Output:~0,5%
if "%S%" EQU "6" set SHIFT=#%%%Output:~6,2%%Output:~0,6%
if "%S%" EQU "7" set SHIFT=#%%%Output:~7,2%%Output:~0,7%

if not defined SHIFTL (
	if "%B%" EQU "0" (
		set SHIFTL=SHIFT8.L%S%		.DA %SHIFT%
	) ELSE (
		set SHIFTL=				.DA %SHIFT%
		)
) ELSE (
	set SHIFTL=%SHIFTL%,%SHIFT%
	)

set /a B+=1
set /a MOD=B%%8 

if "%MOD%" EQU "0" (
	(echo %SHIFTL%)>>SHIFT.TXT
	set SHIFTL=
	)

if "%B%" NEQ "128" goto LOOP1

set /a S+=1
if "%S%" NEQ "8" goto LOOP0 

echo.
echo (I know, this other batch is also stupid ;-)
echo.
pause
exit 0


:ToBin

SET Output=
SET CurrentValue=128
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

