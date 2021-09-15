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

