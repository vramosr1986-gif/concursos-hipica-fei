$f = "C:\Users\vramo\Documents\concursos-hipica-fei\src\app\admin\reprises\page.tsx"

# Backup
$bak = "$f.bak-buscar-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Copy-Item -LiteralPath $f -Destination $bak -Force
Write-Host "Backup: $bak" -ForegroundColor Green

$c = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
$antes = $c.Length

# 1. Buscar el bloque del boton (type="submit") y reemplazar TODO su contenido interior por "Buscar"
# Patron: <button type="submit" ...>  ... </button>

$regex = '(?s)(<button[^>]*type="submit"[^>]*>)(.*?)(</button>)'

$reemplazo = '$1Buscar$3'

$c = [regex]::Replace($c, $regex, $reemplazo)

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "Antes:   $antes bytes"
Write-Host "Despues: $($c.Length) bytes"
Write-Host ""

# Verificar
$d = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
Write-Host "Queda 'ðŸ': $($d.Contains([char]0x00F0 + [char]0x0178))"
Write-Host "Queda 'ð':  $($d.Contains([char]0x00F0))"
Write-Host ""

# Mostrar el boton resultado
$m = [regex]::Match($d, '(?s)<button[^>]*type="submit"[^>]*>.*?</button>')
if ($m.Success) {
    Write-Host "Boton nuevo:" -ForegroundColor Cyan
    Write-Host $m.Value
} else {
    Write-Host "No se encontro boton con type=submit" -ForegroundColor Red
}

Write-Host ""
Write-Host "Recarga con Ctrl+Shift+R" -ForegroundColor Yellow