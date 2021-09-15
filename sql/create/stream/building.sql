-- Поток сооружений/сетей
CREATE TABLE stream.building (
    id                  bigserial PRIMARY KEY,
    hid                 bigint,
    hid_str             varchar(128),
    hid_uuid            uuid,
    h_ptype             varchar(32),
    hpid                bigint,
    hpid_str            varchar(128),
    hpid_uuid           uuid,
    hcontract_id        bigint,
    hcontract_id_str    varchar(128),
    hcontract_uuid      uuid,
    stream_status       SMALLINT NOT NULL DEFAULT 0,
    successor_id        bigint,
    code                varchar(16) NOT NULL,
    num                 varchar(16) NOT NULL,
    name                varchar(8192),
    gip                 varchar(128),
    object_time         timestamp with time zone,
    insert_time         timestamp with time zone
);

COMMENT ON TABLE stream.building IS 'Поток сооружений';

COMMENT ON COLUMN stream.building.id IS 'Идентификатор';
COMMENT ON COLUMN stream.building.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.building.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.building.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.building.h_ptype IS 'Тип род. объекта';
COMMENT ON COLUMN stream.building.hpid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.building.hpid_str IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.building.hpid_uuid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.building.hcontract_id IS 'ИД договора оригинала';
COMMENT ON COLUMN stream.building.hcontract_id_str IS 'ИД договора оригинала';
COMMENT ON COLUMN stream.building.hcontract_uuid IS 'ИД договора оригинала';
COMMENT ON COLUMN stream.building.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.building.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.building.code IS 'Код';
COMMENT ON COLUMN stream.building.num IS 'Номер';
COMMENT ON COLUMN stream.building.name IS 'Наименование';
COMMENT ON COLUMN stream.building.gip IS 'ГИП';
COMMENT ON COLUMN stream.building.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.building.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamBuildings.c', 'Создание в потоке сооружений'),
    ('stream.StreamBuildings.r', 'Чтение потока сооружений'),
    ('stream.StreamBuildings.u', 'Изменение в потоке сооружений'),
    ('stream.StreamBuildings.d', 'Удаление из потока сооружений');

