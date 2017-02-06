package com.siping.ess.action;

import java.text.SimpleDateFormat;
import java.util.Date;

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

import com.siping.ess.service.InfoConfirmSer;

@Controller
@RequestMapping(value = "/ess/infoCon")
public class InfoConfirmCtroller {

    Logger logger = Logger.getLogger(InfoConfirmCtroller.class);

    @Autowired
    private InfoConfirmSer infoConfirmSer;

    /**
     * 页面跳转
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/{infoConfirmType}")
	public ModelAndView getPersonInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		modelMap.put("toDate",
				new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		return new ModelAndView("", modelMap);
	}

    /**
     * 信息确认
     * @param request
     * @return
     */
    @RequestMapping(value = "/confirmApp", method = RequestMethod.POST)
    @ResponseBody
    public String confirmApp(HttpServletRequest request) throws Exception {

        this.infoConfirmSer.confirmApp(request);

        return "Y";
    }

    /**
     * 信息删除
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/delApp", method = RequestMethod.POST)
    @ResponseBody
    public String delApp(HttpServletRequest request) throws Exception {

        this.infoConfirmSer.delApp(request);

        return "Y";
    }
}
