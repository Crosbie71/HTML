@echo off
setlocal enabledelayedexpansion

:: 1. Start the file and the Header
echo ^<!DOCTYPE html^>^<html^>^<head^>^<title^>My HTML Lessons^</title^> > index.html
echo ^<style^> >> index.html
echo body { font-family: sans-serif; background: #f0f2f5; padding: 20px; text-align: center; } >> index.html
echo .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; max-width: 1200px; margin: 0 auto; } >> index.html
echo .card { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-decoration: none; color: #333; border-top: 4px solid #3498db; transition: 0.2s; display: flex; flex-direction: column; justify-content: space-between; min-height: 100px; } >> index.html
echo .card:hover { transform: translateY(-5px); border-top-color: #2ecc71; box-shadow: 0 5px 15px rgba(0,0,0,0.1); } >> index.html
echo h3 { margin: 0; font-size: 1.1em; word-wrap: break-word; overflow-wrap: break-word; white-space: normal; } >> index.html
echo p { font-size: 0.8em; color: #666; margin-top: 10px; } >> index.html
echo ^</style^>^</head^>^<body^> >> index.html
echo ^<h1^>My Lesson Portal^</h1^>^<div class="grid"^> >> index.html

:: 2. The Updated Loop (Now scans for .html and .htm)
for %%f in (*.htm) do (
    if /i not "%%f"=="index.html" (
        set "fname=%%~nf"
        echo ^<a href="%%f" class="card"^>^<h3^>!fname!^</h3^>^<p^>Click to Open^</p^>^</a^> >> index.html
    )
)

:: 3. Close it up
echo ^</div^>^</body^>^</html^> >> index.html

echo Pretty Index Updated (including .htm files)!
pause