# Display a tree structure of the current folder, excluding directories that are too large to display it efficiently.

$source = Get-Location
$treeOutput = "$source\tree-output"

# Ensure the temporary directory is empty, then create it
if (Test-Path -Path $treeOutput) { Remove-Item -Recurse -Force -Path $treeOutput }
New-Item -ItemType Directory -Path $treeOutput

# Copy the directory, excluding the specified directories
robocopy $source $treeOutput /E /XD node_modules .next dist

# Run the tree command to display the directory structure
Set-Location $treeOutput
tree /f

# Clean up the temporary directory
Set-Location $source
Remove-Item -Recurse -Force -Path $treeOutput
