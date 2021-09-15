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
import ru.gazpromproject.ta.svcm.stream.model.StreamConstruction;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamConstructionRepoPg;

public class StreamConstructionData extends StreamData<StreamConstruction> implements EntityStorageData {
    public StreamConstructionData() {
        repo = new StreamConstructionRepoPg();
        entity_set_name = SvcmEdmStream.ES_STREAM_CONSTRUCTIONS_NAME;
    }

    @Override
    public ArrayList<Property> getSpecificProperties(StreamConstruction modelObject) {
        ArrayList<Property> spec_props = new ArrayList<Property>();
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_CODE.getName(), ValueType.PRIMITIVE,
                modelObject.getCode()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_NAME.getName(), ValueType.PRIMITIVE,
                modelObject.getName()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_GIP.getName(), ValueType.PRIMITIVE,
                modelObject.getGip()));
        return spec_props;
    }

    @Override
    public StreamConstruction convertFromEntity(StreamConstruction item, Entity entity) throws ODataApplicationException {
        StreamConstruction result;
        if (item == null) {
            result = new StreamConstruction();
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

            if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_CODE.getName())) {
                result.setCode(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_NAME.getName())) {
                result.setName(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_GIP.getName())) {
                result.setGip(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName,
                        SvcmEdmStream.ET_STREAM_CONSTRUCTION_NAME);
                throw new ODataApplicationException(err_msg, HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(),
                        Locale.ENGLISH);
            }
        }
        return result;
    }
}
