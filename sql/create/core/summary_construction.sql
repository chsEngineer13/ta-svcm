-- DashBoard для Комплексов: отображает кол-во комплектов по каждому Комплексу
-- Для обновления данных - вызвать REFRESH MATERIALIZED VIEW core.summary_construction
CREATE MATERIALIZED VIEW core.summary_construction (
    id,
    cobject_id,
    code,
    name,
    cnt_id,
    cnt_datestart,
    cnt_datefinish,
    cnt_invoicenum)
AS
SELECT c.id,
    co1.id AS cobject_id,
    c.code,
    c.name,
    count(ds.id) AS cnt_id,
    count(ds.datestart) AS cnt_datestart,
    count(ds.datefinish) AS cnt_datefinish,
    count(ds.invoice_num) AS cnt_invoicenum
FROM core.construction c
     JOIN core.cobject co1 ON co1.construction_id = c.id
     JOIN core.cobject_type cot ON cot.id = co1.cobject_type_id AND
         cot.name::text = 'CONSTR'::text
     JOIN core.cobject co2 ON co2.construction_id = c.id
     LEFT JOIN core.docset ds ON ds.cobject_id = co2.id
GROUP BY c.id, co1.id, c.code, c.name
ORDER BY c.code, c.name;

COMMENT ON MATERIALIZED VIEW core.summary_construction IS 'Обобщенные данные по комплектам(DocSet) для Constructions';

COMMENT ON COLUMN core.summary_construction.code IS 'Код комплекса';
COMMENT ON COLUMN core.summary_construction.id IS 'Идентификатор (construction_id)';
COMMENT ON COLUMN core.summary_construction.cobject_id IS 'Идентификатор (CObject_id)';
COMMENT ON COLUMN core.summary_construction.name IS 'Наименование комплекса';
COMMENT ON COLUMN core.summary_construction.cnt_id IS 'Кол-во комплектов комплекса';
COMMENT ON COLUMN core.summary_construction.cnt_datestart IS 'Кол-во комплектов, у которых есть дата начала';
COMMENT ON COLUMN core.summary_construction.cnt_datefinish IS 'Кол-во комплектов, у которых есть дата окончания';
COMMENT ON COLUMN core.summary_construction.cnt_invoicenum IS 'Кол-во комплектов, у которых есть № накладной';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.SummaryConstructions.r', 'Чтение данных комплектов для Комплексов');

