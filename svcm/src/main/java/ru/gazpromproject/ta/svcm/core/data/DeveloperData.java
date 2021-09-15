package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Developer;
import ru.gazpromproject.ta.svcm.core.repo.pg.DeveloperRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class DeveloperData extends AbstractEntityData<Developer> implements EntityStorageData {

    public DeveloperData() {
        repo = new DeveloperRepoPg(Developer.class);
    }

    @Override
    public Entity convertToEntity(Developer developer) {
        final Entity e = new Entity()
                .addProperty(new Property(null, "Id", ValueType.PRIMITIVE, developer.getId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, developer.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, developer.getName()))
                .addProperty(new Property(null, "ShortName", ValueType.PRIMITIVE, developer.getShortName()));
        e.setId(createId(SvcmEdmCore.ES_DEVELOPERS_NAME, developer.getId()));
        return e;
    }

    @Override
    public Developer convertFromEntity(Developer item, Entity entity) throws ODataApplicationException {
        Developer result;
        if (item == null) {
            result = new Developer();
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
            } else if (propertyName.equals("ShortName")) {
                result.setShortName(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_DEVELOPER_NAME);
                throw new ODataApplicationException(err_msg
                        , HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode()
                        , Locale.ENGLISH);
            }
        }
        return result;
    }       
}
