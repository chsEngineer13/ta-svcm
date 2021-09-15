package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "ref_chaptercode")
public class ChapterCode extends AbstractModelId {
    private Long chapterCodeTypeId;
    private Long chapter;
    private Long subChapter;
    private String code;
    private String name;

    @Column(name = "chaptercodetype_id", nullable = true)
    public Long getchapterCodeTypeId() {
        return chapterCodeTypeId;
    }

    public void setchapterCodeTypeId(Long chapterCodeTypeId) {
        if (chapterCodeTypeId != null)
            this.chapterCodeTypeId = chapterCodeTypeId;
    }

    public Long getChapter() {
        return chapter;
    }

    public void setChapter(Long chapter) {
        if (chapter != null)
            this.chapter = chapter;
    }

    public Long getSubChapter() {
        return subChapter;
    }

    public void setSubChapter(Long subChapter) {
        this.subChapter = subChapter;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
