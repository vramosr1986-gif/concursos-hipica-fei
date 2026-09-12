# ============================================================
# backup_bbdd.ps1
# Hace un dump completo de la BBDD de Supabase
# Uso: .\scripts\backup_bbdd.ps1
# ============================================================

$ErrorActionPreference = "Stop"

Write-Host "=== Backup de la BBDD de Concursos FEI ===" -ForegroundColor Cyan

# 1. Leer credenciales de .env.local
if (-not (Test-Path ".\.env.local")) {
  Write-Host "ERROR: no existe .env.local" -ForegroundColor Red
  exit 1
}

$lineasEnv = Get-Content ".\.env.local" -Encoding UTF8
$supabaseUrl = ""
$serviceKey = ""

foreach ($linea in $lineasEnv) {
  $trimLinea = $linea.Trim()
  if ($trimLinea.StartsWith("#")) { continue }

  if ($trimLinea -match '^NEXT_PUBLIC_SUPABASE_URL=(.+)$') {
    $supabaseUrl = $Matches[1].Trim().Trim('"').Trim("'")
  }
  if ($trimLinea -match '^SUPABASE_SERVICE_ROLE_KEY=(.+)$') {
    $serviceKey = $Matches[1].Trim().Trim('"').Trim("'")
  }
}

if (-not $supabaseUrl) {
  Write-Host "ERROR: no se encontro NEXT_PUBLIC_SUPABASE_URL" -ForegroundColor Red
  exit 1
}

if (-not $serviceKey) {
  Write-Host "ERROR: no se encontro SUPABASE_SERVICE_ROLE_KEY" -ForegroundColor Red
  exit 1
}

Write-Host "URL Supabase: $supabaseUrl" -ForegroundColor Gray
Write-Host "Service role: $($serviceKey.Substring(0, 30))..." -ForegroundColor Gray
Write-Host ""

# 2. Crear carpeta de backups con fecha
$fecha = Get-Date -Format "yyyyMMdd_HHmmss"
$backupDir = ".\backups\backup_$fecha"

if (-not (Test-Path ".\backups")) {
  New-Item -ItemType Directory -Path ".\backups" -Force | Out-Null
}
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

Write-Host "Carpeta de backup: $backupDir" -ForegroundColor Yellow
Write-Host ""

# 3. Lista de tablas a exportar
$tablas = @(
  'concursos',
  'jornadas',
  'reprises',
  'ejercicios_reprise',
  'binomios',
  'inscripciones',
  'pruebas',
  'prueba_jueces',
  'participaciones',
  'puntuaciones',
  'equipos',
  'equipo_miembros',
  'niveles',
  'categorias_edad',
  'tipos_prueba',
  'niveles_reprises',
  'profiles',
  'jueces'
)

# 4. Exportar cada tabla via la API REST de Supabase
$total = $tablas.Count
$i = 0

foreach ($tabla in $tablas) {
  $i++
  Write-Host "[$i/$total] Exportando $tabla..." -ForegroundColor Gray -NoNewline

  try {
    $headers = @{
      "apikey" = $serviceKey
      "Authorization" = "Bearer $serviceKey"
      "Accept" = "application/json"
    }

    # Paginacion: descargar en bloques de 1000
    $todasLasFilas = @()
    $offset = 0
    $limite = 1000
    $hayMas = $true

    while ($hayMas) {
      $uri = "${supabaseUrl}/rest/v1/${tabla}?select=*&limit=${limite}&offset=${offset}"
      $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method GET -TimeoutSec 60

      if ($response -is [array]) {
        $todasLasFilas += $response
        if ($response.Count -lt $limite) {
          $hayMas = $false
        } else {
          $offset += $limite
        }
      } else {
        $todasLasFilas += $response
        $hayMas = $false
      }
    }

    $response = $todasLasFilas

    $archivo = Join-Path $backupDir "$tabla.json"
    $response | ConvertTo-Json -Depth 10 | Out-File -FilePath $archivo -Encoding UTF8

    $numRegistros = if ($response -is [array]) { $response.Count } else { 1 }
    Write-Host " OK ($numRegistros registros)" -ForegroundColor Green
  } catch {
    Write-Host " ERROR: $($_.Exception.Message)" -ForegroundColor Red
  }
}

# 5. Guardar metadata del backup
$metadata = @{
  fecha = $fecha
  supabase_url = $supabaseUrl
  tablas = $tablas
  version = "1.0"
}

$metadata | ConvertTo-Json | Out-File -FilePath (Join-Path $backupDir "_metadata.json") -Encoding UTF8

# 6. Crear ZIP del backup
$zipPath = ".\backups\backup_$fecha.zip"
Compress-Archive -Path "$backupDir\*" -DestinationPath $zipPath -Force

Write-Host ""
Write-Host "=== BACKUP COMPLETADO ===" -ForegroundColor Green
Write-Host "Carpeta: $backupDir" -ForegroundColor White
Write-Host "ZIP: $zipPath" -ForegroundColor White
Write-Host ""
Write-Host "Tamano del ZIP:" -ForegroundColor Gray
$tamano = (Get-Item $zipPath).Length / 1KB
Write-Host ("  {0:N2} KB" -f $tamano) -ForegroundColor White