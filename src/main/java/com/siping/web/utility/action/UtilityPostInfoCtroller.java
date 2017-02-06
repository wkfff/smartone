package com.siping.web.utility.action;

import java.util.HashMap;
import java.util.LinkedHashMap;
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

import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.service.UtilityPostInfoSer;

@Controller
@RequestMapping(value = "/utility/postInfo")
public class UtilityPostInfoCtroller {
    Logger logger = Logger.getLogger(UtilityPostInfoCtroller.class);
    @Autowired
    private UtilityPostInfoSer UtilityPostInfoSer;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getPostInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPostInfoList(HttpServletRequest request) throws Exception {
        List hrPostList = this.UtilityPostInfoSer.getPostInfoList(request);
        int hrPostCnt = this.UtilityPostInfoSer.getPostInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", hrPostList);
        model.put("Total", hrPostCnt);
        return model;
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/searchPost", method = RequestMethod.GET)
    public ModelAndView searchPost(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        modelMap.put("kpiItem", paramMap);
        return new ModelAndView("/web/utility/postInfo/searchPost", modelMap);
    }
}
