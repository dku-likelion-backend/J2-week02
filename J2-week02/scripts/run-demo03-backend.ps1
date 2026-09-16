$ErrorActionPreference = "Stop"

$root = Resolve-Path "$PSScriptRoot\..\demo03-2024"
Set-Location $root

.\gradlew.bat bootRun
