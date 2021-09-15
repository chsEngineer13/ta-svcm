package ru.gazpromproject.ta.svcm.sys.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "sys", name = "acl_role_function")
public class AclRoleFunction extends AbstractModelId {

    private long roleId;
    private long functionId;

    @Column(name = "role_id", nullable = true)
    public long getRoleId() {
        return roleId;
    }

    public void setRoleId(long roleId) {
        this.roleId = roleId;
    }

    @Column(name = "function_id", nullable = true)
    public long getFunctionId() {
        return functionId;
    }

    public void setFunctionId(long functionId) {
        this.functionId = functionId;
    }
}
