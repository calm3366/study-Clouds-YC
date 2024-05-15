resource "yandex_iam_service_account" "sa" {
  name = "backet-editor"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "my-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "arihin-netology"

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }

  //шифрование ключом kms
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  //добавление сертификата для https
  # https {
  #   certificate_id = "<идентификатор_сертификата>"
  # }
}

resource "yandex_storage_object" "some-picture" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "arihin-netology"
  key        = "keep-calm.png"
  source     = "../keep-calm.png"
}

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // 1 год
}