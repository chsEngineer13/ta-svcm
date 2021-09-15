package ru.gazpromproject.ta.svcm.core.data;

import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpMethod;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriParameter;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.SummaryConstruction;
import ru.gazpromproject.ta.svcm.core.repo.pg.SummaryConstructionRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class SummaryConstructionData extends AbstractEntityData<SummaryConstruction> implements EntityStorageData {

    public SummaryConstructionData() {
        repo = new SummaryConstructionRepoPg(SummaryConstruction.class);
    }

    @Override
    public Entity createItem(Entity requestEntity) throws ODataApplicationException {
        throw new ODataApplicationException("Method 'createItem' not allowed for 'SummaryConstruction' entity.",
                HttpStatusCode.METHOD_NOT_ALLOWED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public void updateItem(List<UriParameter> keyParams, Entity requestEntity, HttpMethod httpMethod)
            throws ODataApplicationException {
        throw new ODataApplicationException("Method 'updateItem' not allowed for 'SummaryConstruction' entity.",
                HttpStatusCode.METHOD_NOT_ALLOWED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public void deleteItem(List<UriParameter> keyParams) throws ODataApplicationException {
        throw new ODataApplicationException("Method 'deleteItem' not allowed for 'SummaryConstruction' entity.",
                HttpStatusCode.METHOD_NOT_ALLOWED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public Entity convertToEntity(SummaryConstruction modelObject) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()))
                .addProperty(new Property(null, "CObjectId", ValueType.PRIMITIVE, modelObject.getCObjectId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, modelObject.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()))
                .addProperty(new Property(null, "CntId", ValueType.PRIMITIVE, modelObject.getCntId()))
                .addProperty(new Property(null, "CntStart", ValueType.PRIMITIVE, modelObject.getCntStart()))
                .addProperty(new Property(null, "CntFinish", ValueType.PRIMITIVE, modelObject.getCntFinish()))
                .addProperty(new Property(null, "CntInvoice", ValueType.PRIMITIVE, modelObject.getCntInvoice()));
        e.setId(createId(SvcmEdmCore.ES_SUMMARYCONSTRUCTIONS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public SummaryConstruction convertFromEntity(SummaryConstruction item, Entity entity) throws ODataApplicationException {
        SummaryConstruction result = new SummaryConstruction();
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
            } else if (propertyName.equals("Code")) {
                result.setCode(propertyText);
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else if (propertyName.equals("CntId")) {
                if (!prop.isNull())
                    result.setCntId(parseIdFromString(propertyText));
            } else if (propertyName.equals("CntStart")) {
                if (!prop.isNull())
                    result.setCntStart(parseIdFromString(propertyText));
            } else if (propertyName.equals("CntFinish")) {
                if (!prop.isNull())
                    result.setCntFinish(parseIdFromString(propertyText));
            } else if (propertyName.equals("CntInvoice")) {
                if (!prop.isNull())
                    result.setCntInvoice(parseIdFromString(propertyText));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_SUMMARYCONSTRUCTION_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

}
