package com.siping.ess.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.ess.service.AffirmAppSer;

@Controller
@RequestMapping(value = "/ess/affirmApp")
public class AffirmAppCtroller {

    Logger logger = Logger.getLogger(AffirmAppCtroller.class);

    @Autowired
    private AffirmAppSer affirmAppSer;

    /**
     * 页面跳转
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/{affirmAppType}")
    public ModelAndView getPersonInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap, @PathVariable("affirmAppType") String affirmAppType) throws Exception {
        modelMap.put("toDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        return new ModelAndView("/ess/affirmApp/" + affirmAppType, modelMap);
    }

    /**
     * 加班信息申请审批
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAffirmOtInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmOtInfo(HttpServletRequest request) throws Exception {
        logger.info("getAffirmOtview.start......");
        Map temp = affirmAppSer.getAffirmOtInfo(request);// 加班信息申请审批
        return temp;
    }

    /**
     * 休假信息申请审批
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAffirmLeaveInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmLeaveInfo(HttpServletRequest request) throws Exception {
        logger.info("getAffirmLeaveview.start......");
        Map temp = affirmAppSer.getAffirmLeaveInfo(request);// 休假信息申请审批
        return temp;
    }

    /**
     * 休假信息申请审批
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAffirmCardtimeInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmCardtimeInfo(HttpServletRequest request) throws Exception {
        logger.info("getAffirmLeaveview.start......");
        Map temp = affirmAppSer.getAffirmCardtimeInfo(request);// 休假信息申请审批
        return temp;
    }

    /**
     * 费用信息申请审批
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAffirmExpInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmExpInfo(HttpServletRequest request) throws Exception {
        logger.info("getAffirmLeaveview.start......");
        Map temp = affirmAppSer.getAffirmExpInfo(request);// 休假信息申请审批
        return temp;
    }

    /**
     * 出差信息申请审批
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAffirmBTInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmBTInfo(HttpServletRequest request) throws Exception {
        logger.info("getAffirmEvectionview.start......");
        Map temp = affirmAppSer.getAffirmBTInfo(request);// 出差信息申请审批
        return temp;
    }

    /**
     * 信息审核
     * @param request
     * @return
     */
    @RequestMapping(value = "/affirmApp", method = RequestMethod.POST)
    @ResponseBody
    public String affirmApp(HttpServletRequest request) throws Exception {

        this.affirmAppSer.affirmApp(request);

        return "Y";
    }
}
