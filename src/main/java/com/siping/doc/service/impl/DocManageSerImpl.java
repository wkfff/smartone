package com.siping.doc.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.zip.CRC32;
import java.util.zip.CheckedOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.doc.bean.MetaData;
import com.siping.doc.dao.DocInfoDao;
import com.siping.doc.dao.DocManageDao;
import com.siping.doc.service.DocInfoSer;
import com.siping.doc.service.DocManageSer;
import com.siping.mat.bean.IdType;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.bean.Type;
import com.siping.process.dao.ObjectTypeDao;
import com.siping.process.dao.ProcessManageDao;
import com.siping.process.service.ObjectTypeSer;
import com.siping.process.service.ProcessRunningSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.RandomUtil;

@Service
public class DocManageSerImpl implements DocManageSer {
    Logger logger = Logger.getLogger(DocManageSer.class);

    @Autowired
    private DocManageDao docManageDao;

    @Autowired
    private DocInfoDao docInfoDao;

    @Autowired
    private ObjectTypeSer objectTypeSer;

    @Autowired
    private ProcessManageDao processManageDao;

    @Autowired
    private ObjectTypeDao objectTypeDao;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Autowired
    private DocInfoSer docInfoSer;

    @Override
    public String addDocument(Document document) throws Exception {
        AdminBean admin = document.getMetaData().getCreateUser();
        Type type = document.getProcessRunning().getType();
        type.setMetaData(document.getMetaData());
        if (objectTypeSer.getAdminObjectGrant(admin, type).getCreateable()) {
            ProcessRunning running = this.processRunningSer.addProcessRunningInfo(document);
            document.setProcessRunning(running);
            return this.docManageDao.addDocument(document);
        } else {
            throw new Exception("No right to create this type of Document!");
        }
    }

    public Document updateDocument(Document document) throws Exception {
        AdminBean user = document.getMetaData().getCreateUser();
        Type type = document.getProcessRunning().getType();
        type.setMetaData(document.getMetaData());
        if (objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            processRunningSer.updateProcessRunningForBusinessData(document);
            docManageDao.updateDocument(document);
            /*Document oriDocument = this.docInfoDao.getDocumentDetail(document);

            if (!document.getProcessRunning().getState().equals(oriDocument.getProcessRunning().getState())) {
                //TODO STATE UPDATE TO BE FINISH
                this.processManageDao.getObjectProcessNO(document);
                docManageDao.updateDocumentStatus(document);
            }*/
        } else {
            throw new Exception("No right to update this type of Document!");
        }
        return document;
    }

    @Override
    public void checkPermission(DocumentFile file, AdminBean user) throws Exception {
        try {
            file = this.docManageDao.getFileInfo(file);
        } catch (Exception e) {
            throw e;
        }

        if (!file.getLocked()) {
            throw new Exception("File was not checkek out");
        }

        if (!file.getActive()) {
            throw new Exception("File was not used!");
        }

        if (!file.getLockUser().getAdminID().equals(user.getAdminID())) {
            throw new Exception("You area not the user who checkd out the file");
        }
    }

