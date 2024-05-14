resource "yandex_compute_instance_group" "in-group-lamp" {
  name                = "inst-group-lamp"
  folder_id           = var.folder_id
  service_account_id  = local.service_id_admin
  deletion_protection = false
  instance_template {
    platform_id = var.vm_platform_id
    resources {
      memory = 2
      cores  = 2
      core_fraction = 5
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.instance_gr_lamp_id
        size     = 10
      }
    }

  scheduling_policy {
      preemptible = true
  }

  network_interface {
      network_id = yandex_vpc_network.network.id
      subnet_ids = [yandex_vpc_subnet.public_subnet.id]
      nat = true
  }
    metadata = {
      serial-port-enable = var.serial-port-enable
      user-data          = data.template_file.cloudinit.rendered
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 3 # Максимальное количество запущенных экземпляров, которые можно перевести в автономный режим (остановить или удалить) одновременно во время процесса обновления.
    max_creating    = 3 # Максимальное количество экземпляров, которые можно создать одновременно.
    max_expansion   = 3 # Максимальное количество экземпляров, которые можно временно выделить сверх целевого размера группы во время процесса обновления.
    max_deleting    = 1 # Максимальное количество экземпляров, которые можно удалить одновременно.
  }

  # load_balancer {
  #   target_group_name        = "auto-group-tg"
  #   target_group_description = "network load balancer target group"
  # }

  application_load_balancer {
    target_group_name        = "auto-group-tg"
    target_group_description = "application load balancer target group"
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yaml")
  vars = {
    username       = var.ssh_login_test_vm
    ssh_public_key = local.file_ssh
    bucket_name = yandex_storage_bucket.my-bucket.bucket
    file_name = yandex_storage_object.some-picture.key
  }
}


