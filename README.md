# vagrant-box-packer
Refer for any vagrant box related help

This release has two parts.
1. This creates a Virtual box using packer. It uses debian 9 iso. It is tested on WIN7.
RUN below command in Powershell ( open with admin rights)
# packer build debian-9-stretch-virtualbox.json
we have used preseed file which supports creating LVM based root partition which can be extended.You can specify the disk size etc in json file.
this Vagrant box is available in vagrant cloud.
search for - cigeek/debian96 )
you can also create vagrant box with root disk of standard partition( Linux partition) but that may not be extended easily. refer preseed file under http folder.
At the time running please check iso_url is working.

packer build debian-9-stretch-virtualbox.json

vagrant box add .....

Reference - We have used below repo to build debian 9
https://github.com/korekontrol/packer-debian9
Please also have a look on another similar repo
https://github.com/geerlingguy/packer-debian-9
2. 
This part contains the vagarntfile which uses this box and also creates an addtional disk for app vol and docker root volume if used.

Please check the vagarntfile to set the new disk size. This box is updated with vbbox and vagrant folder is already shared ( mounted within the VM). 
This also have provisioner which installs docker and partition the new disk into two LVMs.
One may be used for app data vol and another for docker root (/var/lib/docker)to store images and continers. Please check the install.sh and make sure you update the LVM size.
