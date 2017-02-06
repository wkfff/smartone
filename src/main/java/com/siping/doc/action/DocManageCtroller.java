package com.siping.doc.action;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.doc.bean.MetaData;
import com.siping.doc.bean.RequestResult;
import com.siping.doc.service.DocInfoSer;
import com.siping.doc.service.DocManageSer;
import com.siping.mat.bean.IdType;
import com.siping.process.service.ObjectTypeSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/doc/docManage")
public class DocManageCtroller {
    Logger logger = Logger.getLogger(DocManageCtroller.class);

    @Autowired
    private DocManageSer docManageSer;

    @Autowired
    private DocInfoSer docInfoSer;

    @Autowired
    private ObjectTypeSer objectTypeSer;

    @RequestMapping(value = "/addDocument", method = RequestMethod.GET)
    public ModelAndView addDocument() {
        return new ModelAndView("/doc/docManage/addDocument");
    }

    @RequestMapping(value = "/updateDocument", method = RequestMethod.GET)
    public ModelAndView updateDocument(HttpServletRequest request, ModelMap modelMap, @RequestParam(value="documentNo",required=false) Long documentNo, @RequestParam(value="documentId",required=false) String documentId) {
        Document document = new Document();
        if(documentNo == null){
            document.setId(documentId);
        }else{
            document.setNo(documentNo);
        }

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            document.setMetaData(metaData);
            modelMap.put("documentDetail", this.docInfoSer.getDocumentDetail(document));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/doc/docManage/updateDocument", modelMap);
    }

