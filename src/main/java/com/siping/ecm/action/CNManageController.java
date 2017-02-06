package com.siping.ecm.action;

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
import org.springframework.web.servlet.ModelAndView;

import com.siping.doc.bean.MetaData;
import com.siping.doc.bean.RequestResult;
import com.siping.ecm.bean.EngineerChange;
import com.siping.ecm.service.CNInfoSer;
import com.siping.ecm.service.CNManageSer;
import com.siping.mat.bean.IdType;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/ecm/cnManage")
public class CNManageController {
    Logger logger = Logger.getLogger(CNManageController.class);
    @Autowired
    private CNManageSer cnManageSer;

    @Autowired
    private CNInfoSer cnInfoSer;

    @RequestMapping(value = "/addChangeNo", method = RequestMethod.GET)
    public ModelAndView addChangeNo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("type", "add");
        return new ModelAndView("/ecm/cnManage/addChangeNo", modelMap);
    }

    @RequestMapping(value = "/updateChangeNo", method = RequestMethod.GET)
    public ModelAndView updateChangeNo(HttpServletRequest request, ModelMap modelMap, @RequestParam("changeNo") Long changeNo) {
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            EngineerChange ecn = new EngineerChange();
            ecn.setNo(changeNo);
            ecn.setMetaData(metaData);

            modelMap.put(EngineerChange.KEY, this.cnInfoSer.getChangeNoDetail(ecn));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/ecm/cnManage/updateChangeNo", modelMap);
    }

    @RequestMapping(value = "/transferChangeNo", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferChangeNo(HttpServletRequest request, @RequestParam("jsonData") String jsonData, @RequestParam(value = "idTypeNo", required = false) Integer idTypeNo) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            EngineerChange ecn = ObjectBindUtil.parseRequestJsonDataToObject(jsonData, EngineerChange.class);
            ecn.setMetaData(metaData);

            if (ecn.getNo() == null || ecn.getNo() == 0L) {
                IdType idType = IdType.create(idTypeNo);
                this.cnManageSer.generateEcnId(ecn, idType);
                this.cnManageSer.addChangeNo(ecn);
            } else {
                this.cnManageSer.updateChangeNo(ecn);
            }
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }

        return result;
    }

    @RequestMapping(value = "/removeChangeNo", method = RequestMethod.GET)
    public ModelAndView removeChangeNo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParams(request));
        return new ModelAndView("/ecm/cnManage/removeChangeNo");
    }

    @RequestMapping(value = "/removeChangeNo")
    @ResponseBody
    public RequestResult<String> removeChangeNo(HttpServletRequest request, @RequestParam("changeNo") Long changeNo) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            EngineerChange ecn = new EngineerChange();
            ecn.setNo(changeNo);
            ecn.setMetaData(metaData);

            this.cnManageSer.removeChangeNo(ecn);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/addObjects")
    @ResponseBody
    public RequestResult<String> addObjects(HttpServletRequest request, HttpServletResponse response) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            this.cnManageSer.addObjects(null, null);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/deleteObjects")
    @ResponseBody
    public RequestResult<String> deleteObjects(HttpServletRequest request, HttpServletResponse response) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            this.cnManageSer.deleteObjects(null, null);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/addObject")
    @ResponseBody
    public String addObject(HttpServletRequest request, HttpServletResponse response) {
        try {
            this.cnManageSer.addObject(null);
        } catch (Exception e) {

        }
        return null;
    }

}
