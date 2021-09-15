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

