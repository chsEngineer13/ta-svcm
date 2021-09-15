package ru.gazpromproject.ta.svcm.stream.model;

import javax.persistence.*;

@Entity
@Table(schema = "stream", name = "contract")
public class StreamContract extends StreamModelBase {
    private String innerNumber;
    private String oipks;
    private String contractorCode;
    private String contractorName;
    private String contractSequenceNumber;
    private String contractYear;
    private String contractDate;
    private String name;
    private String contractStatus;
    private String iusCode;
    private String developerCode;
    private String developerName;
    private String techdirector;
    private String gip;    
    private String dateSign;
    private String workStart;
    private String workFinish;
    private String orderStart;
    private String orderFinish;
    private String workTypes;

    @Column(name = "inner_num")
    public String getInnerNumber() {
        return innerNumber;
    }
    public void setInnerNumber(String innerNumber) {
        this.innerNumber = innerNumber;
    }

    @Column(name = "oipks")
    public String getOipks() {
        return oipks;
    }
    public void setOipks(String oipks) {
        this.oipks = oipks;
    }
       
    @Column(name = "contractor_code")
    public String getContractorCode() {
        return contractorCode;
    }
    public void setContractorCode(String contractorCode) {
        this.contractorCode = contractorCode;
    }
    
    @Column(name = "contractor_name")
    public String getContractorName() {
        return contractorName;
    }
    public void setContractorName(String contractorName) {
        this.contractorName = contractorName;
    }

    @Column(name = "contract_num")
    public String getContractSequenceNumber() {
        return contractSequenceNumber;
    }
    public void setContractSequenceNumber(String contractSequenceNumber) {
        this.contractSequenceNumber = contractSequenceNumber;
    }

    @Column(name = "contract_year")
    public String getContractYear() {
        return contractYear;
    }
    public void setContractYear(String contractYear) {
        this.contractYear = contractYear;
    }
    
    @Column(name = "contract_date")
    public String getContractDate() {
        return contractDate;
    }
    public void setContractDate(String contractDate) {
        this.contractDate = contractDate;
    }
    
    @Column(name = "name", nullable = false)
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    @Column(name = "contract_status")
    public String getContractStatus() {
        return contractStatus;
    }
    public void setContractStatus(String contractStatus) {
        this.contractStatus = contractStatus;
    }
    
    @Column(name = "ius_code")
    public String getIusCode() {
        return iusCode;
    }
    public void setIusCode(String iusCode) {
        this.iusCode = iusCode;
    }        
    
    @Column(name = "dev_code")
    public String getDeveloperCode() {
        return developerCode;
    }
    public void setDeveloperCode(String developerCode) {
        this.developerCode = developerCode;
    }
    
    @Column(name = "dev_name")
    public String getDeveloperName() {
        return developerName;
    }
    public void setDeveloperName(String developerName) {
        this.developerName = developerName;
    }
    
    @Column(name = "techdirector")
    public String getTechdirector() {
        return techdirector;
    }
    public void setTechdirector(String techdirector) {
        this.techdirector = techdirector;
    }
    
    @Column(name = "gip")
    public String getGip() {
        return gip;
    }
    public void setGip(String gip) {
        this.gip = gip;
    }
    
    @Column(name = "date_sign")
    public String getDateSign() {
        return dateSign;
    }
    public void setDateSign(String dateSign) {
        this.dateSign = dateSign;
    }
    
    @Column(name = "work_start")
    public String getWorkStart() {
        return workStart;
    }
    public void setWorkStart(String workStart) {
        this.workStart = workStart;
    }
    
    @Column(name = "work_finish")
    public String getWorkFinish() {
        return workFinish;
    }
    public void setWorkFinish(String workFinish) {
        this.workFinish = workFinish;
    }
    
    @Column(name = "order_start")
    public String getOrderStart() {
        return orderStart;
    }
    public void setOrderStart(String orderStart) {
        this.orderStart = orderStart;
    }
    
    @Column(name = "order_finish")
    public String getOrderFinish() {
        return orderFinish;
    }
    public void setOrderFinish(String orderFinish) {
        this.orderFinish = orderFinish;
    }
    
    @Column(name = "work_types")
    public String getWorkTypes() {
        return workTypes;
    }
    public void setWorkTypes(String workTypes) {
        this.workTypes = workTypes;
    }
}
