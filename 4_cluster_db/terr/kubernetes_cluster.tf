resource "yandex_kubernetes_cluster" "k8s-regional" {
  name = var.kubernetes_cluster_name
  network_id = yandex_vpc_network.network.id
  
  master {
    master_location {
      zone      = yandex_vpc_subnet.public_subnet.zone
      subnet_id = yandex_vpc_subnet.public_subnet.id
    }
    master_location {
      zone      = yandex_vpc_subnet.public_subnet2.zone
      subnet_id = yandex_vpc_subnet.public_subnet2.id
    }
    master_location {
      zone      = yandex_vpc_subnet.public_subnet3.zone
      subnet_id = yandex_vpc_subnet.public_subnet3.id
    }
    # security_group_ids = [yandex_vpc_security_group.regional-k8s-sg.id]
    public_ip = var.kubernetes_cluster_public_ip
  }
  service_account_id      = yandex_iam_service_account.my-regional-account.id
  node_service_account_id = yandex_iam_service_account.my-regional-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

resource "yandex_kubernetes_node_group" "k8s_nodes_a" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name       = var.kubernetes_node_group_name_a
  instance_template {
    name       = var.kubernetes_instances_name
    platform_id = var.kubernetes_instances_platform_id
    network_interface {
      nat                = var.kubernetes_instances_network_interface_nat
      subnet_ids         = ["${yandex_vpc_subnet.public_subnet.id}"]
    }
    network_acceleration_type = var.kubernetes_instances_network_acceleration_type
    scheduling_policy {
      preemptible = var.kubernetes_instances_preemptible
    }
    resources {
      memory = var.kubernetes_instances_resources_memory
      cores  = var.kubernetes_instances_resources_cores
      core_fraction = var.kubernetes_instances_resources_core_fraction
    }
    boot_disk {
      type = var.kubernetes_instances_boot_disk_type
      size = var.kubernetes_instances_boot_disk_size
    }
    container_runtime {
      type = var.kubernetes_instances_container_runtime_type
    }
    metadata = {
      serial-port-enable = var.serial-port-enable
      user-data          = data.template_file.cloudinit.rendered
    }
  }
  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public_subnet.zone
    }
  }
  scale_policy {
    auto_scale {
      min     = var.kubernetes_instances_scale_policy_min
      max     = var.kubernetes_instances_scale_policy_max
      initial = var.kubernetes_instances_scale_policy_initial
    }
  }
}

resource "yandex_kubernetes_node_group" "k8s_nodes_b" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name       = var.kubernetes_node_group_name_b
  instance_template {
    name       = var.kubernetes_instances_name
    platform_id = var.kubernetes_instances_platform_id
    network_interface {
      nat                = var.kubernetes_instances_network_interface_nat
      subnet_ids         = ["${yandex_vpc_subnet.public_subnet2.id}"]
    }
    network_acceleration_type = var.kubernetes_instances_network_acceleration_type
    scheduling_policy {
      preemptible = var.kubernetes_instances_preemptible
    }
    resources {
      memory = var.kubernetes_instances_resources_memory
      cores  = var.kubernetes_instances_resources_cores
      core_fraction = var.kubernetes_instances_resources_core_fraction
    }
    boot_disk {
      type = var.kubernetes_instances_boot_disk_type
      size = var.kubernetes_instances_boot_disk_size
    }
    container_runtime {
      type = var.kubernetes_instances_container_runtime_type
    }
    metadata = {
      serial-port-enable = var.serial-port-enable
      user-data          = data.template_file.cloudinit.rendered
    }
  }
  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public_subnet2.zone
    }
  }
  scale_policy {
    auto_scale {
      min     = var.kubernetes_instances_scale_policy_min
      max     = var.kubernetes_instances_scale_policy_max
      initial = var.kubernetes_instances_scale_policy_initial
    }
  }
}

resource "yandex_iam_service_account" "my-regional-account" {
  name        = var.kubernetes_iam_service_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  folder_id = var.folder_id
  role      = var.kubernetes_role_k8s_clusters_agent
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  folder_id = var.folder_id
  role      = var.kubernetes_role_vpc_publicAdmin
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  folder_id = var.folder_id
  role      = var.kubernetes_role_container_registry_images_puller
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  folder_id = var.folder_id
  role      = var.kubernetes_role_kms_keys_encrypterDecrypter
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "loggingWriter" {
  folder_id = var.folder_id
  role      = var.kubernetes_role_logging_writer
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "loadBalancerAdmin" {
  folder_id = var.folder_id
  role      = var.kubernetes_role_load_balancer_admin
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_kms_symmetric_key" "kms-key" {
  name              = var.kubernetes_kms_key_name
  default_algorithm = var.kubernetes_kms_default_algorithm
  rotation_period   = var.kubernetes_kms_rotation_period
}