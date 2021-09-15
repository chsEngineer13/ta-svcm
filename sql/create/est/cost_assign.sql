-- Типы отнесения затрат
CREATE TABLE cost_assign (
    id      smallserial PRIMARY KEY,
    name    varchar(64) NOT NULL
);

COMMENT ON TABLE cost_assign IS 'Типы отнесения затрат';

COMMENT ON COLUMN cost_assign.name IS 'Идентификатор';
COMMENT ON COLUMN cost_assign.name IS 'Наименование';

INSERT INTO cost_assign (name) VALUES
    ('Косвенные'),
    ('Прямые');

