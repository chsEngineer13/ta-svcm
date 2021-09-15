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

