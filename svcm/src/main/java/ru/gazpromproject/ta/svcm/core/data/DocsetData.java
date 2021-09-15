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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.model.Document;
import ru.gazpromproject.ta.svcm.core.model.Mark;
import ru.gazpromproject.ta.svcm.core.repo.DocsetRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.DocsetRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class DocsetData extends AbstractEntityData<Docset> implements EntityStorageData {

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(DocsetData.class);

    public DocsetData() {
        repo = new DocsetRepoPg(Docset.class);
    }

    @Override
    public Entity convertToEntity(Docset modelObject) throws ODataApplicationException {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()))
                .addProperty(new Property(null, "CObjectId", ValueType.PRIMITIVE, modelObject.getCObjectId()))
                .addProperty(new Property(null, "Sign", ValueType.PRIMITIVE, modelObject.getSign()))
                .addProperty(new Property(null, "MarkRefId", ValueType.PRIMITIVE, modelObject.getMarkRefId()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()))
                .addProperty(new Property(null, "DateStart", ValueType.PRIMITIVE,
                        convertDateToGregorian(modelObject.getDateStart())))
                .addProperty(new Property(null, "DateFinish", ValueType.PRIMITIVE,
                        convertDateToGregorian(modelObject.getDateFinish())));
        e.setId(createId(SvcmEdmCore.ES_DOCSETS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public Docset convertFromEntity(Docset item, Entity entity) throws ODataApplicationException {
        Docset result;
        if (item == null) {
            result = new Docset();
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
            } else if (propertyName.equals("CObjectId")) {
                if (!prop.isNull())
                    result.setCObjectId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Sign")) {
                result.setSign(propertyText);
            } else if (propertyName.equals("MarkRefId")) {
                if (!prop.isNull())
                    result.setMarkRefId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else if (propertyName.equals("DateStart")) {
                if (!prop.isNull())
                    result.setDateStart(convertGregorianToDate(prop));
            } else if (propertyName.equals("DateFinish")) {
                if (!prop.isNull())
                    result.setDateFinish(convertGregorianToDate(prop));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_DOCSET_NAME);
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
        if (entitySetName.equals(SvcmEdmCore.ES_OBJECTS_NAME)) {
            CObjectData objectData = new CObjectData();
            CObject objectItem = objectData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((DocsetRepo) repo).getByObject(objectItem));
        }
        return entityCollection;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_OBJECTS_NAME)) {
            CObjectData objectData = new CObjectData();
            CObject objectItem = objectData.convertFromEntity(parentEntity);

            long id = getIdFromParams(keyParams);
            final Docset item = repo.getById(id);
            if (item.getCObjectId() != null && item.getCObjectId() == objectItem.getId()) {
                result = convertToEntity(item);
            }
        }
        if (entitySetName.equals(SvcmEdmCore.ES_DOCUMENTS_NAME)) {
            DocumentData documentData = new DocumentData();
            Document documentItem = documentData.convertFromEntity(parentEntity);
            Long id = documentItem.getDocsetId();
            if (id != null) {
                final Docset item = repo.getById(id);
                if (item != null) {
                    result = convertToEntity(item);
                }
            }
        }
        return result;
    }

    @Override
    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmCore.ES_OBJECTS_NAME) ) {
            CObjectData pCObjectData = new CObjectData();
            CObject pCObjectItem = pCObjectData.convertFromEntity(targetEntity);
            Long pCObjectId = pCObjectItem.getId();
            Docset pDocsetItem = convertFromEntity(parentEntity);
            pDocsetItem.setCObjectId(pCObjectId);
            long id = pDocsetItem.getId();
            repo.update(id, pDocsetItem);
        }
        if (targetSetName.equals(SvcmEdmCore.ES_MARKS_NAME) ) {
            MarkData pMarkData = new MarkData();
            Mark pMarkItem = pMarkData.convertFromEntity(targetEntity);
            Long pMarkRefId = pMarkItem.getId();
            Docset pDocsetItem = convertFromEntity(parentEntity);
            pDocsetItem.setMarkRefId(pMarkRefId);
            long id = pDocsetItem.getId();
            repo.update(id, pDocsetItem);
        }
    }

    @Override
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException {
        String parentEntitySetName = parentEntitySet.getName();
        if (parentEntitySetName.equals(SvcmEdmCore.ES_OBJECTS_NAME)) {
            Docset item = convertFromEntity(navEntity);
            item.setCObjectId(null);
            repo.update(item.getId(), item);
        }
        if (parentEntitySetName.equals(SvcmEdmCore.ES_MARKS_NAME)) {
            Docset item = convertFromEntity(navEntity);
            item.setMarkRefId(null);
            repo.update(item.getId(), item);
        }
    }
}
