package com.siping.hrm.action;

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
import com.siping.hrm.service.TransferOrderSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/hrm/searchTransferOrder")
public class SearchTransferOrderCtroller {
    Logger logger = Logger.getLogger(SearchTransferOrderCtroller.class);

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
     * 调动
     */
    @RequestMapping(value = "/searchUpgrade", method = RequestMethod.GET)
    public ModelAndView getUpgrade(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_CODE", UPGRADE_TRANS_CODE);

        return new ModelAndView("/hrm/searchTransferOrder/searchUpgrade", modelMap);
    }

    @RequestMapping(value = "/searchHire", method = RequestMethod.GET)
    public ModelAndView searchHire(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_CODE", HIRE_TRANS_CODE);

        return new ModelAndView("/hrm/searchTransferOrder/searchHire", modelMap);
    }

    /**
     * 晋升
     */
    @RequestMapping(value = "/searchTransferPromote", method = RequestMethod.GET)
    public ModelAndView getTransferPromote(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/hrm/searchTransferOrder/searchTransferPromote", modelMap);
    }

    /**
     * 职务便更
     */
    @RequestMapping(value = "/searchTransferPosition", method = RequestMethod.GET)
    public ModelAndView getTransferPosition(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/hrm/searchTransferOrder/searchTransferPosition", modelMap);
    }

    /**
     * 转正
     */
    @RequestMapping(value = "/searchTransferNormal", method = RequestMethod.GET)
    public ModelAndView getTransferNormal(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/hrm/searchTransferOrder/searchTransferNormal", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getExpInsideInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getExpInsideInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.transferOrderSer.getExpInsideInfoList(request);
        int empInfoCnt = this.transferOrderSer.getExpInsideInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    @RequestMapping(value = "/cancelDoc", method = RequestMethod.POST)
    @ResponseBody
    public String cancelDoc(HttpServletRequest request) throws Exception {
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> list = ObjectBindUtil.getRequestJsonData(jsonString);
        String flag = this.transferOrderSer.cancelDoc(request);// 调动列表
        if (flag.equals("cancel")) {
            return "Y";
        } else {
            return "N";
        }
    }

    @RequestMapping(value = "/cancelDoc2", method = RequestMethod.POST)
    @ResponseBody
    public String cancelDoc2(HttpServletRequest request) throws Exception {
        String flag = this.transferOrderSer.cancelDoc(request);
        if (flag.equals("cancel")) {
            return "Y";
        } else {
            return "N";
        }
    }

    /**
     * 奖励
     */
    @RequestMapping(value = "/searchReward", method = RequestMethod.GET)
    public ModelAndView searchReward(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_CODE", REWARD_TRANS_CODE);

        return new ModelAndView("/hrm/searchTransferOrder/searchReward", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getRewardInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getRewardInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.transferOrderSer.getRewardInfoList(request);
        int empInfoCnt = this.transferOrderSer.getRewardInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 惩戒
     */
    @RequestMapping(value = "/searchPunishMent", method = RequestMethod.GET)
    public ModelAndView getPunishMent(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_CODE", PUN_TRANS_CODE);
        return new ModelAndView("/hrm/searchTransferOrder/searchPunishMent", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPunishmentInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPunishmentInfoList(HttpServletRequest request) throws Exception {
        List empInfoList = this.transferOrderSer.getPunishmentInfoList(request);
        int empInfoCnt = this.transferOrderSer.getPunishmentInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 兼职
     */
    @RequestMapping(value = "/searchPlurality", method = RequestMethod.GET)
    public ModelAndView getPlurality(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_CODE", PLURALITY_TRANS_CODE);

        return new ModelAndView("/hrm/searchTransferOrder/searchPlurality", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPluralityInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPluralityInfoList(HttpServletRequest request) throws Exception {
        List empInfoList = this.transferOrderSer.getPluralityInfoList(request);
        int empInfoCnt = this.transferOrderSer.getPluralityInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 派遣
     */
    @RequestMapping(value = "/searchDispatch")
    public ModelAndView getDispatch(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_CODE", DISPATCH_TRANS_CODE);

        return new ModelAndView("/hrm/searchTransferOrder/searchDispatch", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDispatchInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDispatchInfoList(HttpServletRequest request) throws Exception {
        List empInfoList = this.transferOrderSer.getDispatchInfoList(request);
        int empInfoCnt = this.transferOrderSer.getDispatchInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 离职
     */
    @RequestMapping(value = "/searchResign", method = RequestMethod.GET)
    public ModelAndView getResign(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("TRANS_CODE", RESIGN_TRANS_CODE);

        return new ModelAndView("/hrm/searchTransferOrder/searchResign", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getResignInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getResignInfoList(HttpServletRequest request) throws Exception {
        List empInfoList = this.transferOrderSer.getResignInfoList(request);
        int empInfoCnt = this.transferOrderSer.getResignInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }
}
