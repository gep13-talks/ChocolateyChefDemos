# Follow these steps to setup this environment before the talk starts

* Run `vagrant up`

## chefworkstation

* Open code at least once, so IE opens to home page, and so it won't happen again
* Open browser to https://chefserver.local
* Click on Administration Tab
* Click on chocolatey Organisation
* Click on Starter Kit in left hand menu
* Click Download Starter Kit
* Click Proceed
* Unblock zip file
* Extract zip file in Downloads folder
* Copy contents of `chef-repo/.chef` to `c:/chef/.chef`
* Open Chef Development Kit
* cd into `c:/chef`
* Run `knife ssl fetch`
* Run `knife ssl check`
* Run `chef verify`
* Bootstrap chocoserver machine:
  * `knife bootstrap windows winrm chocoserver --winrm-user vagrant --winrm-password vagrant --node-name chocoserver`
* Verify correctly registered `knife node list`
* Navigate into `cookbooks/all-nodes` folder
  * Run `berks install`
  * Run `berks upload`
* Navigate into `cookbooks/chocolatey-server`
  * Run `berks install`
  * Run `berks upload`
* Navigate into `cookbooks/install-git`
  * Run `berks install`
  * Run `berks upload`
* Navigate into `cookbooks/uninstall-git`
  * Run `berks install`
  * Run `berks upload`
* Navigate into `roles`
  * Run `knife role from file .\chocolatey-server.rb`
  * Run `knife role from file .\all-nodes.rb`
  * Run `knife role from file .\install-git.rb`
  * Run `knife role from file .\uninstall-git.rb`

## chefserver

No additional steps are required on this server

## chocoserver

* Open Administrator PowerShell prompt
* Navigate to `c:/opscode/chef/bin`
* Run `chef-client.bat`
* Open browser to https://chefserver.local
* Assign all-nodes role to chocoserver
  * Or run `knife node run_list add chocoserver "role[all-nodes]"` from chef workstation
* Run `chef-client.bat`
* Make sure everything works as expected
* Check run history, to make sure that it is all good

## Additional things that could be good to check/know

* Make sure winrm is configured `winrm quickconfig`
* Check to make sure knife-windows is up to date:
  * `gem list knife-windows`
  * `gem update knife-windows`
