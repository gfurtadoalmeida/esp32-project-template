function Rename-Project {
    param (
        [string]
        $SourceRootPath,
        [string]
        $ComponentName
    )

    $ComponentName = $ComponentName.Replace('-', '_').ToLower()
    $ComponentNameUpper = $ComponentName.ToUpper();

    $TextReplacements = New-Object System.Collections.ArrayList
    $TextReplacements.AddRange((
            [Tuple]::Create("$($SourceRootPath)/components/component_name/include/component_name/component_name.h", '__COMPONENT_NAME_H__', "__$($ComponentNameUpper)_H__"),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/include/component_name/component_name.h", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/private_include/assertion.h", '__COMPONENT_NAME_ASSERTION_H__', "__$($ComponentNameUpper)_ASSERTION_H__"),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/private_include/config.h", '__COMPONENT_NAME_CONFIG_H__', "__$($ComponentNameUpper)_CONFIG_H__"),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/private_include/config.h", 'CONFIG_COMP_NAME_', "CONFIG_$($ComponentNameUpper)_"),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/private_include/log.h", '__COMPONENT_NAME_LOG_H__', "__$($ComponentNameUpper)_LOG_H__"),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/private_include/log.h", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/src/component_name.c", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/test/CMakeLists.txt", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/Kconfig", 'Component_Name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/Kconfig", 'COMP_NAME', $ComponentNameUpper),
            [Tuple]::Create("$($SourceRootPath)/main/CMakeLists.txt", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/main/main.c", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/test/CMakeLists.txt", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/CMakeLists.txt", 'component_name', $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/sonar-project.properties", 'component_name', $ComponentName)
        ))

    $FileRenamings = New-Object System.Collections.ArrayList
    $FileRenamings.AddRange((
            [Tuple]::Create("$($SourceRootPath)/components/component_name/include/component_name/component_name.h", "$($ComponentName).h"),
            [Tuple]::Create("$($SourceRootPath)/components/component_name/src/component_name.c", "$($ComponentName).c")
        ))

    $DirectoryRenamings = New-Object System.Collections.ArrayList
    $DirectoryRenamings.AddRange((
            [Tuple]::Create("$($SourceRootPath)/components/component_name/include/component_name", $ComponentName),
            [Tuple]::Create("$($SourceRootPath)/components/component_name", $ComponentName)
        ))

    foreach ($TextReplacement in $TextReplacements) {
        ((Get-Content -Path $TextReplacement.Item1 -Raw) -replace $TextReplacement.Item2, $TextReplacement.Item3) | Set-Content -Path $TextReplacement.Item1
    }

    foreach ($FileRenaming in $FileRenamings) {
        Rename-Item $FileRenaming.Item1 $FileRenaming.Item2
    }

    foreach ($DirectoryRenaming in $DirectoryRenamings) {
        Rename-Item $DirectoryRenaming.Item1 $DirectoryRenaming.Item2
    }
}

Rename-Project -SourceRootPath $args[0] -ComponentName $args[1]