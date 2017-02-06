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

import com.siping.hrm.service.EmpInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.system.service.BasicMaintenanceSer;
import com.siping.system.service.MyHomeSer;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/hrm/empinfo")
public class EmpInfoCtroller {
    Logger logger = Logger.getLogger(EmpInfoCtroller.class);
    @Autowired
    private EmpInfoSer empInfoSer;
    @RequestMapping(value = "/searchEmp", method = RequestMethod.GET)
    public ModelAndView getSearchEmp(HttpServletRequest request) throws Exception {
        return new ModelAndView("/hrm/empinfo/searchEmp");
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEmpList")
    @ResponseBody
    public Map getEmpList(HttpServletRequest request) throws Exception {
        Map info = empInfoSer.getEmpList(request);
        return info;
    }

    /**
     * 基础信息和个人信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPersonalInfo", method = RequestMethod.GET)
    public ModelAndView getPersonalInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        modelMap.put("personalInfo", this.empInfoSer.getPersonalInfo(request));

        return new ModelAndView("/hrm/empinfo/viewPersonalInfo", modelMap);
    }

    /**
     * 员工信息查询
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPersonalIndex", method = RequestMethod.GET)
    public ModelAndView getPersonalIndex(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/empinfo/viewPersonalIndex", null);
    }

    /**
     * 修改信息和个人信息
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateEmpInfo", method = RequestMethod.GET)
    public ModelAndView updateEmpInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        modelMap.put("personalInfo", this.empInfoSer.getPersonalInfo(request));

        return new ModelAndView("/hrm/empinfo/updateEmpInfo", modelMap);
    }

    /**
     * 发令信息
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewExpInside", method = RequestMethod.GET)
    public ModelAndView getExpInside(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewExpInside", modelMap);
    }

    /**
     * 发令信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getExpInsideInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getExpInsideInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.empInfoSer.getExpInsideInfoList(request);
        int empInfoCnt = this.empInfoSer.getExpInsideInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 离职信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getResignInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getResignInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.empInfoSer.getResignInfoList(request);
        int empInfoCnt = this.empInfoSer.getResignInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 评价信息
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewEvaluate", method = RequestMethod.GET)
    public ModelAndView getEvaluate(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewEvaluate", modelMap);
    }

    /**
     * 评价信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEvalList", method = RequestMethod.POST)
    @ResponseBody
    public Map getEvalList(HttpServletRequest request) throws Exception {
        Map temp = this.empInfoSer.getEvalForGrid(request);
        return temp;
    }

    /**
     * 评价信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEvaluateList", method = RequestMethod.POST)
    @ResponseBody
    public Map getEvaluateList(HttpServletRequest request) throws Exception {
        Map temp = this.empInfoSer.getEvaluateForGrid(request);
        return temp;
    }

    /**
     * 奖励/惩戒
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewReward", method = RequestMethod.GET)
    public ModelAndView getReward(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewReward", modelMap);
    }

    /**
     * 奖励/惩戒
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPunishmentInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPunishmentInfoList(HttpServletRequest request) throws Exception {
        List rewardInfoList = this.empInfoSer.getPunishMentInfoList(request);
        int rewardInfoCnt = this.empInfoSer.getPunishMentInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", rewardInfoList);
        model.put("Total", rewardInfoCnt);
        return model;
    }

    /**
     * 奖励/惩戒
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getRewardInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getRewardInfoList(HttpServletRequest request) throws Exception {
        List rewardInfoList = this.empInfoSer.getRewardInfoList(request);
        int rewardInfoCnt = this.empInfoSer.getRewardInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", rewardInfoList);
        model.put("Total", rewardInfoCnt);
        return model;
    }

    /**
     * 兼职/派遣
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewTranslate", method = RequestMethod.GET)
    public ModelAndView getTranslate(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewTranslate", modelMap);
    }

    /**
     * 派遣
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDispatchInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDispatchInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.empInfoSer.getDispatchInfoList(request);
        int empInfoCnt = this.empInfoSer.getDispatchInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 兼职
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPluralityInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPluralityInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.empInfoSer.getPluralityInfoList(request);
        int empInfoCnt = this.empInfoSer.getPluralityInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getSuspendList", method = RequestMethod.POST)
    @ResponseBody
    public Map getSuspendList(HttpServletRequest request) throws Exception {
        return this.empInfoSer.getSuspendForGrid(request);
    }

    /**
     * 培训
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewTraining", method = RequestMethod.GET)
    public ModelAndView getTraining(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewTraining", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getTrainingInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getTrainingInfoList(HttpServletRequest request) throws Exception {
        List trainingInfoList = this.empInfoSer.getTrainingInfoList(request);
        int trainingInfoCnt = this.empInfoSer.getTrainingInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", trainingInfoList);
        model.put("Total", trainingInfoCnt);
        return model;
    }

    @RequestMapping(value = "/addTrainingInfo", method = RequestMethod.GET)
    public ModelAndView addTrainingInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/hrm/empinfo/addTrainingInfo", modelMap);
    }

    @RequestMapping(value = "/updateTrainingInfo", method = RequestMethod.GET)
    public ModelAndView updateTrainingInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("trainingInfo", this.empInfoSer.getTrainingInfo(request));
        return new ModelAndView("/hrm/empinfo/updateTrainingInfo", modelMap);
    }

    @RequestMapping(value = "/addTrainingInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addTrainingInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addTrainingInfo(request);
    }

    @RequestMapping(value = "/updateTrainingInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateTrainingInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateTrainingInfo(request);
    }

    @RequestMapping(value = "/deleteTrainingInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteTrainingInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteTrainingInfo(request);
    }

    /**
     * 社会关系
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewRelation")
    public ModelAndView getRelation(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewRelation", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getFamilyInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getFamilyInfoList(HttpServletRequest request) throws Exception {
        List familyInfoList = this.empInfoSer.getFamilyInfoList(request);
        int familyInfoCnt = this.empInfoSer.getFamilyInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", familyInfoList);
        model.put("Total", familyInfoCnt);
        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getEmergencyContactInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getEmergencyContactInfoList(HttpServletRequest request) throws Exception {
        List ecInfoList = this.empInfoSer.getEmergencyContactInfoList(request);
        int ecInfoCnt = this.empInfoSer.getEmergencyContactInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", ecInfoList);
        model.put("Total", ecInfoCnt);
        return model;
    }

    /**
     * 账户信息维护
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveAndUpdateEmpPaInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveAndUpdateEmpPaInfo(HttpServletRequest request) throws Exception {
        this.empInfoSer.updateEmpPaInfo(request);
        return this.empInfoSer.addEmpPaInfo(request);
    }

    /**
     * 家庭成员维护
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveAndUpdateFamilyInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveAndUpdateFamilyInfo(HttpServletRequest request) throws Exception {
        this.empInfoSer.updateFamilyInfo(request);
        return this.empInfoSer.addFamilyInfo(request);
    }

    /**
     * 紧急联系人维护
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveAndUpdateEmergencyContactInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveAndUpdateEmergencyContactInfo(HttpServletRequest request) throws Exception {

        this.empInfoSer.updateEmergencyContactInfo(request);
        return this.empInfoSer.addEmergencyContactInfo(request);
    }

    @RequestMapping(value = "/deleteFamilyInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteFamilyInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteFamilyInfo(request);
    }

    @RequestMapping(value = "/deleteEmpPaInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteEmpPaInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteEmpPaInfo(request);
    }

    /**
     * 健康信息
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewHealthInfo", method = RequestMethod.GET)
    public ModelAndView viewHealthInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewHealthInfo", modelMap);
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/viewHealthDetailInfo", method = RequestMethod.GET)
    public ModelAndView viewHealthDetailInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        Map healthInfo = (Map) this.empInfoSer.getHealthInfo(request);
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        modelMap.put("healthInfo", healthInfo);
        return new ModelAndView("/hrm/empinfo/viewHealthDetailInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getHealthInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getHealthInfoList(HttpServletRequest request) throws Exception {
        List healthInfoList = this.empInfoSer.getHealthInfoList(request);
        int healthInfoCnt = this.empInfoSer.getHealthInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", healthInfoList);
        model.put("Total", healthInfoCnt);
        return model;
    }

    /*********************************************************************************************/
    /**
     * 健康信息
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addHealthInfo", method = RequestMethod.GET)
    public ModelAndView addHealthInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd"));

        return new ModelAndView("/hrm/empinfo/addHealthInfo", modelMap);
    }

    @RequestMapping(value = "/addHealthInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addHealthInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addHealthInfo(request);
    }

    @RequestMapping(value = "/updateHealthInfo", method = RequestMethod.GET)
    public ModelAndView updateHealthInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        modelMap.put("healthInfo", this.empInfoSer.getHealthInfo(request));
        return new ModelAndView("/hrm/empinfo/updateHealthInfo", modelMap);
    }

    @RequestMapping(value = "/updateHealthInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateHealthInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateHealthInfo(request);
    }

    @RequestMapping(value = "/deleteHealthInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteHealthInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteHealthInfo(request);
    }

    /*********************************************************************************************/
    /**
     * 工作经验
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewWorkExperienceInfo", method = RequestMethod.GET)
    public ModelAndView viewWorkExperienceInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewWorkExperienceInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getWorkExperienceInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getWorkExperienceInfoList(HttpServletRequest request) throws Exception {
        List workExperienceInfoList = this.empInfoSer.getWorkExperienceInfoList(request);
        int workExperienceInfoCnt = this.empInfoSer.getWorkExperienceInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", workExperienceInfoList);
        model.put("Total", workExperienceInfoCnt);
        return model;
    }

    @RequestMapping(value = "/deleteWorkExperienceInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteWorkExperienceInfo(HttpServletRequest request) throws Exception {
        return this.empInfoSer.deleteWorkExperienceInfo(request);
    }

    @RequestMapping(value = "/addWorkExperienceInfo", method = RequestMethod.GET)
    public ModelAndView addWorkExperienceInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/hrm/empinfo/addWorkExperienceInfo", modelMap);
    }

    @RequestMapping(value = "/updateWorkExperienceInfo", method = RequestMethod.GET)
    public ModelAndView updateWorkExperienceInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("workExperienceInfo", this.empInfoSer.getWorkExperienceInfo(request));
        return new ModelAndView("/hrm/empinfo/updateWorkExperienceInfo", modelMap);
    }

    @RequestMapping(value = "/addWorkExperienceInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addWorkExperienceInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addWorkExperienceInfo(request);
    }

    @RequestMapping(value = "/updateWorkExperienceInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateWorkExperienceInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateWorkExperienceInfo(request);
    }

    /*********************************************************************************************/
    /**
     * 教育信息
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewEduInfo", method = RequestMethod.GET)
    public ModelAndView viewEduInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewEduInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getEduInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getEduInfoList(HttpServletRequest request) throws Exception {
        List EduInfoList = this.empInfoSer.getEduInfoList(request);
        int EduInfoCnt = this.empInfoSer.getEduInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", EduInfoList);
        model.put("Total", EduInfoCnt);
        return model;
    }

    @RequestMapping(value = "/deleteEduInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteEduInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteEduInfo(request);
    }

    @RequestMapping(value = "/addEduInfo", method = RequestMethod.GET)
    public ModelAndView addEduInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/hrm/empinfo/addEduInfo", modelMap);
    }
    
    @RequestMapping(value = "/updateEduInfo", method = RequestMethod.GET)
    public ModelAndView updateEduInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("EduInfo", this.empInfoSer.getEduInfo(request));
        return new ModelAndView("/hrm/empinfo/updateEduInfo", modelMap);
    }

    @RequestMapping(value = "/addEduInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addEduInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addEduInfo(request);
    }

    @RequestMapping(value = "/updateEduInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateEduInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateEduInfo(request);
    }

    /*********************************************************************************************/
    /**
     * 证件信息
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewDocInfo", method = RequestMethod.GET)
    public ModelAndView viewDocInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewDocInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDocInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDocInfoList(HttpServletRequest request) throws Exception {
        List DocInfoList = this.empInfoSer.getDocInfoList(request);
        int DocInfoCnt = this.empInfoSer.getDocInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", DocInfoList);
        model.put("Total", DocInfoCnt);
        return model;
    }

    @RequestMapping(value = "/deleteDocInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteDocInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteDocInfo(request);
    }

    @RequestMapping(value = "/addDocInfo", method = RequestMethod.GET)
    public ModelAndView addDocInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/hrm/empinfo/addDocInfo", modelMap);
    }

    @RequestMapping(value = "/updateDocInfo", method = RequestMethod.GET)
    public ModelAndView updateDocInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("DocInfo", this.empInfoSer.getDocInfo(request));
        return new ModelAndView("/hrm/empinfo/updateDocInfo", modelMap);
    }

    @RequestMapping(value = "/addDocInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addDocInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addDocInfo(request);
    }

    @RequestMapping(value = "/updateDocInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateDocInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateDocInfo(request);
    }

    /**
     * 特殊事项
     * @param ac
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewAppendInfo", method = RequestMethod.GET)
    public ModelAndView getAppendInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewAppendInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getAppendInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAppendInfoList(HttpServletRequest request) throws Exception {
        Map temp = this.empInfoSer.getAppendInfoForGrid(request);
        return temp;
    }

    @RequestMapping(value = "/updateFappendInfoGrid", method = RequestMethod.POST)
    public ModelAndView updateFappendInfoGrid(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        logger.info("updateHealthInfoGrid.start......");
        request.setAttribute("basicInfo", this.empInfoSer.getBasicInfo(request));
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        admin.getAdminID();
        String fappendInfoGridJson = request.getParameter("#fappendInfoGrid");
        @SuppressWarnings("unused")
        String famBackInfo = this.empInfoSer.updateFappendInfoGrid(JsonUtil.getUpdateList(fappendInfoGridJson), request);
        request.getRequestDispatcher("/WEB-INF/view/hrm/empinfo/viewAppendInfo.jsp").forward(request, response);
        return null;
    }

    /**
     * 资格证书信息
     * @param ac
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewCompetence", method = RequestMethod.GET)
    public ModelAndView getCompetence(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewCompetence", modelMap);
    }
    /*
    @RequestMapping(value = "/viewEmpPostRecords", method = RequestMethod.GET)
    public ModelAndView getEmpPostRecords(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewEmpPostRecords", modelMap);
    }*/

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getQualificationInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getQualificationInfoList(HttpServletRequest request) throws Exception {
        List qualificationInfoList = this.empInfoSer.getQualificationInfoList(request);
        int qualificationInfoCnt = this.empInfoSer.getQualificationInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", qualificationInfoList);
        model.put("Total", qualificationInfoCnt);
        return model;
    }

    @RequestMapping(value = "/addQualificationInfo", method = RequestMethod.GET)
    public ModelAndView addQualificationInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/hrm/empinfo/addQualificationInfo", modelMap);
    }

