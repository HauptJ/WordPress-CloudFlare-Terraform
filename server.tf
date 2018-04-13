resource "digitalocean_droplet" "wordpress" {
  image = "centos-7-x64"
  name = "wordpress"
  region = "nyc3"
  size = "4gb"
  ipv6 = true
}
