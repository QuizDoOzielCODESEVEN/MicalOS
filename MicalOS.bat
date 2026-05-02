@echo off
setlocal enabledelayedexpansion
title MicalOS v1.0
color 0A

set "OS_NAME=MicalOS"
set "VERSION=1.0"
set "USER=usuario"

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
echo                  Versao %VERSION% - Iniciando...
echo.
timeout /t 2 /nobreak >nul
cls
goto :eof

:shell
cls
echo ============================================
echo  %OS_NAME% v%VERSION%  ^|  Usuario: %USER%
echo ============================================
echo  Digite 'ajuda' para ver os comandos
echo ============================================
echo.

:prompt
set "CMD="
set /p "CMD= %USER%@%OS_NAME%> "

if /i "%CMD%"=="ajuda"       goto cmd_ajuda
if /i "%CMD%"=="apps"        goto cmd_apps
if /i "%CMD%"=="calc"        goto cmd_calc
if /i "%CMD%"=="adivinha"    goto cmd_adivinha
if /i "%CMD%"=="info"        goto cmd_info
if /i "%CMD%"=="limpar"      goto cmd_limpar
if /i "%CMD%"=="usuario"     goto cmd_usuario
if /i "%CMD%"=="sair"        goto cmd_sair

set "CMD_BASE=%CMD:~0,3%"
if /i "%CMD_BASE%"=="run" goto cmd_run

if not "%CMD%"==""           echo  Comando desconhecido: %CMD%. Digite 'ajuda'.
echo.
goto prompt

:cmd_ajuda
echo.
echo  Comandos disponiveis:
echo  ----------------------
echo  ajuda          - Mostra esta lista
echo  apps           - Lista os aplicativos
echo  calc           - Abre a calculadora
echo  adivinha       - Jogo de adivinhar numero
echo  run [arquivo]  - Executa um app .bat do MicalOS
echo  info           - Informacoes do sistema
echo  usuario        - Mudar nome de usuario
echo  limpar         - Limpa a tela
echo  sair           - Encerra o MicalOS
echo.
goto prompt

:cmd_apps
echo.
echo  Aplicativos instalados:
echo  -----------------------
echo  [1] calc      - Calculadora
echo  [2] adivinha  - Jogo Adivinha o Numero
echo.
goto prompt

:cmd_run
set "RUN_ARG=!CMD:~4!"
if "%RUN_ARG%"=="" (
    echo.
    echo  Uso: run [arquivo]
    echo  Exemplo: run apps\meuapp.bat
    echo.
    goto prompt
)
if not exist "%RUN_ARG%" (
    echo.
    echo  Erro: arquivo '%RUN_ARG%' nao encontrado.
    echo.
    goto prompt
)
echo.
echo  Executando: %RUN_ARG%
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
echo  Sistema : %OS_NAME%
echo  Versao  : %VERSION%
echo  Usuario : %USER%
echo  Shell   : MicalSHELL
echo.
goto prompt

:cmd_limpar
goto shell

:cmd_usuario
echo.
set /p "NOVO_USER= Novo nome de usuario: "
if not "%NOVO_USER%"=="" set "USER=%NOVO_USER%"
echo  Usuario alterado para: %USER%
echo.
goto prompt

:cmd_sair
cls
echo.
echo  Encerrando %OS_NAME%... Ate logo, %USER%!
echo.
timeout /t 2 /nobreak >nul
exit
