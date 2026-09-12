# ============================================================
# listar_backups.ps1
# Lista los backups disponibles
# Uso: .\scripts\listar_backups.ps1
# ============================================================

Write-Host "=== Backups disponibles ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path ".\backups")) {
  Write-Host "No hay carpeta de backups" -ForegroundColor Yellow
  exit 0
}

$backups = Get-ChildItem -Path ".\backups" -Filter "backup_*.zip" | Sort-Object Name -Descending

if ($backups.Count -eq 0) {
  Write-Host "No hay backups" -ForegroundColor Yellow
  exit 0
}

Write-Host ("{0,-35} {1,-15} {2,10}" -f "NOMBRE", "FECHA", "TAMANO") -ForegroundColor White
Write-Host ("-" * 65) -ForegroundColor Gray

foreach ($b in $backups) {
  $fecha = $b.LastWriteTime.ToString("yyyy-MM-dd HH:mm")
  $tamano = "{0:N2} KB" -f ($b.Length / 1KB)
  Write-Host ("{0,-35} {1,-15} {2,10}" -f $b.Name, $fecha, $tamano)
}

Write-Host ""
Write-Host "Total: $($backups.Count) backups" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para restaurar uno:" -ForegroundColor Yellow
Write-Host "  .\scripts\restore_bbdd.ps1 -BackupZip `".\backups\NOMBRE.zip`"" -ForegroundColor White