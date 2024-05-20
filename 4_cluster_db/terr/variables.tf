###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

// network

variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_c" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_public" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_public2" {
  type        = list(string)
  default     = ["192.168.100.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_public3" {
  type        = list(string)
  default     = ["192.168.110.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_private" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_private2" {
  type        = list(string)
  default     = ["192.168.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_old_name" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}

variable "vpc_name" {
  type        = string
  default     = "my_network"
  description = "VPC network name"
}

variable "public_subnet_name" {
  type        = string
  default     = "public"
  description = "subnet name"
}

variable "public_subnet_name2" {
  type        = string
  default     = "public2"
  description = "subnet name"
}

variable "public_subnet_name3" {
  type        = string
  default     = "public3"
  description = "subnet name"
}

variable "private_subnet_name" {
  type        = string
  default     = "private"
  description = "subnet name"
}

variable "private_subnet_name2" {
  type        = string
  default     = "private2"
  description = "subnet name"
}

// instances

variable "NAT_instance_ID" {
  type    = string
  default = "fd8e09l2blguqbdk5eej"
}

variable "instance_gr_lamp_id" {
  type    = string
  default = "fd827b91d99psvq5fjit"
  description = "ID of LAMP instance image"
}

variable "vm_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_platform_id" {
  type    = string
  default = "standard-v1"
}

variable "ssh_login" {
  type    = string
  default = "admin"
}

variable "ssh_login_test_vm" {
  type    = string
  default = "admin"
}

variable "ssh_file" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "secure_file" {
  type    = string
  default = "secure"
  description = "my secure file"
}

variable "vms_resources" {
  type = map(any)
  default = {
    "cores" = {
      nat  = 2
      test = 2
    }
    "memory" = {
      nat  = 2
      test = 2
    }
    "core_fraction" = {
      nat  = 5
      test = 5
    }
    "size" = {
      nat  = 10
      test = 10
    }
  }
  description = "resources for test VMs and NAT-instance"
}

variable "vms_resources2" {
  type = map(any)
  default = {
    "nat" = {
      nat  = true
      test = false
    }
    "preemptible" = {
      nat  = true
      test = true
    }
  }
  description = "resources for test VMs and NAT-instance"
}

variable "serial-port-enable" {
  default = "0"
}

variable "nat-instance_name" {
  type    = string
  default = "nat-instance"
  description = "nat-instance_name"
}

variable "nat-instance_ip_address" {
  type    = string
  default = "192.168.10.254"
  description = "nat-instance_ip_address"
}

variable "file_cloud-init" {
  type    = string
  default = "./cloud-init-test-vm.yaml"
  description = "cloud-init file for nat-instance and test VMs and k8s node groups"
}

variable "nat-instance-route_name" {
  type    = string
  default = "nat-instance-route"
  description = "nat-instance-route_name"
}

variable "nat-instance-destination_prefix" {
  type    = string
  default = "0.0.0.0/0"
  description = "nat-instance-destination_prefix"
}

variable "instance_test_vm_public_name" {
  type    = string
  default = "test-vm-public"
  description = "instance_test_vm_public_name"
}

variable "instance_test_vm_private_name" {
  type    = string
  default = "test-vm-private"
  description = "instance_test_vm_private_name"
}

// mysql

variable "mysql_cluster_name" {
  type    = string
  default = "mysql_cluster"
  description = "mysql cluster name"
}

variable "mysql_environment" {
  type    = string
  default = "PRESTABLE"
  description = "mysql environment"
}

variable "mysql_version" {
  type    = string
  default = "8.0"
  description = "mysql version"
}

variable "mysql_deletion_protection" {
  type    = string
  default = "true"
  description = "mysql deletion protection?"
}

variable "mysql_resource_preset_id" {
  type    = string
  default = "b1.medium"
  description = "mysql resource preset id https://yandex.cloud/en/docs/managed-mysql/concepts/instance-types"
}

variable "mysql_disk_type_id" {
  type    = string
  default = "network-ssd"
  description = "mysql disk type id"
}

variable "mysql_disk_size" {
  type    = string
  default = "20"
  description = "mysql disk size"
}

variable "mysql_maintenance_window_type" {
  type    = string
  default = "ANYTIME"
  description = "mysql maintenance window type (время технического обслуживания (в т. ч. для выключенных кластеров)"
}

variable "mysql_backup_window_start_hour" {
  type    = string
  default = "23"
  description = "mysql backup_window_start (время начала резервного копирования) - час"
}

variable "mysql_backup_window_start_minute" {
  type    = string
  default = "59"
  description = "mysql backup_window_start (время начала резервного копирования) - минута"
}

variable "mysql_backup_retain_period_days" {
  type    = string
  default = "10"
  description = "mysql backup_retain_period_days срок хранения резервных копий (от 7 до 60)"
}

variable "mysql_database_name" {
  type    = string
  default = "netology_db"
  description = "mysql mysql_database name"
}

variable "mysql_user_name" {
  type    = string
  default = "user1"
  description = "mysql user name"
}

variable "mysql_user_password" {
  type    = string
  default = "user1user1"
  description = "mysql user name"
}

variable "mysql_user_permission_roles" {
  type    = string
  default = "ALL"
  description = "mysql user permission roles"
}

// k8s

variable "kubernetes_cluster_name" {
  type    = string
  default = "k8s-regional"
  description = "kubernetes cluster name"
}

variable "kubernetes_cluster_public_ip" {
  type    = string
  default = "true"
  description = "kubernetes_cluster_public_ip ?"
}

variable "kubernetes_iam_service_account_name" {
  type    = string
  default = "regional-k8s-account"
  description = "K8S regional service account"
}

variable "kubernetes_role_k8s_clusters_agent" {
  type    = string
  default = "k8s.clusters.agent"
  description = "Сервисному аккаунту назначается роль  k8s.clusters.agent"
}
variable "kubernetes_role_vpc_publicAdmin" {
  type    = string
  default = "vpc.publicAdmin"
  description = "Сервисному аккаунту назначается роль  vpc.publicAdmin"
}
variable "kubernetes_role_container_registry_images_puller" {
  type    = string
  default = "container-registry.images.puller"
  description = "Сервисному аккаунту назначается роль  container-registry.images.puller"
}
variable "kubernetes_role_kms_keys_encrypterDecrypter" {
  type    = string
  default = "kms.keys.encrypterDecrypter"
  description = "Сервисному аккаунту назначается роль  kms.keys.encrypterDecrypter"
}

variable "kubernetes_role_logging_writer" {
  type    = string
  default = "logging.writer"
  description = "Сервисному аккаунту назначается роль  logging.writer"
}

variable "kubernetes_role_load_balancer_admin" {
  type    = string
  default = "load-balancer.admin"
  description = "Сервисному аккаунту назначается роль  load-balancer.admin"
}

variable "kubernetes_kms_key_name" {
  type    = string
  default = "kms-key"
  description = "Ключ Yandex Key Management Service для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи."
}

variable "kubernetes_kms_default_algorithm" {
  type    = string
  default = "AES_128"
  description = "kubernetes_kms_default_algorithm"
}

variable "kubernetes_kms_rotation_period" {
  type    = string
  default = "8760h"
  description = "kubernetes_kms_rotation_period (8760h - 1 год.)"
}

variable "kubernetes_node_group_name_a" {
  type    = string
  default = "k8s-nodes-a"
  description = "kubernetes_node_group_name"
}

variable "kubernetes_node_group_name_b" {
  type    = string
  default = "k8s-nodes-b"
  description = "kubernetes_node_group_name"
}

variable "kubernetes_node_group_name_d" {
  type    = string
  default = "k8s-nodes-d"
  description = "kubernetes_node_group_name"
}

variable "kubernetes_instances_name" {
  type    = string
  default = "netology-k8s-node-{instance.short_id}-{instance_group.id}"
  description = "kubernetes_instances_name https://yandex.cloud/ru/docs/managed-kubernetes/operations/node-group/node-group-create#tf_1"
}

variable "kubernetes_instances_platform_id_for_d" {
  type    = string
  default = "standard-v3"
  description = "https://yandex.cloud/ru/docs/overview/concepts/zone-migration-consequences https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "kubernetes_instances_platform_id" {
  type    = string
  default = "standard-v1"
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-platforms"
}

variable "kubernetes_instances_network_acceleration_type" {
  type    = string
  default = "standard"
  description = "kubernetes_instances_network_acceleration_type"
}

variable "kubernetes_instances_container_runtime_type" {
  type    = string
  default = "containerd"
  description = "kubernetes_instances_container_runtime_type"
}

variable "kubernetes_instances_scale_policy_min" {
  type    = string
  default = "3"
  description = "минимальное_количество_узлов_в_группе_узлов"
}

variable "kubernetes_instances_scale_policy_max" {
  type    = string
  default = "6"
  description = "максимальное_количество_узлов_в_группе_узлов"
}

variable "kubernetes_instances_scale_policy_initial" {
  type    = string
  default = "3"
  description = "начальное_количество_узлов_в_группе_узлов"
}

variable "kubernetes_instances_boot_disk_type" {
  type    = string
  default = "network-hdd"
  description = "kubernetes_instances_boot_disk_type"
}

variable "kubernetes_instances_boot_disk_size" {
  type    = string
  default = "64"
  description = "kubernetes_instances_boot_disk_size"
}

variable "kubernetes_instances_resources_memory" {
  type    = string
  default = "8"
  description = "kubernetes_instances_resources_memory"
}

variable "kubernetes_instances_resources_core_fraction" {
  type    = string
  default = "5"
  description = "kubernetes_instances_resources_memory"
}

variable "kubernetes_instances_resources_cores" {
  type    = string
  default = "4"
  description = "kubernetes_instances_resources_cores"
}

variable "kubernetes_instances_preemptible" {
  type    = string
  default = "true"
  description = "kubernetes_instances_preemptible"
}

variable "kubernetes_instances_network_interface_nat" {
  type    = string
  default = "true"
  description = "kubernetes_instances_network_interface_nat"
}