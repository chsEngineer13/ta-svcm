package ru.gazpromproject.ta.svcm.core.data;

import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriParameter;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartGroupRef;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartRef;
import ru.gazpromproject.ta.svcm.core.repo.ConstrPartRefRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.ConstrPartRefRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class ConstrPartRefData extends AbstractEntityData<ConstrPartRef> implements EntityStorageData {
    // private static final Logger logger =
    // LoggerFactory.getLogger(ConstrPartRefData.class);

    public ConstrPartRefData() {
        repo = new ConstrPartRefRepoPg(ConstrPartRef.class);
    }

    @Override
    public Entity convertToEntity(ConstrPartRef constrPart) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, constrPart.getId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, constrPart.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, constrPart.getName()))
                .addProperty(new Property(null, "GroupId", ValueType.PRIMITIVE, constrPart.getGroupId()));
        e.setId(createId(SvcmEdmCore.ES_CONSTRPARTREFS_NAME, constrPart.getId()));
        return e;
    }

    @Override
    public ConstrPartRef convertFromEntity(ConstrPartRef item, Entity entity) throws ODataApplicationException {
        ConstrPartRef result;
        if (item == null) {
            result = new ConstrPartRef();
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
            } else if (propertyName.equals("Code")) {
                result.setCode(propertyText);
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else if (propertyName.equals("GroupId")) {
                if (!prop.isNull())
                    result.setGroupId(parseIdFromString(propertyText));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_CONSTRPARTREF_NAME);
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
        if (entitySetName.equals(SvcmEdmCore.ES_CONSTRPARTGROUPREFS_NAME)) {
            ConstrPartGroupRefData parentRepo = new ConstrPartGroupRefData();
            ConstrPartGroupRef parentItem = parentRepo.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((ConstrPartRefRepo) repo).getByGroup(parentItem));
        }
        return entityCollection;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_CONSTRPARTGROUPREFS_NAME)) {
            ConstrPartGroupRefData groupRepo = new ConstrPartGroupRefData();
            ConstrPartGroupRef groupRef = groupRepo.convertFromEntity(parentEntity);
            //
            long id = getIdFromParams(keyParams);
            final ConstrPartRef item = repo.getById(id);
            if (item.getGroupId() != null && item.getGroupId() == groupRef.getId()) {
                result = convertToEntity(item);
            }
        }
        return result;
    }

    @Override
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException {
        String parentEntitySetName = parentEntitySet.getName();
        if (parentEntitySetName.equals(SvcmEdmCore.ES_CONSTRPARTGROUPREFS_NAME)) {
            ConstrPartRef cp = convertFromEntity(navEntity);
            cp.setGroupId(null);            
            repo.update(cp.getId(), cp);
            /*
            ConstrPartGroupRefData groupRepo = new ConstrPartGroupRefData();
            ConstrPartGroupRef groupRef = groupRepo.convertFromEntity(parentEntity);
            //
            long id = getIdFromParams(keyParams);
            final ConstrPartRef item = repo.getById(id);
            if (item.getGroupId() != null && item.getGroupId() == groupRef.getId()) {
                result = convertToEntity(item);
            }
            */
        }
    }

    @Override
    public void unsetRelatedLinks(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty) {
        // TODO Auto-generated method stub
        super.unsetRelatedLinks(parentEntitySet, parentEntity, navProperty);
    }        
}
