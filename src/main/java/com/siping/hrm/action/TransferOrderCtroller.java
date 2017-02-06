package com.siping.hrm.action;

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

import com.siping.hrm.service.TransferOrderSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;

// 调动
@Controller
@RequestMapping(value = "/hrm/transferOrder")
public class TransferOrderCtroller {

    Logger logger = Logger.getLogger(TransferOrderCtroller.class);

    @Autowired
    private TransferOrderSer transferOrderSer;

    private static String HIRE_TRANS_CODE = "TransCode_100";
    private static String UPGRADE_TRANS_CODE = "TransCode_110";
    private static String PLURALITY_TRANS_CODE = "TransCode_150";
    private static String DISPATCH_TRANS_CODE = "TransCode_160";
    private static String REWARD_TRANS_CODE = "TransCode_180";
    private static String PUN_TRANS_CODE = "TransCode_190";
    private static String RESIGN_TRANS_CODE = "TransCode_200";
    private static String REJOIN_TRANS_CODE = "TransCode_210";

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/{transferOrderType}")
    public void getTransferOrder() {
    }

    @RequestMapping(value = "/viewHire", method = RequestMethod.GET)
    public ModelAndView viewHire(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
        modelMap.put("TRANS_CODE", HIRE_TRANS_CODE);
//        modelMap.put("EMPID", this.transferOrderSer.getNewestEmpIDInfo(request));
        return new ModelAndView("/hrm/transferOrder/viewHire", modelMap);
    }

    @RequestMapping(value = "/viewUpgrade", method = RequestMethod.GET)
    public ModelAndView viewUpgrade(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_CODE", UPGRADE_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewUpgrade", modelMap);
    }

    @RequestMapping(value = "/viewTransferNormal", method = RequestMethod.GET)
    public ModelAndView viewTransferNormal(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewTransferNormal", modelMap);
    }

    @RequestMapping(value = "/viewTransferPosition", method = RequestMethod.GET)
    public ModelAndView viewTransferPosition(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewTransferPosition", modelMap);
    }

    @RequestMapping(value = "/viewTransferPromote", method = RequestMethod.GET)
    public ModelAndView viewTransferPromote(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewTransferPromote", modelMap);
    }

    @RequestMapping(value = "/viewActBusiness", method = RequestMethod.GET)
    public ModelAndView viewActBusiness(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewActBusiness", modelMap);
    }

    @RequestMapping(value = "/viewPlurality", method = RequestMethod.GET)
    public ModelAndView viewPlurality(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_CODE", PLURALITY_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewPlurality", modelMap);
    }

    @RequestMapping(value = "/viewDispatch", method = RequestMethod.GET)
    public ModelAndView viewDispatch(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_CODE", DISPATCH_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewDispatch", modelMap);
    }

    @RequestMapping(value = "/viewSuspension", method = RequestMethod.GET)
    public ModelAndView viewSuspension(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewSuspension", modelMap);
    }

    @RequestMapping(value = "/viewReward", method = RequestMethod.GET)
    public ModelAndView viewReward(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_CODE", REWARD_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewReward", modelMap);
    }

    @RequestMapping(value = "/viewPunishment", method = RequestMethod.GET)
    public ModelAndView viewPunishMent(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_CODE", PUN_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewPunishment", modelMap);
    }

    @RequestMapping(value = "/viewResign", method = RequestMethod.GET)
    public ModelAndView viewResign(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_CODE", RESIGN_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewResign", modelMap);
    }

    @RequestMapping(value = "/viewJoinAgain", method = RequestMethod.GET)
    public ModelAndView viewJoinAgain(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("TRANS_CODE", REJOIN_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));

        return new ModelAndView("/hrm/transferOrder/viewJoinAgain", modelMap);
    }

    /**
     * 获取列表
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getEmpInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getEmpInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.transferOrderSer.getEmpInfoList(request);
        int empInfoCnt = this.transferOrderSer.getEmpInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 获取列表
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getEmpActBusinessInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getEmpActBusinessInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.transferOrderSer.getEmpActBusinessInfoList(request);
        int empInfoCnt = this.transferOrderSer.getEmpActBusinessInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 提交发令
     */
    @RequestMapping(value = "/saveTransferOrder", method = RequestMethod.POST)
    @ResponseBody
    public String saveTransferOrder(HttpServletRequest request) {
        String returnString = "Y";
        try {
            returnString = this.transferOrderSer.saveTransferOrder(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }

    /**
     * 检查工号可用性
     */
    @RequestMapping(value = "/checkEmpID", method = RequestMethod.POST)
    @ResponseBody
    public String checkEmpID(HttpServletRequest request) {
        String returnString = "Y";
        try {
            returnString = this.transferOrderSer.checkEmpID(request);
        } catch (Exception e) {
            returnString = Messages.getMessage(request, "hrms.unknownError");
        }
        return returnString;
    }

    /**
     * 将每个月的职员调令信息以Excel导出
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/getTransferOrderByExcel", method = RequestMethod.GET)
    public void getTransferOrderByExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.transferOrderSer.getTransferOrderByExcel(request, response);
    }

    /**
     * 将每个月的职员奖励信息以Excel导出
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/getRewardInfoByExcel", method = RequestMethod.GET)
    public void getRewardInfoByExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.transferOrderSer.getRewardInfoByExcel(request, response);
    }

    /**
     * 将每个月的职员惩戒信息以Excel导出
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/getPunishmentInfoByExcel", method = RequestMethod.GET)
    public void getPunishmentInfoByExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.transferOrderSer.getPunishmentInfoByExcel(request, response);
    }

    /**
     * 将每个月的职员离职信息以Excel导出
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/getResignInfoByExcel", method = RequestMethod.GET)
    public void getResignInfoByExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.transferOrderSer.getResignInfoByExcel(request, response);
    }
}
