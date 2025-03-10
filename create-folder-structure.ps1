# Define the root project directory – adjust the path as needed.
$rootPath = "$PSScriptRoot\MyProjectDemo"

# Define folder structure
$folders = @(
    "$rootPath",
    "$rootPath\src",
    "$rootPath\docs",
    "$rootPath\config",
    "$rootPath\logs"
)

# Create each folder if it doesn't exist
foreach ($folder in $folders) {
    if (-Not (Test-Path -Path $folder)) {
        New-Item -Path $folder -ItemType Directory -Force | Out-Null
        Write-Host "Created folder: $folder"
    } else {
        Write-Host "Folder already exists: $folder"
    }
}

# Define files and their content
$files = @{
    # Main script file for the project
    "$rootPath\src\main.ps1" = @'
# Main script for MyProjectDemo
Write-Output "Hello, welcome to MyProjectDemo!"
'@;

    # Documentation file
    "$rootPath\docs\readme.md" = @'
﻿# MyProjectDemo

This project serves as an example of creating a folder structure and adding files with content using PowerShell.
'@;

    # Configuration file with settings
    "$rootPath\config\settings.xml" = @'
﻿<?xml version="1.0" encoding="utf-8"?>
<settings>
    <setting name="Theme" value="Casual" />
    <setting name="Version" value="1.0.0" />
</settings>
'@
}

# Create or overwrite each file with its content
foreach ($file in $files.Keys) {
    $content = $files[$file]
    $content | Out-File -FilePath $file -Encoding UTF8
    Write-Host "Created file: $file"
}

# Verification: Check if all required files exist
$missingFiles = @()
foreach ($file in $files.Keys) {
    if (-Not (Test-Path -Path $file)) {
        $missingFiles += $file
    }
}

if ($missingFiles.Count -eq 0) {
    Write-Host "All required files have been created successfully at: $rootPath"
} else {
    Write-Host "The following files are missing:"
    $missingFiles | ForEach-Object { Write-Host $_ }
}