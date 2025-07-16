$OutputEncoding = [Console]::InputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$dbDirPath = "C:\Users\nick\AppData\Roaming\Mozilla\Firefox\Profiles\ccrtwvyq.default-release\storage\default\https+++krut.nve.no\ls"
$dbPath = "$dbDirPath\data.sqlite"

# Check if folder is present
if (-not (Test-Path -Path $dbDirPath -PathType Container))
{
    Write-Error "Could not find directory where the sqliste database of localstorage is stored in`n$dbDirPath"
    exit 1
}

# Check if file is present
if (-not (Test-Path -Path $dbPath -PathType Leaf))
{
    Write-Error "Could not find sql-lite file`n$dbPath"
    exit 1
}

#Set-Location $dbDirPath

$credential = sqlite3.exe $dbPath "select value from data where key like '%substantial%krut_api/apireadwrite--';" | ConvertFrom-Json
if ($credential.secret.Length -gt 0)
{
    Write-Host "🏴‍☠️ Copied Krut JWT to clipboard!"
    $credential.secret | clip
}
else
{
    Write-Error "Was not able to find Krut JWT from credential secret in credential:`n$credential"
}
