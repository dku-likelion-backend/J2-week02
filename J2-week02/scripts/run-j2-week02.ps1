$ErrorActionPreference = "Stop"

$root = Resolve-Path "$PSScriptRoot\.."
Set-Location $root

.\gradlew.bat bootRun
