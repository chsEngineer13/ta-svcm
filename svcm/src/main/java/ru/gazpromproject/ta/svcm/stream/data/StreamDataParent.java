package ru.gazpromproject.ta.svcm.stream.data;

import java.util.ArrayList;

import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.stream.model.StreamModelBaseParent;

public abstract class StreamDataParent<T extends StreamModelBaseParent> extends StreamData<T> {

    @Override
    protected ArrayList<Property> getProperties(T modelObject) throws ODataApplicationException {
        ArrayList<Property> result = super.getProperties(modelObject);
        result.addAll(this.getStreamBaseParentProperties(modelObject));
        return result;
    }

    protected ArrayList<Property> getStreamBaseParentProperties(T modelObject) {
        ArrayList<Property> props = new ArrayList<Property>();
        props.add(new Property(null, "HParentType", ValueType.PRIMITIVE, modelObject.getParentType()));
        props.add(new Property(null, "HPid", ValueType.PRIMITIVE, modelObject.getHpid()));
        props.add(new Property(null, "HPguid", ValueType.PRIMITIVE, modelObject.getHpid_guid()));
        props.add(new Property(null, "HPidStr", ValueType.PRIMITIVE, modelObject.getHpid_str()));
        return props;
    }

    protected boolean setStreamBaseParentProperty(T modelObject, Property prop, String propertyName,
            String propertyText) throws ODataApplicationException {
        if (propertyName.equals("HParentType")) {
            modelObject.setParentType(propertyText);
        } else if (propertyName.equals("HPid")) {
            if (!prop.isNull())
                modelObject.setHpid(parseIdFromString(propertyText));
        } else if (propertyName.equals("HPguid")) {
            modelObject.setHpid_guid(parseUUID(propertyText));
        } else if (propertyName.equals("HPidStr")) {
            modelObject.setHpid_str(propertyText);
        } else {
            return false;
        }
        return true;
    }
}
