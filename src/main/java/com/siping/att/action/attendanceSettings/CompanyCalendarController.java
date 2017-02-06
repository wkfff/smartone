package com.siping.att.action.attendanceSettings;

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

import com.siping.att.service.CompanyCalendarSer;
import com.siping.att.service.ShiftSer;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class CompanyCalendarController {
    Logger logger = Logger.getLogger(CompanyCalendarController.class);

    @Autowired
    private CompanyCalendarSer companyCalendarSer;

    @Autowired
    private ShiftSer shiftSer;

    @RequestMapping(value = "/viewCompanyCalendar", method = RequestMethod.GET)
    public ModelAndView viewCompanyCalendar(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String calendarHtml = this.companyCalendarSer.getCompanyCalendarInfoHtml(request);
        modelMap.put("calendarHtml", calendarHtml);
        return new ModelAndView("/att/attendanceSettings/viewCompanyCalendar", modelMap);
    }

    @RequestMapping(value = "/addCompanyCalendarInfo", method = RequestMethod.GET)
    public ModelAndView addCompanyCalendarInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("shiftInfo", shiftSer.getShiftSelectionList(request));
        return new ModelAndView("/att/attendanceSettings/addCompanyCalendarInfo", modelMap);
    }

    @RequestMapping(value = "/addCompanyCalendarInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addCompanyCalendarInfo(HttpServletRequest request) throws Exception {

        this.companyCalendarSer.addCompanyCalendarInfo(request);

        return "Y";
    }

    @RequestMapping(value = "/updateCompanyCalendarInfo", method = RequestMethod.GET)
    public ModelAndView updateCompanyCalendarInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        String calendarHtml = this.companyCalendarSer.getCompanyCalendarInfoHtml(request);

        modelMap.put("calendarHtml", calendarHtml);
        modelMap.put("shiftInfo", shiftSer.getShiftSelectionList(request));

        return new ModelAndView("/att/attendanceSettings/viewCompanyCalendar", modelMap);
    }

    @RequestMapping(value = "/updateCompanyCalendarInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateCompanyCalendarInfo(HttpServletRequest request) throws Exception {

        this.companyCalendarSer.updateCompanyCalendarInfo(request);

        return "Y";
    }
}
