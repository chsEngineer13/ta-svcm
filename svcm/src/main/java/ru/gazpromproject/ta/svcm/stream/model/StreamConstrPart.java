package ru.gazpromproject.ta.svcm.stream.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(schema = "stream", name = "constrpart")
public class StreamConstrPart extends StreamModelBaseParent {
    private String code;
    private String number;
    private String name;
    private String gip;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "num", nullable = false)
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
