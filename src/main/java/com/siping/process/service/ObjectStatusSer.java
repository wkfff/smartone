package com.siping.process.service;

import java.util.HashMap;
import java.util.List;

import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.State;

public interface ObjectStatusSer {

    List<State> getObjectStatusList(HashMap<String, Object> params, PagerRequest pagerRequest) throws Exception;

    Integer getObjectStatusListCnt(HashMap<String, Object> params) throws Exception;

    void addStatus(List<State> insertList) throws Exception;

    void updateStatus(List<State> updateList) throws Exception;

    void removeState(State state) throws Exception;

}
