package com.siping.process.service.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.State;
import com.siping.process.dao.ObjectStatusDao;
import com.siping.process.service.ObjectStatusSer;

@Service
public class ObjectStatusSerImpl implements ObjectStatusSer {
    Logger logger = Logger.getLogger(ObjectStatusSerImpl.class);
    @Autowired
    private ObjectStatusDao objectStatusDao;

    @Override
    public List<State> getObjectStatusList(HashMap<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<State> result = this.objectStatusDao.getObjectStatusList(params, pagerRequest);
        return result;
    }

    @Override
    public Integer getObjectStatusListCnt(HashMap<String, Object> params) throws Exception {
        int result = this.objectStatusDao.getObjectStatusListCnt(params);
        return result;
    }

    @Override
    public void addStatus(List<State> insertList) throws Exception {
        this.objectStatusDao.addObjectStatus(insertList);
    }

    @Override
    public void updateStatus(List<State> updateList) throws Exception {
        this.objectStatusDao.updateObjectStatus(updateList);
    }

    @Override
    public void removeState(State state) throws Exception {
        this.objectStatusDao.removeObjectState(state);
    }

}
