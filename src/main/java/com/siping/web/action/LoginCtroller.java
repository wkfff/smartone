package com.siping.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.hrm.service.EmpInfoSer;
import com.siping.mobile.service.MobileManageSer;
import com.siping.productStorage.service.ProductSer;
import com.siping.system.bean.AdminBean;
import com.siping.system.service.BasicMaintenanceSer;
import com.siping.system.service.LogOutSer;
import com.siping.system.service.LoginSer;
import com.siping.system.service.MyHomeSer;
import com.siping.web.utility.HttpRequestDeviceUtils;
import com.siping.web.utility.SessionUtil;

@Controller
public class LoginCtroller {

    Logger logger = Logger.getLogger(LoginCtroller.class);

    @Autowired
    @Qualifier("loginSerImpl")
    private LoginSer loginStr;
    @Autowired
    @Qualifier("logOutSerImpl")
    private LogOutSer logOutStr;
    @Autowired
    private MyHomeSer myHomeSer;
    @Autowired
    private EmpInfoSer empInfoSer;
    @Autowired
    private BasicMaintenanceSer basicMaintenanceSer;
    @Autowired
    private MobileManageSer mobileManageSer;
    @Autowired
    private ProductSer productSer;

    /*
     * 用户访问量记录参数
     */
    private static long visitTimes = 0;

    public static long getVisitTimes() {
        return visitTimes;
    }

    public static void setVisitTimes(long visitTimes) {
        LoginCtroller.visitTimes = visitTimes;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView logIndex(HttpServletRequest request, ModelMap modelMap) {
        if(HttpRequestDeviceUtils.isMobileDevice(request)){
            List advList = this.mobileManageSer.getMobileAdv(request);
            List<HashMap> areaList = this.mobileManageSer.getMobileAreaList(request);
            for(int i=0;i<areaList.size();i++){
                HashMap map = areaList.get(i);
                request.setAttribute("M_AREA_NO", map.get("M_AREA_NO"));
                List proList = this.productSer.getProductList(request);
                areaList.get(i).put("proList", proList);
            }
            modelMap.put("advList", advList);
            modelMap.put("areaList", areaList);
            visitTimes++;
            return new ModelAndView("/mobile/home", modelMap);
        }else{
            visitTimes++;
            return new ModelAndView("/web/login/index");
        }
    }

    @RequestMapping(value = "/login/in", method = RequestMethod.POST)
    @ResponseBody
    public String loginIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("login waiting......");
        String returnString = this.loginStr.findUser(request, response);
        request.getSession().setAttribute("targetUrl", null);
        return returnString;
    }

    @RequestMapping(value = "/login/out", method = RequestMethod.GET)
    public void loginOut(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.logOutStr.updateUserInfo(request, response);
        request.getSession().removeAttribute("LoginUser");
        if(HttpRequestDeviceUtils.isMobileDevice(request)){
            request.getRequestDispatcher("/mobile/login/index").forward(request, response);
        }else{
            request.getRequestDispatcher("/").forward(request, response);
        }
    }

    @RequestMapping(value = "/login/supHome", method = RequestMethod.GET)
    public ModelAndView loginSupHome(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("mainMenuList", this.loginStr.getMainMenu(request, response));
        modelMap.put("announcementList", this.basicMaintenanceSer.getAnnouncementList(request));
        return new ModelAndView("/web/login/supHome", modelMap);
    }

    @RequestMapping(value = "/login/home", method = RequestMethod.GET)
    public ModelAndView loginHome(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelMap.put("mainMenuList", this.loginStr.getMainMenu(request, response));
        modelMap.put("announcementList", this.basicMaintenanceSer.getAnnouncementList(request));
        modelMap.put("userType", admin.getAccountType());
        return new ModelAndView("/web/login/home", modelMap);
    }

