package ru.gazpromproject.ta.svcm.sys.model;

import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "sys", name = "acl_role")
public class AclRole extends AbstractModelId {
    private String name;
    private String descr;

    public String getName() {
        return name;
    }
    public void setName(String roleName) {
        name = roleName;
    }

    public String getDescr() {
        return descr;
    }
    public void setDescr(String roleDescr) {
        descr = roleDescr;
    }

}
