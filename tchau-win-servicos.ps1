$services = @(
  "Fax",
  "XpsPrint",
  "MapsBroker",
  "SysMain",
  "WSearch",
  "XblGameSave",
  "XboxNetApiSvc",
  "DiagTrack",
  "BITS",
  "TapiSrv"
)

foreach ($s in $services) {
  try {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled
    Write-Host "Desativado: $s"
  } catch {
    Write-Warning "Falha ao desativar $s"
  }
}
