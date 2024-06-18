@echo off

REM Check if Git is installed using winget
winget list -e | findstr /i /C:"Git" >nul
if %errorlevel% neq 0 (
    echo Git is not installed. Installing Git...
    winget install --id Git.Git -e
)

git init
git add .
git remote add origin https://github.com/coffeegrind123/sd-webui.git
git remote update
git checkout main
git submodule update --recursive --remote

cd ".\stable-diffusion-webui-docker\"
git pull
cd ".."
xcopy /s /e /y ".\data" ".\stable-diffusion-webui-docker\data\"

REM https://github.com/AbdBarho/stable-diffusion-webui-docker/wiki/Setup
docker compose --profile download up --build
REM wait until its done, then:
REM docker compose --profile [ui] up --build
REM where [ui] is one of: invoke | auto | auto-cpu | comfy | comfy-cpu
REM docker compose --profile auto up --build
docker compose --profile auto up

REM Close the command prompt after the script finishes
pause
exit
