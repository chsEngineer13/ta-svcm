package ru.gazpromproject.ta.svcm.stream.model;

public enum StreamStatus {
    NEW(0),
    DISTRIBUTED_SUCCESSFULLY(1),
    PARENT_NOT_FOUND(22),
    PARENT_NOT_SUPPORTED(33);
    
    private final int id;
    public int getId() { return id; }
    
    StreamStatus(int id) {
        this.id = id;
    }    
}
