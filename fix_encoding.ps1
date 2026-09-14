Set-Location "C:\Users\vramo\Documents\concursos-hipica-fei"

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  DIAGNOSTICO DE MOJIBAKE EN src/" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Patrones que indican mojibake
$patrones = @(
    'Ã¡', 'Ã©', 'Ã', 'Ã³', 'Ãº', 'Ã±', 'Ã¼', 'Ã‘', 'Ã‰', 'Ã"',
    'ðŸ', 'â–', 'âœ', 'â ï', 'â€', 'Â°', 'Â¡'
)

$archivos = Get-ChildItem -Path .\src -Recurse -Include *.tsx,*.ts,*.css,*.json -File |
    Where-Object { $_.FullName -notmatch 'node_modules|\.next|\.bak' }

$encontrados = @()

foreach ($a in $archivos) {
    $c = [System.IO.File]::ReadAllText($a.FullName, [System.Text.UTF8Encoding]::new($false))
    $coincidencias = @()
    foreach ($p in $patrones) {
        $count = ([regex]::Matches($c, [regex]::Escape($p))).Count
        if ($count -gt 0) {
            $coincidencias += "$p ($count)"
        }
    }
    if ($coincidencias.Count -gt 0) {
        $rel = $a.FullName.Replace((Get-Location).Path + '\', '')
        $encontrados += [PSCustomObject]@{
            Archivo = $rel
            Patrones = ($coincidencias -join ', ')
        }
    }
}

if ($encontrados.Count -eq 0) {
    Write-Host "  Sin problemas de codificacion" -ForegroundColor Green
} else {
    Write-Host "Archivos con mojibake: $($encontrados.Count)" -ForegroundColor Yellow
    Write-Host ""
    $encontrados | Format-Table -AutoSize -Wrap
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  FIN" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan