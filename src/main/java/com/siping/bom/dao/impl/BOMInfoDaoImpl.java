package com.siping.bom.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.bom.dao.BOMInfoDao;
import com.siping.doc.bean.BusinessData;
import com.siping.process.bean.PagerRequest;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class BOMInfoDaoImpl extends SqlMapClientSupport implements BOMInfoDao {

    @Override
    public List<Bom> getBOMList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<Bom> list = new ArrayList<Bom>();
        try {
            if (pagerRequest != null) {
                list = (ArrayList<Bom>) this.queryForList("bom.bomInfo.getBOMList", params, pagerRequest.getPage(), pagerRequest.getPagesize());
            } else {
                list = (ArrayList<Bom>) this.queryForList("bom.bomInfo.getBOMList");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public int getBOMListCnt(Map<String, Object> params) throws Exception {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("bom.bomInfo.getBOMItemListCnt", params).toString());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return temp;
    }

    @Override
    public int getBOMItemListCnt(Map<String, Object> params) throws Exception {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("bom.bomInfo.getBOMItemListCnt", params).toString());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return temp;
    }

    @Override
    public List<BomItem> getBOMItemList(Map<String, Object> object, PagerRequest pagerRequest) throws Exception {
        List<BomItem> list = new ArrayList<BomItem>();
        try {
            if (pagerRequest != null) {
                list = (ArrayList<BomItem>) this.queryForList("bom.bomInfo.getBOMItemList", object, pagerRequest.getPage(), pagerRequest.getPagesize());
            } else {
                list = (ArrayList<BomItem>) this.queryForList("bom.bomInfo.getBOMItemList");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public Bom getBOMDetail(Bom bom) throws Exception {
        Bom resultBom = null;
        try {
            resultBom = (Bom) this.queryForObject("bom.bomInfo.getBOMDetail", bom);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return resultBom;
    }

}
