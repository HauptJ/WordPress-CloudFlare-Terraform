# Creates and provisions DO cloud server for static CV site

resource "digitalocean_droplet" "cv" {
  image = "centos-7-x64"
  name = "${var.do_cv_name}"
  region = "${var.do_region}"
  size = "${var.do_cv_size}"
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

  # Make sure known hosts exists
  provisioner "local-exec" {
    command = "touch ~/.ssh/known_hosts"
  }

  # Make sure known_hosts is empty
  provisioner "local-exec" {
    command = "cp /dev/null ~/.ssh/known_hosts"
  }

  # To provision over IPv6 replace "ipv4_address" with "ipv6_address" and use ssh-keyscan -t rsa -6v
  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa ${digitalocean_droplet.cv.ipv4_address} >> ~/.ssh/known_hosts"
  }

  # Check playbook syntax
  provisioner "local-exec" {
    command = "TF_STATE=terraform.tfstate ansible-playbook --private-key=~/.ssh/deploy.key --inventory-file=~/go/bin/terraform-inventory ../ansible/cv.yml --syntax-check"
  }

  # Provision server
  provisioner "local-exec" {
    command = "TF_STATE=terraform.tfstate ansible-playbook --private-key=~/.ssh/deploy.key --inventory-file=~/go/bin/terraform-inventory ../ansible/cv.yml"
  }
}
