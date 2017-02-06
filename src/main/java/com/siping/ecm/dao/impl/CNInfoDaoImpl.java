package com.siping.ecm.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.doc.bean.BusinessData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.ecm.dao.CNInfoDao;
import com.siping.process.bean.PagerRequest;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CNInfoDaoImpl extends SqlMapClientSupport implements CNInfoDao {

    public List<EngineerChange> getChangeNoList(Map<String, Object> ecn, PagerRequest pagerRequest) throws Exception {
        List<EngineerChange> list = new ArrayList<EngineerChange>();
        try {
            if (!pagerRequest.supportPager()) {
                list = this.queryForList("ecm.cnInfo.getChangeNoList", ecn);
            } else {
                list = this.queryForList("ecm.cnInfo.getChangeNoList", ecn, pagerRequest.getPage(), pagerRequest.getPagesize());
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    public int getChangeNoListCnt(Map<String, Object> params) throws Exception {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("ecm.cnInfo.getChangeNoListCnt", params).toString());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return temp;
    }

    public EngineerChange getChangeNoDetail(EngineerChange ecn) throws Exception {
        EngineerChange resultEcn = null;
        try {
            if(ecn.getNo() == null || ecn.getNo() == 0L){
                resultEcn = (EngineerChange) this.queryForObject("ecm.cnInfo.getChangeNoDetailById", ecn);
            } else {
                resultEcn = (EngineerChange) this.queryForObject("ecm.cnInfo.getChangeNoDetail", ecn);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return resultEcn;
    }

    @Override
    public List getTypeList(Object object) {
        List resultList = new ArrayList();
        try {
            resultList = this.queryForList("ecm.cnInfo.getTypeList", object);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public List<BusinessData> getObjectList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<BusinessData> objectList = new ArrayList<BusinessData>();
        try {
            if (pagerRequest == null) {
                objectList = (ArrayList<BusinessData>)this.queryForList("ecm.cnInfo.getObjectList", params);
            }else{
                objectList = (ArrayList<BusinessData>)this.queryForList("ecm.cnInfo.getObjectList", params, pagerRequest.getPage(), pagerRequest.getPagesize());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return objectList;
    }

    @Override
    public int getObjectListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("ecm.cnInfo.getObjectListCnt", object).toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return temp;
    }
}
