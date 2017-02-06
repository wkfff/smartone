package com.siping.bom.dao;

import java.util.List;
import java.util.Map;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.process.bean.PagerRequest;

public interface BOMInfoDao {
    public List<Bom> getBOMList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception;

    public int getBOMListCnt(Map<String, Object> params) throws Exception;

    public List<BomItem> getBOMItemList(Map<String, Object> object, PagerRequest pagerRequest) throws Exception;

    public int getBOMItemListCnt(Map<String, Object> params) throws Exception;

    public Bom getBOMDetail(Bom bom) throws Exception;
}
