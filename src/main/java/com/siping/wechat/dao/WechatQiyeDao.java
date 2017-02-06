package com.siping.wechat.dao;

import com.siping.hrm.bean.ApplyBusiTrip;
import com.siping.hrm.bean.ApplyCost;
import com.siping.hrm.bean.ApplyLeave;

public interface WechatQiyeDao {

    void addLeave(ApplyLeave applyLeave) throws Exception;

    void addCost(ApplyCost applyCost) throws Exception;

    void addBusiTrip(ApplyBusiTrip applyBusiTrip) throws Exception;
}
