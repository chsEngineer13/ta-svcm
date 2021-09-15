package ru.gazpromproject.ta.svcm.stream.model;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class StreamModelBaseParent extends StreamModelBase {
    private String parentType;
    private Long hpid;
    private UUID hpid_guid;
    private String hpid_str;

    @Column(name = "h_ptype", nullable = true)
    public String getParentType() {
        return parentType;
    }

    public void setParentType(String parentType) {
        this.parentType = parentType;
    }

    @Column(name = "hpid", nullable = true)
    public Long getHpid() {
        return hpid;
    }

    public void setHpid(Long hpid) {
        this.hpid = hpid;
    }

    @Column(name = "hpid_uuid", nullable = true)
    public UUID getHpid_guid() {
        return hpid_guid;
    }

    public void setHpid_guid(UUID hpid_guid) {
        this.hpid_guid = hpid_guid;
    }

    @Column(name = "hpid_str", nullable = true)
    public String getHpid_str() {
        return hpid_str;
    }

    public void setHpid_str(String hpid_str) {
        this.hpid_str = hpid_str;
    }
}
