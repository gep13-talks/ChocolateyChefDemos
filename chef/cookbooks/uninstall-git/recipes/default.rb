include_recipe 'chocolatey::default'

chocolatey_package 'git.install' do
    action :remove
end
