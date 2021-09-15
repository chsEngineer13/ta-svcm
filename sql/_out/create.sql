-- Кодировка по-умолчанию
SET client_encoding = 'UTF8';

-- Права на схему public
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA public GRANT SELECT, USAGE ON SEQUENCES TO svcm;

-- Схема core
CREATE SCHEMA IF NOT EXISTS core AUTHORIZATION svcm;
COMMENT ON SCHEMA core IS 'Основные бизнес-объекты системы';
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA core GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA core GRANT SELECT, USAGE ON SEQUENCES TO svcm;

-- Схема sys
CREATE SCHEMA IF NOT EXISTS sys AUTHORIZATION svcm;
COMMENT ON SCHEMA sys IS 'Хранение данных о пользователях, ролях, функциях сервиса, правах доступа, а так же логи работы пользователя';
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA sys GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA sys GRANT SELECT, USAGE ON SEQUENCES TO svcm;

-- Схема stream
CREATE SCHEMA IF NOT EXISTS stream AUTHORIZATION svcm;
COMMENT ON SCHEMA stream IS 'Организация распределенного обмена данными и интеграцией';
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA stream GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO svcm;
ALTER DEFAULT PRIVILEGES FOR ROLE svcm IN SCHEMA stream GRANT SELECT, USAGE ON SEQUENCES TO svcm;

-- Создание доменов
CREATE DOMAIN core.d_description AS text NULL;
COMMENT ON DOMAIN core.d_description IS 'Тип поля - описаниe';

-- Функции доступа
CREATE TABLE sys.acl_function (
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(32) NOT NULL UNIQUE,
    descr        VARCHAR(512)
); 

COMMENT ON TABLE sys.acl_function IS 'Функции доступа';

COMMENT ON COLUMN sys.acl_function.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_function.name IS 'Наименование';
COMMENT ON COLUMN sys.acl_function.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('sys.AclFunctions.c', 'Создание функции'),
    ('sys.AclFunctions.r', 'Чтение функций'),
    ('sys.AclFunctions.u', 'Изменение функции'),
    ('sys.AclFunctions.d', 'Удаление функции'),
    ('sys.AclFunctions.l', 'Создание/удаление записи в связанной таблице');

-- Пользователи системы
CREATE TABLE sys.acl_account (
    id           SERIAL PRIMARY KEY,
    login        VARCHAR(32) NOT NULL UNIQUE,
    pwd          VARCHAR(64),
    salt         VARCHAR(64),
    firstname    VARCHAR(128),
    middlename   VARCHAR(128),
    lastname     VARCHAR(128),
    tabnum       VARCHAR(32),
    email        VARCHAR(128) NOT NULL UNIQUE,
    is_active    BOOLEAN DEFAULT TRUE NOT NULL
); 

COMMENT ON TABLE sys.acl_account IS 'Пользователи';

COMMENT ON COLUMN sys.acl_account.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_account.login IS 'Логин';
COMMENT ON COLUMN sys.acl_account.pwd IS 'Пароль';
COMMENT ON COLUMN sys.acl_account.salt IS 'Соль';
COMMENT ON COLUMN sys.acl_account.firstname IS 'Имя';
COMMENT ON COLUMN sys.acl_account.middlename IS 'Отчество';
COMMENT ON COLUMN sys.acl_account.lastname IS 'Фамилия';
COMMENT ON COLUMN sys.acl_account.tabnum IS 'Табельный номер';
COMMENT ON COLUMN sys.acl_account.email IS 'E-mail';
COMMENT ON COLUMN sys.acl_account.is_active IS 'Статус активности';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('sys.AclAccounts.c', 'Создание пользователя'),
    ('sys.AclAccounts.r', 'Чтение пользователей'),
    ('sys.AclAccounts.u', 'Изменение пользователя'),
    ('sys.AclAccounts.d', 'Удаление пользователя'),
    ('sys.AclAccounts.l', 'Создание/удаление записи в связанной таблице');

INSERT INTO sys.acl_account(login, firstname, lastname, email) VALUES ('admin', 'administrator', 'adm', 'sec-sd-setd@gazpromproject.ru');

-- Роли доступа
CREATE TABLE sys.acl_role (
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(256) NOT NULL,
    descr        VARCHAR(1024)
); 

COMMENT ON TABLE sys.acl_role IS 'Роли доступа';

COMMENT ON COLUMN sys.acl_role.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_role.name IS 'Наименование';
COMMENT ON COLUMN sys.acl_role.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('sys.AclRoles.c', 'Создание роли'),
    ('sys.AclRoles.r', 'Чтение ролей'),
    ('sys.AclRoles.u', 'Изменение роли'),
    ('sys.AclRoles.d', 'Удаление роли'),
    ('sys.AclRoles.l', 'Создание/удаление записи в связанной таблице');

INSERT INTO sys.acl_role(name, descr) VALUES
    ('Super', 'СуперАдминистратор')
    ,('User', 'Пользователь')
;

-- Группы пользователей
CREATE TABLE sys.acl_group (
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(256) NOT NULL,
    descr        VARCHAR(1024)
); 

COMMENT ON TABLE sys.acl_group IS 'Группы пользователей';

COMMENT ON COLUMN sys.acl_group.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_group.name IS 'Наименование';
COMMENT ON COLUMN sys.acl_group.descr IS 'Идентификатор';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('sys.AclGroups.c', 'Создание группы'),
    ('sys.AclGroups.r', 'Чтение групп'),
    ('sys.AclGroups.u', 'Изменение группы'),
    ('sys.AclGroups.d', 'Удаление группы');

-- Таблица присвоения ролей пользователю
CREATE TABLE sys.acl_account_role (
  id          BIGSERIAL PRIMARY KEY,
  account_id  INTEGER NOT NULL REFERENCES sys.acl_account(id),
  role_id     INTEGER NOT NULL REFERENCES sys.acl_role(id),
  CONSTRAINT acl_account_role_ar_key UNIQUE(account_id, role_id)
);

COMMENT ON TABLE sys.acl_account_role IS 'acl_account <-> acl_role';

COMMENT ON COLUMN sys.acl_account_role.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_account_role.account_id IS '-> acl_account';
COMMENT ON COLUMN sys.acl_account_role.role_id IS '-> acl_role';

-- Таблица присвоения функций ролям
CREATE TABLE sys.acl_role_function (
  id            BIGSERIAL PRIMARY KEY,
  role_id       INTEGER NOT NULL REFERENCES sys.acl_role(id),
  function_id   INTEGER NOT NULL REFERENCES sys.acl_function(id),
  CONSTRAINT acl_role_function_rf_key UNIQUE(role_id, function_id)
);

COMMENT ON TABLE sys.acl_role_function IS 'acl_role <-> acl_function';

COMMENT ON COLUMN sys.acl_role_function.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_role_function.role_id IS '-> acl_role';
COMMENT ON COLUMN sys.acl_role_function.function_id IS '-> acl_function';

-- Типы событий для аудита
CREATE TABLE sys.ref_logeventtype (
  id SERIAL PRIMARY KEY,
  name VARCHAR(10) NOT NULL UNIQUE,
  descr core.d_description
);

COMMENT ON TABLE sys.ref_logeventtype IS 'Типы событий для аудита';

COMMENT ON COLUMN sys.ref_logeventtype.id IS 'Идентификатор';
COMMENT ON COLUMN sys.ref_logeventtype.name IS 'Наименование действия';
COMMENT ON COLUMN sys.ref_logeventtype.descr IS 'Описание';

INSERT INTO sys.ref_logeventtype(name, descr) VALUES
    ('c', 'Создание')
    ,('r', 'Чтение')
    ,('u', 'Изменение')
    ,('d', 'Удаление')
    ,('p', 'Генерация отчета')
    ,('e', 'Запуск процедуры')
    ,('a', 'Аутентификация пользователя')
    ,('h', 'Проверка прав доступа')
    ,('l', 'Создание связи для таблиц')
;

-- Аудит действий пользователя
CREATE TABLE sys.logevent (
  id BIGSERIAL PRIMARY KEY,
  account_id INTEGER NOT NULL REFERENCES sys.acl_account(id),
  eventtype_id INTEGER NOT NULL REFERENCES sys.ref_logeventtype(id),
  eventtime TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  schema_name VARCHAR(25),
  operation_name VARCHAR(250) NOT NULL,
  operation_pk_id BIGINT,
  operation_pk_time TIMESTAMP WITH TIME ZONE,
  details JSON,
  descr core.d_description
);

COMMENT ON TABLE sys.logevent IS 'Аудит действий пользователя';

COMMENT ON COLUMN sys.logevent.id IS 'Идентификатор';
COMMENT ON COLUMN sys.logevent.account_id IS '-> acl_account';
COMMENT ON COLUMN sys.logevent.eventtype_id IS '-> ref_logeventtype';
COMMENT ON COLUMN sys.logevent.eventtime IS 'Дата и время события';
COMMENT ON COLUMN sys.logevent.schema_name IS 'Имя схемы БД для операции';
COMMENT ON COLUMN sys.logevent.operation_name IS 'Имя операции - логируемая таблица/отчет/функция и т.д.';
COMMENT ON COLUMN sys.logevent.operation_pk_id IS 'Id первичного ключа логируемой таблицы';
COMMENT ON COLUMN sys.logevent.operation_pk_time IS 'Дата и время первичного ключа логируемой таблицы';
COMMENT ON COLUMN sys.logevent.details IS 'Детализация данных операции';
COMMENT ON COLUMN sys.logevent.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('sys.LogEvents.r', 'Чтение записей аудита');

-- Комплексы
CREATE TABLE core.construction (
    id      smallserial PRIMARY KEY,
    code    varchar(16) NOT NULL,
    name    varchar(8192)
);

COMMENT ON TABLE core.construction IS 'Комплексы';

COMMENT ON COLUMN core.construction.id IS 'Идентификатор';
COMMENT ON COLUMN core.construction.code IS 'Код комплекса';
COMMENT ON COLUMN core.construction.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.Constructions.c', 'Создание комплекса'),
    ('core.Constructions.r', 'Чтение комплексов'),
    ('core.Constructions.u', 'Изменение комплекса'),
    ('core.Constructions.d', 'Удаление комплекса');

-- Классификатор групп частей комплексов строек 
CREATE TABLE core.ref_constrpart_group (
    id		  serial PRIMARY KEY,		-- ИД
    code_range    varchar(32),			-- диапазон кодов
    name	  varchar(512) NOT NULL		-- наименование группы частей комплексов строек
);

COMMENT ON TABLE core.ref_constrpart_group IS 'Классификатор групп частей комплексов строек';

COMMENT ON COLUMN core.ref_constrpart_group.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_constrpart_group.code_range IS 'Диапазон кодов';
COMMENT ON COLUMN core.ref_constrpart_group.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES 
     ('core.RefConstrPartGroups.c', 'Создание классификатора групп частей комплексов строек'),
     ('core.RefConstrPartGroups.r', 'Чтение классификаторов групп частей комплексов строек'),
     ('core.RefConstrPartGroups.u', 'Изменение классификатора групп частей комплексов строек'),
     ('core.RefConstrPartGroups.d', 'Удаление классификатора групп частей комплексов строек'),
     ('core.RefConstrPartGroups.l', 'Создание/удаление записи в связанной таблице');

-- Классификатор частей коплексов строек
CREATE TABLE core.ref_constrpart (
    id		serial PRIMARY KEY,
    group_id	int REFERENCES core.ref_constrpart_group (id),
    code	varchar(8) NOT NULL,
    name	varchar(512) NOT NULL
);

COMMENT ON TABLE core.ref_constrpart IS 'Классификатор частей комплексов строек';

