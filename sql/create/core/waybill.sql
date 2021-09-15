-- Список транспортных накладных
CREATE TABLE core.waybill (
  id BIGSERIAL PRIMARY KEY,
  waybill_num VARCHAR(100) NOT NULL,
  waybill_date DATE NOT NULL,
  descr core.d_description
);

COMMENT ON TABLE core.waybill IS 'Список транспортных накладных';

COMMENT ON COLUMN core.waybill.id IS 'Идентификатор';
COMMENT ON COLUMN core.waybill.waybill_num IS 'Номер накладной';
COMMENT ON COLUMN core.waybill.waybill_date IS 'Дата накладной';
COMMENT ON COLUMN core.waybill.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.Waybills.c', 'Создание накладной'),
    ('core.Waybills.r', 'Чтение накладных'),
    ('core.Waybills.u', 'Изменение накладной'),
    ('core.Waybills.d', 'Удаление накладной');

