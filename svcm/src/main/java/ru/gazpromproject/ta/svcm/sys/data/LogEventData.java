package ru.gazpromproject.ta.svcm.sys.data;

import java.util.Date;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.LogEvent;
import ru.gazpromproject.ta.svcm.sys.model.LogEventType;
import ru.gazpromproject.ta.svcm.sys.repo.pg.LogEventRepoPg;
import ru.gazpromproject.ta.svcm.sys.repo.pg.LogEventTypeRepoPg;

public class LogEventData extends AbstractEntityData<LogEvent> implements EntityStorageData {

    public LogEventData() {
        repo = new LogEventRepoPg(LogEvent.class);
    }

    private static final Logger logger = LoggerFactory.getLogger(LogEventData.class);

    @Override
    public Entity convertToEntity(LogEvent modelObject) throws ODataApplicationException {
        final Entity e = new Entity();
        e.addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()));
        e.addProperty(new Property(null, "AccountId", ValueType.PRIMITIVE, modelObject.getAccountId()));
        e.addProperty(new Property(null, "ActionId", ValueType.PRIMITIVE, modelObject.getEventTypeId()));
        e.addProperty(new Property(null, "EventTime", ValueType.PRIMITIVE,
//                convertDateToGregorian(modelObject.getEventTime())));
                modelObject.getEventTime()));
        e.addProperty(new Property(null, "SchemaName", ValueType.PRIMITIVE, modelObject.getSchemaName()));
        e.addProperty(new Property(null, "OperationName", ValueType.PRIMITIVE, modelObject.getOperationName()));
        e.addProperty(new Property(null, "OperationPKId", ValueType.PRIMITIVE, modelObject.getOperationPKId()));
        e.addProperty(new Property(null, "OperationPKTime", ValueType.PRIMITIVE,
//                convertDateToGregorian(modelObject.getOperationPKTime())));
                modelObject.getOperationPKTime()));
        e.addProperty(new Property(null, "Details", ValueType.PRIMITIVE, modelObject.getDetails()));
        e.addProperty(new Property(null, "Descr", ValueType.PRIMITIVE, modelObject.getDescr()));
        e.setId(createId(SvcmEdmSys.ES_LOGEVENTS_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public LogEvent convertFromEntity(LogEvent item, Entity entity) throws ODataApplicationException {
        LogEvent result;
        if (item == null) {
            result = new LogEvent();
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
            } else if (propertyName.equals("AccountId")) {
                result.setAccountId(parseIdFromString(propertyText));
            } else if (propertyName.equals("ActionId")) {
                result.setEventTypeId(parseIdFromString(propertyText));
            } else if (propertyName.equals("EventTime")) {
//                result.setEventTime(convertGregorianToDate(prop));
                result.setEventTime((Date)prop.getValue());
            } else if (propertyName.equals("SchemaName")) {
                result.setSchemaName(propertyText);
            } else if (propertyName.equals("OperationName")) {
                result.setOperationName(propertyText);
            } else if (propertyName.equals("OperationPKId")) {
                if (!prop.isNull())
                    result.setOperationPKId(parseIdFromString(propertyText));
            } else if (propertyName.equals("OperationPKTime")) {
                if (!prop.isNull())
                    result.setOperationPKTime((Date)prop.getValue());
            } else if (propertyName.equals("Details")) {
                result.setDetails(propertyText);
            } else if (propertyName.equals("Descr")) {
                result.setDescr(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmSys.ET_LOGEVENT_NAME);
                throw new ODataApplicationException(err_msg
                        , HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode()
                        , Locale.ENGLISH);
            }
        }
        return result;
    }

    @Override
    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        String entitySetName = parentSet.getName();
        if (entitySetName.equals(SvcmEdmSys.ES_ACCOUNTS_NAME)) {
            AclAccountData data = new AclAccountData();
            AclAccount account = data.convertFromEntity(parentEntity);            
            entityCollection = convertItemsToEntityCollection(((LogEventRepoPg) repo).getByAclAccount(account));
        }
        return entityCollection;
    }

    public Integer addEvent(
            String eventtype,
            String schema_name,
            String operation_name,
            Long operation_pk_id,
            Date operation_pk_time,
            String details,
            String descr) throws ODataApplicationException {
        AclAccountData accData = new AclAccountData();

        LogEventTypeRepoPg eventTypeRepo = new LogEventTypeRepoPg(LogEventType.class);
        LogEventType logEventType = eventTypeRepo.getByName(eventtype);
        if (logEventType == null) {
            String msg = String.format("Return null: LogEventType.getByName('%s')", eventtype);
            throw new ODataApplicationException(msg,
                    HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
        }

        LogEvent event = new LogEvent();
        event.setAccountId(accData.getMeAccount().getId());
        event.setEventTypeId(logEventType.getId());
        event.setSchemaName(schema_name);
        event.setOperationName(operation_name);
        event.setOperationPKId(operation_pk_id);
        event.setOperationPKTime(operation_pk_time);
        event.setDetails(details);
        event.setDescr(descr);

        Integer result = 0;
        try {
            result = ((LogEventRepoPg) repo).addEvent(event);
//            logger.info(String.format("Affected records: %d", result));
        } catch (Exception e) {
            logger.error(String.format("Error add event: %s", e.toString()));
        }
        return result;
    }

}