    @RequestMapping(value = "/updateQualificationInfo", method = RequestMethod.GET)
    public ModelAndView updateQualificationInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("qualificationInfo", this.empInfoSer.getQualificationInfo(request));
        return new ModelAndView("/hrm/empinfo/updateQualificationInfo", modelMap);
    }

    @RequestMapping(value = "/addQualificationInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addQualificationInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addQualificationInfo(request);
    }

    @RequestMapping(value = "/updateQualificationInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateQualificationInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateQualificationInfo(request);
    }

    @RequestMapping(value = "/deleteQualificationInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteQualificationInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteQualificationInfo(request);
    }

    @RequestMapping(value = "/updateEmpInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateEmpInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateEmpInfo(request);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getLanuageInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getLanuageInfoList(HttpServletRequest request) throws Exception {
        List lanuageInfoList = this.empInfoSer.getLanuageInfoList(request);
        int lanuageInfoCnt = this.empInfoSer.getLanuageInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", lanuageInfoList);
        model.put("Total", lanuageInfoCnt);
        return model;
    }

    @RequestMapping(value = "/addLanuageInfo", method = RequestMethod.GET)
    public ModelAndView addLanuageInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/hrm/empinfo/addLanuageInfo", modelMap);
    }

    @RequestMapping(value = "/updateLanuageInfo", method = RequestMethod.GET)
    public ModelAndView updateLanuageInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("lanuageInfo", this.empInfoSer.getLanuageInfo(request));
        return new ModelAndView("/hrm/empinfo/updateLanuageInfo", modelMap);
    }

    @RequestMapping(value = "/addLanuageInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addLanuageInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addLanuageInfo(request);
    }

    @RequestMapping(value = "/updateLanuageInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateLanuageInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateLanuageInfo(request);
    }

    @RequestMapping(value = "/deleteLanuageInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteLanuageInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteLanuageInfo(request);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getITLevelInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getITLevelInfoList(HttpServletRequest request) throws Exception {
        List itInfoList = this.empInfoSer.getITLevelInfoList(request);
        int itInfoCnt = this.empInfoSer.getITLevelInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", itInfoList);
        model.put("Total", itInfoCnt);
        return model;
    }

    @RequestMapping(value = "/addITLevelInfo", method = RequestMethod.GET)
    public ModelAndView addITLevelInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/hrm/empinfo/addITLevelInfo", modelMap);
    }

    @RequestMapping(value = "/updateITLevelInfo", method = RequestMethod.GET)
    public ModelAndView updateITLevelInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("itInfo", this.empInfoSer.getITLevelInfo(request));
        return new ModelAndView("/hrm/empinfo/updateITLevelInfo", modelMap);
    }

    @RequestMapping(value = "/addITLevelInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addITLevelInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.addITLevelInfo(request);
    }

    @RequestMapping(value = "/updateITLevelInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateITLevelInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.updateITLevelInfo(request);
    }

    @RequestMapping(value = "/deleteITLevelInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteITLevelInfo(HttpServletRequest request) throws Exception {

        return this.empInfoSer.deleteITLevelInfo(request);
    }

    /**
     * 工资信息
     * @param ac
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewAccountsInfo", method = RequestMethod.GET)
    public ModelAndView getAccountsInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewAccountsInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getSinfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getSinfoList(HttpServletRequest request) throws Exception {
        Map temp = empInfoSer.getSinfoForGrid(request);
        return temp;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPaEmpInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPaEmpInfoList(HttpServletRequest request) throws Exception {
        List itInfoList = this.empInfoSer.getPaEmpInfoList(request);
        int itInfoCnt = this.empInfoSer.getPaEmpInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", itInfoList);
        model.put("Total", itInfoCnt);
        return model;
    }

    /**
     * 担当业务
     * @param ac
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewActBusiness", method = RequestMethod.GET)
    public ModelAndView getActBusiness(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/hrm/empinfo/viewActBusiness", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getBizInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getBizInfoList(HttpServletRequest request) throws Exception {
        List bizInfoList = this.empInfoSer.getBizInfoList(request);
        int bizInfoCnt = this.empInfoSer.getBizInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", bizInfoList);
        model.put("Total", bizInfoCnt);

        return model;
    }

    @RequestMapping(value = "/viewContractInfo", method = RequestMethod.GET)
    public ModelAndView viewContractInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", empInfoSer.getBasicInfo(request));

        return new ModelAndView("/hrm/empinfo/viewContractInfo", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getHrSearchEmployeeList", method = RequestMethod.POST)
    @ResponseBody
    public Map getHrSearchEmployeeList(HttpServletRequest request) throws Exception {

        List hrSearchEmployeeList = this.empInfoSer.getHrSearchEmployeeList(request);

        int hrSearchEmployeeCnt = this.empInfoSer.getHrSearchEmployeeCnt(request);

        Map model = new HashMap();
        model.put("Rows", hrSearchEmployeeList);
        model.put("Total", hrSearchEmployeeCnt);

        return model;
    }

    @RequestMapping(value = "/deleteEmpInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteEmpInfo(HttpServletRequest request) throws Exception {
        return this.empInfoSer.deleteEmpInfo(request);
    }
}
