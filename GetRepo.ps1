# Check if PoshGit is already installed, and install if not
if (-not (Get-Module -ListAvailable -Name Posh-Git)) {
    Write-Host "Installing PoshGit..."
    Install-Module Posh-Git -Scope CurrentUser -Force
    Write-Host "PoshGit Installed."
} else {
    Write-Host "PoshGit is already installed."
}

# Get your Personal Access Token (PAT)
$token = Read-Host "Enter your PAT"
$repoUrl = Read-Host "Enter the repository URL"

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "Repository URL cannot be empty."
    exit
}

# Format the repo URL to include the PAT for authentication
$repoUrlWithToken = $repoUrl -replace 'https://', "https://${token}:@"

# Clone the repository using the PAT for authentication
$tempDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $tempDir

try {
    git clone $repoUrlWithToken $tempDir
    Write-Host "Repository cloned."

    # Create or clear the output text file
    $outputFile = "output.txt"
    Set-Content -Path $outputFile -Value ""

    # Get all project folders
    $projectDirs = Get-ChildItem -Path $tempDir -Directory

    foreach ($projectDir in $projectDirs) {
        Write-Host "Processing project: $($projectDir.FullName)"
        Add-Content -Path $outputFile -Value "`nProject: $($projectDir.FullName)`n"

        # Get all .cs and .xaml files in the project directory, excluding Migrations folder
        $files = Get-ChildItem -Path $projectDir.FullName -Recurse -Include *.cs, *.xaml | Where-Object { $_.FullName -notmatch '\\Migrations\\' }

        foreach ($file in $files) {
            Write-Host "Processing file: $($file.FullName)"
            Add-Content -Path $outputFile -Value "`nFile: $($file.FullName)`n"
            $fileContent = Get-Content -Path $file.FullName -Raw
            Add-Content -Path $outputFile -Value $fileContent
        }
    }

    Write-Host "Code extracted to $outputFile."
} catch {
    Write-Host "An error occurred: $_"
} finally {
    # Clean up the temporary repository directory
    Remove-Item -Recurse -Force $tempDir
    Write-Host "Cleaned up temporary files."
}
