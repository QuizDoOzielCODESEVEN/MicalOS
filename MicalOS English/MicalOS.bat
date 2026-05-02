@echo off
setlocal enabledelayedexpansion
title MicalOS v1.0
color 0A

set "OS_NAME=MicalOS"
set "VERSION=1.0"
set "USER=user"

call :boot
goto shell

:boot
cls
echo.
echo  ███╗   ███╗██╗ ██████╗ █████╗ ██╗      ██████╗ ███████╗
echo  ████╗ ████║██║██╔════╝██╔══██╗██║     ██╔═══██╗██╔════╝
echo  ██╔████╔██║██║██║     ███████║██║     ██║   ██║███████╗
echo  ██║╚██╔╝██║██║██║     ██╔══██║██║     ██║   ██║╚════██║
echo  ██║ ╚═╝ ██║██║╚██████╗██║  ██║███████╗╚██████╔╝███████║
echo  ╚═╝     ╚═╝╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝
echo.
echo                  Version %VERSION% - Starting...
echo.
timeout /t 2 /nobreak >nul
cls
goto :eof

:shell
cls
echo ============================================
echo  %OS_NAME% v%VERSION%  ^|  User: %USER%
echo ============================================
echo  Type 'help' to see available commands
echo ============================================
echo.

:prompt
set "CMD="
set /p "CMD= %USER%@%OS_NAME%> "

if /i "%CMD%"=="help"        goto cmd_ajuda
if /i "%CMD%"=="apps"        goto cmd_apps
if /i "%CMD%"=="calc"        goto cmd_calc
if /i "%CMD%"=="guess"       goto cmd_adivinha
if /i "%CMD%"=="info"        goto cmd_info
if /i "%CMD%"=="clear"       goto cmd_limpar
if /i "%CMD%"=="user"        goto cmd_usuario
if /i "%CMD%"=="exit"        goto cmd_sair

set "CMD_BASE=%CMD:~0,3%"
if /i "%CMD_BASE%"=="run" goto cmd_run

if not "%CMD%"==""           echo  Unknown command: %CMD%. Type 'help'.
echo.
goto prompt

:cmd_ajuda
echo.
echo  Available commands:
echo  ----------------------
echo  help           - Show this list
echo  apps           - List installed apps
echo  calc           - Open the calculator
echo  guess          - Number guessing game
echo  run [file]     - Run a MicalOS .bat app
echo  info           - System information
echo  user           - Change username
echo  clear          - Clear the screen
echo  exit           - Exit MicalOS
echo.
goto prompt

:cmd_apps
echo.
echo  Installed apps:
echo  -----------------------
echo  [1] calc      - Calculator
echo  [2] guess     - Guess the Number
echo  [3] adventure - Shadow Adventure (RPG)
echo.
goto prompt

:cmd_run
set "RUN_ARG=!CMD:~4!"
if "%RUN_ARG%"=="" (
    echo.
    echo  Usage: run [file]
    echo  Example: run apps\myapp.bat
    echo.
    goto prompt
)
if not exist "%RUN_ARG%" (
    echo.
    echo  Error: file '%RUN_ARG%' not found.
    echo.
    goto prompt
)
echo.
echo  Running: %RUN_ARG%
echo.
call "%RUN_ARG%"
goto shell

:cmd_calc
call apps\calculadora.bat
goto shell

:cmd_adivinha
call apps\jogo_adivinha.bat
goto shell

:cmd_info
echo.
echo  System  : %OS_NAME%
echo  Version : %VERSION%
echo  User    : %USER%
echo  Shell   : MicalSHELL
echo.
goto prompt

:cmd_limpar
goto shell

:cmd_usuario
echo.
set /p "NOVO_USER= New username: "
if not "%NOVO_USER%"=="" set "USER=%NOVO_USER%"
echo  Username changed to: %USER%
echo.
goto prompt

:cmd_sair
cls
echo.
echo  Shutting down %OS_NAME%... Goodbye, %USER%!
echo.
timeout /t 2 /nobreak >nul
exit
