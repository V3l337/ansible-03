Этот репозиторий содержит решения для автоматизации с использованием Terraform и Ansible, с дополнительным инвентори файлом для Ansible. (clickhouse, vector и lighthouse)

## 1. Манифест Terraform

В директории `terraform` был создан манифест Terraform для создания инфраструктуры. Манифест описывает ресурсы, которые необходимы для развертывания, установка через count с листами имен машин + был сделан outputs под inventory ansible.

## 2. Ansible-palybook for ClickHouse, Vector, and Lighthouse Setup

Директории `playbook` содержит плейбук Ansible, предназначенный для автоматической установки и настройки следующих сервисов на удаленных хостах: **ClickHouse**, **Vector** и **Lighthouse**.

### 1. Установка и настройка ClickHouse
Плейбук автоматически выполняет следующие шаги для хостов, входящих в группу `clickhouse_group`:
- Скачивает и устанавливает необходимые пакеты ClickHouse с помощью `get_url` и `apt`.
- Настроит и запустит сервис ClickHouse с помощью `systemd`.

### 2. Установка и настройка Vector
Для хостов в группе `vector_group` плейбук:
- Устанавливает зависимость `curl`.
- Скачивает и устанавливает Vector через скрипт.
- Создает директорию для конфигурации Vector и копирует шаблон конфигурации `vector.yaml` из шаблона Jinja2.

### 3. Установка и настройка Lighthouse
На хостах группы `lighthouse_group` выполняются следующие действия:
- Устанавливается Nginx и настраивается веб-сервер.
- Создается директория для веб-контента.
- Скачивается файл `index.html` для Lighthouse.
- Создается и активируется конфигурация для Nginx с использованием шаблона Jinja2.
- Удаляется дефолтная конфигурация Nginx и перезапускается сервис.

### 4. Обработчики
- Для всех сервисов предусмотрены обработчики, которые обеспечивают запуск или перезапуск сервисов:
  - Перезапуск Nginx.
  - Перезапуск Vector.
  - Перезапуск ClickHouse.
- Создание базы данных `logs` в ClickHouse для хранения логов.

### 5. Инвентори файл
Инвентори файл содержит информацию о хостах для каждой из групп (`clickhouse_group`, `vector_group`, `lighthouse_group`). Плейбук автоматически настроит нужные ресурсы на каждом хосте, в зависимости от его роли в инфраструктуре.

## Структура репозитория

- `group_vars/vars.yml`: переменные, используемые в плейбуке.
- `templates/vector_conf.j2`: шаблон конфигурации для Vector.
- `templates/lighthouse_nginx_conf.j2`: шаблон конфигурации для Nginx с Lighthouse.
- `playbook.yml`: основной Ansible playbook для выполнения задач.


Проверки по заданиям:

![ansible-playbook -i inventory yml playbook yml --check](https://github.com/user-attachments/assets/ed02c309-1be1-4db5-9ede-2ad132f574e0)


![ansible-playbook -i inventory yml playbook yml --diff](https://github.com/user-attachments/assets/48eec759-0db0-4fc5-9987-fc59e11bd5f0)


![ansible-playbook -i inventory yml playbook yml --diff повторный](https://github.com/user-attachments/assets/99a369fb-4c05-4b67-81a1-d57f35af2ce5)
