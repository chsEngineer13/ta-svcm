package ru.gazpromproject.ta.svcm.sys;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.apache.olingo.commons.api.edm.EdmPrimitiveTypeKind;
import org.apache.olingo.commons.api.edm.FullQualifiedName;
import org.apache.olingo.commons.api.edm.provider.CsdlEntitySet;
import org.apache.olingo.commons.api.edm.provider.CsdlEntityType;
import org.apache.olingo.commons.api.edm.provider.CsdlEnumType;
import org.apache.olingo.commons.api.edm.provider.CsdlMapping;
import org.apache.olingo.commons.api.edm.provider.CsdlNavigationProperty;
import org.apache.olingo.commons.api.edm.provider.CsdlNavigationPropertyBinding;
import org.apache.olingo.commons.api.edm.provider.CsdlProperty;
import org.apache.olingo.commons.api.edm.provider.CsdlPropertyRef;
import org.apache.olingo.commons.api.edm.provider.CsdlSingleton;
import org.apache.olingo.commons.api.ex.ODataException;

import ru.gazpromproject.ta.svcm.base.AbstractSvcmEdm;
import ru.gazpromproject.ta.svcm.service.SvcmEdmProvider;

public class SvcmEdmSys extends AbstractSvcmEdm {
    // Entity Types Names
    public static final String ET_ACCOUNT_NAME = "AclAccount";
    public static final FullQualifiedName ET_ACCOUNT_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_ACCOUNT_NAME);
    public static final String ES_ACCOUNTS_NAME = "AclAccounts";

    public static final String ET_FUNC_NAME = "AclFunction";
    public static final FullQualifiedName ET_FUNC_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_FUNC_NAME);
    public static final String ES_FUNCS_NAME = "AclFunctions";

    public static final String ET_ROLE_NAME = "AclRole";
    public static final FullQualifiedName ET_ROLE_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_ROLE_NAME);
    public static final String ES_ROLES_NAME = "AclRoles";

    public static final String ET_GROUP_NAME = "AclGroup";
    public static final FullQualifiedName ET_GROUP_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_GROUP_NAME);
    public static final String ES_GROUPS_NAME = "AclGroups";

    public static final String ET_LOGEVENT_NAME = "LogEvent";
    public static final FullQualifiedName ET_LOGEVENT_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_LOGEVENT_NAME);
    public static final String ES_LOGEVENTS_NAME = "LogEvents";
    
    public static final String ST_ME_NAME = "Me";
    public static final FullQualifiedName ST_ME_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ST_ME_NAME);

    @Override
    public CsdlEntityType getEntityType(FullQualifiedName entityTypeName) throws ODataException {
        if (entityTypeName.equals(ET_ACCOUNT_FQN))
            return getAccountEntityType();
        else if (entityTypeName.equals(ET_FUNC_FQN))
            return getFuncEntityType();
        else if (entityTypeName.equals(ET_ROLE_FQN))
            return getRoleEntityType();
        else if (entityTypeName.equals(ET_GROUP_FQN))
            return getGroupEntityType();
        else if (entityTypeName.equals(ET_LOGEVENT_FQN))
            return getLogEventEntityType();
        return null;
    }

    @Override
    public List<CsdlEntityType> getEntityTypeList() throws ODataException {
        List<CsdlEntityType> entityTypes = new ArrayList<CsdlEntityType>();
        entityTypes.add(getEntityType(ET_ACCOUNT_FQN));
        entityTypes.add(getEntityType(ET_FUNC_FQN));
        entityTypes.add(getEntityType(ET_ROLE_FQN));
        entityTypes.add(getEntityType(ET_GROUP_FQN));
        entityTypes.add(getEntityType(ET_LOGEVENT_FQN));
        return entityTypes;
    }

    @Override
    public CsdlEntitySet getEntitySet(FullQualifiedName entityContainer, String entitySetName) throws ODataException {
        if (entityContainer.equals(SvcmEdmProvider.CNT_FQN)) {
            if (entitySetName.equals(ES_ACCOUNTS_NAME))
                return getAccountEntitySet(ES_ACCOUNTS_NAME, ET_ACCOUNT_FQN);
            else if (entitySetName.equals(ES_FUNCS_NAME))
                return getFunctionEntitySet(ES_FUNCS_NAME, ET_FUNC_FQN);
            else if (entitySetName.equals(ES_ROLES_NAME))
                return getRoleEntitySet(ES_ROLES_NAME, ET_ROLE_FQN);
            else if (entitySetName.equals(ES_GROUPS_NAME))
                return getStandardEntitySet(ES_GROUPS_NAME, ET_GROUP_FQN);
            else if (entitySetName.equals(ES_LOGEVENTS_NAME))
                return getLogEventEntitySet(ES_LOGEVENTS_NAME, ET_LOGEVENT_FQN);
        }
        return null;
    }

    @Override
    public List<CsdlEntitySet> getEntitySetList() throws ODataException {
        List<CsdlEntitySet> entitySets = new ArrayList<CsdlEntitySet>();
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_ACCOUNTS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_FUNCS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_ROLES_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_GROUPS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_LOGEVENTS_NAME));
        return entitySets;
    }

    @Override
    public CsdlSingleton getSingleton(FullQualifiedName entityContainer, String singletonName) throws ODataException {
        if (entityContainer.equals(SvcmEdmProvider.CNT_FQN)) {
            if (singletonName.equals(ST_ME_NAME))
                return getStandardSingleton(ST_ME_NAME, ET_ACCOUNT_FQN);
        }
        return null;
    }

    @Override
    public List<CsdlSingleton> getSingletonList() throws ODataException {
        List<CsdlSingleton> stn_list = new ArrayList<CsdlSingleton>();
        stn_list.add(getSingleton(SvcmEdmProvider.CNT_FQN, ST_ME_NAME));
        return stn_list;
    }

    @Override
    public CsdlEnumType getEnumType(FullQualifiedName enumTypeName) throws ODataException {
        return null;
    }

    @Override
    public List<CsdlEnumType> getEnumTypeList() throws ODataException {
        return null;
    }

    private CsdlEntityType getAccountEntityType() {
        CsdlProperty id = new CsdlProperty()
                .setName(SvcmEdmProvider.GEN_ID_NAME)
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("id"));
        CsdlProperty login = new CsdlProperty()
                .setName("Login")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())            
                .setMapping(new CsdlMapping().setInternalName("login"));                        
        CsdlProperty pwd = new CsdlProperty()
                .setName("Pwd")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("password"));
        CsdlProperty first_name = new CsdlProperty()
                .setName("FirstName")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("firstName"));
        CsdlProperty middle_name = new CsdlProperty()
                .setName("MiddleName")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("middleName"));
        CsdlProperty last_name = new CsdlProperty()
                .setName("LastName")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("lastName"));
        CsdlProperty tabnum = new CsdlProperty()
                .setName("TabNum")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("tabNum"));
        CsdlProperty email = new CsdlProperty()
                .setName("Email")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("email"));
        CsdlProperty is_active = new CsdlProperty()
                .setName("IsActive")
                .setType(EdmPrimitiveTypeKind.Boolean.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("isActive"));

        CsdlNavigationProperty roles = new CsdlNavigationProperty()
                .setName(ES_ROLES_NAME)
                .setType(ET_ROLE_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ES_ACCOUNTS_NAME);

        CsdlNavigationProperty functions = new CsdlNavigationProperty()
                .setName(ES_FUNCS_NAME)
                .setType(ET_FUNC_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ES_ACCOUNTS_NAME);

        CsdlNavigationProperty logEvents = new CsdlNavigationProperty()
                .setName(ES_LOGEVENTS_NAME)
                .setType(ET_LOGEVENT_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ET_ACCOUNT_NAME);
        
        CsdlPropertyRef idRef = new CsdlPropertyRef().setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_ACCOUNT_NAME);
        entityType.setProperties(
                Arrays.asList(id, login, pwd, first_name, middle_name, last_name, tabnum, email, is_active));
        entityType.setNavigationProperties(Arrays.asList(roles, functions, logEvents));
        entityType.setKey(Collections.singletonList(idRef));

        return entityType;
    }

    private CsdlEntityType getFuncEntityType() {
        CsdlProperty id = new CsdlProperty()
                .setName(SvcmEdmProvider.GEN_ID_NAME)
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("id"));
        CsdlProperty name = new CsdlProperty()
                .setName("Name")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("name"));
        CsdlProperty descr = new CsdlProperty()
                .setName("Descr")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("descr"));

        CsdlNavigationProperty accounts = new CsdlNavigationProperty()
                .setName(ES_ACCOUNTS_NAME)
                .setType(ET_ACCOUNT_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ES_FUNCS_NAME);

        CsdlNavigationProperty roles = new CsdlNavigationProperty()
                .setName(ES_ROLES_NAME)
                .setType(ET_ROLE_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ES_FUNCS_NAME);

        CsdlPropertyRef idRef = new CsdlPropertyRef().setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_FUNC_NAME);
        entityType.setProperties(Arrays.asList(id, name, descr));
        entityType.setNavigationProperties(Arrays.asList(accounts, roles));
        entityType.setKey(Collections.singletonList(idRef));

        return entityType;
    }

    private CsdlEntityType getRoleEntityType() {
        CsdlProperty id = new CsdlProperty()
                .setName(SvcmEdmProvider.GEN_ID_NAME)
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("id"));
        CsdlProperty name = new CsdlProperty()
                .setName("Name")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("name"));        
        CsdlProperty descr = new CsdlProperty()
                .setName("Descr")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("descr"));

        CsdlNavigationProperty accounts = new CsdlNavigationProperty()
                .setName(ES_ACCOUNTS_NAME)
                .setType(ET_ACCOUNT_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ES_ROLES_NAME);

        CsdlNavigationProperty functions = new CsdlNavigationProperty()
                .setName(ES_FUNCS_NAME)
                .setType(ET_FUNC_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ES_ROLES_NAME);

        CsdlPropertyRef idRef = new CsdlPropertyRef().setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_ROLE_NAME);
        entityType.setProperties(Arrays.asList(id, name, descr));
        entityType.setNavigationProperties(Arrays.asList(accounts, functions));
        entityType.setKey(Collections.singletonList(idRef));

        return entityType;
    }

    private CsdlEntityType getGroupEntityType() {
        CsdlProperty id = new CsdlProperty()
                .setName(SvcmEdmProvider.GEN_ID_NAME)
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("id"));
        CsdlProperty name = new CsdlProperty()
                .setName("Name")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("name"));
        CsdlProperty descr = new CsdlProperty()
                .setName("Descr")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("descr"));

        CsdlPropertyRef idRef = new CsdlPropertyRef().setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_GROUP_NAME);
        entityType.setProperties(Arrays.asList(id, name, descr));
        entityType.setKey(Collections.singletonList(idRef));

        return entityType;
    }

    private CsdlEntityType getLogEventEntityType() {
        CsdlProperty id = new CsdlProperty()
                .setName(SvcmEdmProvider.GEN_ID_NAME)
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("id"));
        CsdlProperty eventTime = new CsdlProperty()
                .setName("EventTime")
                .setType(EdmPrimitiveTypeKind.DateTimeOffset.getFullQualifiedName())
                .setPrecision(6)
                .setMapping(new CsdlMapping().setInternalName("eventTime"));                
        CsdlProperty tableSchema = new CsdlProperty()
                .setName("SchemaName")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("schemaName"));
        CsdlProperty tableName = new CsdlProperty()
                .setName("OperationName")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("operationName"));
        CsdlProperty pkId = new CsdlProperty()
                .setName("OperationPKId")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("operationPKId"));
        CsdlProperty pkTimeStamp = new CsdlProperty()
                .setName("OperationPKTime")
                .setType(EdmPrimitiveTypeKind.DateTimeOffset.getFullQualifiedName())
                .setPrecision(6)
                .setMapping(new CsdlMapping().setInternalName("operationPKId"));
        CsdlProperty details = new CsdlProperty()
                .setName("Details")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("details"));
        CsdlProperty descr = new CsdlProperty()
                .setName("Descr")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("descr"));

        CsdlNavigationProperty account = new CsdlNavigationProperty()
                .setName(ET_ACCOUNT_NAME)
                .setType(ET_ACCOUNT_FQN)
                .setNullable(true)
                .setPartner(ES_LOGEVENTS_NAME);
        
        CsdlPropertyRef idRef = new CsdlPropertyRef()
                .setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_LOGEVENT_NAME);
        entityType.setProperties(Arrays.asList(id, eventTime, tableSchema, tableName, pkId, pkTimeStamp, details, descr));
        entityType.setNavigationProperties(Arrays.asList(account));
        entityType.setKey(Collections.singletonList(idRef));

        return entityType;
    }

    private CsdlEntitySet getAccountEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        
        CsdlNavigationPropertyBinding roleBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_ROLES_NAME)
                .setTarget(ES_ROLES_NAME);
        CsdlNavigationPropertyBinding functionBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_FUNCS_NAME)
                .setTarget(ES_FUNCS_NAME);
        CsdlNavigationPropertyBinding logBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_LOGEVENTS_NAME)
                .setTarget(ES_LOGEVENTS_NAME);
        
        set.setNavigationPropertyBindings(Arrays.asList(roleBinding, functionBinding, logBinding));
        return set;
    }

    private CsdlEntitySet getRoleEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding accountBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_ACCOUNTS_NAME)
                .setTarget(ES_ACCOUNTS_NAME);
        CsdlNavigationPropertyBinding functionBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_FUNCS_NAME)
                .setTarget(ES_FUNCS_NAME);

        set.setNavigationPropertyBindings(Arrays.asList(accountBinding, functionBinding));
        return set;
    }

    private CsdlEntitySet getFunctionEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding accountBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_ACCOUNTS_NAME)
                .setTarget(ES_ACCOUNTS_NAME);
        CsdlNavigationPropertyBinding roleBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_ROLES_NAME)
                .setTarget(ES_ROLES_NAME);

        set.setNavigationPropertyBindings(Arrays.asList(accountBinding, roleBinding));
        return set;
    }

    private CsdlEntitySet getLogEventEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding accountBinding = new CsdlNavigationPropertyBinding()
                .setPath(ET_ACCOUNT_NAME)
                .setTarget(ES_ACCOUNTS_NAME);

        set.setNavigationPropertyBindings(Arrays.asList(accountBinding));        
        return set;
    }    
}
