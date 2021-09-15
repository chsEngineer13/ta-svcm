package ru.gazpromproject.ta.svcm.sys.data;

import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriParameter;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.model.AclRoleFunction;
import ru.gazpromproject.ta.svcm.sys.repo.AclFunctionRepo;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclFunctionRepoPg;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclRoleFunctionRepoPg;

public class AclFunctionData extends AbstractEntityData<AclFunction> implements EntityStorageData {

    public AclFunctionData() {
        repo = new AclFunctionRepoPg(AclFunction.class);
    }

    @Override
    public Entity convertToEntity(AclFunction aclFunction) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, aclFunction.getId()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, aclFunction.getName()))
                .addProperty(new Property(null, "Descr", ValueType.PRIMITIVE, aclFunction.getDescr()));
        e.setId(createId(SvcmEdmSys.ES_FUNCS_NAME, aclFunction.getId()));
        return e;
    }

    @Override
    public AclFunction convertFromEntity(AclFunction item, Entity entity) throws ODataApplicationException {
        AclFunction result;
        if (item == null) {
            result = new AclFunction();
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
                        , SvcmEdmSys.ET_FUNC_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmSys.ES_ACCOUNTS_NAME)) {
            AclAccountData aclData = new AclAccountData();
            AclAccount parentItem = aclData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(
                    ((AclFunctionRepo) repo).getFunctionsByAccount(parentItem));
        }
        if (entitySetName.equals(SvcmEdmSys.ES_ROLES_NAME)) {
            AclRoleData aclData = new AclRoleData();
            AclRole parentItem = aclData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((AclFunctionRepo) repo).getFunctionsByRole(parentItem));
        }
        return entityCollection;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmSys.ES_ROLES_NAME)) {
            AclRoleData roleData = new AclRoleData();
            AclRole roleItem = roleData.convertFromEntity(parentEntity);
            long id = getIdFromParams(keyParams);
            AclFunction functionItem = repo.getById(id);
            AclRoleFunctionRepoPg rfRepo = new AclRoleFunctionRepoPg(AclRoleFunction.class);
            AclRoleFunction rfItem = rfRepo.getByRoleFunction(roleItem, functionItem);
            if (rfItem != null)
                result = convertToEntity(functionItem);
        }
        return result;
    }

}
