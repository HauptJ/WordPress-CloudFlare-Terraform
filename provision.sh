#!/bin/bash -eux

# Script to provision Vagrant Utility

pushd /vagrant
# Install Dynamic Inventory utility
go get github.com/adammck/terraform-inventory
# Install Dependencies from Ansible Galaxy
# Copy vault password file
cp ansible/vault_test.txt ~/vault_test.txt
cp deploy.vault ~/deploy.vault
chmod -x ~/vault_test.txt
chmod -x ~/deploy.vault
# Prepare SSH
mkdir -p ~/.ssh
cp deploy.key ~/.ssh/
cp deploy.pub ~/.ssh/
cp ssh_config ~/.ssh/config
chmod 700 ~/.ssh
chmod 400 ~/.ssh/*
chmod 600 ~/.ssh/config
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/deploy.key
popd
