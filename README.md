# saurshi_infra
saurshi Infra repository

### Используем Bastion host для сквозного подключения

* Проверяем подключение через проброс ключа на bastiomhost:
```
$ ssh -i ~/.ssh/appuser -A appuser@178.154.253.62
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
