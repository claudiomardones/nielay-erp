Write-Host "`n🔍 INFRAESTRUCTURA`n" -ForegroundColor Cyan
cd C:\NIELAY\public_html\nielay-erp
if (Test-Path "artisan") { Write-Host "✅ Laravel" -ForegroundColor Green }
composer show 2>$null | Select-String "filament/filament" | Select-Object -First 1 | ForEach-Object { Write-Host "✅ $_" -ForegroundColor Green }
Write-Host "`n📋 MODELOS:" -ForegroundColor Yellow
Get-ChildItem "app/Models/*.php" | ForEach-Object { $c = Get-Content $_.FullName -Raw; if ($c -match '\$table\s*=\s*[''"]([^''"]+)[''"]') { Write-Host "   ✅ $($_.BaseName) → $($matches[1])" -ForegroundColor Green } }
Write-Host "`n🎨 RESOURCES:" -ForegroundColor Yellow
Get-ChildItem "app/Filament/Resources/*.php" -Exclude "*Pages*" | ForEach-Object { Write-Host "   ✅ $($_.BaseName)" -ForegroundColor Green }
Write-Host ""