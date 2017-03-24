@ECHO OFF
setlocal

SET SOLUTION=Csg.Data.Dapper.sln
SET BUILD_CONFIG=Release
SET TEST_PROJ=
SET EnableNuGetPackageRestore=True

ECHO ----- RESTORING -----
dotnet restore %SOLUTION%
IF ERRORLEVEL 1 GOTO RestoreFail

ECHO ----- BUILDING -----

dotnet build %SOLUTION% --configuration %BUILD_CONFIG%
IF ERRORLEVEL 1 GOTO BuildFail

::ECHO ----- TESTING -----
::dotnet test %TEST_PROJ% --no-build --configuration %BUILD_CONFIG%
::IF ERRORLEVEL 1 GOTO TestFail

ECHO ----- PACKAGING -----
dotnet pack %SOLUTION% --no-build --configuration %BUILD_CONFIG%
IF ERRORLEVEL 1 GOTO PackageFail

GOTO BuildSuccess

:RestoreFail
echo.
echo *** RESTORE FAILED ***
EXIT /b 1

:BuildFail
echo.
echo *** BUILD FAILED ***
EXIT /b 2

:TestFail
echo.
echo *** TESTS FAILED ***
EXIT /b 3

:PackageFail
echo.
echo *** PACKAGING FAILED ***
EXIT /b 4

:BuildSuccess
echo.
echo *** RESTORE + BUILD + TEST SUCCESSFUL ***
goto End

:End
echo DONE