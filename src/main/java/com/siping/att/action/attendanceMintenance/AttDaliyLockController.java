package com.siping.att.action.attendanceMintenance;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.att.service.AttDaliyLockSer;

@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttDaliyLockController {

    @Autowired
    private AttDaliyLockSer attDaliyLockSer;

    @RequestMapping(value = "/viewAttDaliyLockInfo", method = RequestMethod.GET)
    public ModelAndView viewAttDaliyLockInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String calendarHtml = this.attDaliyLockSer.getAttDaliyLockInfoHtml(request);
        modelMap.put("calendarHtml", calendarHtml);
        return new ModelAndView("/att/attendanceMintenance/viewAttDaliyLockInfo", modelMap);
    }

    @RequestMapping(value = "/updateAttDaliyLockInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateAttDaliyLockInfo(HttpServletRequest request) throws Exception {
        int returnInt = 0;
        returnInt = this.attDaliyLockSer.updateAttDaliyLockInfo(request);
        if (returnInt == 1) {
            return "Y";
        } else {
            return "N";
        }

    }
}
