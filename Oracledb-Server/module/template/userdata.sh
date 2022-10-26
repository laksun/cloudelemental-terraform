#!/bin/bash
echo '[Installing and Starting Systems Manager Agent]'
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent
echo '[Cloning: Load QuickStart Common Utils]'
yum install -y git
#until git clone --single-branch -b develop https://github.com/aws-quickstart/quickstart-linux-utilities.git\
#              \ ; do echo \"Retrying\";done
git clone --single-branch -b develop https://github.com/aws-quickstart/quickstart-linux-utilities.git
cd quickstart-linux-utilities
source quickstart-cfn-tools.source
echo '[Loaded: Load QuickStart Common Utils]'
echo '[Update Operating System]'
qs_update-os || qs_error
qs_bootstrap_pip || qs_error
yum -y install python3-setuptools
yum install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
qs_aws-cfn-bootstrap || qs_error