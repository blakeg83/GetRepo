
# PowerShell Script: Clone and Extract Code Files

This script automates the following tasks:
1. Installs **PoshGit** if it is not already installed.
2. Clones a GitHub repository using a Personal Access Token (PAT) for authentication.
3. Extracts all `.cs` and `.xaml` files (excluding `Migrations` folders) from the repository and writes their contents to `output.txt`.

## Prerequisites

- **PowerShell**: Ensure you have PowerShell installed on your system.
- **Git**: Git must be installed and available in your PATH.

## Instructions

### Step 1: Clone the Repository and Extract Files

1. Save this script to a `.ps1` file (e.g., `ExtractCode.ps1`).
2. Open a PowerShell terminal.
3. Run the script:
   ```powershell
   .\ExtractCode.ps1
   ```
4. When prompted:
   - Enter your Personal Access Token (PAT).
   - Enter the repository URL.

5. The script will:
   - Clone the repository into a temporary directory.
   - Extract `.cs` and `.xaml` files, ignoring folders named `Migrations`.
   - Write the extracted file paths and their contents to `output.txt`.

6. The output file `output.txt` will be created in the current working directory.

### Step 2: Clean Up

- The temporary directory created during the cloning process will be automatically deleted after execution.

## Example

```plaintext
Enter your PAT: ************
Enter the repository URL: https://github.com/username/repository.git
Processing project: C:\Users\Example\Temp\Project1
Processing file: C:\Users\Example\Temp\Project1\File1.cs
Processing file: C:\Users\Example\Temp\Project1\File2.xaml
Code extracted to output.txt.
Cleaned up temporary files.
```

## Notes

- Ensure your PAT has the appropriate scopes to clone the repository (e.g., `repo` scope for private repositories).
- If the repository URL is empty or invalid, the script will exit with an error.

## Disclaimer

Use this script responsibly. Ensure that you have permission to access and extract code from the repository.
