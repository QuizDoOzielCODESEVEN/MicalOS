@echo off
:: MicalOS App
:: Name: Shadow Adventure
:: Author: MicalOS

setlocal enabledelayedexpansion

set "HP=100"
set "ATK=10"
set "GOLD=0"
set "HAS_SWORD=0"
set "HAS_KEY=0"

call :start
goto :eof

:start
cls
echo  ================================================
echo   SHADOW ADVENTURE
echo  ================================================
echo.
echo  You wake up in a dark forest.
echo  Around you, only silence and shadows.
echo  A mission awaits you...
echo.
pause >nul
goto :village

:status
echo  ------------------------------------------------
echo  HP: %HP%  ^|  ATK: %ATK%  ^|  GOLD: %GOLD%
echo  ------------------------------------------------
goto :eof

:village
cls
echo  === GREY STONE VILLAGE ===
echo.
call :status
echo.
echo  You arrive at a small village.
echo  What do you want to do?
echo.
echo  [1] Go to the shop
echo  [2] Explore the forest
echo  [3] Enter the castle
echo  [4] Rest (restores HP)
echo  [5] Quit game
echo.
set /p "OP= Choice: "

if "%OP%"=="1" goto :shop
if "%OP%"=="2" goto :forest
if "%OP%"=="3" goto :castle_gate
if "%OP%"=="4" goto :rest
if "%OP%"=="5" goto :quit
goto :village

:rest
cls
echo  You rest at the inn...
set /a "HP=HP+30"
if %HP% GTR 100 set "HP=100"
echo  HP restored! Current HP: %HP%
echo.
pause >nul
goto :village

:shop
cls
echo  === SHOP ===
echo.
call :status
echo.
echo  [1] Buy Sword    (30 gold, ATK +15)
echo  [2] Buy Potion   (10 gold, HP  +40)
echo  [3] Buy Key      (20 gold)
echo  [4] Back
echo.
set /p "OP= Choice: "

if "%OP%"=="1" goto :buy_sword
if "%OP%"=="2" goto :buy_potion
if "%OP%"=="3" goto :buy_key
if "%OP%"=="4" goto :village
goto :shop

:buy_sword
if %HAS_SWORD%==1 ( echo  You already have a sword! & pause >nul & goto :shop )
if %GOLD% LSS 30  ( echo  Not enough gold! & pause >nul & goto :shop )
set /a "GOLD=GOLD-30"
set /a "ATK=ATK+15"
set "HAS_SWORD=1"
echo  Sword purchased! ATK is now %ATK%.
pause >nul
goto :shop

:buy_potion
if %GOLD% LSS 10 ( echo  Not enough gold! & pause >nul & goto :shop )
set /a "GOLD=GOLD-10"
set /a "HP=HP+40"
if %HP% GTR 100 set "HP=100"
echo  Potion used! HP is now %HP%.
pause >nul
goto :shop

:buy_key
if %HAS_KEY%==1 ( echo  You already have a key! & pause >nul & goto :shop )
if %GOLD% LSS 20 ( echo  Not enough gold! & pause >nul & goto :shop )
set /a "GOLD=GOLD-20"
set "HAS_KEY=1"
echo  Mysterious key purchased!
pause >nul
goto :shop

:forest
cls
echo  === DARK FOREST ===
echo.
echo  You enter the dense forest.
echo  Suddenly, a GOBLIN appears!
echo.
pause >nul
call :battle "GOBLIN" 30 8 15
if %HP% LEQ 0 goto :death
echo.
echo  You find a chest with 20 gold!
set /a "GOLD=GOLD+20"
echo  Current gold: %GOLD%
echo.
pause >nul
goto :village

:castle_gate
cls
echo  === CASTLE GATE ===
echo.
if "%HAS_KEY%"=="0" (
    echo  The gate is locked.
    echo  You need a key to enter.
    echo.
    pause >nul
    goto :village
)
echo  You use the key. The gate opens with a creak...
pause >nul
goto :castle

:castle
cls
echo  === SHADOW CASTLE ===
echo.
echo  Dark corridors and extinguished torches.
echo  At the end, you see the SHADOW LORD!
echo.
pause >nul
call :battle "SHADOW LORD" 80 20 50
if %HP% LEQ 0 goto :death
goto :victory

:: :battle "NAME" ENEMY_HP ENEMY_ATK GOLD_REWARD
:battle
set "E_NOME=%~1"
set /a "E_HP=%~2"
set /a "E_ATK=%~3"
set /a "E_GOLD=%~4"

:battle_loop
cls
echo  === BATTLE: %E_NOME% ===
echo.
echo  Your HP    : %HP%
echo  Enemy HP   : %E_HP%
echo.
echo  [1] Attack
echo  [2] Flee
echo.
set /p "OP= Choice: "

if "%OP%"=="2" (
    echo  You fled!
    pause >nul
    goto :eof
)

set /a "DMG_PLAYER=ATK + (%RANDOM% %% 5)"
set /a "DMG_ENEMY=E_ATK + (%RANDOM% %% 5)"
set /a "E_HP=E_HP - DMG_PLAYER"
set /a "HP=HP - DMG_ENEMY"

echo.
echo  You dealt %DMG_PLAYER% damage!
echo  %E_NOME% dealt %DMG_ENEMY% damage!

if %E_HP% LEQ 0 (
    echo.
    echo  %E_NOME% was defeated!
    set /a "GOLD=GOLD+E_GOLD"
    echo  You earned %E_GOLD% gold!
    pause >nul
    goto :eof
)
if %HP% LEQ 0 goto :eof
pause >nul
goto :battle_loop

:death
cls
echo  ================================================
echo   YOU DIED...
echo  ================================================
echo.
echo  Your journey ends here.
echo  Gold collected: %GOLD%
echo.
pause >nul
goto :eof

:victory
cls
echo  ================================================
echo   YOU WON!
echo  ================================================
echo.
echo  The Shadow Lord was defeated!
echo  The village is saved!
echo.
echo  Final gold: %GOLD%
echo  Final HP  : %HP%
echo.
pause >nul
goto :eof

:quit
cls
echo  Until next time, adventurer...
echo.
pause >nul
endlocal
