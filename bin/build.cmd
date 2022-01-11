@ECHO OFF
@REM resolve for lua executable
call :RESOLVEPATH ".\bin\lua\lua54.exe"
set lua_exec=%RETVAL%
if not exist %lua_exec% goto :cancel

@REM look out for yarn command
where /q yarn
if %ERRORLEVEL% neq 0 goto :canceled

@REM resolve for input script
call :RESOLVEPATH ".\src\main.lua"
set main_script=%RETVAL%
if not exist %main_script% goto :canceled

@REM resolve for output script
call :RESOLVEPATH ".\dist\bundle.lua"
set output_script=%RETVAL%

@REM start bundle
echo bundling...

set lua_paths=-p .\?.lua -p .\?\?.lua -p .\?\init.lua -p ? -p .\src\?.lua

cmd /c yarn --silent run luabundler bundle "%main_script%" %lua_paths% -o "%output_script%" 

@REM resolve for minified output script
call :RESOLVEPATH ".\dist\bundle.min.lua"
set minified_output_script=%RETVAL%

@REM start minified version
echo minifying...
yarn --silent run luamin -f %output_script% > %minified_output_script%

:: ========== FUNCTIONS ==========
EXIT /B

:canceled
echo something went wrong!
EXIT 1

:RESOLVEPATH
  SET RETVAL=%~f1
  EXIT /B