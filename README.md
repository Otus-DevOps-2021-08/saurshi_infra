# saurshi_infra
saurshi Infra repository

## Практика
### Задание №3
**Используем Bastion host для сквозного подключения**

* Проверяем подключение через проброс ключа на bastionhost:
```
$ ssh -i ~/.ssh/appuser -A appuser@178.154.221.153
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-42-generic x86_64)
```
```
appuser@bastion:~$ ssh appuser@someinternalhost
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-42-generic x86_64)
...

Last login: Mon Sep 20 10:51:02 2021 from 10.128.0.13
```
```
appuser@someinternalhost:~$ hostname
someinternalhost
```
* все Ок!

* Подключаемся однострочной командой:
```
ssh -i ~/.ssh/appuser -A appuser@178.154.253.62 ssh appuser@10.128.0.17
```
* ... и получаем "неадекватную" сессию...

* Гораздо лучше подключение через jamp-сервер или узел бастион:
```
ssh -i ~/.ssh/appuser -J appuser@178.154.253.62 appuser@10.128.0.17
```
* Получили полноценную ssh-сессию.

###
Создание alias`ов для подключения:

1. Добавлением в .bashrc (.bash_aliases, .alias): 

```
alias ssh-sinthost="ssh -i ~/.ssh/appuser -J appuser@178.154.253.62 appuser@10.128.0.17"
```

2. Лучший вариант - добавлением секции в ~/.ssh/config:

```
Host someinternalhost
	HostName someinternalhost
	#HostName 10.128.0.17
	User appuser
	ProxyCommand ssh -W %h:%p appuser@178.154.253.62
```
* Подключаемся:
```
$ ssh someinternalhost
```
* All Ok)

### Создаем VPN-сервер для серверовYandex.CloudYandex.

* Устанавливаем и запускаем prituln & mongodb с помощью скрипта (setupvpn.sh)
* Далее конфигурируем наш VPN-сервер через веб интерфейс, добавляя организацию, пользователей и пароли.
* Сохраняем конфиг cloud-bastion.ovpn для подключения локальной машины к vpn-серверу.
* Проверяем, что соединения осуществляются по внутренней сетке, и нам доступны сервера без публичных IP.

 Конфигурация подключения (cloud-bastion.ovpn):
 ```
 Шлюз: 178.154.253.62
 Тип соединения: Пароль и сертификаты (TLS)
 Имя пользователя: test
 ...
 Нестандартный порт шлюза: 10698
 Шифрование: AES-128-CBC
 ```
 * Данные для подключения к серверам CloudYandex:

 ```
 bastion_IP = 178.154.253.62
 someinternalhost_IP = 10.128.0.17

 ```
### Задание №4
**Практика управления ресурсами yandex cloud через YC**

* Создаем инстанс в Yandex.Cloud с уже запущенным приложением, с помощью CLI, запустив скрипт:

```
$ ./startup.sh

```
* Данные для подключения к серверам CloudYandex:

```
testapp_IP = 62.84.113.81
testapp_port = 9292

```
### Задание №5
**Подготовка базового образа VM при помощи Packer.**

#### В процессе сделано:
* Установлен Packer.
* Создан service account & key file.
* Создан файла-шаблона Packer - packer/ubuntu16.json.
* Собран baked-образ с установленными MongoDB, Ruby - reddit-base.
* Протестирован образ в качестве загрузочного при создании ВМ.
* Параметризирован шаблон.
* Собран baked-образ reddit-full шаблоном immutable.json.
* Образ проверен созданным скриптом:
  ```./create-reddit-vm.sh```
#### Как проверить:
**Проверить работоспособность сервера puma можно по ссылке:**
  [http://62.84.119.210:9292/](http://62.84.119.210:9292/)

**Собрать baked-образ:
```cd packer && packer build -var-file=variables.json immutable.json```

**Создать ВМ с помощью Yandex.Cloud CLI можно, запустив скрипт**
```cd scripts && ./create-reddit-vm.sh```

### Задание №6
**Декларативное описание в виде кода инфраструктуры YC, требуемой для запуска тестового приложения, при помощи Terraform.**

#### В процессе сделано:
1. Определена input переменная для приватного ключа, для провижинеров.
2. Определена input переменная для для задания зоны.
3. Отформатированы все конфигурационные файлы используя команду terraform fmt.
4. Создан  terraform.tfvars.example

#### Как проверить:
**Проверить работоспособность сервера можно по ссылке:**
[http://62.84.118.21:9292/](http://62.84.118.21:9292/)

**Создать ВМ с помощью Terraform**
``` cd terraform && terraform apply ```

