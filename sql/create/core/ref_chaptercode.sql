--  Разделы проектной документации
CREATE TABLE core.ref_chaptercode (
    id                    serial PRIMARY KEY,
    chaptercodetype_id    smallint REFERENCES core.ref_chaptercode_type (id),
    chapter               smallint,
    subchapter            smallint,
    code                  varchar(16) NOT NULL,
    name                  varchar(2048)
);

COMMENT ON TABLE core.ref_chaptercode IS 'Разделы проектной документации';

COMMENT ON COLUMN core.ref_chaptercode.chaptercodetype_id IS '-> chaptercode_type';
COMMENT ON COLUMN core.ref_chaptercode.chapter IS 'Номер раздела';
COMMENT ON COLUMN core.ref_chaptercode.subchapter IS 'Номер подраздела';
COMMENT ON COLUMN core.ref_chaptercode.code IS 'Шифр';
COMMENT ON COLUMN core.ref_chaptercode.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefChapterCodes.c', 'Создание классификатора разделов ПД'),
    ('core.RefChapterCodes.r', 'Чтение классификаторов разделов ПД'),
    ('core.RefChapterCodes.u', 'Изменение классификатора разделов ПД'),
    ('core.RefChapterCodes.d', 'Удаление классификатора разделов ПД');

