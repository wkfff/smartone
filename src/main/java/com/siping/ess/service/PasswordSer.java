package com.siping.ess.service;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface PasswordSer {

    public String updatePassword(HttpServletRequest request) throws Exception;

    public String forgetPassword(String username);

    public Date getEndDate(Map object);

    public String updatepasswordAndCheckcode(Map object);

    String getVerifyCode(String username);

}
