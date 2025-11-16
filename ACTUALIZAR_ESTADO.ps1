param([Parameter(Mandatory=$true)][string]$Descripcion, [string]$ProximoPaso = "[DEFINIR]")
cd C:\NIELAY\public_html\nielay-erp
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$fecha = Get-Date -Format "yyyy-MM-dd"
$hora = Get-Date -Format "HH:mm"
$content = Get-Content "ESTADO_PROYECTO.md" -Raw -Encoding UTF8
$content = $content -replace '(?<=\*\*Último cambio:\*\* ).*', $Descripcion
$content = $content -replace '(?<=\*\*Próximo paso:\*\* ).*', $ProximoPaso
$nuevoHistorial = "`n### $fecha $hora`n- ✅ $Descripcion"
$content = $content -replace '(## HISTORIAL)', "`$1$nuevoHistorial"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("$PWD\ESTADO_PROYECTO.md", $content, $utf8NoBom)
Write-Host "`n✅ Estado actualizado: $Descripcion`n" -ForegroundColor Green