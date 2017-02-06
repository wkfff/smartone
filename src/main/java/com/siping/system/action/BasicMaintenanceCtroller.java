package com.siping.system.action;

import java.sql.SQLException;
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

import com.siping.system.bean.AdminBean;
import com.siping.system.service.BasicMaintenanceSer;
import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/system/basicMaintenance")
public class BasicMaintenanceCtroller {
    Logger logger = Logger.getLogger(BasicMaintenanceCtroller.class);
    @Autowired
    private BasicMaintenanceSer basicMaintenanceSer;
    @Autowired
    private SystemSer systemSer;

    /**
     * 获取公司信息
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewCompanyManage", method = RequestMethod.GET)
    public ModelAndView viewCompanyManage(HttpServletRequest request,
                                          HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/system/basicMaintenance/viewCompanyManage", modelMap);
    }

    /**
     * 获取公司信息
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping(value = "/getCompanyInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getCompanyInfo(HttpServletRequest request) throws Exception {

        List companyInfoList = this.basicMaintenanceSer.getCompanyInfo(request);

        Map model = new HashMap();
        model.put("companyInfoList", companyInfoList);
        model.put("companyInfoListCnt", companyInfoList.size());

        return model;
    }

    /**
     * 更新公司信息
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateCompanyInfo", method = RequestMethod.GET)
    public ModelAndView updateCompanyInfoView(HttpServletRequest request,
                                              HttpServletResponse response, ModelMap modelMap) throws Exception {

        Object companyInfo = this.basicMaintenanceSer.getCompanyInfoObj(request);

        modelMap.put("companyInfo", companyInfo);

        return new ModelAndView("/system/basicMaintenance/updateCompanyInfo", modelMap);
    }

    /**
     * 添加公司信息
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addCompanyInfo", method = RequestMethod.GET)
    public ModelAndView addCompanyInfoView(HttpServletRequest request,
                                           HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/system/basicMaintenance/addCompanyInfo", modelMap);
    }

    /**
     * 更新公司信息
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateCompanyInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateCompanyInfo(HttpServletRequest request) throws Exception {

        this.basicMaintenanceSer.updateCompanyInfo(request);

        return "Y";
    }

    /**
     * 删除公司信息
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteCompanyInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCompanyInfo(HttpServletRequest request) throws Exception {

        this.basicMaintenanceSer.deleteCompanyInfo(request);

        return "Y";
    }

    @RequestMapping(value = "/addCompanyInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addCompanyInfo(HttpServletRequest request) throws Exception {

        String returnString = "Y";

        int errorInt = this.basicMaintenanceSer.checkCompanyInfo(request);
        if (errorInt == 0) {
            this.basicMaintenanceSer.addCompanyInfo(request);
        } else {
            returnString = "N";
        }

        return returnString;
    }

    /**
     * 父级CODE查询
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewCodeManage", method = RequestMethod.GET)
    public ModelAndView getParentCodeList(HttpServletRequest request,
                                          HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("parentCodeList", this.basicMaintenanceSer.getParentCodeList(request));

        return new ModelAndView("/system/basicMaintenance/viewCodeManage", modelMap);
    }

    /**
     * 根据父级CODE查询子CODE
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getCodeListByParentCode", method = RequestMethod.POST)
    @ResponseBody
    public List getCodeListByParentCode(HttpServletRequest request) throws Exception {

        List codeList = this.basicMaintenanceSer.getCodeListByParentCode(request);

        return codeList;
    }

    /**
     * CODE维护
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveAndUpdateCodeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveAndUpdateCodeInfo(HttpServletRequest request) throws Exception {

        try {
            this.basicMaintenanceSer.addCodeInfo(request);
            this.basicMaintenanceSer.updateCodeInfo(request);
        } catch (SQLException e) {
            e.printStackTrace();
            return e.getMessage();
        }

        return "Y";
    }

    /**
     * 删除CODE信息
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteCodeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCodeInfo(HttpServletRequest request) throws Exception {
        try {
            this.basicMaintenanceSer.deleteCodeInfo(request);
        } catch (SQLException e) {
            e.printStackTrace();
            return e.getMessage();
        }
        return "Y";
    }

    /**
     * 父级菜单查询
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewMenuManage", method = RequestMethod.GET)
    public ModelAndView getParentMenuList(HttpServletRequest request,
                                          HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("parentMenuList", this.basicMaintenanceSer.getParentMenuList(request));

        return new ModelAndView("/system/basicMaintenance/viewMenuManage", modelMap);
    }

    /**
     * 根据父级菜单查询子菜单
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getMenuListByParentMenuCode", method = RequestMethod.POST)
    @ResponseBody
    public List getMenuListByParentMenuCode(HttpServletRequest request) throws Exception {

        List menuList = this.basicMaintenanceSer.getMenuListByParentMenuCode(request);

        return menuList;
    }

    @RequestMapping(value = "/getMenuInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getMenuInfo(HttpServletRequest request) throws Exception {

        String menuInfo = this.basicMaintenanceSer.getMenuInfo(request);

        return menuInfo;
    }

    /**
     * 菜单维护
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveAndUpdateMenuInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveAndUpdateMenuInfo(HttpServletRequest request) throws Exception {

        this.basicMaintenanceSer.addMenuInfo(request);

        this.basicMaintenanceSer.updateMenuInfo(request);

        return "Y";
    }

    /**
     * 菜单维护
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteMenuInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteMenuInfo(HttpServletRequest request) throws Exception {

        this.basicMaintenanceSer.deleteMenuInfo(request);

        return "Y";
    }

    /**
     * 部门查询
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewDeptManage", method = RequestMethod.GET)
    public ModelAndView viewDeptManage(HttpServletRequest request,
                                       HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/system/basicMaintenance/viewDeptManage", modelMap);
    }

    /**
     * 获取部门信息
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping(value = "/getDeptInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDeptInfoList(HttpServletRequest request) throws Exception {

        Map model = new HashMap();
        List deptInfoList = this.basicMaintenanceSer.getDeptInfoList(request);

        model.put("deptInfoList", deptInfoList);
        model.put("deptInfoListCnt", deptInfoList.size());

        return model;
    }

    /**
     * 根据父级部门查询子部门
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getDeptListByParentCode", method = RequestMethod.POST)
    @ResponseBody
    public List getDeptListByParentCode(HttpServletRequest request) throws Exception {

        List deptList = this.basicMaintenanceSer.getDeptListByParentCode(request);

        return deptList;
    }

    /**
     * 获取下拉菜单
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    public List getDeptLevelList(HttpServletRequest request) throws Exception {

        List listMap = this.basicMaintenanceSer.getDeptLevelList(request);

        return listMap;
    }

    /**
     * 获取下拉菜单
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getActivitySelectMap", method = RequestMethod.POST)
    @ResponseBody
    public Map getActivitySelectMap(HttpServletRequest request) throws Exception {

        Map listMap = this.basicMaintenanceSer.getActivitySelectMap(request);

        return listMap;
    }

    /**
     * 获取下拉菜单
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    public Map getCompanySelectMap(HttpServletRequest request) throws Exception {

        Map listMap = this.basicMaintenanceSer.getCompanySelectMap(request);

        return listMap;
    }

    /**
     * 是否列表
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getSysCodeSelectMap", method = RequestMethod.POST)
    @ResponseBody
    public Map getSysCodeSelectMap(HttpServletRequest request) throws Exception {

        Map listMap = this.basicMaintenanceSer.getSysCodeSelectMap(request);

        return listMap;
    }

    /**
     * 是否列表
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getSysCodeSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getSysCodeSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.basicMaintenanceSer.getSysCodeSelectList(request);

        return listMap;
    }

    @RequestMapping(value = "/viewAnnouncementManage", method = RequestMethod.GET)
    public ModelAndView viewAnnouncementList(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        return new ModelAndView("/system/basicMaintenance/viewAnnouncementManage", modelMap);
    }

    /* **********************************************************************/
    /* The following functions return the data(stored in Map) */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getAnnouncementList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAnnouncementList(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("Rows", this.basicMaintenanceSer.getAnnouncementList(request));
        modelMap.put("Total", this.basicMaintenanceSer.getAnnouncementListCnt(request));
        return modelMap;
    }

