package ru.gazpromproject.ta.svcm.stream.data;

import java.util.ArrayList;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.stream.SvcmEdmStream;
import ru.gazpromproject.ta.svcm.stream.model.StreamBuilding;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamBuildingRepoPg;

public class StreamBuildingData extends StreamDataParent<StreamBuilding> implements EntityStorageData {

    public StreamBuildingData() {
        repo = new StreamBuildingRepoPg();
        entity_set_name = SvcmEdmStream.ES_STREAM_BUILDINGS_NAME;
    }

    @Override
    public ArrayList<Property> getSpecificProperties(StreamBuilding modelObject) {
        ArrayList<Property> spec_props = new ArrayList<Property>();
        spec_props.add(new Property(null, "HContractId", ValueType.PRIMITIVE, modelObject.getHcontractId()));
        spec_props.add(new Property(null, "HContractGuid", ValueType.PRIMITIVE, modelObject.getHcontractIdGuid()));
        spec_props.add(new Property(null, "HContractIdStr", ValueType.PRIMITIVE, modelObject.getHcontractIdStr()));

        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_CODE.getName(), ValueType.PRIMITIVE,
                modelObject.getCode()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_NUMBER.getName(), ValueType.PRIMITIVE,
                modelObject.getNumber()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_NAME.getName(), ValueType.PRIMITIVE,
                modelObject.getName()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_GIP.getName(), ValueType.PRIMITIVE,
                modelObject.getGip()));
        return spec_props;
    }

    @Override
    public StreamBuilding convertFromEntity(StreamBuilding item, Entity entity) throws ODataApplicationException {
        StreamBuilding result;
        if (item == null) {
            result = new StreamBuilding();
        } else {
            result = item;
        }
        for (Property prop : entity.getProperties()) {
            String propertyName = prop.getName();
            String propertyText = null;
            if (!prop.isNull())
                propertyText = prop.getValue().toString();
            if (setStreamBaseProperty(result, prop, propertyName, propertyText))
                continue;
            if (setStreamBaseParentProperty(result, prop, propertyName, propertyText))
                continue;

            if (propertyName.equals("HContractId")) {
                result.setHcontractId(parseIdFromString(propertyText));
            } else if (propertyName.equals("HContractGuid")) {
                result.setHcontractIdGuid(parseUUID(propertyText));
            } else if (propertyName.equals("HContractIdStr")) {
                result.setHcontractIdStr(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_CODE.getName())) {
                result.setCode(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_NUMBER.getName())) {
                result.setNumber(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_NAME.getName())) {
                result.setName(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_GIP.getName())) {
                result.setGip(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName,
                        SvcmEdmStream.ET_STREAM_BUILDING_NAME);
                throw new ODataApplicationException(err_msg, HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(),
                        Locale.ENGLISH);
            }
        }
        return result;
    }
}
