@echo off
title Kernel DOC generator
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
echo Creating SHIFT.L%S%...

:LOOP1

call :ToBin %B%

if "%S%" EQU "1" set SHIFT=#%%0%Output:~1,6%%Output:~0,1%
if "%S%" EQU "2" set SHIFT=#%%0%Output:~2,5%%Output:~0,2%
if "%S%" EQU "3" set SHIFT=#%%0%Output:~3,4%%Output:~0,3%
if "%S%" EQU "4" set SHIFT=#%%0%Output:~4,3%%Output:~0,4%
if "%S%" EQU "5" set SHIFT=#%%0%Output:~5,2%%Output:~0,5%
if "%S%" EQU "6" set SHIFT=#%%0%Output:~6,1%%Output:~0,6%

if not defined SHIFTL (
	if "%B%" EQU "0" (
		set SHIFTL=SHIFT.L%S%		.DA %SHIFT%
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
if "%S%" NEQ "7" goto LOOP0 

(echo.)>TWIST.TXT

set /a B=0
set TWISTL=
echo Creating TWIST...
:LOOP2

call :ToBin2 %B%
 
if not defined TWISTL (
	if "%B%" EQU "0" (
		set TWISTL=TWIST			.DA #%%%Output%
	) ELSE (
		set TWISTL=				.DA #%%%Output%
		)
) ELSE (
	set TWISTL=%TWISTL%,#%%%Output%
	)

set /a B+=1
set /a MOD=B%%8 

if "%MOD%" EQU "0" (
	(echo %TWISTL%)>>TWIST.TXT
	set TWISTL=
	)

	if "%B%" NEQ "256" goto LOOP2

echo.
echo (I know, this other batch is also stupid ;-)
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

:ToBin2

SET Output=
SET CurrentValue=128
SET InputValue=%1

:TopLoop2
IF !CurrentValue! LEQ !InputValue! (
	SET Output=1!Output!
	SET /A InputValue=!InputValue!-!CurrentValue!
) ELSE (
	SET Output=0!Output!
	) 

If !CurrentValue! EQU 1 GOTO :EOF
SET /A CurrentValue=!CurrentValue!/2

Goto TopLoop2
