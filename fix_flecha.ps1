$f = "C:\Users\vramo\Documents\concursos-hipica-fei\src\app\admin\reprises\page.tsx"
Copy-Item -LiteralPath $f -Destination "$f.bak-flecha" -Force

$c = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
$antes = $c.Length

# ============================================================
# Patrones de flecha rota: "â†'" = â + † + '
# El codepoint correcto: → = U+2192
# ============================================================

$flecha = [char]0x2192   # →

# Patron 1: â + † + '  (el mas comun)
$p1 = [char]0x00E2 + [char]0x2020 + [char]0x0027

# Patron 2: â + † + ’  (comilla tipografica)
$p2 = [char]0x00E2 + [char]0x2020 + [char]0x2019

# Patron 3: â + † + "  (comilla recta)
$p3 = [char]0x00E2 + [char]0x2020 + [char]0x0022

# Patron 4: â + †  (base)
$p4 = [char]0x00E2 + [char]0x2020

# Variantes de la flecha delgada (→, ⟶, ➜)
# Tambien podria ser "â†'ï¸" con un emoji variation selector

$patrones = @($p1, $p2, $p3, $p4)

$cambios = 0
foreach ($p in $patrones) {
    $cnt = ([regex]::Matches($c, [regex]::Escape($p))).Count
    if ($cnt -gt 0) {
        $bytes = [System.BitConverter]::ToString([System.Text.Encoding]::UTF8.GetBytes($p))
        Write-Host "Encontrado patron ($cnt veces): $bytes" -ForegroundColor Yellow
        $c = $c.Replace($p, $flecha)
        $cambios += $cnt
    }
}

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))

Write-Host ""
Write-Host "Antes:   $antes bytes"
Write-Host "Despues: $($c.Length) bytes"
Write-Host "Cambios: $cambios"
Write-Host ""
Write-Host "=== VERIFICACION ===" -ForegroundColor Cyan
$d = [System.IO.File]::ReadAllText($f, [System.Text.UTF8Encoding]::new($false))
Write-Host "Queda 'a-dagger roto': $($d.Contains([char]0x00E2 + [char]0x2020))"
Write-Host ""
Write-Host "Recarga con Ctrl+Shift+R" -ForegroundColor Yellow