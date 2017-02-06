package com.siping.ecm.action;

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

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.MetaData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.ecm.service.CNInfoSer;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.PagerResult;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/ecm/cnInfo")
public class CNInfoController {
    Logger logger = Logger.getLogger(CNInfoController.class);
    @Autowired
    private CNInfoSer cnInfoSer;

    @RequestMapping(value = "/viewChangeNoList", method = RequestMethod.GET)
    public ModelAndView viewChangeNoList(HttpServletRequest request) {
        return new ModelAndView("/ecm/cnInfo/viewChangeNoList");
    }

    @RequestMapping(value = "/viewChangeNoDetail", method = RequestMethod.GET)
    public ModelAndView viewChangeNoDetail(HttpServletRequest request, ModelMap modelMap, @RequestParam("changeNo") Long changeNo) {
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            EngineerChange ecn = new EngineerChange();
            ecn.setNo(changeNo);
            ecn.setMetaData(metaData);

            modelMap.put(EngineerChange.KEY, this.cnInfoSer.getChangeNoDetail(ecn));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new ModelAndView("/ecm/cnInfo/viewChangeNoDetail", modelMap);
    }

    @RequestMapping(value = "/getChangeNoList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<EngineerChange> getChangeNoList(HttpServletRequest request, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) Integer page,
        @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) Integer pagesize) {
        PagerResult<EngineerChange> result = new PagerResult<EngineerChange>();
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Map<String, Object> params = ObjectBindUtil.getRequestParams(request);
            params.put(MetaData.KEY, metaData);

            result.setRows(this.cnInfoSer.getChangeNoList(params, pagerRequest));
            result.setTotal(this.cnInfoSer.getChangeNoListCnt(params));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/getObjectList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<BusinessData> getObjectList(HttpServletRequest request, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                                   @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize, @RequestParam("changeNo") Long changeNo) {
        PagerResult<BusinessData> result = new PagerResult<BusinessData>();
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        try {
            Map<String, Object> params = ObjectBindUtil.getRequestParams(request);

            result.setRows(this.cnInfoSer.getObjectList(params, pagerRequest));
            result.setTotal(this.cnInfoSer.getObjectListCnt(params));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        return result;
    }
}
