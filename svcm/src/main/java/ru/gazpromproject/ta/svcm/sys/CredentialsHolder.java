package ru.gazpromproject.ta.svcm.sys;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;

public class CredentialsHolder {

    public static Credentials BASIC_CREDENTIALS = null;

    public static void setBasicCredentils(HttpServletRequest req) {
        Credentials cred = credentialsWithBasicAuthentication(req);
        BASIC_CREDENTIALS = cred;
    }

    private static Credentials credentialsWithBasicAuthentication(HttpServletRequest req) {
        final String authorization = req.getHeader("Authorization");
        if (authorization != null && authorization.toLowerCase().startsWith("basic")) {
            // Authorization: Basic base64credentials
            String base64Credentials = authorization.substring("Basic".length()).trim();
            byte[] credDecoded = Base64.getDecoder().decode(base64Credentials);
            String credentials = new String(credDecoded, StandardCharsets.UTF_8);
            // credentials = username:password
            final String[] values = credentials.split(":", 2);
            return new Credentials(values[0], values[1]);
        }
        return null;
    }
}
