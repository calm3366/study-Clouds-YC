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
    user-data          = data.template_file.cloudinit-test-vm.rendered
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
    user-data          = data.template_file.cloudinit-test-vm.rendered
  }

}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_family
}

data "template_file" "cloudinit-test-vm" {
  template = file("./cloud-init-test-vm.yaml")
  vars = {
    username       = var.ssh_login_test_vm
    ssh_public_key = local.file_ssh
  }
}
