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

