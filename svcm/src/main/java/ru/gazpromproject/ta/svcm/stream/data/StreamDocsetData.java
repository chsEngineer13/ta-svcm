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
import ru.gazpromproject.ta.svcm.stream.model.StreamDocset;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamDocsetRepoPg;

public class StreamDocsetData extends StreamDataParent<StreamDocset> implements EntityStorageData {

    public StreamDocsetData() {
        repo = new StreamDocsetRepoPg();
        entity_set_name = SvcmEdmStream.ES_STREAM_DOCSETS_NAME;
    }

    @Override
    public ArrayList<Property> getSpecificProperties(StreamDocset modelObject) {
        ArrayList<Property> spec_props = new ArrayList<Property>();
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_NAME.getName(), ValueType.PRIMITIVE,
                modelObject.getName()));
        spec_props.add(new Property(null, "Cipher", ValueType.PRIMITIVE, modelObject.getCipher()));
        spec_props.add(new Property(null, "DevDep", ValueType.PRIMITIVE, modelObject.getDevDep()));
        spec_props.add(new Property(null, "OipKs", ValueType.PRIMITIVE, modelObject.getOipKs()));
        spec_props.add(new Property(null, "CustomerCode", ValueType.PRIMITIVE, modelObject.getCustomerCode()));
        spec_props.add(new Property(null, "ContractNumber", ValueType.PRIMITIVE, modelObject.getContractNumber()));
        spec_props.add(new Property(null, "CipherStage", ValueType.PRIMITIVE, modelObject.getCipherStage()));
        spec_props.add(new Property(null, "Developer", ValueType.PRIMITIVE, modelObject.getDeveloper()));
        spec_props.add(new Property(null, "ConstrPartCode", ValueType.PRIMITIVE, modelObject.getConstrPartCode()));
        spec_props.add(new Property(null, "ConstrPartNumber", ValueType.PRIMITIVE, modelObject.getConstrPartNumber()));
        spec_props.add(new Property(null, "BuildingCode", ValueType.PRIMITIVE, modelObject.getBuildingCode()));
        spec_props.add(new Property(null, "BuildingNumber", ValueType.PRIMITIVE, modelObject.getBuildingNumber()));
        spec_props.add(new Property(null, "Mark", ValueType.PRIMITIVE, modelObject.getMark()));
        spec_props.add(new Property(null, "MarkPath", ValueType.PRIMITIVE, modelObject.getMarkPath()));
        spec_props.add(new Property(null, "Stage", ValueType.PRIMITIVE, modelObject.getStage()));
        spec_props.add(new Property(null, "ContractStage", ValueType.PRIMITIVE, modelObject.getContractStage()));
        spec_props.add(new Property(null, "Changeset", ValueType.PRIMITIVE, modelObject.getChangeset()));
        spec_props.add(new Property(null, "Status", ValueType.PRIMITIVE, modelObject.getStatus()));
        spec_props.add(new Property(null, SvcmEdmStream.STREAM_PROPERTY_GIP.getName(), ValueType.PRIMITIVE,
                modelObject.getGip()));
        return spec_props;
    }

    @Override
    public StreamDocset convertFromEntity(StreamDocset item, Entity entity) throws ODataApplicationException {
        StreamDocset result;
        if (item == null) {
            result = new StreamDocset();
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

            if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_NAME.getName())) {
                result.setName(propertyText);
            } else if (propertyName.equals("Cipher")) {
                result.setCipher(propertyText);
            } else if (propertyName.equals("DevDep")) {
                result.setDevDep(propertyText);
            } else if (propertyName.equals("OipKs")) {
                result.setOipKs(propertyText);
            } else if (propertyName.equals("CustomerCode")) {
                result.setCustomerCode(propertyText);
            } else if (propertyName.equals("ContractNumber")) {
                result.setContractNumber(propertyText);
            } else if (propertyName.equals("CipherStage")) {
                result.setCipherStage(propertyText);
            } else if (propertyName.equals("Developer")) {
                result.setDeveloper(propertyText);
            } else if (propertyName.equals("ConstrPartCode")) {
                result.setConstrPartCode(propertyText);
            } else if (propertyName.equals("ConstrPartNumber")) {
                result.setConstrPartNumber(propertyText);
            } else if (propertyName.equals("BuildingCode")) {
                result.setBuildingCode(propertyText);
            } else if (propertyName.equals("BuildingNumber")) {
                result.setBuildingNumber(propertyText);
            } else if (propertyName.equals("Mark")) {
                result.setMark(propertyText);
            } else if (propertyName.equals("MarkPath")) {
                result.setMarkPath(propertyText);
            } else if (propertyName.equals("Stage")) {
                result.setStage(propertyText);
            } else if (propertyName.equals("ContractStage")) {
                result.setContractStage(propertyText);
            } else if (propertyName.equals("Changeset")) {
                result.setChangeset(propertyText);
            } else if (propertyName.equals("Status")) {
                result.setStatus(propertyText);
            } else if (propertyName.equals(SvcmEdmStream.STREAM_PROPERTY_GIP.getName())) {
                result.setGip(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName,
                        SvcmEdmStream.ET_STREAM_CONSTRPART_NAME);
                throw new ODataApplicationException(err_msg, HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(),
                        Locale.ENGLISH);
            }
        }
        return result;
    }

}
