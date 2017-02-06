package com.siping.web.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.siping.hrm.service.impl.EmpInfoSerImpl;
import com.siping.hrm.service.impl.HrmSerImpl;
import com.siping.web.service.TimerTaskSer;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.mailUtil.MailSenderInfo;
import com.siping.web.utility.mailUtil.SimpleMailSender;

/**
 * 系统定时器配置文件
 * @author ChenMx
 *
 */
@Component
public class TimerTask {
    Logger logger = Logger.getLogger(TimerTask.class);
    @Autowired
    private TimerTaskSer paItemDataActivitySer;
    
    @Autowired
    private HrmSerImpl hrmSerImpl;
    
    @Autowired
    private EmpInfoSerImpl empInfoSerImpl;

    /**
     * 每月一号的00: 40执行该task用于初始化工资记录
     */
    @Scheduled(cron = "0 40 0 1 * ?")
    public void monthTask() {
        logger.info("每月开始初始化工资记录............");
        paItemDataActivitySer.initialPaInputItemInfo();
    }

    /**
     * 每天的23: 30执行该task用于每天检查更新考勤审核记录
     */
    // @Scheduled(cron = "0/5 * * * * *")
    @Scheduled(cron = "0 30 23 * * ?")
    public void attendanceTask() {
        logger.info("每天更新考勤审核记录............");
        paItemDataActivitySer.daylyCheckAttInfo();
    }
    
    /**
     * 每周三凌晨3点触发邮件定时器
     * @throws ParseException 
     */
    @Scheduled(cron="0 0 3 ? * WED") 
//    	@Scheduled(cron = "0/5 * * * * *")
    public void contractRemindByEmail() throws ParseException{
    		List converDateList = new ArrayList();
    		converDateList = hrmSerImpl.getAllConPer();
    		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String currentTime = formatter.format(new Date());
    		for (Object converDateObj : converDateList) {
    				LinkedHashMap dateMap = (LinkedHashMap)converDateObj;
    				String startDate =  DateUtil.getDateString((Date)dateMap.get("START_DATE"), "yyyy-MM-dd");
    				int con_per =  (Integer)dateMap.get("CON_PER");
    				String empid = (String) dateMap.get("EMPID");
    				String chineseName = (String) dateMap.get("CHINESENAME");
    				Date joinDate = (Date) dateMap.get("JOIN_DATE");
    				Integer activity = (Integer) dateMap.get("ACTIVITY");
//    				LinkedHashMap emailMap = (LinkedHashMap)this.empInfoSerImpl.getEmailByEmpId(empid);
//    				String email = (String) emailMap.get("P_EMAIL");
				int conver_dif = DateUtil.daysBetween(currentTime, startDate);
				int contra_dif = DateUtil.daysBetween(currentTime, DateUtil.daysAfterYears(joinDate, con_per));
//				提前一个月发送转正提醒邮件
				if(conver_dif < 30 && conver_dif > 0){
					MailSenderInfo mailInfo = new MailSenderInfo();
			        mailInfo.setMailServerHost("smtp.exmail.qq.com");
			        mailInfo.setMailServerPort("25");
			        mailInfo.setValidate(true);
			        mailInfo.setUserName("sipingsoft.hrms@sipingsoft.com");
			        mailInfo.setPassword("sipingsoft147258");// 您的邮箱密码
			        mailInfo.setFromAddress("sipingsoft.hrms@sipingsoft.com");
			        mailInfo.setSubject("转正提醒");
			        mailInfo.setToAddress("haixia.wang@sipingsoft.com");
			        mailInfo.setContent("<p>员工："+chineseName+":</p><p style='text-indent:2em;'>将于： " + startDate + "转正</p><p style='text-indent:2em;'>"+
			                "</p><p style='color:red;font-size:12px;text-indent:2em;'>本邮件由系统自动发送，请勿回复！</p><p>谢谢！</p><p>SipingSoft SmartOne团队</p>");
			        SimpleMailSender.sendHtmlMail(mailInfo);// 发送html格式
				}
//				提前一个月提醒合同到期
				if(null != activity && 0 != activity && contra_dif < 30){
//					非离职员工
					MailSenderInfo mailInfo = new MailSenderInfo();
			        mailInfo.setMailServerHost("smtp.exmail.qq.com");
			        mailInfo.setMailServerPort("25");
			        mailInfo.setValidate(true);
			        mailInfo.setUserName("sipingsoft.hrms@sipingsoft.com");
			        mailInfo.setPassword("sipingsoft147258");// 您的邮箱密码
			        mailInfo.setFromAddress("sipingsoft.hrms@sipingsoft.com");
			        mailInfo.setSubject("合同续约提醒");
			        mailInfo.setToAddress("haixia.wang@sipingsoft.com");
			        mailInfo.setContent("<p>员工："+chineseName+":</p><p style='text-indent:2em;'>将于： " + DateUtil.daysAfterYears(joinDate, con_per) + "合同到期</p><p style='text-indent:2em;'>"+
			                "</p><p style='color:red;font-size:12px;text-indent:2em;'>本邮件由系统自动发送，请勿回复！</p><p>谢谢！</p><p>SipingSoft SmartOne团队</p>");
			        SimpleMailSender.sendHtmlMail(mailInfo);// 发送html格式
				}
			}
    } 
}
