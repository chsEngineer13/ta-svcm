package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "ref_phase")
public class Phase extends AbstractModelId {
    private String code;
    private String name;

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
