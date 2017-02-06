package com.siping.mat.dao;

import com.siping.mat.bean.Material;

public interface MatManageDao {
    public String addMaterial(Material material) throws Exception;

    public void updateMaterialData(Material material) throws Exception;

    public void removeMaterial(Material mat) throws Exception;

    public String copyMaterial(Object object) throws Exception;

    public String generateMatId() throws Exception;
}
