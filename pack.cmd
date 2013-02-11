@echo off
setlocal
chcp 1252 > nul
for %%i in (NuGet.exe) do set nuget=%%~dpnx$PATH:i
if "%nuget%"=="" goto :nonuget
pushd "%~dp0"
if not exist dist md dist
if %errorlevel%==0 call :packlib && call :packcs
popd
exit /b %errorlevel%

:packlib
call build /v:m && call :pack TryParsers
goto :EOF

:packcs
call :pack TryParsers.Embedded
goto :EOF

:pack
NuGet pack %1.nuspec -OutputDirectory dist
goto :EOF

:nonuget
echo NuGet executable not found in PATH
echo For more on NuGet, see http://nuget.codeplex.com
exit /b 2