    @RequestMapping(value = "/transferAnnouncement", method = RequestMethod.POST)
    @ResponseBody
    public String transferAnnouncement(HttpServletRequest request, ModelMap modelMap) {
        String resultString = "Y";
        try {
            this.basicMaintenanceSer.transferAnnouncement(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @RequestMapping(value = "/removeAnnouncement")
    @ResponseBody
    public String removeAnnouncement(HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        try {
            resultString = this.basicMaintenanceSer.removeAnnouncement(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    /**
     * 分类管理
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewTypeManage", method = RequestMethod.GET)
    public ModelAndView viewTypeManage(HttpServletRequest request,
                                       HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/system/basicMaintenance/viewTypeManage", modelMap);
    }

    /**
     * 查询分类
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getCategoryList", method = RequestMethod.POST)
    @ResponseBody
    public Map getCategoryList(HttpServletRequest request) throws Exception {

        List<LinkedHashMap> categoryList = this.basicMaintenanceSer.getCategoryList(request);
        int categoryListCnt = this.basicMaintenanceSer.getCategoryListCnt(request);

        Map model = new HashMap();
        model.put("Rows", categoryList);
        model.put("Total", categoryListCnt);

        return model;
    }

    /**
     * 查询类别属性
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getPropertyList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPropertyList(HttpServletRequest request) throws Exception {

        List<LinkedHashMap> propertyList = this.basicMaintenanceSer.getPropertyList(request);
        int propertyListCnt = this.basicMaintenanceSer.getCategoryListCnt(request);

        Map model = new HashMap();
        model.put("Rows", propertyList);
        model.put("Total", propertyListCnt);

        return model;
    }

    /**
     * 查询类别属性值
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getPropertyValueList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPropertyValueList(HttpServletRequest request) throws Exception {

        List<LinkedHashMap> propertyList = this.basicMaintenanceSer.getPropertyValueList(request);
        int propertyListCnt = this.basicMaintenanceSer.getPropertyValueListCnt(request);

        Map model = new HashMap();
        model.put("Rows", propertyList);
        model.put("Total", propertyListCnt);

        return model;
    }

    /**
     * 更新分类信息
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/updateCategoryInfo", method = RequestMethod.GET)
    public ModelAndView updateCategoryInfo(HttpServletRequest request,
                                           HttpServletResponse response, ModelMap modelMap) throws Exception {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        modelMap.put("category", paramMap);
        return new ModelAndView("/system/basicMaintenance/updateCategoryInfo", modelMap);
    }

    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/updatePropertyInfo", method = RequestMethod.GET)
    public ModelAndView updatePropertyInfo(HttpServletRequest request,
                                           HttpServletResponse response, ModelMap modelMap) throws Exception {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        modelMap.put("property", paramMap);
        return new ModelAndView("/system/basicMaintenance/updatePropertyInfo", modelMap);
    }

    @RequestMapping(value = "/addPropertyToCategory", method = RequestMethod.POST)
    @ResponseBody
    public String addPropertyToCategory(HttpServletRequest request) {
        String resultString = "Y";
        resultString = this.basicMaintenanceSer.addPropertyToCategory(request);
        return resultString;
    }

    @RequestMapping(value = "/deletePropertyFromCategory", method = RequestMethod.POST)
    @ResponseBody
    public String deletePropertyFromCategory(HttpServletRequest request) {
        String resultString = "Y";
        resultString = this.basicMaintenanceSer.deletePropertyFromCategory(request);
        return resultString;
    }

    @RequestMapping(value = "/addValueToProperty", method = RequestMethod.POST)
    @ResponseBody
    public String addValueToProperty(HttpServletRequest request) {
        String resultString = "Y";
        resultString = this.basicMaintenanceSer.addValueToProperty(request);
        return resultString;
    }

    @RequestMapping(value = "/deleteValueFromProperty", method = RequestMethod.POST)
    @ResponseBody
    public String deleteValueFromProperty(HttpServletRequest request) {
        String resultString = "Y";
        resultString = this.basicMaintenanceSer.deleteValueFromProperty(request);
        return resultString;
    }

    @RequestMapping(value = "/updateCategory", method = RequestMethod.POST)
    @ResponseBody
    public String updateCategory(HttpServletRequest request) {
        String returnString = "Y";
        returnString = this.basicMaintenanceSer.updateCategory(request);
        return returnString;
    }

    @RequestMapping(value = "/updateProperty", method = RequestMethod.POST)
    @ResponseBody
    public String updateProperty(HttpServletRequest request) {
        String returnString = "Y";
        returnString = this.basicMaintenanceSer.updateProperty(request);
        return returnString;
    }

    @RequestMapping(value = "/updatePropertyValue", method = RequestMethod.POST)
    @ResponseBody
    public String updatePropertyValue(HttpServletRequest request) {
        String returnString = "Y";
        returnString = this.basicMaintenanceSer.updatePropertyValue(request);
        return returnString;
    }

    @RequestMapping(value = "/deleteCategoryInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCategoryInfo(HttpServletRequest request) {
        String returnString = "Y";

        int temp = this.basicMaintenanceSer.checkCategoryDelete(request);
        if (temp > 0) {
            returnString = "该类别已分配给货品，不能删除";
        } else {
            returnString = this.basicMaintenanceSer.deleteCategoryInfo(request);
        }
        return returnString;
    }

    @RequestMapping(value = "/deletePropertyInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePropertyInfo(HttpServletRequest request) {
        String returnString = "Y";
        returnString = this.basicMaintenanceSer.deletePropertyInfo(request);
        return returnString;
    }

    @RequestMapping(value = "/deletePropertyValueInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePropertyValueInfo(HttpServletRequest request) {
        String returnString = "Y";
        returnString = this.basicMaintenanceSer.deletePropertyValueInfo(request);
        return returnString;
    }

    @RequestMapping(value = "/viewAddCategoryInfo", method = RequestMethod.GET)
    public ModelAndView viewAddCategoryInfo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/system/basicMaintenance/viewAddCategoryInfo", modelMap);
    }

    @RequestMapping(value = "/viewAddPropertyInfo", method = RequestMethod.GET)
    public ModelAndView viewAddPropertyInfo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/system/basicMaintenance/viewAddPropertyInfo", modelMap);
    }

    @RequestMapping(value = "/viewAddPropertyValueInfo", method = RequestMethod.GET)
    public ModelAndView viewAddPropertyValueInfo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/system/basicMaintenance/viewAddPropertyValueInfo", modelMap);
    }

    /**
     * 添加类别信息
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addCategoryInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addCategoryInfo(HttpServletRequest request) throws Exception {
        String result = "Y";
        int temp = this.basicMaintenanceSer.checkCategoryId(request);
        if (temp > 0) {
            result = "该类别编号已存在";
        } else {
            result = this.basicMaintenanceSer.addCategoryInfo(request);
        }
        return result;
    }

    /**
     * 添加属性信息
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPropertyInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addPropertyInfo(HttpServletRequest request) throws Exception {
        String result = "Y";
        int temp = this.basicMaintenanceSer.checkPropertyId(request);
        if (temp > 0) {
            result = "该属性编号已存在";
        } else {
            result = this.basicMaintenanceSer.addPropertyInfo(request);
        }
        return result;
    }

    /**
     * 添加属性信息
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPropertyValueInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addPropertyValueInfo(HttpServletRequest request) throws Exception {
        String result = "Y";
        int temp = this.basicMaintenanceSer.checkPropertyValueId(request);
        if (temp > 0) {
            result = "该属性编号已存在";
        } else {
            result = this.basicMaintenanceSer.addPropertyValueInfo(request);
        }
        return result;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getPropertyValueType", method = RequestMethod.POST)
    @ResponseBody
    public List getPropertyValueType(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        List codeList = systemSer.getPropertyValueType(paramMap);
        return codeList;
    }

    /**
     * 获取库存预警
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewStorageWarnManage", method = RequestMethod.GET)
    public ModelAndView viewStorageWarnManage(HttpServletRequest request,
                                              HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/system/basicMaintenance/viewStorageWarnManage", modelMap);
    }

    /**
     * 查询预警设置
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getStorageWarnList", method = RequestMethod.POST)
    @ResponseBody
    public Map getStorageWarnList(HttpServletRequest request) throws Exception {

        List<LinkedHashMap> propertyList = this.basicMaintenanceSer.getStorageWarnList(request);
        int propertyListCnt = this.basicMaintenanceSer.getStorageWarnListCnt(request);

        Map model = new HashMap();
        model.put("Rows", propertyList);
        model.put("Total", propertyListCnt);

        return model;
    }

    /**
     * 添加预警目标
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addStorageWarnTarget", method = RequestMethod.POST)
    @ResponseBody
    public String addStorageWarnTarget(HttpServletRequest request) throws Exception {
        String result = "Y";
        int temp = this.basicMaintenanceSer.checkAddStorageWarnTarget(request);
        if (temp > 0) {
            result = "该目标已经存在";
        } else {
            result = this.basicMaintenanceSer.addStorageWarnTarget(request);
        }
        return result;
    }

    /**
     * 删除预警目标
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteStorageWarnTarget", method = RequestMethod.POST)
    @ResponseBody
    public String deleteStorageWarnTarget(HttpServletRequest request) throws Exception {
        String result = "Y";
        result = this.basicMaintenanceSer.deleteStorageWarnTarget(request);
        return result;
    }
}
