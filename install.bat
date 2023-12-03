@echo off
REM Run python -m venv venv
python -m venv venv

REM Activate virtual environment
venv\Scripts\activate

REM Install dependencies
pip install -r requirements.txt

REM Move to the ./webui directory
cd ..

REM Run yarn install && yarn build && yarn start-api
cd webui
yarn install
yarn build
yarn start-api
