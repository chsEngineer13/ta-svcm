-- Классификатор зданий, сооружений, систем и установок  
CREATE TABLE core.ref_building (
    id		serial PRIMARY KEY,
    group_id	int REFERENCES core.ref_building_group (id),
    code	varchar(8) NOT NULL,
    name	varchar(512) NOT NULL
);

COMMENT ON TABLE core.ref_building IS 'Классификатор зданий, сооружений, систем и установок';

COMMENT ON COLUMN core.ref_building.id IS 'Индентификатр';
COMMENT ON COLUMN core.ref_building.group_id IS '-> building_group';
COMMENT ON COLUMN core.ref_building.code IS 'Код';
COMMENT ON COLUMN core.ref_building.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES 
     ('core.RefBuildings.c', 'Создание классификатора зданий, сооружений, систем и установок'),
     ('core.RefBuildings.r', 'Чтение классификаторов зданий, сооружений, систем и установок'),
     ('core.RefBuildings.u', 'Изменение классификатора зданий, сооружений, систем и установок'),
     ('core.RefBuildings.d', 'Удаление классификатора зданий, сооружений, систем и установок');

