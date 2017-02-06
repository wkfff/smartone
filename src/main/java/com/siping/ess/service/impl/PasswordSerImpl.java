package com.siping.ess.service.impl;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.ess.dao.PasswordDao;
import com.siping.ess.service.PasswordSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.mailUtil.MailSenderInfo;
import com.siping.web.utility.mailUtil.SimpleMailSender;

@Service
public class PasswordSerImpl implements PasswordSer {

    Logger logger = Logger.getLogger(PasswordSerImpl.class);

    @Autowired
    private PasswordDao passwordDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updatePassword(HttpServletRequest request) throws Exception {
        Map param = ObjectBindUtil.getRequestParamData(request);
        String oldpassword = param.get("PASSWORD").toString();
        String new_password = param.get("NEW_PASSWORD").toString();
        String c_password = param.get("C_PASSWORD").toString();
        param.remove("PASSWORD");
        param.remove("NEW_PASSWORD");
        param.remove("C_PASSWORD");
        param.put("PASSWORD", EncryptUtil.MD5Encode(oldpassword));
        param.put("NEW_PASSWORD", EncryptUtil.MD5Encode(new_password));
        param.put("C_PASSWORD", EncryptUtil.MD5Encode(c_password));
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        if (!admin.getPassword().equals(EncryptUtil.MD5Encode(oldpassword))) {
            return "当前密码错误！";
        }
        return this.passwordDao.updatePassword(param);
    }

    @Override
    public String forgetPassword(String username) {
        String email = this.passwordDao.getEmailByUsername(username);
        if (email == null||email.equals("")){
            return "-1";
        }
        return "1";
    }

    public String generateCheckCode() {
        // 定义验证码的字符表
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        char[] rands = new char[12];
        for (int i = 0; i < rands.length; i++) {
            int rand = (int) (Math.random() * 62);
            rands[i] = chars.charAt(rand);
        }
        return String.valueOf(rands);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public Date getEndDate(Map object) {
        String password = object.get("password").toString();
        object.remove("password");
        object.put("password", EncryptUtil.MD5Encode(password));
        return passwordDao.checkCkeckcode(object);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String updatepasswordAndCheckcode(Map object) {
        return passwordDao.updatepasswordAndCheckcode(object);
    }

    @SuppressWarnings({ "unchecked", "deprecation", "rawtypes", "unused" })
    @Override
    public String getVerifyCode(String username) {
        String email = this.passwordDao.getEmailByUsername(username);
        String checkcode = generateCheckCode();
        Map object = new LinkedHashMap();
        object.put("USERNAME", username);
        object.put("C_MAIL", email);
        object.put("CHECK_CODE", checkcode);
        Date date = new Date();
        int hour = date.getHours() + 12;
        date.setHours(hour);
        object.put("END_DATE", date);
        Boolean bool = passwordDao.saveCheckCode(object);
        MailSenderInfo mailInfo = new MailSenderInfo();
        mailInfo.setMailServerHost("smtp.exmail.qq.com");
        mailInfo.setMailServerPort("25");
        mailInfo.setValidate(true);
        mailInfo.setUserName("sipingsoft.hrms@sipingsoft.com");
        mailInfo.setPassword("sipingsoft147258");// 您的邮箱密码
        mailInfo.setFromAddress("sipingsoft.hrms@sipingsoft.com");
        mailInfo.setSubject("四平一智通找回密码  系统验证码");
        mailInfo.setToAddress(email);
        mailInfo.setContent("<p>"+username+":</p><p style='text-indent:2em;'>您正在申请找回密码，本次验证码为 : " + checkcode + "</p><p style='text-indent:2em;'>"+
            "本次验证码12小时内有效，请及时修改密码，若失效请重新获取</p><p style='color:red;font-size:12px;text-indent:2em;'>本邮件由系统自动发送，请勿回复！</p><p>谢谢！</p><p>SipingSoft SmartOne团队</p>");
        SimpleMailSender.sendHtmlMail(mailInfo);// 发送html格式
        return email;
    }
}
