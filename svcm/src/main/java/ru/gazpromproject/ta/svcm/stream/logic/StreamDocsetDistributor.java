package ru.gazpromproject.ta.svcm.stream.logic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.repo.CObjectRepo;
import ru.gazpromproject.ta.svcm.core.repo.DocsetRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.CObjectRepoPg;
import ru.gazpromproject.ta.svcm.core.repo.pg.DocsetRepoPg;
import ru.gazpromproject.ta.svcm.stream.model.StreamDocset;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;
import ru.gazpromproject.ta.svcm.stream.model.StreamStatus;
import ru.gazpromproject.ta.svcm.stream.repo.StreamDocsetRepo;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamDocsetRepoPg;

public class StreamDocsetDistributor implements StreamDistributor {

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(StreamDistributorsRunner.class);
    
    private Map<String, CObject> parentsCache;
    StreamDocsetRepo repo;
    DocsetRepo docsetRepo;
    CObjectRepo cobjectRepo;
    
    public StreamDocsetDistributor() {
        parentsCache = new HashMap<String, CObject>();
        repo = new StreamDocsetRepoPg();
        cobjectRepo = new CObjectRepoPg(CObject.class);
        docsetRepo = new DocsetRepoPg(Docset.class);
    }

    @Override
    public void distributeNew() {
        parentsCache.clear();        
        List<StreamDocset> newItems = repo.getAllByStatus(StreamStatus.NEW);
        logger.info(String.format("Total new intems: %s", newItems.size()));

        for (StreamDocset streamItem: newItems) {
            if (streamItem.getParentType() == "Contract") {
                logger.info(String.format("Parent is contract: %s", streamItem.getId()));
                streamItem.setStreamStatus(StreamStatus.PARENT_NOT_SUPPORTED.getId());
                repo.update(streamItem.getId(), streamItem);
                continue;
            }
            CObject parent = getCObjectParent(streamItem);
            if (parent == null) {
                logger.info(String.format("Parent not found: %s", streamItem.getId()));
                streamItem.setStreamStatus(StreamStatus.PARENT_NOT_FOUND.getId());
                repo.update(streamItem.getId(), streamItem);
                continue;
            } else {
                logger.info(String.format("Processing: %s", streamItem.getId()));
                Docset docset = objectFromStream(streamItem);               
                docset.setCObjectId(parent.getId());
                docsetRepo.create(docset);
                streamItem.setStreamStatus(StreamStatus.DISTRIBUTED_SUCCESSFULLY.getId());
                streamItem.setSuccessorId(docset.getId());
                repo.update(streamItem.getId(), streamItem);
            }                                      
        }                      
    }

    protected <P extends StreamModelBase> CObject getCObjectParent(StreamDocset child) {
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
    
    protected Docset objectFromStream(StreamDocset streamItem) {
        Docset result = new Docset();        
        String name = streamItem.getName();
        if (name != null)
            result.setName(name);
        String cipher = streamItem.getCipher();
        if (cipher != null)
            result.setSign(cipher);                               
        return result;
    }
}
