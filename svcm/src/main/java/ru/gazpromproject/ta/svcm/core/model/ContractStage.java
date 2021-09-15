package ru.gazpromproject.ta.svcm.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

@Entity
@Table(schema = "core", name = "contract_stages")
public class ContractStage extends AbstractModelId {
    private Long contractId;
    private String status;
    private String stageNum;
    private String stageName;
    private Date planStart;
    private Date planFinish;
    private String workTypes;

    @Column(name = "contract_id")
    public Long getContractId() {
        return contractId;
    }

    public void setContractId(Long contractId) {
        this.contractId = contractId;
    }

    @Column(name = "status", nullable = true)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "stage_num", nullable = true)
    public String getStageNum() {
        return stageNum;
    }

    public void setStageNum(String stageNum) {
        this.stageNum = stageNum;
    }

    @Column(name = "name")
    public String getStageName() {
        return stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }

    @Column(name = "plan_start")
    public Date getPlanStart() {
        return planStart;
    }

    public void setPlanStart(Date planStart) {
        this.planStart = planStart;
    }

    @Column(name = "plan_finish")
    public Date getPlanFinish() {
        return planFinish;
    }

    public void setPlanFinish(Date planFinish) {
        this.planFinish = planFinish;
    }

    @Column(name = "worktypes")
    public String getWorkTypes() {
        return workTypes;
    }

    public void setWorkTypes(String workTypes) {
        this.workTypes = workTypes;
    }
}
