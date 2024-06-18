@echo off

REM Check if Git is installed using winget
winget list -e | findstr /i /C:"Git" >nul
if %errorlevel% neq 0 (
    echo Git is not installed. Installing Git...
    winget install --id Git.Git -e
)

REM https://github.com/AbdBarho/stable-diffusion-webui-docker/wiki/Setup
git init
git remote add origin https://github.com/coffeegrind123/sd-webui.git
git branch --set-upstream-to=origin/main main
git pull
git submodule update --recursive --remote
xcopy /s /e /y ".\data" ".\stable-diffusion-webui-docker\data\"
cd ".\stable-diffusion-webui-docker\"
docker compose --profile download up --build
REM wait until its done, then:
REM docker compose --profile [ui] up --build
REM where [ui] is one of: invoke | auto | auto-cpu | comfy | comfy-cpu
REM docker compose --profile auto up --build
docker compose --profile auto up

REM Close the command prompt after the script finishes
pause
exit
