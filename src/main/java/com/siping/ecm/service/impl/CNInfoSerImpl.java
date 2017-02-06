package com.siping.ecm.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.MetaData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.ecm.dao.CNInfoDao;
import com.siping.ecm.service.CNInfoSer;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.service.ProcessRunningSer;

@Service
public class CNInfoSerImpl implements CNInfoSer {
    Logger logger = Logger.getLogger(CNInfoSerImpl.class);
    @Autowired
    private CNInfoDao cnInfoDao;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Override
    public List<EngineerChange> getChangeNoList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception {
        return this.cnInfoDao.getChangeNoList(params,pagerRequest);
    }

    @Override
    public int getChangeNoListCnt(Map<String, Object> params) throws Exception {
        return this.cnInfoDao.getChangeNoListCnt(params);
    }

    @Override
    public EngineerChange getChangeNoDetail(EngineerChange ecn) throws Exception {
        MetaData metaData = ecn.getMetaData();
        EngineerChange resultEcn = this.cnInfoDao.getChangeNoDetail(ecn);
        resultEcn.setMetaData(metaData);
        if(resultEcn != null){
            ProcessRunning running = processRunningSer.getProcessRunningInfo(resultEcn);
            resultEcn.setProcessRunning(running);
        }
        return resultEcn;
    }

    @Override
    public List<BusinessData> getObjectList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<BusinessData> resultList = this.cnInfoDao.getObjectList(params,pagerRequest);

        //TODO may be more info

        return resultList;
    }

    @Override
    public int getObjectListCnt(Map<String, Object> params) throws Exception {
        int resultNum = this.cnInfoDao.getObjectListCnt(params);
        return resultNum;
    }

}
