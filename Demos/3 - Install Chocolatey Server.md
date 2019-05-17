1. Try to open `inetmgr` and show it not work
1. Open PowerShell and run `choco source`
1. Open Windows Explorer, navigate to `c:/programdata/chocolatey/lib`
1. Show only chocolatey and chocolatey-core.extension installed
1. Open browser and navigate to https://chefserver.local
1. Login to the portal
1. Click on Nodes
1. Hover the gear icon for `chocoserver`
1. Click `Edit Run List`
1. Click and drag `chocolatey-server` to right hand side
1. Click Save Run List
1. Open Administrator PowerShell prompt
1. Navigate to `c:/opscode/chef/bin`
1. Run `chef-client.bat`
1. Back to Windows Explorer, show additional packages installed
1. Open `inetmgr` and show newly created site
1. Open browser and navigate to `http://localhost`
1. Run `choco source` to show new configuration
