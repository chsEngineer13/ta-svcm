package ru.gazpromproject.ta.svcm.core.data;

import java.util.Date;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Document;
import ru.gazpromproject.ta.svcm.core.model.MFile;
import ru.gazpromproject.ta.svcm.core.repo.MFileRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.MFileRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class MFileData extends AbstractEntityData<MFile> implements EntityStorageData {

    public MFileData() {
        repo = new MFileRepoPg(MFile.class);
    }

    @Override
    public Entity convertToEntity(MFile modelObject) throws ODataApplicationException {
        final Entity e = new Entity();
        e.addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()));
        e.addProperty(new Property(null, "ParentObjectType", ValueType.PRIMITIVE, modelObject.getParentObjectType()));
        e.addProperty(new Property(null, "ParentObjectId", ValueType.PRIMITIVE, modelObject.getParentObjectId()));
        e.addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()));
        e.addProperty(new Property(null, "Size", ValueType.PRIMITIVE, modelObject.getSize()));
        e.addProperty(new Property(null, "ModifyTime", ValueType.PRIMITIVE, modelObject.getModifyTime()));
        e.addProperty(new Property(null, "FileTypeId", ValueType.PRIMITIVE, modelObject.getFileTypeId()));

        e.setId(createId(SvcmEdmCore.ES_BUILDINGS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public MFile convertFromEntity(MFile item, Entity entity) throws ODataApplicationException {
        MFile result;
        if (item == null) {
            result = new MFile();
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
            } else if (propertyName.equals("ParentObjectType")) {
                result.setParentObjectType(propertyText);
            } else if (propertyName.equals("ParentObjectId")) {
                if (!prop.isNull())
                    result.setParentObjectId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else if (propertyName.equals("Size")) {
                if (!prop.isNull())
                    result.setSize(parseIdFromString(propertyText));
            } else if (propertyName.equals("ModifyTime")) {
                if (!prop.isNull())
                    result.setModifyTime((Date) prop.getValue());
            } else if (propertyName.equals("FileTypeId")) {
                if (!prop.isNull())
                    result.setFileTypeId(parseIdFromString(propertyText));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName, SvcmEdmCore.ET_MFILE_NAME);
                throw new ODataApplicationException(err_msg, HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(),
                        Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_DOCUMENTS_NAME)) {
            DocumentData documentData = new DocumentData();
            Document documentItem = documentData.convertFromEntity(parentEntity);
            Long id = documentItem.getId();
            entityCollection = convertItemsToEntityCollection(((MFileRepo) repo).getByParentObjectId(id, "document"));
        }
        return entityCollection;
    }

    @Override
    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmCore.ES_DOCUMENTS_NAME) ) {
            DocumentData pDocumentData = new DocumentData();
            Document pDocumentItem = pDocumentData.convertFromEntity(targetEntity);
            Long pDocumentId = pDocumentItem.getId();
            MFile pMFileItem = convertFromEntity(parentEntity);
            pMFileItem.setParentObjectId(pDocumentId);
            pMFileItem.setParentObjectType("document");
            long id = pMFileItem.getId();
            repo.update(id, pMFileItem);
        }
    }

    @Override
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException {
        String parentEntitySetName = parentEntitySet.getName();
        if (parentEntitySetName.equals(SvcmEdmCore.ES_DOCUMENTS_NAME)) {
            MFile item = convertFromEntity(navEntity);
            item.setParentObjectId(null);
            item.setParentObjectType(null);
            repo.update(item.getId(), item);
        }
    }

}
