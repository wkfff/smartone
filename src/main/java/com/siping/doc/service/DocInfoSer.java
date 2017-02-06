package com.siping.doc.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.process.bean.PagerRequest;
import com.siping.system.bean.AdminBean;

public interface DocInfoSer {
    public List<Document> getDocumentList(HashMap<String, Object> params, AdminBean user, PagerRequest pagerRuest) throws Exception;

    public int getDocumentListCnt(HashMap<String, Object> params, AdminBean user) throws Exception;

    public Document getDocumentDetail(Document document) throws Exception;

    @SuppressWarnings({ "rawtypes" })
    public List<DocumentFile> getFileList(Document document, Boolean active, PagerRequest pagerRequest) throws Exception;

    public DocumentFile getDocumentFileDetail(DocumentFile file) throws Exception;

    public int getFileListCnt(Document document, Boolean active) throws Exception;

    @SuppressWarnings({ "rawtypes" })
    public List getDocObjectList(HttpServletRequest request);

    public int getDocObjectListCnt(HttpServletRequest request);

    public String checkDocument(HttpServletRequest request);

    public List<Document> getWorkDocumentList(HashMap params, AdminBean user, PagerRequest pagerRequest);

    public int getWorkDocumentListCnt(HashMap params, AdminBean user);
}
