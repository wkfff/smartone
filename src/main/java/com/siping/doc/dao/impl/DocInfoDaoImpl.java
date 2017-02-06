package com.siping.doc.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.doc.dao.DocInfoDao;
import com.siping.process.bean.PagerRequest;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class DocInfoDaoImpl extends SqlMapClientSupport implements DocInfoDao {

    @Override
    public List<Document> getDocumentList(HashMap<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<Document> list = new ArrayList<Document>();
        try {
            if(pagerRequest != null && pagerRequest.supportPager()){
                list = (ArrayList<Document>)this.queryForList("doc.docInfo.getDocumentList", params, pagerRequest.getPage(), pagerRequest.getPagesize());
            }else{
                list = (ArrayList<Document>)this.queryForList("doc.docInfo.getDocumentList", params);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public int getFileListCnt(Map<String, Object> params) throws Exception {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("doc.docInfo.getFileListCnt", params).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List<DocumentFile> getFileList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception {
        List<DocumentFile> list = new ArrayList<DocumentFile>();
        try {
            if(pagerRequest!=null && pagerRequest.supportPager()){
                list = (ArrayList<DocumentFile>)this.queryForList("doc.docInfo.getFileList", params, pagerRequest.getPage(), pagerRequest.getPagesize());
            }else{
                list = (ArrayList<DocumentFile>)this.queryForList("doc.docInfo.getFileList", params);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public DocumentFile getDocumentFileDetail(DocumentFile file) throws Exception {
        try {
            file = (DocumentFile) this.queryForObject("doc.docInfo.getFileInfo", file);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Query document detail failed:" + e.getMessage());
        }
        return file;
    }

    @Override
    public int getDocumentListCnt(HashMap<String, Object> params) throws Exception {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("doc.docInfo.getDocumentListCnt", params).toString());
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getDocObjectList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("doc.docInfo.getDocObjectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getDocObjectListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("doc.docInfo.getDocObjectListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public Document getDocumentDetail(Document document) throws Exception {
        try {
          if(document.getNo() == null || document.getNo() == 0L){
              document = (Document)this.queryForObject("doc.docInfo.getDocumentDetailById", document);
          } else {
              document = (Document)this.queryForObject("doc.docInfo.getDocumentDetail", document);
          }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Query document detail failed:" + e.getMessage());
        }
        return document;
    }

    @Override
    public Object getDocumentDetailB(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("doc.docInfo.getDocumentDetailB", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @Override
    public String getNextDocumentId(Object object) throws SQLException {
        return this.queryForObject("doc.docManage.getNextDocumentId", object).toString();
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getWorkDocumentList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("doc.docInfo.getWorkDocumentList", object, Integer.parseInt(((Map) object).get("page").toString()), Integer.parseInt(((Map) object).get("pagesize").toString()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getWorkDocumentListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("doc.docInfo.getWorkDocumentListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }
}
