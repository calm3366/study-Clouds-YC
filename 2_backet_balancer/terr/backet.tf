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
  bucket     = "arihin-07-05-04"
}

resource "yandex_storage_object" "some-picture" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "arihin-07-05-04"
  key        = "keep-calm.png"
  source     = "../keep-calm.png"
}

# Получение публичной ссылки на картинку (НЕ РАБОТАЕТ)
# data "yandex_storage_object_signature" "some-picture" {
#   bucket = yandex_storage_bucket.my-bucket.id
#   key    = yandex_storage_object.some-picture.key
#   expires_in = 3600 # Срок действия ссылки в секундах
# }