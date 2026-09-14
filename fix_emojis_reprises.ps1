$f = "C:\Users\vramo\Documents\concursos-hipica-fei\src\app\admin\reprises\page.tsx"

Copy-Item -LiteralPath $f -Destination "$f.bak-emoji3" -Force

$c = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
$antes = $c.Length

# ============================================================
# Patrones rotos (construidos con codepoints) -> correcto
# ============================================================

$mapa = @()

# --- Emoji búsqueda (lupa) línea 284 ---
# "Ã°Å¸â€<" = Ã + ° + Å + ¸ + â + € + ...
# Lo mejor: borrar toda la secuencia rota
$mapa += @{
    de = ([char]0x00C3 + [char]0x00B0 + [char]0x00C5 + [char]0x00B8 + [char]0x00E2 + [char]0x20AC)
    a  = [char]0xD83D + [char]0xDD0D   # 🔍
}

# --- Emoji "Ver lista plana" (📋) ---
# "ðŸ“‹" = ð + Ÿ + " + ‹
$mapa += @{
    de = ([char]0x00F0 + [char]0x0178 + [char]0x201C + [char]0x2039)
    a  = [char]0xD83D + [char]0xDCCB   # 📋
}

# --- Emoji "Ver agrupado" (📖) ---
# "Ã°Å¸â€œÂ" = Ã + ° + Å + ¸ + â + € + œ + Â
$mapa += @{
    de = ([char]0x00C3 + [char]0x00B0 + [char]0x00C5 + [char]0x00B8 + [char]0x00E2 + [char]0x20AC + [char]0x0153 + [char]0x00C2)
    a  = [char]0xD83D + [char]0xDCD6   # 📖
}

# --- Acento í ---
$mapa += @{
    de = ([char]0x00C3 + [char]0x00AD)
    a  = [char]0x00ED
}

# --- Otras variantes del emoji lupa ---
$mapa += @{
    de = ([char]0x00C3 + [char]0x00B0 + [char]0x00C5 + [char]0x00B8 + [char]0x00E2 + [char]0x20AC + [char]0x00A0)
    a  = [char]0xD83D + [char]0xDD0D
}
$mapa += @{
    de = ([char]0x00C3 + [char]0x00B0 + [char]0x00C5 + [char]0x00B8 + [char]0x00E2 + [char]0x20AC)
    a  = [char]0xD83D + [char]0xDD0D
}

# Aplicar
$cambios = 0
foreach ($m in $mapa) {
    $cnt = ([regex]::Matches($c, [regex]::Escape($m.de))).Count
    if ($cnt -gt 0) {
        $c = $c.Replace($m.de, $m.a)
        $cambios += $cnt
        Write-Host "Reemplazado ($cnt veces): un emoji roto" -ForegroundColor Green
    }
}

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "Antes: $antes bytes"
Write-Host "Despues: $($c.Length) bytes"
Write-Host "Cambios: $cambios"
Write-Host ""
Write-Host "=== VERIFICACION ===" -ForegroundColor Cyan
$d = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
Write-Host "Queda 'Ã°' roto:  $($d.Contains([char]0x00C3 + [char]0x00B0))"
Write-Host "Queda 'ðŸ' roto:  $($d.Contains([char]0x00F0 + [char]0x0178))"
Write-Host "Queda 'Ã­' roto:  $($d.Contains([char]0x00C3 + [char]0x00AD))"
Write-Host ""
Write-Host "Recarga con Ctrl+Shift+R" -ForegroundColor Yellow