    @Override
    public void removeDocument(Document document) throws Exception {
        Document doc = this.docInfoSer.getDocumentDetail(document);
        Type type = doc.getProcessRunning().getType();
        type.setMetaData(document.getMetaData());
        AdminBean user = document.getMetaData().getLastUpdateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getDeleteable()) {
            document.setActive(false);
            this.docManageDao.removeDocument(document);
        } else {
            throw new Exception("No right to delete this type of Document!");
        }
    }

    @Override
    public String uploadFile(HttpServletRequest request, MultipartFile multiFile, Document document) throws Exception {
        String filePath = request.getSession().getServletContext().getRealPath("/document/" + document.getMetaData().getCompany().getCompanyId() + "/doc/" + document.getId() + "/");
        try {
            File uploadFilePath = new File(filePath);
            if (!uploadFilePath.exists())
                uploadFilePath.mkdirs();
            filePath += "\\" + RandomUtil.getRandomNumber(1) + DateUtil.getSysdateString("yyyyMMddHHmmssSSS") + RandomUtil.getRandomNumber(1);
            multiFile.transferTo(new File(filePath));
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return filePath;
    }

    @Override
    public String addFile(DocumentFile file, AdminBean user) throws Exception {
        Document document = this.docInfoSer.getDocumentDetail(file.getDocument());
        Type type = document.getProcessRunning().getType();
        type.setMetaData(file.getDocument().getMetaData());

        if (objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            String fileNo = null;
            try {
                fileNo = this.docManageDao.addFile(file);
            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
            return fileNo;
        } else {
            throw new Exception("No right to edit this Document!");
        }
    }

    @Override
    public void deleteFile(DocumentFile file, AdminBean user) throws Exception {
        Type type = file.getDocument().getProcessRunning().getType();
        type.setMetaData(file.getDocument().getMetaData());
        if (objectTypeSer.getAdminObjectGrant(user, type).getDeleteable()) {
            try {
                this.docManageDao.deleteFile(file);
            } catch (SQLException e) {
                throw e;
            }
        } else {
            throw new Exception("No right to edit on this document to delete file");
        }
    }

    @Override
    public void downloadFile(HttpServletResponse response, List<DocumentFile> file, AdminBean user, Document document) throws Exception {
        Type type = document.getProcessRunning().getType();
        type.setMetaData(document.getMetaData());
        response.reset();
        if (objectTypeSer.getAdminObjectGrant(user, type).getReadable()) {

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
            String dateString = formatter.format(new Date());
            String zipFileName = "当前文件_" + dateString + ".zip";
            File zipFile = null;
            /*List<DocumentFile> files = new ArrayList<DocumentFile>();
            files.add(file);*/
            try {
                zipFile = zipFile(zipFileName, file);
            } catch (Exception e) {
                throw e;
            }
            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            String fileName = zipFileName;

            // fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
            response.setHeader("Content-Disposition", "attachment;fileName=" + java.net.URLEncoder.encode(fileName, "UTF-8"));

            // String filePath = fileMap.get("FILE_PATH").toString();
            InputStream inputStream = new FileInputStream(zipFile);
            OutputStream outputStream = response.getOutputStream();

            // response.setCharacterEncoding("UTF-8");
            byte[] b = new byte[1024];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                outputStream.write(b, 0, length);
            }
            inputStream.close();
            outputStream.close();
            zipFile.delete();
        }
    }

    /**
     * ZIP all the files to a zipFile
     * @param zipName
     * @param files
     * @return ZIP file
     */
    private static File zipFile(String zipName, List<DocumentFile> files) throws Exception {
        File file = new File(zipName);
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            CheckedOutputStream cos = new CheckedOutputStream(fileOutputStream, new CRC32());
            ZipOutputStream out = new ZipOutputStream(cos);
            out.setEncoding("UTF-8");
            for (DocumentFile oneFile : files) {
                FileInputStream in = new FileInputStream(new File(oneFile.getPath()));
                String fileName = oneFile.getName();
                ZipEntry entry = new ZipEntry(fileName);
                out.putNextEntry(entry);
                int len = 0;
                byte[] bytes = new byte[1024];
                while ((len = in.read(bytes, 0, bytes.length)) != -1) {
                    out.write(bytes, 0, len);
                }
                out.closeEntry();
                in.close();
            }
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return file;
    }

    @Override
    public void releaseFileLock(DocumentFile file, AdminBean user) throws Exception {

        try {
            file = this.docManageDao.getFileInfo(file);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

        if (!file.getLocked()) {
            throw new Exception("File was checked out");
        }

        if (!file.getLockUser().getAdminID().equals(user.getAdminID())) {
            throw new Exception("You can not release the file locked by other user");
        }

        try {
            this.docManageDao.releaseFileLock(file);
        } catch (SQLException e) {
            throw e;
        }
    }

    @Override
    public void checkOutFile(DocumentFile file) throws Exception {
        MetaData metaDate = file.getMetaData();
        Type type = file.getDocument().getProcessRunning().getType();
        type.setMetaData(metaDate);

        AdminBean user = metaDate.getLastUpdateUser();
        DocumentFile newfile;
        if (objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            try {
                newfile = this.docManageDao.getFileInfo(file);
                newfile.setLockUser(user);
            } catch (SQLException e) {
                throw e;
            }

            if (file.getLocked()) {
                throw new Exception("File was checked out by other");
            }

            if (!file.getActive()) {
                throw new Exception("File was already unsed");
            }

            try {
                this.docManageDao.checkOutFile(newfile);
            } catch (SQLException e) {
                throw e;
            }
        } else {
            throw new Exception("No right to edit document");
        }
    }

    @Override
    public void checkInFile(DocumentFile documentFile, AdminBean user) throws Exception {
        try {
            documentFile = this.docManageDao.getFileInfo(documentFile);
        } catch (Exception e) {
            throw e;
        }

        try {
            this.docManageDao.releaseFileLock(documentFile);
            this.docManageDao.deleteFile(documentFile);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void addRelObject(Document document, BusinessData relatedObject, AdminBean user) throws Exception {
        if (objectTypeSer.getAdminObjectGrant(user, document.getProcessRunning().getType()).getWriteable()) {
            if (objectTypeDao.isObjectEditable(document)) {// 所处的状态是否可以编辑内容
                try {
                    this.docManageDao.addDocObject(document, relatedObject);
                } catch (Exception e) {
                    throw e;
                }
            } else {
                throw new Exception("Document was not editable");
            }
        } else {
            throw new Exception("No right to access this document");
        }
    }

    @Override
    public void deleteDocObject(Document document, BusinessData relatedObject, AdminBean user) throws Exception {
        if (objectTypeSer.getAdminObjectGrant(user, document.getProcessRunning().getType()).getWriteable()) {
            if (objectTypeDao.isObjectEditable(document)) {// 所处的状态是否可以编辑内容
                try {
                    this.docManageDao.deleteDocObject(document);
                } catch (Exception e) {
                    throw e;
                }
            } else {
                throw new Exception("该状态不可编辑");
            }
        } else {
            throw new Exception("你没有编辑文档的权限！请联系管理员");
        }
    }

    @Override
    public void generateDocId(IdType id, Document document) throws Exception {
        String noStr = this.docManageDao.generateDocId();
        String idStr = document.getId();

        switch (id) {
            case INNER:
                idStr = noStr;
                break;
            case MIX:
                idStr += ("-" + noStr);
                break;
            case OUTER:
                if (idStr == null || idStr.trim().equals("")) {
                    throw new Exception("Wrong param to generate idStr!");
                }
                if (this.docInfoDao.getDocumentDetail(document)!= null) {
                    throw new Exception("Duplicated document data!");
                }
                break;
        }
        document.setNo(Long.parseLong(noStr));
        document.setId(idStr);
    }

}
