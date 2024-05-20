locals {
  file_ssh         = sensitive(file(var.ssh_file))
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

}

