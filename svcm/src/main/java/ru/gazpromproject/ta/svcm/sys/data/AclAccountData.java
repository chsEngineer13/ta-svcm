package ru.gazpromproject.ta.svcm.sys.data;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
import ru.gazpromproject.ta.svcm.sys.AccountHolder;
import ru.gazpromproject.ta.svcm.sys.CredentialsHolder;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclAccountRole;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.model.LogEvent;
import ru.gazpromproject.ta.svcm.sys.repo.AclAccountRepo;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclAccountRepoPg;
import ru.gazpromproject.ta.svcm.sys.repo.pg.AclAccountRoleRepoPg;

public class AclAccountData extends AbstractEntityData<AclAccount> implements EntityStorageData {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(AclAccountData.class);

    public AclAccountData() {
        repo = new AclAccountRepoPg(AclAccount.class);
    }

    @Override
    public Entity convertToEntity(AclAccount acc) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, acc.getId()))
                .addProperty(new Property(null, "Login", ValueType.PRIMITIVE, acc.getLogin()))
                .addProperty(new Property(null, "Pwd", ValueType.PRIMITIVE, acc.getPassword()))
                .addProperty(new Property(null, "FirstName", ValueType.PRIMITIVE, acc.getFirstName()))
                .addProperty(new Property(null, "MiddleName", ValueType.PRIMITIVE, acc.getMiddleName()))
                .addProperty(new Property(null, "LastName", ValueType.PRIMITIVE, acc.getLastName()))
                .addProperty(new Property(null, "TabNum", ValueType.PRIMITIVE, acc.getTabNum()))
                .addProperty(new Property(null, "Email", ValueType.PRIMITIVE, acc.getEmail()))
                .addProperty(new Property(null, "IsActive", ValueType.PRIMITIVE, acc.isIsActive()));
        e.setId(createId(SvcmEdmSys.ES_ACCOUNTS_NAME, acc.getId()));
        return e;
    }

    @Override
    public AclAccount convertFromEntity(AclAccount item, Entity entity) throws ODataApplicationException {
        AclAccount result;
        if (item == null) {
            result = new AclAccount();
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
            } else if (propertyName.equals("Login")) {
                result.setLogin(propertyText);
            } else if (propertyName.equals("Pwd")) {
                result.setPassword(propertyText);
            } else if (propertyName.equals("FirstName")) {
                result.setFirstName(propertyText);
            } else if (propertyName.equals("MiddleName")) {
                result.setMiddleName(propertyText);
            } else if (propertyName.equals("LastName")) {
                result.setLastName(propertyText);
            } else if (propertyName.equals("TabNum")) {
                result.setTabNum(propertyText);
            } else if (propertyName.equals("Email")) {
                result.setEmail(propertyText);
            } else if (propertyName.equals("IsActive")) {
                result.setIsActive(Boolean.parseBoolean(propertyText));
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmSys.ET_ACCOUNT_NAME);
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
        if (entitySetName.equals(SvcmEdmSys.ES_ROLES_NAME)) {
            AclRoleData aclData = new AclRoleData();
            AclRole parentItem = aclData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((AclAccountRepo) repo).getAccountsByRole(parentItem));
        }
        if (entitySetName.equals(SvcmEdmSys.ES_FUNCS_NAME)) {
            AclFunctionData aclData = new AclFunctionData();
            AclFunction parentItem = aclData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(
                    ((AclAccountRepo) repo).getAccountsByFunction(parentItem));
        }
        return entityCollection;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity) throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmSys.ES_LOGEVENTS_NAME)) {
            LogEventData data = new LogEventData();
            LogEvent item = data.convertFromEntity(parentEntity);
            Long id = item.getAccountId();
            if (id != null) {
                final AclAccount account = ((AclAccountRepo) repo).getById(id);
                if (account != null)
                    result = convertToEntity(account);
            }
        }
        return result;
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
            AclAccount accountItem = repo.getById(id);
            AclAccountRoleRepoPg arRepo = new AclAccountRoleRepoPg(AclAccountRole.class);
            AclAccountRole arItem = arRepo.getByAccountRole(accountItem, roleItem);
            if (arItem != null)
                result = convertToEntity(accountItem);
        }
        return result;
    }

    public AclAccount getMeAccount() throws ODataApplicationException {
        if (CredentialsHolder.BASIC_CREDENTIALS == null)
            throw new ODataApplicationException("Authentication required.", HttpStatusCode.UNAUTHORIZED.getStatusCode(),
                    Locale.ENGLISH, "TA-001");
        AclAccount currentAccount = AccountHolder.getCurrentAccount();
        if (currentAccount != null)
            return currentAccount;
        currentAccount = ((AclAccountRepoPg) repo).getByLogin(CredentialsHolder.BASIC_CREDENTIALS.getLogin());
        if (currentAccount == null) {
            throw new ODataApplicationException("Authentication failed.", HttpStatusCode.FORBIDDEN.getStatusCode(),
                    Locale.ENGLISH);
        } else {
            AccountHolder.setCurrentAccount(currentAccount);
        }
        return currentAccount;
    }

    public Entity getMe() throws ODataApplicationException {
        AclAccount item = getMeAccount();
        final Entity entity = convertToEntity(item);

        // Add event
        LogEventData eventData = new LogEventData();
        long tablePKID = item.getId();
        String details = String.format("{\"srcName\":\"%s\",\"srcPK\":\"%s\"}", item.getLogin(), tablePKID);
        eventData.addEvent("a", "sys", "Me", tablePKID, null, details, "User authentication");

        return entity;
    }

    public Boolean hasFunction(String functionName, String accountName) {
        return ((AclAccountRepo) repo).hasFunction(functionName, accountName);
    }

    public Boolean hasFunction(String functionName) throws ODataApplicationException {
        String accountName = getMeAccount().getLogin();
        return hasFunction(functionName, accountName);
    }
}
