-- Стадии проектирования
CREATE TABLE core.ref_phase (
    id      smallserial PRIMARY KEY,
    code    varchar(16) NOT NULL,
    name    varchar(128)
);

COMMENT ON TABLE core.ref_phase IS 'Стадии проектирования';

COMMENT ON COLUMN core.ref_phase.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_phase.code IS 'Буквенный код';
COMMENT ON COLUMN core.ref_phase.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefPhases.c', 'Создание классификатора стадий проектирования'),
    ('core.RefPhases.r', 'Чтение классификаторов стадий проектирования'),
    ('core.RefPhases.u', 'Изменение классификатора стадий проектирования'),
    ('core.RefPhases.d', 'Удаление классификатора стадий проектирования');

