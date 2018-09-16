##### DigitalOcean Vars #####
variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

##### CloudFlare Vars #####
variable "cf_email" {}
variable "cf_token" {}

##### DigitalOcean #####
provider "digitalocean" {
  token = "${var.do_token}"
}

##### CloudFlare #####
provider "cloudflare" {
  email = "${var.cf_email}"
  token = "${var.cf_token}"
}
