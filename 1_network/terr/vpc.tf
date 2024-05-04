# Для старого проекта
resource "yandex_vpc_network" "develop" {
  name = var.vpc_old_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_old_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Для нового
resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public_subnet" {
  name           = var.public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.default_cidr_public
}

resource "yandex_vpc_subnet" "private_subnet" {
  name           = var.private_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.default_cidr_private
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}












