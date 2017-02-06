package com.siping.bom.dao;

import java.util.List;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;

public interface BOMManageDao {
    void addBOM(Bom bom) throws Exception;

    void updateBOMData(Bom bom) throws Exception;

    void removeBOM(Bom bom) throws Exception;

    void deleteBOMItem(BomItem bomItem) throws Exception;

    void updateBOMItems(List<BomItem> bomItems) throws Exception;

    void addBOMItems(List<BomItem> bomItems) throws Exception;

    void addEndDate2ChangedItem(List<BomItem> list) throws Exception;

    void addStartDate2ChangedItem(List<BomItem> list) throws Exception;

    String generateBomNo() throws Exception; 
}
