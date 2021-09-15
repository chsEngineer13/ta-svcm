package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.Contract;
import ru.gazpromproject.ta.svcm.core.model.ContractStage;
import ru.gazpromproject.ta.svcm.core.repo.ContractStageRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.ContractStageRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class ContractStageData extends AbstractEntityData<ContractStage> implements EntityStorageData {

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(ContractStage.class);

    public ContractStageData() {
        repo = new ContractStageRepoPg(ContractStage.class);
    }

    @Override
    public Entity convertToEntity(ContractStage modelObject) throws ODataApplicationException {
        final Entity e = new Entity();
        e.addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()));
        e.addProperty(new Property(null, "ContractId", ValueType.PRIMITIVE, modelObject.getContractId()));
        e.addProperty(new Property(null, "Status", ValueType.PRIMITIVE, modelObject.getStatus()));
        e.addProperty(new Property(null, "StageNum", ValueType.PRIMITIVE, modelObject.getStageNum()));
        e.addProperty(new Property(null, "StageName", ValueType.PRIMITIVE, modelObject.getStageName()));
        e.addProperty(new Property(null, "PlanStart", ValueType.PRIMITIVE,
                convertDateToGregorian(modelObject.getPlanStart())));
        e.addProperty(new Property(null, "PlanFinish", ValueType.PRIMITIVE,
                convertDateToGregorian(modelObject.getPlanFinish())));
        e.addProperty(new Property(null, "WorkTypes", ValueType.PRIMITIVE, modelObject.getWorkTypes()));

        e.setId(createId(SvcmEdmCore.ES_CONTRACTSTAGES_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public ContractStage convertFromEntity(ContractStage item, Entity entity) throws ODataApplicationException {
        ContractStage result;
        if (item == null) {
            result = new ContractStage();
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
            } else if (propertyName.equals("ContractId")) {
                if (!prop.isNull())
                    result.setContractId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Status")) {
                if (!prop.isNull())
                    result.setStatus(propertyText);
            } else if (propertyName.equals("StageNum")) {
                if (!prop.isNull())
                    result.setStageNum(propertyText);
            } else if (propertyName.equals("StageName")) {
                if (!prop.isNull())
                    result.setStageName(propertyText);
            } else if (propertyName.equals("PlanStart")) {
                if (!prop.isNull())
//                    result.setContractDate((Date)prop.getValue());
                    result.setPlanStart(convertGregorianToDate(prop));
            } else if (propertyName.equals("PlanFinish")) {
                if (!prop.isNull())
                    result.setPlanFinish(convertGregorianToDate(prop));
            } else if (propertyName.equals("WorkTypes")) {
                result.setWorkTypes(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY, propertyName,
                        SvcmEdmCore.ET_CONTRACTSTAGE_NAME);
                throw new ODataApplicationException(err_msg, HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(),
                        Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_CONTRACTS_NAME)) {
            ContractData contractData = new ContractData();
            Contract contractItem = contractData.convertFromEntity(parentEntity);
            entityCollection = convertItemsToEntityCollection(((ContractStageRepo) repo).getByContract(contractItem));
        }
        return entityCollection;
    }

    @Override
    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
        String targetSetName = targetSet.getName();
        if (targetSetName.equals(SvcmEdmCore.ES_CONTRACTS_NAME)) {
            ContractStage contractStageItem = convertFromEntity(parentEntity);
            ContractData contractData = new ContractData();
            Contract contractItem = contractData.convertFromEntity(targetEntity);
            long contractId = contractItem.getId();
            contractStageItem.setContractId(contractId);
            long id = contractStageItem.getId();
            repo.update(id, contractStageItem);
        }
    }

    @Override
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException {
        String parentEntitySetName = parentEntitySet.getName();
        if (parentEntitySetName.equals(SvcmEdmCore.ES_CONTRACTS_NAME)) {
            ContractStage item = convertFromEntity(navEntity);
            item.setContractId(null);
            repo.update(item.getId(), item);
        }
    }

}
