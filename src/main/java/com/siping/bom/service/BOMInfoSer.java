package com.siping.bom.service;

import java.util.List;
import java.util.Map;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.process.bean.PagerRequest;

public interface BOMInfoSer {
    public List<Bom> getBOMList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception;

    public int getBOMListCnt(Map<String, Object> request) throws Exception;

    public List<BomItem> getBOMItemList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception;

    public int getBOMItemListCnt(Map<String, Object> params) throws Exception;

    public Bom getBOMDetail(Bom bom) throws Exception;

}
