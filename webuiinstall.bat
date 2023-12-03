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
    echo Creating start-webui.bat in the current directory...
    REM Create start-webui.bat in the current directory
    echo @echo off > "start-webui.bat"
    echo start "" http://localhost:5000/ >> "start-webui.bat"
    echo cd "webui" >> "start-webui.bat"
    echo yarn start-api >> "start-webui.bat"
    echo Start-webui.bat created.

    echo.
    echo Script execution complete.
)
