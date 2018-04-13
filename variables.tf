variable "domains_wordpress" {
  default = "jnh.bz"
  description = "The domain used for the WordPress site"
}

variable "dns_cf_bypass" {
  default = "dev.jnh.bz"
  description = "CloudFlare bypass"
}
