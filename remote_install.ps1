# remote_install.ps1

Write-Host "🔧 Starting Remote Terminal Agent Setup..." -ForegroundColor Cyan

# Step 1: Create temp folder
$dest = "$env:USERPROFILE\\RemoteTerminal"
if (!(Test-Path $dest)) {
    New-Item -ItemType Directory -Path $dest | Out-Null
}

# Step 2: Download all necessary files from GitHub
$repo = "https://raw.githubusercontent.com/AlmightyTopher/Remote-Terminal/main"
$files = @("agent.py", "requirements.txt", "setup_and_run.bat")

foreach ($file in $files) {
    Invoke-WebRequest "$repo/$file" -OutFile "$dest\\$file"
}

# Step 3: Run the .bat installer
Start-Process "$dest\\setup_and_run.bat"
