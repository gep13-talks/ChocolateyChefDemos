#
# Cookbook:: uninstall-git
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'chocolatey::default'

chocolatey_package 'git.install' do
    action :remove
end
