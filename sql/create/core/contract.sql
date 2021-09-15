-- Договор
CREATE TABLE core.contract (
    id              SERIAL PRIMARY KEY,
    construction_id SMALLINT REFERENCES core.construction(id),
    oipks           VARCHAR(16),
    contractor_id   INT REFERENCES core.ref_contractor(id),
    developer_id    INT REFERENCES core.ref_developer(id),
    inner_num       VARCHAR(128),
    contract_num    VARCHAR(128) NOT NULL,
    title           VARCHAR(8192) NOT NULL,
    contract_date   DATE,
    contract_status VARCHAR(32),
    techdirector    VARCHAR(32),
    gip             VARCHAR(128),
    date_sign       DATE,
    work_start      DATE,
    work_finish     DATE,
    order_start     DATE,
    order_finish    DATE,
    work_types      VARCHAR(32)
);

COMMENT ON TABLE core.contract IS 'Договор';

COMMENT ON COLUMN core.contract.id IS 'Идентификатор';
COMMENT ON COLUMN core.contract.construction_id IS '-> construction';
COMMENT ON COLUMN core.contract.oipks IS 'Код ОИП КС';
COMMENT ON COLUMN core.contract.contractor_id IS '-> ref_contractor';
COMMENT ON COLUMN core.contract.developer_id IS '-> ref_developer';
COMMENT ON COLUMN core.contract.inner_num IS 'Внутренний номер договора';
COMMENT ON COLUMN core.contract.contract_num IS 'Номер договора';
COMMENT ON COLUMN core.contract.title IS 'Предмет договора';
COMMENT ON COLUMN core.contract.contract_date IS 'Дата договора';
COMMENT ON COLUMN core.contract.contract_status IS 'Статус договора';
COMMENT ON COLUMN core.contract.techdirector IS 'Технический директор';
COMMENT ON COLUMN core.contract.gip IS 'ГИПы по договору';
COMMENT ON COLUMN core.contract.date_sign IS 'Дата заключения договора';
COMMENT ON COLUMN core.contract.work_start IS 'Начало работ по договору';
COMMENT ON COLUMN core.contract.work_finish IS 'Окончание работ по договору';
COMMENT ON COLUMN core.contract.order_start IS 'Начало работ по приказу';
COMMENT ON COLUMN core.contract.order_finish IS 'Окончание работ по приказу';
COMMENT ON COLUMN core.contract.work_types IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
     ('core.Contracts.c', 'Создание договора')
    ,('core.Contracts.r', 'Чтение договоров')
    ,('core.Contracts.u', 'Изменение договора')
    ,('core.Contracts.d', 'Удаление договора')
    ,('core.Contracts.l', 'Создание/удаление записи в связанной таблице')
;

