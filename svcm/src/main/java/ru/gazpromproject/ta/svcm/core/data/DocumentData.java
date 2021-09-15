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
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.model.Document;
import ru.gazpromproject.ta.svcm.core.model.MFile;
import ru.gazpromproject.ta.svcm.core.repo.DocumentRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.DocumentRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class DocumentData extends AbstractEntityData<Document> implements EntityStorageData {

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(Document.class);

    public DocumentData() {
        repo = new DocumentRepoPg(Document.class);
    }

    @Override
    public Entity convertToEntity(Document modelObject) throws ODataApplicationException {
        final Entity e = new Entity();
        e.addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()));
        e.addProperty(new Property(null, "DocsetId", ValueType.PRIMITIVE, modelObject.getDocsetId()));
        e.addProperty(new Property(null, "Cipher", ValueType.PRIMITIVE, modelObject.getCipher()));
        e.addProperty(new Property(null, "DoccodeId", ValueType.PRIMITIVE, modelObject.getDoccodeId()));
        e.addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()));
        e.addProperty(new Property(null, "DeveloperDep", ValueType.PRIMITIVE, modelObject.getDeveloperDep()));
        e.addProperty(new Property(null, "IzmNum", ValueType.PRIMITIVE, modelObject.getIzmNum()));
        e.addProperty(new Property(null, "Status", ValueType.PRIMITIVE, modelObject.getStatus()));
        e.addProperty(new Property(null, "IsActual", ValueType.PRIMITIVE, modelObject.isActual()));

        e.setId(createId(SvcmEdmCore.ES_DOCUMENTS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public Document convertFromEntity(Document item, Entity entity) throws ODataApplicationException {
        Document result;
        if (item == null) {
            result = new Document();
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
            } else if (propertyName.equals("DocsetId")) {
                if (!prop.isNull())
                    result.setDocsetId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Cipher")) {
                result.setCipher(propertyText);
            } else if (propertyName.equals("DoccodeId")) {
                if (!prop.isNull())
                    result.setDoccodeId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else if (propertyName.equals("DeveloperDep")) {
                result.setDeveloperDep(propertyText);
            } else if (propertyName.equals("IzmNum")) {
                if (!prop.isNull())
                    result.setIzmNum(parseIdFromString(propertyText));
            } else if (propertyName.equals("Status")) {
                result.setStatus(propertyText);
            } else if (propertyName.equals("IsActual")) {
                result.setActual(Boolean.parseBoolean(propertyText));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName,
                        SvcmEdmCore.ET_DOCUMENT_NAME);
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
        if (entitySetName.equals(SvcmEdmCore.ES_DOCSETS_NAME)) {
            DocsetData docsetData = new DocsetData();
            Docset docsetItem = docsetData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((DocumentRepo) repo).getByDocset(docsetItem));
        }
        return entityCollection;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_MFILES_NAME)) {
            MFileData mFileData = new MFileData();
            MFile mFileItem = mFileData.convertFromEntity(parentEntity);
            Long id = mFileItem.getParentObjectId();
            if (id != null) {
                Document item = repo.getById(id);
                if (item != null)
                    result = convertToEntity(item);
            }
        }
        return result;
    }

    @Override
    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmCore.ES_DOCSETS_NAME) ) {
            DocsetData pDocsetData = new DocsetData();
            Docset pDocsetItem = pDocsetData.convertFromEntity(targetEntity);
            Long pDocsetId = pDocsetItem.getId();
            Document pDocumentItem = convertFromEntity(parentEntity);
            pDocumentItem.setDocsetId(pDocsetId);
            long id = pDocumentItem.getId();
            repo.update(id, pDocumentItem);
        }
    }

    @Override
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException {
        String parentEntitySetName = parentEntitySet.getName();
        if (parentEntitySetName.equals(SvcmEdmCore.ES_DOCSETS_NAME)) {
            Document item = convertFromEntity(navEntity);
            item.setDocsetId(null);
            repo.update(item.getId(), item);
        }
    }

}
