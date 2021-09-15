package ru.gazpromproject.ta.svcm.stream.logic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.repo.CObjectRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.CObjectRepoPg;
import ru.gazpromproject.ta.svcm.stream.model.StreamBuilding;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;
import ru.gazpromproject.ta.svcm.stream.model.StreamStatus;
import ru.gazpromproject.ta.svcm.stream.repo.StreamBuildingRepo;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamBuildingRepoPg;

public class StreamBuildingDistributor implements StreamDistributor {

    private Map<String, CObject> parentsCache;
    StreamBuildingRepo repo;
    CObjectRepo cobjectRepo;
    
    public StreamBuildingDistributor() {
        parentsCache = new HashMap<String, CObject>();
        repo = new StreamBuildingRepoPg();
        cobjectRepo = new CObjectRepoPg(CObject.class);
    }
    
    @Override
    public void distributeNew() {
        parentsCache.clear();        
        List<StreamBuilding> newItems = repo.getAllByStatus(StreamStatus.NEW);        

        for (StreamBuilding streamItem: newItems) {
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

    protected <P extends StreamModelBase> CObject getCObjectParent(StreamBuilding child) {
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
    
    protected CObject cobjectFromConstrpart(StreamBuilding constrItem) {
        CObject result = new CObject();
        // TODO: remove hardcode in using CObject.Type
        result.setCObjectTypeId(3);
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
