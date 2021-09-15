package ru.gazpromproject.ta.svcm.stream.repo.pg;

import ru.gazpromproject.ta.svcm.stream.model.StreamConstrPart;
import ru.gazpromproject.ta.svcm.stream.repo.StreamConstrPartRepo;

public class StreamConstrPartRepoPg extends StreamRepoParentPg<StreamConstrPart> implements StreamConstrPartRepo {
    public StreamConstrPartRepoPg() {
        super(StreamConstrPart.class);
    }
}
