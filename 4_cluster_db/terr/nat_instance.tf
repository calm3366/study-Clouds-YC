resource "yandex_compute_instance" "nat_instance" {
  name        = var.nat-instance_name
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
    preemptible = var.vms_resources2.preemptible.nat
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public_subnet.id
    ip_address = var.nat-instance_ip_address
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat        = var.vms_resources2.nat.nat
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    user-data          = data.template_file.cloudinit.rendered
  }
}

data "template_file" "cloudinit" {
  template = file(var.file_cloud-init)
  vars = {
    username       = var.ssh_login_test_vm
    ssh_public_key = local.file_ssh
  }
}