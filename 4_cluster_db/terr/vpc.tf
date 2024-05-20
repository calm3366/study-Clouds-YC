resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = var.public_subnet_name
  zone           = var.zone_a
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.default_cidr_public
}

resource "yandex_vpc_subnet" "public_subnet2" {
  name           = var.public_subnet_name2
  zone           = var.zone_b
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.default_cidr_public2
}

resource "yandex_vpc_subnet" "public_subnet3" {
  name           = var.public_subnet_name3
  zone           = var.zone_c
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.default_cidr_public3
}

resource "yandex_vpc_subnet" "private_subnet" {
  name           = var.private_subnet_name
  zone           = var.zone_a
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.default_cidr_private
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

resource "yandex_vpc_subnet" "private_subnet2" {
  name           = var.private_subnet_name2
  zone           = var.zone_b
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.default_cidr_private2
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}











