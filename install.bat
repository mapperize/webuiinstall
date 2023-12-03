@echo off

REM Redirect output to a log file
> install_log.txt (
    echo Installing Yarn globally...
    REM Install Yarn globally
    npm install -g yarn
    echo Yarn installation complete.

    echo.
    echo Running python -m venv venv...
    REM Run python -m venv venv
    python -m venv venv
    echo Virtual environment created.

    echo.
    echo Activating virtual environment...
    REM Activate virtual environment
    venv\Scripts\activate
    echo Virtual environment activated.

    echo.
    echo Installing dependencies...
    REM Install dependencies
    pip install -r requirements.txt
    echo Dependencies installed.

    echo.
    echo Moving to the ./webui directory...
    REM Move to the ./webui directory
    cd ..

    echo.
    echo Running yarn install...
    REM Run yarn install
    cd webui
    yarn install
    echo Yarn installation in webui complete.

    echo.
    echo Running yarn build...
    REM Run yarn build
    yarn build
    echo Yarn build complete.

    echo.
    echo Running yarn start-api...
    REM Run yarn start-api
    yarn start-api
    echo Yarn start-api complete.

    echo.
    echo Script execution complete.
)

REM Keep the Command Prompt window open
pause
