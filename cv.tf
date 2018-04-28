# Creates and provisions DO cloud server for static CV site

resource "digitalocean_droplet" "cv" {
  depends_on = ["digitalocean_droplet.wordpress"]
  image = "centos-7-x64"
  name = "${var.do_cv_name}"
  region = "${var.do_region}"
  size = "${var.do_cv_size}"
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

  # Generate an entry in Ansible inventory file
  provisioner "local-exec" {
    command = "echo '[cv]' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo '${digitalocean_droplet.cv.ipv6_address}' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo '[cv:vars]' >> inventory/deploy.inventory"
  }

  provisioner "local-exec" {
    command = "echo 'ansible_ssh_private_key_file=${var.pvt_key}' >> inventory/deploy.inventory"
  }

  # To provision over IPv4 replace "ipv6_address" with "ipv4_address"
  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa -6v ${digitalocean_droplet.cv.ipv6_address} >> ~/.ssh/known_hosts"
  }

  # Check playbook syntax
  provisioner "local-exec" {
    command = "ansible-playbook --vault-password-file ~/vault_test.txt -i inventory/deploy.inventory ansible/cv.yml --syntax-check"
  }

  # Provision server
  provisioner "local-exec" {
    command = "ansible-playbook -e 'host_key_checking=False' --vault-password-file ~/vault_test.txt -i inventory/deploy.inventory ansible/cv.yml"
  }
}
