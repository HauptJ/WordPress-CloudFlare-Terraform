variable "do_region" {
  default = "nyc3"
  description = "DigitalOcean Droplet region"
}

variable "do_wordpress_size" {
  default = "4gb"
  description = "DigitalOcean Droplet size for the WordPress server NOTE: must be at least 2gb"
}

variable "do_wordpress_name" {
  default = "wordpress"
  description = "DigitalOcean Droplet name for the WordPress server"
}

variable "do_cv_size" {
  default = "2gb"
  description = "DigitalOcean Droplet Size for the CS server"
}

variable "do_cv_name" {
  default = "cv"
  description = "DigitalOcean Droplet name for CV server"
}

variable "cf_dns_wordpress" {
  default = "###"
  description = "The proxied domain used for the WordPress server"
}

variable "cf_dns_wordpress_bypass" {
  default = "###"
  description = "CloudFlare proxy bypass hostname for the WordPress server"
}

variable "cf_dns_cv" {
  default = "###"
  description = "The proxied domain used for the CV server"
}

variable "cf_dns_cv_bypass" {
  default = "###"
  description = "CloudFlare proxy bypass hostname tor the CV server"
}
