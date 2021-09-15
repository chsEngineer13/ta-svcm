package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.*;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "ref_mark")
public class Mark extends AbstractModelId {
    private String code;
    private String name;
    private String comment;
    private boolean isAdditional;

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComment() {
        return this.comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Column(name = "additional")
    public boolean getIsAdditional() {
        return this.isAdditional;
    }

    public void setIsAdditional(boolean isAdditional) {
        this.isAdditional = isAdditional;
    }
}
