package ru.gazpromproject.ta.svcm.core.data;

import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.Property;
import org.apache.olingo.commons.api.data.ValueType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityData;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.core.model.ChapterCode;
import ru.gazpromproject.ta.svcm.core.repo.pg.ChapterCodeRepoPg;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class ChapterCodeData extends AbstractEntityData<ChapterCode> implements EntityStorageData {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(ChapterCode.class);

    public ChapterCodeData() {
        repo = new ChapterCodeRepoPg(ChapterCode.class);
    }

    @Override
    public Entity convertToEntity(ChapterCode modelObject) {
        final Entity e = new Entity().addProperty(new Property(null, "Id", ValueType.PRIMITIVE, modelObject.getId()))
//				.addProperty(new Property(null, "ChapterCodeTypeId", ValueType.PRIMITIVE, modelObject.getchapterCodeTypeId()))
                .addProperty(new Property(null, "Chapter", ValueType.PRIMITIVE, modelObject.getChapter()))
                .addProperty(new Property(null, "SubChapter", ValueType.PRIMITIVE, modelObject.getSubChapter()))
                .addProperty(new Property(null, "Code", ValueType.PRIMITIVE, modelObject.getCode()))
                .addProperty(new Property(null, "Name", ValueType.PRIMITIVE, modelObject.getName()));
        e.setId(createId(SvcmEdmCore.ES_CHAPTERCODES_NAME, modelObject.getId()));
        return e;
    }

    @Override
    public ChapterCode convertFromEntity(ChapterCode item, Entity entity) throws ODataApplicationException {
        ChapterCode result;
        if (item == null) {
            result = new ChapterCode();
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
//			} else if (propertyName.equals("ChapterCodeTypeId")) {
//				if (!prop.isNull())
//					result.setchapterCodeTypeId(parseIdFromString(propertyText));
            } else if (propertyName.equals("Chapter")) {
                if (!prop.isNull())
                    result.setChapter(parseIdFromString(propertyText));
            } else if (propertyName.equals("SubChapter")) {
                if (!prop.isNull())
                    result.setSubChapter(parseIdFromString(propertyText));
            } else if (propertyName.equals("Code")) {
                result.setCode(propertyText);
            } else if (propertyName.equals("Name")) {
                result.setName(propertyText);
            } else {
                String err_msg = String.format(DATA_ERR_UNDEFINED_PROPERTY
                        , propertyName
                        , SvcmEdmCore.ET_CHAPTERCODE_NAME);
                throw new ODataApplicationException(err_msg,
                        HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
            }
        }
        return result;
    }

}
