package com.siping.doc.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.doc.bean.Document;
import com.siping.doc.bean.DocumentFile;
import com.siping.doc.bean.MetaData;
import com.siping.doc.service.DocInfoSer;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.PagerResult;
import com.siping.productStorage.bean.Company;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/doc/docInfo")
public class DocInfoCtroller {
    Logger logger = Logger.getLogger(DocInfoCtroller.class);

    @Autowired
    private DocInfoSer docInfoSer;

    @RequestMapping(value = "/viewDocumentList", method = RequestMethod.GET)
    public ModelAndView viewDocumentList(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/doc/docInfo/viewDocumentList", modelMap);
    }

    @RequestMapping(value = "/viewDocumentDetail", method = RequestMethod.GET)
    public ModelAndView viewDocumentDetail(HttpServletRequest request, ModelMap modelMap, @RequestParam(value="documentNo",required=false) Long documentNo) {
        Document document = new Document();
        document.setNo(documentNo);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            document.setMetaData(metaData);
            document = this.docInfoSer.getDocumentDetail(document);
            modelMap.put("documentDetail", document);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        return new ModelAndView("/doc/docInfo/viewDocumentDetail", modelMap);
    }

    @RequestMapping(value = "/getDocumentList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<Document> getDocumentList(HttpServletRequest request, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                                 @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize) {
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        AdminBean user = SessionUtil.getLoginUserFromSession(request);
        HashMap<String,Object> params = ObjectBindUtil.getRequestParams(request);

        PagerResult<Document> pagerResult = new PagerResult<Document>();
        params.put(Company.KEY_OF_ID, user.getCpnyId());
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);
            pagerResult.setRows(this.docInfoSer.getDocumentList(params, user, pagerRequest));
            pagerResult.setTotal(this.docInfoSer.getDocumentListCnt(params, user));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return pagerResult;
    }

    @RequestMapping(value = "/getWorkDocumentList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<Document> getWorkDocumentList(HttpServletRequest request, ModelMap params, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                                     @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize) {
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        AdminBean user = SessionUtil.getLoginUserFromSession(request);

        PagerResult<Document> pagerResult = new PagerResult<Document>();
        try {
            pagerResult.setRows(this.docInfoSer.getWorkDocumentList(params, user, pagerRequest));
            pagerResult.setTotal(this.docInfoSer.getWorkDocumentListCnt(params, user));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return pagerResult;
    }

    @RequestMapping(value = "/getFileList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<DocumentFile> getFileList(HttpServletRequest request, @RequestParam("DOC_NO") Long documentNo, @RequestParam(value = "active", required = false) Boolean active,
                                                 @RequestParam(value = PagerRequest.KEY_PAGE, required = false) Integer page,
                                                 @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) Integer pagesize) {
        Document document = new Document();
        document.setNo(documentNo);
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        PagerResult<DocumentFile> pagerResult = new PagerResult<DocumentFile>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            document.setMetaData(metaData);
            pagerResult.setRows(this.docInfoSer.getFileList(document, active, pagerRequest));
            pagerResult.setTotal(this.docInfoSer.getFileListCnt(document, active));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return pagerResult;
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getDocObjectList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDocObjectList(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("Rows", this.docInfoSer.getDocObjectList(request));
        modelMap.put("Total", this.docInfoSer.getDocObjectListCnt(request));
        return modelMap;
    }

    /**
     * check if document id is duplicated
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/checkDocumentID", method = RequestMethod.POST)
    @ResponseBody
    public String checkDocumentID(HttpServletRequest request, ModelMap modelMap, @RequestParam("documentID") String documentID) {
        String resultstring = "1";
        Company company = SessionUtil.getCompanyFromSession(request);

        Document document = new Document();
        MetaData metaData = new MetaData(new Date());
        metaData.setCompany(company);
        document.setMetaData(metaData);
        document.setId(documentID);

        Document resutlDocument = null;
        try {
            resutlDocument = this.docInfoSer.getDocumentDetail(document);
        } catch (Exception e) {
        }

        if (resutlDocument == null) {
            resultstring = "0";
        } else {
            resultstring = "1";
        }

        return resultstring;
    }

    /**
     * check if document is duplicated
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/checkDocument", method = RequestMethod.POST)
    @ResponseBody
    public String checkDocument(HttpServletRequest request, ModelMap modelMap) {
        return this.docInfoSer.checkDocument(request);
    }

}
