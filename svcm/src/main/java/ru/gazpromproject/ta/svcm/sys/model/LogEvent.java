package ru.gazpromproject.ta.svcm.sys.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "sys", name = "logevent")
public class LogEvent extends AbstractModelId {
    private long accountId;
    private long eventTypeId;
    private Date eventTime;
    private String schemaName;
    private String operationName;
    private Long operationPKId;
    private Date operationPKTime;
    private String details;
    private String descr;

    @Column(name = "account_id", nullable = true)
    public long getAccountId() {
        return accountId;
    }

    public void setAccountId(long accountId) {
        this.accountId = accountId;
    }

    @Column(name = "eventtype_id", nullable = true)
    public long getEventTypeId() {
        return eventTypeId;
    }

    public void setEventTypeId(long eventTypeId) {
        this.eventTypeId = eventTypeId;
    }

    @Column(name = "eventtime", nullable = true)
    public Date getEventTime() {
        return eventTime;
    }

    public void setEventTime(Date eventTime) {
        this.eventTime = eventTime;
    }

    @Column(name = "schema_name")
    public String getSchemaName() {
        return schemaName;
    }

    public void setSchemaName(String schemaName) {
        this.schemaName = schemaName;
    }

    @Column(name = "operation_name", nullable = true)
    public String getOperationName() {
        return operationName;
    }

    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }
    @Column(name = "operation_pk_id")
    public Long getOperationPKId() {
        return operationPKId;
    }

    public void setOperationPKId(Long operationPKId) {
        this.operationPKId = operationPKId;
    }
    @Column(name = "operation_pk_time")
    public Date getOperationPKTime() {
        return operationPKTime;
    }

    public void setOperationPKTime(Date operationPKTime) {
        this.operationPKTime = operationPKTime;
    }
    @Column(name = "details")
    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }
    @Column(name = "descr")
    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }
}
