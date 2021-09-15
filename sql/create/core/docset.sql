-- Комплекты
CREATE TABLE core.docset (
    id               bigserial PRIMARY KEY,
    cobject_id       bigint  REFERENCES core.cobject(id),
    settype          varchar(10),
    cipher           varchar(50) NOT NULL,
    mark_ref_id      integer REFERENCES core.ref_mark(id),
    name             varchar(2048) NOT NULL,
    datestart        date,
    datefinish       date,
    invoice_num      varchar(100),
    invoice_date     date,
    ds_type_id       SMALLINT REFERENCES core.ds_type(id)
);

COMMENT ON TABLE core.docset IS 'Комплекты';

COMMENT ON COLUMN core.docset.id IS 'Идентификатор';
COMMENT ON COLUMN core.docset.cobject_id IS '-> cobject';
COMMENT ON COLUMN core.docset.settype IS 'Тип комплекта (ОТ, ВТ)';
COMMENT ON COLUMN core.docset.cipher IS 'Обозначение комплекта';
COMMENT ON COLUMN core.docset.mark_ref_id IS '-> mark_ref';
COMMENT ON COLUMN core.docset.name IS 'Наименование';
COMMENT ON COLUMN core.docset.datestart IS 'Дата начала';
COMMENT ON COLUMN core.docset.datefinish IS 'Дата окончания';
COMMENT ON COLUMN core.docset.invoice_num IS '№ накладной';
COMMENT ON COLUMN core.docset.invoice_date IS 'Дата накладной';
COMMENT ON COLUMN core.docset.ds_type_id IS '-> ds_type';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.Docsets.c', 'Создание комплекта')
    ,('core.Docsets.r', 'Чтение комплектов')
    ,('core.Docsets.u', 'Изменение комплекта')
    ,('core.Docsets.d', 'Удаление комплекта')
    ,('core.Docsets.l', 'Создание/удаление записи в связанной таблице')
;

