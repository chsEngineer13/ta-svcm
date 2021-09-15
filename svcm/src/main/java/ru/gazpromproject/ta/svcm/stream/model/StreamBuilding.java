package ru.gazpromproject.ta.svcm.stream.model;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(schema = "stream", name = "building")
public class StreamBuilding extends StreamModelBaseParent {
    private Long hcontractId;
    @Type(type = "pg-uuid")
    private UUID hcontractIdGuid;
    private String hcontractIdStr;
    private String code;
    private String number;
    private String name;
    private String gip;

    @Column(name = "hcontract_id", nullable = true)
    public Long getHcontractId() {
        return hcontractId;
    }

    public void setHcontractId(Long hcontractId) {
        this.hcontractId = hcontractId;
    }

    @Column(name = "hcontract_uuid", nullable = true)
    public UUID getHcontractIdGuid() {
        return hcontractIdGuid;
    }

    public void setHcontractIdGuid(UUID hcontractIdGuid) {
        this.hcontractIdGuid = hcontractIdGuid;
    }

    @Column(name = "hcontract_id_str", nullable = true)
    public String getHcontractIdStr() {
        return hcontractIdStr;
    }

    public void setHcontractIdStr(String hcontractIdStr) {
        this.hcontractIdStr = hcontractIdStr;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "num", nullable = true)
    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGip() {
        return gip;
    }

    public void setGip(String gip) {
        this.gip = gip;
    }
}
