-- Поток частей комплексов
CREATE TABLE stream.constrpart (
    id             bigserial PRIMARY KEY,
    hid            bigint,
    hid_str        varchar(128),
    hid_uuid       uuid,
    h_ptype        varchar(32),
    hpid           bigint,
    hpid_str       varchar(128),
    hpid_uuid      uuid,
    stream_status  SMALLINT NOT NULL DEFAULT 0,
    successor_id   bigint,
    code           varchar(16) NOT NULL,
    num            varchar(16) NOT NULL,
    name           varchar(8192),
    gip            varchar(128),
    object_time    timestamp with time zone,
    insert_time    timestamp with time zone
);

COMMENT ON TABLE stream.constrpart IS 'Поток частей комплексов';

COMMENT ON COLUMN stream.constrpart.id IS 'Идентификатор';
COMMENT ON COLUMN stream.constrpart.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.constrpart.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.constrpart.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.constrpart.h_ptype IS 'Тип род. объекта';
COMMENT ON COLUMN stream.constrpart.hpid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.constrpart.hpid_str IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.constrpart.hpid_uuid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.constrpart.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.constrpart.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.constrpart.code IS 'Код';
COMMENT ON COLUMN stream.constrpart.num IS 'Номер';
COMMENT ON COLUMN stream.constrpart.name IS 'Наименование';
COMMENT ON COLUMN stream.constrpart.gip IS 'ГИП';
COMMENT ON COLUMN stream.constrpart.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.constrpart.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamConstrParts.c', 'Создание в потоке частей комплексов'),
    ('stream.StreamConstrParts.r', 'Чтение потока частей комплексов'),
    ('stream.StreamConstrParts.u', 'Изменение в потоке частей комплексов'),
    ('stream.StreamConstrParts.d', 'Удаление из потока частей комплексов');

