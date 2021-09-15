-- Этапы договора
CREATE TABLE core.contract_stages (
  id BIGSERIAL PRIMARY KEY,
  contract_id INTEGER REFERENCES core.contract(id),
  status VARCHAR(50) DEFAULT 'не определен'::character varying NOT NULL,
  stage_num VARCHAR(20) NOT NULL,
  name TEXT,
  plan_start DATE,
  plan_finish DATE,
  worktypes TEXT
);

COMMENT ON TABLE core.contract_stages IS 'Этапы договора';

COMMENT ON COLUMN core.contract_stages.id IS 'Иденитификатор';
COMMENT ON COLUMN core.contract_stages.contract_id IS '-> core.contract';
COMMENT ON COLUMN core.contract_stages.status IS 'Статус: не определен / перспективный / проект / подписан / приостановлен / расторгнут / выполнен';
COMMENT ON COLUMN core.contract_stages.stage_num IS '№ этапа';
COMMENT ON COLUMN core.contract_stages.name IS 'Наименование этапа';
COMMENT ON COLUMN core.contract_stages.plan_start IS 'Начало работ по плану';
COMMENT ON COLUMN core.contract_stages.plan_finish IS 'Окончание работ по плану';
COMMENT ON COLUMN core.contract_stages.worktypes IS 'Виды работ';

INSERT INTO sys.acl_function(name, descr) VALUES
     ('core.ContractStages.c', 'Создание этапа договора')
    ,('core.ContractStages.r', 'Чтение этапов договора')
    ,('core.ContractStages.u', 'Изменение этапа договора')
    ,('core.ContractStages.d', 'Удаление этапа договора')
    ,('core.ContractStages.l', 'Создание/удаление записи в связанной таблице')
;

