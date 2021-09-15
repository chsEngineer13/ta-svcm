package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Construction;
import ru.gazpromproject.ta.svcm.core.repo.pg.ConstructionRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;;

public class ConstructionData extends AbstractEntityData<Construction> implements EntityStorageData {

    public ConstructionData() {
        repo = new ConstructionRepoPg(Construction.class);
    }

    @Override
    public Entity convertToEntity(Construction construction) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, construction.getId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, construction.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, construction.getName()));
        e.setId(createId(SvcmEdmCore.ES_CONSTRUCTIONS_NAME, construction.getId()));
        return e;
    }

    @Override
    public Construction convertFromEntity(Construction item, Entity entity) throws ODataApplicationException {
        Construction result;
        if (item == null) {
            result = new Construction();
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
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_CONSTRUCTION_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }
}
