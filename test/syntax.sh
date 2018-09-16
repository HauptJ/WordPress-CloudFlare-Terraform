#!/bin/bash -eux

# test playbook syntax
ansible-playbook --vault-password-file ~/deploy.vault -i inventory/deploy.inventory ../ansible/test.yml --syntax-check
