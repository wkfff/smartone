package com.siping.mobile.dao;

public interface MobileLoginDao {
    public int getCntByUsername(Object object);

    public int getCntByInvitationCondition(Object object);

    public String insertRegisterInfo(Object object) throws Exception;
}
