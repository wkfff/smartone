package com.siping.web.utility.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.system.service.SystemSer;

@Controller
@RequestMapping(value = "/utility/toolInfo")
public class UtilityToolInfoCtroller {
    Logger logger = Logger.getLogger(UtilityToolInfoCtroller.class);
    @Autowired
    private SystemSer systemSer;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getToolInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getToolInfoList(HttpServletRequest request) throws Exception {
    	List toolList = this.systemSer.getAssetID(request);
    	int toolListCnt = this.systemSer.getAssetInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", toolList);
        model.put("Total", toolListCnt);
        return model;
    }

    @RequestMapping(value = "/searchTool", method = RequestMethod.GET)
    public ModelAndView searchTool(HttpServletRequest request) throws Exception {
        return new ModelAndView("/web/utility/toolInfo/searchTool");
    }
}
