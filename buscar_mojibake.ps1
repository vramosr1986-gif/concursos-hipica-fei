Set-Location "C:\Users\vramo\Documents\concursos-hipica-fei"

Write-Host ""
Write-Host "=== BUSCANDO MOJIBAKE EN src/ ===" -ForegroundColor Cyan
Write-Host ""

# Construir patrones con codepoints (no literales)
$patrones = @()
$patrones += [char]0x00C3 + [char]0x00A1   # Ã¡
$patrones += [char]0x00C3 + [char]0x00A9   # Ã©
$patrones += [char]0x00C3 + [char]0x00AD   # Ã
$patrones += [char]0x00C3 + [char]0x00B3   # Ã³
$patrones += [char]0x00C3 + [char]0x00BA   # Ãº
$patrones += [char]0x00C3 + [char]0x00B1   # Ã±
$patrones += [char]0x00F0 + [char]0x0178   # ðŸ
$patrones += [char]0x00E2 + [char]0x2013   # â€“
$patrones += [char]0x00E2 + [char]0x0153   # âœ
$patrones += [char]0x00C2 + [char]0x00B0   # Â°

$archivos = Get-ChildItem -Path .\src -Recurse -Include *.tsx,*.ts,*.css,*.json -File |
    Where-Object { $_.FullName -notmatch 'node_modules|\.next|\.bak' }

$encontrados = @()
foreach ($a in $archivos) {
    $c = [System.IO.File]::ReadAllText($a.FullName, [System.Text.UTF8Encoding]::new($false))
    foreach ($p in $patrones) {
        if ($c.Contains($p)) {
            $rel = $a.FullName.Replace((Get-Location).Path + "\", "")
            $encontrados += $rel
            break
        }
    }
}

if ($encontrados.Count -eq 0) {
    Write-Host "Sin problemas" -ForegroundColor Green
} else {
    Write-Host "Archivos con mojibake: $($encontrados.Count)" -ForegroundColor Yellow
    $encontrados | Sort-Object -Unique | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
}

Write-Host ""
Write-Host "=== FIN ===" -ForegroundColor Cyan