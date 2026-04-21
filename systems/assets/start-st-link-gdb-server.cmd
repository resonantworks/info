@echo off
:loop
"%STM32CLT_PATH%/STLink-gdb-server/bin/ST-LINK_gdbserver.exe" -p 61234 -l 1 -d -s  -m 0 -k -cp "%STM32CLT_PATH%/STM32CubeProgrammer/bin"
echo gdbserver exited, restarting in 1s...
goto loop
