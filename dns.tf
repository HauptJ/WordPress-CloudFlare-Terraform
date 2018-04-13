resource "cloudflare_record" "wordpress_ipv6_cf" {
  domain = "${var.domains_wordpress}"
  name = "${var.domains_wordpress}"
  value = "${digitalocean_droplet.wordpress.ipv6_address}"
  type = "AAAA"
  proxied = true
}

resource "cloudflare_record" "wordpress_ipv6_bypass" {
  domain = "${var.domains_wordpress}"
  name = "${var.dns_ipv6_bypass}"
  value = "${digitalocean_droplet.wordpress.ipv6_address}"
  type = "AAAA"
  proxied = false
}

resource "cloudflare_record" "wordpress_ipv4_bypass" {
  domain = "${var.domains.wordpress}"
  name = "${var.dns_ipv4_bypass}"
  value = "${digitalocean_droplet.wordpress.ipv4_address}"
  type = "A"
  proxied = false
}
