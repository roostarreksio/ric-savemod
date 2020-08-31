@ECHO OFF
CLS
ECHO Wybierz akcje:
ECHO.
ECHO 1.Zainstaluj moda
ECHO 2.Odinstaluj moda
ECHO 3.Importuj zapisy gry
ECHO 4.Wyjdz
ECHO.

CHOICE /C 1234 /M "Twoj wybor:"

IF ERRORLEVEL 4 GOTO Wyjdz
IF ERRORLEVEL 3 GOTO Przenies zapisy gry
IF ERRORLEVEL 2 GOTO Odinstaluj
IF ERRORLEVEL 1 GOTO Zainstaluj

:Zainstaluj

for /F "usebackq delims=" %%G in ("%~dp0modfiles\modfilelist.txt") do if not exist "%~dp0%%G.bak" copy "%~dp0%%G" "%~dp0%%G.bak" && echo Backup %%~nxG && echo.

for /F "usebackq delims=" %%G in ("%~dp0modfiles\modfilelist.txt") do (
	echo %%~nxG:
	echo Konwersja EOL
	for %%E in (""\r\n" "\n"", ""\n" "\r\n"") do "%~dp0modfiles\fart.exe" -q -C "%~dp0%%G" %%~E
	"%~dp0modfiles\AMkd.exe" "%~dp0%%G"
	for %%D in ("%~dp0%%G.dek") do if %%~zD==0 (del %%D && echo Rodzaj: Niezakodowany) else (
		echo Rodzaj: Zakodowany
		copy "%~dp0%%G.dek" "%~dp0%%G" && del "%~dp0%%G.dek"
		echo Zdekodowano
		)
	echo.
)

echo Modyfikacja plikow: && echo.

for /F "usebackq delims=" %%f in ("%~dp0modfiles\fullpatch.txt") do "%~dp0modfiles\fart.exe" "%~dp0%%f

echo. && echo Wgrywanie nowej struktury plikow zapisu: && echo.

for %%S in (save, save\slot0, save\slot1, save\slot2, save\slot3, save\slot4) do (
	for %%F in ("%~dp0modfiles\%%S\*") do if not exist "%~dp0Common\%%S\%%~nxF" (
	xcopy "%%F" "%~dp0Common\%%S\" /Y /Q && echo Utworzono %%S\%%~nxF) else (echo %%S\%%~nxF juz istnieje)
)
if not exist "%~dp0Common\save\slot0\" (mkdir "%~dp0Common\save\slot0" && echo Utworzono save\slot0\) else (echo save\slot0\ juz istnieje)

echo. && echo Koniec instalacji && echo.

pause

GOTO End

:Odinstaluj

for /F "usebackq delims=" %%G in ("%~dp0modfiles\modfilelist.txt") do (
	if exist "%~dp0%%G.bak" (
	xcopy "%~dp0%%G.bak" "%~dp0%%G" /Y /q && del "%~dp0%%G.bak" && echo Przywrocono kopie zapasowa %%~nxG
	) else (echo Brak kopii zapasowej %%~nxG)

)

echo. && echo Koniec dezinstalacji && echo.

pause

GOTO End

:Przenies zapisy gry
ECHO. && ECHO.
ECHO Gdzie znajduja sie pliki zapisu:
ECHO.
ECHO 1.W folderze glownym gry
ECHO 2.W VirtualStore
ECHO.

CHOICE /C 12 /M "Twoj wybor:"

IF ERRORLEVEL 2 set "ImportPath=%LOCALAPPDATA%\VirtualStore%~p0" && goto Import
IF ERRORLEVEL 1 set "ImportPath=%~dp0" && goto Import

:Import
for %%f in (0, 1, 2, 3, 4) do (
	for %%A in ("%ImportPath%Common\*") do @echo %%A | >nul findstr %%f.ARR && xcopy "%%A" "%ImportPath%Common\save\slot%%f\" /y /q && echo Importowanie %%~nxA
	for %%A in ("%ImportPath%Common\*") do @echo %%A | >nul findstr %%f.DTA && xcopy "%%A" "%ImportPath%Common\save\slot%%f\" /y /q && echo Importowanie %%~nxA
)

for %%f in (1, 2, 3, 4) do xcopy "%ImportPath%Common\m_shot%%f.img" "%ImportPath%Common\save\slot%%f\" /y /q && echo Importowanie m_shot%%f.img

for %%f in (PAGE.IMG, SAVE.IMG, SETTINGS.ARR, ZOOM.IMG) do xcopy "%ImportPath%Common\%%f" "%ImportPath%Common\save\" /y /q && echo Importowanie %%~nxf

xcopy "%ImportPath%Common\DODOS*.SAV" "%ImportPath%Common\save\" /y /q && echo Importowanie DODOS.SAV

@echo off
setlocal enabledelayedexpansion

for %%b in (0, 1, 2, 3, 4) do (
	for %%f in ("%ImportPath%Common\save\slot%%b\*%%b.???") do (
		set "filename=%%~nf"
		if exist "%%~dpf!filename:~0,-1!%%~xf" del "%%~dpf!filename:~0,-1!%%~xf"
		ren "%%f" "!filename:~0,-1!%%~xf"
		echo Zmiana nazwy %%~nf
	)
)

echo. && echo Koniec importowania && echo.

pause


GOTO End

:Wyjdz

GOTO End
	
pause