-- Классификатор марок основных комплектов рабочих чертежей
CREATE TABLE core.ref_mark (
    id            serial PRIMARY KEY,
    code          varchar(16) NOT NULL,
    name          varchar(2048),
    comment       varchar(2048),
    additional    BOOLEAN DEFAULT FALSE NOT NULL
);

COMMENT ON TABLE core.ref_mark IS 'Классификатор марок основных комплектов рабочих чертежей';

COMMENT ON COLUMN core.ref_mark.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_mark.code IS 'Шифр';
COMMENT ON COLUMN core.ref_mark.name IS 'Наименование';
COMMENT ON COLUMN core.ref_mark.comment IS 'Примечание';
COMMENT ON COLUMN core.ref_mark.additional IS 'Являтся дополнительным';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefMarks.c', 'Создание классификатора марок комплектов рабочих чертежей'),
    ('core.RefMarks.r', 'Чтение классификаторов марок комплектов рабочих чертежей'),
    ('core.RefMarks.u', 'Изменение классификатора марок комплектов рабочих чертежей'),
    ('core.RefMarks.d', 'Удаление классификатора марок комплектов рабочих чертежей'),
	('core.RefMarks.l', 'Создание/удаление записи в связанной таблице')
;

