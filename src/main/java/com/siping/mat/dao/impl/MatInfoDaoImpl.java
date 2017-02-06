package com.siping.mat.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.mat.bean.Material;
import com.siping.mat.dao.MatInfoDao;
import com.siping.process.bean.PagerRequest;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MatInfoDaoImpl extends SqlMapClientSupport implements MatInfoDao {

    public List<Material> getMaterialList(HashMap<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<Material> list = new ArrayList<Material>();
        try {
            if (pagerRequest == null || pagerRequest.getPage() == 0) {
                list = (ArrayList<Material>) this.queryForList("mat.matInfo.getMaterialList", params);
            } else {
                list = (ArrayList<Material>) this.queryForList("mat.matInfo.getMaterialList", params, pagerRequest.getPage(), pagerRequest.getPagesize());
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    public int getMaterialListCnt(HashMap<String, Object> params) throws Exception {
        int count = 0;
        try {
            count = Integer.parseInt(this.queryForObject("mat.matInfo.getMaterialListCnt", params).toString());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return count;
    }

    public Material getMaterialDetail(Material material) throws Exception {
        try {
            if (material.getNo() == null || material.getNo() == 0L) {
                material = (Material) this.queryForObject("mat.matInfo.getMaterialDetailById", material);
            } else {
                material = (Material) this.queryForObject("mat.matInfo.getMaterialDetail", material);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return material;
    }
}
