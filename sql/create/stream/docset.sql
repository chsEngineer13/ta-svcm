-- Поток составых документов 
CREATE TABLE stream.docset (
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
    name           varchar(8192),
    cipher         varchar(128),
    dev_dep        varchar(32),
    oipks          varchar(32),
    ccode          varchar(32),
    num            varchar(32),
    pstage         varchar(32),
    dev_org        varchar(32),
    cpcode         varchar(32),
    cpnum          varchar(32),
    bcode          varchar(32),
    bnum           varchar(32),
    mark           varchar(32),
    mark_path      varchar(32),
    cipher_doc     varchar(32),
    bstage         varchar(32),
    cstage         varchar(32),
    izm_num        varchar(32),
    gip            varchar(128),
    status         varchar(512),
    object_time    timestamp with time zone,
    insert_time    timestamp with time zone
);

COMMENT ON TABLE stream.docset IS 'Поток составных документов';

COMMENT ON COLUMN stream.docset.id IS 'Идентификатор';
COMMENT ON COLUMN stream.docset.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.docset.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.docset.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.docset.h_ptype IS 'Ти род. объекта';
COMMENT ON COLUMN stream.docset.hpid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.docset.hpid_str IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.docset.hpid_uuid IS 'ИД род. объекта оригинала';
COMMENT ON COLUMN stream.docset.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.docset.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.docset.name IS 'Наименование';
COMMENT ON COLUMN stream.docset.cipher IS 'Шифр документа (обозначение)';
COMMENT ON COLUMN stream.docset.dev_dep IS 'Код подразделения-исполнителя';
COMMENT ON COLUMN stream.docset.oipks IS '1 - код ОИП КС';
COMMENT ON COLUMN stream.docset.ccode IS '2 - код заказчика';
COMMENT ON COLUMN stream.docset.num IS '3 - номер договора';
COMMENT ON COLUMN stream.docset.pstage IS '4 - стадия';
COMMENT ON COLUMN stream.docset.dev_org IS '5 - субъект разработки';
COMMENT ON COLUMN stream.docset.cpcode IS '6 - код части комплекса';
COMMENT ON COLUMN stream.docset.cpnum IS '7 - номер части комплекса';
COMMENT ON COLUMN stream.docset.bcode IS '8 - код сооружения/сети ';
COMMENT ON COLUMN stream.docset.bnum IS '9 - позиция по генплану';
COMMENT ON COLUMN stream.docset.mark IS '10 - марка основного комплекта';
COMMENT ON COLUMN stream.docset.mark_path IS '11 - номер части марки';
COMMENT ON COLUMN stream.docset.cipher_doc IS '12 - шифр документа';
COMMENT ON COLUMN stream.docset.bstage IS 'Этап строительства по договору';
COMMENT ON COLUMN stream.docset.cstage IS 'Этап по генподрядному договру';
COMMENT ON COLUMN stream.docset.izm_num IS 'Изменение';
COMMENT ON COLUMN stream.docset.gip IS 'Гип';
COMMENT ON COLUMN stream.docset.status IS 'Статус';
COMMENT ON COLUMN stream.docset.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.docset.insert_time IS 'Время импорта';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamDocsets.c', 'Создание в потоке составных документов'),
    ('stream.StreamDocsets.r', 'Чтение потока составных документов'),
    ('stream.StreamDocsets.u', 'Изменение в потоке составных документов'),
    ('stream.StreamDocsets.d', 'Удаление из потока составных документов');

