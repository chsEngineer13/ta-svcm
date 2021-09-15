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

