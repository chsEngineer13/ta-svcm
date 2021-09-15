package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Contract;
import ru.gazpromproject.ta.svcm.core.model.ContractStage;
import ru.gazpromproject.ta.svcm.core.repo.pg.ContractRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class ContractData extends AbstractEntityData<Contract> implements EntityStorageData {

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(Contract.class);

    public ContractData() {
        repo = new ContractRepoPg(Contract.class);
    }

    @Override
    public Entity convertToEntity(Contract modelObject) throws ODataApplicationException {
        final Entity e = new Entity();
        e.addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()));
        e.addProperty(new Property(null, "ConstructionId", ValueType.PRIMITIVE, modelObject.getConstructionId()));
        e.addProperty(new Property(null, "ContractNum", ValueType.PRIMITIVE, modelObject.getContractNum()));
        e.addProperty(new Property(null, "PhaseId", ValueType.PRIMITIVE, modelObject.getPhaseId()));
        e.addProperty(new Property(null, "DeveloperId", ValueType.PRIMITIVE, modelObject.getDeveloperId()));
        e.addProperty(new Property(null, "ContractDate", ValueType.PRIMITIVE,
                convertDateToGregorian(modelObject.getContractDate())));
        e.addProperty(new Property(null, "ContractStatus", ValueType.PRIMITIVE, modelObject.getContractStatus()));
        e.addProperty(new Property(null, "ContractYear", ValueType.PRIMITIVE, modelObject.getContractYear()));
        e.addProperty(new Property(null, "ContractorId", ValueType.PRIMITIVE, modelObject.getContractorId()));
        e.addProperty(
                new Property(null, "DateSign", ValueType.PRIMITIVE, convertDateToGregorian(modelObject.getDateSign())));
        e.addProperty(new Property(null, "GIPs", ValueType.PRIMITIVE, modelObject.getGips()));
        e.addProperty(new Property(null, "InnerNum", ValueType.PRIMITIVE, modelObject.getInnerNum()));
        e.addProperty(new Property(null, "IUSCode", ValueType.PRIMITIVE, modelObject.getIUSCode()));
        e.addProperty(new Property(null, "Title", ValueType.PRIMITIVE, modelObject.getTitle()));
        e.addProperty(new Property(null, "OIPKS", ValueType.PRIMITIVE, modelObject.getOipks()));
        e.addProperty(new Property(null, "OrderStart", ValueType.PRIMITIVE,
                convertDateToGregorian(modelObject.getOrderStart())));
        e.addProperty(new Property(null, "OrderFinish", ValueType.PRIMITIVE,
                convertDateToGregorian(modelObject.getOrderFinish())));
        e.addProperty(new Property(null, "TechDirector", ValueType.PRIMITIVE, modelObject.getTechDirector()));
        e.addProperty(new Property(null, "WorkStart", ValueType.PRIMITIVE,
                convertDateToGregorian(modelObject.getWorkStart())));
        e.addProperty(new Property(null, "WorkFinish", ValueType.PRIMITIVE,
                convertDateToGregorian(modelObject.getWorkFinish())));
        e.addProperty(new Property(null, "WorkTypes", ValueType.PRIMITIVE, modelObject.getWorkTypes()));

        e.setId(createId(SvcmEdmCore.ES_CONTRACTS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public Contract convertFromEntity(Contract item, Entity entity) throws ODataApplicationException {
        Contract result;
        if (item == null) {
            result = new Contract();
        } else {
            result = item;
        }
        for (Property prop : entity.getProperties()) {
            String propertyName = prop.getName();
            String propertyText = null;
            if (!prop.isNull())
                propertyText = prop.getValue().toString();

            if (propertyName.equals("Id")) {
                result.setId(parseIdFromString(propertyText));
            } else if (propertyName.equals("ConstructionId")) {
                if (!prop.isNull())
                    result.setConstructionId(parseIdFromString(propertyText));
            } else if (propertyName.equals("ContractNum")) {
                result.setContractNum(propertyText);
            } else if (propertyName.equals("PhaseId")) {
                if (!prop.isNull())
                    result.setPhaseId(parseIdFromString(propertyText));
            } else if (propertyName.equals("DeveloperId")) {
                if (!prop.isNull())
                    result.setDeveloperId(parseIdFromString(propertyText));
            } else if (propertyName.equals("ContractDate")) {
                if (!prop.isNull())
//                    result.setContractDate((Date)prop.getValue());
                    result.setContractDate(convertGregorianToDate(prop));
            } else if (propertyName.equals("ContractStatus")) {
                result.setContractStatus(propertyText);
            } else if (propertyName.equals("ContractYear")) {
                if (!prop.isNull())
                    result.setContractYear(parseIdFromString(propertyText));
            } else if (propertyName.equals("ContractorId")) {
                if (!prop.isNull())
                    result.setContractorId(parseIdFromString(propertyText));
            } else if (propertyName.equals("DateSign")) {
                if (!prop.isNull())
                    result.setDateSign(convertGregorianToDate(prop));
            } else if (propertyName.equals("GIPs")) {
                result.setGips(propertyText);
            } else if (propertyName.equals("InnerNum")) {
                result.setInnerNum(propertyText);
            } else if (propertyName.equals("IUSCode")) {
                result.setIUSCode(propertyText);
            } else if (propertyName.equals("Title")) {
                result.setTitle(propertyText);
            } else if (propertyName.equals("OIPKS")) {
                result.setOipks(propertyText);
            } else if (propertyName.equals("OrderStart")) {
                if (!prop.isNull())
                    result.setOrderStart(convertGregorianToDate(prop));
            } else if (propertyName.equals("OrderFinish")) {
                if (!prop.isNull())
                    result.setOrderFinish(convertGregorianToDate(prop));
            } else if (propertyName.equals("TechDirector")) {
                result.setTechDirector(propertyText);
            } else if (propertyName.equals("WorkStart")) {
                if (!prop.isNull())
                    result.setWorkStart(convertGregorianToDate(prop));
            } else if (propertyName.equals("WorkFinish")) {
                if (!prop.isNull())
                    result.setWorkFinish(convertGregorianToDate(prop));
            } else if (propertyName.equals("WorkTypes")) {
                result.setWorkTypes(propertyText);

            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName, SvcmEdmCore.ET_CONTRACT_NAME);
                throw new ODataApplicationException(err_msg, HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(),
                        Locale.ENGLISH);
            }
        }

        return result;
    }

    @Override
    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity) throws ODataApplicationException {
        Entity result = null;
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_CONTRACTSTAGES_NAME)) {
            ContractStageData contractStageData = new ContractStageData();
            ContractStage contractStageItem = contractStageData.convertFromEntity(parentEntity);
            if (contractStageItem != null) {
                Long id = contractStageItem.getContractId();
                if (id != null)
                    result = convertToEntity(repo.getById(id));
            }
        }
        return result;
    }

}
