package ru.gazpromproject.ta.svcm.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "contract")
public class Contract extends AbstractModelId {

    private Long constructionId;
    private String contractNum;
    private Long phaseId;
    private Long developerId;
    private Date contractDate;
    private String contractStatus;
    private Long contractYear;
    private Long contractorId;
    private Date dateSign;
    private String gips;
    private String innerNum;
    private String iusCode;
    private String title;
    private String oipks;
    private Date orderStart;
    private Date orderFinish;
    private String techDirector;
    private Date workStart;
    private Date workFinish;
    private String workTypes;

    @Column(name = "construction_id", nullable = true)
    public Long getConstructionId() {
        return constructionId;
    }

    public void setConstructionId(Long constructionId) {
        this.constructionId = constructionId;
    }

    @Column(name = "contract_num", nullable = true)
    public String getContractNum() {
        return contractNum;
    }

    public void setContractNum(String contractNum) {
        this.contractNum = contractNum;
    }

    @Column(name = "phase_id")
    public Long getPhaseId() {
        return phaseId;
    }

    public void setPhaseId(Long phaseId) {
        this.phaseId = phaseId;
    }

    @Column(name = "developer_id")
    public Long getDeveloperId() {
        return developerId;
    }

    public void setDeveloperId(Long developerId) {
        this.developerId = developerId;
    }

    @Column(name = "contract_date")
    public Date getContractDate() {
        return contractDate;
    }

    public void setContractDate(Date contractDate) {
        this.contractDate = contractDate;
    }

    @Column(name = "contract_status")
    public String getContractStatus() {
        return contractStatus;
    }

    public void setContractStatus(String contractStatus) {
        this.contractStatus = contractStatus;
    }

    @Column(name = "contract_year")
    public Long getContractYear() {
        return contractYear;
    }

    public void setContractYear(Long contractYear) {
        this.contractYear = contractYear;
    }

    @Column(name = "contractor_id", nullable = true)
    public Long getContractorId() {
        return contractorId;
    }

    public void setContractorId(Long contractorId) {
        this.contractorId = contractorId;
    }

    @Column(name = "date_sign")
    public Date getDateSign() {
        return dateSign;
    }

    public void setDateSign(Date dateSign) {
        this.dateSign = dateSign;
    }

    @Column(name = "gips")
    public String getGips() {
        return gips;
    }

    public void setGips(String gips) {
        this.gips = gips;
    }

    @Column(name = "inner_num")
    public String getInnerNum() {
        return innerNum;
    }

    public void setInnerNum(String innerNum) {
        this.innerNum = innerNum;
    }

    @Column(name = "ius_code")
    public String getIUSCode() {
        return iusCode;
    }

    public void setIUSCode(String iusCode) {
        this.iusCode = iusCode;
    }

    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "oipks")
    public String getOipks() {
        return oipks;
    }

    public void setOipks(String oipks) {
        this.oipks = oipks;
    }

    @Column(name = "order_start")
    public Date getOrderStart() {
        return orderStart;
    }

    public void setOrderStart(Date orderStart) {
        this.orderStart = orderStart;
    }

    @Column(name = "order_finish")
    public Date getOrderFinish() {
        return orderFinish;
    }

    public void setOrderFinish(Date orderFinish) {
        this.orderFinish = orderFinish;
    }

    @Column(name = "techdirector")
    public String getTechDirector() {
        return techDirector;
    }

    public void setTechDirector(String techDirector) {
        this.techDirector = techDirector;
    }

    @Column(name = "work_start")
    public Date getWorkStart() {
        return workStart;
    }

    public void setWorkStart(Date workStart) {
        this.workStart = workStart;
    }

    @Column(name = "work_finish")
    public Date getWorkFinish() {
        return workFinish;
    }

    public void setWorkFinish(Date workFinish) {
        this.workFinish = workFinish;
    }

    @Column(name = "work_types")
    public String getWorkTypes() {
        return workTypes;
    }

    public void setWorkTypes(String workTypes) {
        this.workTypes = workTypes;
    }
}
