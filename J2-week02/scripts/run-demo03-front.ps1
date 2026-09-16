$ErrorActionPreference = "Stop"

$frontRoot = Resolve-Path "$PSScriptRoot\..\demo03-2024\front"
Set-Location $frontRoot

if (-not (Test-Path ".\node_modules")) {
    npm.cmd install
}

npm.cmd run dev
