resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = var.nat-instance-route_name
  network_id = yandex_vpc_network.network.id
  static_route {
    destination_prefix = var.nat-instance-destination_prefix
    next_hop_address   = yandex_compute_instance.nat_instance.network_interface.0.ip_address
  }
}