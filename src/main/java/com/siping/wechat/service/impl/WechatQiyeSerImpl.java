package com.siping.wechat.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.hrm.bean.ApplyBusiTrip;
import com.siping.hrm.bean.ApplyCost;
import com.siping.hrm.bean.ApplyLeave;
import com.siping.web.utility.DateUtil;
import com.siping.wechat.dao.WechatQiyeDao;
import com.siping.wechat.service.WechatQiyeSer;

@Service
public class WechatQiyeSerImpl implements WechatQiyeSer{

    @Autowired
    private WechatQiyeDao wechatQiyeDao;
    @Autowired
    private RuntimeService runtimeService;

    @Override
    public String addLeave(ApplyLeave applyLeave) throws Exception {
/*        applyLeave.setLeaveFromTime(DateUtil.removeCharT(applyLeave.getLeaveFromTime()));
        applyLeave.setLeaveToTime(DateUtil.removeCharT(applyLeave.getLeaveToTime()));
        Map<String, Object> processParam = new LinkedHashMap<String, Object>();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String currentTime = formatter.format(new Date());
        processParam.put("application_time", currentTime);
        processParam.put("S_DATE", applyLeave.getLeaveFromTime());
        processParam.put("E_DATE", applyLeave.getLeaveToTime());
        processParam.put("EMPID", applyLeave.getEmpid());
        processParam.put("DAYS", days);
        processParam.put("reason", param.get("LEAVE_REASON"));
        processParam.put("applicant", chineseName);
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("LeaveProcess", processParam);
        String processID = processInstance.getProcessInstanceId();
        param.put("PROCESSID", processID);
        wechatQiyeDao.addLeave(applyLeave);*/
        return "Y";
    }

    @Override
    public String addCost(ApplyCost applyCost) throws Exception {
        wechatQiyeDao.addCost(applyCost);
        return "Y";
    }

    @Override
    public String addBusiTrip(ApplyBusiTrip applyBusiTrip) throws Exception {
        applyBusiTrip.setBtFromTime(DateUtil.removeCharT(applyBusiTrip.getBtFromTime()));
        applyBusiTrip.setBtToTime(DateUtil.removeCharT(applyBusiTrip.getBtToTime()));
        wechatQiyeDao.addBusiTrip(applyBusiTrip);
        return "Y";
    }

}
