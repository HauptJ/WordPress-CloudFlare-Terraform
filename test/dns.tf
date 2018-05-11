##### TEST Server #####

resource "cloudflare_record" "test_ipv6_cf" {
  domain = "${var.cf_dns_test}"
  name = "${var.cf_dns_test_host}"
  value = "${digitalocean_droplet.test.ipv6_address}"
  type = "AAAA"
  proxied = true
}

resource "cloudflare_record" "test_ipv6_bypass" {
  domain = "${var.cf_dns_test}"
  name = "${var.cf_dns_test_bypass}"
  value = "${digitalocean_droplet.test.ipv6_address}"
  type = "AAAA"
  proxied = false
}

resource "cloudflare_record" "test_ipv4_bypass" {
  domain = "${var.cf_dns_test}"
  name = "${var.cf_dns_test_bypass}"
  value = "${digitalocean_droplet.test.ipv4_address}"
  type = "A"
  proxied = false
}
