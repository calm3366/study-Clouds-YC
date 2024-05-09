resource "yandex_compute_instance" "nat_instance" {
  name        = "nat-instance"
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vms_resources.cores.nat
    memory        = var.vms_resources.memory.nat
    core_fraction = var.vms_resources.core_fraction.nat
  }
  boot_disk {
    initialize_params {
      image_id = var.NAT_instance_ID
      size     = var.vms_resources.size.nat
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public_subnet.id
    ip_address = "192.168.10.254"
    nat        = true
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    ssh-keys           = local.ssh-keys
  }
}