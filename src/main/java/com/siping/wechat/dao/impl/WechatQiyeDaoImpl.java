package com.siping.wechat.dao.impl;

import org.springframework.stereotype.Repository;

import com.siping.hrm.bean.ApplyBusiTrip;
import com.siping.hrm.bean.ApplyCost;
import com.siping.hrm.bean.ApplyLeave;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.wechat.dao.WechatQiyeDao;

@Repository
public class WechatQiyeDaoImpl extends SqlMapClientSupport implements WechatQiyeDao{

    @Override
    public void addLeave(ApplyLeave applyLeave) throws Exception {
        this.insert("wechatQiye.addLeave", applyLeave);
    }

    @Override
    public void addCost(ApplyCost applyCost) throws Exception {
        this.insert("wechatQiye.addCost", applyCost);
    }

    @Override
    public void addBusiTrip(ApplyBusiTrip applyBusiTrip) throws Exception {
        this.insert("wechatQiye.addBusiTrip", applyBusiTrip);
    }

}
