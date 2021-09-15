-- Объекты проектирования
CREATE TABLE core.cobject (
    id                 bigserial PRIMARY KEY,
    parent_id 	       bigint REFERENCES core.cobject (id),
    construction_id    smallint REFERENCES core.construction (id),
    cobject_type_id    smallint NOT NULL REFERENCES core.cobject_type (id),
    code 	       varchar(32),
    number 	       varchar(32),
    descr 	       varchar(8192)
);

COMMENT ON TABLE core.cobject IS 'Объекты проектирования';

COMMENT ON COLUMN core.cobject.id IS 'Индентификатр';
COMMENT ON COLUMN core.cobject.parent_id IS '-> object';
COMMENT ON COLUMN core.cobject.construction_id IS '-> construction';
COMMENT ON COLUMN core.cobject.cobject_type_id IS '-> object_type';
COMMENT ON COLUMN core.cobject.code IS 'Код объекта';
COMMENT ON COLUMN core.cobject.number IS 'Номер объекта';
COMMENT ON COLUMN core.cobject.descr IS 'Описание/наименование';

INSERT INTO sys.acl_function(name, descr) VALUES 
     ('core.CObjects.c', 'Создание объектов проектирования'),
     ('core.CObjects.r', 'Чтение объектов проектирования'),
     ('core.CObjects.u', 'Изменение объектов проектирования'),
     ('core.CObjects.d', 'Удаление объектов проектирования'),
     ('core.CObjects.l', 'Создание/удаление записи в связанной таблице')
;

