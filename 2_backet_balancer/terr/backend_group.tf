resource "yandex_alb_backend_group" "backend-group" {
  name      = "my-backend-group"

#   session_affinity {
#     connection {
#       source_ip = "127.0.0.1"
#     }
#   }

  http_backend {
    name = "test-http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_alb_target_group.alb_target_group.id}"]
    # target_group_ids = ["${yandex_compute_instance_group.in-group-lamp.application_load_balancer[0].target_group_id}"]
    # tls {
    #   sni = "backend-domain.internal"
    # }
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
    http2 = "false"
  }
}