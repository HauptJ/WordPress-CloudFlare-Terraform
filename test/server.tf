# Creates and provisions DO cloud server for static CV site

resource "digitalocean_droplet" "test" {
  image = "centos-7-x64"
  name = "${var.do_test_name}"
  region = "${var.do_region}"
  size = "${var.do_test_size}"
  #tags   = ["${digitalocean_tag.allow_inbound_cloudflare.id}"]
  ipv6 = true
  monitoring = true
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

  # Delete all SSH known hosts
  provisioner "local-exec" {
    command = "rm ~/.ssh/known_hosts"
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
    command = "echo '[test]' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo '${digitalocean_droplet.test.ipv6_address}' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo '[test:vars]' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo 'ansible_ssh_private_key_file=${var.pvt_key}' >> inventory/deploy.inventory"
  }

  # To provision over IPv4 replace "ipv6_address" with "ipv4_address"
  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa -6v ${digitalocean_droplet.test.ipv6_address} >> ~/.ssh/known_hosts"
  }

  # Check playbook syntax
  provisioner "local-exec" {
    command = "ansible-playbook --vault-password-file ~/deploy.vault -i inventory/deploy.inventory ../ansible/test.yml --syntax-check"
  }

  # Provision server
  provisioner "local-exec" {
    command = "ansible-playbook -e 'host_key_checking=False' --vault-password-file ~/deploy.vault -i inventory/deploy.inventory ../ansible/test.yml"
  }
}