COMMENT ON COLUMN core.ref_constrpart.id IS 'Индентификатр';
COMMENT ON COLUMN core.ref_constrpart.group_id IS '-> constrpart_group';
COMMENT ON COLUMN core.ref_constrpart.code IS 'Код';
COMMENT ON COLUMN core.ref_constrpart.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefConstrParts.c', 'Создание классификатора частей комплексов строек'),
    ('core.RefConstrParts.r', 'Чтение классификаторов частей комплексов строек'),
    ('core.RefConstrParts.u', 'Изменение классификатора частей комплексов строек'),
    ('core.RefConstrParts.d', 'Удаление классификатора частей коплексов строек'),
    ('core.RefConstrParts.l', 'Создание/удаление записи в связанной таблице');

-- Классификатор групп зданий, сооружений, систем и установок
CREATE TABLE core.ref_building_group (
    id            serial PRIMARY KEY,
    parent_id     int,
    code_range    varchar(32),
    name	  varchar(512) NOT NULL
);

COMMENT ON TABLE core.ref_building_group IS 'Классификатор групп зданий, сооружений, систем и установок';

COMMENT ON COLUMN core.ref_building_group.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_building_group.parent_id IS 'Ccылка на группу-родитель';
COMMENT ON COLUMN core.ref_building_group.code_range IS 'Диапазон кодов';
COMMENT ON COLUMN core.ref_building_group.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefBuildingGroups.c', 'Создание классификатора частей комплексов строек'),
    ('core.RefBuildingGroups.r', 'Чтение классификаторов частей комплексов строек '),
    ('core.RefBuildingGroups.u', 'Изменение классификатора частей комплексов строек'),
    ('core.RefBuildingGroups.d', 'Удаление классификатора частей коплексов строек');

-- Классификатор зданий, сооружений, систем и установок  
CREATE TABLE core.ref_building (
    id		serial PRIMARY KEY,
    group_id	int REFERENCES core.ref_building_group (id),
    code	varchar(8) NOT NULL,
    name	varchar(512) NOT NULL
);

COMMENT ON TABLE core.ref_building IS 'Классификатор зданий, сооружений, систем и установок';

COMMENT ON COLUMN core.ref_building.id IS 'Индентификатр';
COMMENT ON COLUMN core.ref_building.group_id IS '-> building_group';
COMMENT ON COLUMN core.ref_building.code IS 'Код';
COMMENT ON COLUMN core.ref_building.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES 
     ('core.RefBuildings.c', 'Создание классификатора зданий, сооружений, систем и установок'),
     ('core.RefBuildings.r', 'Чтение классификаторов зданий, сооружений, систем и установок'),
     ('core.RefBuildings.u', 'Изменение классификатора зданий, сооружений, систем и установок'),
     ('core.RefBuildings.d', 'Удаление классификатора зданий, сооружений, систем и установок');

-- Тип объектов проектирования
CREATE TABLE core.cobject_type (
    id		smallserial PRIMARY KEY,
	code	varchar(1),
    name	varchar(16),
    descr	varchar(32)
);

COMMENT ON TABLE core.cobject_type IS 'Типы объектов проектирования';

COMMENT ON COLUMN core.cobject_type.id IS 'Идентификатор';
COMMENT ON COLUMN core.cobject_type.code IS 'Код';
COMMENT ON COLUMN core.cobject_type.name IS 'Наименование';
COMMENT ON COLUMN core.cobject_type.descr IS 'Описание';

INSERT INTO core.cobject_type(code, name, descr) VALUES
    ('C', 'CONSTR',      'Комплекс'),
    ('P', 'CONSTR_PART', 'Часть комплекса'),
    ('B', 'BUILDING',    'Здание/сооружение'),
    ('M', 'MARK',        'Марка'),
    ('F', 'FOLDER',      'Папка');

-- Объекты проектирования
CREATE TABLE core.cobject (
    id                 bigserial PRIMARY KEY,
    parent_id 	       bigint REFERENCES core.cobject (id),
    construction_id    smallint REFERENCES core.construction (id),
    cobject_type_id    smallint NOT NULL REFERENCES core.cobject_type (id),
    code 	       varchar(32),
    number 	       varchar(32),
    descr 	       varchar(8192)
);

COMMENT ON TABLE core.cobject IS 'Объекты проектирования';

COMMENT ON COLUMN core.cobject.id IS 'Индентификатр';
COMMENT ON COLUMN core.cobject.parent_id IS '-> object';
COMMENT ON COLUMN core.cobject.construction_id IS '-> construction';
COMMENT ON COLUMN core.cobject.cobject_type_id IS '-> object_type';
COMMENT ON COLUMN core.cobject.code IS 'Код объекта';
COMMENT ON COLUMN core.cobject.number IS 'Номер объекта';
COMMENT ON COLUMN core.cobject.descr IS 'Описание/наименование';

INSERT INTO sys.acl_function(name, descr) VALUES 
     ('core.CObjects.c', 'Создание объектов проектирования'),
     ('core.CObjects.r', 'Чтение объектов проектирования'),
     ('core.CObjects.u', 'Изменение объектов проектирования'),
     ('core.CObjects.d', 'Удаление объектов проектирования'),
     ('core.CObjects.l', 'Создание/удаление записи в связанной таблице')
;

-- Стадии проектирования
CREATE TABLE core.ref_phase (
    id      smallserial PRIMARY KEY,
    code    varchar(16) NOT NULL,
    name    varchar(128)
);

COMMENT ON TABLE core.ref_phase IS 'Стадии проектирования';

COMMENT ON COLUMN core.ref_phase.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_phase.code IS 'Буквенный код';
COMMENT ON COLUMN core.ref_phase.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefPhases.c', 'Создание классификатора стадий проектирования'),
    ('core.RefPhases.r', 'Чтение классификаторов стадий проектирования'),
    ('core.RefPhases.u', 'Изменение классификатора стадий проектирования'),
    ('core.RefPhases.d', 'Удаление классификатора стадий проектирования');

-- Субъекты разработики (документации)
CREATE TABLE core.ref_developer (
    id 	    serial PRIMARY KEY,
    code    varchar(16) NOT NULL,
    name    varchar(256),
    short_name varchar(16)
);

COMMENT ON TABLE core.ref_developer IS 'Субъекты разработки';

COMMENT ON COLUMN core.ref_developer.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_developer.code IS 'Код';
COMMENT ON COLUMN core.ref_developer.name IS 'Наименование';
COMMENT ON COLUMN core.ref_developer.short_name IS 'Сокращенное наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefDevelopers.c', 'Создание субъекта разработки'),
    ('core.RefDevelopers.r', 'Чтение субъектов разработки'),
    ('core.RefDevelopers.u', 'Изменение субъекта разработки'),
    ('core.RefDevelopers.d', 'Удаление субъекта разработки');

-- Контрагенты
CREATE TABLE core.ref_contractor (
    id               serial PRIMARY KEY,
    name	     varchar(256) NOT NULL,
    customer_code    varchar(16)
);

COMMENT ON TABLE core.ref_contractor IS 'Контрагенты';

COMMENT ON COLUMN core.ref_contractor.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_contractor.name IS 'Наименование';
COMMENT ON COLUMN core.ref_contractor.customer_code IS 'Код заказчика';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefContractors.c', 'Создание контрагента'),
    ('core.RefContractors.r', 'Чтение контрагентов'),
    ('core.RefContractors.u', 'Изменение контрагента'),
    ('core.RefContractors.d', 'Удаление контрагента');

-- Договор
CREATE TABLE core.contract (
    id              SERIAL PRIMARY KEY,
    construction_id SMALLINT REFERENCES core.construction(id),
    oipks           VARCHAR(16),
    contractor_id   INT REFERENCES core.ref_contractor(id),
    developer_id    INT REFERENCES core.ref_developer(id),
    inner_num       VARCHAR(128),
    contract_num    VARCHAR(128) NOT NULL,
    title           VARCHAR(8192) NOT NULL,
    contract_date   DATE,
    contract_status VARCHAR(32),
    techdirector    VARCHAR(32),
    gip             VARCHAR(128),
    date_sign       DATE,
    work_start      DATE,
    work_finish     DATE,
    order_start     DATE,
    order_finish    DATE,
    work_types      VARCHAR(32)
);

COMMENT ON TABLE core.contract IS 'Договор';

COMMENT ON COLUMN core.contract.id IS 'Идентификатор';
COMMENT ON COLUMN core.contract.construction_id IS '-> construction';
COMMENT ON COLUMN core.contract.oipks IS 'Код ОИП КС';
COMMENT ON COLUMN core.contract.contractor_id IS '-> ref_contractor';
COMMENT ON COLUMN core.contract.developer_id IS '-> ref_developer';
COMMENT ON COLUMN core.contract.inner_num IS 'Внутренний номер договора';
COMMENT ON COLUMN core.contract.contract_num IS 'Номер договора';
COMMENT ON COLUMN core.contract.title IS 'Предмет договора';
COMMENT ON COLUMN core.contract.contract_date IS 'Дата договора';
COMMENT ON COLUMN core.contract.contract_status IS 'Статус договора';
COMMENT ON COLUMN core.contract.techdirector IS 'Технический директор';
COMMENT ON COLUMN core.contract.gip IS 'ГИПы по договору';
COMMENT ON COLUMN core.contract.date_sign IS 'Дата заключения договора';
COMMENT ON COLUMN core.contract.work_start IS 'Начало работ по договору';
COMMENT ON COLUMN core.contract.work_finish IS 'Окончание работ по договору';
COMMENT ON COLUMN core.contract.order_start IS 'Начало работ по приказу';
COMMENT ON COLUMN core.contract.order_finish IS 'Окончание работ по приказу';
COMMENT ON COLUMN core.contract.work_types IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
     ('core.Contracts.c', 'Создание договора')
    ,('core.Contracts.r', 'Чтение договоров')
    ,('core.Contracts.u', 'Изменение договора')
    ,('core.Contracts.d', 'Удаление договора')
    ,('core.Contracts.l', 'Создание/удаление записи в связанной таблице')
;

-- Классификатор шифров прилагаемых документов
CREATE TABLE core.ref_doccode (
    id              serial PRIMARY KEY,
    code            varchar(16) NOT NULL,
    name            varchar(256),
    additional      BOOLEAN DEFAULT FALSE NOT NULL,
    numeric_part    BOOLEAN DEFAULT FALSE NOT NULL
);

COMMENT ON TABLE core.ref_doccode IS 'Классификатор шифров прилагаемых документов';

COMMENT ON COLUMN core.ref_doccode.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_doccode.code IS 'Шифр';
COMMENT ON COLUMN core.ref_doccode.name IS 'Наименование';
COMMENT ON COLUMN core.ref_doccode.additional IS 'Являтся дополнительным';
COMMENT ON COLUMN core.ref_doccode.numeric_part IS 'Может подразделяться на номерные группы';

INSERT INTO sys.acl_function(name, descr) VALUES 
    ('core.RefDocCodes.c', 'Создание классификатора шифров прилагаемых документов'),
    ('core.RefDocCodes.r', 'Чтение классификаторов шифров прилагаемых документов'),
    ('core.RefDocCodes.u', 'Изменение классификатора шифров прилагаемых документов'),
    ('core.RefDocCodes.d', 'Удаление классификатора шифров прилагаемых документов');

-- Классификатор марок основных комплектов рабочих чертежей
CREATE TABLE core.ref_mark (
    id            serial PRIMARY KEY,
    code          varchar(16) NOT NULL,
    name          varchar(2048),
    comment       varchar(2048),
    additional    BOOLEAN DEFAULT FALSE NOT NULL
);

COMMENT ON TABLE core.ref_mark IS 'Классификатор марок основных комплектов рабочих чертежей';

