-- cost_kind <---> ssr_chapter
CREATE TABLE cost_kind_chapter_link (
    id                smallserial PRIMARY KEY,
    cost_kind_id      smallint REFERENCES cost_kind(id),
    ssr_chapter_id    smallint REFERENCES ssr_chapter(id)
);

COMMENT ON TABLE cost_kind_chapter_link IS 'cost_kind <---> ssr_chapter';

COMMENT ON COLUMN cost_kind_chapter_link.id IS 'Идентификатор';
COMMENT ON COLUMN cost_kind_chapter_link.cost_kind_id IS '-> cost_kind';
COMMENT ON COLUMN cost_kind_chapter_link.ssr_chapter_id IS '-> ssr_chapter';

