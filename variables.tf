variable "os_region" {
  default = "BHS3"
  description = "OS server region"
  # OVH OS regions
  # BHS3: Beauharnois, Canada
  # GRA3: Gravelines, France
  # SBG3: Strasbourg, France
  # WAS1: Washington D.C. / Northern Virginia (coming soon)
}

variable "os_flavor" {
  default = "s1-8"
  description = "OS flavor / size NOTE: must be at least 2gb"
  # SEE: https://www.ovh.com/world/public-cloud/instances/prices/
}

variable "os_net" {
  default = "Ext-Net"
  description = "OS compute network"
  # OVH uses Ext-Net as the default public network
}

variable "domains_wordpress" {
  default = "jnh.bz"
  description = "The proxied domain used for the WordPress site"
}

variable "dns_cf_bypass" {
  default = "dev.jnh.bz"
  description = "CloudFlare proxy bypass hostname"
}