COMMENT ON COLUMN core.ref_mark.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_mark.code IS 'Шифр';
COMMENT ON COLUMN core.ref_mark.name IS 'Наименование';
COMMENT ON COLUMN core.ref_mark.comment IS 'Примечание';
COMMENT ON COLUMN core.ref_mark.additional IS 'Являтся дополнительным';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefMarks.c', 'Создание классификатора марок комплектов рабочих чертежей'),
    ('core.RefMarks.r', 'Чтение классификаторов марок комплектов рабочих чертежей'),
    ('core.RefMarks.u', 'Изменение классификатора марок комплектов рабочих чертежей'),
    ('core.RefMarks.d', 'Удаление классификатора марок комплектов рабочих чертежей'),
	('core.RefMarks.l', 'Создание/удаление записи в связанной таблице')
;

-- Виды разделов проектной документации
CREATE TABLE core.ref_chaptercode_type (
    id            smallserial PRIMARY KEY,
    short_name    varchar(8) NOT NULL,
    name	  varchar(256) NOT NULL
);

COMMENT ON TABLE core.ref_chaptercode_type IS 'Виды разделов ПД';

COMMENT ON COLUMN core.ref_chaptercode_type.id IS 'Индентификатр';
COMMENT ON COLUMN core.ref_chaptercode_type.short_name IS 'Обозначение';
COMMENT ON COLUMN core.ref_chaptercode_type.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefChapterCodeTypes.c', 'Создание классификатора видов разделов ПД'),
    ('core.RefChapterCodeTypes.r', 'Чтение классификаторов видов разделов ПД'),
    ('core.RefChapterCodeTypes.u', 'Изменение классификатора видов разделов ПД'),
    ('core.RefChapterCodeTypes.d', 'Удаление классификатора видов разделов ПД');

--  Разделы проектной документации
CREATE TABLE core.ref_chaptercode (
    id                    serial PRIMARY KEY,
    chaptercodetype_id    smallint REFERENCES core.ref_chaptercode_type (id),
    chapter               smallint,
    subchapter            smallint,
    code                  varchar(16) NOT NULL,
    name                  varchar(2048)
);

COMMENT ON TABLE core.ref_chaptercode IS 'Разделы проектной документации';

COMMENT ON COLUMN core.ref_chaptercode.chaptercodetype_id IS '-> chaptercode_type';
COMMENT ON COLUMN core.ref_chaptercode.chapter IS 'Номер раздела';
COMMENT ON COLUMN core.ref_chaptercode.subchapter IS 'Номер подраздела';
COMMENT ON COLUMN core.ref_chaptercode.code IS 'Шифр';
COMMENT ON COLUMN core.ref_chaptercode.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefChapterCodes.c', 'Создание классификатора разделов ПД'),
    ('core.RefChapterCodes.r', 'Чтение классификаторов разделов ПД'),
    ('core.RefChapterCodes.u', 'Изменение классификатора разделов ПД'),
    ('core.RefChapterCodes.d', 'Удаление классификатора разделов ПД');

-- Типы единиц проектной продукции
CREATE TABLE core.ds_type (
  id SMALLSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(25) NOT NULL UNIQUE,
  descr TEXT
);

COMMENT ON TABLE core.ds_type IS 'Типы единиц проектной продукции';

COMMENT ON COLUMN core.ds_type.id IS 'Идентификатор';
COMMENT ON COLUMN core.ds_type.name IS 'Наименование';
COMMENT ON COLUMN core.ds_type.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
      ('core.DocsetTypes.r', 'Чтение типов единиц проектной продукции')
    , ('core.DocsetTypes.c', 'Создание типа единицы проектной продукции')
    , ('core.DocsetTypes.u', 'Изменение типа единицы проектной продукции')
    , ('core.DocsetTypes.d', 'Удаление типа единицы проектной продукции')
    , ('core.DocsetTypes.l', 'Создание/удаление записи в связанной таблице')
;

INSERT INTO core.ds_type (name, descr) VALUES
     ('Комплект', 'Комплект проектной продукции (стадия Р)')
    ,('Том', 'Том (стадия П, ИИ)')
;

-- Комплекты
CREATE TABLE core.docset (
    id               bigserial PRIMARY KEY,
    cobject_id       bigint  REFERENCES core.cobject(id),
    settype          varchar(10),
    cipher           varchar(50) NOT NULL,
    mark_ref_id      integer REFERENCES core.ref_mark(id),
    name             varchar(2048) NOT NULL,
    datestart        date,
    datefinish       date,
    invoice_num      varchar(100),
    invoice_date     date,
    ds_type_id       SMALLINT REFERENCES core.ds_type(id)
);

COMMENT ON TABLE core.docset IS 'Комплекты';

COMMENT ON COLUMN core.docset.id IS 'Идентификатор';
COMMENT ON COLUMN core.docset.cobject_id IS '-> cobject';
COMMENT ON COLUMN core.docset.settype IS 'Тип комплекта (ОТ, ВТ)';
COMMENT ON COLUMN core.docset.cipher IS 'Обозначение комплекта';
COMMENT ON COLUMN core.docset.mark_ref_id IS '-> mark_ref';
COMMENT ON COLUMN core.docset.name IS 'Наименование';
COMMENT ON COLUMN core.docset.datestart IS 'Дата начала';
COMMENT ON COLUMN core.docset.datefinish IS 'Дата окончания';
COMMENT ON COLUMN core.docset.invoice_num IS '№ накладной';
COMMENT ON COLUMN core.docset.invoice_date IS 'Дата накладной';
COMMENT ON COLUMN core.docset.ds_type_id IS '-> ds_type';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.Docsets.c', 'Создание комплекта')
    ,('core.Docsets.r', 'Чтение комплектов')
    ,('core.Docsets.u', 'Изменение комплекта')
    ,('core.Docsets.d', 'Удаление комплекта')
    ,('core.Docsets.l', 'Создание/удаление записи в связанной таблице')
;

-- Мониторинг выпуска комплектов
CREATE TABLE core.docset_mon (
    id             bigserial PRIMARY KEY,
    docset_id      bigint NOT NULL REFERENCES core.docset(id),
    mondate        date NOT NULL,
    monpercent     smallint DEFAULT 0 NOT NULL,
    description    varchar(1024),
    created        timestamp WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT docset_mon_percent_chk CHECK (((monpercent >= 0) AND (monpercent <= 100)))
);

CREATE INDEX docset_mon_idx ON core.docset_mon USING btree (docset_id, mondate, created DESC);

COMMENT ON TABLE core.docset_mon IS 'Мониторинг выпуска комплектов';

COMMENT ON COLUMN core.docset_mon.id IS 'Идентификатор';
COMMENT ON COLUMN core.docset_mon.docset_id IS 'Ссылка на комплект документации';
COMMENT ON COLUMN core.docset_mon.mondate IS 'Дата мониторинга разработки комплекта';
COMMENT ON COLUMN core.docset_mon.monpercent IS '% разработки комплекта';
COMMENT ON COLUMN core.docset_mon.description IS 'Комментарии/описание';
COMMENT ON COLUMN core.docset_mon.created IS 'Дата создания записи';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.DocsetMons.c', 'Создание записи в мониторинге выпуска комплектов'),
    ('core.DocsetMons.r', 'Чтение записей мониторинга выпуска комплектов'),
    ('core.DocsetMons.u', 'Изменение записи мониторинга выпуска комплектов'),
    ('core.DocsetMons.d', 'Удаление записи мониторинга выпуска комплектов');

-- Список транспортных накладных
CREATE TABLE core.waybill (
  id BIGSERIAL PRIMARY KEY,
  waybill_num VARCHAR(100) NOT NULL,
  waybill_date DATE NOT NULL,
  descr core.d_description
);

COMMENT ON TABLE core.waybill IS 'Список транспортных накладных';

COMMENT ON COLUMN core.waybill.id IS 'Идентификатор';
COMMENT ON COLUMN core.waybill.waybill_num IS 'Номер накладной';
COMMENT ON COLUMN core.waybill.waybill_date IS 'Дата накладной';
COMMENT ON COLUMN core.waybill.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.Waybills.c', 'Создание накладной'),
    ('core.Waybills.r', 'Чтение накладных'),
    ('core.Waybills.u', 'Изменение накладной'),
    ('core.Waybills.d', 'Удаление накладной');

-- Связь много-ко-многим для составного документа (core.docset) и накладной (core.waybill)
CREATE TABLE core.waybill_link (
  id BIGSERIAL PRIMARY KEY,
  docset_id BIGINT NOT NULL REFERENCES core.docset(id),
  waybill_id BIGINT NOT NULL REFERENCES core.waybill(id)
);

COMMENT ON TABLE core.waybill_link IS 'core.docset <---> core.waybill';

COMMENT ON COLUMN core.waybill_link.id IS 'Идентификатор';
COMMENT ON COLUMN core.waybill_link.docset_id IS '-> core.docset';
COMMENT ON COLUMN core.waybill_link.waybill_id IS '-> core.waybill';

-- Детализация составного документа - Комплект
CREATE TABLE core.ds_bsd (
    id             BIGSERIAL PRIMARY KEY,
    docset_id      BIGINT NOT NULL REFERENCES core.docset(id),
    name           TEXT NOT NULL,
    cipher         VARCHAR(128) NOT NULL,
    dev_dep        VARCHAR(32),
    oipks_id       SMALLINT REFERENCES core.construction(id),
    contractor_id  INTEGER REFERENCES core.ref_contractor(id),
    contract_id    INTEGER REFERENCES core.contract(id),
    phase_id       SMALLINT REFERENCES core.ref_phase(id),
    phase_num      VARCHAR(32),
    developer_id   INTEGER REFERENCES core.ref_developer(id),
    constrpart_id  INTEGER REFERENCES core.ref_constrpart(id),
    constrpart_num VARCHAR(4),
    building_id    INTEGER REFERENCES core.ref_building(id),
    building_num   VARCHAR(3),
    mark_id        INTEGER REFERENCES core.ref_mark(id),
    mark_path      VARCHAR(3),
    cipher_doc     VARCHAR(3),
    cstage         VARCHAR(32),
    izm_num        SMALLINT DEFAULT 0,
    gip            VARCHAR(128),
    status         TEXT,
    object_time    TIMESTAMP WITH TIME ZONE
);

COMMENT ON TABLE core.ds_bsd IS 'Детализация составного документа - Комплект';

COMMENT ON COLUMN core.ds_bsd.id IS 'Идентификатор';
COMMENT ON COLUMN core.ds_bsd.docset_id IS '-> docset';
COMMENT ON COLUMN core.ds_bsd.name IS 'Наименование';
COMMENT ON COLUMN core.ds_bsd.cipher IS 'Шифр документа (обозначение)';
COMMENT ON COLUMN core.ds_bsd.dev_dep IS 'Код подразделения-исполнителя';
COMMENT ON COLUMN core.ds_bsd.oipks_id IS '1 - код ОИП КС -> core.construction';
COMMENT ON COLUMN core.ds_bsd.contractor_id IS '2 - код заказчика -> core.ref_contractor';
COMMENT ON COLUMN core.ds_bsd.contract_id IS '3 - договор -> core.contract';
COMMENT ON COLUMN core.ds_bsd.phase_id IS '4 - стадия -> core.ref_phase';
COMMENT ON COLUMN core.ds_bsd.phase_num IS '4 - уточнение: этапы/стадии договора может быть 1/1-3, т.е. этап 1 подэтапы 1-3';
COMMENT ON COLUMN core.ds_bsd.developer_id IS '5 - субъект разработки -> core.ref_developer';
COMMENT ON COLUMN core.ds_bsd.constrpart_id IS '6 - часть комплекса -> core.ref_constrpart';
COMMENT ON COLUMN core.ds_bsd.constrpart_num IS '7 - номер части комплекса';
COMMENT ON COLUMN core.ds_bsd.building_id IS '8 - здание/сооружение/сеть -> core.ref_building';
COMMENT ON COLUMN core.ds_bsd.building_num IS '9 - позиция здания/сооружения/сети по генплану';
COMMENT ON COLUMN core.ds_bsd.mark_id IS '10 - марка основного комплекта -> core.ref_mark';
COMMENT ON COLUMN core.ds_bsd.mark_path IS '11 - номер части марки';
COMMENT ON COLUMN core.ds_bsd.cipher_doc IS '12 - шифр документа';
COMMENT ON COLUMN core.ds_bsd.cstage IS 'Этап по генподрядному договру';
COMMENT ON COLUMN core.ds_bsd.izm_num IS '№ изменения';
COMMENT ON COLUMN core.ds_bsd.gip IS 'ГИП';
COMMENT ON COLUMN core.ds_bsd.status IS 'Статус';
COMMENT ON COLUMN core.ds_bsd.object_time IS 'Время изменения оригинала';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.DSBSDs.c', 'Создание Комплекта в составном документе'),
    ('core.DSBSDs.r', 'Чтение Комплектов в составном документе'),
    ('core.DSBSDs.u', 'Изменение Комплекта в составном документе'),
    ('core.DSBSDs.d', 'Удаление Комплекта из составного документа');

