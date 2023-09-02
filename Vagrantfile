Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.network "private_network", type: "dhcp"
    config.vm.synced_folder "src", "/home/vagrant/src"
    config.vm.synced_folder "gunicorn", "/home/vagrant/gunicorn"
    config.vm.provision :shell, path: "provision.sh"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.ssh.insert_key = false
    config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"  # Add this line
  end
  