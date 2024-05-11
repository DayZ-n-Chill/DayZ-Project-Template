function Get-ProjectDirectory {
    <#
    Retrieves the project directory from the configuration file.
    #>
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
    <#
    Sets the specified text in a file.
    #>
    param(
        [string]$filePath,
        [string]$oldText,
        [string]$newText
    )
    if (-Not (Test-Path -Path $filePath)) {
        Write-Host "File does not exist: $filePath" -ForegroundColor Red
        return $false
    }
    try {
        $content = Get-Content -Path $filePath -Raw
        $newContent = $content.Replace($oldText, $newText)
        if ($content -ne $newContent) {
            Set-Content -Path $filePath -Value $newContent
            return $true
        } else {
            Write-Host "No changes needed in $filePath" -ForegroundColor Cyan
            return $false
        }
    } catch {
        Write-Host "Failed to update ${filePath}: $_" -ForegroundColor Magenta
        return $false
    }
}

function Rename-ModFolder {
    <#
    Renames the mod folder.
    #>
    param(
        [string]$oldFolderPath,
        [string]$newFolderPath
    )
    if (-Not (Test-Path -Path $oldFolderPath)) {
        Write-Host "Folder does not exist: $oldFolderPath" -ForegroundColor Red
        return $false
    }
    try {
        Rename-Item -Path $oldFolderPath -NewName $newFolderPath
        Write-Host -NoNewline "Renamed folder from: " -ForegroundColor Magenta
        Write-Host "'$oldFolderPath' to '$newFolderPath'" -ForegroundColor Cyan
        return $true
    } catch {
        Write-Host "Failed to rename folder: $_" -ForegroundColor Magenta
        return $false
    }
}

function Get-RandomBrightColor {
    <#
    Generates a random bright color. fuck it ill just magenta
    #>
    $colors = @('Magenta', 'Red', 'DarkMagenta','DarkRed' )
    return $colors | Get-Random
}
function Invoke-ModUpdateProcess {
    Write-Host "Starting file & folder pathing process..." -ForegroundColor Magenta
    Write-Host ""  # Empty line for spacing
    Write-Host "Enter the name of your" -ForegroundColor Yellow -NoNewline
    Write-Host " 'Mod-Name': " 
    $newModName = Read-Host
    if (-not $newModName) {
        Write-Host "No mod name entered. Exiting." -ForegroundColor Red
        return
    }

    $configPath = "E:\DayZ Projects\DayZ-Project-Template\Utils\Shared\Globals.cfg"
    $projectDir = Get-ProjectDirectory -configPath $configPath
    if (-not $projectDir) {
        Write-Host "Failed to load the project directory from configuration. Exiting." -ForegroundColor Red
        return
    }

    $oldModPath = Join-Path -Path $projectDir -ChildPath "Mod-Name"
    $newModPath = Join-Path -Path $projectDir -ChildPath $newModName

    $filesToModify = @{
        "BuildMods.bat" = Join-Path -Path $projectDir -ChildPath "Utils\Batch\Build\BuildMods.bat"
        "Globals.cfg"   = Join-Path -Path $projectDir -ChildPath "Utils\Shared\Globals.cfg"
        "config.cpp"    = Join-Path -Path $oldModPath -ChildPath "Scripts\config.cpp"
        "dayz.gproj"    = Join-Path -Path $oldModPath -ChildPath "Workbench\dayz.gproj"
        "DayZTools.c"   = Join-Path -Path $oldModPath -ChildPath "Workbench\ToolAddons\Plugins\DayZTools.c"
    }

    Write-Host "Updating all files with the proper pathing for your mod name." -ForegroundColor Green
    Write-Host ""  # Empty line for spacing

    $updatedFiles = @()
    foreach ($fileDescription in $filesToModify.Keys) {
        $result = Set-TextInFile -filePath $filesToModify[$fileDescription] -oldText "Mod-Name" -newText $newModName
        if ($result) {
            $updatedFiles += $fileDescription
        }
    }

    Write-Host "Files to update:" -ForegroundColor Cyan -NoNewline
    Write-Host " $($updatedFiles -join ', ')" -ForegroundColor Gray
    Write-Host ""  # Empty line for spacing
    foreach ($fileDescription in $updatedFiles) {
        Write-Host "Updated:" -ForegroundColor Green -NoNewline
        Write-Host " $($filesToModify[$fileDescription])" -ForegroundColor Gray
        Write-Host ""  # Empty line for spacing
    }

    if ($updatedFiles.Count -gt 0) {
        Write-Host "Updated all pathing and folders from" -ForegroundColor Cyan -NoNewline
        Write-Host " 'Mod-Name'" -ForegroundColor Gray -NoNewline
        Write-Host " to" -ForegroundColor Cyan -NoNewline
        Write-Host " '$newModName'" -ForegroundColor Gray -NoNewline
        Write-Host " in all listed files." -ForegroundColor Cyan
        Write-Host ""  # Empty line for spacing

        $renameResult = Rename-ModFolder -oldFolderPath $oldModPath -newFolderPath $newModPath
        if (-not $renameResult) {
            Write-Host "Failed to rename the mod folder. Please check the paths and permissions." -ForegroundColor Red
        } else {
            Write-Host "Renamed folder from:" -ForegroundColor Green -NoNewline
            Write-Host " '$oldModPath' to '$newModPath'" -ForegroundColor Gray
        }
    } else {
        Write-Host "No files were updated; folder rename skipped." -ForegroundColor Blue
    }

    Write-Host ""  # Empty line for final spacing
    Write-Host "Modification process is complete." -ForegroundColor Green
    Write-Host "Thank you for using DayZ n Chill Dev Tools!" -ForegroundColor Green
}

Invoke-ModUpdateProcess
