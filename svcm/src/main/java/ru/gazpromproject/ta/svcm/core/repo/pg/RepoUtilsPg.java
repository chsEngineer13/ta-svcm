package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;

public class RepoUtilsPg {
    
    public static Date parseDatePg(String source) throws ODataApplicationException {
        final String PG_TIME_FORMAT = "yyyy-MM-dd";
        
        Date result = null;
        if (source == null || source.isEmpty())
            return result;

        try {
            final SimpleDateFormat sdf = new SimpleDateFormat(PG_TIME_FORMAT);
            sdf.setCalendar(new GregorianCalendar());
            result = sdf.parse(source);
        } catch (ParseException e) {
            throw new ODataApplicationException(String.format("Failed to parse date string: %s", source),
                    HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH, e);
        }
        return result;
    }

}
