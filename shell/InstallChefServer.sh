wget -P /tmp https://packages.chef.io/files/stable/chef-server/12.19.31/ubuntu/18.04/chef-server-core_12.19.31-1_amd64.deb
dpkg -i /tmp/chef-server-core_12.19.31-1_amd64.deb
chef-server-ctl reconfigure
mkdir /home/vagrant/certs
chef-server-ctl user-create gep13 Gary Ewan Park gary@chocolatey.io abc123 --filename /home/vagrant/certs/gep13.pem
chef-server-ctl org-create chocolatey "Chocolatey Software, Inc." --association_user gep13 --filename /home/vagrant/certs/chocolatey.pem
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license
chef-server-ctl install opscode-reporting
chef-server-ctl reconfigure
opscode-reporting-ctl reconfigure --accept-license
