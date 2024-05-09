### network load balancer

# resource "yandex_lb_network_load_balancer" "balancer" {
#   name = "group-balancer"

#   listener {
#     name        = "http"
#     port        = 80
#     target_port = 80
#   }

#   attached_target_group {
#     target_group_id = yandex_compute_instance_group.in-group-lamp.load_balancer[0].target_group_id
#     healthcheck {
#       name = "tcp"
#       tcp_options {
#         port = 80
#       }
#     }
#   }
# }



### application load balancer


resource "yandex_alb_load_balancer" "app-load-balancer" {
  name        = "application-load-balancer"
  network_id  = yandex_vpc_network.network.id

  allocation_policy {
    location {
      zone_id   = var.default_zone
      subnet_id = yandex_vpc_subnet.public_subnet.id
    }
  }

  listener {
    name = "http"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb-http-router.id
      }
    }
  }

}

# resource "yandex_alb_target_group" "alb_target_group" {
#   name      = "my-target-group"

#   target {
#     subnet_id = "${yandex_vpc_subnet.public_subnet.id}"
#     ip_address   = "${yandex_compute_instance_group.in-group-lamp.instances[0].network_interface[0].ip_address}"
#   }
#   target {
#     subnet_id = "${yandex_vpc_subnet.public_subnet.id}"
#     ip_address   = "${yandex_compute_instance_group.in-group-lamp.instances[1].network_interface[0].ip_address}"
#   }
#     target {
#     subnet_id = "${yandex_vpc_subnet.public_subnet.id}"
#     ip_address   = "${yandex_compute_instance_group.in-group-lamp.instances[2].network_interface[0].ip_address}"
#   }

# }