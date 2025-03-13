@echo off
setlocal

echo バッチファイルの起動位置: %CD%
:: 引数チェック
if "%~1"=="" (
    echo プロジェクト名を指定してください。
    echo 例: add_project MyProject
    exit /b 1
)

set ROOT_PATH=%CD%
:: 元のソリューション名を設定
for %%I in (%CD%) do set LAST_DIR=%%~nxI
set SOLUTION_NAME=%LAST_DIR%
set PROJECT_NAME=%1

:: コンソールアプリを作成
dotnet new console -n %PROJECT_NAME% --framework net8.0
cd %PROJECT_NAME%
:: 新しいソリューションを作成
dotnet new sln -n %PROJECT_NAME%
:: ソリューションにプロジェクトを追加
dotnet sln %PROJECT_NAME%.sln add %PROJECT_NAME%.csproj

cd %ROOT_PATH%
echo %CD%
set CSPROJ_FILE_PATH=%CD%\%PROJECT_NAME%\%PROJECT_NAME%.csproj
echo 以下のディレクトリパス
echo %CSPROJ_FILE_PATH%
powershell -ExecutionPolicy Bypass -File modify_csproj.ps1 %CSPROJ_FILE_PATH%
:: ビルドと実行
cd %PROJECT_NAME%
dotnet run

cd %ROOT_PATH%
dotnet sln %SOLUTION_NAME%.sln add %CSPROJ_FILE_PATH%

endlocal