-- Этапы договора
CREATE TABLE core.contract_stages (
  id BIGSERIAL PRIMARY KEY,
  contract_id INTEGER REFERENCES core.contract(id),
  status VARCHAR(50) DEFAULT 'не определен'::character varying NOT NULL,
  stage_num VARCHAR(20) NOT NULL,
  name TEXT,
  plan_start DATE,
  plan_finish DATE,
  worktypes TEXT
);

COMMENT ON TABLE core.contract_stages IS 'Этапы договора';

COMMENT ON COLUMN core.contract_stages.id IS 'Иденитификатор';
COMMENT ON COLUMN core.contract_stages.contract_id IS '-> core.contract';
COMMENT ON COLUMN core.contract_stages.status IS 'Статус: не определен / перспективный / проект / подписан / приостановлен / расторгнут / выполнен';
COMMENT ON COLUMN core.contract_stages.stage_num IS '№ этапа';
COMMENT ON COLUMN core.contract_stages.name IS 'Наименование этапа';
COMMENT ON COLUMN core.contract_stages.plan_start IS 'Начало работ по плану';
COMMENT ON COLUMN core.contract_stages.plan_finish IS 'Окончание работ по плану';
COMMENT ON COLUMN core.contract_stages.worktypes IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
     ('core.ContractStages.c', 'Создание этапа договора')
    ,('core.ContractStages.r', 'Чтение этапов договора')
    ,('core.ContractStages.u', 'Изменение этапа договора')
    ,('core.ContractStages.d', 'Удаление этапа договора')
    ,('core.ContractStages.l', 'Создание/удаление записи в связанной таблице')
;

-- Документ в составе составного документа (Document)
CREATE TABLE core.document (
  id BIGSERIAL PRIMARY KEY,
  docset_id BIGINT REFERENCES core.docset(id),
  cipher VARCHAR(128),
  doccode_id INTEGER REFERENCES core.ref_doccode(id),
  name TEXT,
  developer_dep VARCHAR(16),
  izm_num INTEGER,
  status VARCHAR(64),
  is_actual BOOLEAN DEFAULT TRUE NOT NULL
);

COMMENT ON TABLE core.document IS 'Документ в составе составного документа (Document)';

COMMENT ON COLUMN core.document.id IS 'Идентификатор';
COMMENT ON COLUMN core.document.docset_id IS '-> core.docset';
COMMENT ON COLUMN core.document.cipher IS 'Обозначение документа в соответствии с Регламентом Р-08';
COMMENT ON COLUMN core.document.doccode_id IS '-> core.ref_doccode';
COMMENT ON COLUMN core.document.name IS 'Наименование с титульного листа';
COMMENT ON COLUMN core.document.developer_dep IS 'Код подразделения-исполнителя внутри филиала';
COMMENT ON COLUMN core.document.izm_num IS 'Номер изменения';
COMMENT ON COLUMN core.document.status IS 'Статус документа в исторической системе';
COMMENT ON COLUMN core.document.is_actual IS 'Признак актуальности документа';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.Documents.c', 'Создание документа')
    ,('core.Documents.r', 'Чтение документов')
    ,('core.Documents.u', 'Изменение документа')
    ,('core.Documents.d', 'Удаление документа')
    ,('core.Documents.l', 'Создание/удаление записи в связанной таблице')
;

-- Элемент "Файл документа" (может входить в состав <Document> или <Invoice>)
CREATE TABLE core.mfile (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  parent_object_type VARCHAR(64),
  parent_object_id BIGINT,
  name VARCHAR(256) NOT NULL,
  size BIGINT,
  modify_time TIMESTAMP WITH TIME ZONE,
  filetype_id INTEGER DEFAULT 0 NOT NULL
);

COMMENT ON TABLE core.mfile IS 'Элемент "Файл документа" (может входить в состав <Document> или <Invoice>)';

COMMENT ON COLUMN core.mfile.id IS 'Идентификатор';
COMMENT ON COLUMN core.mfile.parent_object_type IS 'Тип объекта, которому принадлежит файл';
COMMENT ON COLUMN core.mfile.parent_object_id IS '-> core.document | core.invoice';
COMMENT ON COLUMN core.mfile.name IS 'Имя файла без пути';
COMMENT ON COLUMN core.mfile.size IS 'Размер файла в байтах';
COMMENT ON COLUMN core.mfile.modify_time IS 'Дата/время последней модификации файла';
COMMENT ON COLUMN core.mfile.filetype_id IS 'Тип файла: 0-UNKNOWN, 1-Скан с подписями, 2-Файл в редактируемом формате, (>=3)-Зарезервировано';

INSERT INTO sys.acl_function(name, descr) VALUES
     ('core.MFiles.c', 'Создание метаданных файла'),
     ('core.MFiles.r', 'Чтение метаданных файла'),
     ('core.MFiles.u', 'Изменение метаданных файла'),
     ('core.MFiles.d', 'Удаление метаданных файла'),
     ('core.MFiles.l', 'Создание/удаление записи в связанной таблице')
;
-- DashBoard для Комплексов: отображает кол-во комплектов по каждому Комплексу
-- Для обновления данных - вызвать REFRESH MATERIALIZED VIEW core.summary_construction
CREATE MATERIALIZED VIEW core.summary_construction (
    id,
    cobject_id,
    code,
    name,
    cnt_id,
    cnt_datestart,
    cnt_datefinish,
    cnt_invoicenum)
AS
SELECT c.id,
    co1.id AS cobject_id,
    c.code,
    c.name,
    count(ds.id) AS cnt_id,
    count(ds.datestart) AS cnt_datestart,
    count(ds.datefinish) AS cnt_datefinish,
    count(ds.invoice_num) AS cnt_invoicenum
FROM core.construction c
     JOIN core.cobject co1 ON co1.construction_id = c.id
     JOIN core.cobject_type cot ON cot.id = co1.cobject_type_id AND
         cot.name::text = 'CONSTR'::text
     JOIN core.cobject co2 ON co2.construction_id = c.id
     LEFT JOIN core.docset ds ON ds.cobject_id = co2.id
GROUP BY c.id, co1.id, c.code, c.name
ORDER BY c.code, c.name;

COMMENT ON MATERIALIZED VIEW core.summary_construction IS 'Обобщенные данные по комплектам(DocSet) для Constructions';

COMMENT ON COLUMN core.summary_construction.code IS 'Код комплекса';
COMMENT ON COLUMN core.summary_construction.id IS 'Идентификатор (construction_id)';
COMMENT ON COLUMN core.summary_construction.cobject_id IS 'Идентификатор (CObject_id)';
COMMENT ON COLUMN core.summary_construction.name IS 'Наименование комплекса';
COMMENT ON COLUMN core.summary_construction.cnt_id IS 'Кол-во комплектов комплекса';
COMMENT ON COLUMN core.summary_construction.cnt_datestart IS 'Кол-во комплектов, у которых есть дата начала';
COMMENT ON COLUMN core.summary_construction.cnt_datefinish IS 'Кол-во комплектов, у которых есть дата окончания';
COMMENT ON COLUMN core.summary_construction.cnt_invoicenum IS 'Кол-во комплектов, у которых есть № накладной';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.SummaryConstructions.r', 'Чтение данных комплектов для Комплексов');

CREATE TABLE "mrd_oksgroup" (
    "id"		serial PRIMARY KEY,		-- ИД
    "code_range"	varchar(32),			-- диапазон кодов
    "name"		varchar(512) NOT NULL		-- наименование группы ОКС
);

COMMENT ON COLUMN mrd_oksgroup.code_range IS 'диапазон кодов';
COMMENT ON COLUMN mrd_oksgroup.name IS 'наименование группы ОКС';

CREATE TABLE "mrd_oksref" (
    "id"		serial PRIMARY KEY,				-- ИД
    "oksgroup_id"	int REFERENCES "mrd_oksgroup" ("id"),		-- ссылка на группу ОКС
    "code"		varchar(8) NOT NULL,				-- код вида ОКС
    "name"		varchar(512) NOT NULL				-- наименования вида ОКС
);

COMMENT ON COLUMN mrd_oksref.oksgroup_id IS 'ссылка на группу ОКС';
COMMENT ON COLUMN mrd_oksref.code IS 'код вида ОКС';
COMMENT ON COLUMN mrd_oksref.name IS 'наименования вида ОКС';

CREATE TABLE "mrd_ossrgroup" (
    "id"		serial PRIMARY KEY,				-- ИД
    "code_range"	varchar(32),					-- диапазон кодов
    "name"		varchar(512) NOT NULL				-- наименование группы ОКС
);

COMMENT ON COLUMN mrd_ossrgroup.code_range IS 'диапазон кодов';
COMMENT ON COLUMN mrd_ossrgroup.name IS 'наименование группы ОКС';

CREATE TABLE "mrd_ossrref" (
    "id"		serial PRIMARY KEY,				-- ИД
    "ossrgroup_id"	int REFERENCES "mrd_ossrgroup" ("id"),		-- ccылка на группу ОССР
    "code"		varchar(8) NOT NULL,				-- код вида ОССР
    "name"		varchar(512) NOT NULL				-- наименования вида ОССР
);

COMMENT ON COLUMN mrd_ossrref.ossrgroup_id IS 'ccылка на группу ОССР';
COMMENT ON COLUMN mrd_ossrref.code IS 'код вида ОССР';
COMMENT ON COLUMN mrd_ossrref.name IS 'наименования вида ОССР';

-- Типы объектов МРД
CREATE TABLE mrd_objecttype (
    id          CHAR(1) PRIMARY KEY,
    codename    VARCHAR(16),
    name        VARCHAR(32)
);

COMMENT ON TABLE mrd_objecttype IS 'Типы объектов МРД';

COMMENT ON COLUMN mrd_objecttype.id IS 'Идентификатор';
COMMENT ON COLUMN mrd_objecttype.codename IS 'Кодовое наименование';
COMMENT ON COLUMN mrd_objecttype.name IS 'Наименование';

INSERT INTO mrd_objecttype (id, codename, name) VALUES
    ('C', 'CONSTR', 'Комплекс'),
    ('S', 'OKS'   , 'ОКС'),
    ('R', 'OSSR'  , 'ОССР');

CREATE TABLE "mrd_object" (
    "id"		serial PRIMARY KEY,
    "parent_id" 	int,
    "construction_id" 	smallint NOT NULL REFERENCES core.construction ("id"),
    "type_id"		int,
    "type" 		char(1) NOT NULL REFERENCES "mrd_objecttype" ("id"),
    "code" 		varchar(32),
    "number" 		varchar(32),
    "descr" 		varchar(8192)
);

CREATE TABLE "mrd_object_link" (
    "id"		serial PRIMARY KEY,
    "cobject_id"		bigint NOT NULL REFERENCES core.cobject ("id"),
    "mrd_object_id"	int NOT NULL REFERENCES "mrd_object" ("id")
);

-- Главы ССР 
CREATE TABLE ssr_chapter (
    id      smallserial PRIMARY KEY,
    code    varchar(8) NOT NULL,
    name    varchar(256) NOT NULL
);

