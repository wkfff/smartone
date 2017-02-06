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
import com.siping.hrm.service.PositionMgtSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/hrm/position")
public class PositionMgtCtroller {
    private static final String ERROR_OCCURRED = "Error Occurred";

    Logger logger = Logger.getLogger(PositionMgtCtroller.class);

    @Autowired
    private PositionMgtSer positionMgtSer;

    /**
     * 获取职群信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPostGroupManage", method = RequestMethod.GET)
    public ModelAndView viewPostGroupManage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/viewPostGroupManage", modelMap);
    }

    @RequestMapping(value = "/viewPostLevelManage", method = RequestMethod.GET)
    public ModelAndView viewPostLevelManage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/viewPostLevelManage", modelMap);
    }

    /**
     * 获取职群信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getPostGroupInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getPostGroupInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List pgList = this.positionMgtSer.getPostGroupInfo(request);
        int pgListCnt = this.positionMgtSer.getPostGroupInfoCnt(request);
        model.put("Rows", pgList);
        model.put("Total", pgListCnt);
        return model;
    }

    /**
     * 添加职群信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPostGroupInfo", method = RequestMethod.GET)
    public ModelAndView addPostGroupInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/addPostGroupInfo", modelMap);
    }

    /**
     * 更新职群信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updatePostGroupInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updatePostGroupInfo(HttpServletRequest request){
        String returnString = "Y";
        try {
            this.positionMgtSer.updatePostGroupInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = ERROR_OCCURRED;
        }
        return returnString;
    }

    /**
     * 删除职群信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deletePostGroupInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePostGroupInfo(HttpServletRequest request) throws Exception {
        this.positionMgtSer.deletePostGroupInfo(request);
        return "Y";
    }

    /**
     * 添加职群信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPostGroupInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addPostGroupInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        int errorInt = this.positionMgtSer.checkPostGroupInfo(request);
        if (errorInt == 0) {
            this.positionMgtSer.addPostGroupInfo(request);
        } else {
            returnString = "N";
        }
        return returnString;
    }

    /**
     * 获取职级信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPostGradeManage", method = RequestMethod.GET)
    public ModelAndView viewPostGradeManage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/viewPostGradeManage", modelMap);
    }

    /**
     * 获取职级信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getPostGradeInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getPostGradeInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List pcList = this.positionMgtSer.getPostGradeInfo(request);
        int pcListCnt = this.positionMgtSer.getPostGradeInfoCnt(request);
        model.put("Rows", pcList);
        model.put("Total", pcListCnt);
        return model;
    }

    /**
     * 添加职级信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPostGradeInfo", method = RequestMethod.GET)
    public ModelAndView addPostGradeInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/addPostGradeInfo", modelMap);
    }

    /**
     * 更新职级信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updatePostGradeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updatePostGradeInfo(HttpServletRequest request){
        String returnString  = "Y";
        try {
            this.positionMgtSer.updatePostGradeInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = ERROR_OCCURRED;
        }
        return returnString;
    }

    /**
     * 删除职级信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deletePostGradeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePostGradeInfo(HttpServletRequest request) throws Exception {
        this.positionMgtSer.deletePostGradeInfo(request);
        return "Y";
    }

    /**
     * 添加职级信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPostGradeInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addPostGradeInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        int errorInt = this.positionMgtSer.checkPostGradeInfo(request);
        if (errorInt == 0) {
            this.positionMgtSer.addPostGradeInfo(request);
        } else {
            returnString = "N";
        }
        return returnString;
    }

    /**
     * 获取职位岗位信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPostManage", method = RequestMethod.GET)
    public ModelAndView viewPostManage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/viewPostManage", modelMap);
    }

    /**
     * 获取职位岗位信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getPostInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getPostInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List pcList = this.positionMgtSer.getPostInfo(request);
        int pcListCnt = this.positionMgtSer.getPostInfoCnt(request);
        model.put("Rows", pcList);
        model.put("Total", pcListCnt);
        return model;
    }

    /**
     * 添加职位岗位信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPostInfo", method = RequestMethod.GET)
    public ModelAndView addPostInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/addPostInfo", modelMap);
    }

    /**
     * 更新职位岗位信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updatePostInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updatePostInfo(HttpServletRequest request){
        String returnString = "Y";
        try {
            this.positionMgtSer.updatePostInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = ERROR_OCCURRED;
        }
        return returnString;
    }

    /**
     * 删除职位岗位信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deletePostInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePostInfo(HttpServletRequest request) throws Exception {
        this.positionMgtSer.deletePostInfo(request);
        return "Y";
    }

    /**
     * 添加职位岗位信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPostInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addPostInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        int errorInt = this.positionMgtSer.checkPostInfo(request);
        if (errorInt == 0) {
            this.positionMgtSer.addPostInfo(request);
        } else {
            returnString = "N";
        }
        return returnString;
    }

    /**
     * 获取职务信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPositionManage", method = RequestMethod.GET)
    public ModelAndView viewPositionManage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/viewPositionManage", modelMap);
    }

    /**
     * 获取职务信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getPositionInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getPositionInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List pcList = this.positionMgtSer.getPositionInfo(request);
        int pcListCnt = this.positionMgtSer.getPositionInfoCnt(request);
        model.put("Rows", pcList);
        model.put("Total", pcListCnt);
        return model;
    }

    /**
     * 添加职务信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPositionInfo", method = RequestMethod.GET)
    public ModelAndView addPositionInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/addPositionInfo", modelMap);
    }

    /**
     * 更新职务信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updatePositionInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updatePositionInfo(HttpServletRequest request){
        String returnString = "Y";
        try {
            this.positionMgtSer.updatePositionInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = ERROR_OCCURRED;
        }
        return returnString;
    }

    /**
     * 删除职务信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deletePositionInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePositionInfo(HttpServletRequest request) throws Exception {
        this.positionMgtSer.deletePositionInfo(request);
        return "Y";
    }

    /**
     * 添加职务信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPositionInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addPositionInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        int errorInt = this.positionMgtSer.checkPositionInfo(request);
        if (errorInt == 0) {
            this.positionMgtSer.addPositionInfo(request);
        } else {
            returnString = "N";
        }
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getPostLevelInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getPostLevelInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List pcList = this.positionMgtSer.getPostLevelInfo(request);
        int pcListCnt = this.positionMgtSer.getPostLevelInfoCnt(request);
        model.put("Rows", pcList);
        model.put("Total", pcListCnt);
        return model;
    }

    @RequestMapping(value = "/addPostLevelInfo", method = RequestMethod.GET)
    public ModelAndView addPostLevelInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/position/addPostLevelInfo", modelMap);
    }

    @RequestMapping(value = "/addPostLevelInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addPostLevelInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        int errorInt = this.positionMgtSer.checkPostLevelInfo(request);
        if (errorInt == 0) {
            this.positionMgtSer.addPostLevelInfo(request);
        } else {
            returnString = "N";
        }
        return returnString;
    }

    @RequestMapping(value = "/deletePostLevelInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePostLevelInfo(HttpServletRequest request) throws Exception {
        this.positionMgtSer.deletePostLevelInfo(request);
        return "Y";
    }

    @RequestMapping(value = "/updatePostLevelInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updatePostLevelInfo(HttpServletRequest request){
        String returnString = "Y";
        try {
            this.positionMgtSer.updatePostLevelInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = ERROR_OCCURRED;
        }
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getPostLevelDataInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getPostLevelDataInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List pcList = this.positionMgtSer.getPostLevelDataInfo(request);
        int pcListCnt = this.positionMgtSer.getPostLevelDataInfoCnt(request);
        model.put("Rows", pcList);
        model.put("Total", pcListCnt);
        return model;
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/updatePostLevelDataInfo", method = RequestMethod.GET)
    public ModelAndView updatePostLevelDataInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        modelMap.put("POST_ID", paramMap);
        return new ModelAndView("/hrm/position/updatePostLevelDataInfo", modelMap);
    }

    @RequestMapping(value = "/addOrUpdatePostLevelDataInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addOrUpdatePostLevelDataInfo(HttpServletRequest request) {
        String returnString = "Y";
        try {
            this.positionMgtSer.addOrUpdatePostLevelDataInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = ERROR_OCCURRED;
        }
        return returnString;
    }

    @RequestMapping(value = "/deletePostLevelDataInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deletePostLevelDataInfo(HttpServletRequest request) throws Exception {
        positionMgtSer.deletePostLevelDataInfo(request);
        return "Y";
    }
}
