# AWS provisioning with Ansible
Here is Ansible setup helps you prepare your AWS RHEL 7 instance to run up JenkinsAsACode project.
* Create logical group and volumes on the EBS volume
* Configure thinpool
* Configure docker devicemapper device to use the thinpool
* Install git, docker and docker-compose
* Mount additional volumes for jenkins data and for docker data
* Create a jenkins user

## Preparations 
* Create an AWS Red Hat Enterprise Linux 7.2 7.2 instance. Create an EBS volume needed capacity in the same region.
* Attach the volume to the instance.
* Create a pem file or say AWS to use existed one.
* Log in to the instance, set a root user (do sudo -s). Go to /etc/sudoers and set requiretty option to false (!requiretty). Connection to aws goes with ec2-user, but installation and configuration commands we need to execute under sudo. By default, sudo requires tty, but ansible connects to the instance without terminal. So we need to disable this option.
* Make sure the additional EBS device has /dev/xvdf path, if not change variable pv1 in playbook/lv/vars/main. If you want to use more devices create new variables there and add those variables to playbook/lv/tasks. 
* Create a tag for tha instance. For example ansible-test. Set this tag to site.yml file in the hosts parametr like tag_<your tag>
* Make sure the instances security group has opened SSH port and open TCP port for all inbound traffic.

## How to use the setup
Clone the project to your local machine. 
Create a aws_keys file to the inventory folder. Set there your AWS account details to export those in to your environment: 
 ```
 export AWS_ACCESS_KEY_ID='YOURKEYS'
 export AWS_SECRET_ACCESS_KEY='YOURSECRETKEYS'
 export EC2_REGION='us-west-2'
```
Copy your *.pem file to the project root directory. Go to provision.sh and change the name of pem file.
Run ansible provisioning:
```
./provision.sh
```