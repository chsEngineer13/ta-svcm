package ru.gazpromproject.ta.svcm.stream.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(schema = "stream", name = "docset")
public class StreamDocset extends StreamModelBaseParent {
    private String name;
    private String cipher;
    private String devDep;
    private String oipKs;
    private String customerCode;
    private String contractNumber;
    private String cipherStage;
    private String developer;
    private String constrPartCode;
    private String constrPartNumber;
    private String buildingCode;
    private String buildingNumber;
    private String mark;
    private String markPath;
    private String stage;
    private String contractStage;
    private String changeset;
    private String status;
    private String gip;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCipher() {
        return cipher;
    }

    public void setCipher(String cipher) {
        this.cipher = cipher;
    }

    @Column(name = "dev_dep")
    public String getDevDep() {
        return devDep;
    }

    public void setDevDep(String devDep) {
        this.devDep = devDep;
    }

    public String getOipKs() {
        return oipKs;
    }

    public void setOipKs(String oipKs) {
        this.oipKs = oipKs;
    }

    @Column(name = "ccode")
    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    @Column(name = "num")
    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    @Column(name = "pstage")
    public String getCipherStage() {
        return cipherStage;
    }

    public void setCipherStage(String cipherStage) {
        this.cipherStage = cipherStage;
    }

    @Column(name = "dev_org")
    public String getDeveloper() {
        return developer;
    }

    public void setDeveloper(String developer) {
        this.developer = developer;
    }

    @Column(name = "cpcode")
    public String getConstrPartCode() {
        return constrPartCode;
    }

    public void setConstrPartCode(String constrPartCode) {
        this.constrPartCode = constrPartCode;
    }

    @Column(name = "cpnum")
    public String getConstrPartNumber() {
        return constrPartNumber;
    }

    public void setConstrPartNumber(String constrPartNumber) {
        this.constrPartNumber = constrPartNumber;
    }

    @Column(name = "bcode")
    public String getBuildingCode() {
        return buildingCode;
    }

    public void setBuildingCode(String buildingCode) {
        this.buildingCode = buildingCode;
    }

    @Column(name = "bnum")
    public String getBuildingNumber() {
        return buildingNumber;
    }

    public void setBuildingNumber(String buildingNumber) {
        this.buildingNumber = buildingNumber;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    @Column(name = "mark_path")
    public String getMarkPath() {
        return markPath;
    }

    public void setMarkPath(String markPath) {
        this.markPath = markPath;
    }

    @Column(name = "bstage")
    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    @Column(name = "cstage")
    public String getContractStage() {
        return contractStage;
    }

    public void setContractStage(String contractStage) {
        this.contractStage = contractStage;
    }

    @Column(name = "izm_num")
    public String getChangeset() {
        return changeset;
    }

    public void setChangeset(String changeset) {
        this.changeset = changeset;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGip() {
        return gip;
    }

    public void setGip(String gip) {
        this.gip = gip;
    }
}