COMMENT ON TABLE ssr_chapter IS 'Главы ССР';

COMMENT ON COLUMN ssr_chapter.id IS 'Идентификатор';
COMMENT ON COLUMN ssr_chapter.code IS 'Номер';
COMMENT ON COLUMN ssr_chapter.name IS 'Наименование';

INSERT INTO ssr_chapter (code, name) VALUES
    ('1', 'Подготовка территории строительства'),
    ('2', 'Основные объекты строительства'),
    ('3', 'Объекты подсобного и обслуживающего назначения'),
    ('4', 'Объекты энергетического хозяйства'),
    ('5', 'Объекты транспортного хозяйства и связи'),
    ('6', 'Наружные сети и сооружения водоснабжения, канализации, теплоснабжения и газоснабжения'),
    ('7', 'Благоустройство и озеленение территории'),
    ('8', 'Временные здания и сооружения'),
    ('9', 'Прочие работы и затраты'),
    ('10', 'Содержание службы заказчика. Строительный контроль'),
    ('12', 'Проектные и изыскательские работы');

-- Типы отнесения затрат
CREATE TABLE cost_assign (
    id      smallserial PRIMARY KEY,
    name    varchar(64) NOT NULL
);

COMMENT ON TABLE cost_assign IS 'Типы отнесения затрат';

COMMENT ON COLUMN cost_assign.name IS 'Идентификатор';
COMMENT ON COLUMN cost_assign.name IS 'Наименование';

INSERT INTO cost_assign (name) VALUES
    ('Косвенные'),
    ('Прямые');

-- Статьи/группы видов затрат
CREATE TABLE cost_group (
    id           smallserial PRIMARY KEY,
    parent_id    smallint REFERENCES cost_group (id),
    name         varchar(100) NOT NULL
);

COMMENT ON TABLE cost_group IS 'Статьи/группы видов затрат';

COMMENT ON COLUMN cost_group.id IS 'Идентификатор';
COMMENT ON COLUMN cost_group.parent_id IS '-> cost_group';
COMMENT ON COLUMN cost_group.name IS 'Наименование';

INSERT INTO cost_group (parent_id, name) VALUES
    (NULL, 'Подрядные работы'),
    (NULL, 'Прочие затраты'),
    (NULL, 'Оборудование'),
    (NULL, 'За итогом глав ССР'),
    (1, 'Строительные работы'),
    (1, 'Монтажные работы'),
    (1, 'Прочие работы, связанные с организацией строительного производства'),
    (2, 'Прочие затраты Заказчика (Агента)'),
    (3, 'Оборудование');

-- Форматы планирования ИУС И
CREATE TABLE iusi_plan_form (
    id           smallserial PRIMARY KEY,
    name         varchar(64) NOT NULL,
    cost_code    varchar(10)
);

COMMENT ON TABLE iusi_plan_form IS 'Форматы планирования ИУС И';

COMMENT ON COLUMN iusi_plan_form.id IS 'Идентификатор';
COMMENT ON COLUMN iusi_plan_form.name IS 'Наименование формата планирования';
COMMENT ON COLUMN iusi_plan_form.cost_code IS 'Код вида затрат ИУС И';

INSERT INTO iusi_plan_form (name, cost_code) VALUES
    ('Подрядные работы', 'Т800000200'),
    ('Материалы, трубная продукция', 'Т800000202'),
    ('Иные прочие', 'Т800000599'),
    ('Землеотвод', 'Т800000500'),
    ('Землеотвод, аренда', 'Т800000501'),
    ('Пуско наладочные работы "вхолостую"', 'Т800000505'),
    ('Услуги Заказчика', 'Т800000509'),
    ('Проектирование (ПД, РД)', 'Т800000100'),
    ('Экспертиза', 'Т800000508'),
    ('Оборудование', 'Т800000301'),
    ('не учитывается', null),
    ('учитывается отдельно', null);

-- Классификатор видов затрат
CREATE TABLE cost_kind (
    id                   smallserial PRIMARY KEY,
    code                 varchar(6) NOT NULL,
    code_old             VARCHAR(6),
    name                 varchar(2048) NOT NULL,
    cost_group_id        smallint REFERENCES cost_group(id),
    cost_assign_id       smallint REFERENCES cost_assign(id),
    iusi_plan_form_id    smallint REFERENCES iusi_plan_form(id)
);

COMMENT ON TABLE cost_kind IS 'Классификатор видов затрат';

COMMENT ON COLUMN cost_kind.id IS 'Идентификтор';
COMMENT ON COLUMN cost_kind.code IS 'Код';
COMMENT ON COLUMN cost_kind.code_old IS 'Код до 2018.08';
COMMENT ON COLUMN cost_kind.name IS 'Наименование';
COMMENT ON COLUMN cost_kind.cost_group_id IS '-> cost_group';
COMMENT ON COLUMN cost_kind.cost_assign_id IS '-> cost_assign';
COMMENT ON COLUMN cost_kind.iusi_plan_form_id IS '-> iusi_plan_form';

