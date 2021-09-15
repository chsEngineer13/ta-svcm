-- Поток комплексов
CREATE TABLE stream.construction (
    id             bigserial PRIMARY KEY,
    hid            bigint,
    hid_str        varchar(128),
    hid_uuid       uuid,
    stream_status  SMALLINT NOT NULL DEFAULT 0,
    successor_id   bigint,
    code           varchar(16) NOT NULL,
    name           varchar(8192),
    gip            varchar(128),
    object_time    timestamp with time zone,
    insert_time    timestamp with time zone
);

COMMENT ON TABLE stream.construction IS 'Поток комплексов';

COMMENT ON COLUMN stream.construction.id IS 'Идентификатор';
COMMENT ON COLUMN stream.construction.hid IS 'Идентификатор оригинала';
COMMENT ON COLUMN stream.construction.hid_str IS 'Идентификатор оригинала';
COMMENT ON COLUMN stream.construction.hid_uuid IS 'Идентификатор оригинала';
COMMENT ON COLUMN stream.construction.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.construction.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.construction.code IS 'Код комплекса';
COMMENT ON COLUMN stream.construction.name IS 'Наименование';
COMMENT ON COLUMN stream.construction.gip IS 'Ответственный руководитель';
COMMENT ON COLUMN stream.construction.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.construction.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamConstructions.c', 'Создание в потоке комплексов'),
    ('stream.StreamConstructions.r', 'Чтение потока комплексов'),
    ('stream.StreamConstructions.u', 'Изменение в потоке комплексов'),
    ('stream.StreamConstructions.d', 'Удаление из потока комплексов');

