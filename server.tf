resource "digitalocean_droplet" "wordpress" {
  image = "centos-7-x64"
  name = "wordpress"
  region = "nyc3"
  size = "4gb"
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
      "yum -y --enablerepo=extras install epel-release",
      "yum install -y ansible git",
      "ansible-galaxy install geerlingguy.repo-epel",
      "ansible-galaxy install geerlingguy.repo-remi",
      "ansible-galaxy install HauptJ.mariadb",
      "ansible-galaxy install HauptJ.redis",
      "ansible-galaxy install HauptJ.openresty",
      "ansible-galaxy install HauptJ.php-fpm",
    ]
  }
  provisioner "local-exec" {
    command = "echo '[wordpress]' >> inventory/wordpress/wordpress.inventory"
  }
  provisioner "local-exec" {
    command = "echo '${digitalocean_droplet.wordpress.ipv4_address}' >> inventory/wordpress/wordpress.inventory"
  }
  provisioner "local-exec" {
    command = "echo '[wordpress:vars]' >> inventory/wordpress/wordpress.inventory"
  }
  provisioner "local-exec" {
    command = "echo 'ansible_ssh_private_key_file=${var.pvt_key}' >> inventory/wordpress/wordpress.inventory"
  }
  provisioner "local-exec" {
    command = "ssh-keyscan ${digitalocean_droplet.wordpress.ipv4_address} >> ~/.ssh/known_hosts"
  }
  provisioner "local-exec" {
    command = "ansible-playbook --vault-password-file ansible/vault_test.txt -i inventory/wordpress/wordpress.inventory ansible/site.yml --syntax-check"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -e 'host_key_checking=False' --vault-password-file ansible/vault_test.txt -i inventory/wordpress/wordpress.inventory ansible/site.yml"
  }
}
