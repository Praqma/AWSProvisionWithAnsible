# AWS provisioning with Ansible
This Ansible playbook helps setup your AWS RHEL 7 machine to run a JenkinsAsACode project.
* Create logical group and volumes on a physical disk or a partition
* Configure thinpool
* Configure docker devicemapper device to use the thinpool - allocating storage space to containers
* Install git, docker-ce and docker-compose
* Mount additional volumes for jenkins data and for docker data
* Create a jenkins user

Docker-ee can't be installed with a few tweaks

## Preparations 
* Get the networking details for the physical RedHat server or the virtual machine.
* Attach a volume or a hard disk to the machine. Get the storage device name (or partition name), e.g. /dev/xdb1
* Log in to the instance, set root user (do sudo -s). Go to /etc/sudoers and set requiretty option to false (!requiretty). In ansible.cfg the pipelining option turned on. Enabling pipelining reduces the number of SSH operations required to execute a module on the remote server, by executing many ansible modules without actual file transfer. This can result in a very significant performance improvement when enabled, however when using “sudo:” operations you must first disable ‘requiretty’ in /etc/sudoers on all managed hosts.   
* Make sure the additional EBS device has /dev/xvdf path, if not change variable pv1 in playbook/lv/vars/main. If you want to use more devices create new variables there and add those variables to playbook/lv/tasks. 
* Create a tag for tha instance. For example ansible-test. Set this tag to site.yml file in the hosts parametr like tag_<your tag>
* Make sure the instances security group has opened SSH port and open TCP port for all inbound traffic.

## How to use the setup
Clone the project to your local machine. 
Create a aws_keys file to the inventory folder. Set there your AWS account details to export those in to your environment: 
 ```
 export AWS_ACCESS_KEY_ID='YOURKEYS'
 export AWS_SECRET_ACCESS_KEY='YOURSECRETKEYS'
 export EC2_REGION='your-region'
```
Copy your *.pem file to the project root directory. Go to provision.sh and change the name of pem file.
Run ansible provisioning:
```
./provision.sh
```

Please note, these scripts are based on this [article](https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/#configure-direct-lvm-mode-for-production)
