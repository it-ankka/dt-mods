<# Create a symlink to the mod in the Darkitide mod folder #>

param (
  [ArgumentCompleter({
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    Get-ChildItem -Path . -Directory |
        Where-Object { $_.Name -like "$wordToComplete*" } |
        ForEach-Object { $_.Name }
  })]
  [string]$ModName,
  [string]$DarktideDir
)

$usageString = "Usage: .\symlink-mod.ps1 -ModName <mod-folder-name> [-DarktideDir <path>]"
$configFileName = "config.json"

$modDir = Join-Path -Path $PSScriptRoot -ChildPath $ModName
$modDirExists = Test-Path $modDir -PathType Container

if ([string]::IsNullOrWhiteSpace($ModName) -or -not $modDirExists) {
  Write-Output "Error: Mod '$ModName' not found in $modDir"
  Write-Output $usageString
  exit 1
}

$configFile = Join-Path -Path $PSScriptRoot -ChildPath $configFileName
$configFileExists = Test-Path $configFile
$validDarktideDir = $true
if([string]::IsNullOrWhiteSpace($DarktideDir)) {
  if($configFileExists) {
    try {
      $config = Get-Content -Path $configFile -Raw  | ConvertFrom-Json
      $DarktideDir = $config.darktideDirectory
    } catch {
      $validDarktideDir = $false
    }
  } else {
    $validDarktideDir = $false
  }
}

if (-not $validDarktideDir -or -not (Test-Path $DarktideDir -PathType Container)) { 
  Write-Output "Invalid Darktide directory supplied. Provide the absolute path to the Darktide directory with -darktide-dir parameter or set 'darktideDirectory' in $configFileName"
  Write-Output $usageString
  exit 1
}
$darktideModsDirExists = Test-Path "$DarktideDir\mods" -PathType Container
if (-not $darktideModsDirExists) {
  Write-Output "No 'mods' directory found under the Darktide directory. Make sure you have installed the Darktide-Mod-Loader and Darktide-Mod-Framework by following the instructions at https://dmf-docs.darkti.de/#/installing-mods"
  exit 1
}

$symlinkPath = Join-Path -Path $DarktideDir -ChildPath "mods\$ModName"
if (Test-Path $symlinkPath) {
    $item = Get-Item $symlinkPath -Force

    if ($item.LinkType -eq "SymbolicLink") {
        Write-Output "Existing symbolic link found at $symlinkPath. Do you want to replace it?"
        Remove-Item $symlinkPath -Force
    }
    else {
        Write-Output "Item at $symlinkPath exists but is not a symbolic link. Not replacing."
        exit 1
    }
}
New-Item -Path $symlinkPath -ItemType SymbolicLink -Value $modDir
Write-Output "Link created"





