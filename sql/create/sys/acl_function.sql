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

