-- Детализация составного документа - Комплект
CREATE TABLE core.ds_bsd (
    id             BIGSERIAL PRIMARY KEY,
    docset_id      BIGINT NOT NULL REFERENCES core.docset(id),
    name           TEXT NOT NULL,
    cipher         VARCHAR(128) NOT NULL,
    dev_dep        VARCHAR(32),
    oipks_id       SMALLINT REFERENCES core.construction(id),
    contractor_id  INTEGER REFERENCES core.ref_contractor(id),
    contract_id    INTEGER REFERENCES core.contract(id),
    phase_id       SMALLINT REFERENCES core.ref_phase(id),
    phase_num      VARCHAR(32),
    developer_id   INTEGER REFERENCES core.ref_developer(id),
    constrpart_id  INTEGER REFERENCES core.ref_constrpart(id),
    constrpart_num VARCHAR(4),
    building_id    INTEGER REFERENCES core.ref_building(id),
    building_num   VARCHAR(3),
    mark_id        INTEGER REFERENCES core.ref_mark(id),
    mark_path      VARCHAR(3),
    cipher_doc     VARCHAR(3),
    cstage         VARCHAR(32),
    izm_num        SMALLINT DEFAULT 0,
    gip            VARCHAR(128),
    status         TEXT,
    object_time    TIMESTAMP WITH TIME ZONE
);

COMMENT ON TABLE core.ds_bsd IS 'Детализация составного документа - Комплект';

COMMENT ON COLUMN core.ds_bsd.id IS 'Идентификатор';
COMMENT ON COLUMN core.ds_bsd.docset_id IS '-> docset';
COMMENT ON COLUMN core.ds_bsd.name IS 'Наименование';
COMMENT ON COLUMN core.ds_bsd.cipher IS 'Шифр документа (обозначение)';
COMMENT ON COLUMN core.ds_bsd.dev_dep IS 'Код подразделения-исполнителя';
COMMENT ON COLUMN core.ds_bsd.oipks_id IS '1 - код ОИП КС -> core.construction';
COMMENT ON COLUMN core.ds_bsd.contractor_id IS '2 - код заказчика -> core.ref_contractor';
COMMENT ON COLUMN core.ds_bsd.contract_id IS '3 - договор -> core.contract';
COMMENT ON COLUMN core.ds_bsd.phase_id IS '4 - стадия -> core.ref_phase';
COMMENT ON COLUMN core.ds_bsd.phase_num IS '4 - уточнение: этапы/стадии договора может быть 1/1-3, т.е. этап 1 подэтапы 1-3';
COMMENT ON COLUMN core.ds_bsd.developer_id IS '5 - субъект разработки -> core.ref_developer';
COMMENT ON COLUMN core.ds_bsd.constrpart_id IS '6 - часть комплекса -> core.ref_constrpart';
COMMENT ON COLUMN core.ds_bsd.constrpart_num IS '7 - номер части комплекса';
COMMENT ON COLUMN core.ds_bsd.building_id IS '8 - здание/сооружение/сеть -> core.ref_building';
COMMENT ON COLUMN core.ds_bsd.building_num IS '9 - позиция здания/сооружения/сети по генплану';
COMMENT ON COLUMN core.ds_bsd.mark_id IS '10 - марка основного комплекта -> core.ref_mark';
COMMENT ON COLUMN core.ds_bsd.mark_path IS '11 - номер части марки';
COMMENT ON COLUMN core.ds_bsd.cipher_doc IS '12 - шифр документа';
COMMENT ON COLUMN core.ds_bsd.cstage IS 'Этап по генподрядному договру';
COMMENT ON COLUMN core.ds_bsd.izm_num IS '№ изменения';
COMMENT ON COLUMN core.ds_bsd.gip IS 'ГИП';
COMMENT ON COLUMN core.ds_bsd.status IS 'Статус';
COMMENT ON COLUMN core.ds_bsd.object_time IS 'Время изменения оригинала';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.DSBSDs.c', 'Создание Комплекта в составном документе'),
    ('core.DSBSDs.r', 'Чтение Комплектов в составном документе'),
    ('core.DSBSDs.u', 'Изменение Комплекта в составном документе'),
    ('core.DSBSDs.d', 'Удаление Комплекта из составного документа');

