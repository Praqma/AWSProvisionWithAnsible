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

