package ru.gazpromproject.ta.svcm.stream.data;

import java.util.ArrayList;
import java.util.Date;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;

public abstract class StreamData<T extends StreamModelBase> extends AbstractEntityData<T> {

    public abstract ArrayList<Property> getSpecificProperties(T modelObject) throws ODataApplicationException;

    protected String entity_set_name;

    @Override
    public Entity convertToEntity(T modelObject) throws ODataApplicationException {
        final Entity e = new Entity();
        ArrayList<Property> props = getProperties(modelObject);
        if (props != null) {
            for (Property prop : props) {
                e.addProperty(prop);
            }
        }
        e.setId(createId(entity_set_name, modelObject.getId()));
        return e;
    }

    protected boolean setStreamBaseProperty(T modelObject, Property prop, String propertyName, String propertyText)
            throws ODataApplicationException {
        if (propertyName.equals("Id")) {
            modelObject.setId(parseIdFromString(propertyText));
        } else if (propertyName.equals("Hid")) {
            if (!prop.isNull())
                modelObject.setHid(parseIdFromString(propertyText));
        } else if (propertyName.equals("Hguid")) {
            modelObject.setHidGuid(parseUUID(propertyText));
        } else if (propertyName.equals("HidStr")) {
            modelObject.setHidStr(propertyText);
        } else if (propertyName.equals("TimeModified")) {
            if (!prop.isNull())
                modelObject.setObjectTime((Date)prop.getValue());
        } else if (propertyName.equals("InsertTime")) {
            if (!prop.isNull())
                modelObject.setInsertTime((Date)prop.getValue());
        } else {
            return false;
        }
        return true;
    }

    protected ArrayList<Property> getProperties(T modelObject) throws ODataApplicationException {
        ArrayList<Property> base_props = getStreamBaseProperties(modelObject);
        ArrayList<Property> spec_props = getSpecificProperties(modelObject);
        ArrayList<Property> result = new ArrayList<Property>();
        result.addAll(base_props);
        result.addAll(spec_props);
        return result;
    }

    protected ArrayList<Property> getStreamBaseProperties(T modelObject) throws ODataApplicationException {
        ArrayList<Property> base_props = new ArrayList<Property>();
        base_props.add(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()));
        base_props.add(new Property(null, "Hid", ValueType.PRIMITIVE, modelObject.getHid()));
        base_props.add(new Property(null, "Hguid", ValueType.PRIMITIVE, modelObject.getHidGuid()));
        base_props.add(new Property(null, "HidStr", ValueType.PRIMITIVE, modelObject.getHidStr()));
        base_props.add(new Property(null, "TimeModified", ValueType.PRIMITIVE, modelObject.getObjectTime()));
        base_props.add(new Property(null, "InsertTime", ValueType.PRIMITIVE, modelObject.getInsertTime()));
        return base_props;
    }
}
