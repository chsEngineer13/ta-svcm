package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.*;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "cobject")
public class CObject extends AbstractModelId {
    private Long parentId;
    private Long constructionId;
    private int cObjectTypeId;
    private String code;
    private String number;
    private String descr;

    @Column(name = "parent_id", nullable = true)
    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    @Column(name = "construction_id", nullable = true)
    public Long getConstructionId() {
        return constructionId;
    }

    public void setConstructionId(Long constructionId) {
        this.constructionId = constructionId;
    }

    @Column(name = "cobject_type_id")
    public int getCObjectTypeId() {
        return cObjectTypeId;
    }

    public void setCObjectTypeId(int cObjectTypeId) {
        this.cObjectTypeId = cObjectTypeId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }
}
