package ru.gazpromproject.ta.svcm.data;

import java.util.List;

import org.apache.olingo.commons.api.edm.provider.CsdlEnumMember;

public interface EnumStorageData {
    public List<CsdlEnumMember> getAllItems();
}
