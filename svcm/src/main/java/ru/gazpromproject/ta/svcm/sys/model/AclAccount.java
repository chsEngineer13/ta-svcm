package ru.gazpromproject.ta.svcm.sys.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "sys", name = "acl_account")
public class AclAccount extends AbstractModelId {
    private String login;
    private String password;
    private String salt;
    private String firstName;
    private String middleName;
    private String lastName;
    private String tabNum;
    private String email;
    private boolean isActive;

    public String getLogin() {
        return login;
    }
    public void setLogin(String accLogin) {
        login = accLogin;
    }

    @Column(name = "pwd")
    public String getPassword() {
        return this.password;
    }
    public void setPassword(String accPassword) {
        this.password = accPassword;
    }

    public String getSalt() {
        return this.salt;
    }
    public void setSalt(String accSalt) {
        this.salt = accSalt;
    }

    public String getFirstName() {
        return this.firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return this.middleName;
    }
    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getLastName() {
        return this.lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getTabNum() {
        return this.tabNum;
    }
    public void setTabNum(String tabNum) {
        this.tabNum = tabNum;
    }

    public String getEmail() {
        return this.email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "is_active")
    public boolean isIsActive() {
        return this.isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
}
