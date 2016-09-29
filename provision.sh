#!/bin/bash

set -u # Variables must be explicit
set -e # If any command fails, fail the whole thing
set -o pipefail

# Make sure SSH knows to use the correct pem. 
# Set here your pem file to connect to aws 
ssh-add docker.pem
ssh-add -l
# Load the AWS keys.
# Create aws_keys file. In the file you will export AWS keys in the environment
# May looks like:
# export AWS_ACCESS_KEY_ID='YOURKEYS'
# export AWS_SECRET_ACCESS_KEY='YOURSECRETKEYS'
# export EC2_REGION='us-west-2'
. ./inventory/aws_keys

# Start a new instance
ansible-playbook playbook/site.yml -vv
