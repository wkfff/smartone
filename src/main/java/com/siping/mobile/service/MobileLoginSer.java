package com.siping.mobile.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface MobileLoginSer {

    public void generateVerifyCode(HttpServletRequest request, HttpServletResponse response) throws Exception;

    public int getCntByUsername(HttpServletRequest request);

    public String invitationStatus(HttpServletRequest request);

    public String insertRegisterInfo(HttpServletRequest request) throws Exception;
}
