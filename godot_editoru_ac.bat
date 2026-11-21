@echo off
rem Godot editorunu bu projeyle acar (exe dogrudan calistirilinca editor yerine oyun aciliyor)
start "" "%~dp0Godot_v4.7.1-stable_win64.exe" -e --path "%~dp0."
