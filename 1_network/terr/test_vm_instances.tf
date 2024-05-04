resource "yandex_compute_instance" "test_vm_public" {
  name        = "test-vm-public"
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vms_resources.cores.test
    memory        = var.vms_resources.memory.test
    core_fraction = var.vms_resources.core_fraction.test
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vms_resources.size.test
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    ssh-keys           = local.ssh-keys-test-vm
  }

}

resource "yandex_compute_instance" "test_vm_private" {
  name        = "test-vm-private"
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vms_resources.cores.test
    memory        = var.vms_resources.memory.test
    core_fraction = var.vms_resources.core_fraction.test
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vms_resources.size.test
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat       = false
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    ssh-keys           = local.ssh-keys-test-vm
  }

}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_family
}