package com.siping.cust.action;

import java.sql.SQLException;
import java.text.ParseException;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.cust.bean.Action;
import com.siping.cust.service.CustActionSer;
import com.siping.cust.service.SalesSettingSer;
import com.siping.ess.service.InfoAppSer;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/cust/custAction")
public class CustActionCtroller {
    Logger logger = Logger.getLogger(CustActionCtroller.class);
    
    @Autowired
    private CustActionSer custActionSer;
    @Autowired
    private InfoAppSer infoAppSer; 
    @Autowired
    private EmpInfoSer empInfoSer;
   
    @Autowired
    private SalesSettingSer salesSettingSer;
    
    @SuppressWarnings("rawtypes")
    @RequestMapping(value="/viewCustomerAction", method=RequestMethod.GET)
    public ModelAndView viewCustomerActionList(HttpServletRequest request, ModelMap modelMap){
        modelMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        List calendarList = this.infoAppSer.getCompanyCalendarInfo(request) ;
        Map paraMap = this.empInfoSer.getRequestParamData(request);
        LinkedHashMap list = (LinkedHashMap)calendarList.get(0);
        int head = Integer.parseInt(list.get("IWEEK").toString());
        modelMap.put("head", head) ;
        list = (LinkedHashMap)calendarList.get(calendarList.size()-1);
        int end = Integer.parseInt(list.get("IWEEK").toString());
        modelMap.put("end", end) ;
        modelMap.put("calendarList", calendarList) ;
        modelMap.put("paraMap", paraMap) ;
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/cust/custAction/viewCustomerAction",modelMap);
    }
    
    
    @SuppressWarnings("rawtypes")
    @RequestMapping(value="/addCustomerAction", method=RequestMethod.GET)
    public ModelAndView addCustomerAction(HttpServletRequest request, ModelMap modelMap){
        modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        String DDATE=(String) paramMap.get("DDATE");
        String empId=(String) paramMap.get("empId");
        String[] DDATES=DDATE.split(" ");
        DDATE=DDATES[0];
        modelMap.put("DDATE", DDATE);
        modelMap.put("empId", empId);
        return new ModelAndView("/cust/custAction/addCustomerAction",modelMap);
    }
    
    @SuppressWarnings("rawtypes")
    @RequestMapping(value="/updateCustomerAction", method=RequestMethod.GET)
    public ModelAndView updateCustomerAction(HttpServletRequest request, ModelMap modelMap) throws SQLException{
        modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        String custActionNo=(String) paramMap.get("custActionNo");
        modelMap.put("custActionNo", custActionNo);
        return new ModelAndView("/cust/custAction/updateCustomerAction",modelMap);
    }

    
    @RequestMapping("/getActionByCustActionNo")
    @ResponseBody
    public Action getActionByCustActionNo(HttpServletRequest request) throws SQLException
    {
        Action action=this.custActionSer.getActionById(request);
        return action;
    }
    @RequestMapping(value="/viewCustomerReturnVisit", method=RequestMethod.GET)
    public ModelAndView viewCustomerReturnVisit(HttpServletRequest request, ModelMap modelMap){
        modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        modelMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        return new ModelAndView("/cust/custAction/viewCustomerReturnVisit",modelMap);
    }
    
    @RequestMapping(value="/viewCustomerTrace", method=RequestMethod.GET)
    public ModelAndView viewCustomerTrace(HttpServletRequest request, ModelMap modelMap){
        modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        modelMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        return new ModelAndView("/cust/custAction/viewCustomerTrace",modelMap);
    }
    
    /* The following functions return the data(stored in Map) */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value="/getCustomerActionList", method=RequestMethod.POST)
    @ResponseBody
    public Map getCustomerActionList(HttpServletRequest request,ModelMap modelMap){
        modelMap.put("Rows",this.custActionSer.getCustomerActionList(request));
        modelMap.put("Total", this.custActionSer.getCustomerActionListCnt(request));
        return modelMap;            
    }
    
    @RequestMapping(value="/transferCustomerAction",method=RequestMethod.POST)
    @ResponseBody
    public String transferCustomerAction(HttpServletRequest request, ModelMap modelMap){
        String resultString = "Y";
        try {
            this.custActionSer.transferCustomerAction(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }
    
    @RequestMapping(value="/addCustomerAction",method=RequestMethod.POST)
    @ResponseBody
    public String addCustomerAction(HttpServletRequest request, HttpServletResponse response){
        String resultString = "Y";
        try {
            this.custActionSer.addCustomerAction(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }
    
    @RequestMapping(value="/removeCustomerAction")
    @ResponseBody
    public String removeCustomerAction(HttpServletRequest request, HttpServletResponse response){
        String resultString = "Y";
        try {
            resultString = this.custActionSer.removeCustomerAction(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @RequestMapping("/addOrUpdateCustAction")
    @ResponseBody
    public String addOrUpdateCustContact(HttpServletRequest request, @RequestBody Action action) {
        String returnString="N";
        //注入是谁添加的用户
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String empId=admin.getAdminID();
        action.setEmpId(empId);
        if (action.getCustActionNo() == null || action.getCustActionNo() == ""){
            try {
                    this.custActionSer.saveAction(action);
                    returnString="Y";
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else {
            try {
                this.custActionSer.updateActon(action);
                returnString="Y";
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("/getActionByCustId")
    @ResponseBody
    public Map getActionByCustId(HttpServletRequest request) throws SQLException{
        List<Action> actionList=this.custActionSer.getActionByCustId(request);
        int total=this.custActionSer.getCountByCustId(request);
        Map map=new HashMap();
        map.put("Rows", actionList);
        map.put("Total", total);
        return map;
    }

    @RequestMapping("/deleteAction")
    @ResponseBody
    public String deleteAction(HttpServletRequest request,@RequestParam(value="custActionNo")String custActionNo) throws SQLException 
    {
        String returnString="N";
        try {
            this.custActionSer.deleteAction(custActionNo);
            returnString="Y";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnString;
    }

    @RequestMapping("/changeActionState")
    @ResponseBody
    public String changeActionState(HttpServletRequest request) throws SQLException{
        String returnString="N";
        try {
            this.custActionSer.changeActionState(request);
            returnString="Y";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings("deprecation")
    @RequestMapping(value="/getCustActionByCondition",method=RequestMethod.POST)
    @ResponseBody
    public List<Action> getCustActionByCondition(HttpServletRequest request) throws SQLException
    {
        List<Action> actionList=null;
        try {
            actionList = this.custActionSer.getCustActionByCondition(request);
        } catch (ParseException e) {
             
            e.printStackTrace();
        }
        return actionList;
    }
    

}
