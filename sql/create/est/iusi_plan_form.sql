-- Форматы планирования ИУС И
CREATE TABLE iusi_plan_form (
    id           smallserial PRIMARY KEY,
    name         varchar(64) NOT NULL,
    cost_code    varchar(10)
);

COMMENT ON TABLE iusi_plan_form IS 'Форматы планирования ИУС И';

COMMENT ON COLUMN iusi_plan_form.id IS 'Идентификатор';
COMMENT ON COLUMN iusi_plan_form.name IS 'Наименование формата планирования';
COMMENT ON COLUMN iusi_plan_form.cost_code IS 'Код вида затрат ИУС И';

INSERT INTO iusi_plan_form (name, cost_code) VALUES
    ('Подрядные работы', 'Т800000200'),
    ('Материалы, трубная продукция', 'Т800000202'),
    ('Иные прочие', 'Т800000599'),
    ('Землеотвод', 'Т800000500'),
    ('Землеотвод, аренда', 'Т800000501'),
    ('Пуско наладочные работы "вхолостую"', 'Т800000505'),
    ('Услуги Заказчика', 'Т800000509'),
    ('Проектирование (ПД, РД)', 'Т800000100'),
    ('Экспертиза', 'Т800000508'),
    ('Оборудование', 'Т800000301'),
    ('не учитывается', null),
    ('учитывается отдельно', null);

