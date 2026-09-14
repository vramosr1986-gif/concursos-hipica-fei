$f = "C:\Users\vramo\Documents\concursos-hipica-fei\src\app\admin\reprises\page.tsx"
Copy-Item -LiteralPath $f -Destination "$f.bak-lupa4" -Force

$c = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
$antes = $c.Length

# ============================================================
# Limpieza AGRESIVA: cualquier resto del mojibake de la lupa
# ============================================================

# Buscar cualquier secuencia que empiece por ðŸ (independiente de qué siga)
# y sustituirla por "Buscar"

$patron = [char]0x00F0 + [char]0x0178  # ðŸ
$restos = @(
    [char]0x00F0 + [char]0x0178 + [char]0x201D + [char]0x25A1,   # ðŸ"□
    [char]0x00F0 + [char]0x0178 + [char]0x201D,                   # ðŸ"
    [char]0x00F0 + [char]0x0178 + [char]0x201C,                   # ðŸ"
    [char]0x00F0 + [char]0x0178 + [char]0x00A1,                   # ðŸ¡
    [char]0x00F0 + [char]0x0178 + [char]0x2039,                   # ðŸ‹
    [char]0x00F0 + [char]0x0178 + [char]0x20AC,                   # ðŸ€
    [char]0x00F0 + [char]0x0178 + [char]0x00B0,                   # ðŸ°
    [char]0x00F0 + [char]0x0178 + [char]0x2030,                   # ðŸ‰
    [char]0x00F0 + [char]0x0178 + [char]0x017D,                   # ðŸŽ
    [char]0x00F0 + [char]0x0178 + [char]0x00B0,                   # ðŸ°
    [char]0x00F0 + [char]0x0178                                  # ðŸ (base)
)

# Tambien restos sueltos
$restos += [char]0x00F0  # ð solo
$restos += [char]0x0178  # Ÿ solo

$cambios = 0
foreach ($r in $restos) {
    $cnt = ([regex]::Matches($c, [regex]::Escape($r))).Count
    if ($cnt -gt 0) {
        Write-Host "Resto ($cnt): $([System.BitConverter]::ToString([System.Text.Encoding]::UTF8.GetBytes($r)))" -ForegroundColor Yellow
        $c = $c.Replace($r, '')
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
Write-Host "Queda 'ð':  $($d.Contains([char]0x00F0))"
Write-Host ""
Write-Host "Recarga con Ctrl+Shift+R" -ForegroundColor Yellow