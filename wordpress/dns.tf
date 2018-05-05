##### WordPress Server #####

resource "cloudflare_record" "wordpress_ipv6_cf" {
  domain = "${var.cf_dns_wordpress}"
  name = "${var.cf_dns_wordpress}"
  value = "${digitalocean_droplet.wordpress.ipv6_address}"
  type = "AAAA"
  proxied = true
  depends_on = ["digitalocean_droplet.wordpress"]
}

resource "cloudflare_record" "wordpress_ipv6_bypass" {
  domain = "${var.cf_dns_wordpress}"
  name = "${var.cf_dns_wordpress_bypass}"
  value = "${digitalocean_droplet.wordpress.ipv6_address}"
  type = "AAAA"
  proxied = false
  depends_on = ["digitalocean_droplet.wordpress"]
}

resource "cloudflare_record" "wordpress_ipv4_bypass" {
  domain = "${var.cf_dns_wordpress}"
  name = "${var.cf_dns_wordpress_bypass}"
  value = "${digitalocean_droplet.wordpress.ipv4_address}"
  type = "A"
  proxied = false
  depends_on = ["digitalocean_droplet.wordpress"]
}
