@echo off
:: MicalOS App
:: Name: Tic-Tac-Toe
:: Author: MicalOS

setlocal enabledelayedexpansion

goto :menu

:menu
cls
echo  ================================
echo   TIC-TAC-TOE
echo  ================================
echo.
echo  Choose your symbol:
echo.
echo  [1] Play as X
echo  [2] Play as O
echo  [3] Exit
echo.
set /p "OP= Choice: "

if "%OP%"=="1" ( set "P1=X" & set "P2=O" & goto :start )
if "%OP%"=="2" ( set "P1=O" & set "P2=X" & goto :start )
if "%OP%"=="3" goto :quit
goto :menu

:start
set "C1= 1 " & set "C2= 2 " & set "C3= 3 "
set "C4= 4 " & set "C5= 5 " & set "C6= 6 "
set "C7= 7 " & set "C8= 8 " & set "C9= 9 "
set "TURN=%P1%"
set "MOVES=0"
goto :turn

:draw_board
echo.
echo   !C1!^|!C2!^|!C3!
echo   ---+---+---
echo   !C4!^|!C5!^|!C6!
echo   ---+---+---
echo   !C7!^|!C8!^|!C9!
echo.
goto :eof

:turn
cls
echo  ================================
echo   TIC-TAC-TOE  ^|  Turn: %TURN%
echo  ================================
call :draw_board

set /p "POS= Choose a position (1-9): "

:: validate input
if "%POS%"=="1" ( if not "!C1!"==" 1 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="2" ( if not "!C2!"==" 2 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="3" ( if not "!C3!"==" 3 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="4" ( if not "!C4!"==" 4 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="5" ( if not "!C5!"==" 5 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="6" ( if not "!C6!"==" 6 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="7" ( if not "!C7!"==" 7 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="8" ( if not "!C8!"==" 8 " ( echo  Position taken! & pause >nul & goto :turn ) )
if "%POS%"=="9" ( if not "!C9!"==" 9 " ( echo  Position taken! & pause >nul & goto :turn ) )

:: place symbol
if "%POS%"=="1" set "C1= %TURN% "
if "%POS%"=="2" set "C2= %TURN% "
if "%POS%"=="3" set "C3= %TURN% "
if "%POS%"=="4" set "C4= %TURN% "
if "%POS%"=="5" set "C5= %TURN% "
if "%POS%"=="6" set "C6= %TURN% "
if "%POS%"=="7" set "C7= %TURN% "
if "%POS%"=="8" set "C8= %TURN% "
if "%POS%"=="9" set "C9= %TURN% "

set /a "MOVES+=1"

call :check_win
if "!WIN!"=="1" goto :winner

if %MOVES%==9 goto :draw

:: switch turn
if "%TURN%"=="%P1%" ( set "TURN=%P2%" ) else ( set "TURN=%P1%" )
goto :turn

:check_win
set "WIN=0"
set "T= %TURN% "

:: rows
if "!C1!"=="%T%" if "!C2!"=="%T%" if "!C3!"=="%T%" set "WIN=1"
if "!C4!"=="%T%" if "!C5!"=="%T%" if "!C6!"=="%T%" set "WIN=1"
if "!C7!"=="%T%" if "!C8!"=="%T%" if "!C9!"=="%T%" set "WIN=1"
:: columns
if "!C1!"=="%T%" if "!C4!"=="%T%" if "!C7!"=="%T%" set "WIN=1"
if "!C2!"=="%T%" if "!C5!"=="%T%" if "!C8!"=="%T%" set "WIN=1"
if "!C3!"=="%T%" if "!C6!"=="%T%" if "!C9!"=="%T%" set "WIN=1"
:: diagonals
if "!C1!"=="%T%" if "!C5!"=="%T%" if "!C9!"=="%T%" set "WIN=1"
if "!C3!"=="%T%" if "!C5!"=="%T%" if "!C7!"=="%T%" set "WIN=1"
goto :eof

:winner
cls
echo  ================================
echo   TIC-TAC-TOE
echo  ================================
call :draw_board
echo  %TURN% WINS!
echo.
set /p "OP= Play again? (y/n): "
if /i "%OP%"=="y" goto :menu
goto :quit

:draw
cls
echo  ================================
echo   TIC-TAC-TOE
echo  ================================
call :draw_board
echo  DRAW!
echo.
set /p "OP= Play again? (y/n): "
if /i "%OP%"=="y" goto :menu

:quit
endlocal
