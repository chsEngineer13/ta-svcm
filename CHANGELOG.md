# Change_log

## 2019-02-01

### Изменения БД
Добавленo: `CREATE MATERIALIZED VIEW core.summary_construction`
Включено в create.sql

## 2019-01-31

### Изменения БД
Добавлена схема `stream`.

## 2019-01-21

### Изменения БД
Создана схема `sys`
В нее перенесены таблицы `acl*`
Переименованы таблицы:
1. object -> cobject
1. object_type -> cobject_type

Изменено в таблице `cobject`:
1. id -> bigserial
1. type -> cobject_type_id

Во всех таблицах изменены внешние ключи на таблицу `cobject` (тип и наименование)

## 2019-01-17

### Создание схемы
В БД создана схема `core`
В нее перенесены все таблицы из `\svcm\sql\create\core`

### Переименование таблиц
Изменено наименований таблиц справочников в базе данных, в именах файлов, в скриптах загрузки и т.д.
Для таблиц (см. ниже) проведено переименование и внесены изменения в:
1. в файле запуска скрипта \svcm\sql\create\run.json
1. в имени файла создания таблицы "\svcm\sql\create\core\*.sql

Список таблиц:
1. constrpart_group -> ref_constrpart_group
1. constrpart_ref -> ref_constrpart
1. building_group -> ref_building_group
1. building_ref -> ref_building
1. object_type -> ref_object_type
1. phase -> ref_phase
1. developer -> ref_developer
1. contractor -> ref_contractor
1. doccode_ref -> ref_doccode
1. mark_ref -> ref_mark
1. chaptercode_type -> ref_chaptercode_type
1. chaptercode_ref -> ref_chaptercode
1. project -> contract

### Изменение FK
В скритпы создания таблиц внесено имя схемы, изменены наименования таблиц и дополнены именем схемы в ссылках внешних ключей для всех таблиц `\svcm\sql\create\`

### Базовые функции
Скорректированы наименования базовых функций для всех таблиц БД.
