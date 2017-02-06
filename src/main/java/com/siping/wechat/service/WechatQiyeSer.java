package com.siping.wechat.service;

import com.siping.hrm.bean.ApplyBusiTrip;
import com.siping.hrm.bean.ApplyCost;
import com.siping.hrm.bean.ApplyLeave;

public interface WechatQiyeSer {
    String addLeave(ApplyLeave applyLeave) throws Exception;

    String addCost(ApplyCost applyCost) throws Exception;

    String addBusiTrip(ApplyBusiTrip applyBusiTrip) throws Exception;
}
