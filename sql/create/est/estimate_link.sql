-- Связи смет с документами
CREATE TABLE public.estimate_link (
    id             BIGSERIAL PRIMARY KEY,
    estimate_id    BIGINT REFERENCES estimate (id),
    link_type_id   SMALLINT NOT NULL,
    link_id        BIGINT NOT NULL
);

COMMENT ON TABLE public.estimate_link IS 'Смета -> Комплект';

COMMENT ON COLUMN public.estimate_link.id IS 'Идентификатор';
COMMENT ON COLUMN public.estimate_link.estimate_id IS '-> estimate.id';
COMMENT ON COLUMN public.estimate_link.link_type_id IS 'Тип связываемого документа';
COMMENT ON COLUMN public.estimate_link.link_id IS 'Идентификатор связываемого документа';

