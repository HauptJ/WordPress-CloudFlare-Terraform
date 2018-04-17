# Create an SSH key pair
resource "openstack_compute_keypair_v2" "ovh_keypair" {
  provider = "openstack.ovh"
  name = "ovh_keypair"
  public_key = "${file(var.pvt_key)}"
}

# Create OpenStack VPS
resource "openstack_compute_instance_v2" "wordpress" {
  name = "wordpress"
  provider = "openstack.ovh"
  image_name =
  flavor_name =
  region = "BHS3"
  # Get the name of the ssh key pair
  key_pair = "${openstack_compute_keypair_v2.ovh_keypair.name}"
  network {
    name = "Ext-Net" # OVH Default public network
  }
}
