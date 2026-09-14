Set-Location "C:\Users\vramo\Documents\concursos-hipica-fei"

Write-Host ""
Write-Host "=== ARREGLANDO MOJIBAKE ===" -ForegroundColor Cyan
Write-Host ""

$mapa = @()

# Acentos
$mapa += @{ de = ([char]0x00C3 + [char]0x00A1); a = [char]0x00E1 }  # a-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x00A9); a = [char]0x00E9 }  # e-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x00AD); a = [char]0x00ED }  # i-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x00B3); a = [char]0x00F3 }  # o-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x00BA); a = [char]0x00FA }  # u-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x00B1); a = [char]0x00F1 }  # n-tilde
$mapa += @{ de = ([char]0x00C3 + [char]0x00BC); a = [char]0x00FC }  # u-umlaut
$mapa += @{ de = ([char]0x00C3 + [char]0x0081); a = [char]0x00C1 }  # A-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x0089); a = [char]0x00C9 }  # E-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x008D); a = [char]0x00CD }  # I-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x0091); a = [char]0x00D1 }  # N-tilde
$mapa += @{ de = ([char]0x00C3 + [char]0x201C); a = [char]0x00D3 }  # O-acute
$mapa += @{ de = ([char]0x00C3 + [char]0x0161); a = [char]0x00DA }  # U-acute

# Emojis
$mapa += @{ de = ([char]0x00F0 + [char]0x0178 + [char]0x201C + [char]0x2039); a = [char]0xD83D + [char]0xDCCB }  # clipboard
$mapa += @{ de = ([char]0x00F0 + [char]0x0178 + [char]0x201C + [char]0x2018); a = [char]0xD83D + [char]0xDCD6 }  # book
$mapa += @{ de = ([char]0x00F0 + [char]0x0178 + [char]0x017D + [char]0x00AF); a = [char]0xD83C + [char]0xDFAF }  # target
$mapa += @{ de = ([char]0x00F0 + [char]0x0178 + [char]0x2020); a = [char]0xD83C + [char]0xDFC6 }                 # trophy
$mapa += @{ de = ([char]0x00F0 + [char]0x0178 + [char]0x2018 + [char]0x00A4); a = [char]0xD83D + [char]0xDC64 }  # user
$mapa += @{ de = ([char]0x00F0 + [char]0x0178 + [char]0x201C + [char]0x2026); a = [char]0xD83D + [char]0xDCC5 }  # calendar
$mapa += @{ de = ([char]0x00F0 + [char]0x0178 + [char]0x00A5 + [char]0x2021); a = [char]0xD83E + [char]0xDD47 }  # gold medal

# Simbolos
$mapa += @{ de = ([char]0x00E2 + [char]0x2013 + [char]0x00BC); a = [char]0x25BC }
$mapa += @{ de = ([char]0x00E2 + [char]0x2013 + [char]0x00B2); a = [char]0x25B2 }
$mapa += @{ de = ([char]0x00E2 + [char]0x2013 + [char]0x00BA); a = [char]0x25BA }
$mapa += @{ de = ([char]0x00E2 + [char]0x0153 + [char]0x201C); a = [char]0x2713 }
$mapa += @{ de = ([char]0x00E2 + [char]0x0153 + [char]0x2014); a = [char]0x2717 }
$mapa += @{ de = ([char]0x00E2 + [char]0x00A0 + [char]0x00EF); a = [char]0x23F1 }
$mapa += @{ de = ([char]0x00C2 + [char]0x00B7); a = [char]0x00B7 }
$mapa += @{ de = ([char]0x00C2 + [char]0x00BA); a = [char]0x00BA }

$archivos = Get-ChildItem -Path .\src -Recurse -Include *.tsx,*.ts,*.css,*.json -File |
    Where-Object { $_.FullName -notmatch 'node_modules|\.next|\.bak' }

$tA = 0
$tC = 0
foreach ($a in $archivos) {
    $c = [System.IO.File]::ReadAllText($a.FullName, [System.Text.UTF8Encoding]::new($false))
    $orig = $c
    $cnt = 0
    foreach ($m in $mapa) {
        if ($c.Contains($m.de)) {
            $n = ([regex]::Matches($c, [regex]::Escape($m.de))).Count
            $c = $c.Replace($m.de, $m.a)
            $cnt += $n
        }
    }
    if ($c -ne $orig) {
        $bak = "$($a.FullName).bak-moj"
        if (-not (Test-Path -LiteralPath $bak)) {
            Copy-Item -LiteralPath $a.FullName -Destination $bak -Force
        }
        [System.IO.File]::WriteAllText($a.FullName, $c, [System.Text.UTF8Encoding]::new($false))
        $rel = $a.FullName.Replace((Get-Location).Path + "\", "")
        Write-Host "OK: $rel ($cnt)" -ForegroundColor Green
        $tA++
        $tC += $cnt
    }
}

Write-Host ""
Write-Host "=== RESULTADO ===" -ForegroundColor Cyan
Write-Host "Archivos modificados: $tA"
Write-Host "Reemplazos totales: $tC"
Write-Host ""
Write-Host "Recarga la web con Ctrl+Shift+R" -ForegroundColor Yellow