-- Статьи/группы видов затрат
CREATE TABLE cost_group (
    id           smallserial PRIMARY KEY,
    parent_id    smallint REFERENCES cost_group (id),
    name         varchar(100) NOT NULL
);

COMMENT ON TABLE cost_group IS 'Статьи/группы видов затрат';

COMMENT ON COLUMN cost_group.id IS 'Идентификатор';
COMMENT ON COLUMN cost_group.parent_id IS '-> cost_group';
COMMENT ON COLUMN cost_group.name IS 'Наименование';

INSERT INTO cost_group (parent_id, name) VALUES
    (NULL, 'Подрядные работы'),
    (NULL, 'Прочие затраты'),
    (NULL, 'Оборудование'),
    (NULL, 'За итогом глав ССР'),
    (1, 'Строительные работы'),
    (1, 'Монтажные работы'),
    (1, 'Прочие работы, связанные с организацией строительного производства'),
    (2, 'Прочие затраты Заказчика (Агента)'),
    (3, 'Оборудование');

