package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Waybill;
import ru.gazpromproject.ta.svcm.core.repo.pg.WaybillRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class WaybillData extends AbstractEntityData<Waybill> implements EntityStorageData {

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(DocsetData.class);

    public WaybillData() {
        repo = new WaybillRepoPg(Waybill.class);
    }

    @Override
    public Entity convertToEntity(Waybill modelObject) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()))
                .addProperty(new Property(null, "WaybillNum", ValueType.PRIMITIVE, modelObject.getWaybillNum()))
                .addProperty(new Property(null, "WaybillDate", ValueType.PRIMITIVE, modelObject.getWaybillDate()))
                .addProperty(new Property(null, "Descr", ValueType.PRIMITIVE, modelObject.getDescr()));
        e.setId(createId(SvcmEdmCore.ES_WAYBILLS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public Waybill convertFromEntity(Waybill item, Entity entity) throws ODataApplicationException {
        Waybill result;
        if (item == null) {
            result = new Waybill();
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
            } else if (propertyName.equals("WaybillNum")) {
                result.setWaybillNum(propertyText);
            } else if (propertyName.equals("WaybillDate")) {
                if (!prop.isNull())
                    result.setWaybillDate(convertGregorianToDate(prop));
            } else if (propertyName.equals("Descr")) {
                result.setDescr(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_WAYBILL_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }
}
