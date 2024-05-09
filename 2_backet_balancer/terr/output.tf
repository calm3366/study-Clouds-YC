output "info_vm" {
  value = concat(local.info_NAT_instance, local.info_test_vm_public, local.info_test_vm_private,local.info_balancer)
}
