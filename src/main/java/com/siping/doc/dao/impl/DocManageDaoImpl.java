package com.siping.doc.dao.impl;

import org.springframework.stereotype.Repository;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.doc.dao.DocManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class DocManageDaoImpl extends SqlMapClientSupport implements DocManageDao {

    @Override
    public String addDocument(Document document) throws Exception {
        String docId = null;
        try {
            docId = (String) this.insert("doc.docManage.addDocument", document);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return docId;
    }

    @Override
    public void updateDocument(Document document) throws Exception {
        try {
            this.update("doc.docManage.updateDocument", document);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeDocument(Document document) throws Exception {
        try {
            this.update("doc.docManage.removeDocument", document);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateDocumentStatus(Document document) throws Exception {
        try {
            this.update("doc.docManage.updateDocumentStatus", document);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public String addFile(DocumentFile file) throws Exception {
        try {
            return this.insert("doc.docManage.uploadFile", file).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

    }

    @Override
    public void deleteFile(DocumentFile file) throws Exception {
        this.update("doc.docManage.deleteFile", file);
    }

    @Override
    public DocumentFile getFileInfo(DocumentFile file) throws Exception {
        try {
            return (DocumentFile) this.queryForObject("doc.docInfo.getFileInfo", file);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void releaseFileLock(DocumentFile file) throws Exception {
        this.update("doc.docManage.releaseFileLock", file);
    }

    @Override
    public void checkOutFile(Object object) throws Exception {
        this.update("doc.docManage.checkOutFile", object);
    }

    @Override
    public void deleteDocObject(Object object) throws Exception {
        this.update("doc.docManage.deleteDocObject", object);
    }

    @Override
    public void addDocObject(Document Document, BusinessData data) throws Exception {
        this.insert("doc.docManage.addDocObject", Document);
    }

    @Override
    public String copyDocument(Object object) throws Exception {
        return this.insert("doc.docManage.copyDocument", object).toString();
    }

    @Override
    public String generateDocId() throws Exception {
        try {
            return this.queryForObject("doc.docManage.generateDocId", null).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