INSERT INTO cost_kind (code, code_old, cost_group_id, cost_assign_id, iusi_plan_form_id, name) VALUES
    ('101','101',5,2,1,'Строительные и специальные строительные работы'),
    ('103','103',9,2,10,'Приобретение оборудования'),
    ('116','103-01',9,2,10,'Приобретение газоперекачивающих агрегатов'),
    ('117','103-02',9,2,10,'Приобретение оборудования для эксплуатационного и разведочного бурения'),
    ('753','703-17',null,null,null,'Затраты на выполнение шефмонтажа оборудования'),
    ('301','302-02',7,1,1,'Средства на оплату затрат, связанных с освобождением территории строительства от имеющихся на ней строений, т.е. по сносу (переносу и строительству взамен сносимого на другом месте) зданий и сооружений, по валке леса, корчевке пней, очистке от кустарника, уборке камней, вывозке промышленных отвалов (отработанные породы, шлак и т.п.), переносу и переустройству инженерных сетей, коммуникаций, сооружений'),
    ('302','302-03',7,1,1,'Организация рельефа при строительстве площадочных сооружений до начала их возведения'),
    ('303','302-04',7,1,1,'Проведение технической рекультивации'),
    ('304',null,null,null,null,'Проведение биологической рекультивация'),
    ('305','301-07',null,null,null,'Осушение территории строительства, проведение других мероприятий, связанных с прекращением или изменением условий водопользования, а также с защитой окружающей среды и ликвидацией неблагоприятных условий строительства'),
    ('306',null,null,null,null,'Затраты на подготовку территории для строительства титульных ВЗиС, размещенных за пределами участка, отведенного под застройку'),
    ('307','302',7,1,1,'Прочие работы, связанные с освоением территории строительства'),
    ('501','501',7,1,1,'Благоустройство и озеленение территории'),
    ('601','601',7,1,1,'Средства на строительство титульных временных устройств и обустройств'),
    ('603','602-01',7,1,1,'Строительство временных коммуникаций для обеспечения стройки электроэнергией, водой, теплом и т.п. от источника подключения до распределительных устройств на строительной площадке (территории строительства)'),
    ('604','602-02',7,1,1,'Строительство временной дороги вдоль трассы (притрассовой дороги) при строительстве магистральных линейных сооружений общей сети с целью первоначального освоения района строительства'),
    ('605','602-03',7,1,1,'Строительство и демонтаж временных лежневых дорог'),
    ('606','602-04',7,1,1,'Устройство земляных амбаров для гидроиспьгганий'),
    ('607','602-05',7,1,1,'Ледовые переправы (при переходе зимних автодорог через водотоки, при осуществлении строительства в районах Крайнего Севера преимущественно в зимний период, не менее 0,5 года)'),
    ('608','602-06',7,1,1,'Временные подъездные автодороги к строящимся основным линейным и площадочным (КС, УКПГ и т.д.) сооружениям, включая автодороги к площадкам временных строительных баз и полевым вахтовым поселкам подрядных организаций'),
    ('609','602-07',7,1,1,'Зимние автодороги (при ведении строительства в районах Крайнего Севера преимущественно в зимний период, не менее 0,5 года)'),
    ('610','602-08',7,1,1,'Усиление существующих автодорог и мостов (ПАО «Газпром» или его предприятий и организаций), несущая способность которых не выдерживает нагрузок от транспортировки по ним грузов при строительстве (реконструкции) объекта'),
    ('602','602',7,1,1,'Прочие титульные временные устройства и обустройства, размещенные за пределами участка, отведенного под застройку и не учтенные нормами'),
    ('911','911',7,1,1,'Средства, связанные с устройством и испытанием свай, проводимых подрядной организацией в период разработки проектной документации по техническому заданию заказчика строительства'),
    ('912','912',7,1,1,'Затраты на проверку сплошности бетонирования и целостности ствола буронабивных свай'),
    ('730','703',7,1,1,'Иные прочие затраты Подрядчика'),
    ('701','701',7,1,1,'Дополнительные затраты при производстве строительно-монтажных, ремонтно-строительных и пусконаладочных работ в зимнее время'),
    ('702','702-01',7,1,1,'Первоначальная очистка от снега площадки (трассы) для строительства, которое начинается в зимнее время'),
    ('703','702-02',7,1,1,'Затраты по снегоборьбе в районах Крайнего Севера и местностях, приравненных к ним, а также в сельских местностях, расположенных в пределах IV, V, VI температурных зон'),
    ('704','702',7,1,1,'Прочие затраты, связанные с производством работ в зимнее время и не учтенные нормами'),
    ('705','703-01',7,1,1,'Затраты на содержание действующих постоянных автомобильных дорог и восстановление их после окончания строительства'),
    ('706','703-02',7,1,1,'Затраты на содержание и восстановление после окончания строительства (ремонта) объекта существующих автодорог с твердым покрытием (ПАО "Газпром’1 или его предприятий и организаций)'),
    ('707','703-03',7,1,1,'Затраты на оплату за проезд по платным автомобильным дорогам'),
    ('708','703-04',7,1,1,'Затраты, связанные с изменением расстояния транспортирования материалов'),
    ('709','703-06',7,1,1,'Средства на покрытие затрат строительных организаций на оплату сборов за перевозку негабаритных грузов по дорогам и мостам'),
    ('710','703-07',7,1,1,'Затраты на содержание и ремонт зимников, в том числе ледовых переправ (для Северного района)'),
    ('711','703-08',7,1,1,'Затраты на оплату услуг владельцам понтонной переправы'),
    ('712','703-09',7,1,1,'Затраты на оплату услуг владельцам зимней дороги'),
    ('713','703-16',7,1,1,'Затраты на содержание железнодорожных станций для приема строительных грузов на период строительства (в том числе, при необходимости, подготовка ж.д. станции для приема грузов)'),
    ('714',null,null,null,null,'Прочие затраты, связанные с использованием действующих объектов транспортной инфраструктуры'),
    ('715','703-11',7,1,1,'Затраты по перевозке работников строительных и монтажных организаций автомобильным транспортом к месту работы и обратно на расстояние более 3 км в одном направлении при отсутствии городских пассажирских маршрутов, или компенсацию расходов по организации специальных маршрутов городского пассажирского транспорта'),
    ('716','703-12',7,1,1,'Затраты, связанные с осуществлением работ вахтовым методом (за исключением вахтовой надбавки к тарифной ставке, учитываемой в локальных сметах)'),
    ('717','703-13',7,1,1,'Средства на возмещение затрат, связанных с командированием (за исключением затрат, учтенных фондом оплаты труда)'),
    ('718','703-14',7,1,1,'Затраты, связанные с перебазированием строительно-монтажных организаций с одной стройки на другую (кроме перебазировки строительных машин и механизмов, которые учтены в стоимости эксплуатации машин и механизмов)'),
    ('719','703-18',7,1,1,'Затраты на проведение мероприятий по обеспечению нормальных условий труда (борьба с радиоактивностью, силикозом, малярией, энцефалитным клещом, гнусом и т.д.)'),
    ('720',null,null,null,null,'Прочие затраты, связанные с мобилизацией строительной организации'),
    ('721','703-15',7,1,1,'Затраты на строительство временных перевалочных баз подрядчика и заказчика в пунктах перегрузки материалов и конструкций с одного вида транспорта на другой, а так же строительство перевалочных баз подрядчика и заказчика за пределами строительной площадки (при необходимости)'),
    ('722','703-20',7,1,1,'Затраты на возмещение налогов, сборов, отчислений, установленные законодательными актами Российской Федерации и решениями местных (региональных) органов власти -затрат, не учтенных нормой накладных расходов: плата за забор воды из водных объектов (водный налог), в случае, если этот вид затрат не учтен в стоимости воды; выплаты в природоохранительные организации и др.'),
    ('723','703-22',7,1,1,'Затраты на оплату размещения отходов в период строительства'),
    ('724','703-23',7,1,1,'Затраты на оплату за выбросы загрязняющих веществ в атмосферу'),
    ('725','703-24',7,1,1,'Выплаты за организованный сброс загрязняющих веществ в водные объекты'),
    ('726','703-25',7,1,1,'Выплаты за неорганизованный сброс загрязняющих веществ в водные объекты'),
    ('727','703-29',7,1,1,'Затраты на контроль изоляции трубопровода'),
    ('728','703-34',7,1,1,'Затраты на мойку колес автотранспорта'),
    ('729','703-35',7,1,1,'Затраты, связанные с использованием электроэнергии от стационарных сетей и передвижных источников электроснабжения (при необходимости)'),
    ('328','301-01',8,1,4,'Средства на отвод земельного участка в натуре, выдачу архитектурно-планировочных заданий и красных линий застройки'),
    ('308','301-02',8,1,4,'Средства на разбивку основных осей зданий и сооружений и переносу их в натуру, строительно-монтажные работы по закреплению их пунктами и знаками'),
    ('739','703-32',null,null,null,'Затраты на совершенствование отраслевой сметно-нормативной базы'),
    ('740','703-33',null,null,null,'Затраты по техническому освидетельствованию после монтажа и до пуска в работу сосудов, работающих под давлением, грузоподъемных механизмов (при отсутствии затрат в нормах на монтаж)'),
    ('309','301-05',8,1,4,'Средства на оплату затрат, связанных с получением заказчиком и проектной организацией исходных данных, технических условий на проектирование, и проведение необходимых согласований по проектным решениям, а также выполнение, по требованию органов местного самоуправления, исполнительной контрольной съемки построенных инженерных сетей'),
    ('310','301-06',8,1,4,'Землеустроительные работы в части разработки горно-геологического обоснования по застройке территории месторождении с целью получения разрешения на застройку территории залегания полезных ископаемых'),
    ('311','301-08',8,1,4,'Затраты по оформлению разрешительной документации в части недропользования (без изъятия воды) при добыче нерудных общераспространенных полезных ископаемых'),
    ('312','301-09',8,1,4,'Затраты по оформлению разрешительной документации по особо охраняемым природным территориям'),
    ('313','301-10',8,1,4,'Затраты на земляные и подготовительные работы для выполнения диагностического обследования существующих трубопроводов в местах пересечения с проектируемыми трубопроводами'),
    ('314','301-11',8,1,4,'Средства на оплату затрат, связанных с разминированием территории строительства в районах бывших боевых действий'),
    ('315','301-12',8,1,4,'Средства на оплату затрат, связанных с выполнением археологических раскопок в пределах строительной площадки'),
    ('316','301-13',8,1,4,'Средства на выполнение комплекса работ по оформлению прав ПАО «Газпром» на земельные (лесные) участки, необходимые для строительства объектов'),
    ('317','301-03',8,1,5,'Средства на оплату за землю при изъятии (выкупе) земельного участка для строительства, а также выплата земельного налога (аренды) в период строительства'),
    ('318','301-04',8,1,5,'Средства на оплату затрат за землю, отвод для строительства титульных ВЗиС, размещенных за пределами участка, отведенного под застройку'),
    ('319','301',8,1,4,'Прочие затраты, связанные с оформлением земельного участка'),
    ('320','302-01',null,null,null,'Средства на оплату затрат, связанных с компенсацией за сносимые строения и садово-огородные насаждения, затрат на незавершенное производство - посев, вспашку и другие сельскохозяйственные работы, затрат, связанных с компенсацией ущерба, наносимого природной среде произведенного на отчуждаемой территории, средства на оплату затрат по возмещению убытков, причиняемых проведением водохозяйственных мероприятий, прекращением или изменением условий водопользования, ущерб водным биологическим ресурсам и ущерб, наносимый объектам животного мира'),
    ('321','302-05',7,1,1,'Средства на компенсацию затрат землепользователей на биологическую рекультивацию'),
    ('322','302-06',null,null,null,'Средства на оплату затрат, связанных с неблагоприятными гидрогеологическими условиями территории строительства и необходимостью устройства объездов для городского транспорта'),
    ('323','302-07',null,null,null,'Затраты на возмещение ущерба водным биологическим ресурсам (при необходимости)'),
    ('104','104',8,1,3,'Затраты на приобретение буферного газа'),
    ('731','703-05',null,null,null,'Средства на возмещение вреда, причиняемого транспортными средствами, осуществляющими перевозки тяжеловесных грузов'),
    ('732','703-10',null,null,null,'Средства на оплату затрат, связанных с услугами по технологическому подключению к действующим сетям инженерно-технического обеспечения'),
    ('733','703-19',null,null,null,'Затраты по санитарно-экологическому сопровождению строительства и составлению санитарно-экологического паспорта объекта (производственно-экологический мониторинг на период строительства)'),
    ('734','703-21',null,null,null,'Затраты по наблюдению в ходе строительства за осадкой зданий и сооружений, возводимых на просадочных, вечномерзлых, насыпных грунтах, а также уникальных объектов (геотехнический мониторинг (ГТМ) в период строительства)'),
    ('735','703-26',null,null,null,'Затраты на техническую инвентаризацию объектов недвижимого имущества и изготовление документов кадастрового и технического учета'),
    ('736','703-27',null,null,null,'Затраты на оплату материалов для первоначального заполнения систем'),
    ('106','101-01',5,2,1,'Земляные работы, в том числе буро-взрывные работы'),
    ('107','101-02',5,2,1,'Сварочно-монтажные работы магистральных трубопроводов'),
    ('108','101-03',5,2,1,'Подводно-строительные (водолазные) работы'),
    ('109','101-04',5,2,1,'Эксплуатационное и разведочное бурение'),
    ('110','101-06',5,2,2,'Приобретение труб большого диаметра'),
    ('112','101-05',5,1,1,'Создание сети геотехнического мониторинга (ГТМ) для объектов газового комплекса в криолитозоне'),
    ('102','102',6,2,1,'Монтажные работы'),
    ('113','102-01',null,null,null,'Сварочно-монтажные работ технологических трубопроводов'),
    ('114',null,null,null,null,'Приобретение труб большого диаметра для монтажа технологических трубопроводов'),
    ('737','703-28',null,null,null,'Затраты на стравливание газа при подключении к единой системе газоснабжения вновь построенных объектов'),
    ('738','703-30',null,null,null,'Затраты по оформлению разрешения на использование радиочастот и по оплате радиочастотного спектра на этапе строительства объектов'),
    ('325','303-02',8,1,3,'Затраты на технико-техническое сопровождение при помощи телесистемы бурения наклонной скважины с горизонтальным вскрытием продуктивных горизонтов'),
    ('327','303-04',8,1,3,'Затраты на проведение комплексных газодинамических исследований и анализа пластовых флюидов'),
    ('749','704-01',8,1,3,'Затраты на переработку буровых отходов'),
    ('750','704-02',8,1,3,'Затраты на сопровождение бурения (сервисные услуги, топографо-геодезические работы и т. Д-)'),
    ('751','704-03',8,1,3,'Затраты на услуги по пожарной безопасности'),
    ('752',null,null,null,null,'Иные прочие затраты при эксплуатационном бурении'),
    ('801','801',8,1,7,'Содержание службы заказчика'),
    ('901','901',8,1,8,'Затраты на разработку предпроектной документации'),
    ('902','902',8,1,8,'Инженерные изыскания на стадии «Проектная документация»'),
    ('903','903',8,1,8,'Разработка проектной документации'),
    ('904','904',8,1,8,'Инженерные изыскания на стадии «Рабочая документация»'),
    ('905','905',8,1,8,'Разработка рабочей документации'),
    ('906','906',8,1,8,'Авторский надзор'),
    ('907','907',8,1,9,'Затраты на проведение экспертизы проектной документации'),
    ('908','908',8,1,8,'Затраты на мониторинг соответствия стоимостных параметров'),
    ('909','909',8,1,8,'Публичный технологический и ценовой аудит'),
    ('910','910',8,1,8,'Разработка конкурсной документации'),
    ('913','913',8,1,8,'Работы по научно-техническому сопровождению (в т.ч. разработка технических регламентов)'),
    ('914','914',8,1,8,'Затраты на разработку и регистрацию декларации пожарной безопасности'),
    ('915','915',8,1,8,'Затраты на разработку, регистрацию и экспертизу декларации промышленной безопасности'),
    ('001','001',4,1,11,'Резерв средств на непредвиденные работы и затраты'),
    ('002','002',4,1,12,'Средства на покрытие затрат по уплате налога на добавленную стоимость (НДС)'),
    ('003',null,null,null,null,'Затраты, учитываемые за итогом ССР'),
    ('741','703-36',null,null,null,'Затраты на разработку исполнительной документации «как построено»'),
    ('742','703-37',null,null,null,'Затраты на осуществление мероприятий по поиску и захоронению останков погибших во время Великой Отечественной войны на территории, отводимой под строительство в местах, относимых к районам бывших военных действий (при необходимости)'),
    ('743','703-38',null,null,null,'Затраты по усиленной охране объектов специализированными охранными организациями МВД России и частными предприятиями.'),
    ('744','703-39',null,null,null,'Затраты на проведение внутритрубной дефектоскопии перед вводом газопроводов в эксплуатацию'),
    ('745','703-40',null,null,null,'Затраты, связанные с использованием военно-строительных частей, студенческих отрядов и других контингентов (организованный набор рабочих)'),
    ('746','703-41',null,null,null,'Затраты, связанные с премированием за ввод в действие построенных объектов'),
    ('747','703-42',null,null,null,'Затраты на страхование'),
    ('748','703-31',null,null,null,'Затраты на проведение пусконаладочных работ "вхолостую"'),
    ('324','303-01',8,1,3,'Затраты на организацию приема грузов'),
    ('326','303-03',8,1,3,'Затраты на топографо-геодезические работы (при эксплуатационном бурении)'),
    ('802','802',8,1,3,'Строительный контроль');

-- Типы смет
CREATE TABLE estimate_type (
    id	          smallserial PRIMARY KEY,
    short_name    varchar(8) NOT NULL,
    name	  varchar(256) NOT NULL
);

COMMENT ON TABLE estimate_type IS 'Типы смет';

COMMENT ON COLUMN estimate_type.id IS 'Идентификатор';
COMMENT ON COLUMN estimate_type.short_name IS 'Сокращенное наименование';
COMMENT ON COLUMN estimate_type.name IS 'Наименование';

INSERT INTO estimate_type (short_name, name) VALUES
    ('ОС',  'Объектная'),
    ('ПОС', 'Подобъектная'),
    ('ЛС',  'Локальная'),
    ('СУМ', 'Суммирующая');

