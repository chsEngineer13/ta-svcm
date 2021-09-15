package ru.gazpromproject.ta.svcm.sys.data;

import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityStorage;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;

public class SysEntityStorage extends AbstractEntityStorage {
    @Override
    public EntityStorageData getEntityStorage(EdmEntitySet edmEntitySet) throws ODataApplicationException {
        EntityStorageData entityStorage = null;
        String entitySetName = edmEntitySet.getName();
        if (entitySetName.equals(SvcmEdmSys.ES_ACCOUNTS_NAME))
            entityStorage = (EntityStorageData) new AclAccountData();
        else if (entitySetName.equals(SvcmEdmSys.ES_FUNCS_NAME))
            entityStorage = (EntityStorageData) new AclFunctionData();
        else if (entitySetName.equals(SvcmEdmSys.ES_ROLES_NAME))
            entityStorage = (EntityStorageData) new AclRoleData();
        else if (entitySetName.equals(SvcmEdmSys.ES_GROUPS_NAME))
            entityStorage = (EntityStorageData) new AclGroupData();
        else if (entitySetName.equals(SvcmEdmSys.ES_LOGEVENTS_NAME))
            entityStorage = (EntityStorageData) new LogEventData();
        return entityStorage;
    }
}
