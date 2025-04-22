@echo off
title Ultremare Systems - Bloqueio Bluetooth
set SCRIPT=%~dp0ultremare_bluetooth_block.ps1

:: Verifica se o script existe
if not exist "%SCRIPT%" (
    echo [ERRO] Script PowerShell não encontrado: %SCRIPT%
    pause
    exit /b
)

:: Executa como admin e mantém janela aberta
powershell -ExecutionPolicy Bypass -NoExit -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -NoExit -File \"%SCRIPT%\"' -Verb RunAs"
