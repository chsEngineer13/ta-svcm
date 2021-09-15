-- Классификатор шифров прилагаемых документов
CREATE TABLE core.ref_doccode (
    id              serial PRIMARY KEY,
    code            varchar(16) NOT NULL,
    name            varchar(256),
    additional      BOOLEAN DEFAULT FALSE NOT NULL,
    numeric_part    BOOLEAN DEFAULT FALSE NOT NULL
);

COMMENT ON TABLE core.ref_doccode IS 'Классификатор шифров прилагаемых документов';

COMMENT ON COLUMN core.ref_doccode.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_doccode.code IS 'Шифр';
COMMENT ON COLUMN core.ref_doccode.name IS 'Наименование';
COMMENT ON COLUMN core.ref_doccode.additional IS 'Являтся дополнительным';
COMMENT ON COLUMN core.ref_doccode.numeric_part IS 'Может подразделяться на номерные группы';

INSERT INTO sys.acl_function(name, descr) VALUES 
    ('core.RefDocCodes.c', 'Создание классификатора шифров прилагаемых документов'),
    ('core.RefDocCodes.r', 'Чтение классификаторов шифров прилагаемых документов'),
    ('core.RefDocCodes.u', 'Изменение классификатора шифров прилагаемых документов'),
    ('core.RefDocCodes.d', 'Удаление классификатора шифров прилагаемых документов');

