package com.siping.mat.service.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.MetaData;
import com.siping.mat.bean.Material;
import com.siping.mat.dao.MatInfoDao;
import com.siping.mat.service.MatInfoSer;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.service.ProcessRunningSer;

@Service
public class MatInfoSerImpl implements MatInfoSer {
    Logger logger = Logger.getLogger(MatInfoSerImpl.class);
    @Autowired
    private MatInfoDao matInfoDao;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Override
    public List<Material> getMaterialList(HashMap<String, Object> params, PagerRequest pagerRequest) throws Exception {
        return this.matInfoDao.getMaterialList(params, pagerRequest);
    }

    @Override
    public int getMaterialListCnt(HashMap<String, Object> params) throws Exception {
        return this.matInfoDao.getMaterialListCnt(params);
    }

    @Override
    public Material getMaterialDetail(Material material) throws Exception {
        MetaData metaData = material.getMetaData();
        Material result = this.matInfoDao.getMaterialDetail(material);
        if (result != null) {
            result.setMetaData(metaData);
            try {
                ProcessRunning running = processRunningSer.getProcessRunningInfo(result);
                result.setProcessRunning(running);
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return result;
    }
}
