echo "Pleas look in the cleanup file to be sure the right resources are being targeted. Feel free to add to or remove from the list if you know what you are doing"

yum -y remove docker*
sleep 5
umount /var/lib/docker
umount /home/jenkins
rm -rf /etc/docker
rm -rf /var/lib/docker
rm -rf /etc/systemd/system/docker.service.d
sleep 2
echo 'y' | lvremove /dev/docker/thinpool
sleep 2
echo 'y' | lvremove /dev/docker/docker-meta
echo 'y' | lvremove /dev/docker/jenkins-home
echo 'y' | lvremove /dev/docker/thinpoolmeta
echo 'y' | lvremove /dev/docker/docker-data

