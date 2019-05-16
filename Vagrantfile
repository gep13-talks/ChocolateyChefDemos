Vagrant.configure("2") do |config|

  config.vm.define "chocoserver" do |chocoserver|
    chocoserver.vm.box = "StefanScherer/windows_2016"
    chocoserver.windows.halt_timeout = 20
    chocoserver.winrm.username = "vagrant"
    chocoserver.winrm.password = "vagrant"
    chocoserver.vm.guest = :windows
    chocoserver.vm.communicator = "winrm"

    chocoserver.vm.hostname = "chocoserver"
    chocoserver.windows.set_work_network = true

    chocoserver.vm.network :forwarded_port, guest: 5985, host: 5988, id: "winrm", auto_correct: true
    chocoserver.vm.network :forwarded_port, guest: 3389, host: 3392, id: "rdp", auto_correct: true
    chocoserver.vm.network :forwarded_port, guest: 22, host: 2225, id: "ssh", auto_correct: true

    chocoserver.vm.synced_folder "packages", "/packages"
    chocoserver.vm.synced_folder "license", "/license"

    chocoserver.vm.provider :virtualbox do |v, override|
      override.vm.network :private_network, ip: "10.10.17.10"
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.gui = true
      v.customize ["modifyvm", :id, "--vram", 32]
      v.customize ["modifyvm", :id, "--memory", "2048"]
      v.customize ["modifyvm", :id, "--audio", "none"]
      v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      v.customize ["modifyvm", :id, "--draganddrop", "hosttoguest"]
      v.customize ["modifyvm", :id, "--usb", "off"]
      # linked clones for speed and size
      v.linked_clone = true if Vagrant::VERSION >= '1.8.0'
    end

    # privileged:false - https://github.com/hashicorp/vagrant/issues/9138
    # Auto Login issue corrected, as per discussion here: https://twitter.com/stefscherer/status/1011120268222304256
    chocoserver.vm.provision "shell", privileged: false, inline: <<-SHELL
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogon -Value 1
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultUserName -Value "vagrant"
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultPassword -Value "vagrant"
      Remove-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogonCount -Confirm -ErrorAction SilentlyContinue
    SHELL
    chocoserver.vm.provision "reload"
    chocoserver.vm.provision :shell, :path => "../shell/PrepareWindows.ps1", privileged: false
    chocoserver.vm.provision :shell, :path => "../shell/SetWindowsPreferences.ps1", privileged: false
    chocoserver.vm.provision :shell, :path => "../shell/NotifyGuiAppsOfEnvironmentChanges.ps1", privileged: false
  end

  config.vm.define "chococlient" do |chococlient|
    chococlient.vm.box = "StefanScherer/windows_2016"
    chococlient.windows.halt_timeout = 20
    chococlient.winrm.username = "vagrant"
    chococlient.winrm.password = "vagrant"
    chococlient.vm.guest = :windows
    chococlient.vm.communicator = "winrm"

    chococlient.vm.hostname = "chococlient"
    chococlient.windows.set_work_network = true

    chococlient.vm.network :forwarded_port, guest: 5985, host: 5988, id: "winrm", auto_correct: true
    chococlient.vm.network :forwarded_port, guest: 3389, host: 3392, id: "rdp", auto_correct: true
    chococlient.vm.network :forwarded_port, guest: 22, host: 2225, id: "ssh", auto_correct: true

    chococlient.vm.synced_folder "packages", "/packages"
    chococlient.vm.synced_folder "license", "/license"

    chococlient.vm.provider :virtualbox do |v, override|
      override.vm.network :private_network, ip: "10.10.17.11"
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      # linked clones for speed and size
      v.linked_clone = true if Vagrant::VERSION >= '1.8.0'
      v.gui = true
      v.customize ["modifyvm", :id, "--memory", "2048"]
      v.customize ["modifyvm", :id, "--audio", "none"]
      v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      v.customize ["modifyvm", :id, "--draganddrop", "hosttoguest"]
      v.customize ["modifyvm", :id, "--usb", "off"]
    end

    # privileged:false - https://github.com/hashicorp/vagrant/issues/9138
    # Auto Login issue corrected, as per discussion here: https://twitter.com/stefscherer/status/1011120268222304256
    chococlient.vm.provision "shell", privileged: false, inline: <<-SHELL
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogon -Value 1
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultUserName -Value "vagrant"
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultPassword -Value "vagrant"
      Remove-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogonCount -Confirm -ErrorAction SilentlyContinue
    SHELL
    chococlient.vm.provision "reload"
    chococlient.vm.provision :shell, :path => "../shell/PrepareWindows.ps1", privileged: false
    chococlient.vm.provision :shell, :path => "../shell/SetWindowsPreferences.ps1", privileged: false
    chococlient.vm.provision :shell, :path => "../shell/NotifyGuiAppsOfEnvironmentChanges.ps1", privileged: false
  end

  config.vm.define "chefserver" do |chefserver|
    chefserver.vm.box = "bento/ubuntu-18.04"
    chefserver.vm.hostname = "chefserver.local"
    chefserver.vm.network "private_network", ip: "10.10.17.12"
    chefserver.vm.provider "virtualbox" do |v, override|
      v.linked_clone = true if Vagrant::VERSION >= '1.8.0'
      v.gui = true
      v.memory = 2048
    end
  end
end
