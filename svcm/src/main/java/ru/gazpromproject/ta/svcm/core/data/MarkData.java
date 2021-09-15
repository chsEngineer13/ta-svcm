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

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.model.Mark;
import ru.gazpromproject.ta.svcm.core.repo.pg.MarkRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class MarkData extends AbstractEntityData<Mark> implements EntityStorageData {

    public MarkData() {
        repo = new MarkRepoPg(Mark.class);
    }

    @Override
    public Entity convertToEntity(Mark mark) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, mark.getId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, mark.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, mark.getName()))
                .addProperty(new Property(null, "Comment", ValueType.PRIMITIVE, mark.getComment()))
                .addProperty(new Property(null, "IsAdditional", ValueType.PRIMITIVE, mark.getIsAdditional()));
        e.setId(createId(SvcmEdmCore.ES_MARKS_NAME, mark.getId()));
        return e;
    }

    @Override
    public Mark convertFromEntity(Mark item, Entity entity) throws ODataApplicationException {
        Mark result;
        if (item == null) {
            result = new Mark();
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
            } else if (propertyName.equals("Comment")) {
                result.setComment(propertyText);
            } else if (propertyName.equals("IsAdditional")) {
                result.setIsAdditional(Boolean.parseBoolean(propertyText));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_MARK_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_DOCSETS_NAME)) {
            DocsetData docsetData = new DocsetData();
            Docset docset = docsetData.convertFromEntity(parentEntity);

            Long id = null;
            if (keyParams != null)
                id = getIdFromParams(keyParams);
            else
                id = docset.getMarkRefId();
            if (id == null)
                return result;
            final Mark item = repo.getById(id);
            if (item != null && item.getId() > 0) {
                result = convertToEntity(item);
            }
        }
        return result;
    }
}