    @RequestMapping(value = "/login/addShortcutInfo", method = RequestMethod.GET)
    public ModelAndView addShortcutInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/web/login/addShortcutInfo", modelMap);
    }

    @RequestMapping(value = "/login/showWarningInfo", method = RequestMethod.GET)
    public ModelAndView showWarningInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.empInfoSer.getRequestParamData(request));
        return new ModelAndView("/web/login/showWarningInfo", modelMap);
    }

    @RequestMapping(value = "/login/saveShortcutInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveShortcutInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        this.myHomeSer.addShortcutInfo(request);
        return "Y";
    }

    @RequestMapping(value = "/login/deleteShortcutInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteShortcutInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        this.myHomeSer.deleteShortcutInfo(request);
        return "Y";
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/login/getMainMenu", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getMainMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {

        List list = this.loginStr.getMainMenu(request, response);
        logger.info("mainMenu:" + ((Map) list.get(0)).get("MENU_CODE"));

        Map<String, Object> modelMap = new HashMap<String, Object>();
        modelMap.put("mainMenuList", list);

        return modelMap;
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/login/getLeftMenu", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getLeftMenu(HttpServletRequest request, HttpServletResponse response) throws Exception {

        List list = this.loginStr.getLeftMenu(request, response);
        logger.info("leftMenu:" + ((Map) list.get(0)).get("MENU_CODE"));

        Map<String, Object> modelMap = new HashMap<String, Object>();
        modelMap.put("leftMenuList", list);

        return modelMap;
    }

    @RequestMapping(value = "/login/getMenuLoad", method = RequestMethod.POST)
    @ResponseBody
    public String getMenuLoad(HttpServletRequest request) throws Exception {
        return this.loginStr.getMenuLoad(request);
    }

    @RequestMapping(value = "/login/checkFirstLogin", method = RequestMethod.POST)
    @ResponseBody
    public String checkFirstLogin(HttpServletRequest request) throws Exception {
        return this.loginStr.checkFirstLogin(request);
    }

    @RequestMapping(value = "/login/getShortcutsInfo", method = RequestMethod.POST)
    @ResponseBody
    public String getShortcutsInfo(HttpServletRequest request) throws Exception {
        String shortcutsInfo = this.myHomeSer.getShortcutsInfo(request);
        return shortcutsInfo;
    }

    @RequestMapping(value = "/login/main", method = RequestMethod.GET)
    public ModelAndView loginMain(HttpServletRequest request, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        if (admin.getLoginType() == 1) {
            modelMap.put("admin", admin);
            return new ModelAndView("/web/login/mainForChannel", modelMap);
        }else if (admin.getLoginType() == 0) {
            modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
            // modelMap.put("mapAppInfo",
            // this.myHomeSer.getLoginUserAppInfo(request));

            // modelMap.put("appcnt", (String)
            // this.myHomeSer.getHomePage(request));
            modelMap.put("page", request.getParameter("page"));
            return new ModelAndView("/web/login/main", modelMap);
        }else{
            return null;
        }
    }

    @RequestMapping(value = "/login/mainSup", method = RequestMethod.GET)
    public ModelAndView loginMainSup(HttpServletRequest request, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        if (admin.getLoginType() == 0) {
            modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
            // modelMap.put("mapAppInfo",
            // this.myHomeSer.getLoginUserAppInfo(request));

            // modelMap.put("appcnt", (String)
            // this.myHomeSer.getHomePage(request));
            modelMap.put("page", request.getParameter("page"));
            return new ModelAndView("/web/login/mainSup", modelMap);
        } else
            return null;
    }

    @RequestMapping(value = "/login/mainSys", method = RequestMethod.GET)
    public ModelAndView loginMainSys() throws Exception {
        return new ModelAndView("/web/login/mainSys");
    }

    @RequestMapping(value = "/login/mainHr", method = RequestMethod.GET)
    public ModelAndView loginMainHr() throws Exception {
        return new ModelAndView("/web/login/mainHr");
    }
}
