#!/usr/bin/env powershell

Param(
    [Parameter(Mandatory = $true, Position = 0)]
    [String]
    $InputFolder,

    [String]
    $OutputFolder = "transcode",

    [String[]]
    $ProcessedFiles = @(".mkv", ".webm")
)

$files = Get-ChildItem $InputFolder -File
$outputDirectory = Join-Path $InputFolder $OutputFolder 
if((Test-Path $outputDirectory) -ne $true){
    Write-Host "Output directory $outputDirectory does not exist. Creating..."
    (New-Item -ItemType directory -Path $outputDirectory) > $null
}
foreach ($file in $files) {
    if ($ProcessedFiles.Contains((Get-Item $file).Extension)) {
        $outputFile = Join-Path $outputDirectory "$((Get-Item $file).BaseName).mkv"
        #Write-Host "ffmpeg -i $file -c:v libx264 -preset medium -crf 22 -c:a copy $outputFile"
        ffmpeg -i $file -c:v libx264 -preset medium -crf 22 -c:a copy $outputFile
    }
}
