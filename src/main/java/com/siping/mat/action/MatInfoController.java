package com.siping.mat.action;

import java.util.HashMap;

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
import com.siping.mat.bean.Material;
import com.siping.mat.service.MatInfoSer;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.PagerResult;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/mat/matInfo")
public class MatInfoController {
    Logger logger = Logger.getLogger(MatInfoController.class);

    @Autowired
    private MatInfoSer matInfoSer;

    @RequestMapping(value = "/viewMaterialDetail", method = RequestMethod.GET)
    public ModelAndView viewMaterialDetail(HttpServletRequest request, ModelMap modelMap, @RequestParam("matNo") Long matNo) {
        Material material = new Material();
        material.setNo(matNo);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            material.setMetaData(metaData);
            modelMap.put("materialDetail", this.matInfoSer.getMaterialDetail(material));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/mat/matInfo/viewMaterialDetail", modelMap);
    }

    @RequestMapping(value = "/viewMaterialList", method = RequestMethod.GET)
    public ModelAndView viewMaterialList(HttpServletRequest request) {
        return new ModelAndView("/mat/matInfo/viewMaterialList");
    }

    @RequestMapping(value = "/getMaterialList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<Material> getMaterialList(HttpServletRequest request, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                                 @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize) {
        PagerResult<Material> result = new PagerResult<Material>();
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        HashMap<String, Object> params = ObjectBindUtil.getRequestParams(request);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);
            result.setRows(this.matInfoSer.getMaterialList(params, pagerRequest));
            result.setTotal(this.matInfoSer.getMaterialListCnt(params));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return result;
    }
}
