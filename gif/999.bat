@echo off
setlocal enabledelayedexpansion
chcp 65001

REM 每次都从0开始重新编号（适合只重命名新文件的场景）
set "counter=0"

for %%F in (*.*) do (
    if /I not "%%~NXF"=="%~NX0" (
        if /I not "%%~NXF"=="px.txt" (
            set "extension=%%~xF"
            set "newname=!counter!!extension!"
            ren "%%F" "!newname!"
            echo 重命名: %%F --^> !newname!
            set /a "counter+=1"
        )
    )
)

echo %counter%>px.txt
echo 文件批量重命名完成，共重命名了 %counter% 个文件
timeout /nobreak /t 2 >nul
chcp 936
exit