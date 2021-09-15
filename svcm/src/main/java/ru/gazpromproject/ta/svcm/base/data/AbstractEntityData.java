package ru.gazpromproject.ta.svcm.base.data;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.persistence.Table;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmMapping;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.edm.EdmProperty;
import org.apache.olingo.commons.api.ex.ODataRuntimeException;
import org.apache.olingo.commons.api.http.HttpMethod;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriInfo;
import org.apache.olingo.server.api.uri.UriInfoResource;
import org.apache.olingo.server.api.uri.UriParameter;
import org.apache.olingo.server.api.uri.UriResource;
import org.apache.olingo.server.api.uri.UriResourcePrimitiveProperty;
import org.apache.olingo.server.api.uri.queryoption.FilterOption;
import org.apache.olingo.server.api.uri.queryoption.OrderByItem;
import org.apache.olingo.server.api.uri.queryoption.OrderByOption;
import org.apache.olingo.server.api.uri.queryoption.SkipOption;
import org.apache.olingo.server.api.uri.queryoption.TopOption;
import org.apache.olingo.server.api.uri.queryoption.expression.Expression;
import org.apache.olingo.server.api.uri.queryoption.expression.ExpressionVisitException;
import org.apache.olingo.server.api.uri.queryoption.expression.Member;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;
import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.service.SvcmFilterExpressionVisitor;

public abstract class AbstractEntityData<T extends AbstractModelId> {

    protected final String DATA_ERR_UNDEFINED_PROPERTY = "Undefined property '%s' reached in '%s' entity";

    protected IAbstractRepoId<T> repo;

    public abstract Entity convertToEntity(T modelObject) throws ODataApplicationException;

    public  T convertFromEntity(Entity entity) throws ODataApplicationException {
        return convertFromEntity(null, entity);
    }
    
    public abstract T convertFromEntity(T item, Entity entity) throws ODataApplicationException;
    
    public EntityCollection getAllItems(UriInfo uriInfo) throws ODataApplicationException {
        // process OrderBy option
        StringBuilder orderbyBuilder = null;
        OrderByOption orderbyOption = uriInfo.getOrderByOption();
        if (orderbyOption != null) {
            orderbyBuilder = new StringBuilder(" ORDER BY");
            boolean isFirstItem = true;
            for (OrderByItem orderbyItem : orderbyOption.getOrders()) {
                Expression expression = orderbyItem.getExpression();
                if(expression instanceof Member){
                    UriInfoResource resourcePath = ((Member)expression).getResourcePath();
                    UriResource uriResource = resourcePath.getUriResourceParts().get(0);
                    if (uriResource instanceof UriResourcePrimitiveProperty) {
                       EdmProperty edmProperty = ((UriResourcePrimitiveProperty)uriResource).getProperty();
                       EdmMapping mapping = edmProperty.getMapping();
                       if (mapping == null ) {
                           String err_msg = String.format("Ordering by property '%s' is not supported."
                                   , edmProperty.getName());
                           throw new ODataApplicationException(err_msg
                                   , HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode()
                                   , Locale.ENGLISH);
                       }
                       if (!isFirstItem)
                           orderbyBuilder.append(",");
                       orderbyBuilder.append(" ");
                       orderbyBuilder.append(mapping.getInternalName());
                       if (orderbyItem.isDescending())
                           orderbyBuilder.append(" DESC");
                       if (isFirstItem)
                           isFirstItem = false;
                    }
                }
            }
        }
        String orderbyString = null;
        if (orderbyBuilder != null) {
            orderbyString = orderbyBuilder.toString();
        }

        // process FilterOption
        StringBuilder whereBuilder = null;
        FilterOption filterOption = uriInfo.getFilterOption();
        if (filterOption != null) {
            whereBuilder = new StringBuilder(" WHERE");
            Expression filterExpression = filterOption.getExpression();
            SvcmFilterExpressionVisitor visitor = new SvcmFilterExpressionVisitor();
            try {
                Object visitorResult = filterExpression.accept(visitor);
                if (visitorResult != null) {
                    whereBuilder.append(String.format(" %s ", visitorResult));
                }
            } catch (ExpressionVisitException e) {
                throw new ODataApplicationException(e.getMessage()
                        , HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode()
                        , Locale.ENGLISH);
            }
        }
        String whereString = null;
        if (whereBuilder != null) {
            whereString = whereBuilder.toString();
        }

        //process SkipOption
        int skipValue = 0;
        SkipOption skipOption = uriInfo.getSkipOption();
        if (skipOption != null)
            skipValue = skipOption.getValue();

        // process TopOption
        int topValue = 0;
        TopOption topOption = uriInfo.getTopOption();
        if (topOption != null)
            topValue = topOption.getValue();

        List<T> items = repo.getAll(whereString, orderbyString, skipValue, topValue);
        return convertItemsToEntityCollection(items);
    }

    public Entity getSingleItem(List<UriParameter> keyParams) throws ODataApplicationException {
        long id = getIdFromParams(keyParams);
        final T item = repo.getById(id);
        if (item == null) {
            return null;
        }
        final Entity entity = convertToEntity(item);
        return entity;
    }

