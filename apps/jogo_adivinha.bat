@echo off
setlocal enabledelayedexpansion
title MicalOS - Adivinha o Numero

:novo_jogo
cls
echo ========================
echo   ADIVINHA O NUMERO
echo ========================
echo  Estou pensando em um numero entre 1 e 100...
echo.

set /a "SECRETO=(%RANDOM% %% 100) + 1"
set "TENTATIVAS=0"

:tentativa
set /p "PALPITE= Seu palpite: "
set /a "TENTATIVAS+=1"

if %PALPITE% LSS %SECRETO% echo  Muito baixo! Tente maior.
if %PALPITE% GTR %SECRETO% echo  Muito alto! Tente menor.
if %PALPITE% EQU %SECRETO% (
    echo.
    echo  ACERTOU em %TENTATIVAS% tentativas!
    goto fim_jogo
)
echo.
goto tentativa

:fim_jogo
echo.
set /p "JOGAR_NOVO= Jogar novamente? (s/n): "
if /i "%JOGAR_NOVO%"=="s" goto novo_jogo
endlocal
