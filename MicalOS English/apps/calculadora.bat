@echo off
setlocal enabledelayedexpansion
title MicalOS - Calculator

:calc_menu
cls
echo ========================
echo    CALCULATOR
echo ========================
echo.
set /p "A= First number  : "
echo  Operations: + - * /
set /p "OP= Operation     : "
set /p "B= Second number : "

if "%OP%"=="+" set /a "RES=A+B"
if "%OP%"=="-" set /a "RES=A-B"
if "%OP%"=="*" set /a "RES=A*B"
if "%OP%"=="/" (
    if "%B%"=="0" (
        echo  Error: division by zero!
        goto calc_fim
    )
    set /a "RES=A/B"
)

echo.
echo  Result: %A% %OP% %B% = %RES%

:calc_fim
echo.
set /p "CONT= Calculate again? (y/n): "
if /i "%CONT%"=="y" goto calc_menu
endlocal
