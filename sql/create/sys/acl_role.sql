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

