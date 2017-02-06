package com.siping.bom.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.bom.dao.BOMInfoDao;
import com.siping.bom.service.BOMInfoSer;
import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.Document;
import com.siping.doc.bean.MetaData;
import com.siping.doc.service.DocInfoSer;
import com.siping.mat.bean.Material;
import com.siping.mat.service.MatInfoSer;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.service.ProcessRunningSer;

@Service
public class BOMInfoSerImpl implements BOMInfoSer {
    Logger logger = Logger.getLogger(BOMInfoSer.class);

    @Autowired
    private BOMInfoDao bomInfoDao;

    @Autowired
    private DocInfoSer docInfoSer;

    @Autowired
    private MatInfoSer matInfoSer;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Override
    public List<Bom> getBOMList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception {
        return this.bomInfoDao.getBOMList(params, pagerRequest);
    }

    @Override
    public int getBOMListCnt(Map<String, Object> params) throws Exception {
        return this.bomInfoDao.getBOMListCnt(params);
    }

    @Override
    public List<BomItem> getBOMItemList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<BomItem> itemList = this.bomInfoDao.getBOMItemList(params, pagerRequest);
        MetaData metaData = (MetaData) params.get(MetaData.KEY);
        for (BomItem item : itemList) {
            try {
                item.setMetaData(metaData);
                BusinessData busiData = loadMaterial(item);
                item.setMaterial(busiData);
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return itemList;
    }

    private BusinessData loadMaterial(BomItem item) throws Exception {
        switch (item.getBomCategory()) {
            case MATERIAL:
                Material material = new Material();
                material.setNo(item.getMaterial().getNo());
                material.setMetaData(item.getMetaData());
                return this.matInfoSer.getMaterialDetail(material);
            case DOC:
                Document document = new Document();
                document.setNo(item.getMaterial().getNo());
                document.setMetaData(item.getMetaData());
                return this.docInfoSer.getDocumentDetail(document);
            default:
                throw new Exception("Item category is not supported!");
        }
    }

    @Override
    public int getBOMItemListCnt(Map<String, Object> params) throws Exception {
        return this.bomInfoDao.getBOMItemListCnt(params);
    }

    @Override
    public Bom getBOMDetail(Bom bom) throws Exception {
        MetaData metaData = bom.getMetaData();
        Bom resultBom = this.bomInfoDao.getBOMDetail(bom);
        resultBom.setMetaData(metaData);

        ProcessRunning running = processRunningSer.getProcessRunningInfo(resultBom);
        resultBom.setProcessRunning(running);
        return resultBom;
    }
}
