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

