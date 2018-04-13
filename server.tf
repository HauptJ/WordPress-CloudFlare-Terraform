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
}
