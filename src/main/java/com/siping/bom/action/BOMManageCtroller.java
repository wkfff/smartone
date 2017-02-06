package com.siping.bom.action;

import java.util.List;

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

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.bom.service.BOMInfoSer;
import com.siping.bom.service.BOMManageSer;
import com.siping.doc.bean.MetaData;
import com.siping.doc.bean.RequestResult;
import com.siping.ecm.bean.EngineerChange;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/bom/bomManage")
public class BOMManageCtroller {
    Logger logger = Logger.getLogger(BOMManageCtroller.class);

    @Autowired
    private BOMManageSer bomManageSer;

    @Autowired
    private BOMInfoSer bomInfoSer;

    @RequestMapping(value = "/addBOM", method = RequestMethod.GET)
    public ModelAndView addBOM(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/bom/bomManage/addBOM", modelMap);
    }

    @RequestMapping(value = "/updateBOM", method = RequestMethod.GET)
    public ModelAndView updateBOM(HttpServletRequest request, ModelMap modelMap, @RequestParam("bomNo") Long bomNo) {
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Bom bom = new Bom();
            bom.setNo(bomNo);
            bom.setMetaData(metaData);

            modelMap.put(Bom.KEY, this.bomInfoSer.getBOMDetail(bom));
            modelMap.put("paramMap", ObjectBindUtil.getRequestParams(request));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/bom/bomManage/updateBOM", modelMap);
    }

    @RequestMapping(value = "/removeBOM", method = RequestMethod.GET)
    public ModelAndView removeBOM(HttpServletRequest request, ModelMap modelMap, @RequestParam("bomNo") Long bomNo) {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParams(request));
        return new ModelAndView("/bom/bomManage/removeBOM");
    }

    @RequestMapping(value = "/transferBOM", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferBOM(HttpServletRequest request, @RequestParam("jsonData") String jsonData) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            Bom bom = ObjectBindUtil.parseRequestJsonDataToObject(jsonData, Bom.class);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            bom.setMetaData(metaData);

            if (bom.getNo() == null || bom.getNo() == 0L) {
                String bomNo = this.bomManageSer.addBOM(bom);
                result.setMessage(bomNo);
            } else {
                this.bomManageSer.updateBOM(bom);
            }
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/removeBOM", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> removeBOM(HttpServletRequest request, @RequestParam("bomNo") Long bomNo) throws Exception {
        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Bom bom = new Bom();
            bom.setNo(bomNo);
            bom.setMetaData(metaData);

            this.bomManageSer.removeBOM(bom);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/transferBOMItems", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferBOMItems(HttpServletRequest request, @RequestParam("bomNo") Long bomNo, @RequestParam("jsonData") String jsonData,
                                                  @RequestParam(value = "changeNo", required = false) Long changeNo) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            List<BomItem> bomItems = ObjectBindUtil.parseRequestJsonDataToListWithJacason(jsonData, BomItem[].class);
            Bom bom = new Bom();
            bom.setNo(bomNo);
            bom.setMetaData(metaData);

            EngineerChange ecn = new EngineerChange();
            ecn.setNo(changeNo);

            this.bomManageSer.transferBOMItems(bomItems, bom, ecn);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

}
