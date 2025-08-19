@echo off
setlocal enabledelayedexpansion
chcp 65001
set "folder=%cd%"

REM 检查是否存在px.txt，如果不存在则创建
if not exist "px.txt" echo 0>px.txt

set /p lastCounter=<px.txt
if not defined lastCounter set "lastCounter=0"
set "counter=!lastCounter!"

REM 只重命名非数字开头的文件（避免重复重命名已处理的文件）
for %%F in (*.*) do (
    if /I not "%%~NXF"=="%~NX0" (
        if /I not "%%~NXF"=="px.txt" (
            set "filename=%%~NF"
            set "extension=%%~xF"
            
            REM 检查文件名是否已经是纯数字格式
            set "isNumeric=1"
            for /f "delims=0123456789" %%i in ("!filename!") do set "isNumeric=0"
            
            REM 只重命名非数字文件名的文件
            if "!isNumeric!"=="0" (
                set "newname=!counter!!extension!"
                ren "%%F" "!newname!"
                echo 重命名: %%F --^> !newname!
                set /a "counter+=1"
            )
        )
    )
)

echo %counter%>px.txt
echo 文件批量重命名完成，共处理了 %counter% 个文件
timeout /nobreak /t 2 >nul
chcp 936
exit