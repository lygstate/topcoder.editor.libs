::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::@ECHO OFF

:: Export java settings from registry to a temporary file
START /W REGEDIT /E %Temp%.\java.reg "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft"

:: Find java location
FOR /F "tokens=1* delims==" %%A IN ('TYPE %Temp%.\java.reg ^| FIND "INSTALLDIR"') DO SET JAVA_HOME=%%B
SET JAVA_HOME=%JAVA_HOME:"=%
SET JAVA_HOME=%JAVA_HOME:\\=\%
SET JAVA_HOME

:: Get java version
FOR /F "tokens=1* delims==" %%A IN ('TYPE %Temp%.\java.reg ^| FIND "CurrentVersion"') DO SET JAVA_VERSION=%%B
SET JAVA_VERSION=%JAVA_VERSION:"=%
SET JAVA_VERSION
SET JAVA_VERSION=%JAVA_VERSION:.=%
SET JAVA_VERSION=%JAVA_VERSION:_=%
SET /A JAVA_VERSION=%JAVA_VERSION%

:: Delete temp file
::@DEL %Temp%.\java.reg /S /Q > NUL 2>&1

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


cd /d %~dp0

"%JAVA_HOME%\bin\java.exe" -jar jnlpdownloader.jar ..\topcoder.editor http://www.topcoder.com/contest/arena/ContestAppletProd.jnlp

pause