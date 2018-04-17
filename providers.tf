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

##### OVH OpenStack #####
provider "openstack" {
  auth_url = "https://auth.cloud.ovh.net/v3"
  domain_name = "default"
  alias = "ovh"
}

provider "ovh" {
  endpoint = "ovh-ca" # ovh-ca for Americas ovh-eu for less desirable locations
  alias = "ovh"
}

##### CloudFlare #####
provider "cloudflare" {
  email = "${var.cf_email}"
  token = "${var.cf_token}"
}
