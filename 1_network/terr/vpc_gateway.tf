resource "yandex_vpc_gateway" "nat_gateway" {
#   folder_id      = "<идентификатор_каталога>"
  name = "test-gateway"
  shared_egress_gateway {}
}