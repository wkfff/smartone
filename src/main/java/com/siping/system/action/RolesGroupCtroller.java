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

import com.siping.system.service.RolesGroupSer;

@Controller
@RequestMapping(value = "/system/rightsManagement")
public class RolesGroupCtroller {
    Logger logger = Logger.getLogger(RolesGroupCtroller.class);

    @Autowired
    private RolesGroupSer rolesGroupSer;

    @RequestMapping(value = "/viewRolesGroup", method = RequestMethod.GET)
    public ModelAndView viewRolesGroup(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/system/rightsManagement/viewRolesGroup", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getRolesGroupList", method = RequestMethod.POST)
    @ResponseBody
    public Map getRolesGroupList(HttpServletRequest request) throws Exception {
        List rolesGroupList = this.rolesGroupSer.getRolesGroupInfo(request);
        int rolesGroupCnt = this.rolesGroupSer.getRolesGroupInfoCnt(request);
        Map model = new HashMap();
        model.put("rolesGroupList", rolesGroupList);
        model.put("rolesGroupCnt", rolesGroupCnt);
        return model;
    }

    @RequestMapping(value = "/deleteRolesGroup", method = RequestMethod.POST)
    @ResponseBody
    public String deleteRolesGroup(HttpServletRequest request) throws Exception {
        this.rolesGroupSer.deleteRolesGroupInfo(request);
        return "Y";
    }

    @RequestMapping(value = "/addRolesGroupInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addRolesGroupInfo(HttpServletRequest request) throws Exception {
        this.rolesGroupSer.addRolesGroupInfo(request);
        return "Y";
    }

    @RequestMapping(value = "/addRolesGroupView", method = RequestMethod.GET)
    public ModelAndView addRolesGroupView(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("menuSelectList", this.rolesGroupSer.getMenuSelectList(request));
        modelMap.put("SCREEN_GRANT_ID", this.rolesGroupSer.getRolesGroupID(request));
        return new ModelAndView("/system/rightsManagement/addRolesGroupView", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getSystemMenuInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getSystemMenuInfo(HttpServletRequest request) throws Exception {
        List systemMenuList = this.rolesGroupSer.getSystemMenuInfo(request);
        int systemMenuCnt = this.rolesGroupSer.getSystemMenuInfoCnt(request);
        Map model = new HashMap();
        model.put("systemMenuList", systemMenuList);
        model.put("systemMenuCnt", systemMenuCnt);
        return model;
    }

    @RequestMapping(value = "/updateRolesGroupView", method = RequestMethod.GET)
    public ModelAndView updateRolesGroupView(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("rolesGroupInfo", this.rolesGroupSer.getRolesGroupInfoObj(request));
        modelMap.put("menuSelectList", this.rolesGroupSer.getMenuSelectList(request));
        return new ModelAndView("/system/rightsManagement/updateRolesGroupView", modelMap);
    }

    @RequestMapping(value = "/updateRolesGroupInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateRolesGroupInfo(HttpServletRequest request) throws Exception {
        this.rolesGroupSer.updateRolesGroupInfo(request);
        return "Y";
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getRolesGroupPageInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getRolesGroupPageInfo(HttpServletRequest request) throws Exception {
        List rolesGroupPageList = this.rolesGroupSer.getRolesGroupPageInfo(request);
        int rolesGroupPageCnt = this.rolesGroupSer.getRolesGroupPageInfoCnt(request);
        Map model = new HashMap();
        model.put("rolesGroupPageList", rolesGroupPageList);
        model.put("rolesGroupPageCnt", rolesGroupPageCnt);
        return model;
    }
}
