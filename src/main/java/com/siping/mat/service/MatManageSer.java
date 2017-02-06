package com.siping.mat.service;

import com.siping.mat.bean.IdType;
import com.siping.mat.bean.Material;

public interface MatManageSer {
    public String addMaterial(Material material) throws Exception;

    public void updateMaterial(Material material) throws Exception;

    public void removeMaterial(Material mat) throws Exception;

    public void generateMatId(IdType id, Material material) throws Exception;

}
