package ru.gazpromproject.ta.svcm.stream.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBaseParent;

public interface StreamRepoParent<T extends StreamModelBaseParent> extends StreamRepo<T> {
    <P extends StreamModelBase> List<P> getParent(T child);
}
