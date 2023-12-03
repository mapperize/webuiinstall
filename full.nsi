# Name of the installer
Outfile "MyInstaller.exe"

# URLs for Python installer, Node.js, Visual Studio Build Tools, and the GitHub repository
!define PythonInstallerURL "https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe"
!define NodeJSInstallerURL "https://nodejs.org/dist/v16.20.2/node-v16.20.2-x64.msi"
!define VSBuildToolsURL "https://aka.ms/vs/17/release/vs_BuildTools.exe"
!define GitHubRepoURL "https://github.com/teejusb/fsr/archive/refs/heads/master.zip"
!define batchfile "https://raw.githubusercontent.com/mapperize/webuiinstall/main/install.bat"

Section

# Set output path to the directory where the installer is located
SetOutPath $EXEDIR

# Create a subdirectory for the installation
CreateDirectory "$EXEDIR\Installation"

# Download and execute the Python installer
inetc::get "${PythonInstallerURL}" "$EXEDIR\Installation\PythonInstaller.exe"
ExecWait '"$EXEDIR\Installation\PythonInstaller.exe" /quiet InstallAllUsers=1 PrependPath=1'

# Download and execute Node.js installer
inetc::get "${NodeJSInstallerURL}" "$EXEDIR\Installation\NodeJSInstaller.msi"
ExecWait 'msiexec /i "$EXEDIR\Installation\NodeJSInstaller.msi" /quiet'

# Download the Visual Studio Build Tools installer
inetc::get "${VSBuildToolsURL}" "$EXEDIR\Installation\VSBuildTools.exe"

# Execute the Visual Studio Build Tools installer
ExecShell 'open' "$EXEDIR\Installation\VSBuildTools.exe"

MessageBox MB_OK "Please install Visual Studio Build Tools. After installation is complete, click OK to continue with the setup."

# Download and extract the GitHub repository
inetc::get "${GitHubRepoURL}" "$EXEDIR\Installation\GitHubRepo.zip"
ExecWait 'powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Path \"$EXEDIR\Installation\GitHubRepo.zip\" -DestinationPath \"$EXEDIR\Installation\GitHubRepo\""'

# Change directory to fsr-master\webui\server
SetOutPath "$EXEDIR\Installation\GitHubRepo\fsr-master\webui\server"

# Edit server.py using the default text editor
ExecWait 'notepad.exe server.py'

# Wait for the user to close the text editor
Sleep 1000 ; Adjust the sleep time as needed

# Download and execute the batch file
inetc::get "${batchfile}" "$EXEDIR\Installation\GitHubRepo\fsr-master\webui\server\webuiinstall.bat"
ExecWait 'cmd.exe /C webuiinstall.bat'
SectionEnd

