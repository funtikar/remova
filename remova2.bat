@echo off

rem clear errorlevel first

echo.
set errorlevel=0
rem unhide folder
pushd %1
dir /ah /b > temp.db
if errorlevel 1 (
echo - No nasty hiding suspicious files found
echo.
echo ...
echo.
goto :noproblem
)
rem disable any potential virus
FOR /F "eol=; tokens=1 delims=, " %%i in (temp.db) do if %%i equ *.exe ren %%i *.mungkin.virus.ini
rem then unhides all them hidden/system files
FOR /F "eol=; tokens=1 delims=, " %%i in (temp.db) do attrib -s -h -r %%i
:noproblem
set errorlevel=0
del /f temp.db
rem deletes malicious shortcut
del *.lnk
echo - Status for if theres any shortcut links removed
echo.
echo Done!
::FOR /F "usebackq delims==" %f IN ('dir /ad /b') DO echo %f
popd
pause