-- Сметы
CREATE TABLE estimate (
    id                  BIGSERIAL PRIMARY KEY,
    checksum 		BIGINT,
    machine_id          VARCHAR(32),
    developer_id        INT REFERENCES core.ref_developer (id),
    origin_key          VARCHAR(128),
    cobject_id          BIGINT REFERENCES core.cobject (id),
    contract_id         INT REFERENCES core.contract (id),
    phase_id		SMALLINT REFERENCES core.ref_phase (id),
    title		VARCHAR(2048),
    type_id		SMALLINT REFERENCES estimate_type (id),
    parent_id           bigint REFERENCES estimate (id),
    chapter_num	        SMALLINT,
    line_num            SMALLINT,
    subline1_num        SMALLINT,
    subline2_num        SMALLINT,
    subline3_num        SMALLINT,
    subline4_num        SMALLINT,
    subline5_num        SMALLINT,
    local_num	        SMALLINT,
    phase_id_num        SMALLINT REFERENCES core.ref_phase (id),
    changeset_num	SMALLINT,
    addenda_num         SMALLINT,
    source_num          VARCHAR(32),
    is_annulled         BOOLEAN DEFAULT false NOT NULL,
    replaces_id         BIGINT REFERENCES estimate (id),
    volume_value        DECIMAL(15,2),
    volume_measure      VARCHAR(64),
    cost_code_id        INT REFERENCES cost_kind (id),
    construction_cost   DECIMAL(15,2),
    installation_cost   DECIMAL(15,2),
    equipment_cost      DECIMAL(15,2),
    material_cost       DECIMAL(15,2),
    other_cost          DECIMAL(15,2),
    total_cost	        DECIMAL(15,2),
    comments            TEXT,
    price_at            DATE,
    approval_date       DATE,
    state_at            DATE NOT NULL,
    basis               VARCHAR(2048),
    book_cipher         VARCHAR(256),
    load_date           TIMESTAMP NOT NULL,
    tm_from             TIMESTAMP,
    tm_to               TIMESTAMP
);

COMMENT ON TABLE estimate IS 'Сметы';

COMMENT ON COLUMN estimate.id IS 'Идентификатор';
COMMENT ON COLUMN estimate.checksum IS 'Идентификатор источника (число)';
COMMENT ON COLUMN estimate.machine_id IS 'Машинный номер сметы';
COMMENT ON COLUMN estimate.developer_id IS 'Разработчик (филиал)';
COMMENT ON COLUMN estimate.origin_key IS 'Идентификатор сметы разработчика';
COMMENT ON COLUMN estimate.cobject_id IS 'Объект проектирования (стройка)';
COMMENT ON COLUMN estimate.contract_id IS 'Проект (договор)';
COMMENT ON COLUMN estimate.phase_id IS 'Стадия проектирования';
COMMENT ON COLUMN estimate.title IS 'Заголовок сметы (наименование работ и затрат...)';
COMMENT ON COLUMN estimate.type_id IS 'Тип сметы: объектная, локальная...';
COMMENT ON COLUMN estimate.parent_id IS 'Cсылка на объектную смету';
COMMENT ON COLUMN estimate.chapter_num IS 'Номер главы';
COMMENT ON COLUMN estimate.line_num IS 'Номер объектной сметы';
COMMENT ON COLUMN estimate.subline1_num IS 'Номер подобъектной сметы 1';
COMMENT ON COLUMN estimate.subline2_num IS 'Номер подобъектной сметы 2';
COMMENT ON COLUMN estimate.subline3_num IS 'Номер подобъектной сметы 3';
COMMENT ON COLUMN estimate.subline4_num IS 'Номер подобъектной сметы 4';
COMMENT ON COLUMN estimate.subline5_num IS 'Номер подобъектной сметы 5';
COMMENT ON COLUMN estimate.local_num IS 'Номер локальной сметы';
COMMENT ON COLUMN estimate.phase_id_num IS 'Стадия проектирования в номере сметы';
COMMENT ON COLUMN estimate.changeset_num IS 'Номер изменения';
COMMENT ON COLUMN estimate.addenda_num IS 'Номер дополнения';
COMMENT ON COLUMN estimate.source_num IS 'Номер сметы (из источника)';
COMMENT ON COLUMN estimate.volume_value IS 'Объемный показатель - количество';
COMMENT ON COLUMN estimate.volume_measure IS 'Объемный показатель - ед. изм.';
COMMENT ON COLUMN estimate.cost_code_id IS 'Код вида затрат (МРД)';
COMMENT ON COLUMN estimate.construction_cost IS 'Стоимость строительных работ';
COMMENT ON COLUMN estimate.installation_cost IS 'Стоимость монтажных работ';
COMMENT ON COLUMN estimate.equipment_cost IS 'Стоимость оборудования';
COMMENT ON COLUMN estimate.material_cost IS 'Стоимость материалов';
COMMENT ON COLUMN estimate.other_cost IS 'Стоимость прочих работ';
COMMENT ON COLUMN estimate.total_cost IS 'Стоимость итого';
COMMENT ON COLUMN estimate.comments IS 'Комментарий';
COMMENT ON COLUMN public.estimate.is_annulled IS 'Признак что смета аннулирована';
COMMENT ON COLUMN public.estimate.replaces_id IS 'Ссылка на заменённую смету';
COMMENT ON COLUMN estimate.price_at IS 'Уровень цен на дату';
COMMENT ON COLUMN estimate.approval_date IS 'Дата утверждения сметы';
COMMENT ON COLUMN estimate.state_at IS 'По состоянию на';
COMMENT ON COLUMN estimate.basis IS 'Основание для разработки';
COMMENT ON COLUMN estimate.book_cipher IS 'Шифр тома СД';
COMMENT ON COLUMN estimate.load_date IS 'Дата загрузки в систему';
COMMENT ON COLUMN estimate.tm_from IS 'Дата начала действия';
COMMENT ON COLUMN estimate.tm_to IS 'Дата окончания действия';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('est.Estimates.c', 'Создание смет'),
    ('est.Estimates.r', 'Чтение смет'),
    ('est.Estimates.u', 'Изменение смет'),
    ('est.Estimates.d', 'Удаление смет');

-- Разделенные сметы
CREATE TABLE estimate_fission (
  id                   BIGSERIAL PRIMARY KEY,
  estimate_id          BIGINT REFERENCES estimate(id),
  checksum             BIGINT,
  title                VARCHAR(2048),
  cost_code_id         INTEGER REFERENCES cost_kind(id),
  construction_cost    NUMERIC(15,2),
  installation_cost    NUMERIC(15,2),
  equipment_cost       NUMERIC(15,2),
  other_cost           NUMERIC(15,2),
  load_date            TIMESTAMP WITH TIME ZONE NOT NULL
);

COMMENT ON TABLE estimate_fission IS 'Разделенные сметы';

COMMENT ON COLUMN estimate_fission.id IS 'Идентификатор';
COMMENT ON COLUMN estimate_fission.estimate_id IS '-> estimate';
COMMENT ON COLUMN estimate_fission.checksum IS 'Идентификатор источника';
COMMENT ON COLUMN estimate_fission.title IS 'Заголовок сметы';
COMMENT ON COLUMN estimate_fission.cost_code_id IS 'Код вида затрат (МРД)';
COMMENT ON COLUMN estimate_fission.construction_cost IS 'Стоимость строительных работ';
COMMENT ON COLUMN estimate_fission.installation_cost IS 'Стоимость монтажных работ';
COMMENT ON COLUMN estimate_fission.equipment_cost IS 'Стоимость оборудования';
COMMENT ON COLUMN estimate_fission.other_cost IS 'Стоимость прочих работ';
COMMENT ON COLUMN estimate_fission.load_date IS 'Дата загрузки в систему';

-- Связи смет с документами
CREATE TABLE public.estimate_link (
    id             BIGSERIAL PRIMARY KEY,
    estimate_id    BIGINT REFERENCES estimate (id),
    link_type_id   SMALLINT NOT NULL,
    link_id        BIGINT NOT NULL
);

COMMENT ON TABLE public.estimate_link IS 'Смета -> Комплект';

COMMENT ON COLUMN public.estimate_link.id IS 'Идентификатор';
COMMENT ON COLUMN public.estimate_link.estimate_id IS '-> estimate.id';
COMMENT ON COLUMN public.estimate_link.link_type_id IS 'Тип связываемого документа';
COMMENT ON COLUMN public.estimate_link.link_id IS 'Идентификатор связываемого документа';

-- Поток комплексов
CREATE TABLE stream.construction (
    id             bigserial PRIMARY KEY,
    hid            bigint,
    hid_str        varchar(128),
    hid_uuid       uuid,
    stream_status  SMALLINT NOT NULL DEFAULT 0,
    successor_id   bigint,
    code           varchar(16) NOT NULL,
    name           varchar(8192),
    gip            varchar(128),
    object_time    timestamp with time zone,
    insert_time    timestamp with time zone
);

COMMENT ON TABLE stream.construction IS 'Поток комплексов';

COMMENT ON COLUMN stream.construction.id IS 'Идентификатор';
COMMENT ON COLUMN stream.construction.hid IS 'Идентификатор оригинала';
COMMENT ON COLUMN stream.construction.hid_str IS 'Идентификатор оригинала';
COMMENT ON COLUMN stream.construction.hid_uuid IS 'Идентификатор оригинала';
COMMENT ON COLUMN stream.construction.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.construction.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.construction.code IS 'Код комплекса';
COMMENT ON COLUMN stream.construction.name IS 'Наименование';
COMMENT ON COLUMN stream.construction.gip IS 'Ответственный руководитель';
COMMENT ON COLUMN stream.construction.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.construction.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamConstructions.c', 'Создание в потоке комплексов'),
    ('stream.StreamConstructions.r', 'Чтение потока комплексов'),
    ('stream.StreamConstructions.u', 'Изменение в потоке комплексов'),
    ('stream.StreamConstructions.d', 'Удаление из потока комплексов');

-- Поток договоров 

CREATE TABLE stream.contract (
    id              BIGSERIAL PRIMARY KEY,
    hid             BIGINT,
    hid_str         VARCHAR(128),
    hid_uuid        UUID,
    stream_status   SMALLINT DEFAULT 0 NOT NULL,
    successor_id    BIGINT,
    object_time     TIMESTAMP WITH TIME ZONE,
    insert_time     TIMESTAMP WITH TIME ZONE,
    inner_num       TEXT,
    oipks           TEXT,
    contractor_code TEXT,
    contractor_name TEXT,
    contract_num    TEXT,
    contract_year   TEXT,
    contract_date   TEXT,
    name            TEXT NOT NULL,
    contract_status TEXT,
    ius_code        TEXT,
    dev_code        TEXT,
    dev_name        TEXT,
    techdirector    TEXT,
    gip             TEXT,
    date_sign       TEXT,
    work_start      TEXT,
    work_finish     TEXT,
    order_start     TEXT,
    order_finish    TEXT,
    work_types      TEXT 
);

COMMENT ON TABLE stream.contract IS 'Поток договоров';

