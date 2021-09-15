-- Типы единиц проектной продукции
CREATE TABLE core.ds_type (
  id SMALLSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(25) NOT NULL UNIQUE,
  descr TEXT
);

COMMENT ON TABLE core.ds_type IS 'Типы единиц проектной продукции';

COMMENT ON COLUMN core.ds_type.id IS 'Идентификатор';
COMMENT ON COLUMN core.ds_type.name IS 'Наименование';
COMMENT ON COLUMN core.ds_type.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
      ('core.DocsetTypes.r', 'Чтение типов единиц проектной продукции')
    , ('core.DocsetTypes.c', 'Создание типа единицы проектной продукции')
    , ('core.DocsetTypes.u', 'Изменение типа единицы проектной продукции')
    , ('core.DocsetTypes.d', 'Удаление типа единицы проектной продукции')
    , ('core.DocsetTypes.l', 'Создание/удаление записи в связанной таблице')
;

INSERT INTO core.ds_type (name, descr) VALUES
     ('Комплект', 'Комплект проектной продукции (стадия Р)')
    ,('Том', 'Том (стадия П, ИИ)')
;

