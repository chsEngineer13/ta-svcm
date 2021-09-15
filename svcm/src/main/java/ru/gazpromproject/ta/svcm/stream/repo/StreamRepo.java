package ru.gazpromproject.ta.svcm.stream.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;
import ru.gazpromproject.ta.svcm.stream.model.StreamStatus;

public interface StreamRepo<T extends StreamModelBase> extends IAbstractRepoId<T> {
    List<T> getAllByStatus(StreamStatus streamStatus);
    List<T> getByHidStr(String hidStr);
    <P extends StreamModelBase> Class<P> getStreamType(String code);
}
