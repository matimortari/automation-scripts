# Quickstart a Next.js-powered website.

# Initialize variables from user input
$projectName = Read-Host -Prompt "Enter the name for the project"
$repoName = Read-Host -Prompt "Enter the name for the GitHub repository"

# Create new Next.js project & install dependencies
git clone https://github.com/matimortari/boilerplate-nextjs $projectName
Set-Location $projectName

Remove-Item .git, README.md -Recurse -Force
New-Item README.md, .env.local, .env.production
npm install --verbose

# Initialize Git repository for the project
git init

$jsonData = @{
    name    = $repoName
    private = $true
} | ConvertTo-Json

$headers = @{
    Authorization = "token $($env:GITHUBTOKEN)"
    Accept        = "application/vnd.github.v3+json"
}

$response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $jsonData

$cloneUrl = $response.clone_url
git remote add origin $cloneUrl
git remote -v
