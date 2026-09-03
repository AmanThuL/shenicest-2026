@echo off
chcp 65001 >nul
setlocal
title VS2026 和 Unity IL2CPP 环境安装器

echo 正在启动中文安装程序并请求管理员权限……
echo.
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-VS2026-Unity-IL2CPP.ps1" -NoPause
set "SETUP_EXIT=%ERRORLEVEL%"

echo.
if "%SETUP_EXIT%"=="0" (
    echo 安装与环境检查已通过。
) else (
    echo 安装或环境检查未完全通过，退出码：%SETUP_EXIT%
    echo 请查看同目录下的“安装日志-日期时间.txt”。
)
echo.
pause
exit /b %SETUP_EXIT%
