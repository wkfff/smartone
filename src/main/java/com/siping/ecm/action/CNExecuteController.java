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
import com.siping.ecm.bean.EngineerChange;
import com.siping.ecm.service.CNExecuteSer;
import com.siping.ecm.service.CNInfoSer;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/ecm/cnExecute")
public class CNExecuteController {
    Logger logger = Logger.getLogger(CNExecuteController.class);

    @Autowired
    private CNExecuteSer cnExecuteSer;

    @Autowired
    private CNInfoSer cnInfoSer;

    @RequestMapping(value = "/handleChangeNo", method = RequestMethod.GET)
    public ModelAndView updateChangeNo(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/ecm/cnExecute/handleChangeNo", modelMap);
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
        return new ModelAndView("/ecm/cnExecute/viewChangeNoDetail", modelMap);
    }

    @RequestMapping(value = "/updateECMObject")
    @ResponseBody
    public String updateECMObject(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return this.cnExecuteSer.updateECMObject(request);
    }

}
