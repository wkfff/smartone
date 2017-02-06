package com.siping.mobile.service.impl;

import java.awt.image.BufferedImage;
import java.util.LinkedHashMap;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.code.kaptcha.Producer;
import com.siping.mobile.dao.MobileLoginDao;
import com.siping.mobile.service.MobileLoginSer;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SqlMapClientSupport;

@Service
public class MobileLoginSerImpl extends SqlMapClientSupport implements MobileLoginSer {

    Logger logger = Logger.getLogger(MobileLoginSerImpl.class);

    @Autowired
    private Producer captchaProducer;
    @Autowired
    private MobileLoginDao mobileLoginDao;

    /**
     * 生成验证码
     * @return
     */
    @Override
    public void generateVerifyCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        // 生成验证码的值
        String capText = captchaProducer.createText();
        // 将验证码的值放入session当中
        request.getSession().setAttribute("KAPTCHA_SESSION_KEY", capText);
        // 生成验证码图片
        BufferedImage bi = captchaProducer.createImage(capText);
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }
    }

    /**
     * 查询sy_admin中对应的username的个数
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    @Override
    public int getCntByUsername(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        int cnt = this.mobileLoginDao.getCntByUsername(paramMap);
        return cnt;
    }

    /**
     * 判断邀请码的使用状态
     * @param request
     * @return not_exist:不存在；be_used:已使用；not_use:未使用
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String invitationStatus(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        int invitationCnt = this.mobileLoginDao.getCntByInvitationCondition(paramMap); // 依据invitation_id查询，判断该邀请码是否存在
        if (invitationCnt == 0) {
            return "not_exists"; // 表示该邀请码不存在
        } else {
            paramMap.put("USE_STATUS", "use0"); // use0表示未使用
            int Cnt = this.mobileLoginDao.getCntByInvitationCondition(paramMap); // 依据invitation_id和use_status查询，判断邀请码使用状态
            if (Cnt > 0) {
                return "not_used"; // 表示该邀请码未使用
            } else {
                return "be_used"; // 表示该邀请码已使用
            }
        }
    }

    /**
     * 插入注册信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String insertRegisterInfo(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        String verifyCode = request.getSession().getAttribute("KAPTCHA_SESSION_KEY").toString();
        String inputVerifyCode = request.getParameter("INPUT_VERIFY_CODE");
        String inputPassword = request.getParameter("INPUT_PASSWORD");
        String encodePassword = EncryptUtil.MD5Encode(inputPassword);
        paramMap.put("PASSWORD", encodePassword);

        if (verifyCode.equals(inputVerifyCode)) {
            this.mobileLoginDao.insertRegisterInfo(paramMap);
            return "INSERT_SUCCESS";
        } else {
            return "WRONG_VERIFY_CODE";
        }
    }
}
