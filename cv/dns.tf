##### CV Server #####

resource "cloudflare_record" "cv_ipv6_cf" {
  domain = "${var.cf_dns_cv}"
  name = "${var.cf_dns_cv}"
  value = "${digitalocean_droplet.cv.ipv6_address}"
  type = "AAAA"
  proxied = true
}

resource "cloudflare_record" "cv_ipv6_bypass" {
  domain = "${var.cf_dns_cv}"
  name = "${var.cf_dns_cv_bypass}"
  value = "${digitalocean_droplet.cv.ipv6_address}"
  type = "AAAA"
  proxied = false
}

resource "cloudflare_record" "cv_ipv4_bypass" {
  domain = "${var.cf_dns_cv}"
  name = "${var.cf_dns_cv_bypass}"
  value = "${digitalocean_droplet.cv.ipv4_address}"
  type = "A"
  proxied = false
}
