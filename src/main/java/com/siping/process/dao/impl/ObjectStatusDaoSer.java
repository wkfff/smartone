package com.siping.process.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.State;
import com.siping.process.dao.ObjectStatusDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ObjectStatusDaoSer extends SqlMapClientSupport implements ObjectStatusDao {

    @Override
    public List<State> getObjectStatusList(HashMap<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<State> list = null;
        try {
            if (pagerRequest == null || pagerRequest.getPage() == 0) {
                list = (List<State>) this.queryForList("process.objectStatus.getObjectStatusList", params, pagerRequest.getPage(), pagerRequest.getPagesize());
            } else {
                list = (List<State>) this.queryForList("process.objectStatus.getObjectStatusList", params);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public int getObjectStatusListCnt(HashMap<String, Object> params) throws Exception {
        int count = 0;
        try {
            count = Integer.parseInt(this.queryForObject("process.objectStatus.getObjectStatusListCnt", params).toString());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return count;
    }

    @Override
    public void addObjectStatus(List<State> insertList) throws Exception {
        try {
            this.insertForList("process.objectStatus.addObjectStatus", insertList);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateObjectStatus(List<State> updateList) throws Exception {
        try {
            this.updateForList("process.objectStatus.updateObjectStatus", updateList);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeObjectState(State state) throws Exception {
        try {
            this.update("process.objectStatus.removeObjectStatus", state);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

	@Override
	public int getHrApplicationStatus(HashMap params) throws Exception {
		// TODO Auto-generated method stub
		Integer status = 3;
//		0申请中1申请成功2申请失败3未申请
        try {
        		status = (Integer) this.queryForObject("process.objectStatus.getHrApplicationStatus", params);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        
        if(status == null){
        		status = 3;
        }
        
		return status;
	}
}
