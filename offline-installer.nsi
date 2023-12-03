!include MUI2.nsh

# Various Installer Details
Name "WebUI Installer"
OutFile "FSR-Webui-Installer.exe"
Unicode True

RequestExecutionLevel user

!define MUI_LICENSE "License.txt"

# URLs for Python installer, Node.js, Visual Studio Build Tools, and the GitHub repository
!define PythonInstallerURL "C:\Users\(your username)\Documents\installer\python-3.9.7-amd64.exe"
!define NodeJSInstallerURL "C:\Users\(your username)\Documents\installer\node-v16.20.2-x64.msi"
!define VSBuildToolsURL "C:\Users\(your username)\Documents\installer\vs_BuildTools.exe"
!define GitHubRepoURL "C:\Users\(your username)\Documents\installer\fsr-master.zip"
!define batchfile "C:\Users\(your username)\Documents\installer\webuiinstall.bat"

# Modern UI Interface Config and Pages
!define MUI_WELCOMEPAGE_TITLE "FSR Web UI Installer"
!define MUI_WELCOMEPAGE_TEXT "This installer will install the FSR WebUI"
!define MUI_LICENSEPAGE_TEXT_TOP "GNU GENERAL PUBLIC LICENSE"
!define MUI_DIRECTORYPAGE_TEXT_TOP "Select where to install WebUI"
!define MUI_DIRECTORYPAGE_VARIABLE $INSTDIR
!define MUI_FINISHPAGE_TITLE "The installer has finished"
!define MUI_FINISHPAGE_TEXT "https://github.com/teejusb/fsr"
!define MUI_FINISHPAGE_RUN "$INSTDIR\fsr-master\webui\start-webui.bat"
!define MUI_FINISHPAGE_RUN_TEXT "Run WebUI after finished?"

!define MUI_FINISHPAGE_NOAUTOCLOSE
!define XPStyle off
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE License.txt
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

Section

# Set output path to the directory where the installer is located
SetOutPath $INSTDIR

# Create a subdirectory for the installation
CreateDirectory "$INSTDIR\"

# Download and execute the Python installer
File /oname=$TEMP\PythonInstaller.exe "${PythonInstallerURL}"
ExecWait '"$TEMP\PythonInstaller.exe" /quiet InstallAllUsers=1 PrependPath=1'
Delete "$TEMP\PythonInstaller.exe"

# Download and execute Node.js installer
File /oname=$TEMP\NodeJSInstaller "${NodeJSInstallerURL}"
ExecWait 'msiexec /i "$TEMP\NodeJSInstaller.msi" /quiet'
Delete "$TEMP\NodeJSInstaller.msi"

# Download the Visual Studio Build Tools installer
File /oname=$TEMP\VSBuildTools.exe "${VSBuildToolsURL}"

# Execute the Visual Studio Build Tools installer
ExecShell 'open' "$TEMP\VSBuildTools.exe"

MessageBox MB_OK "Please install Visual Studio Build Tools. After installation is complete, click OK to continue with the setup."

# Download and extract the GitHub repository
File /oname=$TEMP\GitHubRepo.zip "${GitHubRepoURL}"
ExecWait 'powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Path \"$TEMP\GitHubRepo.zip\" -DestinationPath \"$INSTDIR\""'
Delete "$TEMP\GitHubRepo.zip"

# Change directory to fsr-master\webui\server
SetOutPath "$INSTDIR\fsr-master\webui\server"

# Edit server.py using the default text editor
ExecWait 'notepad.exe server.py'

# Wait for the user to close the text editor
Sleep 1000 ; Adjust the sleep time as needed

# Download and execute the batch file
File /oname=$INSTDIR\fsr-master\webui\server\webuiinstall.bat "${batchfile}"
ExecWait 'cmd.exe /C webuiinstall.bat'

SectionEnd
