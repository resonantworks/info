@echo off
if "%~1"=="" (
     echo "Usage: jlink-gdb-server <device id>"
     echo "Example: jlink-gdb-server STM32L4S9ZI"
    exit /b 1
)

"C:\Program Files\SEGGER\JLink\JLinkGDBServerCL.exe" -select USB -device %1 -if SWD -speed 8000 -endian little -port 2331 -swoport 2332 -telnetport 2333 -vd -noir -localhostonly 0 -strict -timeout 0 -nogui
