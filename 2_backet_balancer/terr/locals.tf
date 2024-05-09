locals {
  # vm_web_platform_name = "vm-test-${var.vm_family}"
  file_ssh         = file(var.ssh_file)
  ssh-keys         = sensitive("${var.ssh_login}:${local.file_ssh}")
  ssh-keys-test-vm = sensitive("${var.ssh_login_test_vm}:${local.file_ssh}")
  service_id_admin =  sensitive(file(var.secure_file))

  info_NAT_instance = [zipmap(
    ["1. Name", "2. EXTERNAL IP:", "3. INTERNAL IP:"],
    [
      yandex_compute_instance.nat_instance.name,
      yandex_compute_instance.nat_instance.network_interface[0].nat_ip_address,
      yandex_compute_instance.nat_instance.network_interface[0].ip_address
    ]
  )]

  info_test_vm_public = [zipmap(
    ["1. Name", "2. EXTERNAL IP:", "3. INTERNAL IP:"],
    [
      yandex_compute_instance.test_vm_public.name,
      yandex_compute_instance.test_vm_public.network_interface[0].nat_ip_address,
      yandex_compute_instance.test_vm_public.network_interface[0].ip_address
    ]
  )]

  info_test_vm_private = [zipmap(
    ["1. Name", "2. EXTERNAL IP:", "3. INTERNAL IP:"],
    [
      yandex_compute_instance.test_vm_private.name,
      yandex_compute_instance.test_vm_private.network_interface[0].nat_ip_address,
      yandex_compute_instance.test_vm_private.network_interface[0].ip_address
    ]
  )]

  info_balancer = [zipmap(
    ["1. Name", "2. EXTERNAL IP:"],
    [
      yandex_alb_load_balancer.app-load-balancer.name,
      element(yandex_alb_load_balancer.app-load-balancer.listener[0].endpoint[0].address[0].external_ipv4_address, 0)
    ]
  )]
}

