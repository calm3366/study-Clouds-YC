Ссылка на домашнее задание - [github](https://github.com/netology-code/clopro-homeworks/blob/main/15.3.md)

## «Безопасность в облачных провайдерах»
### Задание 1. Yandex Cloud

#### С помощью ключа в KMS необходимо зашифровать содержимое бакета:

- [backet.tf](terr/backet.tf) 


![!\[Alt text\](<img/!\[Alt text\](<img/1.png>)>)](<img/1.png>)

#### (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

Изначально применяется сертификат от GlobalSign YC на уровне облака: 

![!\[Alt text\](<img/!\[Alt text\](<img/5.png>)>)](<img/5.png>)




При добавлении самоподписного сертификата в раздел Certificate Manager и HTTPS, а также создание домена:

![!\[Alt text\](<img/!\[Alt text\](<img/2.png>)>)](<img/2.png>)

![!\[Alt text\](<img/!\[Alt text\](<img/3.png>)>)](<img/3.png>)

![!\[Alt text\](<img/!\[Alt text\](<img/4.png>)>)](<img/4.png>)


Результат:


