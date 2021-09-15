-- Виды разделов проектной документации
CREATE TABLE core.ref_chaptercode_type (
    id            smallserial PRIMARY KEY,
    short_name    varchar(8) NOT NULL,
    name	  varchar(256) NOT NULL
);

COMMENT ON TABLE core.ref_chaptercode_type IS 'Виды разделов ПД';

COMMENT ON COLUMN core.ref_chaptercode_type.id IS 'Индентификатр';
COMMENT ON COLUMN core.ref_chaptercode_type.short_name IS 'Обозначение';
COMMENT ON COLUMN core.ref_chaptercode_type.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefChapterCodeTypes.c', 'Создание классификатора видов разделов ПД'),
    ('core.RefChapterCodeTypes.r', 'Чтение классификаторов видов разделов ПД'),
    ('core.RefChapterCodeTypes.u', 'Изменение классификатора видов разделов ПД'),
    ('core.RefChapterCodeTypes.d', 'Удаление классификатора видов разделов ПД');

