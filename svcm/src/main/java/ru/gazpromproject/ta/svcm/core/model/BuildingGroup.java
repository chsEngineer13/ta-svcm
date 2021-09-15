package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractTreeModel;

@Entity
@Table(schema = "core", name = "ref_building_group")
public class BuildingGroup extends AbstractTreeModel {
    private String codeRange;
    private String name;

    @Column(name = "code_range")
    public String getCodeRange() {
        return codeRange;
    }

    public void setCodeRange(String codeRange) {
        this.codeRange = codeRange;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
