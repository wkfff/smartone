package com.siping.ess.action;

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

import com.siping.ess.service.PersonInfoSer;
import com.siping.hrm.service.EmpInfoSer;

@Controller
@RequestMapping(value = "/ess/personinfo")
public class PersonInfoCtroller {

    Logger logger = Logger.getLogger(PersonInfoCtroller.class);

    @Autowired
    private EmpInfoSer empInfoSer;

    @Autowired
    private PersonInfoSer personInfoSer;

    /**
     * 页面跳转
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPersonInfo", method = RequestMethod.GET)
    public ModelAndView viewPersonInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        modelMap.put("personalInfo", this.empInfoSer.getPersonalInfo(request));

        return new ModelAndView("/ess/personinfo/viewPersonInfo", modelMap);
    }

    @RequestMapping(value = "/viewExpInside", method = RequestMethod.GET)
    public ModelAndView viewExpInside(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewExpInside", modelMap);
    }

    @RequestMapping(value = "/viewTranslate", method = RequestMethod.GET)
    public ModelAndView viewTranslate(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewTranslate", modelMap);
    }

    @RequestMapping(value = "/viewTraining", method = RequestMethod.GET)
    public ModelAndView viewTraining(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewTraining", modelMap);
    }

    @RequestMapping(value = "/viewRelation", method = RequestMethod.GET)
    public ModelAndView viewRelation(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewRelation", modelMap);
    }

    @RequestMapping(value = "/viewHealth", method = RequestMethod.GET)
    public ModelAndView viewHealth(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewHealth", modelMap);
    }

    @RequestMapping(value = "/viewWorkExperience", method = RequestMethod.GET)
    public ModelAndView viewWorkExperience(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewWorkExperience", modelMap);
    }

    @RequestMapping(value = "/viewCompetence", method = RequestMethod.GET)
    public ModelAndView viewCompetence(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewCompetence", modelMap);
    }

    @RequestMapping(value = "/viewAccount", method = RequestMethod.GET)
    public ModelAndView viewAccount(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewAccount", modelMap);
    }

    @RequestMapping(value = "/viewActbusiness", method = RequestMethod.GET)
    public ModelAndView viewActbusiness(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewActbusiness", modelMap);
    }

    @RequestMapping(value = "/viewDocInfo", method = RequestMethod.GET)
    public ModelAndView viewDocInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewDocInfo", modelMap);
    }

    @RequestMapping(value = "/viewEduInfo", method = RequestMethod.GET)
    public ModelAndView viewEduInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));

        return new ModelAndView("/ess/personinfo/viewEduInfo", modelMap);
    }

    /**
     * 页面跳转
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/{personInfoType}")
    public ModelAndView getPersonInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", empInfoSer.getBasicInfo(request));
        modelMap.put("personalInfo", empInfoSer.getPersonalInfo(request));
        return new ModelAndView("", modelMap);
    }

    /**
     * 获取列表
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getBasicList")
    @ResponseBody
    public Map getBasicList(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        logger.info("getBasicList.start......");
        // Map temp=transferOrderSer.getTransferOrderList(request);
        return null;
    }

    /**
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEducationInfoList")
    @ResponseBody
    public Map getEducationInfoList(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        logger.info("getBasicList.start......");
        Map temp = personInfoSer.getEducationInfoList(request);
        return temp;
    }

    /**
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getEvaluateforList")
    @ResponseBody
    public Map getEvaluateforList(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        logger.info("getBasicList.start......");
        Map temp = personInfoSer.getEvaluateforList(request);
        return temp;
    }

    @RequestMapping(value = "/viewWorkDocument", method = RequestMethod.GET)
    public ModelAndView viewWorkDocument(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/doc/docInfo/viewDocumentList", modelMap);
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
        return new ModelAndView("/ess/personinfo/updateEmpInfo", modelMap);
    }
}
