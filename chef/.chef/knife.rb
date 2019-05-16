# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "gep13"
client_key               "#{current_dir}/gep13.pem"
chef_server_url          "https://chefserver.local/organizations/chocolatey"
cookbook_path            ["#{current_dir}/../cookbooks"]
