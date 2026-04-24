@echo off

:: === HTML + CSS ===
echo ^<!DOCTYPE html^>^<html lang="en"^>^<head^>^<meta charset="UTF-8"^> > index.html
echo ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> index.html
echo ^<title^>My Lesson Portal^</title^>^<style^> >> index.html
echo body { font-family: sans-serif; background: #f0f2f5; padding: 20px; text-align: center; } >> index.html
echo .toolbar { display: flex; gap: 10px; align-items: center; max-width: 1200px; margin: 0 auto 24px; flex-wrap: wrap; } >> index.html
echo #search { flex: 1; min-width: 180px; padding: 9px 14px; font-size: 0.95em; border: 2px solid #ddd; border-radius: 6px; outline: none; transition: border-color 0.15s; } >> index.html
echo #search:focus { border-color: #3498db; } >> index.html
echo .sort-btns { display: flex; gap: 6px; } >> index.html
echo .sort-btns button { font-family: inherit; font-size: 0.8em; padding: 7px 13px; border: 2px solid #ddd; border-radius: 6px; background: white; cursor: pointer; transition: 0.15s; color: #555; } >> index.html
echo .sort-btns button:hover { border-color: #3498db; color: #3498db; } >> index.html
echo .sort-btns button.active { border-color: #3498db; background: #3498db; color: white; } >> index.html
echo #count { font-size: 0.8em; color: #999; white-space: nowrap; } >> index.html
echo .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; max-width: 1200px; margin: 0 auto; } >> index.html
echo .card { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-decoration: none; color: #333; border-top: 4px solid #3498db; transition: 0.2s; display: flex; flex-direction: column; justify-content: space-between; min-height: 100px; text-align: left; } >> index.html
echo .card:hover { transform: translateY(-5px); border-top-color: #2ecc71; box-shadow: 0 5px 15px rgba(0,0,0,0.1); } >> index.html
echo .card h3 { margin: 0; font-size: 1.1em; word-break: break-word; } >> index.html
echo .card p { font-size: 0.75em; color: #aaa; margin-top: 10px; } >> index.html
echo .card .date { font-size: 0.7em; color: #bbb; margin-top: 6px; } >> index.html
echo mark { background: #fff3cd; border-radius: 2px; } >> index.html
echo #empty { display: none; color: #aaa; font-size: 0.95em; margin-top: 40px; } >> index.html
echo ^</style^>^</head^>^<body^> >> index.html
echo ^<h1^>My Lesson Portal^</h1^> >> index.html
echo ^<div class="toolbar"^> >> index.html
echo ^<input type="text" id="search" placeholder="Search files..." oninput="render()" autofocus^> >> index.html
echo ^<div class="sort-btns"^> >> index.html
echo ^<button id="btn-name" onclick="setSort('name')"^>A-Z^</button^> >> index.html
echo ^<button id="btn-date" onclick="setSort('date')"^>Recent first^</button^> >> index.html
echo ^</div^>^<span id="count"^>^</span^>^</div^> >> index.html
echo ^<div class="grid" id="grid"^>^</div^>^<p id="empty"^>No files match your search.^</p^> >> index.html
echo ^<script^> >> index.html
echo const FILE_LIST = [ >> index.html

:: === File list with dates ===
:: Two separate loops with exact extension checks to avoid Windows 8.3
:: short-name matching (which causes *.htm to also match *.html files)
setlocal enabledelayedexpansion
for %%f in (*.html) do (
    if /i not "%%f"=="index.html" (
        if /i "%%~xf"==".html" (
            set "fdate=%%~tf"
            echo   { name: "%%f", modified: "!fdate!" }, >> index.html
        )
    )
)
for %%f in (*.htm) do (
    if /i "%%~xf"==".htm" (
        set "fdate=%%~tf"
        echo   { name: "%%f", modified: "!fdate!" }, >> index.html
    )
)
endlocal

:: === JavaScript ===
echo ]; >> index.html
echo let sortMode = 'name'; >> index.html
echo function setSort(mode) { sortMode = mode; document.getElementById('btn-name').classList.toggle('active', mode === 'name'); document.getElementById('btn-date').classList.toggle('active', mode === 'date'); render(); } >> index.html
echo function parseDate(s) { const m = s.match(/(\d+)\/(\d+)\/(\d+)\s+(\d+):(\d+)/); return m ? new Date(m[3], m[2]-1, m[1], m[4], m[5]) : new Date(0); } >> index.html
echo function render() { >> index.html
echo   const q = document.getElementById('search').value.trim().toLowerCase(); >> index.html
echo   const grid = document.getElementById('grid'); >> index.html
echo   const empty = document.getElementById('empty'); >> index.html
echo   const count = document.getElementById('count'); >> index.html
echo   let files = [...FILE_LIST]; >> index.html
echo   if (sortMode === 'name') files.sort((a,b) =^> a.name.localeCompare(b.name)); >> index.html
echo   else files.sort((a,b) =^> parseDate(b.modified) - parseDate(a.modified)); >> index.html
echo   const filtered = q ? files.filter(f =^> f.name.toLowerCase().includes(q)) : files; >> index.html
echo   grid.innerHTML = ''; >> index.html
echo   if (!filtered.length) { empty.style.display='block'; count.textContent=''; return; } >> index.html
echo   empty.style.display = 'none'; >> index.html
echo   count.textContent = filtered.length + ' of ' + files.length; >> index.html
echo   filtered.forEach(f =^> { >> index.html
echo     const a = document.createElement('a'); a.className='card'; a.href=f.name; >> index.html
echo     const display = f.name.replace(/\.(html?)$/i, ''); >> index.html
echo     const h = document.createElement('h3'); >> index.html
echo     const idx = q ? display.toLowerCase().indexOf(q) : -1; >> index.html
echo     if (idx ^>= 0) { >> index.html
echo       const pre = document.createTextNode(display.slice(0,idx)); >> index.html
echo       const mid = document.createElement('mark'); mid.textContent = display.slice(idx,idx+q.length); >> index.html
echo       const post = document.createTextNode(display.slice(idx+q.length)); >> index.html
echo       h.appendChild(pre); h.appendChild(mid); h.appendChild(post); >> index.html
echo     } else { h.textContent = display; } >> index.html
echo     const p = document.createElement('p'); p.textContent = 'Click to open'; >> index.html
echo     a.appendChild(h); a.appendChild(p); >> index.html
echo     if (f.modified) { const d=document.createElement('div'); d.className='date'; d.textContent=f.modified; a.appendChild(d); } >> index.html
echo     grid.appendChild(a); >> index.html
echo   }); >> index.html
echo } >> index.html
echo setSort('name'); >> index.html
echo ^</script^>^</body^>^</html^> >> index.html

echo Done!
pause