COMMENT ON COLUMN stream.contract.id IS 'Идентификатор';
COMMENT ON COLUMN stream.contract.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.contract.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.contract.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.contract.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.contract.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.contract.inner_num IS 'Внутренний номер договора';
COMMENT ON COLUMN stream.contract.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.contract.insert_time IS 'Время импорта';
COMMENT ON COLUMN stream.contract.oipks IS 'Код стройки/шифр';
COMMENT ON COLUMN stream.contract.contractor_code IS 'Код заказчика';
COMMENT ON COLUMN stream.contract.contractor_name IS 'Наименование заказчика';
COMMENT ON COLUMN stream.contract.contract_num IS 'Номер договора';
COMMENT ON COLUMN stream.contract.contract_year IS 'Год договора';
COMMENT ON COLUMN stream.contract.contract_date IS 'Дата договора';
COMMENT ON COLUMN stream.contract.name IS 'Наименование';
COMMENT ON COLUMN stream.contract.contract_status IS 'Статус договора (АПБП): не определен, перспективный, проект, подписан, приостановлен, расторгнут, выполнен';
COMMENT ON COLUMN stream.contract.ius_code IS 'Код ИУС (АПБП)';
COMMENT ON COLUMN stream.contract.dev_code IS 'Ответственный филиал: код';
COMMENT ON COLUMN stream.contract.dev_name IS 'Ответственный филиал: наименование';
COMMENT ON COLUMN stream.contract.techdirector IS 'Технический директор';
COMMENT ON COLUMN stream.contract.gip IS 'ГИПы по договору';
COMMENT ON COLUMN stream.contract.date_sign IS 'Дата заключения договора';
COMMENT ON COLUMN stream.contract.work_start IS 'Начало работ по договору';
COMMENT ON COLUMN stream.contract.work_finish IS 'Окончание работ по договору';
COMMENT ON COLUMN stream.contract.order_start IS 'Начало работ по приказу';
COMMENT ON COLUMN stream.contract.order_finish IS 'Окончание работ по приказу';
COMMENT ON COLUMN stream.contract.work_types IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamContracts.c', 'Создание в потоке договоров'),
    ('stream.StreamContracts.r', 'Чтение потока договоров'),
    ('stream.StreamContracts.u', 'Изменение в потоке договоров'),
    ('stream.StreamContracts.d', 'Удаление из потока договоров');

-- Этапы договора
CREATE TABLE stream.contract_stage (
    id BIGSERIAL PRIMARY KEY,
    contractstage_guid VARCHAR(64) NOT NULL,
    contract_guid VARCHAR(64) NOT NULL,
    status VARCHAR(32),
    stage_num VARCHAR(32) NOT NULL,
    name VARCHAR(20),
    plan_start DATE,
    plan_finish VARCHAR(20),
    wait_start DATE,
    wait_finish VARCHAR(20),
    work_types VARCHAR(32)
);

COMMENT ON TABLE stream.contract_stage IS 'Этапы договора';

COMMENT ON COLUMN stream.contract_stage.id IS 'Идентификатор';
COMMENT ON COLUMN stream.contract_stage.contractstage_guid IS 'GUID этапа (АПБП)';
COMMENT ON COLUMN stream.contract_stage.contract_guid IS 'GUID договора, ссылка на договор (АПБП)';
COMMENT ON COLUMN stream.contract_stage.status IS 'Статус этапа (АПБП): не определен, перспективный, проект, подписан, приостановлен, расторгнут, выполнен';
COMMENT ON COLUMN stream.contract_stage.stage_num IS 'Номер этапа';
COMMENT ON COLUMN stream.contract_stage.name IS 'Наименование этапа';
COMMENT ON COLUMN stream.contract_stage.plan_start IS 'План начала работ';
COMMENT ON COLUMN stream.contract_stage.plan_finish IS 'План окончания работ';
COMMENT ON COLUMN stream.contract_stage.wait_start IS 'Ожидание начало работ';
COMMENT ON COLUMN stream.contract_stage.wait_finish IS 'Ожидание окончания работ';
COMMENT ON COLUMN stream.contract_stage.work_types IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.ContractStages.c', 'Создание в потоке этапов'),
    ('stream.ContractStages.r', 'Чтение потока этапов'),
    ('stream.ContractStages.u', 'Изменение в потоке этапов'),
    ('stream.ContractStages.d', 'Удаление из потока этапов');

-- Поток частей комплексов
CREATE TABLE stream.constrpart (
    id             bigserial PRIMARY KEY,
    hid            bigint,
    hid_str        varchar(128),
    hid_uuid       uuid,
    h_ptype        varchar(32),
    hpid           bigint,
    hpid_str       varchar(128),
    hpid_uuid      uuid,
    stream_status  SMALLINT NOT NULL DEFAULT 0,
    successor_id   bigint,
    code           varchar(16) NOT NULL,
    num            varchar(16) NOT NULL,
    name           varchar(8192),
    gip            varchar(128),
    object_time    timestamp with time zone,
    insert_time    timestamp with time zone
);

COMMENT ON TABLE stream.constrpart IS 'Поток частей комплексов';

COMMENT ON COLUMN stream.constrpart.id IS 'Идентификатор';
COMMENT ON COLUMN stream.constrpart.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.constrpart.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.constrpart.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.constrpart.h_ptype IS 'Тип род. объекта';
COMMENT ON COLUMN stream.constrpart.hpid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.constrpart.hpid_str IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.constrpart.hpid_uuid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.constrpart.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.constrpart.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.constrpart.code IS 'Код';
COMMENT ON COLUMN stream.constrpart.num IS 'Номер';
COMMENT ON COLUMN stream.constrpart.name IS 'Наименование';
COMMENT ON COLUMN stream.constrpart.gip IS 'ГИП';
COMMENT ON COLUMN stream.constrpart.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.constrpart.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamConstrParts.c', 'Создание в потоке частей комплексов'),
    ('stream.StreamConstrParts.r', 'Чтение потока частей комплексов'),
    ('stream.StreamConstrParts.u', 'Изменение в потоке частей комплексов'),
    ('stream.StreamConstrParts.d', 'Удаление из потока частей комплексов');

-- Поток сооружений/сетей
CREATE TABLE stream.building (
    id                  bigserial PRIMARY KEY,
    hid                 bigint,
    hid_str             varchar(128),
    hid_uuid            uuid,
    h_ptype             varchar(32),
    hpid                bigint,
    hpid_str            varchar(128),
    hpid_uuid           uuid,
    hcontract_id        bigint,
    hcontract_id_str    varchar(128),
    hcontract_uuid      uuid,
    stream_status       SMALLINT NOT NULL DEFAULT 0,
    successor_id        bigint,
    code                varchar(16) NOT NULL,
    num                 varchar(16) NOT NULL,
    name                varchar(8192),
    gip                 varchar(128),
    object_time         timestamp with time zone,
    insert_time         timestamp with time zone
);

COMMENT ON TABLE stream.building IS 'Поток сооружений';

COMMENT ON COLUMN stream.building.id IS 'Идентификатор';
COMMENT ON COLUMN stream.building.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.building.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.building.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.building.h_ptype IS 'Тип род. объекта';
COMMENT ON COLUMN stream.building.hpid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.building.hpid_str IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.building.hpid_uuid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.building.hcontract_id IS 'ИД договора оригинала';
COMMENT ON COLUMN stream.building.hcontract_id_str IS 'ИД договора оригинала';
COMMENT ON COLUMN stream.building.hcontract_uuid IS 'ИД договора оригинала';
COMMENT ON COLUMN stream.building.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.building.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.building.code IS 'Код';
COMMENT ON COLUMN stream.building.num IS 'Номер';
COMMENT ON COLUMN stream.building.name IS 'Наименование';
COMMENT ON COLUMN stream.building.gip IS 'ГИП';
COMMENT ON COLUMN stream.building.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.building.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamBuildings.c', 'Создание в потоке сооружений'),
    ('stream.StreamBuildings.r', 'Чтение потока сооружений'),
    ('stream.StreamBuildings.u', 'Изменение в потоке сооружений'),
    ('stream.StreamBuildings.d', 'Удаление из потока сооружений');

-- Поток составых документов 
CREATE TABLE stream.docset (
    id             bigserial PRIMARY KEY,
    hid            bigint,
    hid_str        varchar(128),
    hid_uuid       uuid,
    h_ptype        varchar(32),
    hpid           bigint,
    hpid_str       varchar(128),
    hpid_uuid      uuid,
    stream_status  SMALLINT NOT NULL DEFAULT 0,
    successor_id   bigint,
    name           varchar(8192),
    cipher         varchar(128),
    dev_dep        varchar(32),
    oipks          varchar(32),
    ccode          varchar(32),
    num            varchar(32),
    pstage         varchar(32),
    dev_org        varchar(32),
    cpcode         varchar(32),
    cpnum          varchar(32),
    bcode          varchar(32),
    bnum           varchar(32),
    mark           varchar(32),
    mark_path      varchar(32),
    cipher_doc     varchar(32),
    bstage         varchar(32),
    cstage         varchar(32),
    izm_num        varchar(32),
    gip            varchar(128),
    status         varchar(512),
    object_time    timestamp with time zone,
    insert_time    timestamp with time zone
);

COMMENT ON TABLE stream.docset IS 'Поток составных документов';

COMMENT ON COLUMN stream.docset.id IS 'Идентификатор';
COMMENT ON COLUMN stream.docset.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.docset.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.docset.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.docset.h_ptype IS 'Ти род. объекта';
COMMENT ON COLUMN stream.docset.hpid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.docset.hpid_str IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.docset.hpid_uuid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.docset.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.docset.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.docset.name IS 'Наименование';
COMMENT ON COLUMN stream.docset.cipher IS 'Шифр документа (обозначение)';
COMMENT ON COLUMN stream.docset.dev_dep IS 'Код подразделения-исполнителя';
COMMENT ON COLUMN stream.docset.oipks IS '1 - код ОИП КС';
COMMENT ON COLUMN stream.docset.ccode IS '2 - код заказчика';
COMMENT ON COLUMN stream.docset.num IS '3 - номер договора';
COMMENT ON COLUMN stream.docset.pstage IS '4 - стадия';
COMMENT ON COLUMN stream.docset.dev_org IS '5 - субъект разработки';
COMMENT ON COLUMN stream.docset.cpcode IS '6 - код части комплекса';
COMMENT ON COLUMN stream.docset.cpnum IS '7 - номер части комплекса';
COMMENT ON COLUMN stream.docset.bcode IS '8 - код сооружения/сети ';
COMMENT ON COLUMN stream.docset.bnum IS '9 - позиция по генплану';
COMMENT ON COLUMN stream.docset.mark IS '10 - марка основного комплекта';
COMMENT ON COLUMN stream.docset.mark_path IS '11 - номер части марки';
COMMENT ON COLUMN stream.docset.cipher_doc IS '12 - шифр документа';
COMMENT ON COLUMN stream.docset.bstage IS 'Этап строительства по договору';
COMMENT ON COLUMN stream.docset.cstage IS 'Этап по генподрядному договру';
COMMENT ON COLUMN stream.docset.izm_num IS 'Изменение';
COMMENT ON COLUMN stream.docset.gip IS 'Гип';
COMMENT ON COLUMN stream.docset.status IS 'Статус';
COMMENT ON COLUMN stream.docset.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.docset.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamDocsets.c', 'Создание в потоке составных документов'),
    ('stream.StreamDocsets.r', 'Чтение потока составных документов'),
    ('stream.StreamDocsets.u', 'Изменение в потоке составных документов'),
    ('stream.StreamDocsets.d', 'Удаление из потока составных документов');

-- Добавление всех функций в роль 'Super'
INSERT INTO sys.acl_role_function (role_id, function_id)
SELECT
	(SELECT id FROM sys.acl_role WHERE name = 'Super'),
	id
FROM sys.acl_function f1
WHERE NOT EXISTS(
    SELECT 1 FROM sys.acl_role_function rf
    WHERE rf.function_id = f1.id
      and rf.role_id = (SELECT id FROM sys.acl_role WHERE name = 'Super')
)
ORDER BY f1.id;

-- Добавление функций чтения данных в роль 'User'
INSERT INTO sys.acl_role_function (role_id, function_id)
SELECT
	(SELECT id FROM sys.acl_role WHERE name = 'User'),
	id
FROM sys.acl_function f1
WHERE NOT EXISTS(
    SELECT 1 FROM sys.acl_role_function rf
    WHERE rf.function_id = f1.id
      and rf.role_id = (SELECT id FROM sys.acl_role WHERE name = 'User')
)
  AND (f1.name like 'core.%.r')
ORDER BY f1.id;

-- Добавление роли 'Super' к логину 'admin'
INSERT INTO sys.acl_account_role (account_id, role_id)
SELECT
	(SELECT id FROM sys.acl_account WHERE login = 'admin'),
	(SELECT id FROM sys.acl_role WHERE name = 'Super');

