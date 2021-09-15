package ru.gazpromproject.ta.svcm.sys;

public class Credentials {
    private String Login;
    private String Password;

    public String getLogin() {
        return Login;
    }

    public void setLogin(String login) {
        Login = login;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public Credentials(String login, String password) {
        setLogin(login);
        setPassword(password);
    }
}
