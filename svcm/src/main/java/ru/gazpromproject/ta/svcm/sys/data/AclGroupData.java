package ru.gazpromproject.ta.svcm.sys.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;
import ru.gazpromproject.ta.svcm.sys.model.AclGroup;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclGroupRepoPg;

public class AclGroupData extends AbstractEntityData<AclGroup> implements EntityStorageData {

    public AclGroupData() {
        repo = new AclGroupRepoPg(AclGroup.class);
    }

    @Override
    public Entity convertToEntity(AclGroup aclGroup) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, aclGroup.getId()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, aclGroup.getName()))
                .addProperty(new Property(null, "Descr", ValueType.PRIMITIVE, aclGroup.getDescr()));
        e.setId(createId(SvcmEdmSys.ES_GROUPS_NAME, aclGroup.getId()));
        return e;
    }

    @Override
    public AclGroup convertFromEntity(AclGroup item, Entity entity) throws ODataApplicationException {
        AclGroup result;
        if (item == null) {
            result = new AclGroup();
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
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else if (propertyName.equals("Descr")) {
                result.setDescr(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmSys.ET_GROUP_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

}
