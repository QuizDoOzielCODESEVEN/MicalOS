@echo off
:: MicalOS App
:: Name: Shadow Adventure 2 - The Ancient
:: Author: MicalOS

setlocal enabledelayedexpansion

set "HP=100"
set "ATK=25"
set "GOLD=50"
set "HAS_ARMOR=0"
set "HAS_MAP=0"
set "PANTANO_DONE=0"
set "MINAS_DONE=0"

call :start
goto :eof

:: ================================================
:start
cls
echo  ================================================
echo   SHADOW ADVENTURE 2 - THE ANCIENT
echo  ================================================
echo.
echo  The Shadow Lord has been defeated.
echo  But an even older force awakens...
echo  Tremors shake the ground. The sky darkens.
echo.
echo  A messenger arrives at the village:
echo  "THE ANCIENT stirs in the Forgotten Ruins.
echo   Only the shadow hero can stop it."
echo.
pause >nul
goto :hub

:: ================================================
:status
echo  ------------------------------------------------
echo  HP: !HP!  ^|  ATK: !ATK!  ^|  GOLD: !GOLD!
if "!HAS_ARMOR!"=="1" echo  [Armor equipped - damage reduced]
echo  ------------------------------------------------
goto :eof

:: ================================================
:hub
cls
echo  === GREY STONE VILLAGE ===
echo.
call :status
echo.
echo  [1] Blacksmith Shop
echo  [2] Cursed Swamp
echo  [3] Abandoned Mines
echo  [4] Forgotten Ruins
echo  [5] Rest (restores HP)
echo  [6] Exit
echo.
set /p "OP= Choice: "

if "%OP%"=="1" goto :shop
if "%OP%"=="2" goto :pantano
if "%OP%"=="3" goto :minas
if "%OP%"=="4" goto :ruinas_gate
if "%OP%"=="5" goto :rest
if "%OP%"=="6" goto :quit
goto :hub

:: ================================================
:rest
cls
echo  You rest at the inn...
set /a "HP=HP+40"
if %HP% GTR 100 set "HP=100"
echo  HP restored! Current HP: %HP%
echo.
pause >nul
goto :hub

:: ================================================
:shop
cls
echo  === BLACKSMITH SHOP ===
echo.
call :status
echo.
echo  [1] Iron Armor      (50 gold, reduces damage)
echo  [2] Sacred Elixir   (20 gold, HP +60)
echo  [3] Ruins Map       (30 gold, required)
echo  [4] Back
echo.
set /p "OP= Choice: "

if "%OP%"=="1" goto :buy_armor
if "%OP%"=="2" goto :buy_elixir
if "%OP%"=="3" goto :buy_map
if "%OP%"=="4" goto :hub
goto :shop

:buy_armor
if %HAS_ARMOR%==1 ( echo  You already have armor! & pause >nul & goto :shop )
if %GOLD% LSS 50  ( echo  Not enough gold! & pause >nul & goto :shop )
set /a "GOLD=GOLD-50"
set "HAS_ARMOR=1"
echo  Armor equipped! Damage received reduced by 5.
pause >nul
goto :shop

:buy_elixir
if %GOLD% LSS 20 ( echo  Not enough gold! & pause >nul & goto :shop )
set /a "GOLD=GOLD-20"
set /a "HP=HP+60"
if %HP% GTR 100 set "HP=100"
echo  Elixir used! HP is now %HP%.
pause >nul
goto :shop

:buy_map
if %HAS_MAP%==1 ( echo  You already have the map! & pause >nul & goto :shop )
if %GOLD% LSS 30 ( echo  Not enough gold! & pause >nul & goto :shop )
set /a "GOLD=GOLD-30"
set "HAS_MAP=1"
echo  Ruins Map obtained!
pause >nul
goto :shop

:: ================================================
:pantano
cls
echo  === CURSED SWAMP ===
echo.
if "%PANTANO_DONE%"=="1" (
    echo  The swamp is quiet. You already cleared this area.
    echo.
    pause >nul
    goto :hub
)
echo  The air is heavy and foul.
echo  Creatures move in the dark waters...
echo.
echo  [1] Explore the shore
echo  [2] Dive into the depths
echo  [3] Back
echo.
set /p "OP= Choice: "

if "%OP%"=="1" goto :pantano_margem
if "%OP%"=="2" goto :pantano_fundo
if "%OP%"=="3" goto :hub
goto :pantano

:pantano_margem
cls
echo  A GIANT LEECH emerges from the mud!
echo.
pause >nul
call :battle "GIANT LEECH" 50 12 25
if %HP% LEQ 0 goto :death
echo.
echo  You find a vial of poison on the ground.
echo  Your attack increases! ATK +5
set /a "ATK=ATK+5"
echo  ATK is now %ATK%.
echo.
pause >nul
goto :pantano_fundo_check

