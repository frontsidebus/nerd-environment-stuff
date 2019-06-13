#!/bin/bash

AUTHENTICATOR_BIN_URL="https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator"


# installing aws cli on ubuntu 18.04 LTS for WSL

update_system () {
	sudo apt-get update && apt-get upgrade -y	
}

install_python_deps () {
	sudo apt-get install -y python3 python3-pip
	pip3 install --upgrade pip
}

install_aws_cli () {
	pip3 install awscli --upgrade --user

}

install_aws_iam_authenticator () {
	curl -o aws-iam-authenticator $AUTHENTICATOR_BIN_URL
	chmod 755 ./aws-iam-authenticator
	if [ -d "$HOME/bin" ]
	then
		cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
	else
		mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
	fi
	echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
	#now test to make sure it's working as expected
	aws-iam-authenticator help &>/dev/null && echo "aws-iam-authenticator successfully installed"
}

update_system
install_python_deps
install_aws_cli
install_aws_iam_authenticator
