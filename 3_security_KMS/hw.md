## «Безопасность в облачных провайдерах»
### Задание 1. Yandex Cloud

#### С помощью ключа в KMS необходимо зашифровать содержимое бакета:

- [backet.tf](terr/backet.tf) 


![!\[Alt text\](<img/!\[Alt text\](<img/1.png>)>)](<img/1.png>)

#### (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:



![!\[Alt text\](<img/!\[Alt text\](<img/5.png>)>)](<img/5.png>)


Т.е. применяется сертификат от GlobalSign на уровне облака. При добавлении самоподписного сертификата в раздел https ошибка:

![!\[Alt text\](<img/!\[Alt text\](<img/2.png>)>)](<img/2.png>)

генерирую сертификаты так 


`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout server-key.pem -out server.pem -subj "/CN=arihin-netology.website.yandexcloud.net/O=arihin-netology.website.yandexcloud.net" `

или

`openssl req -x509 -newkey rsa:4096 -nodes \
  -keyout key.pem \
  -out cert.pem \
  -days 365 \
  -subj '/CN=arihin-netology.website.yandexcloud.net' `


![!\[Alt text\](<img/!\[Alt text\](<img/4.png>)>)](<img/4.png>)


описание ошибки:

```
{
  "traceId": "a7bca8a267f6a2b8",
  "requestId": "234570cb-0300-4837-914c-fe65093705a2",
  "status": 400,
  "message": "{\"self_managed\":\"validating certificates: certificate is not valid for any names, but wanted to match arihin-07-05-04\"}",
  "code": "GATEWAY_REQUEST_ERROR",
  "title": "Ошибка",
  "description": "{\"self_managed\":\"validating certificates: certificate is not valid for any names, but wanted to match arihin-07-05-04\"}",
  "details": {
    "grpcCode": 3
  }
}
```
