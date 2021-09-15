package ru.gazpromproject.ta.svcm.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "document")
public class Document extends AbstractModelId {

    private Long docsetId;
    private String cipher;
    private Long doccodeId;
    private String name;
    private String developerDep;
    private Long izmNum;
    private String status;
    private boolean actual;
    
    @Column(name = "docset_id")
    public Long getDocsetId() {
        return docsetId;
    }
    public void setDocsetId(Long docsetId) {
        this.docsetId = docsetId;
    }
    
    @Column(name = "cipher")
    public String getCipher() {
        return cipher;
    }
    public void setCipher(String cipher) {
        this.cipher = cipher;
    }
    
    @Column(name = "doccode_id")
    public Long getDoccodeId() {
        return doccodeId;
    }
    public void setDoccodeId(Long doccodeId) {
        this.doccodeId = doccodeId;
    }
    
    @Column(name = "name")
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    @Column(name = "developer_dep")
    public String getDeveloperDep() {
        return developerDep;
    }
    public void setDeveloperDep(String developerDep) {
        this.developerDep = developerDep;
    }
    
    @Column(name = "izm_num")
    public Long getIzmNum() {
        return izmNum;
    }
    public void setIzmNum(Long izmNum) {
        this.izmNum = izmNum;
    }
    
    @Column(name = "status")
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "is_actual")
    public boolean isActual() {
        return actual;
    }
    public void setActual(boolean actual) {
        this.actual = actual;
    }
    

}
