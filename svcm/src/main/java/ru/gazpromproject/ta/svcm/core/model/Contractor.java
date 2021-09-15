package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "ref_contractor")
public class Contractor extends AbstractModelId {
    private String customerCode;
    private String name;

    @Column(name = "customer_code")
    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
