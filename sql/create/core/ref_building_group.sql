-- Классификатор групп зданий, сооружений, систем и установок
CREATE TABLE core.ref_building_group (
    id            serial PRIMARY KEY,
    parent_id     int,
    code_range    varchar(32),
    name	  varchar(512) NOT NULL
);

COMMENT ON TABLE core.ref_building_group IS 'Классификатор групп зданий, сооружений, систем и установок';

COMMENT ON COLUMN core.ref_building_group.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_building_group.parent_id IS 'Ccылка на группу-родитель';
COMMENT ON COLUMN core.ref_building_group.code_range IS 'Диапазон кодов';
COMMENT ON COLUMN core.ref_building_group.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.RefBuildingGroups.c', 'Создание классификатора частей комплексов строек'),
    ('core.RefBuildingGroups.r', 'Чтение классификаторов частей комплексов строек '),
    ('core.RefBuildingGroups.u', 'Изменение классификатора частей комплексов строек'),
    ('core.RefBuildingGroups.d', 'Удаление классификатора частей коплексов строек');

