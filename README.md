# WordPress-CloudFlare-Terraform
Terraform script to orchestrate deployment of WordPress on a DigitalOcean VPS with CloudFlare DNS and Web Application Firewall (WAF)

USAGE
-----
- To pull the submodules, use: `git submodule update --init --recursive`
Read: [Easy way to pull latest of all git submodules](https://stackoverflow.com/questions/1030169/easy-way-to-pull-latest-of-all-git-submodules)

- Set the variables in `variables.tf` to your domain name, preferred DO region and droplet size.
**NOTE:** Droplet size must be at least 2gb.

- Set the Ansible variables in `ansible/group_vars`. To decrypt `vault.yml` use: `ansible-vault --vault-password-file vault_test.txt decrypt vault.yml` The vault password can be found in  `ansible/vault_test.txt`. To encrypt the vault, use: `ansible-vault --vault-password-file vault_test.txt encrypt vault.yml`.


Export your DigitalOcean API key, CloudFlare API key and the Email address associated with your CloudFlare account.
- `export DO_PAT=YOUR_DO_API_KEY`
- `export CF_PAT=YOUR_CF_API_KEY`
- `export CF_EMAIL=YOUR_CF_EMAIL`

Initialize Terraform
- `terraform init`

Make a Terraform plan to deploy everything.
```
terraform plan -out=terraform.tfplan \
  -var "do_token=$DO_PAT" \
  -var "cf_email=$CF_EMAIL" \
  -var "cf_token=$CF_PAT" \
  -var "pub_key=$HOME/.ssh/pub_key.pub" \
  -var "pvt_key=$HOME/.ssh/priv_key" \
  -var "ssh_fingerprint=75:b0:fc:16:8a:f6:32:a7:fe:a5:93:90:ad:b8:0a:12"
```

...or to destroy everything
```
terraform plan -destroy -out=terraform.tfplan \
  -var "do_token=$DO_PAT" \
  -var "cf_email=$CF_EMAIL" \
  -var "cf_token=$CF_PAT" \
  -var "pub_key=$HOME/.ssh/pub_key.pub" \
  -var "pvt_key=$HOME/.ssh/priv_key" \
  -var "ssh_fingerprint=75:b0:fc:16:8a:f6:32:a7:fe:a5:93:90:ad:b8:0a:12"
```

Apply the Terraform plan.
- `terraform apply terraform.tfplan`

When you run the plan to deploy everything, an inventory file with the IP addresses of the servers will be automatically generated. The inventory file is located in `inventory/deploy.inventory`. **NOTE:** by default, the IPv6 addresses of the servers will be inserted into the inventory file, to change this you can replace
`ipv6_address` with `ipv4_address`.

The automatically generated Ansible inventory file should look like this:
```
[wordpress]
2604:a880:0800:00a1:0000:0000:1d32:5001
[wordpress:vars]
ansible_ssh_private_key_file=/root/.ssh/deploy.key
[cv]
2604:a880:0800:00a1:0000:0000:7315:2001
[cv:vars]
ansible_ssh_private_key_file=/root/.ssh/deploy.key
```
