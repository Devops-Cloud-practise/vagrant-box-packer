# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.define "Debian" do |m|
  m.vm.box = "cigeek/debian96"
  m.vm.hostname = "debian"
  m.vm.network "private_network", ip: "192.168.33.89" 
# Creating an addtional disk to store app data. Needs to be formatted
  config.vm.provider "virtualbox" do |v|
    file_to_disk = 'disk2.vdi'
    #v.gui = true
    unless File.exist?(file_to_disk)
    v.customize ['createhd', '--filename', file_to_disk, '--size', 20 * 1024]
    end
	v.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
	end 
    m.vm.provision "shell", path: "provisioner/install.sh",
#  run: "always",
  privileged: true
end
  end