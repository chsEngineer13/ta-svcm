-- Этапы договора
CREATE TABLE stream.contract_stage (
    id BIGSERIAL PRIMARY KEY,
    contractstage_guid VARCHAR(64) NOT NULL,
    contract_guid VARCHAR(64) NOT NULL,
    status VARCHAR(32),
    stage_num VARCHAR(32) NOT NULL,
    name VARCHAR(20),
    plan_start DATE,
    plan_finish VARCHAR(20),
    wait_start DATE,
    wait_finish VARCHAR(20),
    work_types VARCHAR(32)
);

COMMENT ON TABLE stream.contract_stage IS 'Этапы договора';

COMMENT ON COLUMN stream.contract_stage.id IS 'Идентификатор';
COMMENT ON COLUMN stream.contract_stage.contractstage_guid IS 'GUID этапа (АПБП)';
COMMENT ON COLUMN stream.contract_stage.contract_guid IS 'GUID договора, ссылка на договор (АПБП)';
COMMENT ON COLUMN stream.contract_stage.status IS 'Статус этапа (АПБП): не определен, перспективный, проект, подписан, приостановлен, расторгнут, выполнен';
COMMENT ON COLUMN stream.contract_stage.stage_num IS 'Номер этапа';
COMMENT ON COLUMN stream.contract_stage.name IS 'Наименование этапа';
COMMENT ON COLUMN stream.contract_stage.plan_start IS 'План начала работ';
COMMENT ON COLUMN stream.contract_stage.plan_finish IS 'План окончания работ';
COMMENT ON COLUMN stream.contract_stage.wait_start IS 'Ожидание начало работ';
COMMENT ON COLUMN stream.contract_stage.wait_finish IS 'Ожидание окончания работ';
COMMENT ON COLUMN stream.contract_stage.work_types IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('stream.ContractStages.c', 'Создание в потоке этапов'),
    ('stream.ContractStages.r', 'Чтение потока этапов'),
    ('stream.ContractStages.u', 'Изменение в потоке этапов'),
    ('stream.ContractStages.d', 'Удаление из потока этапов');

