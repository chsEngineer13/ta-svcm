package ru.gazpromproject.ta.svcm.sys.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "sys", name = "acl_account_role")
public class AclAccountRole extends AbstractModelId {
    private long accountId;
    private long roleId;

    @Column(name = "account_id", nullable = true)
    public long getAccountId() {
        return accountId;
    }
    public void setAccountId(long accountId) {
        this.accountId = accountId;
    }

    @Column(name = "role_id", nullable = true)
    public long getRoleId() {
        return roleId;
    }
    public void setRoleId(long roleId) {
        this.roleId = roleId;
    }
}
