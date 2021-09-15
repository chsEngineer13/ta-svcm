-- Поток договоров 

CREATE TABLE stream.contract (
    id              BIGSERIAL PRIMARY KEY,
    hid             BIGINT,
    hid_str         VARCHAR(128),
    hid_uuid        UUID,
    stream_status   SMALLINT DEFAULT 0 NOT NULL,
    successor_id    BIGINT,
    object_time     TIMESTAMP WITH TIME ZONE,
    insert_time     TIMESTAMP WITH TIME ZONE,
    inner_num       TEXT,
    oipks           TEXT,
    contractor_code TEXT,
    contractor_name TEXT,
    contract_num    TEXT,
    contract_year   TEXT,
    contract_date   TEXT,
    name            TEXT NOT NULL,
    contract_status TEXT,
    ius_code        TEXT,
    dev_code        TEXT,
    dev_name        TEXT,
    techdirector    TEXT,
    gip             TEXT,
    date_sign       TEXT,
    work_start      TEXT,
    work_finish     TEXT,
    order_start     TEXT,
    order_finish    TEXT,
    work_types      TEXT 
);

COMMENT ON TABLE stream.contract IS 'Поток договоров';

COMMENT ON COLUMN stream.contract.id IS 'Идентификатор';
COMMENT ON COLUMN stream.contract.hid IS 'ИД оригинала';
COMMENT ON COLUMN stream.contract.hid_str IS 'ИД оригинала';
COMMENT ON COLUMN stream.contract.hid_uuid IS 'ИД оригинала';
COMMENT ON COLUMN stream.contract.stream_status IS 'Статус обработки';
COMMENT ON COLUMN stream.contract.successor_id IS 'ИД записи-наследника';
COMMENT ON COLUMN stream.contract.inner_num IS 'Внутренний номер договора';
COMMENT ON COLUMN stream.contract.object_time IS 'Время изменения оригинала';
COMMENT ON COLUMN stream.contract.insert_time IS 'Время импорта';
COMMENT ON COLUMN stream.contract.oipks IS 'Код стройки/шифр';
COMMENT ON COLUMN stream.contract.contractor_code IS 'Код заказчика';
COMMENT ON COLUMN stream.contract.contractor_name IS 'Наименование заказчика';
COMMENT ON COLUMN stream.contract.contract_num IS 'Номер договора';
COMMENT ON COLUMN stream.contract.contract_year IS 'Год договора';
COMMENT ON COLUMN stream.contract.contract_date IS 'Дата договора';
COMMENT ON COLUMN stream.contract.name IS 'Наименование';
COMMENT ON COLUMN stream.contract.contract_status IS 'Статус договора (АПБП): не определен, перспективный, проект, подписан, приостановлен, расторгнут, выполнен';
COMMENT ON COLUMN stream.contract.ius_code IS 'Код ИУС (АПБП)';
COMMENT ON COLUMN stream.contract.dev_code IS 'Ответственный филиал: код';
COMMENT ON COLUMN stream.contract.dev_name IS 'Ответственный филиал: наименование';
COMMENT ON COLUMN stream.contract.techdirector IS 'Технический директор';
COMMENT ON COLUMN stream.contract.gip IS 'ГИПы по договору';
COMMENT ON COLUMN stream.contract.date_sign IS 'Дата заключения договора';
COMMENT ON COLUMN stream.contract.work_start IS 'Начало работ по договору';
COMMENT ON COLUMN stream.contract.work_finish IS 'Окончание работ по договору';
COMMENT ON COLUMN stream.contract.order_start IS 'Начало работ по приказу';
COMMENT ON COLUMN stream.contract.order_finish IS 'Окончание работ по приказу';
COMMENT ON COLUMN stream.contract.work_types IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.StreamContracts.c', 'Создание в потоке договоров'),
    ('stream.StreamContracts.r', 'Чтение потока договоров'),
    ('stream.StreamContracts.u', 'Изменение в потоке договоров'),
    ('stream.StreamContracts.d', 'Удаление из потока договоров');

