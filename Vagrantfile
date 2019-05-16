Vagrant.configure("2") do |config|

  config.vm.define "chefworkstation" do |chefworkstation|
    chefworkstation.vm.box = "StefanScherer/windows_2016"
    chefworkstation.windows.halt_timeout = 20
    chefworkstation.winrm.username = "vagrant"
    chefworkstation.winrm.password = "vagrant"
    chefworkstation.vm.guest = :windows
    chefworkstation.vm.communicator = "winrm"

    chefworkstation.vm.hostname = "chefworkstation"
    chefworkstation.windows.set_work_network = true

    chefworkstation.vm.network :forwarded_port, guest: 5985, host: 5988, id: "winrm", auto_correct: true
    chefworkstation.vm.network :forwarded_port, guest: 3389, host: 3392, id: "rdp", auto_correct: true
    chefworkstation.vm.network :forwarded_port, guest: 22, host: 2225, id: "ssh", auto_correct: true

    chefworkstation.vm.synced_folder "chef", "/chef"

    chefworkstation.vm.provider :virtualbox do |v, override|
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
    chefworkstation.vm.provision "shell", privileged: false, inline: <<-SHELL
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogon -Value 1
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultUserName -Value "vagrant"
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultPassword -Value "vagrant"
      Remove-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogonCount -Confirm -ErrorAction SilentlyContinue
    SHELL
    chefworkstation.vm.provision "reload"
    chefworkstation.vm.provision :shell, :path => "shell/PrepareWindows.ps1", privileged: false
    chefworkstation.vm.provision :shell, :path => "shell/SetWindowsPreferences.ps1", privileged: false
    chefworkstation.vm.provision :shell, :path => "shell/Generate-HostsFile.ps1", privileged: false
    chefworkstation.vm.provision :shell, :path => "shell/InstallChocolatey.ps1", privileged: false
    chefworkstation.vm.provision :shell, :path => "shell/InstallRequiredApplications.ps1", privileged: false
    chefworkstation.vm.provision :shell, :path => "shell/ConfigureGit.ps1", privileged: false
    chefworkstation.vm.provision :shell, :path => "shell/NotifyGuiAppsOfEnvironmentChanges.ps1", privileged: false
  end

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

    chocoserver.vm.provider :virtualbox do |v, override|
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
    chocoserver.vm.provision "shell", privileged: false, inline: <<-SHELL
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogon -Value 1
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultUserName -Value "vagrant"
      Set-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name DefaultPassword -Value "vagrant"
      Remove-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon" -Name AutoAdminLogonCount -Confirm -ErrorAction SilentlyContinue
    SHELL
    chocoserver.vm.provision "reload"
    chocoserver.vm.provision :shell, :path => "shell/PrepareWindows.ps1", privileged: false
    chocoserver.vm.provision :shell, :path => "shell/SetWindowsPreferences.ps1", privileged: false
    chocoserver.vm.provision :shell, :path => "shell/Generate-HostsFile.ps1", privileged: false
    chocoserver.vm.provision :shell, :path => "shell/NotifyGuiAppsOfEnvironmentChanges.ps1", privileged: false
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

    chefserver.vm.provision :shell, :path => "shell/InstallChefServer.sh"
  end
end
