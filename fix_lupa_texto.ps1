$f = "C:\Users\vramo\Documents\concursos-hipica-fei\src\app\admin\reprises\page.tsx"
Copy-Item -LiteralPath $f -Destination "$f.bak-lupa3" -Force

$c = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
$antes = $c.Length

# ============================================================
# Patrones del emoji lupa roto (ðŸ"□) -> texto "Buscar"
# ============================================================

# "ðŸ"□" = ð + Ÿ + " + □  (con el cuadro blanco al final)
$p1 = [char]0x00F0 + [char]0x0178 + [char]0x201D + [char]0x25A1
# "ðŸ"" = ð + Ÿ + "  (sin cuadro)
$p2 = [char]0x00F0 + [char]0x0178 + [char]0x201D
# "ðŸ" = ð + Ÿ  (base)
$p3 = [char]0x00F0 + [char]0x0178

$cambios = 0
foreach ($p in @($p1, $p2, $p3)) {
    $cnt = ([regex]::Matches($c, [regex]::Escape($p))).Count
    if ($cnt -gt 0) {
        Write-Host "Encontrado ($cnt veces)" -ForegroundColor Yellow
        $c = $c.Replace($p, 'Buscar')
        $cambios += $cnt
    }
}

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "Antes:   $antes bytes"
Write-Host "Despues: $($c.Length) bytes"
Write-Host "Cambios: $cambios"
Write-Host ""

# Verificar
$d = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
Write-Host "Queda 'ðŸ': $($d.Contains([char]0x00F0 + [char]0x0178))"
Write-Host ""
Write-Host "Recarga con Ctrl+Shift+R" -ForegroundColor Yellow