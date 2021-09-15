package ru.gazpromproject.ta.svcm.sys;

import ru.gazpromproject.ta.svcm.sys.model.AclAccount;

public class AccountHolder {

    private static AclAccount _account = null;

    public static AclAccount getCurrentAccount() {
        return _account;
    }

    public static void setCurrentAccount(AclAccount account) {
        _account = account;
    }
}
