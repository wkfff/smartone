package com.siping.mat.action;

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

import com.siping.doc.bean.MetaData;
import com.siping.doc.bean.RequestResult;
import com.siping.mat.bean.IdType;
import com.siping.mat.bean.Material;
import com.siping.mat.service.MatInfoSer;
import com.siping.mat.service.MatManageSer;
import com.siping.process.service.ObjectTypeSer;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/mat/matManage")
public class MatManageController {
    Logger logger = Logger.getLogger(MatManageController.class);

    @Autowired
    private MatManageSer matManageSer;

    @Autowired
    private MatInfoSer matInfoSer;

    @Autowired
    private ObjectTypeSer objectTypeSer;

    @RequestMapping(value = "/addMaterial", method = RequestMethod.GET)
    public ModelAndView addMaterial(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/mat/matManage/addMaterial", modelMap);
    }

    @RequestMapping(value = "/updateMaterial", method = RequestMethod.GET)
    public ModelAndView updateMaterial(HttpServletRequest request, ModelMap modelMap, @RequestParam("matNo") Long matNo) {
        Material material = new Material();
        material.setNo(matNo);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            material.setMetaData(metaData);
            modelMap.put("materialDetail", this.matInfoSer.getMaterialDetail(material));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/mat/matManage/updateMaterial", modelMap);
    }

    @RequestMapping(value = "/transferMaterial", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferMaterial(HttpServletRequest request, @RequestParam("jsonData") String jsonData, @RequestParam(value = "idType", required = false) Integer idTypeNo) {
        RequestResult<String> result = new RequestResult<String>();

        try {
            Material material = ObjectBindUtil.parseRequestJsonDataToObject(jsonData, Material.class);
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            material.setMetaData(metaData);
            if (material.getNo() == null || material.getNo() == 0L) {
                IdType idType = IdType.create(idTypeNo);
                this.matManageSer.generateMatId(idType, material);
                this.matManageSer.addMaterial(material);
            } else {
                this.matManageSer.updateMaterial(material);
            }
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/removeMaterial", method = RequestMethod.GET)
    public ModelAndView removeMaterial(HttpServletRequest request, ModelMap modelMap, @RequestParam("matNo") Long matNo) {
        Material material = new Material();
        material.setNo(matNo);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            material.setMetaData(metaData);
            modelMap.put("materialDetail", this.matInfoSer.getMaterialDetail(material));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/mat/matManage/removeMaterial");
    }

    @RequestMapping(value = "/removeMaterial")
    @ResponseBody
    public RequestResult<String> removeMaterial(HttpServletRequest request, @RequestParam("matNo") Long matNo) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Material mat = new Material();
            mat.setNo(matNo);
            mat.setMetaData(metaData);
            this.matManageSer.removeMaterial(mat);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

}
