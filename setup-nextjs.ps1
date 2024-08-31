# Quickstart a Next.js-powered website.

# Prompt for project & repository name
$projectName = Read-Host -Prompt "Enter the name for the project"
$repoName = Read-Host -Prompt "Enter the name for the GitHub repository"

# Create a new Next.js project using the boilerplate repository
git clone https://github.com/matimortari/boilerplate-nextjs $projectName
Set-Location $projectName

# Create & install necessary files 
Remove-Item .git, README.md -Recurse -Force
New-Item README.md, .env.local, .env.production
npm install --verbose

# Create a new GitHub repository for the project
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
