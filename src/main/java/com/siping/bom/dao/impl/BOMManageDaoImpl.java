package com.siping.bom.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.bom.dao.BOMManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class BOMManageDaoImpl extends SqlMapClientSupport implements BOMManageDao {

    @Override
    public void addBOM(Bom bom) throws Exception {
        try {
            this.insert("bom.bomManage.addBOM", bom);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateBOMData(Bom bom) throws Exception {
        try {
            this.update("bom.bomManage.updateBOMData", bom);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void addBOMItems(List<BomItem> bomItems) throws Exception {
        try {
            this.insertForList("bom.bomManage.addBOMItem", bomItems);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateBOMItems(List<BomItem> bomItems) throws Exception {
        try {
            this.updateForList("bom.bomManage.updateBOMItem", bomItems);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteBOMItem(BomItem bomItem) throws Exception {
        try {
            this.update("bom.bomManage.deleteBOMItem", bomItem);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeBOM(Bom bom) throws Exception {
        try {
            this.insert("bom.bomManage.removeBOM", bom);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void addEndDate2ChangedItem(List<BomItem> list) throws Exception {
        try {
            this.updateForList("bom.bomManage.addEndDate2ChangedItem", list);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void addStartDate2ChangedItem(List<BomItem> list) throws Exception {
        try {
            this.updateForList("bom.bomManage.addStartDate2ChangedItem", list);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public String generateBomNo() throws Exception {
        String nextNo = null;
        try {
            nextNo = this.queryForObject("bom.bomManage.generateBomNo", null).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return nextNo;
    }

}
