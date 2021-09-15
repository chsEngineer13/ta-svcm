package ru.gazpromproject.ta.svcm.sys.data;

import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriParameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclAccountRole;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.model.AclRoleFunction;
import ru.gazpromproject.ta.svcm.sys.repo.AclRoleRepo;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclAccountRoleRepoPg;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclRoleFunctionRepoPg;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclRoleRepoPg;

public class AclRoleData extends AbstractEntityData<AclRole> implements EntityStorageData {

    private static final Logger logger = LoggerFactory.getLogger(AclRoleData.class);

    public AclRoleData() {
        repo = new AclRoleRepoPg(AclRole.class);
    }

    @Override
    public Entity convertToEntity(AclRole aclRole) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, aclRole.getId()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, aclRole.getName()))
                .addProperty(new Property(null, "Descr", ValueType.PRIMITIVE, aclRole.getDescr()));
        e.setId(createId(SvcmEdmSys.ES_ROLES_NAME, aclRole.getId()));
        return e;
    }

    @Override
    public AclRole convertFromEntity(AclRole item, Entity entity) throws ODataApplicationException {
        AclRole result;
        if (item == null) {
            result = new AclRole();
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
                        , SvcmEdmSys.ET_ROLE_NAME);
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
            entityCollection = convertItemsToEntityCollection(((AclRoleRepo) repo).getRolesByAccount(parentItem));
        }
        if (entitySetName.equals(SvcmEdmSys.ES_FUNCS_NAME)) {
            AclFunctionData aclData = new AclFunctionData();
            AclFunction parentItem = aclData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((AclRoleRepo) repo).getRolesByFunction(parentItem));
        }
        return entityCollection;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmSys.ES_FUNCS_NAME)) {
            AclFunctionData functionData = new AclFunctionData();
            AclFunction functionItem = functionData.convertFromEntity(parentEntity);
            long id = getIdFromParams(keyParams);
            AclRole roleItem = repo.getById(id);
            AclRoleFunctionRepoPg rfRepo = new AclRoleFunctionRepoPg(AclRoleFunction.class);
            AclRoleFunction rfItem = rfRepo.getByRoleFunction(roleItem, functionItem);
            if (rfItem != null)
                result = convertToEntity(roleItem);
        }
        if (entitySetName.equals(SvcmEdmSys.ES_ACCOUNTS_NAME)) {
            AclAccountData accountData = new AclAccountData();
            AclAccount accountItem = accountData.convertFromEntity(parentEntity);
            long id = getIdFromParams(keyParams);
            AclRole roleItem = repo.getById(id);
            AclAccountRoleRepoPg arRepo = new AclAccountRoleRepoPg(AclAccountRole.class);
            AclAccountRole arItem = arRepo.getByAccountRole(accountItem, roleItem);
            if (arItem != null)
                result = convertToEntity(roleItem);
        }
        return result;
    }

    @Override
    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmSys.ES_FUNCS_NAME)) {
            AclRole roleItem = convertFromEntity(parentEntity);
            AclFunctionData functionData = new AclFunctionData();
            AclFunction functionItem = functionData.convertFromEntity(targetEntity);
            AclRoleFunctionRepoPg rfRepo = new AclRoleFunctionRepoPg(AclRoleFunction.class);
            AclRoleFunction rfItem = new AclRoleFunction();
            rfItem.setRoleId(roleItem.getId());
            rfItem.setFunctionId(functionItem.getId());
            try {
                rfRepo.create(rfItem);
            } catch (Exception e) {
                logger.error(String.format("Error add to acl_role_function. %s", e.toString()));
                throw e;
            }
        }
        if (targetSetName.equals(SvcmEdmSys.ES_ACCOUNTS_NAME)) {
            AclRole roleItem = convertFromEntity(parentEntity);
            AclAccountData accountData = new AclAccountData();
            AclAccount accountItem = accountData.convertFromEntity(targetEntity);
            AclAccountRoleRepoPg arRepo = new AclAccountRoleRepoPg(AclAccountRole.class);
            AclAccountRole arItem = new AclAccountRole();
            arItem.setAccountId(accountItem.getId());
            arItem.setRoleId(roleItem.getId());
            try {
                arRepo.create(arItem);
            } catch (Exception e) {
                logger.error(String.format("Error add to acl_account_role. %s", e.toString()));
                throw e;
            }
        }
    }

    @Override
    public void setRelatedLinks(Entity parentEntity, EdmEntitySet targetSet, List<Entity> targetEntities)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();

        if (targetSetName.equals(SvcmEdmSys.ES_FUNCS_NAME) || targetSetName.equals(SvcmEdmSys.ES_ACCOUNTS_NAME)) {
            for (Entity targetEntity : targetEntities) {
                setRelatedLink(parentEntity, targetSet, targetEntity);
            }
        }
    }

    @Override
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException {
        String parentSetName = parentEntitySet.getName();
        if (parentSetName.equals(SvcmEdmSys.ES_FUNCS_NAME)) {
            AclFunctionData functionData = new AclFunctionData();
            AclFunction functionItem = functionData.convertFromEntity(parentEntity);
            AclRole roleItem = convertFromEntity(navEntity);
            AclRoleFunctionRepoPg rfRepo = new AclRoleFunctionRepoPg(AclRoleFunction.class);
            AclRoleFunction rfItem = rfRepo.getByRoleFunction(roleItem, functionItem);
            if (rfItem != null) {
                rfRepo.delete(rfItem.getId());
            }
        }
        if (parentSetName.equals(SvcmEdmSys.ES_ACCOUNTS_NAME)) {
            AclAccountData accountData = new AclAccountData();
            AclAccount accountItem = accountData.convertFromEntity(parentEntity);
            AclRole roleItem = convertFromEntity(navEntity);
            AclAccountRoleRepoPg arRepo = new AclAccountRoleRepoPg(AclAccountRole.class);
            AclAccountRole arItem = arRepo.getByAccountRole(accountItem, roleItem);
            if (arItem != null)
                arRepo.delete(arItem.getId());
        }
    }
}
