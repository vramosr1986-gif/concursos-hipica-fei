# ============================================
# RECREAR BASE DE DATOS COMPLETA
# ============================================
# Uso: .\db\recrear_bd.ps1
#
# ADVERTENCIA: Este script BORRA toda la BD y la recrea desde cero.
# ============================================

param(
  [switch]$SoloVerificar = $false,
  [switch]$SinConfirmar = $false
)

$ErrorActionPreference = "Continue"

# Ir al directorio del proyecto
$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  RECREAR BASE DE DATOS - Concursos FEI" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

if (-not $SinConfirmar) {
  Write-Host "ADVERTENCIA: Este script BORRARA TODA LA BD y la recreara desde cero." -ForegroundColor Yellow
  Write-Host "Todos los datos actuales se PERDERAN." -ForegroundColor Yellow
  Write-Host ""
  $confirmacion = Read-Host "Escribe 'SI' para continuar"
  
  if ($confirmacion -ne "SI") {
    Write-Host "Cancelado." -ForegroundColor Red
    exit
  }
}

# Lista de archivos SQL en orden
$archivos = @(
  "00_limpiar_todo.sql",
  "01_estructura.sql",
  "02_funciones.sql",
  "03_politicas_rls.sql",
  "04_permisos.sql",
  "05_seed_usuarios.sql",
  "06_seed_reprises.sql",
  "07_seed_datos.sql",
  "08_seed_participaciones.sql"
)

$dbPath = $PSScriptRoot

foreach ($archivo in $archivos) {
  $rutaCompleta = Join-Path $dbPath $archivo
  
  if (-not (Test-Path $rutaCompleta)) {
    Write-Host "  SKIP: $archivo (no existe)" -ForegroundColor Yellow
    continue
  }
  
  Write-Host "  Ejecutando: $archivo" -ForegroundColor Cyan
  
  if ($SoloVerificar) {
    Write-Host "    [SoloVerificar] NO ejecutado" -ForegroundColor DarkGray
    continue
  }
  
  try {
    # Ejecutar sin capturar stderr para evitar falsos positivos
    supabase db query --linked --file $rutaCompleta
    
    if ($LASTEXITCODE -ne 0) {
      Write-Host "    ERROR (codigo $LASTEXITCODE)" -ForegroundColor Red
      throw "Error ejecutando $archivo"
    } else {
      Write-Host "    OK" -ForegroundColor Green
    }
  } catch {
    Write-Host "    ERROR: $_" -ForegroundColor Red
    Write-Host "Abortando..." -ForegroundColor Red
    exit 1
  }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  BD RECREADA CORRECTAMENTE" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Proximos pasos:" -ForegroundColor Yellow
Write-Host "  1. Verifica que los usuarios Auth siguen existiendo"
Write-Host "  2. Comprueba los datos:"
Write-Host "     supabase db query --linked 'SELECT COUNT(*) FROM profiles;'"
Write-Host ""
