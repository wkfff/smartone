package com.siping.doc.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.doc.bean.MetaData;
import com.siping.doc.dao.DocInfoDao;
import com.siping.doc.service.DocInfoSer;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.service.ProcessRunningSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class DocInfoSerImpl implements DocInfoSer {
    Logger logger = Logger.getLogger(DocInfoSer.class);

    @Autowired
    private DocInfoDao docInfoDao;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Override
    public List<Document> getDocumentList(HashMap<String, Object> params, AdminBean user, PagerRequest pagerRuest) throws Exception {
        return this.docInfoDao.getDocumentList(params, pagerRuest);
    }

    @Override
    public int getDocumentListCnt(HashMap<String, Object> params, AdminBean user) throws Exception {
        return this.docInfoDao.getDocumentListCnt(params);
    }

    @Override
    public List<DocumentFile> getFileList(Document document, Boolean active, PagerRequest pagerRequest) throws Exception {
        try {
            Map<String, Object> params = new LinkedHashMap<String, Object>();
            params.put("document", document);
            params.put("active", active);
            return this.docInfoDao.getFileList(params, pagerRequest);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public DocumentFile getDocumentFileDetail(DocumentFile file) throws Exception {
        file = this.docInfoDao.getDocumentFileDetail(file);
        return file;
    }

    @Override
    public int getFileListCnt(Document document, Boolean active) throws Exception {
        Map<String, Object> params = new LinkedHashMap<String, Object>();
        params.put("document", document);
        params.put("active", active);
        return this.docInfoDao.getFileListCnt(params);
    }

    @Override
    public List getDocObjectList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.docInfoDao.getDocObjectList(paramMap);
    }

    @Override
    public int getDocObjectListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.docInfoDao.getDocObjectListCnt(paramMap);
    }

    @Override
    public Document getDocumentDetail(Document document) throws Exception {
        MetaData metaData = document.getMetaData();
        Document detailDocument = this.docInfoDao.getDocumentDetail(document);
        if(detailDocument != null){
            detailDocument.setMetaData(metaData);
            try {
                ProcessRunning running = processRunningSer.getProcessRunningInfo(detailDocument);
                detailDocument.setProcessRunning(running);
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return detailDocument;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String checkDocument(HttpServletRequest request) {
        String resultstring = "1";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        Object obj = this.docInfoDao.getDocumentDetailB(paramMap);

        if (obj == null) {
            resultstring = "0";
        } else {
            resultstring = "1";
        }

        return resultstring;
    }

    @Override
    public List<Document> getWorkDocumentList(HashMap params, AdminBean user, PagerRequest pagerRequest) {
        if (params.get("OBJECT_ID") == null || "".equals(params.get("OBJECT_ID"))) {
            params.put("OBJECT_ID", user.getAdminID());
        }
        if (params.get("OBJECT_TYPE_ID") == null || "".equals(params.get("OBJECT_TYPE_ID"))) {
            params.put("OBJECT_TYPE_ID", "ADMIN");
        }
        params.put("CPNY_ID", user.getCpnyId());
        return this.docInfoDao.getWorkDocumentList(params);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getWorkDocumentListCnt(HashMap params, AdminBean user) {
        params.put("OBJECT_ID", user.getAdminID());
        params.put("OBJECT_TYPE_ID", "ADMIN");
        params.put("CPNY_ID", user.getCpnyId());
        return this.docInfoDao.getWorkDocumentListCnt(params);
    }
}
