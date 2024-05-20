resource "yandex_mdb_mysql_cluster" "mysql-cluster" {
  name                = var.mysql_cluster_name
  environment         = var.mysql_environment
  network_id          = yandex_vpc_network.network.id
  version             = var.mysql_version
  security_group_ids  = [yandex_vpc_security_group.nat-instance-sg.id]
  deletion_protection = var.mysql_deletion_protection
  
  resources {
    resource_preset_id = var.mysql_resource_preset_id
    disk_type_id       = var.mysql_disk_type_id
    disk_size          = var.mysql_disk_size
  }

  host {
    zone      = var.zone_a
    subnet_id = yandex_vpc_subnet.private_subnet.id
  }

  host {
    zone      = var.zone_b
    subnet_id = yandex_vpc_subnet.private_subnet2.id
  }

  maintenance_window {
    type = var.mysql_maintenance_window_type
  }

  backup_window_start {
    hours   = var.mysql_backup_window_start_hour
    minutes = var.mysql_backup_window_start_minute
  }
  
  backup_retain_period_days = var.mysql_backup_retain_period_days
}

resource "yandex_mdb_mysql_database" "db1" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
  name       = var.mysql_database_name
}
resource "yandex_mdb_mysql_user" "mysql_user" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
  name       = var.mysql_user_name
  password   = var.mysql_user_password
  permission {
    database_name = yandex_mdb_mysql_database.db1.name
    roles         = [var.mysql_user_permission_roles]
  }
}
