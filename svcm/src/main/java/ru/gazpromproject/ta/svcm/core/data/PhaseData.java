package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Phase;
import ru.gazpromproject.ta.svcm.core.repo.pg.PhaseRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class PhaseData extends AbstractEntityData<Phase> implements EntityStorageData {
    public PhaseData() {
        repo = new PhaseRepoPg(Phase.class);
    }

    @Override
    public Entity convertToEntity(Phase modelObject) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, modelObject.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()));
        e.setId(createId(SvcmEdmCore.ES_PHASES_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public Phase convertFromEntity(Phase item, Entity entity) throws ODataApplicationException {
        Phase result;
        if (item == null) {
            result = new Phase();
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
                        , SvcmEdmCore.ET_PHASE_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

}
