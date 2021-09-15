package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "ref_building")
public class Building extends AbstractModelId {
    private Long buildingGroupId;
    private String code;
    private String name;

    @Column(name = "group_id", nullable = true)
    public Long getBuildingGroupId() {
        return buildingGroupId;
    }

    public void setBuildingGroupId(Long buildingGroupId) {
        if (buildingGroupId != null)
            this.buildingGroupId = buildingGroupId;
    }

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
}
