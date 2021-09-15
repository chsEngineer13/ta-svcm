package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "summary_construction")
public class SummaryConstruction extends AbstractModelId {
    private Long cObjectId;
    private String code;
    private String name;
    private Long cntId;
    private Long cntStart;
    private Long cntFinish;
    private Long cntInvoice;

    @Column(name = "cobject_id")
    public Long getCObjectId() {
        return cObjectId;
    }

    public void setCObjectId(Long cObjectId) {
        this.cObjectId = cObjectId;
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

    @Column(name = "cnt_id")
    public Long getCntId() {
        return cntId;
    }

    public void setCntId(Long cnt) {
        this.cntId = cnt;
    }

    @Column(name = "cnt_datestart")
    public Long getCntStart() {
        return cntStart;
    }

    public void setCntStart(Long cnt) {
        this.cntStart = cnt;
    }

    @Column(name = "cnt_datefinish")
    public Long getCntFinish() {
        return cntFinish;
    }

    public void setCntFinish(Long cnt) {
        this.cntFinish = cnt;
    }

    @Column(name = "cnt_invoicenum")
    public Long getCntInvoice() {
        return cntInvoice;
    }

    public void setCntInvoice(Long cnt) {
        this.cntInvoice = cnt;
    }
}
