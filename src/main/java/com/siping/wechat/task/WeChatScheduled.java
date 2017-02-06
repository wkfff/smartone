package com.siping.wechat.task;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.siping.web.action.LoginCtroller;
import com.siping.wechat.bean.AccessToken;
import com.siping.wechat.bean.Visits;
import com.siping.wechat.service.WechatSer;
import com.siping.wechat.util.WeChatConstant;
import com.siping.wechat.util.WeChatUtil;

/**
 * 微信定时工作类
 * @author Mx
 *
 */
@Component
public class WeChatScheduled {
    private static Logger logger = Logger.getLogger(WeChatScheduled.class);
    @Autowired
    private WechatSer wechatService;

    /**
     *  每3600秒执行一次刷新access_token
     */
    @Scheduled(fixedRate=3600000)
    public void getAccessTokenTask() {
        AccessToken token = null;
        while(token == null){
            try {
                token = WeChatUtil.getAccessToken(WeChatConstant.APPID,WeChatConstant.APPSECRET);
                if(null != token){
                    WeChatConstant.ACCESS_TOKEN = token.getToken();
                }
            } catch (Exception e) {
                logger.error("获取AccessToken发生异常");
                e.printStackTrace();
            }
        }
        logger.debug("%%%%%%%%refresh access token is " + WeChatConstant.ACCESS_TOKEN);
    }

    /**
     * 每晚11:59存储访问量信息
     */
    @Scheduled(cron = "0 59 23 * * ?")
    public void saveOauthTimes(){
        Visits record = new Visits();
        record.setTimes(LoginCtroller.getVisitTimes());
        try{
            wechatService.saveVisitTimes(record);
        }catch(Exception e){
            e.printStackTrace();
            return;
        }
        LoginCtroller.setVisitTimes(0);
    }

}
