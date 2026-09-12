# ============================================================
# restore_bbdd.ps1
# Restaura la BBDD desde un backup
# Uso: .\scripts\restore_bbdd.ps1 -BackupZip ".\backups\backup_XXXX.zip"
# ============================================================

param(
  [Parameter(Mandatory=$true)]
  [string]$BackupZip
)

$ErrorActionPreference = "Stop"

Write-Host "=== Restaurando BBDD desde $BackupZip ===" -ForegroundColor Cyan
Write-Host ""

# 1. Verificar que existe el ZIP
if (-not (Test-Path $BackupZip)) {
  Write-Host "ERROR: no existe $BackupZip" -ForegroundColor Red
  exit 1
}

# 2. Leer credenciales
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

# 3. Extraer el ZIP en una carpeta temporal
$tempDir = ".\backups\_temp_restore_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
Expand-Archive -Path $BackupZip -DestinationPath $tempDir -Force

Write-Host "Contenido extraido en: $tempDir" -ForegroundColor Yellow
Write-Host ""

# 4. Leer metadata
$metadataPath = Join-Path $tempDir "_metadata.json"
if (-not (Test-Path $metadataPath)) {
  Write-Host "ERROR: no se encontro _metadata.json en el backup" -ForegroundColor Red
  exit 1
}

$metadata = Get-Content $metadataPath -Raw | ConvertFrom-Json
Write-Host "Backup del: $($metadata.fecha)" -ForegroundColor Gray
Write-Host ""

# 5. ADVERTENCIA
Write-Host "ADVERTENCIA: Esto va a BORRAR los datos actuales y sustituirlos por los del backup." -ForegroundColor Yellow
Write-Host ""
$confirmacion = Read-Host "Estas seguro? Escribe 'SI' para continuar"

if ($confirmacion -ne "SI") {
  Write-Host "Cancelado." -ForegroundColor Yellow
  Remove-Item -Path $tempDir -Recurse -Force
  exit 0
}

Write-Host ""
Write-Host "Restaurando..." -ForegroundColor Cyan

# 6. Orden inverso al backup (borrar primero, luego insertar)
$ordenInsercion = @(
  'niveles',
  'categorias_edad',
  'tipos_prueba',
  'reprises',
  'ejercicios_reprise',
  'niveles_reprises',
  'concursos',
  'jornadas',
  'binomios',
  'inscripciones',
  'pruebas',
  'prueba_jueces',
  'participaciones',
  'puntuaciones',
  'equipos',
  'equipo_miembros',
  'jueces',
  'profiles'
)

$total = $ordenInsercion.Count
$i = 0

foreach ($tabla in $ordenInsercion) {
  $i++
  $archivo = Join-Path $tempDir "$tabla.json"

  if (-not (Test-Path $archivo)) {
    Write-Host "[$i/$total] $tabla... SALTADO (no hay JSON)" -ForegroundColor Yellow
    continue
  }

  Write-Host "[$i/$total] Restaurando $tabla..." -ForegroundColor Gray -NoNewline

  try {
    $datos = Get-Content $archivo -Raw | ConvertFrom-Json

    if ($datos -isnot [array]) {
      $datos = @($datos)
    }

    if ($datos.Count -eq 0) {
      Write-Host " VACIO" -ForegroundColor Gray
      continue
    }

    $headers = @{
      "apikey" = $serviceKey
      "Authorization" = "Bearer $serviceKey"
      "Content-Type" = "application/json"
      "Prefer" = "resolution=merge-duplicates"
    }

    $body = $datos | ConvertTo-Json -Depth 10 -Compress

    $uri = "$supabaseUrl/rest/v1/$tabla"
    Invoke-RestMethod -Uri $uri -Headers $headers -Method POST -Body $body -TimeoutSec 120 | Out-Null

    Write-Host " OK ($($datos.Count) registros)" -ForegroundColor Green
  } catch {
    Write-Host " ERROR: $($_.Exception.Message)" -ForegroundColor Red
  }
}

# 7. Limpiar carpeta temporal
Remove-Item -Path $tempDir -Recurse -Force

Write-Host ""
Write-Host "=== RESTAURACION COMPLETADA ===" -ForegroundColor Green