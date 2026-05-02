@echo off
setlocal enabledelayedexpansion
title MicalOS - Calculadora

:calc_menu
cls
echo ========================
echo    CALCULADORA
echo ========================
echo.
set /p "A= Primeiro numero : "
echo  Operacoes: + - * /
set /p "OP= Operacao       : "
set /p "B= Segundo numero  : "

if "%OP%"=="+" set /a "RES=A+B"
if "%OP%"=="-" set /a "RES=A-B"
if "%OP%"=="*" set /a "RES=A*B"
if "%OP%"=="/" (
    if "%B%"=="0" (
        echo  Erro: divisao por zero!
        goto calc_fim
    )
    set /a "RES=A/B"
)

echo.
echo  Resultado: %A% %OP% %B% = %RES%

:calc_fim
echo.
set /p "CONT= Calcular novamente? (s/n): "
if /i "%CONT%"=="s" goto calc_menu
endlocal
