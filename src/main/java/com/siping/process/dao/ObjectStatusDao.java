package com.siping.process.dao;

import java.util.HashMap;
import java.util.List;

import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.State;

public interface ObjectStatusDao {

	List<State> getObjectStatusList(HashMap<String, Object> params, PagerRequest pagerRequest) throws Exception;

	int getObjectStatusListCnt(HashMap<String, Object> params) throws Exception;

	void addObjectStatus(List<State> insertList) throws Exception;

	void updateObjectStatus(List<State> updateList) throws Exception;

    void removeObjectState(State state) throws Exception;

    int getHrApplicationStatus(HashMap params) throws Exception;
}
