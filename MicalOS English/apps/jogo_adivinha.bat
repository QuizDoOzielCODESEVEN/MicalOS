@echo off
setlocal enabledelayedexpansion
title MicalOS - Guess the Number

:novo_jogo
cls
echo ========================
echo   GUESS THE NUMBER
echo ========================
echo  I'm thinking of a number between 1 and 100...
echo.

set /a "SECRETO=(%RANDOM% %% 100) + 1"
set "TENTATIVAS=0"

:tentativa
set /p "PALPITE= Your guess: "
set /a "TENTATIVAS+=1"

if %PALPITE% LSS %SECRETO% echo  Too low! Try higher.
if %PALPITE% GTR %SECRETO% echo  Too high! Try lower.
if %PALPITE% EQU %SECRETO% (
    echo.
    echo  Correct! You got it in %TENTATIVAS% attempts!
    goto fim_jogo
)
echo.
goto tentativa

:fim_jogo
echo.
set /p "JOGAR_NOVO= Play again? (y/n): "
if /i "%JOGAR_NOVO%"=="y" goto novo_jogo
endlocal
