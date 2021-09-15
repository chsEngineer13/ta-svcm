package ru.gazpromproject.ta.svcm.stream.logic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.repo.CObjectRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.CObjectRepoPg;
import ru.gazpromproject.ta.svcm.stream.model.StreamConstrPart;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;
import ru.gazpromproject.ta.svcm.stream.model.StreamStatus;
import ru.gazpromproject.ta.svcm.stream.repo.StreamConstrPartRepo;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamConstrPartRepoPg;

public class StreamConstrPartDistributor implements StreamDistributor {
    
    private Map<String, CObject> parentsCache;
    StreamConstrPartRepo repo;
    CObjectRepo cobjectRepo;
    
    public StreamConstrPartDistributor() {
        parentsCache = new HashMap<String, CObject>();
        repo = new StreamConstrPartRepoPg();
        cobjectRepo = new CObjectRepoPg(CObject.class);
    }
    
    public void distributeNew() {
        parentsCache.clear();        
        List<StreamConstrPart> newItems = repo.getAllByStatus(StreamStatus.NEW);        

        for (StreamConstrPart streamItem: newItems) {
            CObject parent = getCObjectParent(streamItem);
            if (parent == null) {
                streamItem.setStreamStatus(StreamStatus.PARENT_NOT_FOUND.getId());
                repo.update(streamItem.getId(), streamItem);
               continue;
            } else {
                CObject cobject = cobjectFromConstrpart(streamItem);
                cobject.setParentId(parent.getId());
                cobject.setConstructionId(parent.getConstructionId());
                cobjectRepo.create(cobject);
                streamItem.setStreamStatus(StreamStatus.DISTRIBUTED_SUCCESSFULLY.getId());
                streamItem.setSuccessorId(cobject.getId());
                repo.update(streamItem.getId(), streamItem);
            }                                      
        }                      
    }

    protected <P extends StreamModelBase> CObject getCObjectParent(StreamConstrPart child) {
        CObject cacheParent = parentsCache.get(child.getHidStr());
        if (cacheParent != null)
            return cacheParent;  
        List<P> parentList = repo.getParent(child);        
        if (parentList == null || parentList.size() < 1)
            return null;
        StreamModelBase streamParent = parentList.get(0);
        if (streamParent.getSuccessorId() == null)
            return null;
        CObject dbParent = cobjectRepo.getById(streamParent.getSuccessorId());
        if (dbParent == null)
            return null;        
        parentsCache.put(streamParent.getHidStr(), dbParent);        
        return dbParent;
    }
    
    
    protected CObject cobjectFromConstrpart(StreamConstrPart constrItem) {
        CObject result = new CObject();
        result.setCObjectTypeId(2);
        String code = constrItem.getCode();
        if (code != null)
            result.setCode(code);
        String num = constrItem.getNumber();
        if (num != null)
            result.setNumber(num);
        String descr = constrItem.getName();
        if (descr != null)
            result.setDescr(descr);        
        return result;
    }
}
