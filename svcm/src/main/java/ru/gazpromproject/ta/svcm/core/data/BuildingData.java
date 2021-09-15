package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Building;
import ru.gazpromproject.ta.svcm.core.model.BuildingGroup;
import ru.gazpromproject.ta.svcm.core.repo.BuildingRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.BuildingRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class BuildingData extends AbstractEntityData<Building> implements EntityStorageData {

    public BuildingData() {
        repo = new BuildingRepoPg(Building.class);
    }

    @Override
    public Entity convertToEntity(Building building) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, building.getId()))
                .addProperty(new Property(null, "BuildingGroupId", ValueType.PRIMITIVE, building.getBuildingGroupId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, building.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, building.getName()));
        e.setId(createId(SvcmEdmCore.ES_BUILDINGS_NAME, building.getId()));
        return e;
    }

    @Override
    public Building convertFromEntity(Building item, Entity entity) throws ODataApplicationException {
        Building result;
        if (item == null) {
            result = new Building();
        } else {
            result = item;
        }
        for (Property prop : entity.getProperties()) {
            String propertyName = prop.getName();
            String propertyText = null;
            if (!prop.isNull())
                propertyText = prop.getValue().toString();
            if (propertyName.equals("Id")) {
                result.setId(parseIdFromString(propertyText));
            } else if (propertyName.equals("BuildingGroupId")) {
                if (!prop.isNull())
                    result.setBuildingGroupId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Code")) {
                result.setCode(propertyText);
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_BUILDING_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_BUILDINGGROUPS_NAME)) {
            BuildingGroupData buildingGroupData = new BuildingGroupData();
            BuildingGroup buildingGroupItem = buildingGroupData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(
                    ((BuildingRepo) repo).getByBuildingGroup(buildingGroupItem));
        }
        return entityCollection;
    }
}
