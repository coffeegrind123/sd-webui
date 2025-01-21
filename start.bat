@echo off

REM Check if Git is installed using winget
winget list -e | findstr /i /C:"Git" >nul
if %errorlevel% neq 0 (
    echo Git is not installed. Installing Git...
    winget install --id Git.Git -e
)

set "directory=.\stable-diffusion-webui-docker"

if exist "%directory%" (
    echo Directory exists. Pulling from the repository.
    cd "%directory%"
    git pull
) else (
    echo Directory does not exist. Cloning from the repository.
    git clone https://github.com/simonmcnair/stable-diffusion-webui-docker "%directory%"
    cd "%directory%"
)

xcopy /s /e /y "..\replace\stable-diffusion-webui-docker" ".\"

REM Check if it's the first run
if not exist first_run.txt (
    echo First run detected. Running download and auto profiles.
    docker compose --profile download up --build
    docker compose --profile auto up --build
    echo First run completed.>first_run.txt
) else (
    echo Subsequent run detected. Running auto profile only.
    docker compose --profile auto up
)

REM Close the command prompt after the script finishes
pause
exit
