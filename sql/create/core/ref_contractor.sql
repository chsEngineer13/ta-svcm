-- Контрагенты
CREATE TABLE core.ref_contractor (
    id               serial PRIMARY KEY,
    name	     varchar(256) NOT NULL,
    customer_code    varchar(16)
);

COMMENT ON TABLE core.ref_contractor IS 'Контрагенты';

COMMENT ON COLUMN core.ref_contractor.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_contractor.name IS 'Наименование';
COMMENT ON COLUMN core.ref_contractor.customer_code IS 'Код заказчика';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefContractors.c', 'Создание контрагента'),
    ('core.RefContractors.r', 'Чтение контрагентов'),
    ('core.RefContractors.u', 'Изменение контрагента'),
    ('core.RefContractors.d', 'Удаление контрагента');

