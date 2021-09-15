package ru.gazpromproject.ta.svcm.core.data;

import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriParameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartGroupRef;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartRef;
import ru.gazpromproject.ta.svcm.core.repo.ConstrPartGroupRefRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.ConstrPartGroupRefRepoPg;
import ru.gazpromproject.ta.svcm.core.repo.pg.ConstrPartRefRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class ConstrPartGroupRefData extends AbstractEntityData<ConstrPartGroupRef> implements EntityStorageData {
    private static final Logger logger = LoggerFactory.getLogger(ConstrPartGroupRefData.class);

    public ConstrPartGroupRefData() {
        repo = new ConstrPartGroupRefRepoPg(ConstrPartGroupRef.class);
    }

    @Override
    public Entity convertToEntity(ConstrPartGroupRef constrPartGroup) {
        final Entity e = new Entity()
                .addProperty(new Property(null, "Id", ValueType.PRIMITIVE, constrPartGroup.getId()))
                .addProperty(new Property(null, "CodeRange", ValueType.PRIMITIVE, constrPartGroup.getCodeRange()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, constrPartGroup.getName()));
        e.setId(createId(SvcmEdmCore.ES_CONSTRPARTGROUPREFS_NAME, constrPartGroup.getId()));
        return e;
    }

    @Override
    public ConstrPartGroupRef convertFromEntity(ConstrPartGroupRef item, Entity entity) throws ODataApplicationException {
        ConstrPartGroupRef result;
        if (item == null) {
            result = new ConstrPartGroupRef();
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
            } else if (propertyName.equals("CodeRange")) {
                result.setCodeRange(propertyText);
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_CONSTRPARTGROUPREF_NAME);
                throw new ODataApplicationException(
                        err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity) throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_CONSTRPARTREFS_NAME)) {
            ConstrPartRefData parentRepo = new ConstrPartRefData();
            ConstrPartRef parentItem = parentRepo.convertFromEntity(parentEntity);
            ConstrPartGroupRef resultGroup = ((ConstrPartGroupRefRepo) repo).getByItem(parentItem);
            if (resultGroup != null)
                result = convertToEntity(resultGroup);
        }
        return result;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        logger.info(String.format("Convert *parentEntity* to *parentItem*..."));
        return super.getRelatedSingleItem(parentSet, parentEntity, keyParams);
    }

    @Override
    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmCore.ES_CONSTRPARTREFS_NAME)) {
            ConstrPartGroupRef parentItem = convertFromEntity(parentEntity);
            ConstrPartRefData targetData = new ConstrPartRefData();
            ConstrPartRef targetItem = targetData.convertFromEntity(targetEntity);
            targetItem.setGroupId(parentItem.getId());
            ConstrPartRefRepoPg targetRepo = new ConstrPartRefRepoPg(ConstrPartRef.class);
            targetRepo.update(targetItem.getId(), targetItem);
        }
    }

    @Override
    public void setRelatedLinks(Entity parentEntity, EdmEntitySet targetSet, List<Entity> targetsEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmCore.ES_CONSTRPARTREFS_NAME)) {
            ConstrPartGroupRef parentItem = convertFromEntity(parentEntity);
            for (Entity targetEntity : targetsEntity) {
                ConstrPartRefData targetData = new ConstrPartRefData();
                ConstrPartRef targetItem = targetData.convertFromEntity(targetEntity);
                targetItem.setGroupId(parentItem.getId());
                ConstrPartRefRepoPg targetRepo = new ConstrPartRefRepoPg(ConstrPartRef.class);
                targetRepo.update(targetItem.getId(), targetItem);
            }
        }
    }
}
