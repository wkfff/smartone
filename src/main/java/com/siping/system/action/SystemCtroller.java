package com.siping.system.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siping.system.service.SystemSer;

@Controller
@RequestMapping(value = "/system")
public class SystemCtroller {
	Logger logger = Logger.getLogger(SystemCtroller.class);
	@Autowired
	private SystemSer systemSer;
	
	@RequestMapping(value = "/updateModel",method = RequestMethod.POST)
	@ResponseBody
	public void updateModel(HttpServletRequest request)throws Exception{
		logger.info("start......");
		systemSer.updateModel(request);		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getModel",method = RequestMethod.GET)
	@ResponseBody
	public Map getModel(HttpServletRequest request)throws Exception{
		List list = systemSer.getModel(request);
		Map model=new HashMap();
		model.put("modelList", list);
		return model;		
	}
}
