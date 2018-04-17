variable "do_region" {
  default = "nyc3"
  description = "DigitalOcean Droplet region"
}

variable "do_size" {
  default = "4gb"
  description = "DigitalOcean Droplet Size NOTE: must be at least 2gb"
}

variable "domains_wordpress" {
  default = "jnh.bz"
  description = "The proxied domain used for the WordPress site"
}

variable "dns_cf_bypass" {
  default = "dev.jnh.bz"
  description = "CloudFlare proxy bypass hostname"
}
