include_recipe 'chocolatey::default'

chocolatey_package 'git.install' do
    action :install
    options '--params "/GitAndUnixToolsOnPath /NoGitLfs /SChannel /NoAutoCrlf"'
end
