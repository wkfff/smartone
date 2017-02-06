package com.siping.hrm.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siping.hrm.service.HrmSer;

@Controller
@RequestMapping(value = "/hrm")
public class HrmCtroller {
    Logger logger = Logger.getLogger(HrmCtroller.class);
    @Autowired
    private HrmSer hrmSer;

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getDeptTree/{limit}")
    @ResponseBody
    public List getEmpList(HttpServletRequest request, @PathVariable("limit") String limit) throws Exception {
        List info = hrmSer.getDeptTree(request, limit);
        return info;
    }

}
