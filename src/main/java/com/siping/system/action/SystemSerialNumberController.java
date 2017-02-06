package com.siping.system.action;

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

import com.siping.system.service.SystemSerialNumberSer;

@Controller
@RequestMapping(value = "/system/serialNumber")
public class SystemSerialNumberController {
    Logger logger = Logger.getLogger(SystemSerialNumberController.class);
    @Autowired
    private SystemSerialNumberSer systemSerialNumberSer;

    /**
     * 跳转到流水号生成页面
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewSerialNumber", method = RequestMethod.GET)
    public ModelAndView viewSerialNumber(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/system/serialNumber/viewSerialNumber", modelMap);
    }

    /**
     * 从sy_serial_num_all中获取所有编号值规则
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getAllSerialNum", method = RequestMethod.POST)
    @ResponseBody
    public Map getAllSerialNum(HttpServletRequest request) {
        List allSerialNumList = this.systemSerialNumberSer.getAllSerialNum(request);
        int allSerialNumCnt = this.systemSerialNumberSer.getAllSerialNumCnt(request);

        Map model = new HashMap();
        model.put("Rows", allSerialNumList);
        model.put("Total", allSerialNumCnt);

        return model;
    }

    /**
     * 添加编号值规则记录到sy_serial_num_all中
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addSerialNum", method = RequestMethod.POST)
    @ResponseBody
    public String addSerialNum(HttpServletRequest request) {
        return this.systemSerialNumberSer.addSerialNum(request);
    }

    /**
     * 从sy_serial_num_all中删除编号值规则信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteSerialNum", method = RequestMethod.POST)
    @ResponseBody
    public String deleteSerialNum(HttpServletRequest request) throws Exception {
        return this.systemSerialNumberSer.deleteSerialNum(request);
    }

    /**
     * 修改serial_num并存入sy_serial_num_all中
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateSerialNum", method = RequestMethod.POST)
    @ResponseBody
    public String updateSerialNum(HttpServletRequest request) throws Exception {
        return this.systemSerialNumberSer.updateSerialNum(request);
    }
}
