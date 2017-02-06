package com.siping.doc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.mat.bean.IdType;
import com.siping.mat.bean.Material;
import com.siping.system.bean.AdminBean;

public interface DocManageSer {

    String addDocument(Document document) throws Exception;

    public void generateDocId(IdType id, Document document) throws Exception;

    Document updateDocument(Document document) throws Exception;

    public void removeDocument(Document document) throws Exception;

    public void checkPermission(DocumentFile file, AdminBean user) throws Exception;

    String uploadFile(HttpServletRequest request, MultipartFile file, Document document) throws Exception;

    public String addFile(DocumentFile file, AdminBean user) throws Exception;

    void deleteFile(DocumentFile file, AdminBean user) throws Exception;

    void releaseFileLock(DocumentFile file, AdminBean user) throws Exception;

    void downloadFile(HttpServletResponse response, List<DocumentFile> files, AdminBean user, Document document) throws Exception;

    void checkOutFile(DocumentFile file) throws Exception;

    void checkInFile(DocumentFile documentFile, AdminBean user) throws Exception;

    void addRelObject(Document document, BusinessData relatedObject, AdminBean user) throws Exception;

    void deleteDocObject(Document document, BusinessData relatedObject, AdminBean user) throws Exception;

}
