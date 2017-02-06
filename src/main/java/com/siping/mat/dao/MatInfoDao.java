package com.siping.mat.dao;

import java.util.HashMap;
import java.util.List;

import com.siping.mat.bean.Material;
import com.siping.process.bean.PagerRequest;

public interface MatInfoDao {

    public List<Material> getMaterialList(HashMap<String, Object> object, PagerRequest pagerRequest) throws Exception;

    public int getMaterialListCnt(HashMap<String, Object> params) throws Exception;

    public Material getMaterialDetail(Material material) throws Exception;

}
