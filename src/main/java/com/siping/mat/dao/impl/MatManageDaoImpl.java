package com.siping.mat.dao.impl;

import org.springframework.stereotype.Repository;

import com.siping.mat.bean.Material;
import com.siping.mat.dao.MatManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MatManageDaoImpl extends SqlMapClientSupport implements MatManageDao {
    @Override
    public String addMaterial(Material material) throws Exception {
        try {
            this.insert("mat.matManage.addMaterial", material);
            return material.getNo().toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateMaterialData(Material material) throws Exception {
        try {
            this.update("mat.matManage.updateMaterialData", material);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeMaterial(Material material) throws Exception {
        try {
            this.update("mat.matManage.removeMaterial", material);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public String copyMaterial(Object object) throws Exception {
        return this.insert("mat.matManage.copyMaterial", object).toString();
    }

    @Override
    public String generateMatId() throws Exception {
        try {
            return this.queryForObject("mat.matManage.generateMatId", null).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
