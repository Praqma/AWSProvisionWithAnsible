# AWS provisioning with Ansible
This Ansible playbook helps setup an RHEL 7 machine to run a JenkinsAsACode project.
* Create logical group and volumes on a physical disk or a partition
* Configure thinpool
* Configure docker devicemapper device to use the thinpool - allocating storage space to containers
* Install conteiner-selinux (needed by docker-ce), git, docker-ce and docker-compose
* Mount additional volumes for jenkins data and for docker data
* Create a jenkins user

Docker-ee can be installed with a few tweaks

## Preparations 
* Get the networking details for the physical RedHat server or the virtual machine (IP address).
* Attach a volume or a hard disk to the machine. Get the storage device name (or partition name), e.g. /dev/xdb1 , /dev/sdb
* Log in to the instance, change to the root user (do sudo -s). Go to /etc/sudoers and set requiretty option to false (!requiretty). In ansible.cfg the pipelining option turned on. Enabling pipelining reduces the number of SSH operations required to execute a module on the remote server, by executing many ansible modules without actual file transfer. This can result in a very significant performance improvement when enabled, however when using “sudo:” operations you must first disable ‘requiretty’ in /etc/sudoers on all managed hosts.   
*  Make sure the additional storage device shows in output of 'lsblk'. Use the device name (e.g. /dev/xdb1) as value for variable pv1 in playbook/lv/vars/main. If you want to use more devices create new variables there and add those variables to playbook/lv/tasks. 
* Make sure the IPTables rules for the machine permit ssh traffic and other relevant TCP traffic.

## How to use the setup
- Clone the project to your local machine. 
- Enter the target dns name or IP addresses and modify the credentials placeholder to match your credentials, in hosts.ini.
- Run cleanup.sh to cleanup the effect of a previous installation run. Inspect the commands in cleanup.sh to be sure that they target the right resources
- Copy your *.pem file(private key file) to the project root directory.
Run the ansible playbook:
- for remote provisioning -
```
ansible-playbook playbook/site.yml --limit jenkins_slaves
```

- for local provisioning -
```
ansible-playbook playbook/site.yml --limit local
```


 
Please note, these scripts are based on this [article](https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/#configure-direct-lvm-mode-for-production)
