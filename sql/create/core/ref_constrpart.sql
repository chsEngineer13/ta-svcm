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

