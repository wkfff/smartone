package com.siping.pa.action.salary;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.siping.pa.service.salary.PaResultSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/pa/salary")
public class PaResultCtroller {
	Logger logger = Logger.getLogger(PaResultCtroller.class);

	@Autowired
	private PaResultSer paResultSer;

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/viewPaResult", method = RequestMethod.GET)
	public ModelAndView viewPaCalculate(HttpServletRequest request, ModelMap modelMap) throws Exception {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("empID", admin.getAdminID());
		List  paColumnsList  =  this.paResultSer.getPaColumns(request);
		modelMap.put("paColumnsList", JsonUtil.writeInternal(paColumnsList));

		return new ModelAndView("/pa/salary/viewPaResult", modelMap);
	}
	
}
