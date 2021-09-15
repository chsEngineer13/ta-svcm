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
import ru.gazpromproject.ta.svcm.stream.model.StreamContract;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamContractRepoPg;

public class StreamContractData extends StreamData<StreamContract> implements EntityStorageData {

    public StreamContractData() {
        repo = new StreamContractRepoPg();
        entity_set_name = SvcmEdmStream.ES_STREAM_CONTRACTS_NAME;
    }

    @Override
    public ArrayList<Property> getSpecificProperties(StreamContract modelObject) throws ODataApplicationException {
        ArrayList<Property> spec_props = new ArrayList<Property>();
        spec_props.add(new Property(null, "CustomerCode", ValueType.PRIMITIVE,
                modelObject.getContractorCode()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_NUMBER.getName(), ValueType.PRIMITIVE,
                modelObject.getInnerNumber()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_NAME.getName(), ValueType.PRIMITIVE,
                modelObject.getName()));
        spec_props.add(new Property(null, "ContractDate", ValueType.PRIMITIVE,
                modelObject.getContractDate()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_GIP.getName(), ValueType.PRIMITIVE,
                modelObject.getGip()));
        return spec_props;
    }

    @Override
    public StreamContract convertFromEntity(StreamContract item, Entity entity) throws ODataApplicationException {
        StreamContract result;
        if (item == null) {
            result = new StreamContract();
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

            if (propertyName.equals("CustomerCode")) {
                result.setContractorCode(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_NUMBER.getName())) {
                result.setInnerNumber(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_NAME.getName())) {
                result.setName(propertyText);
            } else if (propertyName.equals("ContractDate")) {
                result.setContractDate(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_GIP.getName())) {
                result.setGip(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName,
                        SvcmEdmStream.ET_STREAM_CONTRACT_NAME);
                throw new ODataApplicationException(err_msg, HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(),
                        Locale.ENGLISH);
            }
        }
        return result;
    }
}
