package ru.gazpromproject.ta.svcm.core.data;

import java.util.Arrays;
import java.util.List;

import org.apache.olingo.commons.api.edm.provider.CsdlEnumMember;

import ru.gazpromproject.ta.svcm.data.EnumStorageData;

public class CObjectTypeEnumData implements EnumStorageData {

    @Override
    public List<CsdlEnumMember> getAllItems() {
        List<CsdlEnumMember> em = Arrays.asList(
                new CsdlEnumMember().setName("CONSTR").setValue("1"),
                new CsdlEnumMember().setName("CONSTR_PART").setValue("2"),
                new CsdlEnumMember().setName("BUILDING").setValue("3"),
                new CsdlEnumMember().setName("MARK").setValue("4"),
                new CsdlEnumMember().setName("FOLDER").setValue("5"));
        return em;
    }
}
