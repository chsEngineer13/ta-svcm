package ru.gazpromproject.ta.svcm.data;

import java.util.List;

import org.apache.olingo.commons.api.edm.FullQualifiedName;
import org.apache.olingo.commons.api.edm.provider.CsdlEnumMember;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.data.CObjectTypeEnumData;

public class SvcmEnumStorage {
    public List<CsdlEnumMember> readEnumData(FullQualifiedName enumTypeName) throws ODataApplicationException {
        EnumStorageData dataStorage = getEnumStorage(enumTypeName);
        return dataStorage.getAllItems();
    }

    private EnumStorageData getEnumStorage(FullQualifiedName enumTypeName) {
        EnumStorageData dataStorage = null;
        if (enumTypeName.equals(SvcmEdmCore.ET_OBJECTTYPE_FQN))
            dataStorage = (EnumStorageData) new CObjectTypeEnumData();
        return dataStorage;
    }
}
