# saurshi_infra
saurshi Infra repository

### Используем Bastion host для сквозного подключения

* Проверяем подключение через проброс ключа на bastiomhost:
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
ssh -i ~/.ssh/id_ed25519 -A appuser@178.154.223.228 ssh appuser@10.128.0.22
```
* ... и получаем "неадекватную" сессию...

* Гораздо лучше подключение через jamp-сервер или узел бастион:
```
ssh -i ~/.ssh/id_ed25519 -J appuser@178.154.223.228 appuser@10.128.0.22
```
* Получили полноценную ssh-сессию.

###
Создание alias`ов для подключения:

1. Добавлением в .bashrc (.bash_aliases, .alias): 

```
alias ssh-sinthost="ssh -i ~/.ssh/id_ed25519 -J appuser@178.154.223.228 appuser@10.128.0.22"
```

2. Лучший вариант - добавлением секции в ~/.ssh/config:

```
Host someinternalhost
	HostName someinternalhost
	#HostName 10.128.0.22
	User appuser
	ProxyCommand ssh -W %h:%p appuser@178.154.223.228
```
* Подключаемся:
```
$ ssh someinternalhost
```
* All Ok)
