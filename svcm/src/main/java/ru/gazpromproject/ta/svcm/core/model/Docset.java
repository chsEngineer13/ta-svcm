package ru.gazpromproject.ta.svcm.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "docset")
public class Docset extends AbstractModelId {
    private Long cObjectId;
    private String sign;
    private Long markRefId;
    private String name;
    private Date dateStart;
    private Date dateFinish;

    @Column(name = "cobject_id", nullable = true)
    public Long getCObjectId() {
        return cObjectId;
    }

    public void setCObjectId(Long cObjectId) {
        this.cObjectId = cObjectId;
    }

    @Column(name = "cipher")
    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    @Column(name = "mark_ref_id", nullable = true)
    public Long getMarkRefId() {
        return markRefId;
    }

    public void setMarkRefId(Long markRefId) {
        this.markRefId = markRefId;
    }

    @Column(name = "name")
    public String getName() {
        return this.name;
    }

    public void setName(String descr) {
        this.name = descr;
    }

    @Column(name = "datestart", nullable = true)
    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    @Column(name = "datefinish", nullable = true)
    public Date getDateFinish() {
        return dateFinish;
    }

    public void setDateFinish(Date dateFinish) {
        this.dateFinish = dateFinish;
    }
}
