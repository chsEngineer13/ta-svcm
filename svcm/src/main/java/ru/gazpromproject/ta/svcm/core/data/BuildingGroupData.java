package ru.gazpromproject.ta.svcm.core.data;

import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Link;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Building;
import ru.gazpromproject.ta.svcm.core.model.BuildingGroup;
import ru.gazpromproject.ta.svcm.core.repo.BuildingGroupRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.BuildingGroupRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.service.SvcmEdmProvider;

public class BuildingGroupData extends AbstractEntityData<BuildingGroup> implements EntityStorageData {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(BuildingGroupData.class);

    public BuildingGroupData() {
        repo = new BuildingGroupRepoPg(BuildingGroup.class);
    }

    @Override
    public Entity convertToEntity(BuildingGroup modelObject) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()))
                .addProperty(new Property(null, "ParentId", ValueType.PRIMITIVE, modelObject.getParentId()))
                .addProperty(new Property(null, "CodeRange", ValueType.PRIMITIVE, modelObject.getCodeRange()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()));
        e.setId(createId(SvcmEdmCore.ES_BUILDINGGROUPS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public BuildingGroup convertFromEntity(BuildingGroup item, Entity entity) throws ODataApplicationException {
        BuildingGroup result;
        if (item == null) {
            result = new BuildingGroup();
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
            } else if (propertyName.equals("ParentId")) {
                if (!prop.isNull())
                    result.setParentId(parseIdFromString(propertyText));
            } else if (propertyName.equals("CodeRange")) {
                result.setCodeRange(propertyText);
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_BUILDINGGROUP_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity) throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_BUILDINGGROUPS_NAME)) {
            BuildingGroup childObject = convertFromEntity(parentEntity);
            final BuildingGroup item = ((BuildingGroupRepo) repo).getParent(childObject);
            if (item != null) {
                result = convertToEntity(item);
            }
        }
        if (entitySetName.equals(SvcmEdmCore.ES_BUILDINGS_NAME)) {
            BuildingData data = new BuildingData();
            Building item = data.convertFromEntity(parentEntity);

            Long id = item.getBuildingGroupId();
            if (id != null) {
                final BuildingGroup obj = ((BuildingGroupRepo) repo).getById(id);
                if (obj != null) {
                    result = convertToEntity(obj);
                }
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
            BuildingGroup parentItem = convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((BuildingGroupRepo) repo).getChilds(parentItem));
        }
        return entityCollection;
    }

    @Override
    public EntityCollection getRelatedItemsTree(EdmNavigationProperty navProperty, Entity parentEntity, int level)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        if (navProperty.getName().equals(SvcmEdmProvider.NAV_CHILDREN_NAME)) {
            BuildingGroup parentItem = convertFromEntity(parentEntity);
            List<BuildingGroup> children = ((BuildingGroupRepo) repo).getChildsTree(parentItem, level);
            entityCollection = convertItemsTreeToEntityCollection(children, navProperty.getName(), parentItem, null);
        }
        return entityCollection;
    }

    private EntityCollection convertItemsTreeToEntityCollection(List<BuildingGroup> items, String propertyName,
            BuildingGroup rootItem, Entity rootEntity) {
        EntityCollection entityCollection = new EntityCollection();
        List<BuildingGroup> children = items.stream().filter(kid -> kid.getParentId().equals(rootItem.getId()))
                .collect(Collectors.toList());
        if (children != null && !children.isEmpty()) {
            List<Entity> entityList = entityCollection.getEntities();
            for (BuildingGroup kidItem : children) {
                Entity kidEntity = convertToEntity(kidItem);
                convertItemsTreeToEntityCollection(items, propertyName, kidItem, kidEntity);
                entityList.add(kidEntity);
            }
        }
        if (rootEntity != null) {
            Link link = new Link();
            link.setTitle(propertyName);
            link.setInlineEntitySet(entityCollection);
            rootEntity.getNavigationLinks().add(link);
        }
        return entityCollection;
    }
}
