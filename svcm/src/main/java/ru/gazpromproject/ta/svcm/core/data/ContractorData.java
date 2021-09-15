package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Contractor;
import ru.gazpromproject.ta.svcm.core.repo.pg.ContractorRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class ContractorData extends AbstractEntityData<Contractor> implements EntityStorageData {

    public ContractorData() {
        repo = new ContractorRepoPg(Contractor.class);
    }

    @Override
    public Entity convertToEntity(Contractor contractor) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, contractor.getId()))
                .addProperty(new Property(null, "CustomerCode", ValueType.PRIMITIVE, contractor.getCustomerCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, contractor.getName()));
        e.setId(createId(SvcmEdmCore.ES_BUILDINGS_NAME, contractor.getId()));
        return e;
    }

    @Override
    public Contractor convertFromEntity(Contractor item, Entity entity) throws ODataApplicationException {
        Contractor result;
        if (item == null) {
            result = new Contractor();
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
            } else if (propertyName.equals("CustomerCode")) {
                result.setCustomerCode(propertyText);
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_CONTRACTOR_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }
}
