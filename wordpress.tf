# Creates and provisions DO cloud server for WordPress

resource "digitalocean_droplet" "wordpress" {
  image = "centos-7-x64"
  name = "${var.do_wordpress_name}"
  region = "${var.do_region}"
  size = "${var.do_wordpress_size}"
  ipv6 = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "yum update -y"
    ]
  }

  # Make sure the Ansible inventory file exists
  provisioner "local-exec" {
    command = "touch inventory/deploy.inventory"
  }

  # Make sure the Ansible inventory file is empty
  provisioner "local-exec" {
    command = "cp /dev/null inventory/deploy.inventory"
  }

  # Generate an entry in Ansible inventory file
  provisioner "local-exec" {
    command = "echo '[wordpress]' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo '${digitalocean_droplet.wordpress.ipv6_address}' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo '[wordpress:vars]' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo 'ansible_ssh_private_key_file=${var.pvt_key}' >> inventory/deploy.inventory"
  }

  # To provision over IPv4 replace "ipv6_address" with "ipv4_address"
  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa -6v ${digitalocean_droplet.wordpress.ipv6_address} >> ~/.ssh/known_hosts"
  }

  # Check playbook syntax
  provisioner "local-exec" {
    command = "ansible-playbook --vault-password-file ~/deploy.vault -i inventory/deploy.inventory ansible/wordpress.yml --syntax-check"
  }

  # Provision server
  provisioner "local-exec" {
    command = "ansible-playbook -e 'host_key_checking=False' --vault-password-file ~/deploy.vault -i inventory/deploy.inventory ansible/wordpress.yml"
  }
}
