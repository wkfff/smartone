package com.siping.pa.action.salary;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.pa.service.salary.PaProgressSer;

@Controller
@RequestMapping(value = "/pa/salary")
public class PaProgressCtroller {
    Logger logger = Logger.getLogger(PaProgressCtroller.class);

    @Autowired
    private PaProgressSer paProgressSer;

    @RequestMapping(value = "/viewPaProgress", method = RequestMethod.GET)
    public ModelAndView viewPaProgress(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/pa/salary/viewPaProgress", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPaProgressInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getPaProgressInfo(HttpServletRequest request) throws Exception {

        List infoList = this.paProgressSer.getPaProgressInfo(request);

        Map model = new HashMap();
        model.put("Rows", infoList);

        return model;
    }

    @RequestMapping(value = "/updatePaProgressInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updatePaProgressInfo(HttpServletRequest request) throws Exception {

        this.paProgressSer.updatePaProgressInfo(request);

        return "Y";
    }

    @RequestMapping(value = "/getPaProgressPaLockFlag", method = RequestMethod.POST)
    @ResponseBody
    public String getPaProgressPaLockFlag(HttpServletRequest request) throws Exception {

        return String.valueOf(this.paProgressSer.getPaProgressPaLockFlag(request));
    }

    @RequestMapping(value = "/getPaProgressLockFlag", method = RequestMethod.POST)
    @ResponseBody
    public String getPaProgressLockFlag(HttpServletRequest request) throws Exception {

        return String.valueOf(this.paProgressSer.getPaProgressLockFlag(request));
    }
}
