package com.siping.web.service.impl;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.web.dao.TimerTaskDao;
import com.siping.web.service.TimerTaskSer;
import com.siping.web.utility.DateUtil;

@Service
public class TimerTaskSerImpl implements TimerTaskSer {

    @Autowired
    private TimerTaskDao paItemDataActivityDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void initialPaInputItemInfo() {
        Map param = new LinkedHashMap<String, Object>();
        param.put("PA_MONTH", DateUtil.formatDate(new Date(), "yyyyMM"));
        paItemDataActivityDao.initialPaInputItemInfo(param);
    }

    @Override
    public void daylyCheckAttInfo() {
        paItemDataActivityDao.daylyCheckAttInfo();
    }

}