    @RequestMapping(value = "/transferDocument", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferDocument(HttpServletRequest request, @RequestParam("jsonData") String jsonData, @RequestParam(value="idType",required=false) Integer idTypeNo) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            Document document = ObjectBindUtil.parseRequestJsonDataToObject(jsonData, Document.class);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            document.setMetaData(metaData);
            if (document.getNo() == null) {
                IdType idType = IdType.create(idTypeNo);
                this.docManageSer.generateDocId(idType, document);
                this.docManageSer.addDocument(document);
                result.setCode(Integer.parseInt(document.getId()));
            } else {
                Document doc = this.docInfoSer.getDocumentDetail(document);
                doc.setMetaData(document.getMetaData());
                if (!objectTypeSer.isObjectEditable(doc)) {
                    result.setMessage("Current state of document is not editable");
                    throw new Exception("Current state of document is not editable");
                }
                this.docManageSer.updateDocument(document);
            }
        } catch (Exception e) {
            result.setMessage("Fail to transfer document:" + e.getMessage());
            result.setCode(1000);
        }
        return result;
    }

    @RequestMapping(value = "/checkPermission", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> checkPermission(HttpServletRequest request, @RequestParam("documentNo") Long documentNo, @RequestParam("fileNo") Long fileNo){
        RequestResult<String> result = new RequestResult<String>();
        AdminBean user = SessionUtil.getLoginUserFromSession(request);
        try{
            Document document = new Document();
            document.setNo(documentNo);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            document.setMetaData(metaData);
            document = this.docInfoSer.getDocumentDetail(document);
            DocumentFile file = new DocumentFile();
            file.setNo(fileNo);
            file.setDocument(document);
            this.docManageSer.checkPermission(file, user);
        } catch (Exception e){
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/removeDocument", method = RequestMethod.GET)
    public ModelAndView removeDocument(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("documentDetail", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/doc/docManage/removeDocument");
    }

    @RequestMapping(value = "/removeDocument")
    @ResponseBody
    public RequestResult<String> removeDocument(HttpServletRequest request, @RequestParam("documentNo") Long documentNo) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Document document = new Document();
            document.setNo(documentNo);
            document.setMetaData(metaData);
            this.docManageSer.removeDocument(document);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /**
     * 返回添加文件页面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewUploadFile", method = RequestMethod.GET)
    public ModelAndView addFile(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        modelMap.put("type", "UPLOAD");
        return new ModelAndView("/doc/docManage/viewUploadFile", modelMap);
    }

    /**
     * 上传文件
     * @param file
     * @param request
     * @return
     */
    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> insertFile(HttpServletResponse response, HttpServletRequest request, @RequestParam("documentNo") Long documentNo) {
        RequestResult<String> result = new RequestResult<String>();
        MultipartHttpServletRequest multipartRequest = null;
        if (request instanceof MultipartHttpServletRequest) {
            multipartRequest = (MultipartHttpServletRequest) request;
        } else {
            result.setCode(1000);
            result.setMessage("No files was selected!");
            return result;
        }

        AdminBean user = SessionUtil.getLoginUserFromSession(request);
        Document document = new Document();
        try {
            MetaData meta = SessionUtil.generateMetaDataFromSession(request);
            document.setNo(documentNo);
            document.setMetaData(meta);
            document = this.docInfoSer.getDocumentDetail(document);
        } catch (Exception e) {
            result.setCode(1001);
            result.setMessage(e.getMessage());
            return result;
        }

        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        Set<String> key = fileMap.keySet();
        MetaData metaData = new MetaData();
        metaData.setCreateUser(user);
        metaData.setLastUpdateUser(user);

        for (Iterator<String> fileKeyIerator = key.iterator(); fileKeyIerator.hasNext();) {
            MultipartFile multiFile = fileMap.get(fileKeyIerator.next());
            try {
                DocumentFile file = new DocumentFile();
                file.setName(multiFile.getOriginalFilename());
                file.setMetaData(metaData);
                String path = this.docManageSer.uploadFile(request, multiFile, document);
                file.setPath(path);
                file.setDocument(document);
                this.docManageSer.addFile(file, user);
                result.setMessage("success!");
            } catch (Exception e) {
                result.setCode(1000);
                result.setMessage(e.getMessage());
                return result;
            }
        }

        return result;
    }

    /**
     * 删除文件
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> deleteFile(HttpServletRequest request, ModelMap modelMap, @RequestParam("fileNo") Long fileNo, @RequestParam("documentNo") Long documentNo) {
        AdminBean user = SessionUtil.getLoginUserFromSession(request);

        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData meta = SessionUtil.generateMetaDataFromSession(request);
            Document document = new Document();
            document.setNo(documentNo);
            document.setMetaData(meta);
            document = this.docInfoSer.getDocumentDetail(document);
            DocumentFile file = new DocumentFile();
            file.setNo(fileNo);
            file.setDocument(document);
            this.docManageSer.deleteFile(file, user);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /**
     * 下载文件
     * @param request
     * @param response
     * @throws SQLException
     * @throws IOException
     */
    @RequestMapping(value = "/downloadFile")
    public void downloadFile(HttpServletRequest request, HttpServletResponse response, @RequestParam("fileNos") String fileNos, @RequestParam("documentNo") Long documentNo) {
        AdminBean user = SessionUtil.getLoginUserFromSession(request);
        try {
            MetaData meta = SessionUtil.generateMetaDataFromSession(request);
            Document document = new Document();
            document.setNo(documentNo);
            document.setMetaData(meta);
            document = this.docInfoSer.getDocumentDetail(document);
            String[] fileNoArray = fileNos.split(",");
            List<DocumentFile> filesToDownLoad = new ArrayList<DocumentFile>();
            for(String fileNoStr: fileNoArray){
                DocumentFile file = new DocumentFile();
                file.setNo(Long.parseLong(fileNoStr));
                file.setDocument(document);
                file = this.docInfoSer.getDocumentFileDetail(file);
                filesToDownLoad.add(file);
            }
            this.docManageSer.downloadFile(response, filesToDownLoad , user, document);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    /**
     * 检出文件
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/checkOutFile", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> checkOutFile(HttpServletRequest request, ModelMap modelMap, @RequestParam("fileNo") Long fileNo, @RequestParam("documentNo") Long documentNo) {
        RequestResult<String> result = new RequestResult<String>();

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Document document = new Document();
            document.setNo(documentNo);
            document.setMetaData(metaData);
            document = this.docInfoSer.getDocumentDetail(document);
            document.setMetaData(metaData);
            DocumentFile file = new DocumentFile();
            file.setNo(fileNo);
            file.setDocument(document);
            file.setMetaData(metaData);
            this.docManageSer.checkOutFile(file);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /**
     * 检入文件页面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewCheckInFile", method = RequestMethod.GET)
    public ModelAndView viewCheckInFile(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        modelMap.put("type", "CHECKIN");
        return new ModelAndView("/doc/docManage/viewUploadFile", modelMap);
    }

    /**
     * 检入文件
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/checkInFile", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> checkInFile(HttpServletResponse response, HttpServletRequest request, @RequestParam("fileNo") Long fileNo, @RequestParam("documentNo") Long documentNo) {
        RequestResult<String> result = new RequestResult<String>();
        AdminBean user = SessionUtil.getLoginUserFromSession(request);
        MultipartHttpServletRequest multipartRequest = null;
        if (request instanceof MultipartHttpServletRequest) {
            multipartRequest = (MultipartHttpServletRequest) request;
        } else {
            result.setCode(1000);
            result.setMessage("No files was selected!");
            return result;
        }

        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        Set<String> key = fileMap.keySet();
        MetaData metaData = new MetaData();
        metaData.setCreateUser(user);
        metaData.setLastUpdateUser(user);

        for (Iterator<String> fileKeyIerator = key.iterator(); fileKeyIerator.hasNext();) {
            MultipartFile file = fileMap.get(fileKeyIerator.next());
            try {
                MetaData meta = SessionUtil.generateMetaDataFromSession(request);
                Document document = new Document();
                document.setNo(documentNo);
                document.setMetaData(meta);
                document = this.docInfoSer.getDocumentDetail(document);
                DocumentFile oldFile = new DocumentFile();
                oldFile.setName(file.getOriginalFilename());
                oldFile.setNo(fileNo);
                oldFile.setDocument(document);
                this.docManageSer.checkInFile(oldFile, user);

                DocumentFile newFile = oldFile.clone();
                String path = this.docManageSer.uploadFile(request, file, oldFile.getDocument());
                newFile.setPath(path);
                newFile.setDocument(document);
                this.docManageSer.addFile(newFile, user);
            } catch (Exception e) {
                result.setCode(1000);
                result.setMessage(e.getMessage());
            }
        }

        return result;
    }

    /**
     * 释放文件锁
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/releaseFileLock", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> releaseFileLock(HttpServletRequest request, ModelMap modelMap, @RequestParam("documentNo") Long documentNo, @RequestParam("fileNo") Long fileNo) {
        RequestResult<String> result = new RequestResult<String>();
        AdminBean user = SessionUtil.getLoginUserFromSession(request);

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Document document = new Document();
            document.setNo(documentNo);
            document.setMetaData(metaData);
            document = this.docInfoSer.getDocumentDetail(document);
            DocumentFile file = new DocumentFile();
            file.setNo(fileNo);
            file.setDocument(document);
            file.setMetaData(metaData);
            this.docManageSer.releaseFileLock(file, user);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/addDocObject", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> addRelObject(HttpServletRequest request, @RequestParam("documentNo") Long documentNo, @RequestParam("relObjectNo") Long relObjectNo,
                                              @RequestParam("relObjectType") String relObjectType) {
        RequestResult<String> result = new RequestResult<String>();
        AdminBean user = SessionUtil.getLoginUserFromSession(request);
        Document document = new Document();
        document.setNo(documentNo);

        BusinessData relObject = new BusinessData();
        relObject.setNo(relObjectNo);
        try {
            document = this.docInfoSer.getDocumentDetail(document);
            this.docManageSer.addRelObject(document, relObject, user);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/deleteDocObject", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> deleteDocObject(HttpServletRequest request, @RequestParam("documentNo") Long documentNo, @RequestParam("relObjectNo") Long relObjectNo,
                                                 @RequestParam("relObjectType") String relObjectType) {
        RequestResult<String> result = new RequestResult<String>();
        AdminBean user = SessionUtil.getLoginUserFromSession(request);
        Document document = new Document();
        document.setNo(documentNo);

        BusinessData relObject = new BusinessData();
        relObject.setNo(relObjectNo);
        try {
            document = this.docInfoSer.getDocumentDetail(document);
            this.docManageSer.deleteDocObject(document, relObject, user);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

}
