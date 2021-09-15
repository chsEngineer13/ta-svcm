-- Связь много-ко-многим для составного документа (core.docset) и накладной (core.waybill)
CREATE TABLE core.waybill_link (
  id BIGSERIAL PRIMARY KEY,
  docset_id BIGINT NOT NULL REFERENCES core.docset(id),
  waybill_id BIGINT NOT NULL REFERENCES core.waybill(id)
);

COMMENT ON TABLE core.waybill_link IS 'core.docset <---> core.waybill';

COMMENT ON COLUMN core.waybill_link.id IS 'Идентификатор';
COMMENT ON COLUMN core.waybill_link.docset_id IS '-> core.docset';
COMMENT ON COLUMN core.waybill_link.waybill_id IS '-> core.waybill';

