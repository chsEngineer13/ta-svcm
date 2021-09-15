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
import org.apache.olingo.server.api.uri.UriParameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.repo.CObjectRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.CObjectRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.service.SvcmEdmProvider;

public class CObjectData extends AbstractEntityData<CObject> implements EntityStorageData {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(CObjectData.class);

    public CObjectData() {
        repo = new CObjectRepoPg(CObject.class);
    }

    @Override
    public Entity convertToEntity(CObject cobject) {       
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, cobject.getId()))
                .addProperty(new Property(null, "ParentId", ValueType.PRIMITIVE, cobject.getParentId()))
                .addProperty(new Property(null, "ConstructionId", ValueType.PRIMITIVE, cobject.getConstructionId()))
                .addProperty(new Property(null, "CObjectTypeId", ValueType.PRIMITIVE, cobject.getCObjectTypeId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, cobject.getCode()))
                .addProperty(new Property(null, "Number", ValueType.PRIMITIVE, cobject.getNumber()))
                .addProperty(new Property(null, "Descr", ValueType.PRIMITIVE, cobject.getDescr()))
                .addProperty(new Property(null, "Type", ValueType.ENUM, cobject.getCObjectTypeId()));
        e.setId(createId(SvcmEdmCore.ES_OBJECTS_NAME, cobject.getId()));
        return e;
    }

    @Override
    public CObject convertFromEntity(CObject item, Entity entity) throws ODataApplicationException {
        CObject result;
        if (item == null) {
            result = new CObject();
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
            } else if (propertyName.equals("Type")) {
                result.setCObjectTypeId((int)parseIdFromString(propertyText));                
            } else if (propertyName.equals("ConstructionId")) {
                if (!prop.isNull())
                    result.setConstructionId(parseIdFromString(propertyText));
            } else if (propertyName.equals("CObjectTypeId")) {                
                result.setCObjectTypeId(Integer.parseInt(propertyText));
            } else if (propertyName.equals("Code")) {
                result.setCode(propertyText);
            } else if (propertyName.equals("Number")) {
                result.setNumber(propertyText);
            } else if (propertyName.equals("Descr")) {
                result.setDescr(propertyText);                
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_OBJECT_NAME);
                throw new ODataApplicationException(err_msg
                        , HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode()
                        , Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_OBJECTS_NAME)) {
            CObject parentItem = convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((CObjectRepo) repo).getChilds(parentItem));
        }
        return entityCollection;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_OBJECTS_NAME)) {
            CObject childObject = convertFromEntity(parentEntity);
            final CObject item = ((CObjectRepo) repo).getParent(childObject);
            if (item != null) {
                result = convertToEntity(item);
            }
        } else if (entitySetName.equals(SvcmEdmCore.ES_DOCSETS_NAME)) {
            DocsetData dsdata = new DocsetData();
            Docset item = dsdata.convertFromEntity(parentEntity);

            long id = item.getCObjectId();
            final CObject cobj = ((CObjectRepo) repo).getById(id);
            if (cobj != null) {
                result = convertToEntity(cobj);
            }
        }
        return result;
    }

    @Override
    public EntityCollection getRelatedItemsTree(EdmNavigationProperty navProperty, Entity parentEntity, int level)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        if (navProperty.getName().equals(SvcmEdmProvider.NAV_CHILDREN_NAME)) {
            CObject parentItem = convertFromEntity(parentEntity);
            List<CObject> children = ((CObjectRepo) repo).getChildsTree(parentItem, level);
            entityCollection = convertItemsTreeToEntityCollection(children, navProperty.getName(), parentItem, null);
        }
        return entityCollection;
    }

    protected EntityCollection convertItemsTreeToEntityCollection(List<CObject> items, String propertyName,
            CObject rootItem, Entity rootEntity) {
        EntityCollection entityCollection = new EntityCollection();
        List<CObject> children = items.stream()
                .filter(kid -> kid.getParentId().equals(rootItem.getId()))
                .collect(Collectors.toList());
        if (children != null && !children.isEmpty()) {
            List<Entity> entityList = entityCollection.getEntities();
            for (CObject kidItem : children) {
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

    @Override
    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmCore.ES_OBJECTS_NAME)) {
            CObject parent = convertFromEntity(parentEntity);
            CObject target = convertFromEntity(targetEntity);
            // Don't cycle parent->child and child->parent, in case of mirror setLink call.
            if (parent.getParentId() == null || parent.getParentId() != target.getId()) {
                // Check hierarchy structure correctness
                if (parent.getCObjectTypeId() > target.getCObjectTypeId()) {
                    throw new ODataApplicationException(
                            "Can't link CObject: hierarchy structure error.",                                
                            HttpStatusCode.BAD_REQUEST.getStatusCode(), Locale.ENGLISH);
                }
                target.setParentId(parent.getId());
                if (parent.getConstructionId() != null) {
                    target.setConstructionId(parent.getConstructionId());
                }               
                repo.update(target.getId(), target);
                // Update entity property
                for (Property prop: targetEntity.getProperties()) {
                    if (prop.getName().equals("ParentId")) {
                        prop.setValue(ValueType.PRIMITIVE, parent.getId());
                    } else if (prop.getName().equals("ConstructionId")) {
                        prop.setValue(ValueType.PRIMITIVE, parent.getConstructionId());
                    }                        
                }
            }
        } 
    }

    @Override
    public void setRelatedLinks(Entity parentEntity, EdmEntitySet targetSet, List<Entity> targetEntities)
            throws ODataApplicationException {
        // TODO Auto-generated method stub
        super.setRelatedLinks(parentEntity, targetSet, targetEntities);
    }

    @Override
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException {
        String parentSetName = parentEntitySet.getName();
        if (parentSetName.equals(SvcmEdmCore.ES_OBJECTS_NAME)) {
            CObject parent = convertFromEntity(parentEntity);
            parent.setParentId(null);           
            repo.update(parent.getId(), parent);
        }
    }

    @Override
    public void unsetRelatedLinks(EdmEntitySet parentEntitySetName, Entity parentEntity,
            EdmNavigationProperty navProperty) {
        // TODO Auto-generated method stub
        super.unsetRelatedLinks(parentEntitySetName, parentEntity, navProperty);
    }
}
