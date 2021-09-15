package ru.gazpromproject.ta.svcm.sys.model;

import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "sys", name = "acl_group")
public class AclGroup extends AbstractModelId {
    private String name;
    private String descr;

    public String getName() {
        return name;
    }
    public void setName(String groupName) {
        name = groupName;
    }

    public String getDescr() {
        return descr;
    }
    public void setDescr(String groupDescr) {
        descr = groupDescr;
    }
}
