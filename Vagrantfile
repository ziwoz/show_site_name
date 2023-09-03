Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.network "private_network", type: "dhcp"
    # config.vm.provision "shell", inline: <<-SHELL
    #     mkdir -p /var/www
    #   SHELL
    config.vm.synced_folder "src", "/var/www/master_src"
    config.vm.synced_folder "nginx", "/var/www/nginx"
    config.vm.synced_folder "gunicorn", "/var/www/gunicorn"
    # config.vm.synced_folder "src", "/home/vagrant/master_src"
    # config.vm.synced_folder "nginx", "/var/www/master_src"
    # config.vm.synced_folder "nginx", "/home/vagrant/nginx"
    # config.vm.synced_folder "gunicorn", "/home/vagrant/gunicorn"
    config.vm.provision :shell, path: "provision.sh"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.ssh.insert_key = false
    config.ssh.private_key_path = "~/.vagrant.d/insecure_private_key"  # Add this line
  end
  