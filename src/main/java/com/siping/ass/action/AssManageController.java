package com.siping.ass.action;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.ass.service.AssManageSer;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/ass/assManage")
public class AssManageController {

    @Autowired
    private AssManageSer assManageSer;
    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;

    @RequestMapping(value = "/addAsset", method = RequestMethod.GET)
    public ModelAndView addAsset(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("type", "add");
        return new ModelAndView("/ass/assManage/addAsset", modelMap);
    }

    @RequestMapping(value = "/updateAsset", method = RequestMethod.GET)
    public ModelAndView updateAsset(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("assetDetail", this.assManageSer.getAssetDetail(request));
        modelMap.put("type", "update");
        return new ModelAndView("/ass/assManage/transferAsset", modelMap);
    }

    @RequestMapping(value = "/transferAsset", method = RequestMethod.POST)
    @ResponseBody
    public String transferAsset(HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        try {
            this.assManageSer.transferAsset(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @RequestMapping(value = "/checkAssetID")
    @ResponseBody
    public String checkAssetID(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.assManageSer.checkAssetID(request);
    }

    @RequestMapping(value = "/checkAssetName")
    @ResponseBody
    public String checkAssetName(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.assManageSer.checkAssetName(request);
    }

    @RequestMapping(value = "/addCategory", method = RequestMethod.GET)
    public ModelAndView addCategory(HttpServletRequest request) {
        return new ModelAndView("/ass/assManage/addCategory");
    }

    @RequestMapping(value = "/addCategory")
    @ResponseBody
    public String addCategory(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.assManageSer.addCategory(request);
    }

    @RequestMapping(value = "/removeAsset", method = RequestMethod.GET)
    public ModelAndView removeAsset(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("assetDetail", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/ass/assManage/removeAsset");
    }

    @RequestMapping(value = "/removeAsset")
    @ResponseBody
    public String removeAsset(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.assManageSer.removeAsset(request);
    }

    @RequestMapping(value = "checkCategoryName")
    @ResponseBody
    public String checkCategoryName(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.assManageSer.checkCategoryName(request);
    }

    @RequestMapping(value = "/borrowListAsset")
    public ModelAndView borrowListAsset(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("assetDetail", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/ass/assManage/borrowListAsset", modelMap);
    }

    /**
     * 资产借用
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/borrowAsset", method = RequestMethod.GET)
    public ModelAndView borrowAsset(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        return new ModelAndView("/ass/assManage/borrowAsset", modelMap);
    }
}
