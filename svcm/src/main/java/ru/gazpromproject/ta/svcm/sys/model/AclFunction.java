package ru.gazpromproject.ta.svcm.sys.model;

import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "sys", name = "acl_function")
public class AclFunction extends AbstractModelId {
    private String name;
    private String descr;

    public String getName() {
        return name;
    }

    public void setName(String funcName) {
        name = funcName;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String funcDescr) {
        descr = funcDescr;
    }
}