    public Entity getSingleItemOptions(List<UriParameter> keyParams, UriInfo uriInfo) throws ODataApplicationException {
        long id = getIdFromParams(keyParams);
        final T item = repo.getById(id);
        final Entity entity = convertToEntity(item);
        return entity;
    }

    public long getIdFromEntity(Entity requestEntity) throws ODataApplicationException {
        T requestItem = convertFromEntity(requestEntity);
        return requestItem.getId();
    }

    public Entity createItem(Entity requestEntity) throws ODataApplicationException {
        T requestItem = convertFromEntity(requestEntity);
        T createdItem = repo.create(requestItem);
        Entity createdEntity = convertToEntity(createdItem);
        return createdEntity;
    }

    public void updateItem(List<UriParameter> keyParams, Entity requestEntity, HttpMethod httpMethod)
            throws ODataApplicationException {        
        long id = getIdFromParams(keyParams);
        T objectItem;
        if (httpMethod.equals(HttpMethod.PATCH)) {
            objectItem = repo.getById(id);
        } else {
            objectItem = null;
        }
        T requestItem = convertFromEntity(objectItem, requestEntity);
        repo.update(id, requestItem);
    }

    public void deleteItem(List<UriParameter> keyParams) throws ODataApplicationException {
        long id = getIdFromParams(keyParams);
        repo.delete(id);
    }

    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity) throws ODataApplicationException {
        return getRelatedSingleItem(parentSet, parentEntity, null);
    }

    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException {
        return null;
    }

    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException {
        return null;
    }

    public EntityCollection getRelatedItemsTree(EdmNavigationProperty navProperty, Entity parentEntity, final int level)
            throws ODataApplicationException {
        return null;
    }

    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException {
    }

    public void setRelatedLinks(Entity parentEntity, EdmEntitySet targetSet, List<Entity> targetEntities)
            throws ODataApplicationException {
        for (Entity targetEntity : targetEntities) {
            setRelatedLink(parentEntity, targetSet, targetEntity);
        }
    }
    
    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity,
            EdmNavigationProperty navProperty, Entity navEntity) throws ODataApplicationException {
        // TODO подумать как реализовать проверку установки и удаления линков в родителе и ребенке
        //        throw new ODataApplicationException("Reference unset not implemented",
        //                HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ROOT);
    }
    
    public void unsetRelatedLinks(EdmEntitySet parentEntitySetName, Entity parentEntity,
            EdmNavigationProperty navProperty) {
    }

    public String getSchemaName() {
        return repo.getModelType().getAnnotation(Table.class).schema();
    }

    public long getIdFromParams(List<UriParameter> keyParams) {
        long id = 0;
        for (UriParameter param : keyParams) {
            if (param.getName().equals(("Id"))) {
                id = Long.parseLong(param.getText());
            }
        }
        return id;
    }

    protected long parseIdFromString(String idString) throws ODataApplicationException {
        long result;
        try {
            result = Long.parseLong(idString);
        } catch (NumberFormatException e) {
            throw new ODataApplicationException("Failed to retrieve Id property as Long value",
                    HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH, e);
        }
        return result;
    }
    
    protected Date convertGregorianToDate(Property source) throws ODataApplicationException {
        if (source == null)
            return null;        
        Date result = null;
        try {
            GregorianCalendar cal = (GregorianCalendar)source.getValue();
            result = cal.getTime();
        } catch (Exception e) {
            throw new ODataApplicationException(String.format("Failed to convert Gregorian to Date: %s", source.toString()),
                    HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH, e);
        }
        return result;
    }

    protected GregorianCalendar convertDateToGregorian(Date source) throws ODataApplicationException {
        if (source == null)
            return null;
        try {
            GregorianCalendar cal = new GregorianCalendar();
            cal.setTime(source);
            return cal;
        } catch (Exception e) {
            throw new ODataApplicationException(String.format("Failed to convert Date to Gregorian: %s", source.toString()),
                    HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH, e);
        }
    }
    
    protected UUID parseUUID(String source) throws ODataApplicationException {
        UUID result = null;
        if (source == null || source.isEmpty())
            return result;
        try {
            result = UUID.fromString(source);
        } catch (IllegalArgumentException e) {
            throw new ODataApplicationException(String.format("Failed to parse UUID string: %s", source),
                    HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH, e);
        }
        return result;
    }

    protected EntityCollection convertItemsToEntityCollection(List<T> items) throws ODataApplicationException {
        EntityCollection entityCollection = new EntityCollection();
        List<Entity> entityList = entityCollection.getEntities();
        for (int i = 0; i < items.size(); i++) {
            T curItem = items.get(i);
            final Entity e = convertToEntity(curItem);
            entityList.add(e);
        }
        return entityCollection;
    }

    protected static URI createId(String entitySetName, Object id) {
        try {
            return new URI(entitySetName + "(" + String.valueOf(id) + ")");
        } catch (URISyntaxException e) {
            throw new ODataRuntimeException("Unable to create id for entity: " + entitySetName, e);
        }
    }
}
