package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.DocCode;
import ru.gazpromproject.ta.svcm.core.repo.pg.DocCodeRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class DocCodeData extends AbstractEntityData<DocCode> implements EntityStorageData {

    public DocCodeData() {
        repo = new DocCodeRepoPg(DocCode.class);
    }

    @Override
    public Entity convertToEntity(DocCode modelObject) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, modelObject.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()))
                .addProperty(new Property(null, "Additional", ValueType.PRIMITIVE, modelObject.getAdditional()))
                .addProperty(new Property(null, "NumericPart", ValueType.PRIMITIVE, modelObject.getNumericPart()));
        e.setId(createId(SvcmEdmCore.ES_DOCCODES_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public DocCode convertFromEntity(DocCode item, Entity entity) throws ODataApplicationException {
        DocCode result;
        if (item == null) {
            result = new DocCode();
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
            } else if (propertyName.equals("Additional")) {
                result.setAdditional(Boolean.parseBoolean(propertyText));
            } else if (propertyName.equals("NumericPart")) {
                result.setNumericPart(Boolean.parseBoolean(propertyText));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_DOCCODE_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

}
