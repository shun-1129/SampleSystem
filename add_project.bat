@echo off
setlocal

echo �o�b�`�t�@�C���̋N���ʒu: %CD%
:: �����`�F�b�N
if "%~1"=="" (
    echo �v���W�F�N�g�����w�肵�Ă��������B
    echo ��: add_project MyProject
    exit /b 1
)

set ROOT_PATH=%CD%
:: ���̃\�����[�V��������ݒ�
for %%I in (%CD%) do set LAST_DIR=%%~nxI
set SOLUTION_NAME=%LAST_DIR%
set PROJECT_NAME=%1

:: �R���\�[���A�v�����쐬
dotnet new console -n %PROJECT_NAME% --framework net8.0
cd %PROJECT_NAME%
:: �V�����\�����[�V�������쐬
dotnet new sln -n %PROJECT_NAME%
:: �\�����[�V�����Ƀv���W�F�N�g��ǉ�
dotnet sln %PROJECT_NAME%.sln add %PROJECT_NAME%.csproj

cd %ROOT_PATH%
echo %CD%
set CSPROJ_FILE_PATH=%CD%\%PROJECT_NAME%\%PROJECT_NAME%.csproj
echo �ȉ��̃f�B���N�g���p�X
echo %CSPROJ_FILE_PATH%
powershell -ExecutionPolicy Bypass -File modify_csproj.ps1 %CSPROJ_FILE_PATH%
:: �r���h�Ǝ��s
cd %PROJECT_NAME%
dotnet run

cd %ROOT_PATH%
dotnet sln %SOLUTION_NAME%.sln add %CSPROJ_FILE_PATH%

endlocal
