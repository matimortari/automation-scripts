# Make an initial commit for a local project to a GitHub repo, with the "Initial commit" message.

# Get the repository URL from the .git folder and the GitHub username from the environment variable
$repoUrl = git config --get remote.origin.url

# Make the initial commit and push to main branch
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
