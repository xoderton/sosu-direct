@echo off

goto SOSU_START

:SOSU_START
  set /p "SOSU_MIDDLEWARE=Did you install Bun? (Y/N): "

  if /i "%SOSU_MIDDLEWARE%"=="Y" goto MIDDLEWARE_BUN
  if /i "%SOSU_MIDDLEWARE%"=="N" goto MIDDLEWARE_BATCH

  echo "Y" or "N" was expected as input, aborting.
  goto COMMON_EXIT

:MIDDLEWARE_BUN
  bun install > nul 2>&1

  reg add "HKCR\sosu" /v "URL Protocol" /f > nul 2>&1
  reg add "HKCR\sosu\shell\open\command" /ve /d "%cd%/scripts/middleware-bun.bat %cd% %%1" /f > nul 2>&1

  echo Installed "bun" version.
  goto COMMON_EXIT

:MIDDLEWARE_BATCH
  reg add "HKCR\sosu" /v "URL Protocol" /f > nul 2>&1
  reg add "HKCR\sosu\shell\open\command" /ve /d "%cd%/scripts/middleware-batch.bat %%1" /f > nul 2>&1

  echo Installed "batch-only" version.
  goto COMMON_EXIT

:COMMON_EXIT
  exit