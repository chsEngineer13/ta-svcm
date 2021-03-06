-- Главы ССР 
CREATE TABLE ssr_chapter (
    id      smallserial PRIMARY KEY,
    code    varchar(8) NOT NULL,
    name    varchar(256) NOT NULL
);

COMMENT ON TABLE ssr_chapter IS 'Главы ССР';

COMMENT ON COLUMN ssr_chapter.id IS 'Идентификатор';
COMMENT ON COLUMN ssr_chapter.code IS 'Номер';
COMMENT ON COLUMN ssr_chapter.name IS 'Наименование';

INSERT INTO ssr_chapter (code, name) VALUES
    ('1', 'Подготовка территории строительства'),
    ('2', 'Основные объекты строительства'),
    ('3', 'Объекты подсобного и обслуживающего назначения'),
    ('4', 'Объекты энергетического хозяйства'),
    ('5', 'Объекты транспортного хозяйства и связи'),
    ('6', 'Наружные сети и сооружения водоснабжения, канализации, теплоснабжения и газоснабжения'),
    ('7', 'Благоустройство и озеленение территории'),
    ('8', 'Временные здания и сооружения'),
    ('9', 'Прочие работы и затраты'),
    ('10', 'Содержание службы заказчика. Строительный контроль'),
    ('12', 'Проектные и изыскательские работы');

