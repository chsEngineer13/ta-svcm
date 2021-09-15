SVCM
====

Сервис обработки метаданных

Установка и запуск
------------------

### WEB-сервер

Для запуска svcm необходимо установить web-сервер поддерживающий технологию Java Servlet.
В качестве такого сервера предлагается использовать [Apache Tomcat](http://tomcat.apache.org).
Для запуска svcm достаточно версии Tomcat 7.

Порядок установки:
1. Скачиваем с официальной страницы, устанавливаем и запускаем Tomcat.
1. Подключамся к домашней странице. По-умолчанию: http://ip-сервера:8080.
1. Заходим в AppManager (пользователь по-умолчанию admin/admin).
1. Находим секцию Deploy. Выбираем svcm.war на диске. Размещаем сервис кнопкой Deploy.

### Настройка приложения

1. Настроить подключение к БД в `WEB-INF\classes\hibernate.cfg.xml`.
1. Убрать комментарии для Cors Plugin в `WEB-INF\web.xml`. 
