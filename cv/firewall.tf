resource "digitalocean_firewall" "cv" {
  name = "cv"

  droplet_ids = ["${digitalocean_droplet.cv.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "443"
      source_addresses   = ["2400:cb00::/32", "2405:8100::/32", "2405:b500::/32", "2606:4700::/32", "2803:f800::/32", "2c0f:f248::/32", "2a06:98c0::/29"]
    },
  ]

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "all"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "udp"
      port_range              = "all"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
}
