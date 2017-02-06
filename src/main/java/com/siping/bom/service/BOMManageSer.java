package com.siping.bom.service;

import java.util.List;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.ecm.bean.EngineerChange;

public interface BOMManageSer {

    String addBOM(Bom bom) throws Exception;

    void updateBOM(Bom bom) throws Exception;

    void removeBOM(Bom bom) throws Exception;

    void deleteBOMItem(BomItem bomItem, Bom bom) throws Exception;

    void transferBOMItems(List<BomItem> bomItems, Bom bom, EngineerChange ecn) throws Exception;

    void generateBomId(Bom bom) throws Exception;
}
