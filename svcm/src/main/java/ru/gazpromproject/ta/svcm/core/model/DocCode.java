package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "ref_doccode")
public class DocCode extends AbstractModelId {
    private String code;
    private String name;
    private Boolean additional;
    private Boolean numericPart;

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

    public Boolean getAdditional() {
        return additional;
    }

    public void setAdditional(Boolean additional) {
        if (additional != null)
            this.additional = additional;
    }

    @Column(name = "numeric_part")
    public Boolean getNumericPart() {
        return numericPart;
    }

    public void setNumericPart(Boolean numericPart) {
        if (numericPart != null)
            this.numericPart = numericPart;
    }
}
