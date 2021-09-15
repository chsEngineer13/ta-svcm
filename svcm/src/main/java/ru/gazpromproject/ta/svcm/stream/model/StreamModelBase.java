package ru.gazpromproject.ta.svcm.stream.model;

import java.util.Date;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import org.hibernate.annotations.Type;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@MappedSuperclass
public abstract class StreamModelBase extends AbstractModelId {
    private Long hid;
    @Type(type = "pg-uuid")
    private UUID hidGuid;
    private String hidStr;
    private Date ObjectTime;
    private Date InsertTime;
    private int streamStatus;
    private Long successorId;

    @Column(name = "hid", nullable = true)
    public Long getHid() {
        return hid;
    }
    public void setHid(Long hid) {
        this.hid = hid;
    }

    @Column(name = "hid_uuid", nullable = true)
    public UUID getHidGuid() {
        return hidGuid;
    }
    public void setHidGuid(UUID hidGuid) {
        this.hidGuid = hidGuid;
    }

    @Column(name = "hid_str", nullable = true)
    public String getHidStr() {
        return hidStr;
    }
    public void setHidStr(String hidStr) {
        this.hidStr = hidStr;
    }

    @Column(name = "object_time", nullable = true)
    public Date getObjectTime() {
        return ObjectTime;
    }
    public void setObjectTime(Date objectTime) {
        ObjectTime = objectTime;
    }

    @Column(name = "insert_time", nullable = true)
    public Date getInsertTime() {
        return InsertTime;
    }
    public void setInsertTime(Date insertTime) {
        InsertTime = insertTime;
    }

    @Column(name = "stream_status")
    public int getStreamStatus() {
        return streamStatus;
    }
    public void setStreamStatus(int streamStatus) {
        this.streamStatus = streamStatus;
    }
    
    @Column(name = "successor_id")
    public Long getSuccessorId() {
        return successorId;
    }
    public void setSuccessorId(Long successorId) {
        this.successorId = successorId;
    }
}
