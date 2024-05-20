resource "yandex_compute_instance" "test_vm_public" {
  name        = var.instance_test_vm_public_name
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
    preemptible = var.vms_resources2.preemptible.test
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = var.vms_resources2.nat.test
  }
  metadata = {
    serial-port-enable = var.serial-port-enable
    user-data          = data.template_file.cloudinit.rendered
  }
}

resource "yandex_compute_instance" "test_vm_private" {
  name        = var.instance_test_vm_private_name
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
    preemptible = var.vms_resources2.preemptible.test
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet.id
    nat       = var.vms_resources2.nat.test
  }
  metadata = {
    serial-port-enable = var.serial-port-enable
    user-data          = data.template_file.cloudinit.rendered
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_family
}


