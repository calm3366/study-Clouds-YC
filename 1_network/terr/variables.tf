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



variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
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

variable "default_cidr_private" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
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

variable "private_subnet_name" {
  type        = string
  default     = "private"
  description = "subnet name"
}


variable "NAT_instance_ID" {
  type    = string
  default = "fd8e09l2blguqbdk5eej"
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
}

variable "serial-port-enable" {
  default = "0"
}

