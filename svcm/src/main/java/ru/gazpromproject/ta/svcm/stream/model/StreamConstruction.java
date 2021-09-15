package ru.gazpromproject.ta.svcm.stream.model;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(schema = "stream", name = "construction")
public class StreamConstruction extends StreamModelBase {
    private String code;
    private String name;
    private String gip;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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
