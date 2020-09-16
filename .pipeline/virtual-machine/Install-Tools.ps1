$vsts_agent_server_url = ''
$vsts_agent_auth_pat = ''
$vsts_agent_pool = 'Default'

cd \

Write-Host "Installing tools..."

function Find-Url {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Url,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Pattern,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Format
    )

    $body = Invoke-RestMethod -Uri $Url -Method Get

    if (($body -match $Pattern) -eq $false) {
        throw "No match for url: '$Url'"
    }

    return $ExecutionContext.InvokeCommand.ExpandString($Format)
}

function Download-File {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Uri,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Destination
    )

    Write-Verbose "Downloading $Name..."

    if (!(Test-Path -Path $Destination -PathType Leaf)) {
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($Uri, $Destination)
    }

    Write-Verbose 'done.'
}

# Download, unzip and install the VSTS Pipeline Agent
# on 'C:\vstsagent' folder.

$vsts_agent_url = Find-Url -Url 'https://github.com/microsoft/azure-pipelines-agent/releases' `
    -Pattern 'agent\/([\.\d]+)\/([A-z-]*-win-x64-[\.\d]+\.zip)' `
    -Format 'https://vstsagentpackage.azureedge.net/agent/$($Matches[1])/$($Matches[2])'

$vsts_agent_unzip_dir = New-Item -Path 'C:\' -Name 'vstsagent' -ItemType Directory
$vsts_agent_download_path = "$env:TEMP\vstsagent.zip"

Download-File -Name 'vstsagent' -Uri $vsts_agent_url -Destination $vsts_agent_download_path
Expand-Archive -Path $vsts_agent_download_path -DestinationPath $vsts_agent_unzip_dir

Start-Process "$($vsts_agent_unzip_dir)\config.cmd" `
    -ArgumentList @('--unattended', '--auth', 'pat', '--acceptTeeEula', '--runAsAutoLogon', '--url', $vsts_agent_server_url, '--token', $vsts_agent_auth_pat, '--pool', $vsts_agent_pool) `
    -Wait

# Download the ESP-IDF Framework tools.

$esp_idf_download_path = "$env:TEMP\espidf.exe"

Download-File -Name 'espidf' `
    -Uri 'https://dl.espressif.com/dl/esp-idf-tools-setup-2.3.exe' `
    -Destination $esp_idf_download_path

# On a clean machine, ESP-IDF installer will install on
# whatever folder is set on machine env var 'IDF_TOOLS_PATH'.
# We want to install it on 'C:\espidf'.
# Setting it to 'C:\' will make it install on 'C:\espidf'.

[System.Environment]::SetEnvironmentVariable('IDF_TOOLS_PATH', 'C:\', [System.EnvironmentVariableTarget]::Machine)

Start-Process $esp_idf_download_path `
    -ArgumentList @('/SILENT', '/ALLUSERS', '/CLOSEAPPLICATIONS', '/SUPPRESSMSGBOXES', '/SP-') `
    -Wait

# Update the machine env var 'IDF_TOOLS_PATH' to point to
# the final installtion folder, otherwise the build
# pipeline will fail.

[System.Environment]::SetEnvironmentVariable('IDF_TOOLS_PATH', 'C:\espidf', [System.EnvironmentVariableTarget]::Machine)

# The installer will download the ESP-IDF Framework sources
# on '{current user}/desktop/esp-idf'.
# We need them on 'C:\espidfsources', so the build can access it.

$esp_idf_old_source_dir = "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop))\esp-idf\"

Rename-Item -Path $esp_idf_old_source_dir -NewName 'espidfsources'
Move-Item -Path "$([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop))\espidfsources" -Destination 'C:\'

# Set access rules for ESP-IDF folders.

$access_rule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\Network Service", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")

$acl = Get-Acl 'C:\espidf'
$acl.SetAccessRule($access_rule)
$acl | Set-Acl 'C:\espidf'

$acl = Get-Acl 'C:\espidfsources'
$acl.SetAccessRule($access_rule)
$acl | Set-Acl 'C:\espidfsources'

# Add Python to machine env var 'PATH'.
# The VM image used (Visual Studio Professional 20XX on Windows 10)
# already have Python installed, it's just not on the env var.

$sys_path = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)

[System.Environment]::SetEnvironmentVariable('PATH', "$($sys_path)C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python37_64", [System.EnvironmentVariableTarget]::Machine)

Write-Host "Tools installation done!"
