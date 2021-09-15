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

