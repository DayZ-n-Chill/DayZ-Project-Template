function Get-ProjectDirectory {
    param(
        [string]$configPath
    )
    if (-Not (Test-Path -Path $configPath)) {
        Write-Host "Configuration file does not exist: $configPath" -ForegroundColor Red
        return $null
    }
    try {
        foreach ($line in Get-Content -Path $configPath) {
            if ($line.Trim().StartsWith('PROJECTDIR')) {
                return $line.Trim().Split('=')[1].Trim()
            }
        }
    } catch {
        Write-Host "Error while reading configuration: $_" -ForegroundColor Red
    }
    return $null
}

function Set-TextInFile {
    param(
        [string]$filePath,
        [string]$oldText,
        [string]$newText
    )
    if (-Not (Test-Path -Path $filePath)) {
        Write-Host "File does not exist: $filePath" -ForegroundColor Red
        return
    }
    try {
        $content = Get-Content -Path $filePath -Raw
        $newContent = $content.Replace($oldText, $newText)
        if ($content -ne $newContent) {
            Set-Content -Path $filePath -Value $newContent
            Write-Host "Updated $filePath" -ForegroundColor Green
            return $true
        } else {
            Write-Host "No changes needed in $filePath" -ForegroundColor Blue
            return $false
        }
    } catch {
        Write-Host "Failed to update ${filePath}: $_" -ForegroundColor Red
    }
}

function Invoke-ModUpdateProcess {
    Write-Host "Starting the mod update process..." -ForegroundColor Magenta
    $configPath = "E:\DayZ Projects\DayZ-Project-Template\Utils\Shared\Globals.cfg"
    $projectDir = Get-ProjectDirectory -configPath $configPath
    if (-not $projectDir) {
        Write-Host "Failed to load the project directory from configuration. Exiting." -ForegroundColor Red
        return
    }

    $newModName = Read-Host -Prompt "Enter the new mod name to replace 'Mod-Name'"
    if (-not $newModName) {
        Write-Host "No mod name entered. Exiting." -ForegroundColor Red
        return
    }

    $filesToModify = @{
        "BuildMods.bat" = Join-Path -Path $projectDir -ChildPath "Utils\Batch\Build\BuildMods.bat"
        "Globals.cfg"   = Join-Path -Path $projectDir -ChildPath "Utils\Shared\Globals.cfg"
        "config.cpp"    = Join-Path -Path $projectDir -ChildPath "Mod-Name\Scripts\config.cpp"
        "dayz.gproj"    = Join-Path -Path $projectDir -ChildPath "Mod-Name\Workbench\dayz.gproj"
        "DayZTools.c"   = Join-Path -Path $projectDir -ChildPath "Mod-Name\Workbench\ToolAddons\Plugins\DayZTools.c"
    }

    foreach ($fileDescription in $filesToModify.Keys) {
        $result = Set-TextInFile -filePath $filesToModify[$fileDescription] -oldText "Mod-Name" -newText $newModName
        if ($result) {
            Write-Host "Change: Updated `Mod-Name` to `$newModName` in file $fileDescription." -ForegroundColor Cyan
        }
    }

    Write-Host "Modification process is complete. Thank you for using DayZ n Chill Dev Tools!" -ForegroundColor Green
}

Invoke-ModUpdateProcess
