package ru.gazpromproject.ta.svcm.base.data;

import java.util.ArrayList;
import java.util.List;

import org.apache.olingo.commons.api.edm.provider.CsdlEnumMember;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;
import ru.gazpromproject.ta.svcm.base.repo.IAbstractReadRepoId;

public abstract class AbstractEnumData<T extends AbstractModelId> {

    protected IAbstractReadRepoId<T> repo;

    public List<CsdlEnumMember> getAllItems() {
        List<CsdlEnumMember> memberList = new ArrayList<CsdlEnumMember>();
        List<T> items = repo.getAll();
        for (int i = 0; i < items.size(); i++) {
            T curItem = items.get(i);
            final CsdlEnumMember e = convertToEnumMember(curItem);
            memberList.add(e);
        }
        return memberList;
    }

    public abstract CsdlEnumMember convertToEnumMember(T modelObject);
}
