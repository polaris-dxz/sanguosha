@echo off
REM Download Avatar Show resources from web.sanguosha.com
REM Author: Luckylele <club.sanguosha.com>

setlocal EnableDelayedExpansion

if not exist avatar (
  mkdir avatar
)
if not exist border (
  mkdir border
)
if not exist background (
  mkdir background
)
if not exist title (
  mkdir title
)

for /f "delims=" %%i in ('ver') do @set a=%%i

:get_bracket
  set a=!a:~1!
  if "%a%" == "" goto :ver_error
  if not "%a:~0,1%" == "[" goto :get_bracket

for /f "tokens=2-3 delims=. " %%i in ('echo %a%') do set version=%%i.%%j

if %version% LEQ 6.1 (
REM Windows 7 or lower version
for /f "tokens=*" %%i in (list.txt) do call :down_win7 %%i
)
if %version% GTR 6.1 (
REM Windows 8 or higher version
for /f "tokens=*" %%i in (list.txt) do call :down_win8 %%i
)


exit /b

:down_win7
  set url=%1
  set out=%url:~47,100%
  if "%out:~0,1%" == "A" set out=%out:~11,100%
  set out=%out:/=\%
  if exist %out% goto :eof
  echo Downloading %out%
  set out=%cd%\%out%
  call winhttpjs.bat %url% -saveTo "%out%"
  exit /b

:down_win8
  set url=%1
  set out=%url:~47,100%
  if "%out:~0,1%" == "A" set out=%out:~11,100%
  if exist %out% goto :eof
  set command="(New-Object Net.WebClient).DownloadFile('%url%', '%out%')"
  echo Downloading %out%
  powershell -Command %command%
  exit /b

:ver_error
  echo ERROR: cannot get windows version

:eof

