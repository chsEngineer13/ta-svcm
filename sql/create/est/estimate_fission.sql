-- Разделенные сметы
CREATE TABLE estimate_fission (
  id                   BIGSERIAL PRIMARY KEY,
  estimate_id          BIGINT REFERENCES estimate(id),
  checksum             BIGINT,
  title                VARCHAR(2048),
  cost_code_id         INTEGER REFERENCES cost_kind(id),
  construction_cost    NUMERIC(15,2),
  installation_cost    NUMERIC(15,2),
  equipment_cost       NUMERIC(15,2),
  other_cost           NUMERIC(15,2),
  load_date            TIMESTAMP WITH TIME ZONE NOT NULL
);

COMMENT ON TABLE estimate_fission IS 'Разделенные сметы';

COMMENT ON COLUMN estimate_fission.id IS 'Идентификатор';
COMMENT ON COLUMN estimate_fission.estimate_id IS '-> estimate';
COMMENT ON COLUMN estimate_fission.checksum IS 'Идентификатор источника';
COMMENT ON COLUMN estimate_fission.title IS 'Заголовок сметы';
COMMENT ON COLUMN estimate_fission.cost_code_id IS 'Код вида затрат (МРД)';
COMMENT ON COLUMN estimate_fission.construction_cost IS 'Стоимость строительных работ';
COMMENT ON COLUMN estimate_fission.installation_cost IS 'Стоимость монтажных работ';
COMMENT ON COLUMN estimate_fission.equipment_cost IS 'Стоимость оборудования';
COMMENT ON COLUMN estimate_fission.other_cost IS 'Стоимость прочих работ';
COMMENT ON COLUMN estimate_fission.load_date IS 'Дата загрузки в систему';

