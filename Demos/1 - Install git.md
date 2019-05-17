1. Open Windows Explorer, navigate to `c:/programdata`
1. Show Chocolatey not installed
1. Open Add/Remove Programs
1. Show Git isn't installed
1. Open browser and navigate to https://chefserver.local
1. Login to the portal
1. Click on Nodes
1. Hover the gear icon for `chocoserver`
1. Click `Edit Run List`
1. Click and drag `install-git` to right hand side
1. Click Save Run List
1. Open Administrator PowerShell prompt
1. Navigate to `c:/opscode/chef/bin`
1. Run `chef-client.bat`
1. Back to Windows Explorer, show chocolatey installed
1. Back to Add/Remove Programs, show Git installed