:pantano_fundo
cls
echo  You dive into the black waters...
echo  A THREE-HEADED HYDRA appears!
echo.
pause >nul
call :battle "THREE-HEADED HYDRA" 70 18 40
if %HP% LEQ 0 goto :death
echo.
echo  At the bottom, a sealed chest! You gain 40 gold.
set /a "GOLD=GOLD+40"
echo  Current gold: %GOLD%
echo.
pause >nul
set "PANTANO_DONE=1"
goto :hub

:pantano_fundo_check
set "PANTANO_DONE=1"
goto :hub

:: ================================================
:minas
cls
echo  === ABANDONED MINES ===
echo.
if "%MINAS_DONE%"=="1" (
    echo  The mines are empty. You already explored everything.
    echo.
    pause >nul
    goto :hub
)
echo  Dark tunnels and stone walls.
echo  The floor creaks with every step.
echo.
echo  [1] Follow the main tunnel
echo  [2] Take the side tunnel
echo  [3] Back
echo.
set /p "OP= Choice: "

if "%OP%"=="1" goto :minas_principal
if "%OP%"=="2" goto :minas_lateral
if "%OP%"=="3" goto :hub
goto :minas

:minas_principal
cls
echo  You advance through the tunnel...
echo  The floor gives way! You fall into a trap!
set /a "HP=HP-20"
echo  Lost 20 HP! Current HP: %HP%
echo.
if %HP% LEQ 0 goto :death
echo  But at the bottom of the trap there is a STONE GOLEM!
echo.
pause >nul
call :battle "STONE GOLEM" 65 15 35
if %HP% LEQ 0 goto :death
echo.
echo  Inside the Golem was an energy crystal.
echo  ATK +8!
set /a "ATK=ATK+8"
echo  ATK is now %ATK%.
echo.
pause >nul
set "MINAS_DONE=1"
goto :hub

:minas_lateral
cls
echo  The side tunnel leads to a secret chamber.
echo  A MINE SPECTER guards the treasure!
echo.
pause >nul
call :battle "MINE SPECTER" 45 22 45
if %HP% LEQ 0 goto :death
echo.
echo  The chamber was full of gold!
echo  You gain 60 gold!
set /a "GOLD=GOLD+60"
echo  Current gold: %GOLD%
echo.
pause >nul
set "MINAS_DONE=1"
goto :hub

:: ================================================
:ruinas_gate
cls
echo  === FORGOTTEN RUINS ===
echo.
if "%HAS_MAP%"=="0" (
    echo  You don't know the way to the ruins.
    echo  Buy the Ruins Map at the shop.
    echo.
    pause >nul
    goto :hub
)
if "%PANTANO_DONE%"=="0" (
    echo  You feel you are not ready yet.
    echo  Explore the Cursed Swamp first.
    echo.
    pause >nul
    goto :hub
)
if "%MINAS_DONE%"=="0" (
    echo  You feel you are not ready yet.
    echo  Explore the Abandoned Mines first.
    echo.
    pause >nul
    goto :hub
)
echo  The map guides you to ancient ruins.
echo  Broken columns and old symbols on the walls.
echo  The ground trembles. A voice echoes:
echo.
echo  "YOU SHOULD NOT HAVE COME HERE..."
echo.
pause >nul
goto :ruinas

:ruinas
cls
echo  === FORGOTTEN RUINS - FINAL CHAMBER ===
echo.
echo  A colossal figure emerges from the shadows.
echo  Eyes like dead stars. Voice like thunder.
echo.
echo  "I AM THE ANCIENT. BEFORE ALL. AFTER ALL."
echo  "YOU ARE MERELY AN INSECT."
echo.
pause >nul
call :battle "THE ANCIENT" 150 28 100
if %HP% LEQ 0 goto :death
goto :victory

:: ================================================
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

set /a "DMG_PLAYER=ATK + (%RANDOM% %% 8)"
set /a "DMG_ENEMY=E_ATK + (%RANDOM% %% 6)"

if "%HAS_ARMOR%"=="1" set /a "DMG_ENEMY=DMG_ENEMY-5"
if %DMG_ENEMY% LSS 1 set "DMG_ENEMY=1"

set /a "E_HP=E_HP-DMG_PLAYER"
set /a "HP=HP-DMG_ENEMY"

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

:: ================================================
:death
cls
echo  ================================================
echo   YOU DIED...
echo  ================================================
echo.
echo  The Ancient remains. Darkness wins.
echo  Gold collected: %GOLD%
echo.
pause >nul
goto :eof

:victory
cls
echo  ================================================
echo   THE ANCIENT WAS DEFEATED!
echo  ================================================
echo.
echo  The earth stops trembling.
echo  The sky clears for the first time in centuries.
echo  You are remembered forever as the hero
echo  who saved the world twice.
echo.
echo  ----------------------------------------
echo  Final gold : %GOLD%
echo  Final HP   : %HP%
echo  Final ATK  : %ATK%
echo  ----------------------------------------
echo.
pause >nul
goto :eof

:quit
cls
echo  Until next time, adventurer...
echo.
pause >nul
endlocal
