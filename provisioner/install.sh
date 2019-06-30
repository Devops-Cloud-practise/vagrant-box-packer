#!/bin/bash
apt-get update && apt-get install -y \
curl \
bc \
parted \
&& curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && usermod -aG docker vagrant #&& rm -rf /var/lib/apt/lists/* ( remove only if you are building docker image to make light weight)
(
echo n
echo
echo 1
echo
echo '+8G'
echo t
echo '8e'
echo p
echo n
echo
echo 2
echo
echo '+8G'
echo t
echo 2
echo '8e'
echo p
echo w
echo q
) | fdisk  /dev/sdb
partprobe
#https://www.tecmint.com/create-lvm-storage-in-linux/
pvcreate /dev/sdb1 /dev/sdb2 && pvs
vgcreate app_docker_vg /dev/sdb1 /dev/sdb2 && vgs
# create 7  GB logical vol . use bc to calculate PEs . one PE=4 MB. Use -L to define size inn GB
lvcreate -l 1792 -n app_data app_docker_vg
lvcreate -l 1792 -n docker_vol app_docker_vg
lvs app_docker_vg
mkfs.ext4 /dev/mapper/app_docker_vg-app_data
sleep 5
mkfs.ext4 /dev/mapper/app_docker_vg-docker_vol
sleep 5
mkdir /app_data /docker_root_vol
mount /dev/mapper/app_docker_vg-app_data /app_data/
mount /dev/mapper/app_docker_vg-docker_vol /docker_root_vol/
df -hT
blkid
#update fstab for persistant mounting
echo "UUID=$(blkid -s UUID -o value /dev/mapper/app_docker_vg-app_data) /app_data ext4 defaults 0 0" | tee -a /etc/fstab
echo "UUID=$(blkid -s UUID -o value /dev/mapper/app_docker_vg-docker_vol) /docker_root_vol ext4 defaults 0 0" | tee -a /etc/fstab
#Moving Docker root dir to new mount 
service docker stop && mv /var/lib/docker /docker_root_vol/ && ln -s /docker_root_vol/docker /var/lib/docker && service docker start



 


